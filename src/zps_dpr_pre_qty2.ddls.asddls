@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - DPR Prev Value'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_PRE_QTY2 
as select from ZPS_DPR_PRE_QTY1 as a
{
    key posid,
    zdpr_no,
    prev_zdpr,
    zunit,
    @Semantics.quantity.unitOfMeasure : 'zunit'         
    zprev_qty 
}
