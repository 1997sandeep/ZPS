@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Prev Qty for DPR report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_PRE_QTY 
as select from zpst_scp_dpr_r1 as a1
               left outer join zpst_boq_mast2 as b on  a1.posid = b.posid
                                                   and b.posid is null 

{
key a1.posid,
    b.zunit,
       @Semantics.quantity.unitOfMeasure : 'zunit'         
 //   sum(a1.zdpr_qty) as zprev_qty
    sum(a1.zprev_qty) as zprev_qty

}
group by
a1.posid,
    b.zunit

