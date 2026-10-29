@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Zero Budget Projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_ZERO_BUDGET_PRJ
  as projection on ZPS_ZERO_BUDGET_CDS
{
  key Project,
  key WbsElement,
  key BoqItem,
  key Category,
  key MaterialServiceCode,
      Definition_,
      ProjectDescription,
      WbsDescription,
      BoqItemDescription,
      BoqUnit,
      BoqQuantity,
      Zcurr,
      @Semantics.amount.currencyCode : 'Zcurr'
      BoqRate,
      BoqAmount,
      Unit,
      @Semantics.amount.currencyCode : 'Zcurr'
      PlannedRates,
      PlannedQty,
      PlannedAmount,
      TotalAmount
}
