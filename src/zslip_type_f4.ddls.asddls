@AbapCatalog.sqlViewName: 'ZSLIP_TYPE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SLIP-type_f4'
define view ZSLIP_type_f4 as select from zprocess_issue
{
   key plant,
 key process_name,
 key machinegroup
}
group by
plant,
 process_name,
  machinegroup
