@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual Qty Final'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_ACT_FINAL 
//  with parameters
////    p_proj    : zproj,
////    p_version : zversion,
////    p_vers1   : zversion,
//    p_zboq_from : zdats, //HS on 04.09.2026
//    p_zboq_to   : zdats    

as select from I_EnterpriseProjectElement as a 
    left outer join ZPS_BOQ_COMP_SCR_ACT2 //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
                                    as g on  g.WBSElementInternalID = a.WBSElementInternalID                                                  
    left outer join ZPS_BOQ_COMP_SCR_ACT3   //( p_zboq_from : $parameters.p_zboq_from , p_zboq_to : $parameters.p_zboq_to )  
                                    as h on  h.WBSElementInternalID = a.WBSElementInternalID                                                  
       
{
   key  a.WBSElementInternalID,
        g.CompanyCodeCurrency, 
////        PostingDate,        
////        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
         cast( case
         when g.GoodsIssueAmountInCoCodeCrcy is not null and h.TotalGoodsMvtAmtInCCCrcy is null
         then g.GoodsIssueAmountInCoCodeCrcy
         when g.GoodsIssueAmountInCoCodeCrcy is null and h.TotalGoodsMvtAmtInCCCrcy is not null
         then h.TotalGoodsMvtAmtInCCCrcy

         when g.GoodsIssueAmountInCoCodeCrcy is not null and h.TotalGoodsMvtAmtInCCCrcy is not null
         then g.GoodsIssueAmountInCoCodeCrcy + h.TotalGoodsMvtAmtInCCCrcy  

         else 0.00
         end as abap.dec(15,2) 
         )as ZboqTamount 
}
