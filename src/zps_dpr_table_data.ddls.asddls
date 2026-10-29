@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Table Data'

define view entity ZPS_DPR_TABLE_DATA
as select from zpst_scp_dpr_r1
{
    key zdpr_no,
    key posid,
     zpspnr

}group by zdpr_no,
     zpspnr,
    posid
