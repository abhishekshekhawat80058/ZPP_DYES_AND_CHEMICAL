@AbapCatalog.sqlViewName: 'YDYES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Temp F4'
define view ZDYES_AND_CHEMICAL_TEMP_F4 as select from I_MaterialBOMLinkDEX as a
left outer join I_ProductDescription_2 as b on (b.Product = a.Material and b.Language = 'E')
left outer join I_Product as c on ( c.Product = a.Material )
{
    key a.Material,
    key a.Plant,
        b.ProductDescription
} 
where c.ProductType = 'ZSDC'
