CLASS lhc_zdprentry DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zdprentry RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zdprentry.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zdprentry.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zdprentry.

    METHODS read FOR READ
      IMPORTING keys FOR READ zdprentry RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zdprentry.

ENDCLASS.

CLASS lhc_zdprentry IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA : ls_dpr   TYPE zpst_scp_dpr_r1,
           ls_check TYPE zpst_scp_dpr_r1,
           wa_att type zdpr_attch,
           msg      TYPE string,
           l_from   TYPE string,
           l_to     TYPE string.

    DATA: w_prevqty TYPE zpst_scp_dpr_r1-zprev_qty.
    DATA:year  TYPE n LENGTH 4,
         month TYPE n LENGTH 2,
         day   TYPE n LENGTH 2.

    DATA: w_date TYPE c LENGTH 14.
    DATA lv_matnr TYPE matnr.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_dpr>).

      IF <ls_dpr>-flag = 'C'.
      select single from I_EnterpriseProject as a
             inner join I_EnterpriseProjectElement as b on ( b~ProjectInternalID = a~ProjectInternalID )
    FIELDS b~PlannedEndDate ,
           b~PlannedStartDate ,
           b~actualStartDate  ,
           b~actualFinishDate
where Project  = @<ls_dpr>-zproj_ext
into @data(prj_data)   .
        ls_dpr-projectenddate   = prj_data-PlannedEndDate.
        ls_dpr-projectstartdate = prj_data-PlannedStartDate.
        ls_dpr-actualStartDate  = prj_data-actualStartDate.
        ls_dpr-actualFinishDate = prj_data-actualFinishDate.
         ls_dpr-amt        = <ls_dpr>-amount.
        ls_dpr-subcontactor        = <ls_dpr>-subcontactor.
        ls_dpr-location        = <ls_dpr>-zlocation.

SELECT SINGLE FROM zpst_scp_dpr_r1
FIELDS
sum( zdpr_qty ) as zdpr_qty
WHERE zproj_ext = @<ls_dpr>-zproj_ext
AND posid = @<ls_dpr>-posid
and zdpr_date le @<ls_dpr>-zdpr_date
INTO @data(chek).

        IF <ls_dpr>-zboq_qty <=  chek .

        APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
                APPEND VALUE #( %key               = <ls_dpr>-%key
                                %state_area        = 'Validate record'
                                 %msg              = new_message_with_text(
                                                             text   = 'Cumu Qty exceed BOQ Qty' && | | && <ls_dpr>-posid
                                                             severity = if_abap_behv_message=>severity-error )
                              %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.
              ENDIF.
*            ENDIF.


*        IF <ls_dpr>-zlayer = 'Top' AND <ls_dpr>-zdpr_flg = 'Complete' .
*
*          SELECT * FROM zpst_scp_dpr_r1
*          WHERE posid = @<ls_dpr>-posid
*          AND zlayer = @<ls_dpr>-zlayer
*          AND zlocation = @<ls_dpr>-zlocation
*          AND zroads = @<ls_dpr>-zroads
*          INTO TABLE @DATA(lt_check).
*          IF  lt_check IS NOT INITIAL.
*
*            LOOP AT lt_check INTO ls_check .
*              IF ( <ls_dpr>-zchain_from BETWEEN ls_check-zchain_from AND ls_check-zchain_to )
*              OR ( <ls_dpr>-zchain_to BETWEEN ls_check-zchain_from AND ls_check-zchain_to ).
*                CLEAR: l_from, l_to, msg.
*
*                l_from = ls_check-zchain_from.
*                l_to = ls_check-zchain_to.
*                CONCATENATE 'Chainage value for WBS' ls_check-posid 'is already saved between the range of' l_from '&' l_to INTO msg SEPARATED BY space.
*
*                APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
*                APPEND VALUE #( %key               = <ls_dpr>-%key
*                                %state_area        = 'VALIDATE_CHAINAGE'
*                                 %msg              = new_message_with_text(
*                                                             text   = msg
*                                                             severity = if_abap_behv_message=>severity-error )
*                              %element-zchain_to = if_abap_behv=>mk-on ) TO reported-zdprentry.
*
*              ENDIF.
*
*
*            ENDLOOP.
*
*          ENDIF.
*        ENDIF.

      ELSEIF <ls_dpr>-flag = 'S'.

        IF  <ls_dpr>-zpspnr IS INITIAL.

          SELECT SINGLE projectinternalid FROM zps_wbs_int_ext WHERE project =  @<ls_dpr>-zproj_ext INTO @DATA(l_proj_int).

          SELECT MAX( zdpr_no ) FROM zpst_scp_dpr_r1 WHERE zpspnr = @l_proj_int INTO @DATA(lv_count1) .
          IF lv_count1 IS INITIAL.
            ls_dpr-zdpr_no = '0000000001'.
          ELSE.
            ls_dpr-zdpr_no = lv_count1 + 1.
          ENDIF.

          ls_dpr-zpspnr    = l_proj_int.

        ELSE.
          SELECT MAX( zdpr_no ) FROM zpst_scp_dpr_r1 WHERE zpspnr = @<ls_dpr>-zpspnr INTO @DATA(lv_count) .
          IF lv_count IS INITIAL.
            ls_dpr-zdpr_no = '0000000001'.
          ELSE.
            ls_dpr-zdpr_no = lv_count + 1.
          ENDIF.
          ls_dpr-zpspnr    = <ls_dpr>-zpspnr.
        ENDIF.

        SELECT SINGLE zpspnr ,responsible_eng, zboq_version , posid , zboq_head_no , zboq_item_no , zboq_head_desc, zboq_item_desc,
        zboq_qty , zunit FROM zpst_boq_mast2
          WHERE posid EQ @<ls_dpr>-posid INTO @DATA(wa_boq).

        ls_dpr-zdpr_date = <ls_dpr>-zdpr_date.
        ls_dpr-posid     = <ls_dpr>-posid.
        ls_dpr-zboq_head_no = <ls_dpr>-zboq_head_no.
        ls_dpr-zboq_item_no = <ls_dpr>-zboq_item_no.
        IF <ls_dpr>-zboq_head_desc IS NOT INITIAL.
          ls_dpr-zboq_head_desc = <ls_dpr>-zboq_head_desc.
        ELSE.
          ls_dpr-zboq_head_desc = wa_boq-zboq_head_desc.
        ENDIF.

        IF <ls_dpr>-zboq_item_desc IS NOT INITIAL.
          ls_dpr-zboq_item_desc = <ls_dpr>-zboq_item_desc.
        ELSE.
          ls_dpr-zboq_item_desc = wa_boq-zboq_item_desc.
        ENDIF.
        IF <ls_dpr>-zboq_qty IS NOT INITIAL.
          ls_dpr-zboq_qty       = <ls_dpr>-zboq_qty.
        ELSE.
          ls_dpr-zboq_qty       = wa_boq-zboq_qty.
        ENDIF.
        IF <ls_dpr>-zunit IS NOT INITIAL.
          ls_dpr-meins          = <ls_dpr>-zunit.
        ELSE.
          ls_dpr-meins          = wa_boq-zunit.
        ENDIF.
        IF <ls_dpr>-zunit IS NOT INITIAL.
          ls_dpr-zuom          = <ls_dpr>-zunit.
        ELSE.
          ls_dpr-zuom         = wa_boq-zunit.
        ENDIF.
        ls_dpr-zdpr_boq       = <ls_dpr>-zdpr_boq.
        ls_dpr-zsubcontract   = <ls_dpr>-zsubcontract.
        ls_dpr-zsubmitted_no  = <ls_dpr>-zsubmitted_no.
        ls_dpr-zsubmitted_len = <ls_dpr>-zsubmitted_len.
        ls_dpr-zsubmitted_bre = <ls_dpr>-zsubmitted_bre.
        ls_dpr-zsubmitted_hei = <ls_dpr>-zsubmitted_hei.

          if <ls_dpr>-responsible_eng is not initial.
         ls_dpr-responsible_eng  = <ls_dpr>-responsible_eng.
         else.
         ls_dpr-responsible_eng  = wa_boq-responsible_eng.
          endif.
*      SELECT MAX( zdpr_no )
*       FROM zpst_scp_dpr_r1
*      WHERE zpspnr = @ls_dpr-zpspnr
*      AND   zboq_head_no = @ls_dpr-zboq_head_no
*      AND   zboq_item_no = @ls_dpr-zboq_item_no
*      INTO @DATA(lv_dprno).

*      IF lv_dprno EQ '0000000000'.
*        ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.
*      ELSEIF lv_dprno NE '0000000000'.
*        ls_dpr-zprev_qty      = <ls_dpr>-zcuml_qty - <ls_dpr>-ztod_qty.
*      ENDIF.

        ls_dpr-ztod_qty       = <ls_dpr>-ztod_qty.
        ls_dpr-zcuml_qty      = <ls_dpr>-zcuml_qty.
        ls_dpr-menge          = <ls_dpr>-ztod_qty.
        ls_dpr-zresource_utl  = <ls_dpr>-zresource_utl.
        ls_dpr-zremark        = <ls_dpr>-zremark.
        ls_dpr-amt        = <ls_dpr>-amount.
        ls_dpr-subcontactor        = <ls_dpr>-subcontactor.
        ls_dpr-location        = <ls_dpr>-zlocation.
*        ls_dpr-zappr_status   = <ls_dpr>-zappr_status.
        ls_dpr-zproj_ext      = <ls_dpr>-zproj_ext.
        ls_dpr-created_by     = sy-uname.
        ls_dpr-created_at     = | { sy-uzeit } | && | { sy-datum  } |.
        ls_dpr-last_changed_by = sy-uname.
        ls_dpr-last_changed_at = | { sy-uzeit } | && | { sy-datum  } |.
        ls_dpr-zdpr_from       = <ls_dpr>-zdpr_date.
        ls_dpr-zdpr_to       = <ls_dpr>-zdpr_date.
        day = ls_dpr-zdpr_to+0(2).
        month = ls_dpr-zdpr_to+3(2).
        year = ls_dpr-zdpr_to+6(4).
        w_date = |{ year }| && |{ month }| && |{ day }|.
        CONDENSE w_date NO-GAPS.
        ls_dpr-zdate = w_date.
     """"""""""""""""""""""""""""""""""""sandeep
        ls_dpr-zdms = <ls_dpr>-zdms.
        ls_dpr-zfile = <ls_dpr>-zfile.
        ls_dpr-zfilename = <ls_dpr>-zfilename.
        ls_dpr-zmimetype = <ls_dpr>-zmimetype.
*        wa_att-posid = <ls_dpr>-posid.
*        wa_att-zdpr_no = <ls_dpr>-zdpr_no.

    """""""""""""""""""""""


        IF ls_dpr-zsubcontract = 'Y'.
          lv_matnr = |00000000| && <ls_dpr>-zmat.

          SELECT SINGLE purchaseorder , PurchaseOrderItem,  Material ,purchaseorderitemtext,
          orderquantity, netpriceamount , netamount, baseunit FROM  i_purchaseorderitemapi01
          WHERE purchaseorder EQ @<ls_dpr>-zwo_no AND Material EQ @lv_matnr AND purchasingdocumentdeletioncode EQ ''
          AND PurchaseOrderItem EQ @<ls_dpr>-zwo_item INTO @DATA(lv_wo).

          SELECT SINGLE ProjectElement , zwo_no , zwo_name , zwo_qty, PurchaseOrderQuantityUnit FROM  zps_dpr_entry_wono
          WHERE ProjectElement EQ @<ls_dpr>-posid AND zwo_no EQ @<ls_dpr>-zwo_no
          INTO @DATA(lv_ZPS_DPR_ENTRY_WONO).

          IF <ls_dpr>-zwo_no IS NOT INITIAL.
            ls_dpr-zwo_no = <ls_dpr>-zwo_no.
          ELSE.
            ls_dpr-zwo_no = lv_wo-purchaseorder.
          ENDIF.

          IF <ls_dpr>-zwo_item IS NOT INITIAL.
            ls_dpr-zwo_item = <ls_dpr>-zwo_item.
          ELSE.
            ls_dpr-zwo_item = <ls_dpr>-zwo_item.
          ENDIF.

          IF  <ls_dpr>-zwo_name IS NOT INITIAL.
            ls_dpr-zwo_name = <ls_dpr>-zwo_name.
          ELSE.
            ls_dpr-zwo_name = lv_ZPS_DPR_ENTRY_WONO-zwo_name.   "subcontract name
          ENDIF.

          IF <ls_dpr>-zwo_qty IS NOT INITIAL.
            ls_dpr-zwo_qty = <ls_dpr>-zwo_qty.
          ELSE.
            ls_dpr-zwo_qty = lv_wo-orderquantity.    "Service Qty
          ENDIF.

          IF <ls_dpr>-zwo_unit IS NOT INITIAL.
            ls_dpr-zwo_unit = <ls_dpr>-zwo_unit.
          ELSE.
            ls_dpr-zwo_unit = lv_wo-baseunit.
          ENDIF.
          ls_dpr-zmat    = <ls_dpr>-zmat.
          IF <ls_dpr>-zmat_desc IS NOT INITIAL.
            ls_dpr-zmat_desc = <ls_dpr>-zmat_desc.
          ELSE.
            ls_dpr-zmat_desc = lv_wo-purchaseorderitemtext.  "service desc
          ENDIF.

          IF <ls_dpr>-zwo_rate IS NOT INITIAL.
            ls_dpr-zwo_rate  = <ls_dpr>-zwo_rate.
          ELSE.
            ls_dpr-zwo_rate  = lv_wo-netpriceamount. "Service rate
          ENDIF.

          IF <ls_dpr>-zwo_amt IS NOT INITIAL.
            ls_dpr-zwo_amt   = <ls_dpr>-zwo_amt.
          ELSE.
            ls_dpr-zwo_amt   = lv_wo-netamount.  "Service amount
          ENDIF.
*        ELSEIF ls_dpr-zsubcontract = 'Subcontract'.

*          ls_dpr-zwo_no = lv_wo-PURCHASEORDER.
*          ls_dpr-zwo_item = <ls_dpr>-zwo_item.
*          ls_dpr-zwo_name = lv_ZPS_DPR_ENTRY_WONO-zwo_name.   "subcontract name
*          ls_dpr-zwo_qty = lv_wo-ORDERQUANTITY.    "Service Qty
*          ls_dpr-zwo_unit = lv_wo-BASEUNIT.
*          ls_dpr-zmat    = <ls_dpr>-zmat.
*          ls_dpr-zmat_desc = lv_wo-PURCHASEORDERITEMTEXT.  "service desc
*          ls_dpr-zwo_rate  = lv_wo-NETPRICEAMOUNT. "Service rate
*          ls_dpr-zwo_amt   = lv_wo-NETAMOUNT.  "Service amount

        ENDIF.
        ls_dpr-ztype_work       = <ls_dpr>-ztype_work.
        ls_dpr-zchain_from       = <ls_dpr>-zchain_from.
        ls_dpr-zchain_to       = <ls_dpr>-zchain_to.
        ls_dpr-zroads       = <ls_dpr>-zroads.
        ls_dpr-zlocation       = <ls_dpr>-zlocation.
        ls_dpr-zsource_loc       = <ls_dpr>-zsource_loc.
        ls_dpr-zlayer       = <ls_dpr>-zlayer.
        ls_dpr-zdpr_qty       = <ls_dpr>-zdpr_qty.
        ls_dpr-zdpr_flg       = <ls_dpr>-zdpr_flg.
        ls_dpr-zarea       = <ls_dpr>-zarea.

clear : prj_data.

      select single from I_EnterpriseProject as a
             inner join I_EnterpriseProjectElement as b on ( b~ProjectInternalID = a~ProjectInternalID )
    FIELDS b~PlannedEndDate ,
           b~PlannedStartDate ,
           b~actualStartDate  ,
           b~actualFinishDate
where Project  = @<ls_dpr>-zproj_ext
into @prj_data   .
        ls_dpr-projectenddate   = prj_data-PlannedEndDate.
        ls_dpr-projectstartdate = prj_data-PlannedStartDate.
        ls_dpr-actualStartDate  = prj_data-actualStartDate.
        ls_dpr-actualFinishDate = prj_data-actualFinishDate.

*        ls_dpr-responsible_eng  = <ls_dpr>-responsible_eng.
**********************************************************************
        "added on 18.07.2023 for Previously Executed Quantity should be shown according to the
        "selected Sub-contractor

**        SELECT zdpr_no,
**               zproj_ext,
**               posid,
**               zwo_no,
**               zdpr_qty FROM  zpst_scp_dpr_r1
**               WHERE zproj_ext = @ls_dpr-zproj_ext
**               AND posid = @ls_dpr-posid
***            AND zwo_no = @ls_dpr-zwo_no
**               INTO TABLE @DATA(lt_prevqty).
**
**        SORT lt_prevqty BY zdpr_no ASCENDING.
**        LOOP AT lt_prevqty INTO DATA(wa_prevqty).
**          IF wa_prevqty-zdpr_no EQ '0000000000'.
**            ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.
**          ELSEIF wa_prevqty-zdpr_no NE '0000000000'.
**            ls_dpr-zprev_qty = ls_dpr-zprev_qty + wa_prevqty-zdpr_qty.
**          ENDIF.
**          CLEAR:wa_prevqty.
**        ENDLOOP.

        ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.

**********************************************************************
        IF  ls_dpr-zdpr_no IS NOT INITIAL AND ls_dpr-zpspnr IS NOT INITIAL
       AND ls_dpr-posid IS NOT INITIAL.
**          IF ls_dpr-zdpr_qty GT '0.000'.
          MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
**          ENDIF.
        ENDIF.
        CLEAR:ls_dpr,w_prevqty,day,month,year,w_date. ", lv_prevqty ,lv_dprno.
*ELSEIF <ls_dpr>-flag = 'U'.
*
*  SELECT SINGLE zpspnr , zboq_version , posid , zboq_head_no , zboq_item_no FROM zpst_boq_mast2
*  WHERE posid EQ @<ls_dpr>-posid INTO @DATA(WA_BOQ).
*  IF SY-SUBRC EQ 0.
*    IF <ls_dpr>-zboq_head_no NE WA_BOQ-zboq_head_no or <ls_dpr>-zboq_item_no NE WA_BOQ-zboq_item_no .
*****eroor
*           new_message(
*  id = 'ZPS_DPR'
*  number = '001'
*  severity = if_abap_behv_message=>severity-error
*  v1 = 'WBS'
*) .
*
*    else.
*       if <ls_dpr>-ztype_work eq 'Subcontract'.
*         SELECT SINGLE zwo , zwo_item, zmat from  zps_dpr_service
*         WHERE zwo eq @<ls_dpr>-zwo_no and zwo_item eq @<ls_dpr>-zwo_item
*         INTO @DATA(wa_wo).
*          if sy-subrc ne 0.
***************** error
*
*          else.
****************modify
*             MOVE-CORRESPONDING <ls_dpr> to ls_dpr.
*             MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
*          endif.
*       ELSEIF  <ls_dpr>-ztype_work eq 'Department'.
****************modify
*             MOVE-CORRESPONDING <ls_dpr> to ls_dpr.
*             MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
*       ENDIF.
*    ENDIF.
*  ELSE.
****error
*  ENDIF.


*   ZPS_DPR_PROJ_WONO
*   zps_dpr_service

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.

    DATA : ls_dpr   TYPE zpst_scp_dpr_r1,
           ls_check TYPE zpst_scp_dpr_r1,
           msg      TYPE string,
           l_from   TYPE string,
           l_to     TYPE string.

    DATA: w_prevqty TYPE zpst_scp_dpr_r1-zprev_qty.
    DATA:year  TYPE n LENGTH 4,
         month TYPE n LENGTH 2,
         day   TYPE n LENGTH 2.

    DATA: w_date TYPE c LENGTH 14.
    DATA lv_matnr TYPE matnr.

    DATA: lw_dpr TYPE zpst_scp_dpr_r1.

    READ TABLE entities INTO DATA(lw_ent)
     WITH KEY  zappr_status = 'DELETE'.
    IF sy-subrc IS INITIAL.
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_del>).
        SELECT SINGLE *
          FROM zpst_scp_dpr_r1
         WHERE zdpr_no = @<fs_del>-zdpr_no
           AND zpspnr  = @<fs_del>-zpspnr
          INTO @lw_dpr.
        lw_dpr-zappr_status = 'DELETE'.
        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.
      ENDLOOP.
    ELSE.
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_dpr>).
        IF <ls_dpr>-flag = 'C'.

          ls_dpr-zdpr_no   = <ls_dpr>-zdpr_no.
          ls_dpr-zdpr_date = <ls_dpr>-zdpr_date.
          ls_dpr-zpspnr    = <ls_dpr>-zpspnr.
          ls_dpr-posid     = <ls_dpr>-posid.
          ls_dpr-zboq_head_no = <ls_dpr>-zboq_head_no.
          ls_dpr-zboq_item_no = <ls_dpr>-zboq_item_no.
          ls_dpr-zboq_head_desc = <ls_dpr>-zboq_head_desc.
          ls_dpr-zboq_item_desc = <ls_dpr>-zboq_item_desc.
          ls_dpr-zboq_qty       = <ls_dpr>-zboq_qty.
          ls_dpr-meins          = <ls_dpr>-zunit.
          ls_dpr-zuom           = <ls_dpr>-zunit.
          ls_dpr-zdpr_boq       = <ls_dpr>-zdpr_boq.
          ls_dpr-zsubcontract   = <ls_dpr>-zsubcontract.
          ls_dpr-zsubmitted_no  = <ls_dpr>-zsubmitted_no.
          ls_dpr-zsubmitted_len = <ls_dpr>-zsubmitted_len.
          ls_dpr-zsubmitted_bre = <ls_dpr>-zsubmitted_bre.
          ls_dpr-zsubmitted_hei = <ls_dpr>-zsubmitted_hei.
          ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.
          ls_dpr-ztod_qty       = <ls_dpr>-ztod_qty.
          ls_dpr-zcuml_qty      = <ls_dpr>-zcuml_qty.
          ls_dpr-zresource_utl  = <ls_dpr>-zresource_utl.
          ls_dpr-zremark        = <ls_dpr>-zremark.
           ls_dpr-amt        = <ls_dpr>-amount.
        ls_dpr-subcontactor        = <ls_dpr>-subcontactor.
 ls_dpr-location        = <ls_dpr>-zlocation.
          ls_dpr-zproj_ext      = <ls_dpr>-zproj_ext.
          ls_dpr-created_by     = sy-uname.
          ls_dpr-created_at     = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-last_changed_by = sy-uname.
          ls_dpr-last_changed_at = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-zdpr_from       = <ls_dpr>-zdpr_date.
          ls_dpr-zdpr_to       = <ls_dpr>-zdpr_date.
          ls_dpr-zarea       = <ls_dpr>-zarea.
          day = ls_dpr-zdpr_to+0(2).
          month = ls_dpr-zdpr_to+3(2).
          year = ls_dpr-zdpr_to+6(4).
          w_date = |{ year }| && |{ month }| && |{ day }|.
          CONDENSE w_date NO-GAPS.
          ls_dpr-zdate = w_date.

          ls_dpr-ztype_work        = <ls_dpr>-ztype_work.
          ls_dpr-zchain_from       = <ls_dpr>-zchain_from.
          ls_dpr-zchain_to         = <ls_dpr>-zchain_to.
          ls_dpr-zroads            = <ls_dpr>-zroads.
          ls_dpr-zlocation         = <ls_dpr>-zlocation.
          ls_dpr-zsource_loc       = <ls_dpr>-zsource_loc.
          ls_dpr-zlayer            = <ls_dpr>-zlayer.
          ls_dpr-zdpr_qty          = <ls_dpr>-zdpr_qty.
          ls_dpr-zdpr_flg          = <ls_dpr>-zdpr_flg.
**        IF ls_dpr-zsubcontract = 'Subcontract'.
**          SELECT SINGLE zwo_no,zwo_name,zwo_qty
**          FROM zpst_scp_dpr_r1
**          WHERE zdpr_no = @ls_dpr-zdpr_no
**          INTO @DATA(wa_wo).
          ls_dpr-zwo_no     = <ls_dpr>-zwo_no.
          ls_dpr-zwo_item   = <ls_dpr>-zwo_item.
          ls_dpr-zwo_name   = <ls_dpr>-zwo_name.
          ls_dpr-zwo_qty    = <ls_dpr>-zwo_qty.
          ls_dpr-zwo_unit   = <ls_dpr>-zwo_unit.
          ls_dpr-zmat       = <ls_dpr>-zmat.
          ls_dpr-zmat_desc  = <ls_dpr>-zmat_desc.
          ls_dpr-zwo_rate   = <ls_dpr>-zwo_rate.
          ls_dpr-zwo_amt    = <ls_dpr>-zwo_amt.
               """"""""""""""""""""""""""""""""""""sandeep
        ls_dpr-zdms = <ls_dpr>-zdms.
        ls_dpr-zfile = <ls_dpr>-zfile.
        ls_dpr-zfilename = <ls_dpr>-zfilename.
        ls_dpr-zmimetype = <ls_dpr>-zmimetype.
*        wa_att-posid = <ls_dpr>-posid.
*        wa_att-zdpr_no = <ls_dpr>-zdpr_no.

**        ENDIF.
          IF  ls_dpr-zdpr_no IS NOT INITIAL AND ls_dpr-zpspnr IS NOT INITIAL
               AND ls_dpr-posid IS NOT INITIAL.
*        IF ls_dpr-zdpr_qty GT '0.000'.
            MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
*        ENDIF.
          ENDIF.
          CLEAR:ls_dpr,day,month,year,w_date.

**        IF <ls_dpr>-zlayer = 'Top' AND <ls_dpr>-zdpr_flg = 'Complete' .
**
**          SELECT * FROM zpst_scp_dpr_r1
**          WHERE posid = @<ls_dpr>-posid
**          AND zlayer = @<ls_dpr>-zlayer
**          AND zdpr_no NE @<ls_dpr>-zdpr_no
**                    AND zlocation = @<ls_dpr>-zlocation
**          AND zroads = @<ls_dpr>-zroads
**          INTO TABLE @DATA(lt_check).
**          IF  lt_check IS NOT INITIAL.
**
**            LOOP AT lt_check INTO ls_check .
**              IF ( <ls_dpr>-zchain_from BETWEEN ls_check-zchain_from AND ls_check-zchain_to )
**              OR ( <ls_dpr>-zchain_to BETWEEN ls_check-zchain_from AND ls_check-zchain_to ).
**                CLEAR: l_from, l_to, msg.
**
**                l_from = ls_check-zchain_from.
**                l_to = ls_check-zchain_to.
**                CONCATENATE 'Chainage value for WBS' ls_check-posid 'is already saved between the range of' l_from '&' l_to INTO msg SEPARATED BY space.
**
**                APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
**                APPEND VALUE #( %key               = <ls_dpr>-%key
**                                %state_area        = 'VALIDATE_CHAINAGE'
**                                 %msg              = new_message_with_text(
**                                                             text   = msg
**                                                             severity = if_abap_behv_message=>severity-error )
**                              %element-zchain_to = if_abap_behv=>mk-on ) TO reported-zdprentry.
**
**              ENDIF.
**            ENDLOOP.
**
**          ENDIF.
**        ENDIF.
        ELSEIF <ls_dpr>-flag = 'S'.
          ls_dpr-zdpr_no   = <ls_dpr>-zdpr_no.
          ls_dpr-zdpr_date = <ls_dpr>-zdpr_date.
          ls_dpr-zpspnr    = <ls_dpr>-zpspnr.
          ls_dpr-posid     = <ls_dpr>-posid.
          ls_dpr-zboq_head_no = <ls_dpr>-zboq_head_no.
          ls_dpr-zboq_item_no = <ls_dpr>-zboq_item_no.
          ls_dpr-zboq_head_desc = <ls_dpr>-zboq_head_desc.
          ls_dpr-zboq_item_desc = <ls_dpr>-zboq_item_desc.
          ls_dpr-zboq_qty       = <ls_dpr>-zboq_qty.
          ls_dpr-meins          = <ls_dpr>-zunit.
          ls_dpr-zuom           = <ls_dpr>-zunit.
          ls_dpr-zdpr_boq       = <ls_dpr>-zdpr_boq.
          ls_dpr-zsubcontract   = <ls_dpr>-zsubcontract.
          ls_dpr-zsubmitted_no  = <ls_dpr>-zsubmitted_no.
          ls_dpr-zsubmitted_len = <ls_dpr>-zsubmitted_len.
          ls_dpr-zsubmitted_bre = <ls_dpr>-zsubmitted_bre.
          ls_dpr-zsubmitted_hei = <ls_dpr>-zsubmitted_hei.
          ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.
          ls_dpr-ztod_qty       = <ls_dpr>-ztod_qty.
          ls_dpr-zcuml_qty      = <ls_dpr>-zcuml_qty.
          ls_dpr-zresource_utl  = <ls_dpr>-zresource_utl.
          ls_dpr-zremark        = <ls_dpr>-zremark.
           ls_dpr-amt        = <ls_dpr>-amount.
        ls_dpr-subcontactor        = <ls_dpr>-subcontactor.
*        ls_dpr-zappr_status   = <ls_dpr>-zappr_status.
          ls_dpr-zproj_ext      = <ls_dpr>-zproj_ext.
          ls_dpr-created_by     = sy-uname.
          ls_dpr-created_at     = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-last_changed_by = sy-uname.
          ls_dpr-last_changed_at = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-zdpr_from       = <ls_dpr>-zdpr_date.
          ls_dpr-zdpr_to       = <ls_dpr>-zdpr_date.
          ls_dpr-zarea       = <ls_dpr>-zarea.
          day = ls_dpr-zdpr_to+0(2).
          month = ls_dpr-zdpr_to+3(2).
          year = ls_dpr-zdpr_to+6(4).
          w_date = |{ year }| && |{ month }| && |{ day }|.
          CONDENSE w_date NO-GAPS.
          ls_dpr-zdate = w_date.

          ls_dpr-ztype_work       = <ls_dpr>-ztype_work.
          ls_dpr-zchain_from       = <ls_dpr>-zchain_from.
          ls_dpr-zchain_to       = <ls_dpr>-zchain_to.
          ls_dpr-zroads       = <ls_dpr>-zroads.
          ls_dpr-zlocation       = <ls_dpr>-zlocation.
          ls_dpr-zsource_loc       = <ls_dpr>-zsource_loc.
          ls_dpr-zlayer       = <ls_dpr>-zlayer.
          ls_dpr-zdpr_qty       = <ls_dpr>-zdpr_qty.
          ls_dpr-zdpr_flg       = <ls_dpr>-zdpr_flg.
**        IF ls_dpr-zsubcontract = 'Subcontract'.
**          SELECT SINGLE zwo_no,zwo_name,zwo_qty
**          FROM zpst_scp_dpr_r1
**          WHERE zdpr_no = @ls_dpr-zdpr_no
**          INTO @DATA(wa_wo).
          ls_dpr-zwo_no = <ls_dpr>-zwo_no.
          ls_dpr-zwo_item = <ls_dpr>-zwo_item.
          ls_dpr-zwo_name = <ls_dpr>-zwo_name.
          ls_dpr-zwo_qty = <ls_dpr>-zwo_qty.
          ls_dpr-zwo_unit = <ls_dpr>-zwo_unit.
          ls_dpr-zmat    = <ls_dpr>-zmat.
          ls_dpr-zmat_desc = <ls_dpr>-zmat_desc.
           ls_dpr-location        = <ls_dpr>-location.
          ls_dpr-zwo_rate  = <ls_dpr>-zwo_rate.
          ls_dpr-zwo_amt   = <ls_dpr>-zwo_amt.
**        ENDIF.
          IF  ls_dpr-zdpr_no IS NOT INITIAL AND ls_dpr-zpspnr IS NOT INITIAL
               AND ls_dpr-posid IS NOT INITIAL.
*        IF ls_dpr-zdpr_qty GT '0.000'.
            MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
*        ENDIF.
          ENDIF.
          CLEAR:ls_dpr,day,month,year,w_date.

** For deleting lines from table

        ELSEIF <ls_dpr>-flag = 'D'.

          ls_dpr-zdpr_no   = <ls_dpr>-zdpr_no.
          ls_dpr-zdpr_date = <ls_dpr>-zdpr_date.
          ls_dpr-zpspnr    = <ls_dpr>-zpspnr.
          ls_dpr-posid     = <ls_dpr>-posid.
          ls_dpr-zboq_head_no = <ls_dpr>-zboq_head_no.
          ls_dpr-zboq_item_no = <ls_dpr>-zboq_item_no.
          ls_dpr-zboq_head_desc = <ls_dpr>-zboq_head_desc.
          ls_dpr-zboq_item_desc = <ls_dpr>-zboq_item_desc.
          ls_dpr-zboq_qty       = <ls_dpr>-zboq_qty.
          ls_dpr-meins          = <ls_dpr>-zunit.
          ls_dpr-zuom           = <ls_dpr>-zunit.
          ls_dpr-zsubcontract   = <ls_dpr>-zsubcontract.
          ls_dpr-zsubmitted_no  = <ls_dpr>-zsubmitted_no.
          ls_dpr-zsubmitted_len = <ls_dpr>-zsubmitted_len.
          ls_dpr-zsubmitted_bre = <ls_dpr>-zsubmitted_bre.
          ls_dpr-zsubmitted_hei = <ls_dpr>-zsubmitted_hei.
          ls_dpr-zprev_qty      = <ls_dpr>-zprev_qty.
          ls_dpr-ztod_qty       = <ls_dpr>-ztod_qty.
          ls_dpr-zcuml_qty      = <ls_dpr>-zcuml_qty.
          ls_dpr-zresource_utl  = <ls_dpr>-zresource_utl.
          ls_dpr-zremark        = <ls_dpr>-zremark.
           ls_dpr-amt        = <ls_dpr>-amount.
          ls_dpr-subcontactor        = <ls_dpr>-subcontactor.
*        ls_dpr-zappr_status   = <ls_dpr>-zappr_status.
          ls_dpr-zproj_ext      = <ls_dpr>-zproj_ext.
          ls_dpr-created_by     = sy-uname.
          ls_dpr-created_at     = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-last_changed_by = sy-uname.
          ls_dpr-last_changed_at = | { sy-uzeit } | && | { sy-datum  } |.
          ls_dpr-zdpr_from       = <ls_dpr>-zdpr_date.
          ls_dpr-zdpr_to       = <ls_dpr>-zdpr_date.
          day = ls_dpr-zdpr_to+0(2).
          month = ls_dpr-zdpr_to+3(2).
          year = ls_dpr-zdpr_to+6(4).
          w_date = |{ year }| && |{ month }| && |{ day }|.
          CONDENSE w_date NO-GAPS.
          ls_dpr-zdate = w_date.

          ls_dpr-ztype_work       = <ls_dpr>-ztype_work.
          ls_dpr-zchain_from       = <ls_dpr>-zchain_from.
          ls_dpr-zchain_to       = <ls_dpr>-zchain_to.
          ls_dpr-zroads       = <ls_dpr>-zroads.
          ls_dpr-zlocation       = <ls_dpr>-zlocation.
          ls_dpr-zsource_loc       = <ls_dpr>-zsource_loc.
          ls_dpr-zlayer       = <ls_dpr>-zlayer.
          ls_dpr-zdpr_qty       = <ls_dpr>-zdpr_qty.
          ls_dpr-zdpr_flg       = <ls_dpr>-zdpr_flg.
               """"""""""""""""""""""""""""""""""""sandeep
        ls_dpr-zdms = <ls_dpr>-zdms.
        ls_dpr-zfile = <ls_dpr>-zfile.
        ls_dpr-zfilename = <ls_dpr>-zfilename.
        ls_dpr-zmimetype = <ls_dpr>-zmimetype.
*        wa_att-posid = <ls_dpr>-posid.
*        wa_att-zdpr_no = <ls_dpr>-zdpr_no.

          DELETE zpst_scp_dpr_r1 FROM @ls_dpr.


**        DELETE from  zpst_scp_dpr_r1 WHERE zproj_ext = 'H/AP02' .

        ELSEIF <ls_dpr>-flag = 'U'.

          SELECT SINGLE zpspnr , zboq_version , posid , zboq_head_no , zboq_item_no FROM zpst_boq_mast2
          WHERE posid EQ @<ls_dpr>-posid INTO @DATA(wa_boq).
          IF sy-subrc EQ 0.
            IF <ls_dpr>-zboq_head_no NE wa_boq-zboq_head_no OR <ls_dpr>-zboq_item_no NE wa_boq-zboq_item_no .
****eroor
              APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
              APPEND VALUE #( %key               = <ls_dpr>-%key
                              %state_area        = 'Validate record'
                               %msg              = new_message_with_text(
                                                           text   = 'Incorrect BOQ Header or item' && | | && <ls_dpr>-posid
                                                           severity = if_abap_behv_message=>severity-error )
                            %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.

            ELSE.
              DATA : lv_drp_date TYPE sy-datum.
              lv_drp_date = <ls_dpr>-zdpr_date+6(4) &&  <ls_dpr>-zdpr_date+3(2) && <ls_dpr>-zdpr_date+0(2).
              IF lv_drp_date <= sy-datum.
                IF <ls_dpr>-zsubcontract EQ 'Y'.
*         SELECT SINGLE zwo , zwo_item, zmat from  zps_dpr_service
*         WHERE zwo eq @<ls_dpr>-zwo_no "and zwo_item eq @<ls_dpr>-zwo_item
*         INTO @DATA(wa_wo).

*         SELECT SINGLE WBSElementInternalID from  I_EnterpriseProjectElement WHERE ProjectElement eq @<ls_dpr>-posid
*         INTO @data(lv_internalid).
**         SELECT SINGLE projectinternalid FROM zps_wbs_int_ext WHERE project =  @<ls_dpr>-zproj_ext INTO @DATA(l_proj_int).
**  SELECT PurchaseOrder from ZPS_DPR_PROJ_WONO( proj = @<ls_dpr>-zproj_ext ) WHERE PurchaseOrder eq @<ls_dpr>-zwo_no
**  INTO TABLE @data(it_po).
                  lv_matnr = |00000000| && <ls_dpr>-zmat.

                  SELECT SINGLE purchaseorder , PurchaseOrderItem,  Material ,purchaseorderitemtext,
                  orderquantity, netpriceamount , netamount, baseunit FROM  i_purchaseorderitemapi01
                  WHERE purchaseorder EQ @<ls_dpr>-zwo_no AND Material EQ @lv_matnr AND purchasingdocumentdeletioncode EQ '' INTO @DATA(lv_wo).

                  IF sy-subrc NE 0.
**************** error
                    APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
                    APPEND VALUE #( %key               = <ls_dpr>-%key
                                    %state_area        = 'Validate record'
                                     %msg              = new_message_with_text(
                                                                 text   = 'Incorrect WO or Service No.' && | | && <ls_dpr>-posid
                                                                 severity = if_abap_behv_message=>severity-error )
                                  %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.

                  ELSE ."if <ls_dpr>-zwo_item ne lv_wo-PurchaseOrderItem .
                    SELECT SINGLE purchaseorder , PurchaseOrderItem,  Material ,purchaseorderitemtext,
                 orderquantity, netpriceamount , netamount, baseunit FROM  i_purchaseorderitemapi01
                 WHERE purchaseorder EQ @<ls_dpr>-zwo_no AND Material EQ @lv_matnr AND PurchaseOrderItem EQ @<ls_dpr>-zwo_item
                 AND  purchasingdocumentdeletioncode EQ '' INTO @lv_wo.
                    IF sy-subrc NE 0.
                      APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
                      APPEND VALUE #( %key               = <ls_dpr>-%key
                                      %state_area        = 'Validate record'
                                       %msg              = new_message_with_text(
                                                                   text   = 'Incorrect WO Item.' && | | && <ls_dpr>-posid
                                                                   severity = if_abap_behv_message=>severity-error )
                                    %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.
                    ENDIF.
                  ENDIF.

                ELSEIF  <ls_dpr>-zsubcontract EQ 'N'.
***************modify
*             MOVE-CORRESPONDING <ls_dpr> to ls_dpr.
*             MODIFY zpst_scp_dpr_r1 FROM @ls_dpr.
                ENDIF.
              ELSE.
                APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
                APPEND VALUE #( %key               = <ls_dpr>-%key
                                %state_area        = 'Validate record'
                                 %msg              = new_message_with_text(
                                                             text   = 'Future DPR Date' && | | && <ls_dpr>-posid
                                                             severity = if_abap_behv_message=>severity-error )
                              %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.
              ENDIF.
            ENDIF.
          ELSE.
***error
            APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
            APPEND VALUE #( %key               = <ls_dpr>-%key
                            %state_area        = 'Validate record'
                             %msg              = new_message_with_text(
                                                         text   = |Incorrect WBS| && | | && <ls_dpr>-posid
                                                         severity = if_abap_behv_message=>severity-error )
                          %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.
          ENDIF.
          DATA : lv_road(3) TYPE c.
          lv_road = <ls_dpr>-zroads.
          CONDENSE lv_road.
          IF lv_road EQ 'LHS' OR lv_road EQ 'RHS' OR lv_road EQ 'BHS' OR lv_road EQ 'MID'.

          ELSE.
***error
            APPEND VALUE #( %key                = <ls_dpr>-%key ) TO failed-zdprentry.
            APPEND VALUE #( %key               = <ls_dpr>-%key
                            %state_area        = 'Validate record'
                             %msg              = new_message_with_text(
                                                         text   = 'Incorrect Side' && | | && <ls_dpr>-posid
                                                         severity = if_abap_behv_message=>severity-error )
                          %element-zpspnr = if_abap_behv=>mk-on ) TO reported-zdprentry.
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD delete.
*    DATA : it_tab TYPE STANDARD TABLE OF zpst_scp_dpr_r1.
*    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs>).
*        SELECT SINGLE *
*          FROM zpst_scp_dpr_r1
*         WHERE zdpr_no = @<fs>-zpspnr
*          INTO @DATA(lw_dpr).
*        lw_dpr-zappr_status = 'DELETE'.
*        APPEND INITIAL LINE TO it_tab ASSIGNING FIELD-SYMBOL(<fs_tab>).
*        MOVE-CORRESPONDING lw_dpr to <fs_tab>.
*    ENDLOOP.
*    modify zpst_scp_dpr_r1 from TABLE @it_tab .
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zps_dpr_entry_cds1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zps_dpr_entry_cds1 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
