@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Last Version QTY for BOQ Report'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_LAST_VERSION as select from zpst_boq_mast2
{
    key zpspnr,
    key posid,
    max(zboq_version) as LastVersion,
    zboq_item_no
}
group by 
    zpspnr,
    posid,
    zboq_item_no
