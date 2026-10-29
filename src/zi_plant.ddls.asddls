@AbapCatalog.sqlViewName: 'ZI_PLANT1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_plant'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_plant as select from I_Plant
{
    key Plant,
    PlantName
}
