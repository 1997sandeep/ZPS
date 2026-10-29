@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Report CDS View'
define view entity ZPS_DPR_REPORT 
 with parameters 
     p_zboq_from : dats, 
     p_zboq_to   : dats 
 as select from ZPS_DPR_ENTRY_CDS1
{
//    key zdpr_no,
  key zproj_ext,
    zpspnr,
//    zdpr_date,
    zboq_head_no,
    zboq_item_no,
    posid,
    zboq_head_desc,
    zboq_item_desc,
    zboq_qty,
    zunit,
    zuom,
    zdpr_boq,
//    zremark,
    zmat,
    zmat_desc,
    ztype_work,
//    zdate,
    @Semantics.quantity.unitOfMeasure : 'zuom'
    sum( zdpr_qty ) as zdpr_qty
    
}
//  where zdpr_date >= $parameters.p_zboq_to or
//        zdpr_date <= $parameters.p_zboq_from
where concat(substring(zdpr_date,7,4), concat(substring(zdpr_date,4,2), substring(zdpr_date,1,2)))
        between $parameters.p_zboq_from and $parameters.p_zboq_to
//       
 group by 
//     zdpr_no,
    zpspnr,
    zboq_head_no,
    zboq_item_no,
    posid,
    zboq_head_desc,
    zboq_item_desc,
    zboq_qty,
    zunit,
    zuom,
    zdpr_boq,
//    zremark,
    zproj_ext,
    zmat,
    zmat_desc,
    ztype_work    
