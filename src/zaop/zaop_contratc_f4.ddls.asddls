@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CONTRACT F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZAOP_CONTRATC_F4 as select from ZPSCDS_BOQMASTER_DISPLAY as A
{
   key A.Posid,
   key A.Zpspnr,
   key A.ZboqHeadNo,
   key A.ZboqItemNo,
   key A.Contract_line_item
}
