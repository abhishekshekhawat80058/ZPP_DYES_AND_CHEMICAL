@AbapCatalog.sqlViewName: 'YSHDE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shed'
define view ZSHEDH_DIPLAP as select from zlab_dipprog_tab
{
    
    key lab_dipno as LabDipno,
    shade_name as ShadeName
} 
group by 
       lab_dipno,
       shade_name
