@AbapCatalog.sqlViewName: 'YYBEAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Beam Length'
@Metadata.ignorePropagatedAnnotations: true
define view ZBEAM_LENGTH as select from zdyes_and_che as a 
//left outer join zbeam_creation_f4_cds as b on ( b.Beamno = a.beamno )
{
    key a.plant, 
    key a.beamno as beamno,
    key method,
     key deletionflag ,
    key machinegroup,
    sum(a.beamlength) as beamlength,
   
 //   key slipno, 
   //    b.Beamlength - sum(a.beamlength) as beamlength,
            processname
      
} 

where deletionflag = ''
group by 
       a. plant,
       a. beamno,
        method,
        machinegroup,
        processname,
        deletionflag
     //  b.Beamlength
     //  a.beamlength
    //    slipno
