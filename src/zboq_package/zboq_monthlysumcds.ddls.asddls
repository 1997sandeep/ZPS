@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ CRUD CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOQ_MONTHLYSUMCDS
  as select from zboq_tracking
{
      // ---- key ------------------------------------------------------
  key sr_no                 as SrNo,
  key project_id            as ProjectId,
  key plant                 as Plant,
  key wbs_element           as WbsElement,

      // ---- descriptive ----------------------------------------------
      description           as Description,
      boq_hdr_no            as BoqHdrNo,
      boq_hdr_desc          as BoqHdrDesc,
      boq_item_no           as BoqItemNo,
      boq_item_desc         as BoqItemDesc,
      contract_line_item    as ContractLineItem,

      // ---- quantity: the reference field is the ALIAS, not the
      //      table column, because the annotation is evaluated on the
      //      view's own element list
      uom                   as Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      boq_qty               as BoqQty,

      // ---- amounts --------------------------------------------------
      currency              as Currency,
      @Semantics.amount.currencyCode: 'Currency'
      boq_rate              as BoqRate,
      @Semantics.amount.currencyCode: 'Currency'
      amount                as Amount,

      resp_engineer         as RespEngineer,
      fiscal_year           as FiscalYear,

      // ---- monthly planning values ----------------------------------
      @Semantics.amount.currencyCode: 'Currency'
      amt_january           as AmtJanuary,
      @Semantics.amount.currencyCode: 'Currency'
      amt_february          as AmtFebruary,
      @Semantics.amount.currencyCode: 'Currency'
      amt_march             as AmtMarch,
      @Semantics.amount.currencyCode: 'Currency'
      amt_april             as AmtApril,
      @Semantics.amount.currencyCode: 'Currency'
      amt_may               as AmtMay,
      @Semantics.amount.currencyCode: 'Currency'
      amt_june              as AmtJune,
      @Semantics.amount.currencyCode: 'Currency'
      amt_july              as AmtJuly,
      @Semantics.amount.currencyCode: 'Currency'
      amt_august            as AmtAugust,
      @Semantics.amount.currencyCode: 'Currency'
      amt_september         as AmtSeptember,
      @Semantics.amount.currencyCode: 'Currency'
      amt_october           as AmtOctober,
      @Semantics.amount.currencyCode: 'Currency'
      amt_november          as AmtNovember,
      @Semantics.amount.currencyCode: 'Currency'
      amt_december          as AmtDecember,

      // ---- the Total column of the spreadsheet is not stored on the
      //      table, so it is derived here for the UI to bind to
      @Semantics.amount.currencyCode: 'Currency'
      cast(   amt_january   + amt_february + amt_march
            + amt_april     + amt_may      + amt_june
            + amt_july      + amt_august   + amt_september
            + amt_october   + amt_november + amt_december
            as abap.curr(15,2) )          as TotalAmount
}
