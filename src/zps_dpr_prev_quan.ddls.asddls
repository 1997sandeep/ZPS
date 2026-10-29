@AbapCatalog.sqlViewName: 'ZPSDPRQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR prev quantity'
define view ZPS_DPR_PREV_QUAN
  as select from zpst_scp_dpr_r1 as a1
   left outer join zpst_boq_mast2 as b on  a1.posid = b.posid
                                                   and b.posid is null 
  
{
  key a1.posid         as Posid,
      b.zunit          as Zuom,
    @Semantics.quantity.unitOfMeasure : 'Zuom'         
      sum(a1.zdpr_qty) as ZdprQty
}
where a1.zdpr_boq = 'Y'
group by
  a1.posid,
  b.zunit
