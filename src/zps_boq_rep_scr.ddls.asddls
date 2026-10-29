@AbapCatalog.sqlViewName: 'ZPSBOQREPSCR'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ Report Screen'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_BOQ_REP_SCR 
 with parameters
    p_zboq_from : zdats,
    p_zboq_to   : zdats    
    as select from zpst_boq_mast2 as a 
    left outer join I_EnterpriseProject  as b on a.zpspnr = b.ProjectInternalID
    left outer join ZPS_BOQ_COMP_SCR_DPR as c on c.posid = a.posid
{
    key a.zpspnr as Zpspnr,
    key a.zboq_version as ZboqVersion,
//    key a.zboq_version as Version,
     a.posid as Posid,
     a.zboq_head_no as ZboqHeadNo,
     a.zboq_item_no as ZboqItemNo,
     a.zboq_to,
     a.zboq_from,
    a.zboq_qty as ZboqQty,
    a.zunit as Zunit,
    a.zboq_head_desc as ZboqHeadDesc,
    a.zboq_item_desc as ZboqItemDesc, 
    @Semantics.quantity.unitOfMeasure : 'zunit'
    c.zcuml_qty as zboqtqty,
    a.zboq_vqty,
    a.zboq_blqty,
    b.Project,
//    @UI.lineItem: [{ position: 30, label: 'Bal. Qty' }]
//    @UI.selectionField: [ { position: 5 } ]  // if needed
    a.zboq_blqty - a.zboq_tqty as bal_qty,
//    @UI.lineItem: [{ position: 40, label: 'Qty Variance' }]
//    @UI.selectionField: [ { position: 6 } ]
    coalesce(a.zboq_blqty, 0) - coalesce(a.zboq_vqty, 0) as qty_variance
}
