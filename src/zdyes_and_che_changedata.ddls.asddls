@AbapCatalog.sqlViewName: 'YCHANGEDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Data Change'
define view ZDYES_AND_CHE_CHANGEDATA as select from zdyes_and_che
{
    key slipno as Slipno,
    key beamno as Beamno,
    key prod_order   as ManufacturingOrder,
    machinegroup as machinegroup,
    machineno  as Machineno, 
    machinename as Machinename,
    processname as Processname,
    method as Method,
    multi as Multi,
    mandi as Mandi,
    remark as Remark,
    additionchk as Additionchk,
    plant as Plant,
    storagelocation as Storagelocation,
    programno as Programno,
    shade as Shade,
    dyestype as Dyestype,
    dyestemp as Dyestemp,
    partyname as Partyname,
    salesorder as Salesorder,
    materialdes as Materialdes,
    beamlength as Beamlength,
    beamweight as Beamweight,
    shift as Shift,
    rt    as RT,
    wtmtr as Wtmtr,
    postingdate as Postingdate,
    deletionflag   as Deletionflag,
    department     as Department
} 
where deletionflag <> 'X'
