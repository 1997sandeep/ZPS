@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BPO BOQ linkage'
define root view entity ZPS_BPO_BOQ_LINK 
  as select from ZPS_BPO_BOQ_LINK1
{

key zposid,
zlot_unit,
cast( rate / zlot_qty as abap.dec(13,2) ) as rate,
zlot_qty

}
