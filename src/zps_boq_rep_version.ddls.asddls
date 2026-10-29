@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_REP_VERSION as select from zpst_boq_mast2

{
  key zproj_ext    as Proj,
      zboq_version as ZboqVersion

}

group by
  zproj_ext,
  zboq_version
