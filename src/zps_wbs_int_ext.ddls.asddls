@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'External wbs to Internal Wbs'
define root view entity ZPS_WBS_INT_EXT
   as select distinct from I_EnterpriseProject as a1

{
  key a1.Project,
      a1.ProjectInternalID,
      a1.ProjectDescription
}
group by
  a1.Project,
  a1.ProjectInternalID,
  a1.ProjectDescription
