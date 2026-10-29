CLASS zcl_boq_mast2_delete DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_boq_mast2_delete IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    CONSTANTS:
      lc_zpspnr   TYPE zpst_boq_mast2-zpspnr       VALUE '00000129',
      lc_version  TYPE zpst_boq_mast2-zboq_version VALUE '001',
      lc_posid_pt TYPE zpst_boq_mast2-posid        VALUE 'W/OM2009%'.

    " 1. Read the full rows so all 5 key fields are available
    SELECT *
      FROM zpst_boq_mast2
      WHERE zpspnr       = @lc_zpspnr
        AND zboq_version = @lc_version
        AND posid LIKE @lc_posid_pt
      INTO TABLE @DATA(lt_rows).

    out->write( |Rows found: { lines( lt_rows ) }| ).

    IF lt_rows IS INITIAL.
      RETURN.
    ENDIF.

    " Show the 5 key fields of every row that will be deleted
    out->write( VALUE string_table(
      FOR ls IN lt_rows
      ( |{ ls-zpspnr } / { ls-zboq_version } / { ls-posid } / { ls-zboq_head_no } / { ls-zboq_item_no }| ) ) ).

    " 2. Delete by full primary key (all 5 key fields)
    DELETE zpst_boq_mast2 FROM TABLE @lt_rows.

    IF sy-subrc = 0.
      out->write( |Rows deleted: { sy-dbcnt }| ).
      COMMIT WORK.
    ELSE.
      ROLLBACK WORK.
      out->write( 'Nothing deleted' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
