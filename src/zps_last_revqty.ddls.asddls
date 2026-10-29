@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Last Estimate QTY for BOQ Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_LAST_REVQTY as select from zpst_boq_mast2 as a
    left outer join ZPS_LAST_VERSION as lv
     on lv.posid = a.posid
     and lv.LastVersion = a.zboq_version
{
    key lv.posid,
    lv.LastVersion,
    a.zboq_vqty as RevisedEstimateQty
    
}
group by lv.posid, lv.LastVersion, a.zboq_vqty
