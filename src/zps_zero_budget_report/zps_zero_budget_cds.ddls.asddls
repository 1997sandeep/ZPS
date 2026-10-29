@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Zero Budget CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPS_ZERO_BUDGET_CDS
  as select from zps_zero_bud_tab
{
  key project               as Project,
  key wbs_element           as WbsElement,
  key boq_item              as BoqItem,
  key category              as Category,
  key material_service_code as MaterialServiceCode,
      definition_           as Definition_,
      project_description   as ProjectDescription,
      wbs_description       as WbsDescription,
      boq_item_description  as BoqItemDescription,
      boq_unit              as BoqUnit,
      boq_quantity          as BoqQuantity,
      zcurr                 as Zcurr,
      @Semantics.amount.currencyCode : 'Zcurr'
      boq_rate              as BoqRate,
      boq_amount            as BoqAmount,
      unit                  as Unit,
      @Semantics.amount.currencyCode : 'Zcurr'
      planned_rates         as PlannedRates,
      planned_qty           as PlannedQty,
      planned_amount        as PlannedAmount,
      total_amount          as TotalAmount
}
