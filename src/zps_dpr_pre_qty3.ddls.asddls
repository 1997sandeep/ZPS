@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - DPR Prev Value'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_PRE_QTY3 
with parameters p_dpr : zdpr_no
as select from zpst_scp_dpr_r1 as a1
               left outer join zpst_boq_mast2 as b on  a1.posid = b.posid
                                                   and b.posid is null 
               left outer join ZPS_DPR_PRE_QTY1 as c on  a1.zdpr_no = c.zdpr_no

{
key a1.posid,
    b.zunit,
    c.prev_zdpr,
    @Semantics.quantity.unitOfMeasure : 'zunit'         
 //   sum(a1.zdpr_qty) as zprev_qty
    sum(a1.zprev_qty) as zprev_qty

}
where a1.zdpr_no < $parameters.p_dpr
group by
a1.posid,
    b.zunit,
    c.prev_zdpr
