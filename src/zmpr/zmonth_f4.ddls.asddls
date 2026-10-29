@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Month f4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMONTH_F4 as select from I_CalendarDate as a
left outer join I_CalendarMonthText as b on b.CalendarMonth = a.CalendarMonth
                                        and b.Language = 'E'
{
   key a.CalendarMonth ,
   b.CalendarMonthName
}
group by a.CalendarMonth,
    b.CalendarMonthName
