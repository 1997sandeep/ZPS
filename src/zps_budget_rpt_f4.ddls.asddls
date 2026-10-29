@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 Entity Budget Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BUDGET_RPT_F4 
as select distinct from I_EnterpriseProjectElement
{
    
    key ProjectElement,
        ProjectElementDescription 
}where ParentObjectUUID is null
