CLASS lhc_zboqroot1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zboqroot1 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zboqroot1.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zboqroot1.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zboqroot1.

    METHODS read FOR READ
      IMPORTING keys FOR READ zboqroot1 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zboqroot1.

ENDCLASS.

CLASS lhc_zboqroot1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA: lv_missing_posid TYPE string,
        lv_wbs           TYPE i_enterpriseprojectelement-ProjectElement.
    DATA : lt_boqroot TYPE STANDARD TABLE OF zpst_boq_mast2,
           ls_boqroot TYPE zpst_boq_mast2,
           msg        TYPE string.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_boqroot>).

     SELECT SINGLE FROM I_ENTERPRISEPROJECTELEMENT
      FIELDS ProjectElement
      WHERE ProjectElement = @<ls_boqroot>-Posid
      INTO @lv_wbs.

    IF sy-subrc <> 0.

*      IF lv_missing_posid IS INITIAL.
        lv_missing_posid = |{ <ls_boqroot>-Posid }|.
*      ELSE.
*        lv_missing_posid =
*          |{ lv_missing_posid }, { <ls_boqroot>-Posid }|.
      ENDIF.

*    ENDIF.

*  ENDLOOP.

  "Show one error if any POSID is missing
  IF lv_missing_posid IS NOT INITIAL.

    APPEND VALUE #(
      %cid = entities[ 1 ]-%cid
    ) TO failed-zboqroot1.

    APPEND VALUE #(
      %cid = entities[ 1 ]-%cid
      %msg = new_message_with_text(
        severity = if_abap_behv_message=>severity-error
        text = |WBS Elements do not exist: { lv_missing_posid }|
      )
    ) TO reported-zboqroot1.

    RETURN.

  ENDIF.

*      ls_boqroot = CORRESPONDING #( <ls_boqroot> MAPPING FROM ENTITY USING CONTROL ).
      ls_boqroot-zpspnr          = <ls_boqroot>-zpspnr.
      ls_boqroot-zboq_version    = <ls_boqroot>-zboqversion.
      ls_boqroot-zboq_head_no    = <ls_boqroot>-zboqheadno.
      ls_boqroot-zboq_item_no    = <ls_boqroot>-zboqitemno.
      ls_boqroot-zboq_head_desc  = <ls_boqroot>-zboqheaddesc.
      ls_boqroot-zboq_item_desc  = <ls_boqroot>-zboqitemdesc.
      ls_boqroot-posid           = <ls_boqroot>-posid.
      ls_boqroot-zdes_chain_to   = <ls_boqroot>-zdeschainto.
      ls_boqroot-zdes_chain_from = <ls_boqroot>-zdeschainfrom.
      ls_boqroot-zdes_chain_at   = <ls_boqroot>-zdeschainat.
      ls_boqroot-zboq_level      = <ls_boqroot>-ZboqLevel.
      ls_boqroot-zboq_from       = <ls_boqroot>-ZboqFrom.
      ls_boqroot-zboq_to         = <ls_boqroot>-ZboqTo.
      ls_boqroot-zboq_qty        = <ls_boqroot>-zboqqty.
      ls_boqroot-zboq_rate       = <ls_boqroot>-zboqrate.
      ls_boqroot-zunit           = <ls_boqroot>-zunit.
      ls_boqroot-ztotal_amt    = <ls_boqroot>-ztotalamt.
      ls_boqroot-zproj_ext    = <ls_boqroot>-zprojext.
      ls_boqroot-zcurr = 'INR'.
      ls_boqroot-material = <ls_boqroot>-material.
      ls_boqroot-zboq_bill = <ls_boqroot>-zboqbill.
      ls_boqroot-zboq_billunit = <ls_boqroot>-zboqbillunit.
      ls_boqroot-zboq_head_wbs = <ls_boqroot>-zboqheadwbs.
      ls_boqroot-zboq_vamount = <ls_boqroot>-zboqvamount.
      ls_boqroot-zboq_vqty = <ls_boqroot>-zboqvqty.
      ls_boqroot-zboq_vrate = <ls_boqroot>-zboqvrate.
      ls_boqroot-zboq_tamount = <ls_boqroot>-zboqtamount.
      ls_boqroot-zboq_tqty = <ls_boqroot>-zboqtqty.
      ls_boqroot-zboq_trate = <ls_boqroot>-zboqtrate.
      ls_boqroot-zboq_blamount = <ls_boqroot>-zboqblamount.
      ls_boqroot-zboq_blqty = <ls_boqroot>-zboqblqty.
      ls_boqroot-zboq_blrate = <ls_boqroot>-zboqblrate.
      ls_boqroot-contract_number    = <ls_boqroot>-contract_number.
      ls_boqroot-Contract_line_item = <ls_boqroot>-Contract_line_item.
      ls_boqroot-Responsible_eng   = <ls_boqroot>-Responsible_eng.
      ls_boqroot-Plant             = <ls_boqroot>-Plant.
      ls_boqroot-created_by = sy-uname.
      ls_boqroot-created_at = | { sy-uzeit } | && | { sy-datum  } |.
      ls_boqroot-last_changed_by = sy-uname.
      ls_boqroot-last_changed_at = | { sy-uzeit } | && | { sy-datum  } |.

      IF ls_boqroot-zpspnr IS NOT INITIAL.
        MODIFY zpst_boq_mast2 FROM @ls_boqroot.
      ENDIF.
      CLEAR:ls_boqroot.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA : ls_boqroot TYPE zpst_boq_mast2,
           msg        TYPE string.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_boqroot>).

*      ls_boqroot = CORRESPONDING #( <ls_boqroot> MAPPING FROM ENTITY USING CONTROL ).
      ls_boqroot-zpspnr            = <ls_boqroot>-zpspnr.
      ls_boqroot-zboq_version      = <ls_boqroot>-zboqversion.
      ls_boqroot-zboq_head_no      = <ls_boqroot>-zboqheadno.
      ls_boqroot-zboq_item_no      = <ls_boqroot>-zboqitemno.
      ls_boqroot-zboq_head_desc    = <ls_boqroot>-zboqheaddesc.
      ls_boqroot-zboq_item_desc    = <ls_boqroot>-zboqitemdesc.
      ls_boqroot-posid             = <ls_boqroot>-posid.
      ls_boqroot-zdes_chain_to     = <ls_boqroot>-zdeschainto.
      ls_boqroot-zdes_chain_from   = <ls_boqroot>-zdeschainfrom.
      ls_boqroot-zdes_chain_at     = <ls_boqroot>-zdeschainat.
      ls_boqroot-zboq_level        = <ls_boqroot>-ZboqLevel.
      ls_boqroot-zboq_from         = <ls_boqroot>-ZboqFrom.
      ls_boqroot-zboq_to           = <ls_boqroot>-ZboqTo.
      ls_boqroot-zboq_qty          = <ls_boqroot>-zboqqty.
      ls_boqroot-zboq_rate         = <ls_boqroot>-zboqrate.
      ls_boqroot-zunit             = <ls_boqroot>-zunit.
      ls_boqroot-ztotal_amt        = <ls_boqroot>-ztotalamt.
      ls_boqroot-zproj_ext         = <ls_boqroot>-zprojext.
      ls_boqroot-zcurr             = 'INR'.
      ls_boqroot-material          = <ls_boqroot>-material.
      ls_boqroot-zboq_bill         = <ls_boqroot>-zboqbill.
      ls_boqroot-zboq_billunit     = <ls_boqroot>-zboqbillunit.
      ls_boqroot-zboq_head_wbs     = <ls_boqroot>-zboqheadwbs.
      ls_boqroot-zboq_vamount      = <ls_boqroot>-zboqvamount.
      ls_boqroot-zboq_vqty         = <ls_boqroot>-zboqvqty.
      ls_boqroot-zboq_vrate        = <ls_boqroot>-zboqvrate.
      ls_boqroot-zboq_tamount      = <ls_boqroot>-zboqtamount.
      ls_boqroot-zboq_tqty         = <ls_boqroot>-zboqtqty.
      ls_boqroot-zboq_trate        = <ls_boqroot>-zboqtrate.
      ls_boqroot-zboq_blamount     = <ls_boqroot>-zboqblamount.
      ls_boqroot-zboq_blqty        = <ls_boqroot>-zboqblqty.
      ls_boqroot-zboq_blrate       = <ls_boqroot>-zboqblrate.
      ls_boqroot-contract_number   = <ls_boqroot>-contract_number.
      ls_boqroot-Contract_line_item   = <ls_boqroot>-Contract_line_item.
      ls_boqroot-Responsible_eng   = <ls_boqroot>-Responsible_eng.
      ls_boqroot-Plant             = <ls_boqroot>-Plant.
      ls_boqroot-created_by        = sy-uname.
      ls_boqroot-created_at        = | { sy-uzeit } | && | { sy-datum  } |.
      ls_boqroot-last_changed_by   = sy-uname.
      ls_boqroot-last_changed_at   = | { sy-uzeit } | && | { sy-datum  } |.

      IF <ls_boqroot>-flag NE 'D'.
        IF ls_boqroot-zpspnr IS NOT INITIAL.
          MODIFY zpst_boq_mast2 FROM @ls_boqroot.
        ENDIF.
        CLEAR:ls_boqroot.
      ELSEIF <ls_boqroot>-flag = 'D'.

        DELETE zpst_boq_mast2 FROM @ls_boqroot.
        CLEAR:ls_boqroot.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.

    DATA : ls_boqroot TYPE zpst_boq_mast2,
           msg        TYPE string.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zpscds_boqroot1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.


    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zpscds_boqroot1 IMPLEMENTATION.

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
