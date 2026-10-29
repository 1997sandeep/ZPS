@EndUserText.label: 'Annual Opreation Plan Report'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_BOQ_TRACK_REP'
    }
}
@UI.headerInfo: {
    typeName: 'Annual Opreation Plan',
    typeNamePlural: 'Annual Opreation Plan'
}
define custom entity ZBOQ_TRACK_REP
{
  key sr_no                : abap.numc(10);
  key project_id           : abap.char(24);
  key plant                : abap.char(4);
  key wbs_element          : abap.char(24);
      description          : abap.char(100);
      boq_hdr_no           : abap.char(10);
      boq_hdr_desc         : abap.char(100);
      boq_item_no          : abap.char(10);
      boq_item_desc        : abap.char(100);
      contract_line_item   : abap.char(10);
      uom                  : abap.unit(3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      boq_qty              : abap.quan(13,3);
      currency             : abap.cuky;
      @Semantics.amount.currencyCode : 'currency'
      boq_rate             : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amount               : abap.curr(13,2);
      resp_engineer        : abap.char(40);
      fiscal_year          : abap.numc(4);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jan_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jan_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      feb_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      feb_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      mar_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      mar_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      apr_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      apr_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      may_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      may_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jun_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jun_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jul_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      jul_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      aug_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      aug_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      sep_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      sep_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      oct_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      oct_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      nov_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      nov_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      dec_planned          : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      dec_executed         : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      Curr_Year_Planned    : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      Curr_Year_Executed   : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      LAST_Year_Planned    : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      LAST_Year_Executed   : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      Cumulative_Planned   : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      Cumulative_Executed  : abap.quan(13,3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      Balance_QTY_Executed : abap.quan(13,3);
}
