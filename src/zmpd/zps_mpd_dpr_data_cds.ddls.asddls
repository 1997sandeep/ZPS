@AbapCatalog.sqlViewName: 'ZDPR_MPD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage project data from DPR Screen CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view ZPS_MPD_DPR_DATA_CDS
  as select from zps_mpd_dpr_data
{
  key    sno                 as Sno,
  key    projectid           as Projectid,
  key    resource_type       as ResourceType,
  key    dpr_date            as DprDate,
  key    position_name       as PositionName,
  key    position_type       as PositionType,
  key    number_of_positions as NumberOfPositions,
         present             as Present,
         working             as Working,
         breakdown           as Breakdown
}
