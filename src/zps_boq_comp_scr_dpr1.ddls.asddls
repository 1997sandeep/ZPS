@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Value for BOQ'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_DPR1 
as select from zpst_scp_dpr_r1
{

   key zproj_ext,
   key posid,
       zuom,
       @Semantics.quantity.unitOfMeasure : 'zuom'         
       zcuml_qty,
       @Semantics.quantity.unitOfMeasure : 'zuom'         
       zdpr_qty,
       zdpr_date,

cast(
 concat(
   concat( substring(zdpr_date, 7, 4), 
           substring(zdpr_date, 4, 2) 
  ),
substring(zdpr_date, 1, 2)
  )
 as abap.dats) 
 as Zdpr_date1                 

}where zdpr_boq = 'Y' and zappr_status = 'APPR'
