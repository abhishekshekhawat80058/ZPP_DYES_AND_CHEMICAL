@AbapCatalog.sqlViewName: 'ZMACHINE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'machine name'
@Metadata.ignorePropagatedAnnotations: true
define view ZMachine_name as select from zprocess_issue
{
    key plant,
    key process_name,
    key machinegroup,
    key machine_name,
    mandi
}

group by 
 plant,
 process_name,
 machinegroup,
 machine_name,
 mandi
