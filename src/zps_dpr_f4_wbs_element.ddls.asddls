@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 Consume View DPR Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPS_DPR_F4_WBS_ELEMENT
  as select distinct from I_EnterpriseProject        as a1
    inner join            I_EnterpriseProjectElement as a2 on a1.ProjectInternalID = a2.ProjectInternalID

  //  as select distinct from zpst_boq_mast1 as a1
  ////  inner join I_EnterpriseProject as a2
  ////  on a1.zpspnr = a2.ProjectInternalID
  //  inner join I_EnterpriseProjectElement as a2
  //  on a1.posid = a2.ProjectElement

  //{
  //// key a1.Project,
  //// a1.ProjectDescription,
  //key a2.ProjectElement,
  // a2.ProjectElementDescription
  // } group by a2.ProjectElement,
  //            a2.ProjectElementDescription

{
  key a1.Project,
      a2.ProjectElement,
      a2.ProjectElementDescription
}
group by
  a1.Project,
  a2.ProjectElement,
  a2.ProjectElementDescription
