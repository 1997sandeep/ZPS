@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PS - Actual Value 2'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_ACT2 
//  with parameters                //HS on 04.09.2026
//    p_zboq_from : zdats,
//    p_zboq_to   : zdats    

as select from I_GoodsMovementCube 
       
{
   key  WBSElementInternalID,
        CompanyCodeCurrency,
////        PostingDate,        
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast( sum( GoodsMvtCnsmpnAmtInCCCrcy ) as abap.dec( 15,2 )) as GoodsIssueAmountInCoCodeCrcy 
}
where ( GoodsMovementType = '221' or GoodsMovementType = '101' )
//and   PostingDate between $parameters.p_zboq_from and $parameters.p_zboq_to
group by
    WBSElementInternalID,
    CompanyCodeCurrency
