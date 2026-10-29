@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Annual Operating Plan Cds'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZAOP_DATA_CDS_C
  as select from zaop_tbl_c
{
  key zpspnr                                as Zpspnr,
  key zboq_version                          as ZboqVersion,
  key posid                                 as Posid,
  key zboq_head_no                          as ZboqHeadNo,
  key zboq_item_no                          as ZboqItemNo,
  key plant                                 as Plant,
      year1                                 as Year1,
      zboq_level                            as ZboqLevel,
      zboq_qty                              as ZboqQty,
      zunit                                 as Zunit,
      zboq_head_desc                        as ZboqHeadDesc,
      zboq_item_desc                        as ZboqItemDesc,
      zcurr                                 as Zcurr,
      cast(zboq_rate as abap.dec( 12, 2 ) ) as ZboqRate,
      ztotal_amt                            as ZtotalAmt,
      responsible_eng                       as ResponsibleEng,
      bal_qty                               as Bal_qty,
      jan                                   as Jan,
      feb                                   as Feb,
      march                                 as March,
      april                                 as April,
      may                                   as May,
      june                                  as June,
      july                                  as July,
      aug                                   as Aug,
      sep                                   as Sep,
      oct                                   as Oct,
      nov                                   as Nov,
      dece                                  as Dece,
      created_by                            as CreatedBy,
      created_at                            as CreatedAt,
      last_changed_by                       as LastChangedBy,
      last_changed_at                       as LastChangedAt
}
