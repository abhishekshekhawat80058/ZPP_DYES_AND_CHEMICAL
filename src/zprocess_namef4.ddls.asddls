@AbapCatalog.sqlViewName: 'YPRONAMEF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Process Name F4'
define view ZPROCESS_NAMEF4 as select from zprocess_issue
{
    key plant,
    key process_name 
} 
group by 
plant,
process_name
