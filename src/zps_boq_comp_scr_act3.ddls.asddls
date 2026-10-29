@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual Qty3'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_BOQ_COMP_SCR_ACT3 
//  with parameters  //HS on 04.09.2026
//    p_zboq_from : zdats,
//    p_zboq_to   : zdats    

as select from I_MaterialDocumentItem_2 
       
{
   key  WBSElementInternalID,
        CompanyCodeCurrency,
////        PostingDate,        
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        cast( sum( TotalGoodsMvtAmtInCCCrcy ) as abap.dec( 15, 2 )) as TotalGoodsMvtAmtInCCCrcy 
}
where ( GoodsMovementType = '601' or GoodsMovementType = '602' )
//and   PostingDate between $parameters.p_zboq_from and $parameters.p_zboq_to
group by
    WBSElementInternalID,
    CompanyCodeCurrency
 