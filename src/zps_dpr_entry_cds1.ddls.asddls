@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Root View For DPR Entry'
@Metadata.allowExtensions: true
define root view entity ZPS_DPR_ENTRY_CDS1
  as select from ZPS_DPR_ENTRY_CDS as a
   left outer join zpst_scp_dpr_r1      as zdpr on  zdpr.zboq_item_no = a.zboq_item_no
                                                 and zdpr.zboq_head_no = a.zboq_head_no
                                                 and zdpr.zdpr_no      = a.zdpr_no
                                                 and zdpr.zpspnr = a.zpspnr
{
            @EndUserText.label: 'DPR No'
  key       a.zdpr_no,
            @EndUserText.label : 'Project Defn'
            a.zpspnr,
            @EndUserText.label: 'DPR Date'
            a.zdpr_date,
            @EndUserText.label: 'BOQ Header No'
            a.zboq_head_no,
            @EndUserText.label: 'BOQ Item No'
            a.zboq_item_no,
            @EndUserText.label: 'Project Name'
            a.posid,
            @EndUserText.label: 'BOQ Header Description'
           a.zboq_head_desc,
            @EndUserText.label: 'BOQ Item Description'
            a.zboq_item_desc,
            @EndUserText.label: 'BOQ Qty'
            cast(a.zboq_qty as abap.dec( 12, 2 )) as zboq_qty,
            @EndUserText.label: 'Unit'
            a.zunit,
            @EndUserText.label : 'Type of Sub Contractor'
            a.zsubcontract,
            @EndUserText.label : 'UnitOfMeasure'
            a.zuom,
            @EndUserText.label : 'DPR BOQ'
            a.zdpr_boq,
            @EndUserText.label : 'Submitted No'
            a.zsubmitted_no,
            @EndUserText.label : 'Submitted Length'
            a.zsubmitted_len,
            @EndUserText.label : 'Submitted Breadth'
            a.zsubmitted_bre,
            @EndUserText.label : 'Submitted Height'
            a.zsubmitted_hei,
            @EndUserText.label : 'Previous Executed Qty'
            a.zprev_qty,
            @EndUserText.label : 'Today Executed Qty'
            a.ztod_qty,
            @EndUserText.label : 'Cumulative Executed Qty'
            a.zcuml_qty,
            @EndUserText.label : 'Resource Utilization'
            a.zresource_utl,
            @EndUserText.label : 'Remarks'
            a.zremark,
            @EndUserText.label : 'Approval Status'
            a.zappr_status,
            @EndUserText.label: 'Project Element Text'
            a.zproj_ext,
            @EndUserText.label: 'BOQ Version'
            a.ZboqVersion,
            @EndUserText.label: 'Dpr Date From'
            a.zdpr_from,
            @EndUserText.label: 'Dpr Date To'
            a.zdpr_to,
            @EndUserText.label: 'Date'
            a.zdate,
            @EndUserText.label: 'WO Number'
            a.zwo_no,
            @EndUserText.label: 'WO Number'
            a.zwo_item,            
            @EndUserText.label: 'Sub Contract Name'
            a.zwo_name,
            @EndUserText.label: 'WO Qty'
            a.zwo_qty,
            @EndUserText.label: 'WO Unit'
            a.zwo_unit,
            @EndUserText.label: 'Material'
            a.zmat,
            @EndUserText.label: 'Material'
            a.zmat_desc,
            @EndUserText.label: 'Service Rate'
            a.zwo_rate,
            @EndUserText.label: 'Service Amt'
            a.zwo_amt,
            @EndUserText.label: 'Type of Work'
            a.ztype_work,
            @EndUserText.label: 'Chainage from'
            a.zchain_from,
            @EndUserText.label: 'Chainage to'
            a.zchain_to,
            @EndUserText.label: 'Roads'
            a.zroads,
            @EndUserText.label: 'Location'
            a.zlocation ,
            @EndUserText.label: 'Source Location'
            a.zsource_loc,
            @EndUserText.label: 'Layers'
            a.zlayer,
            @EndUserText.label: 'DPR QTY'
            a.zdpr_qty,
            a.zdpr_flg,
            a.zarea,
            a.projectstartdate,
            a.projectenddate  ,
            a.actualstartdate ,
            a.actualfinishdate,
            a.responsible_eng ,
            cast( a.amount as abap.dec( 12,2 ) ) as amount,
            a.subcontactor,
            a.location as location,
            zdpr.zdms,
            zdpr.zfile,
            zdpr.zfilename,
            zdpr.zmimetype,
            
            a.zboq_rate,
            @Semantics.user.createdBy: true
            @EndUserText.label: 'Created By'
            a.created_by,
//            @Semantics.user.createdBy: true
            @EndUserText.label: 'Created At'
            a.created_at,
            @Semantics.user.lastChangedBy: true
            @EndUserText.label: 'Last Changed By'
            a.last_changed_by,
//            @Semantics.user.lastChangedBy: true
            @EndUserText.label: 'Last Changed At'
            a.last_changed_at,
            0 as ExcelRowNumber,
            '' as flag
}
