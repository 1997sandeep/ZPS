@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Attchment CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZDPR_ATTCH_CDS as select from zpst_scp_dpr_r1
{
    key zproj_ext as proj_id,
    key zdpr_date as ZdprDate,
    key zdpr_no as Zdpr_no,
   key posid as Posid,
    zdms as Zdms,
    zfile as Zfile,
    zmimetype as Zmimetype,
    zfilename as Zfilename
} where zmimetype is not initial
