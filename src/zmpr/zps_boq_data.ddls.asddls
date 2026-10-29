@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_BOQ_DATA as select from zpst_boq_mast2 as a
left outer join I_EnterpriseProjectElement as b on a.zproj_ext = b.ProjectElement
{

 key a.zproj_ext as Zproj,
 key a.posid as Posid,
 b.ProjectElementDescription,
a.contract_line_item,
 a.zunit as Zunit,
 a.zboq_qty as ZboqQty


}
