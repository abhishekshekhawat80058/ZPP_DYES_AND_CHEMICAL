@AbapCatalog.sqlViewName: 'YCOMPDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Bom Component'
define view ZBOM_COMPONENT_DATA as select from I_MaterialBOMLinkDEX as a
left outer join I_BillOfMaterialItemDEX_2 as b on ( b.BillOfMaterial = a.BillOfMaterial and b.BillOfMaterialCategory = 'M') 
left outer join I_ProductDescription_2 as c on (c.Product = b.BillOfMaterialComponent and c.Language = 'E' )
{
    key a.Material,
    key a.Plant,
    key b.BillOfMaterialComponent,
        c.ProductDescription,
        b.BillOfMaterialItemUnit,
        case when b.BOMItemSorter = 'C' then b.BillOfMaterialItemQuantity 
        else 0 end as BillOfMaterialItemQuantity,
        b.BOMItemSorter 
}
