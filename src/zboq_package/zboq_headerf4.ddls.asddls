@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HeaderF4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZBOQ_HEADERF4 as select distinct from ZPSCDS_BOQMASTER_DISPLAY as A
{
   key A.Posid,
    A.Zpspnr,
    A.ZboqHeadNo
}
