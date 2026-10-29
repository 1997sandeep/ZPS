@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - Approval - DPR Qty Sum'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_APPR_SUM1 
  as select distinct from zpst_scp_dpr_r1 as a
                 left outer join zpst_scp_dpr_r1 as b on  a.posid = b.posid
                                                      and b.posid is null 
  
{
    key a.zboq_head_no ,
    key a.zboq_item_no ,
    key a.posid ,
    b.zuom ,
    @Semantics.quantity.unitOfMeasure : 'zuom'
    sum(a.zdpr_qty) as CumDprQty    
}
where a.zappr_status = 'APPR'
 and  a.zdpr_boq = 'Y'
group by
    b.zuom,
    a.posid,
    a.zboq_head_no,
    a.zboq_item_no
