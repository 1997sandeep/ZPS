@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget report wbs F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_BUDGETREPWBSF4 as select distinct from 
I_EnterpriseProject as A left outer join  I_EnterpriseProjectElement as B on ( B.ProjectUUID = A.ProjectUUID )
{
    key A.Project,
  key  B.ProjectElement as WBS,
    B.ProjectElementDescription as WBSDESCRIPTION
}
