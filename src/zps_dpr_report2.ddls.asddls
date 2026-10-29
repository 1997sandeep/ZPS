@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DPR Report CDS View 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPS_DPR_REPORT2 
 with parameters 
     p_zboq_from : dats, 
     p_zboq_to   : dats 
as select from ZPS_DPR_REPORT( p_zboq_from :$parameters.p_zboq_from ,p_zboq_to :$parameters.p_zboq_to  )
{
//    key zdpr_no,
   key zproj_ext,
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
    zmat,
    zmat_desc,
    ztype_work,
//    zdate,
    @Semantics.quantity.unitOfMeasure : 'zuom'
    sum( zdpr_qty ) as zdpr_qty 
//    coalesce(cast(zboq_qty    as abap.dec(26,2)), cast(0 as abap.dec(26,2))) - 
//    coalesce(cast(zdpr_qty    as abap.dec(26,2)), cast(0 as abap.dec(26,2))) as CUM_QTY

}
// where zdpr_date >= $parameters.p_zboq_to or
//        zdpr_date <= $parameters.p_zboq_from  
group by
zproj_ext,
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
//  zremark,            
  zmat,               
  zmat_desc,          
  ztype_work
//    zdpr_qty        
