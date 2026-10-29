@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cumulative Qty'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCUMUL_QTY
    with parameters
// p_zboq_from : dats, 
     p_zboq_to   : dats 
  as select from ZPS_DPR_ENTRY_CDS
{
//  key     zdpr_no,
  key zproj_ext,
  key posid,
  key zboq_item_no,
//     zdpr_date,
     sum( cast( zdpr_qty as abap.dec( 12, 2 ))) as zdpr_qty
}
//  where cast(
//        concat( substring( zdpr_date, 7, 4 ),
//        concat( substring( zdpr_date, 4, 2 ),
//                substring( zdpr_date, 1, 2 ) ) ) as abap.dats )
//      <= $parameters.p_zboq_to
 group by
// zdpr_no,
    zproj_ext,
    posid,
    zboq_item_no
//    zdpr_date
