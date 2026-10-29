@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPROJECTID_F4 as select from I_EnterpriseProject 
{
    key Project,
     ProjectDescription
}
