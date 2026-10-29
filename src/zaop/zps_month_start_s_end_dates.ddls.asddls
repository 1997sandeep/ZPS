@AbapCatalog.sqlViewName: 'ZAOP_DPR1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for AOP DPR Month wise data'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_MONTH_START_S_END_DATES  
 with parameters
    P_Year :  abap.char(4)  

  as select from I_CalendarDate
{
  key CalendarYear,
  key CalendarMonth,
      min( CalendarDate ) as MonthStartDate,
      max( CalendarDate ) as MonthEndDate

}
where CalendarYear = $parameters.P_Year

group by
  CalendarYear,
  CalendarMonth
