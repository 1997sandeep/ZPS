@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Project User Data'
define view entity ZPS_DPR_PROJ_USER 
as select from zps_dpr_appr
{
  key  plant as Plant,
  key  userid  as Userid
}group by plant,
userid

