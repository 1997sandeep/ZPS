@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fetch Project and WBS InternalID'
define root view entity ZPS_DPR_ENTRY_IID
  as select from I_EnterpriseProject        as a
    inner join   I_EnterpriseProjectElement as b on a.ProjectInternalID = b.ProjectInternalID
{
  key cast(a.Project as abap.char( 30 ))        as zproj_ext,
      a.ProjectInternalID                       as Projid,
      cast(b.ProjectElement as abap.char( 24 )) as posid,
      b.WBSElementInternalID                    as Wbsid
}
group by
  a.Project,
  a.ProjectInternalID,
  b.ProjectElement,
  b.WBSElementInternalID
