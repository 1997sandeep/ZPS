@AbapCatalog.sqlViewName: 'ZPS_AOP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOQ data for Aop'
@Metadata.ignorePropagatedAnnotations: true
define view ZPS_AOP_BOQ
  as select distinct from ZPSCDS_BOQROOT1
{
  key Zpspnr,
  key ZboqHeadNo,
  key ZboqItemNo,
  key ZProjext,
  key Posid,
      ZboqQty,
      ZboqRate
} group by 
Zpspnr,    
ZboqHeadNo,
ZboqItemNo,
ZProjext,  
Posid,     
ZboqQty,   
ZboqRate   
