@AbapCatalog.sqlViewName: 'ZPSMATERIALVALD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Validation for Material as Product'
define view ZPS_BOQ_MATERIAL_VALIDATION
  //    with parameters parameter_name : parameter_type
  as select from ZPS_PRODUCT_VIEW
{
  key Product,
      ProductDescription
}
where
  Product <> ''
group by
  Product,
  ProductDescription
