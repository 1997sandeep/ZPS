CLASS zcl_budget_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BUDGET_REPORT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
 IF io_request->is_data_requested( ).


      TYPES : BEGIN OF st_final,
              ProjectElement TYPE string,
              WBSElementInternalID TYPE string,
              PROJECTELEMENTUUID type string,
              PARENTOBJECTUUID type string,
              wbs_level     TYPE string,
              level1     type int1,
              wbs_desc  TYPE string,
              p_wbs     TYPE string,
              p_desc    TYPE string,
              main_wbs  TYPE string,
              org_bdg   TYPE zamt,   ""ZPS_BUDGET_AMT,
              supl_bdg  TYPE zamt,
              send_bdg  TYPE zamt,
              recv_bdg  TYPE zamt,
              retn_bdg  TYPE zamt,
              curr_bdg  TYPE zamt,
              comittmnt TYPE zamt,
              act_cost  TYPE zamt,
              assign_cost  TYPE zamt,
              avbl_bdg  TYPE zamt,
      END OF st_final.

      data : it_final TYPE TABLE of st_final,
             it_data  TYPE TABLE of st_final,
             it_tot   TYPE TABLE of st_final,
             wa_final type st_final,
             wa_data  type st_final,
             wa_tot   type st_final,
             wa_data1 type st_final.

      data : lv_cnt1 TYPE string,
             lv_cnt2 TYPE string,
             lv_cnt3 TYPE string,
             lv_cnt4 TYPE string,
             lv_cnt5 TYPE string,
             lv_cnt6 TYPE string,
             lv_cnt7 TYPE string.

      data : lv_cnt11(2) TYPE n,
             lv_cnt22(2) TYPE n,
             lv_cnt33(2) TYPE n,
             lv_cnt44(2) TYPE n,
             lv_cnt55(2) TYPE n,
             lv_cnt66(2) TYPE n,
             lv_cnt77(2) TYPE n.

      data : amt_org1  type zamt,
             amt_supl1 type zamt,
             amt_send1 type zamt,
             amt_recv1 type zamt,
             amt_retn1 type zamt,
             amt_curr1 type zamt,
             amt_comt1 type zamt,
             amt_actl1 type zamt,
             amt_assn1 type zamt,
             amt_avbl1 type zamt.

      data : amt_org2  type zamt,
             amt_supl2 type zamt,
             amt_send2 type zamt,
             amt_recv2 type zamt,
             amt_retn2 type zamt,
             amt_curr2 type zamt,
             amt_comt2 type zamt,
             amt_actl2 type zamt,
             amt_assn2 type zamt,
             amt_avbl2 type zamt.

      data : amt_org3  type zamt,
             amt_supl3 type zamt,
             amt_send3 type zamt,
             amt_recv3 type zamt,
             amt_retn3 type zamt,
             amt_curr3 type zamt,
             amt_comt3 type zamt,
             amt_actl3 type zamt,
             amt_assn3 type zamt,
             amt_avbl3 type zamt.

      data : amt_org4  type zamt,
             amt_supl4 type zamt,
             amt_send4 type zamt,
             amt_recv4 type zamt,
             amt_retn4 type zamt,
             amt_curr4 type zamt,
             amt_comt4 type zamt,
             amt_actl4 type zamt,
             amt_assn4 type zamt,
             amt_avbl4 type zamt.


      data : amt_org5  type zamt,
             amt_supl5 type zamt,
             amt_send5 type zamt,
             amt_recv5 type zamt,
             amt_retn5 type zamt,
             amt_curr5 type zamt,
             amt_comt5 type zamt,
             amt_actl5 type zamt,
             amt_assn5 type zamt,
             amt_avbl5 type zamt.

      data : amt_org6  type zamt,
             amt_supl6 type zamt,
             amt_send6 type zamt,
             amt_recv6 type zamt,
             amt_retn6 type zamt,
             amt_curr6 type zamt,
             amt_comt6 type zamt,
             amt_actl6 type zamt,
             amt_assn6 type zamt,
             amt_avbl6 type zamt.

      data : amt_org7  type zamt,
             amt_supl7 type zamt,
             amt_send7 type zamt,
             amt_recv7 type zamt,
             amt_retn7 type zamt,
             amt_curr7 type zamt,
             amt_comt7 type zamt,
             amt_actl7 type zamt,
             amt_assn7 type zamt,
             amt_avbl7 type zamt.


      DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.

**      lv_top = 100.

      DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

      DATA(lt_sort)    = io_request->get_sort_elements( ).

      DATA : lv_orderby TYPE string.
      LOOP AT lt_sort INTO DATA(ls_sort).
        IF ls_sort-descending = abap_true.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } DESCENDING '|.
        ELSE.
          lv_orderby = |'{ lv_orderby } { ls_sort-element_name } ASCENDING '|.
        ENDIF.
      ENDLOOP.
      IF lv_orderby IS INITIAL.
        lv_orderby = 'ProjectElement'.
      ENDIF.

      DATA(lv_conditions) =  io_request->get_filter( )->get_as_sql_string( ).

      DATA(lo_paging)  = io_request->get_paging( ).
      DATA(lv_offset)  = lo_paging->get_offset( ).
      DATA(lv_rows)    = lo_paging->get_page_size( ).
      DATA(lv_max_rows) = COND #( WHEN lv_rows =
              if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_rows ).

**       IF io_request->is_total_numb_of_rec_requested( ) = abap_true.
**         SELECT COUNT( * ) FROM I_ENTERPRISEPROJECTELEMENT WHERE (lv_conditions) INTO @DATA(Lv_counts).
**         io_response->set_total_number_of_records( Lv_counts ).
**        ENDIF.
**
**      SELECT ProjectElement, WBSElementInternalID , PROJECTELEMENTUUID , PARENTOBJECTUUID, ProjectElementDescription,
**             YY1_ADDITIONALINFORMAT_PTD, YY1_BOQQTYL_PTD, YY1_BUDGETHEAD_PTD, YY1_COSTCODE_PTD, YY1_DEPARTMENT_PTD,
**             YY1_GROUPCODE_PTD, YY1_LOCATION_PTD, YY1_RATEL_PTD, YY1_RERANO_PTD, YY1_UOMFL_PTD
**       FROM  I_ENTERPRISEPROJECTELEMENT
**        WHERE (lv_conditions)
**        ORDER BY (lv_orderby)
**        INTO TABLE @DATA(it_wbs)
**       UP TO @LV_max_rows ROWS OFFSET @LV_offset.

      SELECT ProjectElement, WBSElementInternalID , PROJECTELEMENTUUID , PARENTOBJECTUUID, ProjectElementDescription , sortingnumber
**             YY1_ADDITIONALINFORMAT_PTD, YY1_BOQQTYL_PTD, YY1_BUDGETHEAD_PTD, YY1_COSTCODE_PTD, YY1_DEPARTMENT_PTD,
**             YY1_GROUPCODE_PTD, YY1_LOCATION_PTD, YY1_RATEL_PTD, YY1_RERANO_PTD, YY1_UOMFL_PTD
       FROM  I_ENTERPRISEPROJECTELEMENT
        WHERE (lv_conditions)
        ORDER BY (lv_orderby)
        INTO TABLE @DATA(it_wbs)
        UP TO @lv_top ROWs offset @lv_skip.

      sort it_wbs by SortingNumber.

       if it_wbs is NOT INITIAL.
        SELECT ProjectElement, WBSElementInternalID , PROJECTELEMENTUUID , PARENTOBJECTUUID, ProjectElementDescription
         FROM  I_ENTERPRISEPROJECTELEMENT
         WHERE ProjectElement is NOT INITIAL
         INTO TABLE @DATA(it_parent).


        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE PlanningCategory = 'BUDGET01'
         and   BudgetProcess is INITIAL
**         and   FunctionalArea is NOT INITIAL
         and     GLAccount = '0040700001'
         INTO TABLE @data(it_org).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY as amt , FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
        WHERE   GLAccount = '0040700006'
**         and    BudgetProcess = 'SUPL'
         INTO TABLE @data(it_supl).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   GLAccount = '0040700003'
**         and     BudgetProcess = 'SEND'
         INTO TABLE @data(it_send).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   GLAccount = '0040700004'
**         and     BudgetProcess = 'RECV'
         INTO TABLE @data(it_recv).

        select WBSElementInternalID, AMOUNTINGLOBALCURRENCY  as amt, FINPLNGENTRYITEMCRTNDATETIME
         from  I_financialplanningentryitem
         WHERE   GLAccount = '0040700005'
**         and     BudgetProcess = 'RETN'
         INTO TABLE @data(it_retn).

      SELECT wbselementinternalid, sum( AmountInCompanyCodeCurrency ) as AmountInCompanyCodeCurrency
      FROM  i_operationalacctgdocitem
      WHERE  Debitcreditcode = 'S'
      AND ACCOUNTINGDOCUMENTTYPE IN ( 'KR' , 'RE' )
      GROUP BY wbselementinternalid
      INTO TABLE @DATA(it_act).

      SELECT wbselementinternalid, sum( GOODSMVTCNSMPNAMTINCCCRCY ) as GOODSISSUEAMOUNTINCOCODECRCY
      FROM  I_GOODSMOVEMENTCUBE
      WHERE GOODSMOVEMENTTYPE in ( '221' , '101' )
      GROUP BY wbselementinternalid
      INTO TABLE @DATA(it_act2).

      SELECT wbselementinternalid, sum( TOTALGOODSMVTAMTINCCCRCY ) as TOTALGOODSMVTAMTINCCCRCY
      FROM  I_MATERIALDOCUMENTITEM_2
      WHERE GOODSMOVEMENTTYPE in ( '601' , '602' )
      GROUP BY wbselementinternalid
      INTO TABLE @DATA(it_act3).

      SELECT WBSElementInternalID, sum( AmountInglobalcurrency ) as AmountInCompanyCodeCurrency
      FROM  I_ActualPlanJournalEntryItem
      WHERE  Ledger = '0E'
      AND    SourceLedger = '0E'
      GROUP BY WBSElementInternalID
      INTO TABLE @DATA(it_commit).

         LOOP AT it_wbs INTO data(wa_wbs11).

           data(it_org11) = it_org[].
           delete it_org11 WHERE WBSElementInternalID <> wa_wbs11-WBSElementInternalID.
           delete it_org11 WHERE amt ge 0.
           sort it_org11 by FINPLNGENTRYITEMCRTNDATETIME DESCENDING.

           READ TABLE it_org11 INTO data(wa_org11) INDEX 1.
           if wa_org11 is NOT INITIAL.
           delete it_supl WHERE WBSElementInternalID = wa_org11-WBSElementInternalID
                          and   FinPlngEntryItemCrtnDateTime le wa_org11-FinPlngEntryItemCrtnDateTime.

           delete it_send WHERE WBSElementInternalID = wa_org11-WBSElementInternalID
                          and   FinPlngEntryItemCrtnDateTime le wa_org11-FinPlngEntryItemCrtnDateTime.

           delete it_recv WHERE WBSElementInternalID = wa_org11-WBSElementInternalID
                          and   FinPlngEntryItemCrtnDateTime le wa_org11-FinPlngEntryItemCrtnDateTime.

           delete it_retn WHERE WBSElementInternalID = wa_org11-WBSElementInternalID
                          and   FinPlngEntryItemCrtnDateTime le wa_org11-FinPlngEntryItemCrtnDateTime.
           ENDIF.

           clear : it_org11[],wa_org11.
         ENDLOOP.


       ENDIF.

      LOOP AT it_wbs into data(wa_wbs).

        wa_final-ProjectElement  = wa_wbs-ProjectElement.
        wa_final-wbselementinternalid  = wa_wbs-WBSElementInternalID.
        wa_final-projectelementuuid    = wa_wbs-ProjectElementUUID.
        wa_final-parentobjectuuid      = wa_wbs-ParentObjectUUID.
        wa_final-wbs_desc        = wa_wbs-ProjectElementDescription.

        READ TABLE it_parent INTO data(wa_parent) with key ProjectElementUUID = wa_wbs-ParentObjectUUID.
        wa_final-p_wbs  = wa_parent-ProjectElement.
        wa_final-p_desc = wa_parent-ProjectElementDescription.

        LOOP at it_org INTO data(wa_org) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-org_bdg  = wa_final-org_bdg + wa_org-amt.
        ENDLOOP.

        LOOP AT it_supl INTO data(wa_supl) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-supl_bdg  = wa_final-supl_bdg + wa_supl-amt.
        ENDLOOP.

        LOOP AT it_send INTO data(wa_send) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-send_bdg  = wa_final-send_bdg + wa_send-amt.
        ENDLOOP.

        LOOP AT it_recv INTO data(wa_recv) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-recv_bdg  = wa_final-recv_bdg + wa_recv-amt.
        ENDLOOP.

        LOOP AT it_retn INTO data(wa_retn) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-retn_bdg  = wa_final-retn_bdg + wa_retn-amt.
        ENDLOOP.

        LOOP AT it_act INTO data(wa_act) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-act_cost  = wa_final-act_cost + wa_act-amountincompanycodecurrency.
        ENDLOOP.

        LOOP AT it_act2 INTO data(wa_act2) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-act_cost  = wa_final-act_cost + wa_act2-goodsissueamountincocodecrcy.
        ENDLOOP.

        LOOP AT it_act3 INTO data(wa_act3) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-act_cost  = wa_final-act_cost + wa_act3-totalgoodsmvtamtincccrcy.
        ENDLOOP.

       LOOP AT it_commit INTO data(wa_commit) WHERE WBSElementInternalID = wa_wbs-WBSElementInternalID.
        wa_final-comittmnt  = wa_final-comittmnt + wa_commit-amountincompanycodecurrency.
        ENDLOOP.

        wa_final-curr_bdg  = wa_final-org_bdg + wa_final-supl_bdg + wa_final-send_bdg + wa_final-retn_bdg + wa_final-recv_bdg.

        wa_final-assign_cost = wa_final-comittmnt + wa_final-act_cost.

        wa_final-avbl_bdg    = wa_final-curr_bdg - wa_final-assign_cost.

        APPEND wa_final to it_final.
        clear: wa_final,wa_parent,wa_org,wa_supl,wa_send,wa_recv,wa_retn.

      ENDLOOP.

    data(it_level1) = it_final[].
    delete it_level1 WHERE p_wbs is not INITIAL.

     LOOP AT it_level1 INTO data(wa_level1).

      "" Level 1 -
        clear: lv_cnt1,lv_cnt11,lv_cnt2,lv_cnt3,lv_cnt4,lv_cnt5,lv_cnt6.
        clear: amt_org1,amt_org2,amt_org3,amt_org4,amt_org5,amt_org6,amt_org7.
        clear: amt_supl1,amt_supl2,amt_supl3,amt_supl4,amt_supl5,amt_supl6,amt_supl7.
        clear: amt_send1,amt_send2,amt_send3,amt_send4,amt_send5,amt_send6,amt_send7.
        clear: amt_recv1,amt_recv2,amt_recv3,amt_recv4,amt_recv5,amt_recv6,amt_recv7.
        clear: amt_retn1,amt_retn2,amt_retn3,amt_retn4,amt_retn5,amt_retn6,amt_retn7.
        clear: amt_curr1,amt_curr2,amt_curr3,amt_curr4,amt_curr5,amt_curr6,amt_curr7.
        clear: amt_comt1,amt_comt2,amt_comt3,amt_comt4,amt_comt5,amt_comt6,amt_comt7.
        clear: amt_actl1,amt_actl2,amt_actl3,amt_actl4,amt_actl5,amt_actl6,amt_actl7.
        clear: amt_assn1,amt_assn2,amt_assn3,amt_assn4,amt_assn5,amt_assn6,amt_assn7.
        clear: amt_avbl1,amt_avbl2,amt_avbl3,amt_avbl4,amt_avbl5,amt_avbl6,amt_avbl7.
         lv_cnt11 = lv_cnt11 + 01.
         lv_cnt1 = lv_cnt11.
        condense lv_cnt1.

      "" Level 2 -
        data(it_level2) = it_final[].
        delete it_level2 WHERE p_wbs ne wa_level1-projectelement.
         LOOP AT it_level2 INTO data(wa_level2).
          clear: lv_cnt3,lv_cnt33,amt_org2,amt_supl2,amt_send2,amt_recv2,amt_retn2,amt_curr2,amt_comt2,amt_actl2,amt_assn2,amt_avbl2.
           lv_cnt22 = lv_cnt22 + 01.
           lv_cnt2 = lv_cnt22.
          condense lv_cnt2.

        "" Level 3 -
          data(it_level3) = it_final[].
          delete it_level3 WHERE p_wbs ne wa_level2-projectelement.
           LOOP AT it_level3 INTO data(wa_level3).
            clear: lv_cnt4,lv_cnt44,amt_org3,amt_supl3,amt_send3,amt_recv3,amt_retn3,amt_curr3,amt_comt3,amt_actl3,amt_assn3,amt_avbl3.
              lv_cnt33 = lv_cnt33 + 01.
              lv_cnt3 = lv_cnt33.
            condense lv_cnt3.

         "" Level 4 -
           data(it_level4) = it_final[].
           delete it_level4 WHERE p_wbs ne wa_level3-projectelement.
            LOOP AT it_level4 INTO data(wa_level4).
             clear: lv_cnt5,lv_cnt55,amt_org4,amt_supl4,amt_send4,amt_recv4,amt_retn4,amt_curr4,amt_comt4,amt_actl4,amt_assn4,amt_avbl4.
              lv_cnt44 = lv_cnt44 + 01.
              lv_cnt4 = lv_cnt44.
             condense lv_cnt4.

          "" Level 5 -
            data(it_level5) = it_final[].
            delete it_level5 WHERE p_wbs ne wa_level4-projectelement.

             LOOP AT it_level5 INTO data(wa_level5).
              clear: lv_cnt6,lv_cnt66,amt_org5,amt_supl5,amt_send5,amt_recv5,amt_retn5,amt_curr5,amt_comt5,amt_actl5,amt_assn5,amt_avbl5.
              lv_cnt55 = lv_cnt55 + 01.
              lv_cnt5 = lv_cnt55.
              condense lv_cnt5.

          "" Level 6 -
            data(it_level6) = it_final[].
            delete it_level6 WHERE p_wbs ne wa_level5-projectelement.

             LOOP AT it_level6 INTO data(wa_level6).
              clear: lv_cnt7,lv_cnt77,amt_org6,amt_supl6,amt_send6,amt_recv6,amt_retn6,amt_curr6,amt_comt6,amt_actl6,amt_assn6,amt_avbl6.
              lv_cnt66 = lv_cnt66 + 01.
              lv_cnt6 = lv_cnt66.
              condense lv_cnt5.

           "" Level 7 -
             data(it_level7) = it_final[].
             delete it_level7 WHERE p_wbs ne wa_level6-projectelement.
              LOOP AT it_level7 INTO data(wa_level7).
               wa_data = wa_level7.
               wa_data-level1 = 7.
               lv_cnt77 = lv_cnt77 + 01.
               lv_cnt7 = lv_cnt77.
               condense lv_cnt7.
               CONCATENATE lv_cnt1 lv_cnt2 lv_cnt3 lv_cnt4 lv_cnt5 lv_cnt6 lv_cnt7 INTO wa_data-wbs_level SEPARATED BY '.' .
               CONDENSE wa_data-wbs_level.
               wa_data-main_wbs  = wa_level1-projectelement.

               amt_org6  = amt_org6  + wa_data-org_bdg.
               amt_supl6 = amt_supl6 + wa_data-supl_bdg.
               amt_send6 = amt_send6 + wa_data-send_bdg.
               amt_recv6 = amt_recv6 + wa_data-recv_bdg.
               amt_retn6 = amt_retn6 + wa_data-retn_bdg.
               amt_curr6 = amt_curr6 + wa_data-curr_bdg.
               amt_comt6 = amt_comt6 + wa_data-comittmnt.
               amt_actl6 = amt_actl6 + wa_data-act_cost.
               amt_assn6 = amt_assn6 + wa_data-assign_cost.
               amt_avbl6 = amt_avbl6 + wa_data-avbl_bdg.

               APPEND wa_data to it_data.
               clear : wa_data.

             ENDLOOP.

            ""Level 6 Data Append -
              wa_data = wa_level6.
              if  amt_org6 is NOT INITIAL.
              wa_data-org_bdg = amt_org6.
              ENDIF.

              if  amt_supl6 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl6.
              ENDIF.

              if  amt_send6 is NOT INITIAL.
              wa_data-send_bdg = amt_send6.
              ENDIF.

              if  amt_recv6 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv6.
              ENDIF.

              if  amt_retn6 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn6.
              ENDIF.

              clear amt_curr6.
              amt_curr6 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_curr6 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr6.
              ENDIF.

              if  amt_comt6 is NOT INITIAL.
              wa_data-comittmnt = amt_comt6.
              ENDIF.

              if  amt_actl6 is NOT INITIAL.
              wa_data-act_cost = amt_actl6.
              ENDIF.

              if  amt_assn6 is NOT INITIAL.
              wa_data-assign_cost = amt_assn6.
              ENDIF.

              if  amt_avbl6 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl6.
              ENDIF.


              CONCATENATE lv_cnt1 lv_cnt2 lv_cnt3 lv_cnt4 lv_cnt5 lv_cnt6 INTO wa_data-wbs_level SEPARATED BY '.' .
              CONDENSE wa_data-wbs_level.
              wa_data-level1 = 6.
              wa_data-main_wbs  = wa_level1-projectelement.

               amt_org5  = amt_org5 + wa_data-org_bdg.
               amt_supl5 = amt_supl5 + wa_data-supl_bdg.
               amt_send5 = amt_send5 + wa_data-send_bdg.
               amt_recv5 = amt_recv5 + wa_data-recv_bdg.
               amt_retn5 = amt_retn5 + wa_data-retn_bdg.
               amt_curr5 = amt_curr5 + wa_data-curr_bdg.
               amt_comt5 = amt_comt5 + wa_data-comittmnt.
               amt_actl5 = amt_actl5 + wa_data-act_cost.
               amt_assn5 = amt_assn5 + wa_data-assign_cost.
               amt_avbl5 = amt_avbl5 + wa_data-avbl_bdg.
              APPEND wa_data to it_data.
              clear : wa_data.

            ENDLOOP.

            ""Level 5 Data Append -
              wa_data = wa_level5.
              if  amt_org5 is NOT INITIAL.
              wa_data-org_bdg = amt_org5.
              ENDIF.

              if  amt_supl5 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl5.
              ENDIF.

              if  amt_send5 is NOT INITIAL.
              wa_data-send_bdg = amt_send5.
              ENDIF.

              if  amt_recv5 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv5.
              ENDIF.

              if  amt_retn5 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn5.
              ENDIF.

              clear amt_curr5.
              amt_curr5 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_curr5 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr5.
              ENDIF.

              if  amt_comt5 is NOT INITIAL.
              wa_data-comittmnt = amt_comt5.
              ENDIF.

              if  amt_actl5 is NOT INITIAL.
              wa_data-act_cost = amt_actl5.
              ENDIF.

              if  amt_assn5 is NOT INITIAL.
              wa_data-assign_cost = amt_assn5.
              ENDIF.

              if  amt_avbl5 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl5.
              ENDIF.


              CONCATENATE lv_cnt1 lv_cnt2 lv_cnt3 lv_cnt4 lv_cnt5 INTO wa_data-wbs_level SEPARATED BY '.' .
              CONDENSE wa_data-wbs_level.
              wa_data-level1 = 5.
              wa_data-main_wbs  = wa_level1-projectelement.

               amt_org4 = amt_org4 + wa_data-org_bdg.
               amt_supl4 = amt_supl4 + wa_data-supl_bdg.
               amt_send4 = amt_send4 + wa_data-send_bdg.
               amt_recv4 = amt_recv4 + wa_data-recv_bdg.
               amt_retn4 = amt_retn4 + wa_data-retn_bdg.
               amt_curr4 = amt_curr4 + wa_data-curr_bdg.
               amt_comt4 = amt_comt4 + wa_data-comittmnt.
               amt_actl4 = amt_actl4 + wa_data-act_cost.
               amt_assn4 = amt_assn4 + wa_data-assign_cost.
               amt_avbl4 = amt_avbl4 + wa_data-avbl_bdg.
              APPEND wa_data to it_data.
              clear : wa_data.

            ENDLOOP.

           ""Level 4 Data Append -
             wa_data = wa_level4.

              if amt_org4 is NOT INITIAL.
              wa_data-org_bdg = amt_org4.
              ENDIF.

              if  amt_supl4 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl4.
              ENDIF.

              if  amt_send4 is NOT INITIAL.
              wa_data-send_bdg = amt_send4.
              ENDIF.

              if  amt_recv4 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv4.
              ENDIF.

              if  amt_retn4 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn4.
              ENDIF.

              clear amt_curr4.
              amt_curr4 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_curr4 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr4.
              ENDIF.

              if  amt_comt4 is NOT INITIAL.
              wa_data-comittmnt = amt_comt4.
              ENDIF.

              if  amt_actl4 is NOT INITIAL.
              wa_data-act_cost = amt_actl4.
              ENDIF.

              if  amt_assn4 is NOT INITIAL.
              wa_data-assign_cost = amt_assn4.
              ENDIF.

              if  amt_avbl4 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl4.
              ENDIF.

             CONCATENATE lv_cnt1 lv_cnt2 lv_cnt3 lv_cnt4 INTO wa_data-wbs_level SEPARATED BY '.' .
             CONDENSE wa_data-wbs_level.
             wa_data-level1 = 4.
             wa_data-main_wbs  = wa_level1-projectelement.

             amt_org3  = amt_org3  + wa_data-org_bdg.
             amt_supl3 = amt_supl3 + wa_data-supl_bdg.
             amt_send3 = amt_send3 + wa_data-send_bdg.
             amt_recv3 = amt_recv3 + wa_data-recv_bdg.
             amt_retn3 = amt_retn3 + wa_data-retn_bdg.
             amt_curr3 = amt_curr3 + wa_data-curr_bdg.
             amt_comt3 = amt_comt3 + wa_data-comittmnt.
             amt_actl3 = amt_actl3 + wa_data-act_cost.
             amt_assn3 = amt_assn3 + wa_data-assign_cost.
             amt_avbl3 = amt_avbl3 + wa_data-avbl_bdg.

             APPEND wa_data to it_data.
             clear : wa_data.

           ENDLOOP.

          ""Level 3 Data Append -
            wa_data = wa_level3.

              if amt_org3 is NOT INITIAL.
              wa_data-org_bdg = amt_org3.
              ENDIF.

              if  amt_supl3 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl3.
              ENDIF.

              if  amt_send3 is NOT INITIAL.
              wa_data-send_bdg = amt_send3.
              ENDIF.

              if  amt_recv3 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv3.
              ENDIF.

              if  amt_retn3 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn3.
              ENDIF.

              clear amt_curr3.
              amt_curr3 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_curr3 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr3.
              ENDIF.

              if  amt_comt3 is NOT INITIAL.
              wa_data-comittmnt = amt_comt3.
              ENDIF.

              if  amt_actl3 is NOT INITIAL.
              wa_data-act_cost = amt_actl3.
              ENDIF.

              if  amt_assn3 is NOT INITIAL.
              wa_data-assign_cost = amt_assn3.
              ENDIF.

              if  amt_avbl3 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl3.
              ENDIF.

            CONCATENATE lv_cnt1 lv_cnt2 lv_cnt3 INTO wa_data-wbs_level SEPARATED BY '.' .
            CONDENSE wa_data-wbs_level.
            wa_data-level1 = 3.
            wa_data-main_wbs  = wa_level1-projectelement.

            amt_org2  = amt_org2  + wa_data-org_bdg.
            amt_supl2 = amt_supl2 + wa_data-supl_bdg.
            amt_send2 = amt_send2 + wa_data-send_bdg.
            amt_recv2 = amt_recv2 + wa_data-recv_bdg.
            amt_retn2 = amt_retn2 + wa_data-retn_bdg.
            amt_curr2 = amt_curr2 + wa_data-curr_bdg.
            amt_comt2 = amt_comt2 + wa_data-comittmnt.
            amt_actl2 = amt_actl2 + wa_data-act_cost.
            amt_assn2 = amt_assn2 + wa_data-assign_cost.
            amt_avbl2 = amt_avbl2 + wa_data-avbl_bdg.

            APPEND wa_data to it_data.
            clear : wa_data.

          ENDLOOP.

        ""Level 2 Data Append -
          wa_data = wa_level2.

              if amt_org2 is NOT INITIAL.
              wa_data-org_bdg = amt_org2.
              ENDIF.

              if  amt_supl2 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl2.
              ENDIF.

              if  amt_send2 is NOT INITIAL.
              wa_data-send_bdg = amt_send2.
              ENDIF.

              if  amt_recv2 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv2.
              ENDIF.

              if  amt_retn2 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn2.
              ENDIF.

              clear amt_curr2.
              amt_curr2 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_curr2 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr2.
              ENDIF.

              if  amt_comt2 is NOT INITIAL.
              wa_data-comittmnt = amt_comt2.
              ENDIF.

              if  amt_actl2 is NOT INITIAL.
              wa_data-act_cost = amt_actl2.
              ENDIF.

              if  amt_assn2 is NOT INITIAL.
              wa_data-assign_cost = amt_assn2.
              ENDIF.

              if  amt_avbl2 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl2.
              ENDIF.

          CONCATENATE lv_cnt1 lv_cnt2 INTO wa_data-wbs_level SEPARATED BY '.' .
          CONDENSE wa_data-wbs_level.
          wa_data-level1 = 2.
          wa_data-main_wbs  = wa_level1-projectelement.

          amt_org1  = amt_org1  + wa_data-org_bdg.
          amt_supl1 = amt_supl1 + wa_data-supl_bdg.
          amt_send1 = amt_send1 + wa_data-send_bdg.
          amt_recv1 = amt_recv1 + wa_data-recv_bdg.
          amt_retn1 = amt_retn1 + wa_data-retn_bdg.
          amt_curr1 = amt_curr1 + wa_data-curr_bdg.
          amt_comt1 = amt_comt1 + wa_data-comittmnt.
          amt_actl1 = amt_actl1 + wa_data-act_cost.
          amt_assn1 = amt_assn1 + wa_data-assign_cost.
          amt_avbl1 = amt_avbl1 + wa_data-avbl_bdg.

          APPEND wa_data to it_data.
          clear : wa_data.

        ENDLOOP.

       ""Level 1 Data Append -
           wa_data = wa_level1.

              if amt_org1 is NOT INITIAL.
              wa_data-org_bdg = amt_org1.
              ENDIF.

              if  amt_supl1 is NOT INITIAL.
              wa_data-supl_bdg = amt_supl1.
              ENDIF.

              if  amt_send1 is NOT INITIAL.
              wa_data-send_bdg = amt_send1.
              ENDIF.

              if  amt_recv1 is NOT INITIAL.
              wa_data-recv_bdg = amt_recv1.
              ENDIF.

              if  amt_retn1 is NOT INITIAL.
              wa_data-retn_bdg = amt_retn1.
              ENDIF.

              if  amt_curr1 is NOT INITIAL.
              wa_data-curr_bdg = amt_curr1.
              ENDIF.

              clear amt_curr1.
              amt_curr1 = wa_data-org_bdg + wa_data-supl_bdg + wa_data-send_bdg + wa_data-recv_bdg + wa_data-retn_bdg.

              if  amt_comt1 is NOT INITIAL.
              wa_data-comittmnt = amt_comt1.
              ENDIF.

              if  amt_actl1 is NOT INITIAL.
              wa_data-act_cost = amt_actl1.
              ENDIF.

              if  amt_assn1 is NOT INITIAL.
              wa_data-assign_cost = amt_assn1.
              ENDIF.

              if  amt_avbl1 is NOT INITIAL.
              wa_data-avbl_bdg = amt_avbl1.
              ENDIF.

        wa_data-wbs_level = lv_cnt1.
        wa_data-level1 = 1.
        wa_data-main_wbs  = wa_level1-projectelement.

        APPEND wa_data to it_data.
        clear : wa_data.

     ENDLOOP.

   sort it_data by main_wbs wbs_level p_wbs projectelement.


**      IF io_request->is_total_numb_of_rec_requested(  ).
        io_response->set_total_number_of_records( lines( it_data ) ).
**        io_response->set_total_number_of_records( lv_top ).
        io_response->set_data( it_data ).
**      ENDIF.

    ENDIF.
  ENDMETHOD.
ENDCLASS.
