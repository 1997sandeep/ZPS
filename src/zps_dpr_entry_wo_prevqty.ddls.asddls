@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PreviousQty Against WO DPR'
define root view entity ZPS_DPR_ENTRY_WO_PREVQTY
  as select distinct from zpst_scp_dpr_r1   as a
    left outer join       ZPS_DPR_ENTRY_IID as b on  a.zpspnr    = b.Projid
                                                 and a.zproj_ext = b.zproj_ext
                                                 and a.posid     = b.posid
{
  key a.zpspnr,
  key a.zproj_ext,
      a.posid,
      b.Wbsid,
      a.zwo_no,
      a.zuom,
      @Semantics.quantity.unitOfMeasure : 'zuom'
      sum(a.zdpr_qty) as zprev_qty
}
//where
//  a.zwo_no is not initial
group by
  a.zpspnr,
  a.zproj_ext,
  a.posid,
  a.zwo_no,
  a.zuom,
  b.Wbsid
