@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WbsF4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_MPR_WBS_F4 as select from I_EnterpriseProjectElement
{
    
    key ProjectElement,
        ProjectElementDescription 
}where ParentObjectUUID is null
