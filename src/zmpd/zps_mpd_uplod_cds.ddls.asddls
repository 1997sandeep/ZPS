@AbapCatalog.sqlViewName: 'ZPS_MPD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage project data CS'
@Metadata.ignorePropagatedAnnotations: true
define root view ZPS_MPD_UPLOD_CDS
  as select from zps_mpd_uplod
{
  key    sno                 as Sno,
  key    projectid           as Projectid,
  key    resource_type       as ResourceType,
  key    position_name       as PositionName,
  key    position_type       as PositionType,
  key    number_of_positions as NumberOfPositions
}
