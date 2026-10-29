@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BPO BOQ linkage - sum of WBS rate'
define root view entity ZPS_BPO_BOQ_LINK1
  as select from zps_bpo_wbs as a
    inner join   zps_bpo     as b on a.zbpo_name = b.zbpo_name

{
  key a.zposid,
      b.zlot_unit,
      @Semantics.quantity.unitOfMeasure : 'zlot_unit'
      cast(sum( b.zvalue_total ) as abap.dec( 13, 2 ) ) as rate,
      cast(b.zlot_qty as abap.dec( 13, 2 ) ) as zlot_qty
}
group by
  a.zposid,
  b.zlot_unit,
  b.zlot_qty
