@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 Consume View DPR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPS_DPR_F4_BOQ_HEAD_ITEM
  as select distinct from I_EnterpriseProject as a1
    left outer join   zpst_boq_mast2      as zp1 on a1.Project = zp1.zproj_ext
{
  key a1.Project,
      zp1.zboq_head_no,
      zp1.zboq_head_desc,
      zp1.zboq_item_no,
      zp1.zboq_item_desc
} where zp1.zboq_head_no is not null
group by a1.Project,
    zp1.zboq_head_no,
    zp1.zboq_head_desc,
    zp1.zboq_item_no,
    zp1.zboq_item_desc
