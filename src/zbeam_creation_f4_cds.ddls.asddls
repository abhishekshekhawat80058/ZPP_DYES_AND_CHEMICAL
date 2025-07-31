@AbapCatalog.sqlViewName: 'ZBEAMCREATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Dyes and Chemical IssueSlip Creation'
define view zbeam_creation_f4_cds as select from zbeam_creation_f4_cds_1 as b
 
{
 key   b.Plant,
 key   b.Beamno,
 key   b.Material,
 key   b.Partyname,
 key   b.ManufacturingOrder,
    b.Wtmtr,
    cast(b.Beamlength as abap.dec( 15, 3 )) as Beamlength,
    b.Salesdoc,
    b.Item, 
    b.Description,
    cast( b.Beamwt as abap.dec( 15, 3 )) as Beamwt,
    b.labdip,
    b.ShadeName,
    b.ch
}
 group by
  b.Plant,
    b.Beamno,
    b.Material,
    b.Partyname,
    b.Wtmtr,
    b.Beamlength,
    b.Salesdoc,
    b.Item,
    b.Description,
    b.Beamwt,
    b.ManufacturingOrder,
    b.labdip,
    b.ShadeName,
    b.ch
    
//TR
