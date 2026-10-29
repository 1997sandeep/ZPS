CLASS lhc_ZPS_DPR_APPROVER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zps_dpr_approver RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zps_dpr_approver.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zps_dpr_approver.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zps_dpr_approver.

    METHODS read FOR READ
      IMPORTING keys FOR READ zps_dpr_approver RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zps_dpr_approver.

ENDCLASS.

CLASS lhc_ZPS_DPR_APPROVER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA : ls_dpr   TYPE zpst_scp_dpr_r1,
           ls_check TYPE zpst_scp_dpr_r1,
           msg      TYPE string,
           l_from   TYPE string,
           l_to     TYPE string.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_dpr>).

      SELECT SINGLE * FROM zpst_scp_dpr_r1 WHERE zdpr_no = @<ls_dpr>-zdpr_no
      INTO @DATA(lw_dpr).
      IF sy-subrc = 0.

        lw_dpr-zappr_status = <ls_dpr>-zappr_status.

        MODIFY zpst_scp_dpr_r1 FROM @lw_dpr.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPS_DPR_APPROVER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPS_DPR_APPROVER IMPLEMENTATION.

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
