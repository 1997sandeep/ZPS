@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Value for BOQ'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_DPR 
//  with parameters
//    p_zboq_from : zdats,
//    p_zboq_to   : zdats    
as select from ZPS_BOQ_COMP_SCR_DPR1 as a 
               left outer join zpst_boq_mast2 as b on  a.posid = b.posid
                                                   and b.posid is null 
{
   key a.posid,
       b.zunit,
       @Semantics.quantity.unitOfMeasure : 'zunit'         
       sum( a.zdpr_qty )  as zcuml_qty 
    
} //where a.Zdpr_date1 between $parameters.p_zboq_from and $parameters.p_zboq_to //HS on 04.09.2026
group by
    a.posid,
    b.zunit
