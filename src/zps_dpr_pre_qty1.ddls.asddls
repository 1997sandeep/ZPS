@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - DPR Prev Value'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_PRE_QTY1 
as select from zpst_scp_dpr_r1 as a1
               left outer join zpst_boq_mast2 as b on  a1.posid = b.posid
                                                   and b.posid is null 

{
key a1.posid,
    a1.zdpr_no,
    cast( a1.zdpr_no as abap.int4 ) - 1  as prev_zdpr,
    b.zunit,
    @Semantics.quantity.unitOfMeasure : 'zunit'         
    a1.zprev_qty as zprev_qty

}

