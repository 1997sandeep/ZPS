@EndUserText.label: 'BOQ Monthly Summary (Custom Entity)'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_BOQ_MONTHLY_SUMMARY'
define custom entity ZC_BoqMonthlySummary
{
  key sr_no              : abap.numc(10);
  key project_id         : abap.char(24);
  key plant              : abap.char(4);
  key wbs_element        : abap.char(24);
      description        : abap.char(100);
      boq_hdr_no         : abap.char(10);
      boq_hdr_desc       : abap.char(100);
      boq_item_no        : abap.char(10);
      boq_item_desc      : abap.char(100);
      contract_line_item : abap.char(10);
      uom                : abap.unit(3);
      @Semantics.quantity.unitOfMeasure : 'uom'
      boq_qty            : abap.quan(13,3);
      currency           : abap.cuky;
      @Semantics.amount.currencyCode : 'currency'
      boq_rate           : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amount             : abap.curr(13,2);
      resp_engineer      : abap.char(40);
      fiscal_year        : abap.numc(4);
      @Semantics.amount.currencyCode : 'currency'
      amt_january        : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_february       : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_march          : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_april          : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_may            : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_june           : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_july           : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_august         : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_september      : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_october        : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_november       : abap.curr(13,2);
      @Semantics.amount.currencyCode : 'currency'
      amt_december       : abap.curr(13,2);

}
