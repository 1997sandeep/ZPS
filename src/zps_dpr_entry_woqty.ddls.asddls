@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS fetch for Wo Qty Wise'
define root view entity ZPS_DPR_ENTRY_WOQTY
  as select from ZPS_DPR_ENTRY_WOWBS
{
  key PurchaseOrder,
  key WBSElementInternalID,
      PurchaseOrderQuantityUnit,
      Quantity
}
group by
  PurchaseOrder,
  WBSElementInternalID,
  PurchaseOrderQuantityUnit,
  Quantity
