@EndUserText.label: 'Custom entity for MPR'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_MPR'

define custom entity ZMPR_CUSTOM_CDS
//  with parameters
//    P_PROJECT : abap.char(20),
//    P_WBS     : abap.char(24),
//    P_MONTH   : abap.char(2),
//    P_YEAR    : abap.char(4)
{
  @EndUserText.label: 'Sr. No.'
  @UI.lineItem: [{ position: 10 }]
  key SrNo : abap.numc(5);


 key projectid : abap.char(24);
  @EndUserText.label: 'WBSE'
  @UI.lineItem: [{ position: 20 }]
 key WBSE : abap.char(24);
  p_month : abap.char(10);
  p_pre_month : abap.char(10);
  p_year : abap.numc(4);

  @EndUserText.label: 'Description'
  @UI.lineItem: [{ position: 30 }]
  Description : abap.char(100);

  @EndUserText.label: 'Unit'
  @UI.lineItem: [{ position: 40 }]
  Unit : abap.char(10);

  @EndUserText.label: 'BOQ Quantity'
  @UI.lineItem: [{ position: 50 }]
  BOQQuantity : abap.dec(15,3);

  @EndUserText.label: 'BOQ Line Item'
  @UI.lineItem: [{ position: 60 }]
  BOQLineItem : abap.char(30);

  @EndUserText.label: 'Contract Line Item'
  @UI.lineItem: [{ position: 70 }]
  ContractLineItem : abap.char(30);

  @EndUserText.label: 'Qty Executed This Month - Week 1'
  @UI.lineItem: [{ position: 80 }]
  QtyExecutedThisMonthW1 : abap.dec(15,3);

  @EndUserText.label: 'Qty Executed This Month - Week 2'
  @UI.lineItem: [{ position: 90 }]
  QtyExecutedThisMonthW2 : abap.dec(15,3);

  @EndUserText.label: 'Qty Executed This Month - Week 3'
  @UI.lineItem: [{ position: 100 }]
  QtyExecutedThisMonthW3 : abap.dec(15,3);

  @EndUserText.label: 'Qty Executed This Month - Week 4'
  @UI.lineItem: [{ position: 110 }]
  QtyExecutedThisMonthW4 : abap.dec(15,3);

  @EndUserText.label: 'Total Qty Executed This Month'
  @UI.lineItem: [{ position: 120 }]
  QtyExecutedThisTotMonth : abap.dec(15,3);

  @EndUserText.label: '% Progress Achieved This Month'
  @UI.lineItem: [{ position: 130 }]
  ProgressAchievedThisMonth : abap.dec(7,2);

  @EndUserText.label: 'Qty Executed Last Month'
  @UI.lineItem: [{ position: 140 }]
  QtyExecutedLastMonth : abap.dec(15,3);

  @EndUserText.label: 'Qty Completed Till This Month'
  @UI.lineItem: [{ position: 150 }]
  QtyCompletedTillThisMonth : abap.dec(15,3);

  @EndUserText.label: 'Balance Quantity'
  @UI.lineItem: [{ position: 160 }]
  BalanceQuantity : abap.dec(15,3);

  @EndUserText.label: 'Cumulative % Progress Till This Month'
  @UI.lineItem: [{ position: 170 }]
  CumulativeProgressTillMonth : abap.dec(7,2);

  @EndUserText.label: 'Target Qty - Month 1'
  @UI.lineItem: [{ position: 180 }]
  TargetQty3MonthsM1 : abap.dec(15,3);

  @EndUserText.label: 'Target Qty - Month 2'
  @UI.lineItem: [{ position: 190 }]
  TargetQty3MonthsM2 : abap.dec(15,3);

  @EndUserText.label: 'Target Qty - Month 3'
  @UI.lineItem: [{ position: 200 }]
  TargetQty3MonthsM3 : abap.dec(15,3);

  @EndUserText.label: 'Start Date'
  @UI.lineItem: [{ position: 210 }]
  StartDate : abap.dats;

  @EndUserText.label: 'End Date'
  @UI.lineItem: [{ position: 220 }]
  EndDate : abap.dats;

  @EndUserText.label: 'Actual Start Date'
  @UI.lineItem: [{ position: 230 }]
  ActualStartDate : abap.dats;

  @EndUserText.label: 'Expected End Date'
  @UI.lineItem: [{ position: 240 }]
  ExpectedEndDate : abap.dats;

  @EndUserText.label: 'Variance'
  @UI.lineItem: [{ position: 250 }]
  Variance : abap.int4;
}
