@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual Qty Final'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_ACT_FINAL1 
//  with parameters
////    p_proj    : zproj,
////    p_version : zversion,
////    p_vers1   : zversion,
//    p_zboq_from : zdats,
//    p_zboq_to   : zdats    
as select from ZPS_BOQ_COMP_SCR_ACT_FINAL as a //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
    left outer join ZPS_BOQ_COMP_SCR_ACT //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
                                    as g on  g.WBSElementInternalID = a.WBSElementInternalID
{
    key a.WBSElementInternalID,
    a.CompanyCodeCurrency,
         cast( case
         when a.ZboqTamount is not null and g.AmountInCompanyCodeCurrency is null
         then a.ZboqTamount
         when a.ZboqTamount is null and g.AmountInCompanyCodeCurrency is not null
         then g.AmountInCompanyCodeCurrency

         when a.ZboqTamount is not null and g.AmountInCompanyCodeCurrency is not null
         then cast( a.ZboqTamount as abap.dec(15,2)) + 
              cast( g.AmountInCompanyCodeCurrency as abap.dec(15,2))  

         else 0.00
         end as abap.dec(15,2) 
         )as ZboqTamount 

}
 