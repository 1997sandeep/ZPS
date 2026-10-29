@AbapCatalog.sqlViewName: 'ZDPRTOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_DPR_MONTH_SUMMERY as select from ZPS_DPR_ENTRY_CDS1

{ key zproj_ext,
  key posid,
  key substring( cast( zdate as abap.char( 8 ) ), 1, 4 ) as CalYear,
  key substring( cast( zdate as abap.char( 8 ) ), 5, 2 ) as CalMonth,
      zdpr_qty 

}
