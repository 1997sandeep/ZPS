"! Creates this chain in project H/OM2500 and SAVES it (no test mode):
"!
"!   H/OM2500-D                          Direct Costs            (exists - level 2)
"!   +- H/OM2500-D-4                     Civil Works             (level 3)
"!      +- H/OM2500-D-4-01               Foundation Works        (level 4)
"!         +- H/OM2500-D-4-01-01         Excavation              (level 5)
"!            +- H/OM2500-D-4-01-01-01   Earthwork Excavation    (level 6)
"!               +- H/OM2500-D-4-01-01-01-01  Excavation Zone A  (level 7)
"!
"! Each level is created with its own MODIFY. The UUID of the element just created
"! (from MAPPED) is the parent of the next level. One COMMIT at the end, then the
"! program reads the project again from the database to prove the elements exist.
CLASS zcl_projectelement_bapi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    CONSTANTS:
      c_project_uuid  TYPE sysuuid_x16 VALUE '42010A0BC9571FE1B2C3CC94481D6F87',   " H/OM2500
      c_start_date    TYPE d           VALUE '20261101',
      c_end_date      TYPE d           VALUE '20271031',
      c_profit_center TYPE string      VALUE '0000001000',
      c_cost_center   TYPE string      VALUE '0010000001'.

    "! Creates one WBS element under iv_parent_uuid (in the buffer) and returns its new UUID
    METHODS create_child
      IMPORTING iv_parent_uuid TYPE sysuuid_x16
                iv_wbs         TYPE string
                iv_description TYPE string
                io_out         TYPE REF TO if_oo_adt_classrun_out
      RETURNING VALUE(rv_uuid) TYPE sysuuid_x16.

    "! UUID of a WBS element of the project, read from SAP ('' if it does not exist)
    METHODS get_uuid
      IMPORTING iv_wbs         TYPE string
      RETURNING VALUE(rv_uuid) TYPE sysuuid_x16.

ENDCLASS.



CLASS zcl_projectelement_bapi IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "--- 0. Parent of the chain must exist, the chain itself must not -----------
    DATA(lv_uuid_d) = get_uuid( `H/OM2500-D` ).
    IF lv_uuid_d IS INITIAL.
      out->write( `H/OM2500-D not found - check the project UUID constant.` ).
      RETURN.
    ENDIF.

    IF get_uuid( `H/OM2500-D-4` ) IS NOT INITIAL.
      out->write( `H/OM2500-D-4 already exists - nothing to do.` ).
      RETURN.
    ENDIF.

    "--- 1. Create level by level - each new UUID is the parent of the next -----
    DATA(lv_uuid_l3) = create_child( iv_parent_uuid = lv_uuid_d
                                     iv_wbs         = `H/OM2500-D-4`
                                     iv_description = `Civil Works`
                                     io_out         = out ).
    IF lv_uuid_l3 IS INITIAL. ROLLBACK ENTITIES. RETURN. ENDIF.

    DATA(lv_uuid_l4) = create_child( iv_parent_uuid = lv_uuid_l3
                                     iv_wbs         = `H/OM2500-D-4-01`
                                     iv_description = `Foundation Works`
                                     io_out         = out ).
    IF lv_uuid_l4 IS INITIAL. ROLLBACK ENTITIES. RETURN. ENDIF.

    DATA(lv_uuid_l5) = create_child( iv_parent_uuid = lv_uuid_l4
                                     iv_wbs         = `H/OM2500-D-4-01-01`
                                     iv_description = `Excavation`
                                     io_out         = out ).
    IF lv_uuid_l5 IS INITIAL. ROLLBACK ENTITIES. RETURN. ENDIF.

    DATA(lv_uuid_l6) = create_child( iv_parent_uuid = lv_uuid_l5
                                     iv_wbs         = `H/OM2500-D-4-01-01-01`
                                     iv_description = `Earthwork Excavation`
                                     io_out         = out ).
    IF lv_uuid_l6 IS INITIAL. ROLLBACK ENTITIES. RETURN. ENDIF.

    DATA(lv_uuid_l7) = create_child( iv_parent_uuid = lv_uuid_l6
                                     iv_wbs         = `H/OM2500-D-4-01-01-01-01`
                                     iv_description = `Excavation Zone A`
                                     io_out         = out ).
    IF lv_uuid_l7 IS INITIAL. ROLLBACK ENTITIES. RETURN. ENDIF.

    "--- 2. Save all five ---------------------------------------------------------
    COMMIT ENTITIES
      RESPONSE OF i_enterpriseprojecttp_3
      FAILED   DATA(ls_commit_failed)
      REPORTED DATA(ls_commit_reported).

    IF sy-subrc <> 0 OR ls_commit_failed IS NOT INITIAL.
      out->write( `COMMIT FAILED - nothing saved:` ).
      LOOP AT ls_commit_reported-enterpriseprojectelement INTO DATA(ls_cmsg).
        out->write( ls_cmsg-%msg->if_message~get_text( ) ).
      ENDLOOP.
      LOOP AT ls_commit_reported-enterpriseproject INTO DATA(ls_pmsg).
        out->write( ls_pmsg-%msg->if_message~get_text( ) ).
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

    out->write( `COMMIT done. Reading the project again from the database:` ).

    "--- 3. Proof: read back from SAP --------------------------------------------
    DATA(lt_check) = VALUE string_table( ( `H/OM2500-D-4` )
                                         ( `H/OM2500-D-4-01` )
                                         ( `H/OM2500-D-4-01-01` )
                                         ( `H/OM2500-D-4-01-01-01` )
                                         ( `H/OM2500-D-4-01-01-01-01` ) ).
    LOOP AT lt_check INTO DATA(lv_wbs).
      out->write( |{ lv_wbs WIDTH = 28 } { COND string( WHEN get_uuid( lv_wbs ) IS NOT INITIAL
                                                         THEN `SAVED`
                                                         ELSE `NOT FOUND` ) }| ).
    ENDLOOP.

  ENDMETHOD.


  METHOD create_child.

    MODIFY ENTITIES OF i_enterpriseprojecttp_3
      ENTITY EnterpriseProjectElement
        CREATE BY \_SubProjElement
        FIELDS ( ProjectElement
                 ProjectElementDescription
                 PlannedStartDate
                 PlannedEndDate
                 ProfitCenter
                 ResponsibleCostCenter )
        WITH VALUE #(
          ( %key-ProjectElementUUID = iv_parent_uuid
            %target = VALUE #(
              ( %cid                      = CONV abp_behv_cid( iv_wbs )
                ProjectElement            = iv_wbs
                ProjectElementDescription = iv_description
                PlannedStartDate          = c_start_date
                PlannedEndDate            = c_end_date
                ProfitCenter              = c_profit_center
                ResponsibleCostCenter     = c_cost_center ) ) ) )
      MAPPED   DATA(ls_mapped)
      FAILED   DATA(ls_failed)
      REPORTED DATA(ls_reported).

    IF ls_failed IS INITIAL AND ls_mapped-enterpriseprojectelement IS NOT INITIAL.
      rv_uuid = ls_mapped-enterpriseprojectelement[ 1 ]-ProjectElementUUID.
      io_out->write( |{ iv_wbs WIDTH = 28 } created in buffer| ).
    ELSE.
      io_out->write( |{ iv_wbs WIDTH = 28 } FAILED - nothing will be saved:| ).
      LOOP AT ls_reported-enterpriseprojectelement INTO DATA(ls_msg).
        io_out->write( ls_msg-%msg->if_message~get_text( ) ).
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_uuid.

    DATA lt_parents TYPE TABLE FOR READ IMPORT
         i_enterpriseprojecttp_3\\EnterpriseProjectElement\_SubProjElement.

    " elements directly under the project
    READ ENTITIES OF i_enterpriseprojecttp_3
      ENTITY EnterpriseProject BY \_EnterpriseProjectElement
        FIELDS ( ProjectElement )
        WITH VALUE #( ( %key-ProjectUUID = c_project_uuid ) )
      RESULT DATA(lt_level).

    LOOP AT lt_level INTO DATA(ls_level).
      IF ls_level-ProjectElement = iv_wbs.
        rv_uuid = ls_level-ProjectElementUUID.
        RETURN.
      ENDIF.
      APPEND VALUE #( %key-ProjectElementUUID = ls_level-ProjectElementUUID ) TO lt_parents.
    ENDLOOP.

    " then one level deeper at a time
    WHILE lt_parents IS NOT INITIAL.
      READ ENTITIES OF i_enterpriseprojecttp_3
        ENTITY EnterpriseProjectElement BY \_SubProjElement
          FIELDS ( ProjectElement )
          WITH lt_parents
        RESULT DATA(lt_children).

      CLEAR lt_parents.
      LOOP AT lt_children INTO DATA(ls_child).
        IF ls_child-ProjectElement = iv_wbs.
          rv_uuid = ls_child-ProjectElementUUID.
          RETURN.
        ENDIF.
        APPEND VALUE #( %key-ProjectElementUUID = ls_child-ProjectElementUUID ) TO lt_parents.
      ENDLOOP.
    ENDWHILE.

  ENDMETHOD.

ENDCLASS.

