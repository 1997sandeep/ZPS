@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS fetch for Wo WBS Wise'
define root view entity ZPS_DPR_ENTRY_WOWBS
  as select from    I_PurchaseOrderAPI01           as a
    left outer join I_PurOrdAccountAssignmentAPI01 as b on a.PurchaseOrder = b.PurchaseOrder
{
  key a.PurchaseOrder,
      //  key max(b.WBSElementInternalID) as WBSElementInternalID,
  key b.WBSElementInternalID_2  as WBSElementInternalID,
      b.PurchaseOrderQuantityUnit,
      @Semantics: { quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit' }
      sum(b.Quantity) as Quantity
}
where
       (
       a.PurchaseOrderType         =  'ZMWO'
    or a.PurchaseOrderType         =  'ZHIR'
    or a.PurchaseOrderType         =  'ZSUB'
  )
  and a.PurchaseOrder             <> ''
  and b.WBSElementInternalID_2      <> '00000000'
  and b.PurchaseOrderQuantityUnit <> ''
group by
  a.PurchaseOrder,
  b.PurchaseOrderQuantityUnit,
  b.WBSElementInternalID_2
