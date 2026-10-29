@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR data fetch for approval'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPS_DPR_APPR_GET
//  with parameters
//    pproj : zproj_ext
  as select from zpst_scp_dpr_r1 as a
          left outer join ZPS_DPR_APPR_SUM as b on  a.zwo_no   = b.zwo_no
                                                and a.zwo_item = b.zwo_item
                                                and a.zmat     = b.zmat
          left outer join ZPS_DPR_APPR_SUM1 as c on a.zboq_head_no  = c.zboq_head_no
                                                and a.zboq_item_no  = c.zboq_item_no
                                                and a.posid    = b.posid
{
  key a.zdpr_no,
  key    a.zpspnr,
      a.zboq_head_no,
      a.zboq_item_no,
      a.posid,
      a.zdpr_date,
      a.zboq_head_desc,
      a.zboq_item_desc,
        @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zboq_qty,
      a.zuom as zunit,
      a.zproj_ext,
      ''  as ZboqVersion,
      a.zsubcontract,
      a.zuom,
      a.zdpr_boq,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zsubmitted_no,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zsubmitted_len,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zsubmitted_bre,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zsubmitted_hei,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.ztod_qty,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zcuml_qty,
      a.zresource_utl,
      a.zremark,
      a.zappr_status,
      a.zdpr_from,
      a.zdpr_to,
      a.zdate,
      a.zwo_no,
      a.zwo_item,
      a.zwo_name,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zwo_qty,
      a.zwo_unit,
      a.zmat,
      a.zmat_desc,
      a.zwo_rate,
      a.zwo_amt,
      a.zarea,
      a.ztype_work,
      a.zchain_from,
      a.zchain_to,
      a.zroads,
      a.zlocation,
      a.zsource_loc,
      a.zlayer,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zdpr_qty,
      a.zdpr_flg,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zbal_qty,
      a.created_by,
      a.created_at,
      a.last_changed_by,
      a.last_changed_at,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      a.zprev_qty,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      sum(b.CumDprQty) as CumDprQty,
      @Semantics.quantity.unitOfMeasure : 'zuom'
     sum(c.CumDprQty) as CumDprQty1
}
where a.zappr_status = ''
group by
    a.zdpr_no,
    a.zpspnr,
    a.zboq_head_no,
    a.zboq_item_no,
    a.posid,
    a.zdpr_date,
    a.zboq_head_desc,
    a.zboq_item_desc,
    a.zboq_qty,
    a.zuom,
    a.zproj_ext,
    a.zsubcontract,
    a.zdpr_boq,
    a.zsubmitted_no,
    a.zsubmitted_len,
    a.zsubmitted_bre,
    a.zsubmitted_hei,
    a.ztod_qty,
    a.zcuml_qty,
    a.zresource_utl,
    a.zremark,
    a.zappr_status,
    a.zdpr_from,
    a.zdpr_to,
    a.zdate,
    a.zwo_no,
    a.zwo_item,
    a.zwo_name,
    a.zwo_qty,
    a.zwo_unit,
    a.zmat,
    a.zmat_desc,
    a.zwo_rate,
    a.zwo_amt,
    a.zarea,
    a.ztype_work,
    a.zchain_from,
    a.zchain_to,
    a.zroads,
    a.zlocation,
    a.zsource_loc,
    a.zlayer,
    a.zdpr_qty,
    a.zdpr_flg,
    a.zbal_qty,
    a.created_by,
    a.created_at,
    a.last_changed_by,
    a.last_changed_at,
    a.zprev_qty

//  $parameters.pproj = zproj_ext
//and zappr_status = ''
