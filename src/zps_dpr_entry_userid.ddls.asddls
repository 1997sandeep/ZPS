@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fetch Userid'
define root view entity ZPS_DPR_ENTRY_USERID
  as select from zpst_scp_dpruser as a

{
  key a.sr_no       as SrNo,
  key a.zproj_ext   as ZprojExt,
  key a.usname      as Usname,
  key case a.flag
  when 'X'
  then 'true'
  when 'C'
  then 'false'
  else ''
  end               as Flag,
      $session.user as syuname
} where usname = $session.user
group by
  sr_no,
  zproj_ext,
  usname,
  flag
