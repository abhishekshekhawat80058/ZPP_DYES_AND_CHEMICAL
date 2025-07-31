@AbapCatalog.sqlViewName: 'YMATF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Material F4 Addistion'
define view ZPP_MATERIAL_F4 as select from I_ProductStorageLocationBasic as a 
left outer join I_ProductDescription_2 as b on (b.Product = a.Product and b.Language = 'E' )
left outer join I_Product   as c on ( c.Product = a.Product )
left outer join I_MaterialStock_2 as k on a.Product = b.Product
{
    key a.Plant,
//    key a.StorageLocation,
    key a.Product,
        b.ProductDescription,
       sum( k.MatlWrhsStkQtyInMatlBaseUnit ) as mat_stock
} where c.ProductType = 'ZSDC'
 group by 
        a.Plant,
//        a.StorageLocation,
        a.Product,
        b.ProductDescription
