@AbapCatalog.sqlViewName: 'YBEAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam No Check'
define view ZPP_BEAM_NOCHECK as select from ZBEAM_LENGTH as a 
left outer join zbeam_creation_f4_cds as b on ( b.Beamno = a.beamno )
{
    key a.plant,
    key a.beamno as beamno,
    key a.method,
    key a.machinegroup,
  //  key a.slipno,
    cast( cast( b.Beamlength as abap.dec( 15, 3 )) - cast( a.beamlength as abap.dec( 15, 3 )) as abap.dec( 15, 3 ))   as beamlength,
   //  b.ManufacturingOrder as  prod_order,
        a.processname
      
} 

group by 
        a.plant,
        a.beamno,
        a.method,
        a.machinegroup,
        a.processname,
        b.Beamlength,
        a.beamlength
        //b.ManufacturingOrder,
  //      slipno
