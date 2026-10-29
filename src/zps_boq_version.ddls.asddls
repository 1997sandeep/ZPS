@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Version Dropdown'
define root view entity ZPS_BOQ_VERSION
  with parameters
    pproj : zclient
  as select from zpst_boq_mast2

{
  key zproj_ext    as Proj,
      zboq_version as ZboqVersion

}
where
  zproj_ext = $parameters.pproj
group by
  zproj_ext,
  zboq_version
