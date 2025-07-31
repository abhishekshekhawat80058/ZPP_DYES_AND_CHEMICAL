@AbapCatalog.sqlViewName: 'ZMACHINE_TABLE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dyes and Chemical IssueSlip Creation cds for f4'
define view zmachine_f4_cds as select distinct from zprocess_issue as a 

{
 // key slip_type,

  key a.machinegroup,
  key a.process_name,
  key a.plant
   
}
group by
//slip_type,
a.machinegroup,
a.process_name,
a.plant
