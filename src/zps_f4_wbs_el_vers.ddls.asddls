@AbapCatalog.sqlViewName: 'ZPSWBSVERSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 WBS with version parameters'
define view ZPS_F4_WBS_EL_VERS
  with parameters
    proj   : zproj_ext,
    p_vern : zversion
  as select from zpst_boq_mast2
{
  key posid,
      zpspnr
}
where
  zboq_version = $parameters.p_vern
