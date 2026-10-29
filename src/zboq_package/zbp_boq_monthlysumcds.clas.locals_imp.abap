*&---------------------------------------------------------------------*
*& Buffer - holds the changes until SAVE writes them to the table
*&---------------------------------------------------------------------*
CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_buf,
             sr_no       TYPE zboq_tracking-sr_no,
             project_id  TYPE zboq_tracking-project_id,
             plant       TYPE zboq_tracking-plant,
             wbs_element TYPE zboq_tracking-wbs_element,
             mode        TYPE c LENGTH 1,
             data        TYPE zboq_tracking,
           END OF ty_buf.
    CLASS-DATA mt_buf TYPE STANDARD TABLE OF ty_buf WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_buffer IMPLEMENTATION.
ENDCLASS.


CLASS lhc_ZBOQ_MONTHLYSUMCDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      keys REQUEST requested_authorizations FOR zboq_monthlysumcds RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zboq_monthlysumcds RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE zboq_monthlysumcds.

    METHODS update FOR MODIFY
       entities FOR UPDATE zboq_monthlysumcds.

    METHODS delete FOR MODIFY
       keys FOR DELETE zboq_monthlysumcds.

    METHODS read FOR READ
       keys FOR READ zboq_monthlysumcds RESULT result.

*    METHODS lock FOR LOCK
*       keys FOR LOCK zboq_monthlysumcds.

ENDCLASS.

CLASS lhc_ZBOQ_MONTHLYSUMCDS IMPLEMENTATION.

*  METHOD get_instance_authorizations.
*  ENDMETHOD.

  METHOD get_global_authorizations.

*   an empty method here refuses every create, so it has to grant it
*    result-%create = if_abap_behv=>auth-allowed.
*    result-%update = if_abap_behv=>auth-allowed.
*    result-%delete = if_abap_behv=>auth-allowed.

  ENDMETHOD.


  METHOD create.

    DATA lv_sr_no TYPE zboq_tracking-sr_no.

    SELECT SINGLE MAX( sr_no ) FROM zboq_tracking INTO @lv_sr_no.

    LOOP AT entities INTO DATA(ls_ent).

      IF ls_ent-SrNo IS INITIAL.
        lv_sr_no    = lv_sr_no + 1.
        ls_ent-SrNo = lv_sr_no.
      ENDIF.

      APPEND VALUE #(
        sr_no       = ls_ent-SrNo
        project_id  = ls_ent-ProjectId
        plant       = ls_ent-Plant
        wbs_element = ls_ent-WbsElement
        mode        = 'C'
        data        = VALUE #(
          sr_no              = ls_ent-SrNo
          project_id         = ls_ent-ProjectId
          plant              = ls_ent-Plant
          wbs_element        = ls_ent-WbsElement
          description        = ls_ent-Description
          boq_hdr_no         = ls_ent-BoqHdrNo
          boq_hdr_desc       = ls_ent-BoqHdrDesc
          boq_item_no        = ls_ent-BoqItemNo
          boq_item_desc      = ls_ent-BoqItemDesc
          contract_line_item = ls_ent-ContractLineItem
          uom                = ls_ent-Uom
          boq_qty            = ls_ent-BoqQty
          currency           = ls_ent-Currency
          boq_rate           = ls_ent-BoqRate
          amount             = ls_ent-Amount
          resp_engineer      = ls_ent-RespEngineer
          fiscal_year        = ls_ent-FiscalYear
          amt_january        = ls_ent-AmtJanuary
          amt_february       = ls_ent-AmtFebruary
          amt_march          = ls_ent-AmtMarch
          amt_april          = ls_ent-AmtApril
          amt_may            = ls_ent-AmtMay
          amt_june           = ls_ent-AmtJune
          amt_july           = ls_ent-AmtJuly
          amt_august         = ls_ent-AmtAugust
          amt_september      = ls_ent-AmtSeptember
          amt_october        = ls_ent-AmtOctober
          amt_november       = ls_ent-AmtNovember
          amt_december       = ls_ent-AmtDecember ) )
        TO lcl_buffer=>mt_buf.

      APPEND VALUE #( %cid = ls_ent-%cid
                      %key = VALUE #( SrNo       = ls_ent-SrNo
                                      ProjectId  = ls_ent-ProjectId
                                      Plant      = ls_ent-Plant
                                      WbsElement = ls_ent-WbsElement ) )
             TO mapped-zboq_monthlysumcds.

    ENDLOOP.

  ENDMETHOD.


  METHOD update.

    LOOP AT entities INTO DATA(ls_ent).

      SELECT SINGLE * FROM zboq_tracking
        WHERE sr_no       = @ls_ent-SrNo
          AND project_id  = @ls_ent-ProjectId
          AND plant       = @ls_ent-Plant
          AND wbs_element = @ls_ent-WbsElement
        INTO @DATA(ls_db).

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = ls_ent-%tky ) TO failed-zboq_monthlysumcds.
        CONTINUE.
      ENDIF.

*     only the fields the client actually sent
      IF ls_ent-%control-Description      = if_abap_behv=>mk-on.
        ls_db-description        = ls_ent-Description.
      ENDIF.
      IF ls_ent-%control-BoqHdrNo         = if_abap_behv=>mk-on.
        ls_db-boq_hdr_no         = ls_ent-BoqHdrNo.
      ENDIF.
      IF ls_ent-%control-BoqHdrDesc       = if_abap_behv=>mk-on.
        ls_db-boq_hdr_desc       = ls_ent-BoqHdrDesc.
      ENDIF.
      IF ls_ent-%control-BoqItemNo        = if_abap_behv=>mk-on.
        ls_db-boq_item_no        = ls_ent-BoqItemNo.
      ENDIF.
      IF ls_ent-%control-BoqItemDesc      = if_abap_behv=>mk-on.
        ls_db-boq_item_desc      = ls_ent-BoqItemDesc.
      ENDIF.
      IF ls_ent-%control-ContractLineItem = if_abap_behv=>mk-on.
        ls_db-contract_line_item = ls_ent-ContractLineItem.
      ENDIF.
      IF ls_ent-%control-Uom              = if_abap_behv=>mk-on.
        ls_db-uom                = ls_ent-Uom.
      ENDIF.
      IF ls_ent-%control-BoqQty           = if_abap_behv=>mk-on.
        ls_db-boq_qty            = ls_ent-BoqQty.
      ENDIF.
      IF ls_ent-%control-Currency         = if_abap_behv=>mk-on.
        ls_db-currency           = ls_ent-Currency.
      ENDIF.
      IF ls_ent-%control-BoqRate          = if_abap_behv=>mk-on.
        ls_db-boq_rate           = ls_ent-BoqRate.
      ENDIF.
      IF ls_ent-%control-Amount           = if_abap_behv=>mk-on.
        ls_db-amount             = ls_ent-Amount.
      ENDIF.
      IF ls_ent-%control-RespEngineer     = if_abap_behv=>mk-on.
        ls_db-resp_engineer      = ls_ent-RespEngineer.
      ENDIF.
      IF ls_ent-%control-FiscalYear       = if_abap_behv=>mk-on.
        ls_db-fiscal_year        = ls_ent-FiscalYear.
      ENDIF.
      IF ls_ent-%control-AmtJanuary       = if_abap_behv=>mk-on.
        ls_db-amt_january        = ls_ent-AmtJanuary.
      ENDIF.
      IF ls_ent-%control-AmtFebruary      = if_abap_behv=>mk-on.
        ls_db-amt_february       = ls_ent-AmtFebruary.
      ENDIF.
      IF ls_ent-%control-AmtMarch         = if_abap_behv=>mk-on.
        ls_db-amt_march          = ls_ent-AmtMarch.
      ENDIF.
      IF ls_ent-%control-AmtApril         = if_abap_behv=>mk-on.
        ls_db-amt_april          = ls_ent-AmtApril.
      ENDIF.
      IF ls_ent-%control-AmtMay           = if_abap_behv=>mk-on.
        ls_db-amt_may            = ls_ent-AmtMay.
      ENDIF.
      IF ls_ent-%control-AmtJune          = if_abap_behv=>mk-on.
        ls_db-amt_june           = ls_ent-AmtJune.
      ENDIF.
      IF ls_ent-%control-AmtJuly          = if_abap_behv=>mk-on.
        ls_db-amt_july           = ls_ent-AmtJuly.
      ENDIF.
      IF ls_ent-%control-AmtAugust        = if_abap_behv=>mk-on.
        ls_db-amt_august         = ls_ent-AmtAugust.
      ENDIF.
      IF ls_ent-%control-AmtSeptember     = if_abap_behv=>mk-on.
        ls_db-amt_september      = ls_ent-AmtSeptember.
      ENDIF.
      IF ls_ent-%control-AmtOctober       = if_abap_behv=>mk-on.
        ls_db-amt_october        = ls_ent-AmtOctober.
      ENDIF.
      IF ls_ent-%control-AmtNovember      = if_abap_behv=>mk-on.
        ls_db-amt_november       = ls_ent-AmtNovember.
      ENDIF.
      IF ls_ent-%control-AmtDecember      = if_abap_behv=>mk-on.
        ls_db-amt_december       = ls_ent-AmtDecember.
      ENDIF.

      APPEND VALUE #( sr_no       = ls_ent-SrNo
                      project_id  = ls_ent-ProjectId
                      plant       = ls_ent-Plant
                      wbs_element = ls_ent-WbsElement
                      mode        = 'U'
                      data        = ls_db ) TO lcl_buffer=>mt_buf.

    ENDLOOP.

  ENDMETHOD.


  METHOD delete.

    LOOP AT keys INTO DATA(ls_key).

      APPEND VALUE #( sr_no       = ls_key-SrNo
                      project_id  = ls_key-ProjectId
                      plant       = ls_key-Plant
                      wbs_element = ls_key-WbsElement
                      mode        = 'D' ) TO lcl_buffer=>mt_buf.

    ENDLOOP.

  ENDMETHOD.


  METHOD read.

    LOOP AT keys INTO DATA(ls_key).

      SELECT SINGLE * FROM zboq_tracking
        WHERE sr_no       = @ls_key-SrNo
          AND project_id  = @ls_key-ProjectId
          AND plant       = @ls_key-Plant
          AND wbs_element = @ls_key-WbsElement
        INTO @DATA(ls_db).

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = ls_key-%tky ) TO failed-zboq_monthlysumcds.
        CONTINUE.
      ENDIF.

      APPEND VALUE #(
        SrNo             = ls_db-sr_no
        ProjectId        = ls_db-project_id
        Plant            = ls_db-plant
        WbsElement       = ls_db-wbs_element
        Description      = ls_db-description
        BoqHdrNo         = ls_db-boq_hdr_no
        BoqHdrDesc       = ls_db-boq_hdr_desc
        BoqItemNo        = ls_db-boq_item_no
        BoqItemDesc      = ls_db-boq_item_desc
        ContractLineItem = ls_db-contract_line_item
        Uom              = ls_db-uom
        BoqQty           = ls_db-boq_qty
        Currency         = ls_db-currency
        BoqRate          = ls_db-boq_rate
        Amount           = ls_db-amount
        RespEngineer     = ls_db-resp_engineer
        FiscalYear       = ls_db-fiscal_year
        AmtJanuary       = ls_db-amt_january
        AmtFebruary      = ls_db-amt_february
        AmtMarch         = ls_db-amt_march
        AmtApril         = ls_db-amt_april
        AmtMay           = ls_db-amt_may
        AmtJune          = ls_db-amt_june
        AmtJuly          = ls_db-amt_july
        AmtAugust        = ls_db-amt_august
        AmtSeptember     = ls_db-amt_september
        AmtOctober       = ls_db-amt_october
        AmtNovember      = ls_db-amt_november
        AmtDecember      = ls_db-amt_december ) TO result.

    ENDLOOP.

  ENDMETHOD.


*  METHOD lock.
*  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZBOQ_MONTHLYSUMCDS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZBOQ_MONTHLYSUMCDS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    LOOP AT lcl_buffer=>mt_buf INTO DATA(ls_buf).

      CASE ls_buf-mode.

        WHEN 'C'.
          INSERT zboq_tracking FROM @ls_buf-data.

        WHEN 'U'.
          UPDATE zboq_tracking FROM @ls_buf-data.

        WHEN 'D'.
          DELETE FROM zboq_tracking
            WHERE sr_no       = @ls_buf-sr_no
              AND project_id  = @ls_buf-project_id
              AND plant       = @ls_buf-plant
              AND wbs_element = @ls_buf-wbs_element.

      ENDCASE.

    ENDLOOP.

    CLEAR lcl_buffer=>mt_buf.

  ENDMETHOD.

  METHOD cleanup.
    CLEAR lcl_buffer=>mt_buf.
  ENDMETHOD.

  METHOD cleanup_finalize.
    CLEAR lcl_buffer=>mt_buf.
  ENDMETHOD.

ENDCLASS.

