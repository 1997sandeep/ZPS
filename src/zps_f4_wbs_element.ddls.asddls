@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Standard f4 For WBS Element'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPS_F4_WBS_ELEMENT
  as select distinct from I_EnterpriseProject        as a1
    inner join            I_EnterpriseProjectElement as a2 on a1.ProjectInternalID = a2.ProjectInternalID
{
      // key a1.Project,
      // a1.ProjectDescription,   
  key a2.ProjectElement,
      a2.ProjectElementDescription
}
group by
  a2.ProjectElement,
  a2.ProjectElementDescription
