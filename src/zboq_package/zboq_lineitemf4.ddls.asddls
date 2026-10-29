@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQLINEITEMF4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBOQ_LINEITEMF4 as select from ZPSCDS_BOQMASTER_DISPLAY as A
{
  key  A.Posid,
    A.Zpspnr,
    A.ZboqHeadNo,
    A.ZboqItemNo
}
