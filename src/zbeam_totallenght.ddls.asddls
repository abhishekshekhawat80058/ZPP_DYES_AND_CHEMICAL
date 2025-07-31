@AbapCatalog.sqlViewName: 'YMEABTTOAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Total Beam Lenght'
@Metadata.ignorePropagatedAnnotations: true
define view ZBEAM_TOTALLENGHT as select from ZPP_BEAM_REPORT
{
    key Plant as Plant,
    key Beamno as Beamno,
    sum( Actgreyquantity ) as TOTALBEAMLENGT
}
group by Plant,
         Beamno
