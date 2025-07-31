@AbapCatalog.sqlViewName: 'YMEHTODF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Method F4'
define view ZMETHOD_F4 as select from zprocess_issue
{
    
    key machinegroup,
    key process_name,
    key mathod,
    key plant
} 
group by 
machinegroup,
process_name,
mathod,
plant
