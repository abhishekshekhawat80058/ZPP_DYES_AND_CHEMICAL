@AbapCatalog.sqlViewName: 'YSLIPF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Slip Number F4'
define view ZDYES_AND_CHEM_SLIP_NO as select from zdyes_and_che
{
    key slipno
} 
group by 
      slipno
