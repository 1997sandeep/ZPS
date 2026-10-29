@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Report UI'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_DPR_REPORT_UI
  with parameters
    p_zboq_from : dats,
    p_zboq_to   : dats
  as  select distinct from  ZPS_DPR_REPORT22( p_zboq_from :$parameters.p_zboq_from ,p_zboq_to :$parameters.p_zboq_to  ) as a
inner join I_EnterpriseProject as b on b.Project = a.zproj_ext
inner join I_EnterpriseProjectElement as c on c.ProjectElement = a.posid
left  outer join ZCUMUL_QTY( p_zboq_to: $parameters.p_zboq_to  ) as d on a.posid = d.posid and a.zproj_ext = d.zproj_ext
and a.zboq_item_no = d.zboq_item_no

{
       @UI.facet: [{ id: 'zpspnr', purpose: #STANDARD,
               type:#IDENTIFICATION_REFERENCE,
               label:'DPR Summary Report', position: 10 }]
       @UI.lineItem             : [{ position: 10 }]
       @UI.identification: [{ position: 10  }]
//       @UI.selectionField       : [{position: 10}]
       @EndUserText.label       : 'Project'
  key  a.zpspnr,
//       @UI.lineItem             : [{ position: 20 }]
//       //          @UI.selectionField       : [{position: 30}]
//       @UI.identification: [{ position: 20  }]
//       @EndUserText.label       : 'DPR No'
//  key  zdpr_no,
       @UI.lineItem             : [{ position: 30 }]
       @UI.identification: [{ position: 30  }]
       @EndUserText.label       : 'BOQ Header No.'
       a.zboq_head_no,
       @UI.lineItem             : [{ position: 40 }]
       @UI.identification: [{ position: 40  }]
       @EndUserText.label       : 'BOQ Line Item No.'
       a.zboq_item_no,
       @UI.lineItem             : [{ position: 50 }]
       @UI.identification: [{ position: 50  }]
       @EndUserText.label       : 'WBSE'
       a.posid,
       @UI.lineItem             : [{ position: 50 }]
       @UI.identification: [{ position: 50  }]
       @EndUserText.label       : 'WBSE Description'
       c.ProjectElementDescription,
       
       a.zboq_item_desc,
       @UI.lineItem             : [{ position: 80 }]
       @UI.identification: [{ position: 80  }]
       @EndUserText.label       : 'BOQ Quantity'
       a.zboq_qty,
       @UI.lineItem             : [{ position: 90 }]
       @UI.identification: [{ position: 90  }]
       @EndUserText.label       : 'Unit'      
       a.zunit,
       @UI.lineItem             : [{ position: 100 }]
       @UI.identification: [{ position: 100  }]
       @EndUserText.label       : 'UOM'
       a.zuom,
       @UI.lineItem             : [{ position: 120 }]
       @UI.identification: [{ position: 110  }]
       @EndUserText.label       : 'DPR No'
       a.zdpr_boq,
       @UI.lineItem             : [{ position: 120 }]
       @UI.identification: [{ position: 120  }]
       @EndUserText.label       : 'Project'
       @Consumption.valueHelpDefinition: [{ entity : { name:    'zps_dpr_f4_project_def', element   : 'Project'  }}]
       @UI.selectionField       : [{position: 10}]
       a.zproj_ext,
       @UI.lineItem             : [{ position: 120 }]
       @UI.identification: [{ position: 120  }]
       @EndUserText.label       : 'Project Description'
//       @Consumption.valueHelpDefinition: [{ entity : { name:    'zps_dpr_f4_project_def', element   : 'Project'  }}]
       @UI.selectionField       : [{position: 10}]
       b.ProjectDescription,
       
       @UI.lineItem             : [{ position: 140 }]
       @UI.identification: [{ position: 140  }]
       a.zmat,
       @UI.lineItem             : [{ position: 150 }]
       @UI.identification: [{ position: 150  }]
       @EndUserText.label       : 'DPR No'
       a.zmat_desc,
       @UI.lineItem             : [{ position: 160 }]
       @UI.identification: [{ position: 160  }]
       @EndUserText.label       : 'DPR No'
       a.ztype_work,
       @UI.lineItem             : [{ position: 180 }]
       @UI.identification: [{ position: 180  }]
       @EndUserText.label       : 'Executed Quantity'
       @Semantics.quantity.unitOfMeasure : 'zuom'       
       a.zdpr_qty,
       d.zdpr_qty as comu_qty,
       
       @UI.lineItem             : [{ position: 190 }]
       @UI.identification: [{ position: 190  }]
       @EndUserText.label       : 'Balance Quantity'
       cast(
    coalesce( cast( a.zboq_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    - coalesce( cast( d.zdpr_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    as abap.dec(26,2)
) as CUM_QTY,
//a.CUM_QTY,


       @UI.lineItem             : [{ position: 200 }]
       @UI.identification: [{ position: 200  }]
       @EndUserText.label       : 'Percent Work Complete'
cast(
    coalesce( cast( d.zdpr_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    / coalesce( cast( a.zboq_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    * cast( 100 as abap.decfloat34 )
    as abap.dec(26,2)
) as Perc_WC,

'' as amount,
//cast(
//    coalesce( cast( a.zdpr_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
//    / coalesce( cast( a.zboq_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
//    * cast( 100 as abap.decfloat34 )
//    as abap.dec(26,2)
//) as Perc_WC,
//       @UI.lineItem             : [{ position: 210 }]
//       @UI.identification: [{ position: 210  }]
//       @EndUserText.label       : 'Percent Work Remaining'
// cast(
//    coalesce( cast( a.CUM_QTY as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
//    / coalesce( cast( a.zboq_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
//    * cast( 100 as abap.decfloat34 )
//    as abap.dec(26,2)
//) as Pec_W_rem
cast( 100 -
    coalesce( cast( d.zdpr_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    / coalesce( cast( a.zboq_qty as abap.decfloat34 ), cast( 0 as abap.decfloat34 ) )
    * cast( 100 as abap.decfloat34 )
    as abap.dec(26,2)
) as Pec_W_rem

}
