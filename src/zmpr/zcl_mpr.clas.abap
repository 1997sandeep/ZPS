CLASS zcl_mpr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_MPR IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    "============================================================
    " DECLARATIONS
    "============================================================
    DATA:
      lt_output TYPE STANDARD TABLE OF zmpr_custom_cds
                 WITH EMPTY KEY
                 WITH NON-UNIQUE SORTED KEY k_wbse COMPONENTS wbse,
      lt_page   TYPE STANDARD TABLE OF zmpr_custom_cds WITH EMPTY KEY,
      ls_output TYPE zmpr_custom_cds.

    DATA:
      lv_page_size TYPE int8,
      lv_offset    TYPE int8,
      lv_index     TYPE int8.

    DATA:
      lv_project TYPE c LENGTH 24,
      lv_year    TYPE n LENGTH 4,
      lv_wbs     TYPE c LENGTH 25,
      lv_month   TYPE n LENGTH 2,
      p_month    TYPE n LENGTH 2.

    DATA:
      lv_month_num TYPE i,
      lv_year_num  TYPE i,
      lv_valid     TYPE abap_bool VALUE abap_true.

    DATA:
      lv_first_date      TYPE d,
      lv_last_date       TYPE d,
      lv_next_first_date TYPE d,
      lv_prev_first_date TYPE d,
      lv_prev_last_date  TYPE d,
      lv_w1_from         TYPE d,
      lv_w1_to           TYPE d,
      lv_w2_from         TYPE d,
      lv_w2_to           TYPE d,
      lv_w3_from         TYPE d,
      lv_w3_to           TYPE d,
      lv_w4_from         TYPE d,
      lv_w4_to           TYPE d.

    "============================================================
    " 1. PAGING
    "============================================================
    lv_page_size = io_request->get_paging( )->get_page_size( ).
    lv_offset    = io_request->get_paging( )->get_offset( ).

    "============================================================
    " 2. FILTERS / PARAMETERS
    "============================================================
    TRY.

        DATA(lt_filter) =
          io_request->get_filter( )->get_as_ranges( ).

      CATCH cx_rap_query_filter_no_range.

        CLEAR lt_filter.

    ENDTRY.


    LOOP AT lt_filter INTO DATA(ls_filter).

      CASE ls_filter-name.

        WHEN 'PROJECTID'.

          DATA(ls_rng) =
            VALUE #( ls_filter-range[ 1 ] OPTIONAL ).

          lv_project = ls_rng-low.


        WHEN 'P_MONTH'.

          ls_rng =
            VALUE #( ls_filter-range[ 1 ] OPTIONAL ).

          lv_month = ls_rng-low.


        WHEN 'P_PRE_MONTH'.

          ls_rng =
            VALUE #( ls_filter-range[ 1 ] OPTIONAL ).

          p_month = ls_rng-low.


        WHEN 'P_YEAR'.

          ls_rng =
            VALUE #( ls_filter-range[ 1 ] OPTIONAL ).

          lv_year = ls_rng-low.


        WHEN 'WBSE'.

          ls_rng =
            VALUE #( ls_filter-range[ 1 ] OPTIONAL ).

          lv_wbs = ls_rng-low.

      ENDCASE.

    ENDLOOP.


    "============================================================
    " 3. VALIDATE PARAMETERS
    "============================================================
    IF lv_project IS INITIAL
       OR lv_month IS INITIAL
       OR lv_year IS INITIAL.

      lv_valid = abap_false.

    ELSE.

      lv_month_num = lv_month.
      lv_year_num  = lv_year.

      IF lv_month_num < 1
         OR lv_month_num > 12
         OR lv_year_num < 1900.

        lv_valid = abap_false.

      ENDIF.

    ENDIF.


    IF lv_valid = abap_false.

      IF io_request->is_data_requested( ).

        io_response->set_data( lt_output ).

      ENDIF.

      IF io_request->is_total_numb_of_rec_requested( ).

        io_response->set_total_number_of_records( 0 ).

      ENDIF.

      RETURN.

    ENDIF.


    "============================================================
    " 4. DATE RANGES
    "============================================================

    " First date of selected month
    lv_first_date = lv_year && lv_month && '01'.


    " Last date of selected month
    lv_next_first_date = lv_first_date + 31.
    lv_next_first_date = lv_next_first_date(6) && '01'.

    lv_last_date = lv_next_first_date - 1.


    " Previous month
    lv_prev_last_date  = lv_first_date - 1.
    lv_prev_first_date = lv_prev_last_date(6) && '01'.


    "============================================================
    " WEEK RANGES
    "============================================================

    " W1 = 01 - 07
    lv_w1_from = lv_first_date.
    lv_w1_to   = lv_first_date + 6.


    " W2 = 08 - 14
    lv_w2_from = lv_first_date + 7.
    lv_w2_to   = lv_first_date + 13.


    " W3 = 15 - 21
    lv_w3_from = lv_first_date + 14.
    lv_w3_to   = lv_first_date + 20.


    " W4 = 22 - Month End
    lv_w4_from = lv_first_date + 21.
    lv_w4_to   = lv_last_date.


    "============================================================
    " 5. READ BOQ DATA
    "============================================================
    SELECT FROM zps_boq_data
      FIELDS
        zproj,
        posid,
        projectelementdescription,
        contract_line_item,
        zunit,
        zboqqty
      WHERE zproj = @lv_project
      INTO TABLE @DATA(lt_boq).


    "============================================================
    " 6. BUILD OUTPUT FROM BOQ
    "============================================================
    LOOP AT lt_boq INTO DATA(ls_boq).

      CLEAR ls_output.

      ls_output-srno =
        sy-tabix.

      ls_output-wbse =
        ls_boq-posid.

      ls_output-description =
        ls_boq-projectelementdescription.

      ls_output-unit =
        ls_boq-zunit.

      ls_output-boqquantity =
        ls_boq-zboqqty.

      ls_output-boqlineitem =
        ls_boq-posid.

      ls_output-contractlineitem =
        ls_boq-contract_line_item.

      APPEND ls_output TO lt_output.

    ENDLOOP.


    "============================================================
    " 6A. READ LAST MONTH DPR SUMMARY
    "============================================================
    " Total_dpr from this table represents the
    " previous month's executed quantity.
    "
    " Example:
    " Previous month = 35
    " Current month  = 2000
    " Completed      = 2000 + 35 = 2035
    "============================================================

    IF lt_boq IS NOT INITIAL.

      SELECT FROM zps_dpr_month_summery1
        FIELDS
          total_dpr,
          zproj_ext,
          posid
        FOR ALL ENTRIES IN @lt_boq
        WHERE zproj_ext = @lv_project
          AND posid      = @lt_boq-posid
        INTO TABLE @DATA(lt_aop_qtylast_m).

    ENDIF.


    "============================================================
    " 6B. ADD LAST MONTH DPR TO OUTPUT
    "============================================================
    LOOP AT lt_aop_qtylast_m INTO DATA(ls_aop).

      ASSIGN lt_output[
        KEY k_wbse
        wbse = ls_aop-posid
      ] TO FIELD-SYMBOL(<ls_last_month>).

      IF sy-subrc = 0.

        <ls_last_month>-qtyexecutedlastmonth =
            <ls_last_month>-qtyexecutedlastmonth
          + ls_aop-total_dpr.

      ENDIF.

    ENDLOOP.


    "============================================================
    " 7. READ DPR DATA
    "============================================================
    SELECT FROM zps_dpr_entry_cds1
      FIELDS
        zproj_ext,
        posid,
        zdpr_date,
        zboq_qty
      WHERE zproj_ext = @lv_project
      INTO TABLE @DATA(lt_dpr).


    DATA lv_dpr_date TYPE d.


    "============================================================
    " 7A. PROCESS DPR DATA
    "============================================================
    LOOP AT lt_dpr INTO DATA(ls_dpr).

      "----------------------------------------------------------
      " Convert DPR date to DATS YYYYMMDD
      "----------------------------------------------------------
      DATA(lv_txt) =
        condense(
          CONV string( ls_dpr-zdpr_date )
        ).

      CLEAR lv_dpr_date.


      IF lv_txt CS '/'.

        " DD/MM/YYYY
        IF strlen( lv_txt ) = 10.

          lv_dpr_date =
              lv_txt+6(4)
           && lv_txt+3(2)
           && lv_txt(2).

        ENDIF.

      ELSEIF strlen( lv_txt ) = 8.

        " Already YYYYMMDD
        lv_dpr_date = lv_txt.

      ENDIF.


      "----------------------------------------------------------
      " Ignore invalid dates
      "----------------------------------------------------------
      IF lv_dpr_date IS INITIAL
         OR lv_dpr_date > lv_last_date.

        CONTINUE.

      ENDIF.


      "----------------------------------------------------------
      " Find corresponding WBS in output
      "----------------------------------------------------------
      ASSIGN lt_output[
        KEY k_wbse
        wbse = ls_dpr-posid
      ] TO FIELD-SYMBOL(<ls_out>).

      IF sy-subrc <> 0.

        CONTINUE.

      ENDIF.


      "----------------------------------------------------------
      " CURRENT MONTH - WEEK WISE
      "----------------------------------------------------------

      IF lv_dpr_date BETWEEN lv_w1_from AND lv_w1_to.

        <ls_out>-qtyexecutedthismonthw1 =
            <ls_out>-qtyexecutedthismonthw1
          + ls_dpr-zboq_qty.


      ELSEIF lv_dpr_date BETWEEN lv_w2_from AND lv_w2_to.

        <ls_out>-qtyexecutedthismonthw2 =
            <ls_out>-qtyexecutedthismonthw2
          + ls_dpr-zboq_qty.


      ELSEIF lv_dpr_date BETWEEN lv_w3_from AND lv_w3_to.

        <ls_out>-qtyexecutedthismonthw3 =
            <ls_out>-qtyexecutedthismonthw3
          + ls_dpr-zboq_qty.


      ELSEIF lv_dpr_date BETWEEN lv_w4_from AND lv_w4_to.

        <ls_out>-qtyexecutedthismonthw4 =
            <ls_out>-qtyexecutedthismonthw4
          + ls_dpr-zboq_qty.

      ENDIF.


    ENDLOOP.


    "============================================================
    " 8. CALCULATIONS
    "============================================================
    LOOP AT lt_output ASSIGNING FIELD-SYMBOL(<ls_final>).


      "----------------------------------------------------------
      " Total Qty Executed This Month
      "
      " W1 + W2 + W3 + W4
      "----------------------------------------------------------
      <ls_final>-qtyexecutedthistotmonth =
          <ls_final>-qtyexecutedthismonthw1
        + <ls_final>-qtyexecutedthismonthw2
        + <ls_final>-qtyexecutedthismonthw3
        + <ls_final>-qtyexecutedthismonthw4.


      "----------------------------------------------------------
      " Qty Completed Till This Month
      "
      " Current Month + Previous Month
      "
      " Example:
      " Current Month = 2000
      " Last Month    = 35
      " Completed     = 2035
      "----------------------------------------------------------
      <ls_final>-qtycompletedtillthismonth =
          <ls_final>-qtyexecutedthistotmonth
        + <ls_final>-qtyexecutedlastmonth.


      "----------------------------------------------------------
      " Balance Quantity
      "----------------------------------------------------------
      <ls_final>-balancequantity =
          <ls_final>-boqquantity
        - <ls_final>-qtycompletedtillthismonth.


      "----------------------------------------------------------
      " Progress Calculations
      "----------------------------------------------------------
      IF <ls_final>-boqquantity <> 0.

        " Current Month Progress
        <ls_final>-progressachievedthismonth =
          ( <ls_final>-qtyexecutedthistotmonth * 100 )
          / <ls_final>-boqquantity.


        " Cumulative Progress
        <ls_final>-cumulativeprogresstillmonth =
          ( <ls_final>-qtycompletedtillthismonth * 100 )
          / <ls_final>-boqquantity.

      ENDIF.


      "----------------------------------------------------------
      " Variance
      "----------------------------------------------------------
      <ls_final>-variance = 0.

    ENDLOOP.


    "============================================================
    " 9. PAGING
    "============================================================
    LOOP AT lt_output INTO DATA(ls_page).

      IF lv_index >= lv_offset.

        APPEND ls_page TO lt_page.

        IF lv_page_size > 0
           AND lines( lt_page ) >= lv_page_size.

          EXIT.

        ENDIF.

      ENDIF.

      lv_index = lv_index + 1.

    ENDLOOP.


    "============================================================
    " 10. RESPONSE
    "============================================================
    IF io_request->is_data_requested( ).

      io_response->set_data( lt_page ).

    ENDIF.


    IF io_request->is_total_numb_of_rec_requested( ).

      io_response->set_total_number_of_records(
        lines( lt_output )
      ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
