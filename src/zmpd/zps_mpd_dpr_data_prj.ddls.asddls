@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MPD DPR Projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_MPD_DPR_DATA_PRJ
  as projection on ZPS_MPD_DPR_DATA_CDS
{
  
  key Sno,              
  key Projectid,        
  key ResourceType,     
  key DprDate,          
  key PositionName,     
  key PositionType,     
  key NumberOfPositions,
      Present,
      Working,
      Breakdown
}
