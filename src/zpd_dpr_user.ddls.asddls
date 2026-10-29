@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR user'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPD_DPR_USER
  as select from zps_dpr_appr
{

  key plant    as Plant,
      userid   as Userid,
      username as Username

}
