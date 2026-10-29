@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consume Product CDS'
define root view entity ZPS_PRODUCT_VIEW
  as select from    I_Product            as a
    left outer join I_ProductDescription as b on a.Product = b.Product
{
  key ltrim(b.Product , '0' ) as Product,
      b.ProductDescription,
      a.BaseUnit
}
where
//      b.Product         like '0%'
   b.LanguageISOCode =    'EN'
  and a.BaseUnit <> ''
group by
  b.Product,
  b.ProductDescription,
  a.BaseUnit
