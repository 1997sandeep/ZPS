@AbapCatalog.sqlViewName: 'ZPSWBSF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 WBS with parameters'
define view ZPS_F4_WBS_EL_PARAM
  with parameters
    p_proj    : zproj_ext
  as select distinct from I_EnterpriseProject        as a1
    inner join            I_EnterpriseProjectElement as a2 on a1.ProjectInternalID = a2.ProjectInternalID
{
      // key a1.Project,
      // a1.ProjectDescription,
  key a2.ProjectElement,
      a2.ProjectElementDescription
}
//where a1.ProjectInternalID = $parameters.p_proj
where a1.Project = $parameters.p_proj
group by
  a2.ProjectElement,
  a2.ProjectElementDescription
