@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Standard f4 For Project Defn'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPS_F4_PROJECT_DEF
  as select distinct from I_EnterpriseProject        as a1
    inner join            I_EnterpriseProjectElement as a2 on a1.ProjectInternalID = a2.ProjectInternalID
    left outer join       zpst_boq_mast2             as a3 on a1.Project = a3.zproj_ext
{
  key a1.Project,
      a1.ProjectDescription,
      a1.ProjectInternalID,
      max( a3.zboq_version ) as latest_ver
      // a2.ProjectElement, 
      // a2.ProjectElementDescription
}
group by
  a1.Project,
  a1.ProjectDescription,
  a1.ProjectInternalID
