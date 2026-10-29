@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - DPR Service Values'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zps_dpr_service 
as select from I_PurchaseOrderItemAPI01
{
     key PurchaseOrder as zwo,
         PurchaseOrderItem as zwo_item,
         Material as zmat,
         PurchaseOrderItemText as zmat_desc,
         BaseUnit as zwo_unit,
         @Semantics.quantity.unitOfMeasure : 'zwo_unit'
         OrderQuantity as zwo_qty,
         DocumentCurrency,
         @Semantics.amount.currencyCode: 'DocumentCurrency'
         NetPriceAmount  as zwo_price,
         @Semantics.amount.currencyCode: 'DocumentCurrency'
         NetAmount as zwo_amt   
} where PurchasingDocumentDeletionCode = ''
