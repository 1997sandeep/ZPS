@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDPR_RECORD'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZDPR_RECORD_PRJ as projection on ZDPR_RECORD_CDS
{
    key ZdprProjId,
    key ZdprContractNo,
    key ZdprWbse,
    key ZdprHeaderNo,
    key ZdprLineItem,
    ZdprContractLi,
    ZdprWbseDes,
    ZdprDate,
    ZdprQuantity,
    ZdprPrvQty,
    ZpdrCumQty,
    ZdprMonth,
    ZdprW1Qty,
    ZdprW2Qty,
    ZdprW3Qty,
    ZdprW4Qty,
    ZdprW5Qty,
    ZdprMonQty,
    ZdprRemark,
    ZdprUom,
    ZdprBoqQty,
    ZdprBalQty,
    ZdprPerWork,
    ZdprCperWork,
    ZdprPlnStart,
    ZdprPlnEnd,
    ZdprActStart,
    ZdprActEnd,
    ZdprVariance,
    ZdprResEngg,
    ZdprRemarks
}
