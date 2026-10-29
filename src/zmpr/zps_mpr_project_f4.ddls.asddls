@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_MPR_PROJECT_F4 as select from I_EnterpriseProject as A
{
    key A.Project,
     A.ProjectDescription
}
