@EndUserText.label: 'Custom Entity Budget Report'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_BUDGET_REPORT'
    }
}

@UI: {
  headerInfo: { 
    typeName: 'Bugdet Report',
    typeNamePlural: 'Budget Report',
    title: { value: 'ProjectElement' },
    description: { value: 'ProjectElement' }
  }
}

define root custom entity ZPS_BUDGET_RPT
{
      @UI.facet      : [
           {
             id      :  'Budget_Data',
             purpose :  #STANDARD,
             type    :  #IDENTIFICATION_REFERENCE,
             label   :  'WBS Element',
             position: 10 }
         ]

      @UI.lineItem   : [{ position: 10 }]
      @UI.selectionField : [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Project / WBS Element'      
      key ProjectElement  : abap.char( 40 );
  
//      @UI.lineItem   : [{ position: 20 }]
//      @UI.selectionField : [{position: 20}]
//      @UI.identification: [{position: 20}]
//      @EndUserText.label: 'WBS Internal ID'      
//  key wbselementinternalid  : abap.char(30);    

      @UI.lineItem   : [{ position: 20 }]
      @UI.selectionField : [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label: 'WBS Level'      
      level1  : abap.int1;

//      @UI.lineItem   : [{ position: 30 }]
//      @UI.selectionField : [{position: 30}]
//      @UI.identification: [{position: 30}]
//      @EndUserText.label: 'WBS Sub Level'      
//      wbs_level  : abap.char( 20);

//      @UI.lineItem   : [{ position: 40 }]
//      @UI.identification: [{position: 40}]
//      PARENTOBJECTUUID      : abap.char( 20 );

      @UI.lineItem   : [{ position: 50 }]
      @UI.identification: [{position: 50}]
      @EndUserText.label: 'Project / WBS Element Desc'      
      wbs_desc  : abap.char( 20 );

      @UI.lineItem   : [{ position: 60 }]
      @UI.identification: [{position: 60}]
      @EndUserText.label: 'Parent WBS Element'      
      p_wbs  : abap.char( 20 );

      @UI.lineItem   : [{ position: 70 }]
      @UI.identification: [{position: 70}]
      @EndUserText.label: 'Parent WBS Element Desc'      
      p_desc  : abap.char( 20 );

      @UI.lineItem   : [{ position: 80 }]
      @UI.identification: [{position: 80}]
      @EndUserText.label: 'Original Budget'      
      org_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 90 }]
      @UI.identification: [{position: 90}]
      @EndUserText.label: 'Supplement Budget'      
      supl_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 100 }]
      @UI.identification: [{position: 100}]
      @EndUserText.label: 'Budget Send'      
      send_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 110 }]
      @UI.identification: [{position: 110}]
      @EndUserText.label: 'Budget Receive'      
      recv_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 120 }]
      @UI.identification: [{position: 120}]
      @EndUserText.label: 'Return Budget'      
      retn_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'Current Budget'      
      curr_bdg  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'Current Budget'      
      comittmnt  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'Current Budget'      
      act_cost  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'Current Budget'      
      assign_cost  : abap.dec( 13,2 );

      @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'Current Budget'      
      avbl_bdg  : abap.dec( 13,2 );

  
}
