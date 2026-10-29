@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR No CDS latest View Fetch'
define root view entity ZPS_DPRNO_LATEST
  as select from zpst_scp_dpr_r1 

{
  key     zboq_head_no as ZboqHeadNo,
  key     zboq_item_no as ZboqItemNo,
//  key    max(zdpr_no) as ZdprNo
key zdpr_no as ZdprNo   //HS on 16.09.2026
  
}
//HS on 16.09.2026
//group by
//  zboq_head_no,
//  zboq_item_no
