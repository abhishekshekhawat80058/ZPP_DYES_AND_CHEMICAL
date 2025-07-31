@AbapCatalog.sqlViewName: 'YLABDIP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical'
define view ZLEBDIP_DATA as select from zlab_dipprog_tab
{

    key item as Item,
    key lab_dipno as LabDipno,
    key material as Material,
    materieal_des as MateriealDes,
    qty as Qty
}
