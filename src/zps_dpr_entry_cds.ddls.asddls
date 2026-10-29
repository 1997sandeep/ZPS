@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic CDS View BOQ Master'
define root view entity ZPS_DPR_ENTRY_CDS
  as select from    ZPS_DPRNO_LATEST     as zdpr1
    left outer join zpst_scp_dpr_r1      as zdpr on  zdpr.zboq_item_no = zdpr1.ZboqItemNo
                                                 and zdpr.zboq_head_no = zdpr1.ZboqHeadNo
                                                 and zdpr.zdpr_no      = zdpr1.ZdprNo
    left outer join zpst_boqmast_version as zver on  zdpr.zpspnr       = zver.zpspnr
                                                 and zdpr.zboq_head_no = zver.zboq_head_no
                                                 and zdpr.zboq_item_no = zver.zboq_item_no
    left outer join zpst_boq_mast2       as zboq on  zver.zpspnr       = zboq.zpspnr
                                                 and zver.ZboqVersion  = zboq.zboq_version
                                                 and zver.zboq_head_no = zboq.zboq_head_no
                                                 and zver.zboq_item_no = zboq.zboq_item_no




  //   as select from  zpst_boq_mast2        as zboq
  //      left outer join zpst_boqmast_version  as zver  on  zboq.zpspnr       = zver.zpspnr
  //                                                     and zboq.zboq_version = zver.ZboqVersion
  //                                                     and zboq.zboq_head_no = zver.zboq_head_no
  //                                                     and zboq.zboq_item_no = zver.zboq_item_no
  //      left outer join zpst_scp_dpr_r1       as zdpr  on zboq.posid = zdpr.posid
  //  //    left outer join ZPS_DPR_ENTRY_PREVQTY as zprev on  zboq.zboq_item_no = zprev.ZboqItemNo
  //  //                                                   and zboq.zpspnr       = zprev.zpspnr
  //  //                                                   and zboq.zboq_head_no = zprev.zboq_head_no
  //      left outer join ZPS_DPRNO_LATEST      as zdpr1 on  zdpr.zboq_item_no = zdpr1.ZboqItemNo
  //                                                     and zdpr.zboq_head_no = zdpr1.ZboqHeadNo
  //                                                     and zdpr.zdpr_no      = zdpr1.ZdprNo

{
  key              zdpr.zdpr_no,
                   //  key              zdpr1.ZdprNo as zdpr_no,
  key              zboq.zpspnr,
  key              zboq.zboq_head_no,
  key              zboq.zboq_item_no,
  key              zboq.posid,
                   zdpr.zdpr_date,
                   zboq.zboq_head_desc,
                   zboq.zboq_item_desc,
                   zboq.zboq_qty,
                   cast(zboq.zboq_rate as abap.dec( 12, 2 )) as zboq_rate ,
                   zboq.zunit,
                   zboq.zproj_ext,
                   zver.ZboqVersion,
                   zdpr.zsubcontract,
                   zdpr.zuom,
                   zdpr.zdpr_boq,
                   zdpr.zsubmitted_no,
                   zdpr.zsubmitted_len,
                   zdpr.zsubmitted_bre,
                   zdpr.zsubmitted_hei,
                   //                   zdpr.zprev_qty, //
                   //                   zdpr.zcuml_qty as zprev_qty, "commented on 18.07.2023
                   @Semantics.quantity.unitOfMeasure : 'zuom'
                   cast(0.000 as abap.quan( 13, 3 )) as zprev_qty, //added on 18.07.2023
                   //                   zprev.ZprevQty as zprev_qty,
                   zdpr.ztod_qty,
                   zdpr.zcuml_qty,
                   zdpr.zresource_utl,
                   zdpr.zremark,
                   zdpr.zappr_status,
                   zdpr.zdpr_from,
                   zdpr.zdpr_to,
                   zdpr.zdate,
                   zdpr.zwo_no,
                   zdpr.zwo_item,
                   zdpr.zwo_name,
                   zdpr.zwo_qty,
                   zdpr.zwo_unit,
                   zdpr.zmat,
                   zdpr.zmat_desc,
                   zdpr.zwo_rate,
                   zdpr.zwo_amt,
                   zdpr.zarea,

                   zdpr.ztype_work,
                   zdpr.zchain_from,
                   zdpr.zchain_to,
                   zdpr.zroads,
                   zdpr.zlocation,
                   zdpr.zsource_loc,
                   zdpr.zlayer,
                   zdpr.zdpr_qty,
                   zdpr.zdpr_flg,
                   zdpr.zbal_qty,
                   zdpr.projectstartdate,
                   zdpr.projectenddate,
                   zdpr.actualstartdate,
                   zdpr.actualfinishdate,
                   zdpr.responsible_eng,
                   zdpr.amt as amount,
                   zdpr.subcontactor,
                   zdpr.location,
                   zdpr.created_by,
                   zdpr.created_at,
                   zdpr.last_changed_by,
                   zdpr.last_changed_at
}
where
  zver.ZboqVersion is not null
//  and zdpr.zdpr_no is null
group by
  zdpr.zdpr_no,
  zboq.zpspnr,
  zboq.zboq_head_no,
  zboq.zboq_item_no,
  zboq.posid,
  zdpr.zdpr_date,
  zboq.zboq_head_desc,
  zboq.zboq_item_desc,
  zboq.zboq_qty,
  zboq.zunit,
  zboq.zproj_ext,
  zver.ZboqVersion,
  zdpr.zsubcontract,
  zdpr.zsubmitted_no,
  zdpr.zsubmitted_len,
  zdpr.zsubmitted_bre,
  zdpr.zsubmitted_hei,
  zdpr.zprev_qty,
  zdpr.ztod_qty,
  zdpr.zcuml_qty,
  zdpr.zresource_utl,
  zdpr.zremark,
  zdpr.zappr_status,
  zdpr.zdpr_from,
  zdpr.zdpr_to,
  zdpr.created_by,
  zdpr.last_changed_by,
  zdpr.zuom,
  zdpr.created_at,
  zdpr.last_changed_at,
  zdpr.zdate,
  zdpr.zwo_no,
  zdpr.zwo_name,
  zdpr.zwo_qty,
  zdpr.ztype_work,
  zdpr.zchain_from,
  zdpr.zchain_to,
  zdpr.zroads,
  zdpr.zlocation,
  zdpr.zsource_loc,
  zdpr.zlayer,
  zdpr.zdpr_qty,
  zdpr.zdpr_flg,
  zdpr.zbal_qty,
  zdpr.zdpr_boq,
  zdpr.zmat,
  zdpr.zmat_desc,
  zdpr.zwo_rate,
  zdpr.zwo_amt,
  zdpr.zwo_unit,
  zdpr.zarea,
  zdpr.projectstartdate,
  zdpr.projectenddate,
  zdpr.actualstartdate,
  zdpr.actualfinishdate,
  zdpr.responsible_eng,
  zdpr.zwo_item,
    zdpr.amt,
    zdpr.subcontactor,
    zboq.zboq_rate,
    zdpr.location
//  zprev.ZprevQty,
//    zdpr1.ZdprNo
