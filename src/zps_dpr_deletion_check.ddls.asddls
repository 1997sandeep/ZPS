@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for RaBill process'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_DPR_DELETION_CHECK 
as select from zpst_scp_dpr_r1 as a
left outer join ZMMT_SCP_RA_BILL_CDS1 as b
 on a.zwo_no = b.Ebeln
and a.zwo_item = b.Ebelp
{
   key a.zdpr_no,
       a.zwo_no,
       b.RaBillFrom,
       b.RaBillTo
}where a.zwo_no is not initial
group by a.zdpr_no,
       a.zwo_no,
       b.RaBillFrom,
       b.RaBillTo
