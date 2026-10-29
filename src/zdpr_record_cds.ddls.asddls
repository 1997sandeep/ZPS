@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Record CDS View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDPR_RECORD_CDS
  as select from zdpr_record
{
  key zdpr_proj_id     as ZdprProjId,
  key zdpr_contract_no as ZdprContractNo,
  key zdpr_wbse        as ZdprWbse,
  key zdpr_header_no   as ZdprHeaderNo,
  key zdpr_line_item   as ZdprLineItem,
      zdpr_contract_li as ZdprContractLi,
      zdpr_wbse_des    as ZdprWbseDes,
      zdpr_date        as ZdprDate,
      zdpr_quantity    as ZdprQuantity,
      zdpr_prv_qty     as ZdprPrvQty,
      zpdr_cum_qty     as ZpdrCumQty,
      zdpr_month       as ZdprMonth,
      zdpr_w1_qty      as ZdprW1Qty,
      zdpr_w2_qty      as ZdprW2Qty,
      zdpr_w3_qty      as ZdprW3Qty,
      zdpr_w4_qty      as ZdprW4Qty,
      zdpr_w5_qty      as ZdprW5Qty,
      zdpr_mon_qty     as ZdprMonQty,
      zdpr_remark      as ZdprRemark,
      zdpr_uom         as ZdprUom,
      zdpr_boq_qty     as ZdprBoqQty,
      zdpr_bal_qty     as ZdprBalQty,
      zdpr_per_work    as ZdprPerWork,
      zdpr_cper_work   as ZdprCperWork,
      zdpr_pln_start   as ZdprPlnStart,
      zdpr_pln_end     as ZdprPlnEnd,
      zdpr_act_start   as ZdprActStart,
      zdpr_act_end     as ZdprActEnd,
      zdpr_variance    as ZdprVariance,
      zdpr_res_engg    as ZdprResEngg,
      zdpr_remarks     as ZdprRemarks
}
