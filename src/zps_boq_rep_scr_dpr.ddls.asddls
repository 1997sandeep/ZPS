@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_REP_SCR_DPR 
 
as select from
ZPS_BOQ_COMP_SCR_DPR1 as a left outer join zpst_boq_mast2 as b on  a.posid = b.posid
                                                   and b.posid is null 
{
   key a.posid,
       b.zunit,
       @Semantics.quantity.unitOfMeasure : 'zunit'         
       sum( a.zdpr_qty )  as zcuml_qty 
    
}
group by
    a.posid,
    b.zunit
    
