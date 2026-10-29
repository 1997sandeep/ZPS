@AbapCatalog.sqlViewName: 'ZTOT_DPR1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Summary'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_DPR_MONTH_SUMMERY1 as select from ZPS_DPR_MONTH_SUMMERY
{
    key zproj_ext,
    key posid,
    key CalYear,
    key CalMonth,
    sum(zdpr_qty) as Total_dpr
} 
group by  
    zproj_ext,
    posid,
    CalYear,
    CalMonth
