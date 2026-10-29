CLASS zcl_boq_monthly_summary DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BOQ_MONTHLY_SUMMARY IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA: lt_result TYPE STANDARD TABLE OF zc_boqmonthlysummary,
          lv_offset TYPE int8,
          lv_limit  TYPE int8.

    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( lt_result ) ).
    ENDIF.
    IF io_request->is_data_requested( ).
      lv_offset = io_request->get_paging( )->get_offset( ).
      lv_limit  = io_request->get_paging( )->get_page_size( ).
      IF lv_limit > 0.
        lt_result = VALUE #( FOR ls_row IN lt_result FROM lv_offset + 1
                                                       TO lv_offset + lv_limit
                              ( ls_row ) ).
      ENDIF.
      io_response->set_data( lt_result ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
