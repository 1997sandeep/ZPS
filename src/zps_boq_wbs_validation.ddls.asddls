@AbapCatalog.sqlViewName: 'ZPSWBSVALIDATION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Validation for WBS'
define view ZPS_BOQ_WBS_VALIDATION
  //    with parameters parameter_name : parameter_type
  as select distinct from I_EnterpriseProject        as a
    inner join            I_EnterpriseProjectElement as b on a.ProjectInternalID = b.ProjectInternalID
{
  key a.ProjectInternalID    as ProjectId,
  key b.ProjectElement       as WbsElement,
      b.WBSElementInternalID as WbsId,
      a.Project              as ProjectDef

}
where
      a.Project        <> ''
  and b.ProjectElement <> ''
group by
  a.Project,
  a.ProjectInternalID,
  b.ProjectElement,
  b.WBSElementInternalID
