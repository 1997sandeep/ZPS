@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - BOQ Validation in DPR'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_BOQ_VAL 
as select from zpst_boq_mast2 as a1
{
  key a1.zproj_ext,
  key a1.posid,
  key a1.zboq_head_no,
  key a1.zboq_item_no,
  sum( zboq_qty )  as zboq_qty,
  sum( zboq_tqty ) as zboq_tqty
       
}
group by
    a1.zproj_ext,
    a1.posid,
    a1.zboq_head_no,
    a1.zboq_item_no
