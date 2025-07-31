@AbapCatalog.sqlViewName: 'YDYES1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyes And Chemical Program'
define view zbeam_creation_f4_cds_1 as select from I_ManufacturingOrder as b
left outer join  ZPP_BEAM_REPORT  as a on ( b.Batch = a.Beamno and b.ProductionPlant = a.Plant ) 
left outer join I_SalesDocumentItem as c on (c.SalesDocument = b.SalesOrder and c.SalesDocumentItem = b.SalesOrderItem )
left outer join I_SalesDocument as e on (e.SalesDocument = b.SalesOrder )
left outer join I_Customer as k on (e.SoldToParty = k.Customer )
left outer join I_Product    as  f on ( f.Product = b.Product ) 
left outer join I_ProductDescription_2    as  g on ( g.Product = b.Product and g.Language = 'E' ) 
left outer join ZSHEDH_DIPLAP    as  d on (d.LabDipno = c.YY1_LabDip_SDI ) 
left outer join  ZBEAM_TOTALLENGHT  as H on ( H.Beamno = a.Beamno and H.Plant = a.Plant ) 
{
 

 key b.PlanningPlant as Plant,
    key b.Batch as Beamno,
    key case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
    then b.Material else a.Material end  as Material,
//    key case when a.beamno = '' or a.beamno is null or a.beamno is initial 
//    then e.SoldToParty else a.partyname end  as Partyname,
     key case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
    then k.CustomerName else a.Partyname end  as Partyname,
        case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
        then division(f.YY1_GLM_PRD , 1000,3) else a.Wtmtr end as Wtmtr,
        case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
        then b.MfgOrderPlannedTotalQty else H.TOTALBEAMLENGT end as Beamlength,
        b.SalesOrder as Salesdoc,
        b.SalesOrderItem as Item,
        case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
        then g.ProductDescription else a.Description end  as Description,
        case when a.Beamno = '' or a.Beamno is null or a.Beamno is initial 
//        then cast( b.MfgOrderPlannedTotalQty * (division(f.YY1_GLM_PRD , 1000,3)) as abap.dec( 13, 2 ) ) else a.beamwt3 end  as Beamwt,
        then cast( b.MfgOrderPlannedTotalQty * (division(f.YY1_GLM_PRD , 1000,3)) as abap.dec( 13, 2 ) ) else ( H.TOTALBEAMLENGT * a.Wtmtr )  end  as Beamwt,
        b.ManufacturingOrder,
        c.YY1_LabDip_SDI  as labdip,
        d.ShadeName,
        a.Beamno as ch
    
}
 where  //a.deletationflag <> 'X' and
b.Batch <>''

 group by 
b.PlanningPlant,
b.Batch,
 a.Beamno,
a.Material,
a.Partyname,
k.CustomerName,
f.YY1_GLM_PRD,
b.MfgOrderPlannedTotalQty,
a.Wtmtr,
e.SoldToParty,
H.TOTALBEAMLENGT,
b.SalesOrder,
b.SalesOrderItem,
a.Description,
a.beamwt3,
b.Material,
b.ManufacturingOrder,
c.YY1_LabDip_SDI,
d.ShadeName,
 g.ProductDescription 
