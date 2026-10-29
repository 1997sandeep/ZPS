@AccessControl.authorizationCheck:  #NOT_REQUIRED
@EndUserText.label: 'View to Extract BOQ Version'
define root view entity zpst_boqmast_version
  as select from zpst_boq_mast2
{
  key zpspnr,
  key zboq_head_no,
  key zboq_item_no,
      max(zboq_version) as ZboqVersion

}
where
  zboq_item_no is not initial
group by
  zpspnr,
  zboq_head_no,
  zboq_item_no
