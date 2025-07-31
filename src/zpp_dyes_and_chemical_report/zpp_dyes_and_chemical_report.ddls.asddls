@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DYES_AND_CHEMICAL_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZPP_DYES_AND_CHEMICAL_REPORT as select from zdyes_and_che as a
left outer join zdyes_and_che2 as b on ( b.slipno = a.slipno  and b.deletionflag = '')

left outer join I_ProductValuationBasic   as c on c.Product = b.material and b.plant = c.ValuationArea
{



     @UI.lineItem                : [{ position: 10 }]
     @UI.selectionField          :  [{ position: 10 }]
     @EndUserText.label          : 'slipno'
     key a.slipno ,
 
    @UI.lineItem                : [{ position: 20 }]
//    @UI.selectionField          :  [{ position: 20 }]
    @EndUserText.label          : 'Beam No.'
    key a.beamno,
 
 
    @UI.lineItem                : [{ position: 30 }]
//    @UI.selectionField          :  [{ position: 30 }]
    @EndUserText.label          : 'prod_order'
    key a.prod_order,
 
 
    @UI.lineItem                : [{ position: 40 }]
//    @UI.selectionField          :  [{ position: 40 }]
    @EndUserText.label          : 'machineno'
    key a.machineno,
 
  
    @UI.lineItem                : [{ position: 50 }]
//    @UI.selectionField          :  [{ position: 50 }]
    @EndUserText.label          : 'machinegroup'
 key  a.machinegroup,
 
 
    @UI.lineItem                : [{ position: 60 }]
//    @UI.selectionField          :  [{ position: 60 }]
    @EndUserText.label          : 'machinename'
  key  a.machinename ,
 
 
    @UI.lineItem                : [{ position: 70 }]
//    @UI.selectionField          :  [{ position: 70 }]
    @EndUserText.label          : 'processname'
  key  a.processname ,
 
 
 
    @UI.lineItem                : [{ position: 80 }]
//    @UI.selectionField          :  [{ position: 80 }]
    @EndUserText.label          : 'method'
   key a.method ,
 
 
    @UI.lineItem                : [{ position: 90 }]
//    @UI.selectionField          :  [{ position: 90 }]
    @EndUserText.label          : 'programno'
  key  a.programno ,
 
 
    @UI.lineItem                : [{ position: 100 }]
//    @UI.selectionField          :  [{ position: 100 }]
    @EndUserText.label          : 'multi'
   key a.multi ,
 
    @UI.lineItem                : [{ position: 120 }]
//    @UI.selectionField          :  [{ position: 120 }]
    @EndUserText.label          : 'mandi'
  key  a.mandi ,
 
 
    @UI.lineItem                : [{ position: 130 }]
//    @UI.selectionField          :  [{ position: 130 }]
    @EndUserText.label          : 'remark'
  key  a.remark ,
 
 
    @UI.lineItem                : [{ position: 140 }]
//    @UI.selectionField          :  [{ position: 140 }]
    @EndUserText.label          : 'additionchk'
  key  a.additionchk ,
 
 
    @UI.lineItem                : [{ position: 150 }]
    @UI.selectionField          :  [{ position: 150 }]
    @EndUserText.label          : 'plant'
  key  a.plant ,
 
 
    @UI.lineItem                : [{ position: 160 }]
//    @UI.selectionField          :  [{ position: 160 }]
    @EndUserText.label          : 'storagelocation'
  key  a.storagelocation,
 
 
 
    @UI.lineItem                : [{ position: 170 }]
//    @UI.selectionField          :  [{ position: 170 }]
    @EndUserText.label          : 'shade'
   key a.shade,
 
 
    @UI.lineItem                : [{ position: 180 }]
//    @UI.selectionField          :  [{ position: 180 }]
    @EndUserText.label          : 'dyestype'
   key a.dyestype ,
 
 
    @UI.lineItem                : [{ position: 190 }]
//    @UI.selectionField          :  [{ position: 190 }]
    @EndUserText.label          : 'dyestemp '
  key  a.dyestemp ,
 
 
    @UI.lineItem                : [{ position: 200 }]
//    @UI.selectionField          :  [{ position: 200 }]
    @EndUserText.label          : 'partyname'
  key  a.partyname ,
 
 
    @UI.lineItem                : [{ position: 210 }]
//    @UI.selectionField          :  [{ position: 210 }]
    @EndUserText.label          : 'salesorder'
  key  a.salesorder  ,
 
 
    @UI.lineItem                : [{ position: 220 }]
//    @UI.selectionField          :  [{ position: 220 }]
    @EndUserText.label          : 'materialdes'
  key  a.materialdes ,
 
 
    @UI.lineItem                : [{ position: 230 }]
//    @UI.selectionField          :  [{ position: 230 }]
    @EndUserText.label          : 'beamlength '
   key a.beamlength ,
 
 
    @UI.lineItem                : [{ position: 240 }]
//    @UI.selectionField          :  [{ position: 240 }]
    @EndUserText.label          : 'beamweight'
  key  a.beamweight ,
 
 
    @UI.lineItem                : [{ position: 250 }]
//    @UI.selectionField          :  [{ position: 250 }]
    @EndUserText.label          : 'shift'
  key a.shift ,
 
 
    @UI.lineItem                : [{ position: 260 }]
//    @UI.selectionField          :  [{ position: 260 }]
    @EndUserText.label          : 'rt'
   key a.rt ,
 
    @UI.lineItem                : [{ position: 270 }]
//    @UI.selectionField          :  [{ position: 270 }]
    @EndUserText.label          : 'wtmtr'
   key a.wtmtr,
 
 
    @UI.lineItem                : [{ position: 280 }]
//    @UI.selectionField          :  [{ position: 280 }]
    @EndUserText.label          : 'totbeamlength'
  key  a.totbeamlength,
 
 
    @UI.lineItem                : [{ position: 290 }]
    @UI.selectionField          :  [{ position: 290 }]
    @EndUserText.label          : 'postingdate'
   key a.postingdate,
 
 
    @UI.lineItem                : [{ position: 320 }]
//    @UI.selectionField          :  [{ position: 320 }]
    @EndUserText.label          : 'material_temp.'  
 key   b.material_temp,

    @UI.lineItem                : [{ position: 330 }]
//    @UI.selectionField          :  [{ position: 330 }]
    @EndUserText.label          : 'material'
  key  b.material ,



    @UI.lineItem                : [{ position: 340 }]
//    @UI.selectionField          :  [{ position: 340 }]
    @EndUserText.label          : 'material_des'
  key  b.material_des ,

    @UI.lineItem                : [{ position: 350 }]
//    @UI.selectionField          :  [{ position: 350 }]
    @EndUserText.label          : 'quantity' 
    @Aggregation.default: #SUM
  key  b.quantity ,


    @UI.lineItem                : [{ position: 360 }]
//    @UI.selectionField          :  [{ position: 360 }]
    @EndUserText.label          : 'qtyper' 
    @Aggregation.default: #SUM
  key  b.qtyper ,


    @UI.lineItem                : [{ position: 370 }]
//    @UI.selectionField          :  [{ position: 370 }]
    @EndUserText.label          : 'dyeschem' 
  key b.dyeschem     ,
      @UI.lineItem                : [{ position: 300 }]
//    @UI.selectionField          :  [{ position: 300 }]
    @EndUserText.label          : 'postingdate1'
    a.postingdate1 ,
 
 
    @UI.lineItem                : [{ position: 310 }]
//    @UI.selectionField          :  [{ position: 310 }]
    @EndUserText.label          : 'deletionflag'
    a.deletionflag  ,
    
    c.Currency,
  
     @UI.lineItem                : [{ position: 310 }]
//    @UI.selectionField          :  [{ position: 310 }]
    @EndUserText.label          : 'material price1'
     @Semantics.amount.currencyCode: 'Currency'
    c.StandardPrice ,  
  
    @UI.lineItem                : [{ position: 310 }]
//    @UI.selectionField          :  [{ position: 310 }]
    @EndUserText.label          : 'material price'
      @Semantics.amount.currencyCode: 'Currency'
    c.MovingAveragePrice 
//   
}
//where a.deletionflag = '' or b.deletionflag = ''
