@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 For Work Order Number'
define root view entity ZPS_DPR_ENTRY_WONO
  as select distinct from    I_EnterpriseProjectElement     as a
    left outer join I_PurOrdAccountAssignmentAPI01 as b on a.WBSElementInternalID = b.WBSElementInternalID_2
    left outer join I_PurchaseOrderAPI01           as c on b.PurchaseOrder = c.PurchaseOrder
    left outer join I_PurchaseOrderItemAPI01       as g on g.PurchaseOrder = c.PurchaseOrder
    left outer join I_Supplier                     as d on c.Supplier = d.Supplier
    left outer join ZPS_DPR_ENTRY_WOQTY            as e on  b.PurchaseOrder        = e.PurchaseOrder
                                                        and b.WBSElementInternalID_2 = e.WBSElementInternalID
    left outer join ZPS_DPR_ENTRY_WO_PREVQTY       as f on b.WBSElementInternalID_2 = f.posid // b.PurchaseOrder        = f.zwo_no
                                                        //and b.WBSElementInternalID = f.Wbsid

{
  key a.ProjectElement, 
  key c.PurchaseOrder as zwo_no,
////  key g.PurchaseOrderItem as zwo_item,
      d.SupplierName  as zwo_name,
      e.PurchaseOrderQuantityUnit,
      @EndUserText.label: 'WO Qty'
      @Semantics: { quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit' }
      e.Quantity      as zwo_qty,
      @Semantics: { quantity.unitOfMeasure : 'PurchaseOrderQuantityUnit' }
      f.zprev_qty     as zprev_qty
}
where
  (
       c.PurchaseOrderType         =  'ZSCS'
  )
  and  
  c.PurchaseOrder             <> ''
////  and  e.PurchaseOrderQuantityUnit is not initial
group by
  a.ProjectElement,
  c.PurchaseOrder,
  d.SupplierName,
  e.Quantity,
  e.PurchaseOrderQuantityUnit,
  f.zprev_qty,
    g.PurchaseOrderItem
