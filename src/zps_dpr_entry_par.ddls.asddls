@AbapCatalog.sqlViewName: 'ZDPRENTRYPAR'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Display DPR Entry'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZPS_DPR_ENTRY_PAR
  with parameters
    pproj : zproj_ext,
    begda : zdats,
    endda : zdats
  as select from    zpst_scp_dpr_r1
//    left outer join ZPS_DPR_PREV_QUAN on zpst_scp_dpr_r1.posid = ZPS_DPR_PREV_QUAN.Posid
        left outer join ZPS_DPR_PRE_QTY  on zpst_scp_dpr_r1.posid = ZPS_DPR_PRE_QTY.posid
        left outer join ZPS_DPRNO_LATEST  on  zpst_scp_dpr_r1.zboq_head_no = ZPS_DPRNO_LATEST.ZboqHeadNo
                                          and zpst_scp_dpr_r1.zboq_item_no = ZPS_DPRNO_LATEST.ZboqItemNo
        left outer join  I_EnterpriseProject as a on a.Project  = ZPS_DPR_PRE_QTY.posid
 
{
  key   zpst_scp_dpr_r1.zproj_ext,
        //       @Consumption.filter.mandatory:false
        //       @Consumption.filter.selectionType: #RANGE
        zpst_scp_dpr_r1.zdate,
        zpst_scp_dpr_r1.zdpr_date,
        zpst_scp_dpr_r1.zdpr_from,
        zpst_scp_dpr_r1.zdpr_to,
        zpst_scp_dpr_r1.zdpr_boq,
        //       @Consumption.filter.mandatory:false
        //       @Consumption.filter.selectionType: #SINGLE
        zpst_scp_dpr_r1.posid,
        zpst_scp_dpr_r1.zpspnr,
        zpst_scp_dpr_r1.zdpr_no,
        //       @Consumption.filter.mandatory:false
        //       @Consumption.filter.selectionType: #SINGLE
        zpst_scp_dpr_r1.zboq_head_no,
        zpst_scp_dpr_r1.zboq_head_desc,
        //       @Consumption.filter.mandatory:false
        //       @Consumption.filter.selectionType: #SINGLE
        zpst_scp_dpr_r1.zboq_item_no,
        zpst_scp_dpr_r1.zboq_item_desc,
        zpst_scp_dpr_r1.zuom,
        zpst_scp_dpr_r1.zboq_qty,
        zpst_scp_dpr_r1.meins,
        zpst_scp_dpr_r1.zarea,
        case  zpst_scp_dpr_r1.zsubcontract
        when 'Y'
        then 'Subcontract'
        when 'N'
        then 'Department'
        when 'Subcontract'
        then 'Subcontract'
        when 'Department'
        then 'Department'
        else ''
        end                       as zsubcontract,
        zpst_scp_dpr_r1.menge,
        zpst_scp_dpr_r1.zsubmitted_no,
        zpst_scp_dpr_r1.zsubmitted_len,
        zpst_scp_dpr_r1.zsubmitted_bre,
        zpst_scp_dpr_r1.zsubmitted_hei,
////        ZPS_DPR_PRE_QTY.zprev_qty as zprev_qty,
        zpst_scp_dpr_r1.zprev_qty as zprev_qty,
        zpst_scp_dpr_r1.ztod_qty,
        zpst_scp_dpr_r1.zcuml_qty,
        zpst_scp_dpr_r1.zresource_utl,
        zpst_scp_dpr_r1.zremark,
        zpst_scp_dpr_r1.zappr_status,
        zpst_scp_dpr_r1.zwo_no,
        zpst_scp_dpr_r1.zwo_item,
        zpst_scp_dpr_r1.zwo_name,
        zpst_scp_dpr_r1.zwo_qty,
        zpst_scp_dpr_r1.zmat,
        zpst_scp_dpr_r1.zmat_desc,
        zpst_scp_dpr_r1.zwo_rate,
        zpst_scp_dpr_r1.zwo_amt,
        zpst_scp_dpr_r1.zwo_unit,
        zpst_scp_dpr_r1.ztype_work,
        zpst_scp_dpr_r1.zchain_from,
        zpst_scp_dpr_r1.zchain_to,
        zpst_scp_dpr_r1.zroads,
        zpst_scp_dpr_r1.zlocation,
        zpst_scp_dpr_r1.zsource_loc,
        zpst_scp_dpr_r1.zlayer,
        zpst_scp_dpr_r1.zdpr_qty,
        zpst_scp_dpr_r1.zdpr_flg,
        zpst_scp_dpr_r1.zbal_qty,
        ZPS_DPRNO_LATEST.ZdprNo as latest_dpr,
        a.ProjectStartDate,
      a.ProjectEndDate,
      a.ActualStartDate,
      a.ActualFinishDate,
//      a.responsible_eng,        
        zpst_scp_dpr_r1.created_by,
        zpst_scp_dpr_r1.created_at,
        zpst_scp_dpr_r1.last_changed_by,
        zpst_scp_dpr_r1.last_changed_at
}
where
      zpst_scp_dpr_r1.zproj_ext = $parameters.pproj
  and zpst_scp_dpr_r1.zdate     between $parameters.begda and $parameters.endda
//and zdpr_date >= $parameters.begda and zdpr_date<= $parameters.endda
group by
  zpst_scp_dpr_r1.posid,
  zpst_scp_dpr_r1.zpspnr,
  zpst_scp_dpr_r1.zdpr_no,
  zpst_scp_dpr_r1.zdpr_date,
  zpst_scp_dpr_r1.zboq_head_no,
  zpst_scp_dpr_r1.zboq_head_desc,
  zpst_scp_dpr_r1.zboq_item_no,
  zpst_scp_dpr_r1.zboq_item_desc,
  zpst_scp_dpr_r1.zuom,
  zpst_scp_dpr_r1.meins,
  zpst_scp_dpr_r1.zsubcontract,
  zpst_scp_dpr_r1.menge,
  zpst_scp_dpr_r1.zsubmitted_no,
  zpst_scp_dpr_r1.zsubmitted_len,
  zpst_scp_dpr_r1.zsubmitted_bre,
  zpst_scp_dpr_r1.zsubmitted_hei,
  zpst_scp_dpr_r1.zprev_qty,
  zpst_scp_dpr_r1.ztod_qty,
  zpst_scp_dpr_r1.zcuml_qty,
  zpst_scp_dpr_r1.zresource_utl,
  zpst_scp_dpr_r1.zremark,
  zpst_scp_dpr_r1.zappr_status,
  zpst_scp_dpr_r1.zproj_ext,
  zpst_scp_dpr_r1.created_by,
  zpst_scp_dpr_r1.created_at,
  zpst_scp_dpr_r1.last_changed_by,
  zpst_scp_dpr_r1.last_changed_at,
  zpst_scp_dpr_r1.zboq_qty,
  zpst_scp_dpr_r1.zdpr_from,
  zpst_scp_dpr_r1.zdpr_to,
  zpst_scp_dpr_r1.zwo_no,
  zpst_scp_dpr_r1.zwo_name,
  zpst_scp_dpr_r1.zwo_qty,
  zpst_scp_dpr_r1.zdate,
  zpst_scp_dpr_r1.ztype_work,
  zpst_scp_dpr_r1.zchain_from,
  zpst_scp_dpr_r1.zchain_to,
  zpst_scp_dpr_r1.zroads,
  zpst_scp_dpr_r1.zlocation,
  zpst_scp_dpr_r1.zsource_loc,
  zpst_scp_dpr_r1.zlayer,
  zpst_scp_dpr_r1.zdpr_qty,
  zpst_scp_dpr_r1.zdpr_flg,
  ZPS_DPR_PRE_QTY.zprev_qty,
  zpst_scp_dpr_r1.zbal_qty,
    zpst_scp_dpr_r1.zdpr_boq,
    zpst_scp_dpr_r1.zmat,
    zpst_scp_dpr_r1.zmat_desc,
    zpst_scp_dpr_r1.zwo_rate,
    zpst_scp_dpr_r1.zwo_amt,
    ZPS_DPRNO_LATEST.ZdprNo,
    zpst_scp_dpr_r1.zwo_unit,
    zpst_scp_dpr_r1.zarea,
    zpst_scp_dpr_r1.zwo_item,
    a.ProjectStartDate,
      a.ProjectEndDate,
      a.ActualStartDate,
      a.ActualFinishDate
//      a1.responsible_eng
