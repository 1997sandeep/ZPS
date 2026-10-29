@AbapCatalog.sqlViewName: 'ZPROJWONO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WO no based on project'
define view ZPS_DPR_PROJ_WONO
  with parameters
    proj : zproj_ext
  as select from    I_EnterpriseProject            as a
    left outer join I_EnterpriseProjectElement     as b on a.ProjectInternalID = b.ProjectInternalID
    left outer join I_PurOrdAccountAssignmentAPI01 as c on b.WBSElementInternalID = c.WBSElementInternalID_2
    left outer join I_PurchaseOrderAPI01           as d on c.PurchaseOrder = d.PurchaseOrder
    left outer join I_Supplier                     as e on d.Supplier = e.Supplier
{
  key c.PurchaseOrder,
      e.SupplierFullName,
      '' as WoQty

}
where
  a.Project = $parameters.proj
  and c.PurchaseOrder <> ''
group by
  c.PurchaseOrder,
  e.SupplierFullName,
  d.PurgReleaseTimeTotalAmount
