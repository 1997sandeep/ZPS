@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ item F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZAOP_BOQLINEITEM_F4 as select from ZPSCDS_BOQMASTER_DISPLAY as A
{
   key A.Posid,
   key A.Zpspnr,
   key A.ZboqHeadNo,
   key A.ZboqItemNo
}
