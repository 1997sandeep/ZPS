@AbapCatalog.sqlViewName: 'ZAOP_DPR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for AOP DPR Month wise data'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_AOP_DPR_MONTH_DATA_CDS  
 with parameters
    P_Year :  abap.char(4)  

  as select from ZPS_MONTH_START_S_END_DATES(P_Year : $parameters.P_Year ) as a  
  left outer join ZAOP_DATA_CDS_C as b on ( b.Year1 = a.CalendarYear )
  left outer join ZPS_DPR_MONTH_SUMMERY1 as C on ( C.zproj_ext = b.Zpspnr and C.posid = b.Posid )
{ key a.CalendarYear,
  key a.CalendarMonth,
      C.posid,
      C.zproj_ext,
      C.Total_dpr
  


}
where a.CalendarYear = $parameters.P_Year
