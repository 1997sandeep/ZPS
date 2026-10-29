@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_MPD_UPLOD_PRJ
  as projection on ZPS_MPD_UPLOD_CDS
{
  key Sno,
  key Projectid,
  key ResourceType,
  key PositionName,
  key PositionType,
  key NumberOfPositions
}
