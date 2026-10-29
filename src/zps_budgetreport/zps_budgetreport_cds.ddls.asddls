@EndUserText.label: 'Project Budget Report'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_PS_BUDGETREPORT'
    }
}
@UI.headerInfo: {
    typeName: 'Project Budget',
    typeNamePlural: 'Project Budget'
}
define root custom entity ZPS_BUDGETREPORT_CDS
{

      //  ---------------- Input screen ----------------
      //  Project Definition - mandatory
      @UI.selectionField : [{ position: 10 }]
      @UI.lineItem       : [{ position: 10, label: 'Project Definition' }]
      @EndUserText.label : 'Project Definition'
  key ProjectDefinition     : abap.char( 24 );

      //  WBS Element - optional. Left blank, every WBS element of the
      //  project is reported.
      @UI.selectionField : [{ position: 20 }]
      @UI.lineItem       : [{ position: 30, label: 'WBS Element' }]
      @EndUserText.label : 'WBS Element'
  key WBSElement            : abap.char( 24 );

      //  Year - mandatory
      @UI.selectionField : [{ position: 30 }]
      @UI.lineItem       : [{ position: 5, label: 'Year' }]
      @EndUserText.label : 'Year'
  key FiscalYear            : abap.numc( 4 );

      //  ---------------- Output ----------------
      @UI.lineItem       : [{ position: 20, label: 'Project Description' }]
      @EndUserText.label : 'Project Description'
      ProjectDescription    : abap.char( 60 );

      @UI.lineItem       : [{ position: 40, label: 'WBS Element Description' }]
      @EndUserText.label : 'WBS Element Description'
      WBSElementDescription : abap.char( 60 );

      //  SEMANTICTAG ACT_COST + PLANNINGCATEGORY BUDGET01
      @Semantics.amount.currencyCode : 'Currency'
      @UI.lineItem       : [{ position: 50, label: 'Budget' }]
      @EndUserText.label : 'Budget'
      Budget                : abap.curr( 23, 2 );

      //  LEDGER 0E and SOURCELEDGER 0E - was called Commitments
      @Semantics.amount.currencyCode : 'Currency'
      @UI.lineItem       : [{ position: 60, label: 'Open PO/WO' }]
      @EndUserText.label : 'Open PO/WO'
      OpenPOWO              : abap.curr( 23, 2 );

      //  LEDGER 0E and SOURCELEDGER 0L, negative values only,
      //  turned positive and summed
      @Semantics.amount.currencyCode : 'Currency'
      @UI.lineItem       : [{ position: 70, label: 'Actuals' }]
      @EndUserText.label : 'Actuals'
      Actuals               : abap.curr( 23, 2 );

      //  Open PO/WO + Actuals
      @Semantics.amount.currencyCode : 'Currency'
      @UI.lineItem       : [{ position: 80, label: 'Assigned Value' }]
      @EndUserText.label : 'Assigned Value'
      AssignedValue         : abap.curr( 23, 2 );

      //  Budget - Assigned Value
      @Semantics.amount.currencyCode : 'Currency'
      @UI.lineItem       : [{ position: 90, label: 'Available Budget' }]
      @EndUserText.label : 'Available Budget'
      AvailableBudget       : abap.curr( 23, 2 );

      @Semantics.currencyCode : true
      @UI.hidden : true
      Currency              : abap.cuky( 5 );

}

