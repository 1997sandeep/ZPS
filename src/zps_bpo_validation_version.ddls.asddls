@AbapCatalog.sqlViewName: 'ZPSBOQVERVALD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Validation for Proj and Version'
define view ZPS_BPO_VALIDATION_VERSION
  //    with parameters parameter_name : parameter_type
  as select distinct from zpst_boq_mast2
{
  key zpspnr       as Zpspnr,
  key zboq_version as ZboqVersion,
  key zproj_ext    as ZprojExt
} where zpspnr is not initial
group by
  zpspnr,
  zboq_version,
  zproj_ext
