CLASS zcl_ps_budgetreport DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PS_BUDGETREPORT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.



    TYPES: BEGIN OF ty_out,
             projectdefinition     TYPE c LENGTH 24,
             wbselement            TYPE c LENGTH 24,
             fiscalyear            TYPE n LENGTH 4,
             projectdescription    TYPE c LENGTH 60,
             wbselementdescription TYPE c LENGTH 60,
             budget                TYPE p LENGTH 15 DECIMALS 2,
             openpowo              TYPE p LENGTH 15 DECIMALS 2,
             actuals               TYPE p LENGTH 15 DECIMALS 2,
             assignedvalue         TYPE p LENGTH 15 DECIMALS 2,
             availablebudget       TYPE p LENGTH 15 DECIMALS 2,
             org_bdg  TYPE  p LENGTH 15 DECIMALS 2,
             supl_bdg  TYPE  p LENGTH 15 DECIMALS 2,
              send_bdg  TYPE  p LENGTH 15 DECIMALS 2,
              recv_bdg  TYPE  p LENGTH 15 DECIMALS 2,
              retn_bdg  TYPE  p LENGTH 15 DECIMALS 2,
             currency              TYPE c LENGTH 5,
           END OF ty_out.


    DATA it_data TYPE STANDARD TABLE OF zps_budgetreport_cds WITH EMPTY KEY.
    DATA it_out  TYPE STANDARD TABLE OF ty_out WITH EMPTY KEY.

    DATA lv_project TYPE c LENGTH 24.
    DATA lv_year    TYPE n LENGTH 4.
    DATA lr_wbs     TYPE RANGE OF i_actualplanlineitemsemtag-wbselement.
    DATA lr_year    TYPE RANGE OF i_actualplanlineitemsemtag-fiscalyear.

    CONSTANTS lc_semtag TYPE c LENGTH 20 VALUE 'ACT_COST'.
    CONSTANTS lc_budget TYPE c LENGTH 20 VALUE 'BUDGET01'.
    CONSTANTS lc_ledger TYPE c LENGTH 2  VALUE '0E'.
    CONSTANTS lc_srccom TYPE c LENGTH 2  VALUE '0E'.   " Open PO/WO
    CONSTANTS lc_poleder TYPE c LENGTH 2  VALUE '0E'.   " Open PO/WO
    CONSTANTS lc_srcact TYPE c LENGTH 2  VALUE '0L'.   " Actuals
    CONSTANTS lc_actleder TYPE c LENGTH 2  VALUE '0L'.   " Actuals

*&---------------------------------------------------------------------*
*& Filters from the input screen
*&---------------------------------------------------------------------*
    TRY.
        DATA(lt_filter) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range.
        CLEAR lt_filter.
    ENDTRY.

    LOOP AT lt_filter INTO DATA(ls_filter).
      CASE ls_filter-name.

        WHEN 'PROJECTDEFINITION'.
          DATA(ls_rng) = VALUE #( ls_filter-range[ 1 ] OPTIONAL ).
          lv_project = ls_rng-low.

        WHEN 'FISCALYEAR'.
          ls_rng  = VALUE #( ls_filter-range[ 1 ] OPTIONAL ).
           lv_year = ls_rng-low.
          lv_year = ls_rng-low.
          IF lv_year IS NOT INITIAL.
            APPEND VALUE #( sign = 'I' option = 'EQ' low = lv_year ) TO lr_year.

          ENDIF.

        WHEN 'WBSELEMENT'.
          LOOP AT ls_filter-range INTO DATA(ls_r).
            IF ls_r-low IS NOT INITIAL.
              APPEND VALUE #( sign   = 'I'
                              option = COND #( WHEN ls_r-high IS NOT INITIAL
                                               THEN 'BT' ELSE 'EQ' )
                              low    = ls_r-low
                              high   = ls_r-high ) TO lr_wbs.
            ENDIF.
          ENDLOOP.

      ENDCASE.
    ENDLOOP.

    DATA(paging) = io_request->get_paging( ).

*&---------------------------------------------------------------------*
*& Project header  (FS column B, row 15)
*&---------------------------------------------------------------------*
    SELECT SINGLE FROM i_enterpriseproject
      FIELDS project,
             projectuuid,
             projectdescription
      WHERE project = @lv_project
      INTO @DATA(ls_proj).

*&---------------------------------------------------------------------*
*& WBS elements of the project  (FS columns C and D, rows 16 and 17)
*&---------------------------------------------------------------------*
    SELECT FROM i_enterpriseprojectelement
      FIELDS projectelement,
             projectelementdescription,
             WBSElementInternalID
      WHERE projectuuid    = @ls_proj-projectuuid
        AND projectelement IN @lr_wbs
      INTO TABLE @DATA(lt_wbs).

    SORT lt_wbs BY projectelement.

*&---------------------------------------------------------------------*
*& Line items  (FS columns E, F and H)
*&---------------------------------------------------------------------*
    SELECT FROM i_actualplanlineitemsemtag
      FIELDS wbselementexternalid,
             semantictag,
             planningcategory,
             ledger,
             sourceledger,
             fiscalyear,
             amountinglobalcurrency,
             globalcurrency
      FOR ALL ENTRIES IN @lt_wbs
      WHERE wbselementexternalid = @lt_wbs-projectelement
        AND semantictag          = @lc_semtag
        AND fiscalyear          IN @lr_year
      INTO TABLE @DATA(lt_item).


       select WBSElementInternalID, AMOUNTINGLOBALCURRENCY as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE PlanningCategory = 'BUDGET01'
         and   BudgetProcess is INITIAL
         and   FunctionalArea is NOT INITIAL
         and FiscalYear = @lv_year
         INTO TABLE @data(it_org).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY as amt , FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   BudgetProcess = 'SUPL'
         and FiscalYear = @lv_year
         INTO TABLE @data(it_supl).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   BudgetProcess = 'SEND'
         and FiscalYear = @lv_year
         INTO TABLE @data(it_send).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   BudgetProcess = 'RECV'
         and FiscalYear = @lv_year
         INTO TABLE @data(it_recv).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
**         FOR ALL ENTRIES IN @it_wbs
**         WHERE WBSElementInternalID = @it_wbs-WBSElementInternalID
**         and   BudgetProcess = 'RETN'
         WHERE   BudgetProcess = 'RETN'
         and FiscalYear = @lv_year
         INTO TABLE @data(it_retn).







    LOOP AT lt_wbs INTO DATA(ls_wbs).

      DATA(ls_out) = VALUE ty_out(
        projectdefinition     = ls_proj-project
        wbselement            = ls_wbs-projectelement
        fiscalyear            = lv_year
        projectdescription    = ls_proj-projectdescription
        wbselementdescription = ls_wbs-projectelementdescription ).

      LOOP AT lt_item INTO DATA(ls_i)
           WHERE wbselementexternalid = ls_wbs-projectelement.

        IF ls_out-currency IS INITIAL.
          ls_out-currency = ls_i-globalcurrency.
        ENDIF.






*       ---- Budget: PLANNINGCATEGORY BUDGET01 ---------------------------
*        IF ls_i-planningcategory = lc_budget.
*          ls_out-budget = ls_out-budget + ls_i-amountinglobalcurrency + ls_out-retn_bdg + ls_out-recv_bdg + ls_out-send_bdg + ls_out-supl_bdg
*          + ls_out-org_bdg.
*        ENDIF.

*        IF ls_i-ledger = lc_ledger.

*         ---- Open PO/WO: SOURCELEDGER 0E, sum of all amounts -----------
*          IF ls_i-sourceledger = lc_srccom .
          IF ls_i-sourceledger = '0E'  AND  ls_i-Ledger = '0E'.
            ls_out-openpowo = ls_out-openpowo + ls_i-amountinglobalcurrency.
          ENDIF.

*         ---- Actuals: SOURCELEDGER 0L, negative amounts only, made
*              positive and summed  (FS rows H42 to H44) -----------------
*          IF ls_i-sourceledger = lc_srcact
          IF ( ls_i-sourceledger = '0L'  AND  ls_i-Ledger = '0L' ) and ls_i-PlanningCategory = 'ACT01' .
*             AND ls_i-amountinglobalcurrency < 0.
            ls_out-actuals = ls_out-actuals + abs( ls_i-amountinglobalcurrency ).
          ENDIF.

*        ENDIF.

      ENDLOOP.
      LOOP at it_org INTO data(wa_org) WHERE WBSElementInternalID = ls_wbs-WBSElementInternalID.
        ls_out-org_bdg  = ls_out-org_bdg + wa_org-amt.
        ENDLOOP.

        LOOP AT it_supl INTO data(wa_supl) WHERE WBSElementInternalID = ls_wbs-WBSElementInternalID.
        ls_out-supl_bdg  = ls_out-supl_bdg + wa_supl-amt.
        ENDLOOP.

        LOOP AT it_send INTO data(wa_send) WHERE WBSElementInternalID = ls_wbs-WBSElementInternalID.
        ls_out-send_bdg  = ls_out-send_bdg + wa_send-amt.
        ENDLOOP.

        LOOP AT it_recv INTO data(wa_recv) WHERE WBSElementInternalID = ls_wbs-WBSElementInternalID.
        ls_out-recv_bdg  = ls_out-recv_bdg + wa_recv-amt.
        ENDLOOP.

        LOOP AT it_retn INTO data(wa_retn) WHERE WBSElementInternalID = ls_wbs-WBSElementInternalID.
        ls_out-retn_bdg  = ls_out-retn_bdg + wa_retn-amt.
        ENDLOOP.

*         IF ls_i-planningcategory = lc_budget.
          ls_out-budget = ls_out-budget + ls_out-retn_bdg + ls_out-recv_bdg + ls_out-send_bdg + ls_out-supl_bdg
          + ls_out-org_bdg.  "+ ls_i-amountinglobalcurrency
*        ENDIF.


*     ---- Assigned Value = Open PO/WO + Actuals  (FS I15) --------------
      ls_out-assignedvalue = ls_out-openpowo + ls_out-actuals.

*     ---- Available Budget = Budget - Assigned  (FS J15) ---------------
      ls_out-availablebudget = ls_out-budget - ls_out-assignedvalue.

      APPEND ls_out TO it_out.
      CLear : ls_i,ls_wbs,wa_retn,wa_recv,wa_send,wa_supl,ls_out,
      wa_org.

    ENDLOOP.

    DELETE it_out WHERE budget = 0.

    it_data = CORRESPONDING #( it_out ).

*&---------------------------------------------------------------------*
*& Count, then paging
*&---------------------------------------------------------------------*
    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( it_data ) ).
    ENDIF.

    IF io_request->is_data_requested( ).

      DATA(lv_offset) = paging->get_offset( ).
      DATA(lv_page)   = paging->get_page_size( ).

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
