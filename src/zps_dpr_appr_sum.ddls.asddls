@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - Approval - DPR Qty Sum'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_APPR_SUM 
  as select distinct from zpst_scp_dpr_r1 as a
                 left outer join zpst_scp_dpr_r1 as b on  a.posid = b.posid
                                                      and b.posid is null 
  
{
    key a.zwo_no ,
    key a.posid ,
    a.zwo_item ,
    a.zmat ,
    b.zuom ,
    @Semantics.quantity.unitOfMeasure : 'zuom'
    sum(a.zdpr_qty) as CumDprQty    
}
where a.zappr_status = 'APPR'
group by
    a.zwo_no,
    a.zwo_item,
    a.zmat,
    b.zuom,
    a.posid
