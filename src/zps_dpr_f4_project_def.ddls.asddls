@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'F4 Consume View DPR Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zps_dpr_f4_project_def

  as select distinct from I_EnterpriseProject        as a1
    inner join            I_EnterpriseProjectElement as a2 on a1.ProjectInternalID = a2.ProjectInternalID
//    as select distinct from I_EnterpriseProject as a1
//    inner join I_EnterpriseProjectElement as a2
//    on a1.ProjectInternalID = a2.ProjectInternalID

//  as select distinct from zpst_boq_mast1      as a1
//    inner join            I_EnterpriseProject as a2 on a1.zpspnr = a2.ProjectInternalID

  //{
  // key a1.Project,
  // a1.ProjectDescription,
  // a1.ProjectInternalID
  //// a2.ProjectElement,
  //// a2.ProjectElementDescription
  // } group by a1.Project,
  //            a1.ProjectDescription,
  //            a1.ProjectInternalID
{
//  key a1.zproj_ext as Project,
//      a2.ProjectDescription,
//      a2.ProjectInternalID
key a1.Project  as Project,
 a1.ProjectDescription,
 a1.ProjectInternalID

}
group by
  a1.Project,
  a1.ProjectDescription,
  a1.ProjectInternalID
