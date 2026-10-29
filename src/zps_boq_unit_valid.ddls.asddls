@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ - Unit Validation'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_UNIT_VALID 
as select from I_UnitOfMeasureText
{
     key UnitOfMeasureCommercialName    
}where Language = 'E'
