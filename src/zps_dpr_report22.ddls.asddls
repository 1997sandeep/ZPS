@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Report CDS View 22'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_REPORT22
with parameters 
     p_zboq_from : dats, 
     p_zboq_to   : dats 
 as select from ZPS_DPR_REPORT2( p_zboq_from :$parameters.p_zboq_from ,p_zboq_to :$parameters.p_zboq_to  ) 
{
    key zproj_ext,
    zpspnr,
    zboq_head_no,
    zboq_item_no,
    posid,
    zboq_head_desc,
    zboq_item_desc,
    zboq_qty,
    zunit,
    zuom,
    zdpr_boq,
    zmat,
    zmat_desc,
    ztype_work,
     @Semantics.quantity.unitOfMeasure : 'zuom'
    zdpr_qty
//     coalesce(cast(zboq_qty    as abap.dec(26,2)), cast(0 as abap.dec(26,2))) - 
//    coalesce(cast(zdpr_qty    as abap.dec(26,2)), cast(0 as abap.dec(26,2))) as CUM_QTY

}
