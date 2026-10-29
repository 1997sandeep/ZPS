@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ data'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR1 
as select from I_EnterpriseProject
{
  key Project
}
