@AbapCatalog.sqlViewName: 'ZPSBOQVERVALD1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Validation against Version'
define view ZPS_BOQ_VALIDATION_VERSION
  as select from ZPS_BPO_VALIDATION_VERSION
{
  key Zpspnr,
  key ZboqVersion,
  key ZprojExt
}
