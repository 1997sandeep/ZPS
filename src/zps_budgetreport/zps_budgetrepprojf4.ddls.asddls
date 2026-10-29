@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_BUDGETREPPROJF4 as select distinct from I_EnterpriseProject as A
{
    key A.Project,
     A.ProjectDescription
}
