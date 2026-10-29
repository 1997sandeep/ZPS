@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View to Extract BOQ Version'
define root view entity ZPST_BOQMAST_VERSION1 
as select from zpst_boq_mast2
{
  key zpspnr,
  key posid,
      max(zboq_version) as ZboqVersion

}
where
  zboq_item_no is not initial
group by
  zpspnr,
  posid
