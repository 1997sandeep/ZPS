@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_PS_DPR_APPR
  provider contract transactional_query
  as projection on ZR_PS_DPR_APPR
{
  key Plant,
  key Userid,
  Username,
  Localcreatedby,
  Localcreatedat,
  Locallastchangedby,
  Locallastchangedat,
  Lastchangedat
  
}
