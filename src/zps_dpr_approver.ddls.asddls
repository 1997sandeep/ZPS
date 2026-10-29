@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR approver cds'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_DPR_APPROVER 
  as select from ZPS_DPR_APPR1 as a
          left outer join ZPS_DPR_APPR_SUM as b on  a.zwo_no   = b.zwo_no
                                                and a.zwo_item = b.zwo_item
                                                and a.zmat     = b.zmat
                                                and a.posid    = b.posid
          left outer join ZPS_DPR_APPR_SUM1 as c on a.zboq_head_no  = c.zboq_head_no
                                                and a.zboq_item_no  = c.zboq_item_no
                                                and a.posid    = b.posid
{
  key a.zdpr_no,
  key a.zpspnr,
   a.zboq_head_no,
   a.zboq_item_no,
   a.posid,
      a.zdpr_date,
      a.zboq_head_desc,
      a.zboq_item_desc,
      a.zboq_qty,
      a.zunit,
      a.zproj_ext,
      a.ZboqVersion,
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
      b.CumDprQty,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      c.CumDprQty as CumDprQty1

}
