@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPS_BOQ_REPORT  
    as select from zpst_boq_mast2 as a
    left outer join I_EnterpriseProject  as b on a.zpspnr = b.ProjectInternalID
    left outer join ZPS_LAST_REVQTY as c on  c.posid = a.posid
//                                         and c.LastVersion = '001'
    left outer join ZPS_BOQ_REP_SCR_DPR  as d on d.posid = a.posid  
{
    key a.zpspnr as Zpspnr,
    key a.zboq_version as ZboqVersion,
    key a.posid as Posid,
    key a.zboq_head_no as ZboqHeadNo,
    key a.zboq_item_no as ZboqItemNo,
    case
    when a.posid like '______'        then 1  -- 6 chars
    when a.posid like '________'      then 2  -- 8 chars
    when a.posid like '____________'  then 3  -- 12 chars
    when a.posid like '________________'  then 4  -- 16 chars
    when a.posid like '__________________' then 5  -- 18 chars
    when a.posid like '_____________________' then 6  -- 21 chars
    when a.posid like '________________________' then 7  -- 24 chars
    else 0
    end as zboq_level,
    
    a.zboq_qty as ZboqQty,
    a.zunit as Zunit,
    a.zboq_head_desc as ZboqHeadDesc,
    a.zboq_item_desc as ZboqItemDesc, 
//    a.zboq_tqty as zboqtqty,
    a.zboq_vqty,
//    a.zboq_blqty,
    b.Project,
//    max(a.zboq_qty) as RevisedEstimateQty,
    c.RevisedEstimateQty,
//    @UI.lineItem: [{ position: 30, label: 'Bal. Qty' }]
//    @UI.selectionField: [ { position: 5 } ]  // if needed
//    a.zboq_blqty - a.zboq_tqty as bal_qty,
    c.RevisedEstimateQty - a.zboq_tqty as bal_qty,
//    @UI.lineItem: [{ position: 40, label: 'Qty Variance' }]
//    @UI.selectionField: [ { position: 6 } ]
    coalesce(c.RevisedEstimateQty, 0) - coalesce(a.zboq_vqty, 0) as qty_variance,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    d.zcuml_qty as Zboqtqty
}
group by
    a.zpspnr,
    a.zboq_version,
    a.posid,
    a.zboq_head_no,
    a.zboq_item_no,
    a.zboq_level,
    a.zboq_qty,
    a.zunit,
    a.zboq_head_desc,
    a.zboq_item_desc, 
    a.zboq_tqty,
    a.zboq_vqty,
//    a.zboq_blqty,
    b.Project,
    c.RevisedEstimateQty,
    d.zcuml_qty
