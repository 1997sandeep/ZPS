@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual Value for BOQ'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_ACT 
//  with parameters
////    p_proj    : zproj,
////    p_version : zversion,
////    p_vers1   : zversion,
//    p_zboq_from : zdats, //HS on 04.09.2026
//    p_zboq_to   : zdats    

as select from I_OperationalAcctgDocItem 
       
{
   key  WBSElementInternalID,
        AdditionalCurrency1, 
////        PostingDate,        
        @Semantics.amount.currencyCode: 'AdditionalCurrency1'
        cast( sum( AmountInCompanyCodeCurrency ) as abap.dec( 15, 2)) as AmountInCompanyCodeCurrency
}
where ( AccountingDocumentType = 'RE' or AccountingDocumentType = 'KR' )
and   DebitCreditCode = 'S'
//and   PostingDate between $parameters.p_zboq_from and $parameters.p_zboq_to //HS on 04.09.2026
group by
    WBSElementInternalID,
    AdditionalCurrency1
//    PostingDate
