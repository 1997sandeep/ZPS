CLASS zcl_boq_track_rep DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .

  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES: tr_project  TYPE RANGE OF zboq_tracking-project_id,
           tr_plant    TYPE RANGE OF zboq_tracking-plant,
           tr_wbs      TYPE RANGE OF zboq_tracking-wbs_element,
           tr_hdr      TYPE RANGE OF zboq_tracking-boq_hdr_no,
           tr_item     TYPE RANGE OF zboq_tracking-boq_item_no,
           tr_contract TYPE RANGE OF zboq_tracking-contract_line_item,
           tr_year     TYPE RANGE OF zboq_tracking-fiscal_year.

ENDCLASS.



CLASS ZCL_BOQ_TRACK_REP IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA: it_data TYPE STANDARD TABLE OF zboq_track_rep WITH EMPTY KEY,
          ls_out  TYPE zboq_track_rep.

    DATA: lr_project  TYPE tr_project,
          lr_plant    TYPE tr_plant,
          lr_wbs      TYPE tr_wbs,
          lr_hdr      TYPE tr_hdr,
          lr_item     TYPE tr_item,
          lr_contract TYPE tr_contract,
          lr_year     TYPE tr_year.

    DATA: lv_year TYPE zboq_tracking-fiscal_year,
          lv_prev TYPE zboq_tracking-fiscal_year.

*&---------------------------------------------------------------------*
*& 1. Filters coming from the UI5 input screen
*&---------------------------------------------------------------------*
    TRY.
        DATA(lt_ranges) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
        CLEAR lt_ranges.
    ENDTRY.

    LOOP AT lt_ranges ASSIGNING FIELD-SYMBOL(<ls_rng>).

      CASE <ls_rng>-name.
        WHEN 'PROJECT_ID'.
          lr_project  = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'PLANT'.
          lr_plant    = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'WBS_ELEMENT'.
          lr_wbs      = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'BOQ_HDR_NO'.
          lr_hdr      = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'BOQ_ITEM_NO'.
          lr_item     = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'CONTRACT_LINE_ITEM'.
          lr_contract = CORRESPONDING #( <ls_rng>-range ).
        WHEN 'FISCAL_YEAR'.
          lr_year     = CORRESPONDING #( <ls_rng>-range ).
      ENDCASE.

    ENDLOOP.

*   the planning year drives the whole report, so it is read out
*   separately - the previous year is derived from it
    lv_year = VALUE #( lr_year[ 1 ]-low OPTIONAL ).
    IF lv_year IS INITIAL.
      lv_year = sy-datum(4).
      CLEAR lr_year.
      APPEND VALUE #( sign = 'I' option = 'EQ' low = lv_year ) TO lr_year.
    ENDIF.

    lv_prev = lv_year - 1.

*&---------------------------------------------------------------------*
*& 2. Planning rows of the selected year
*&---------------------------------------------------------------------*
    SELECT *
      FROM zboq_tracking
      WHERE project_id         IN @lr_project
        AND plant              IN @lr_plant
        AND wbs_element        IN @lr_wbs
        AND boq_hdr_no         IN @lr_hdr
        AND boq_item_no        IN @lr_item
        AND contract_line_item IN @lr_contract
        AND fiscal_year         = @lv_year
      ORDER BY sr_no
      INTO TABLE @DATA(lt_curr).

*&---------------------------------------------------------------------*
*& 3. The same BOQ lines for the previous year
*&---------------------------------------------------------------------*
    SELECT *
      FROM zboq_tracking
      WHERE project_id         IN @lr_project
        AND plant              IN @lr_plant
        AND wbs_element        IN @lr_wbs
        AND boq_hdr_no         IN @lr_hdr
        AND boq_item_no        IN @lr_item
        AND contract_line_item IN @lr_contract
        AND fiscal_year         = @lv_prev
      INTO TABLE @DATA(lt_prev).

*&---------------------------------------------------------------------*
*& 4. Build the report rows
*&---------------------------------------------------------------------*
    LOOP AT lt_curr INTO DATA(ls_curr).

      CLEAR ls_out.

*     ---- identification ------------------------------------------------
      ls_out-sr_no              = ls_curr-sr_no.
      ls_out-project_id         = ls_curr-project_id.
      ls_out-plant              = ls_curr-plant.
      ls_out-wbs_element        = ls_curr-wbs_element.
      ls_out-description        = ls_curr-description.
      ls_out-boq_hdr_no         = ls_curr-boq_hdr_no.
      ls_out-boq_hdr_desc       = ls_curr-boq_hdr_desc.
      ls_out-boq_item_no        = ls_curr-boq_item_no.
      ls_out-boq_item_desc      = ls_curr-boq_item_desc.
      ls_out-contract_line_item = ls_curr-contract_line_item.
      ls_out-uom                = ls_curr-uom.
      ls_out-boq_qty            = ls_curr-boq_qty.
      ls_out-currency           = ls_curr-currency.
      ls_out-boq_rate           = ls_curr-boq_rate.
      ls_out-amount             = ls_curr-amount.
      ls_out-resp_engineer      = ls_curr-resp_engineer.
      ls_out-fiscal_year        = ls_curr-fiscal_year.

*     ---- monthly planned -----------------------------------------------
      ls_out-jan_planned = ls_curr-amt_january.
      ls_out-feb_planned = ls_curr-amt_february.
      ls_out-mar_planned = ls_curr-amt_march.
      ls_out-apr_planned = ls_curr-amt_april.
      ls_out-may_planned = ls_curr-amt_may.
      ls_out-jun_planned = ls_curr-amt_june.
      ls_out-jul_planned = ls_curr-amt_july.
      ls_out-aug_planned = ls_curr-amt_august.
      ls_out-sep_planned = ls_curr-amt_september.
      ls_out-oct_planned = ls_curr-amt_october.
      ls_out-nov_planned = ls_curr-amt_november.
      ls_out-dec_planned = ls_curr-amt_december.

*     ---- monthly executed ----------------------------------------------
*     ZBOQ_TRACKING holds no execution figures, so these stay zero.
*     When the source is decided (a second Z table, network
*     confirmations, or actual postings), read it above into LT_EXEC
*     keyed on the same BOQ line and fill the twelve fields here:
*
*        READ TABLE lt_exec INTO DATA(ls_exec)
*             WITH KEY project_id  = ls_curr-project_id
*                      wbs_element = ls_curr-wbs_element
*                      boq_item_no = ls_curr-boq_item_no
*                      fiscal_year = lv_year.
*        IF sy-subrc = 0.
*          ls_out-jan_executed = ls_exec-jan.
*          ...
*        ENDIF.

      CLEAR: ls_out-jan_executed, ls_out-feb_executed, ls_out-mar_executed,
             ls_out-apr_executed, ls_out-may_executed, ls_out-jun_executed,
             ls_out-jul_executed, ls_out-aug_executed, ls_out-sep_executed,
             ls_out-oct_executed, ls_out-nov_executed, ls_out-dec_executed.

*     ---- current year totals -------------------------------------------
      ls_out-curr_year_planned  = ls_out-jan_planned + ls_out-feb_planned
                                + ls_out-mar_planned + ls_out-apr_planned
                                + ls_out-may_planned + ls_out-jun_planned
                                + ls_out-jul_planned + ls_out-aug_planned
                                + ls_out-sep_planned + ls_out-oct_planned
                                + ls_out-nov_planned + ls_out-dec_planned.

      ls_out-curr_year_executed = ls_out-jan_executed + ls_out-feb_executed
                                + ls_out-mar_executed + ls_out-apr_executed
                                + ls_out-may_executed + ls_out-jun_executed
                                + ls_out-jul_executed + ls_out-aug_executed
                                + ls_out-sep_executed + ls_out-oct_executed
                                + ls_out-nov_executed + ls_out-dec_executed.

*     ---- previous year totals ------------------------------------------
      READ TABLE lt_prev INTO DATA(ls_prev)
           WITH KEY project_id         = ls_curr-project_id
                    plant              = ls_curr-plant
                    wbs_element        = ls_curr-wbs_element
                    boq_hdr_no         = ls_curr-boq_hdr_no
                    boq_item_no        = ls_curr-boq_item_no
                    contract_line_item = ls_curr-contract_line_item.

      IF sy-subrc = 0.
        ls_out-last_year_planned = ls_prev-amt_january  + ls_prev-amt_february
                                 + ls_prev-amt_march    + ls_prev-amt_april
                                 + ls_prev-amt_may      + ls_prev-amt_june
                                 + ls_prev-amt_july     + ls_prev-amt_august
                                 + ls_prev-amt_september + ls_prev-amt_october
                                 + ls_prev-amt_november + ls_prev-amt_december.
      ENDIF.

*     last year executed comes from the same missing source as above
      CLEAR ls_out-last_year_executed.

*     ---- cumulative and balance ----------------------------------------
      ls_out-cumulative_planned   = ls_out-last_year_planned
                                  + ls_out-curr_year_planned.

      ls_out-cumulative_executed  = ls_out-last_year_executed
                                  + ls_out-curr_year_executed.

      ls_out-balance_qty_executed = ls_curr-boq_qty
                                  - ls_out-cumulative_executed.

      APPEND ls_out TO it_data.

    ENDLOOP.

*&---------------------------------------------------------------------*
*& 5. Sorting
*&---------------------------------------------------------------------*
    DATA(lt_sort) = io_request->get_sort_elements( ).

    IF lt_sort IS NOT INITIAL.
      DATA(lt_otab) = VALUE abap_sortorder_tab( ).
      LOOP AT lt_sort INTO DATA(ls_sort).
        APPEND VALUE #( name       = ls_sort-element_name
                        descending = ls_sort-descending ) TO lt_otab.
      ENDLOOP.
      SORT it_data BY (lt_otab).
    ELSE.
      SORT it_data BY sr_no ASCENDING.
    ENDIF.

*&---------------------------------------------------------------------*
*& 6. Total count - before paging cuts the table down
*&---------------------------------------------------------------------*
    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( it_data ) ).
    ENDIF.

*&---------------------------------------------------------------------*
*& 7. Paging
*&---------------------------------------------------------------------*
    IF io_request->is_data_requested( ).

      DATA(lo_paging)  = io_request->get_paging( ).
      DATA(lv_offset)  = lo_paging->get_offset( ).
      DATA(lv_page)    = lo_paging->get_page_size( ).

      IF lv_offset > 0.
        DELETE it_data TO lv_offset.
      ENDIF.

      IF lv_page <> if_rap_query_paging=>page_size_unlimited
         AND lv_page > 0
         AND lines( it_data ) > lv_page.
        DELETE it_data FROM lv_page + 1.
      ENDIF.

      io_response->set_data( it_data ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
