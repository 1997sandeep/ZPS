@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For DPR Entry'
define view entity ZPS_DPR_DELETION_CHECK_USER
 as select from zpst_scp_dpr_r1
{
    key zdpr_no,
    zproj_ext
} where zproj_ext is not initial
group by zdpr_no,
    zproj_ext
