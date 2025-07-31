@AbapCatalog.sqlViewName: 'YCHANGEDATA2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Data Change'
define view ZDYES_AND_CHE2_CHANGE_DATA as select from zdyes_and_che2
{
    key slipno as Slipno,
    key material_temp as MaterialTemp,
    key material as Material,
    material_des as MaterialDes,
    quantity as Quantity,
    qtyadd,
    qtyper   as Qtyper,
    dyeschem,
    deletionflag as Deletionflag
}
where deletionflag <> 'X' and quantity <> 0
