CLASS zcl_dyes_print_2 DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES if_oo_adt_classrun .
        CLASS-METHODS :
        read_posts
        importing
        slip_no type string
        RETURNING VALUE(result12) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DYES_PRINT_2 IMPLEMENTATION.


METHOD read_posts.
data lv_xml TYPE string.

SELECT * from zdyes_and_che WITH PRIVILEGED ACCESS as a
      WHERE a~slipno = @slip_no INTO table @data(it).

SELECT * from zdyes_and_che2  WITH PRIVILEGED ACCESS  as a
LEFT OUTER JOIN I_ProductValuationBasic  WITH PRIVILEGED ACCESS  as b on a~material = b~Product and a~plant = b~ValuationArea
WHERE a~slipno = @slip_no and a~quantity <> '0' into table @data(it2).


*SELECT  noofpeace FROM zbeam_noofpeace WHERE Beamno = @it-beamno into TABLE  @data(noofpeace).


LOOP AT it ASSIGNING FIELD-SYMBOL(<fs_it>).
  SELECT   COUNT(*)
    FROM zbeam_create_tab
    WHERE Beamno = @<fs_it>-beamno
    and deletationflag <> 'X'
    INTO  @DATA(noofpeace).

    DATA noofpeace1 LIKE noofpeace.

    noofpeace1 =  noofpeace1 + noofpeace.
ENDLOOP.


READ TABLE it INTO data(head) INDEX 1.
READ TABLE it2 INTO data(head2) INDEX 1.

DATA DEPT TYPE STRING.
data add1 TYPE string .
data add2 type string.
data add3 type string.
data add4 type string.
data gst type string.
data cin type string.
data pan type string.


if  head-plant = '1101' or head-plant = '1103'.
add1 = 'SONASELECTION INDIA LIMITED'.
add2 = '18th KM Stone, Chittorgarh Road, Harmirgarh,'.
add3 = 'Bhilwara, Rajasthan (311025)'.
add4 = 'Tel.:01482-286041'.
cin = 'U17299RJ2022PLC079631'.
pan = 'ABHCS8575K'.
gst = '08ABHCS8575K1ZI'.

ELSEIF head-plant = '3201'.
add1 = 'SONA STYLES LIMITED'.
add2 = 'Plot No 1/270/1 and 270/2, Chittor Road, Guwardi,'.
add3 = 'Bhilwara, Rajasthan (311025)'.
add4 = 'Tel.:01482-299207'.
cin = 'U18109RJ2009PLC028314'.
pan = 'AAMCS8050K'.
gst = '08AAMCS8050K1ZT'.

 ELSEIF head-plant = '5101' .
add1 = 'SONA PROCESSORS(INDIA) LIMITED'.
add2 = '12th KM Stone, Village - Guwardi, Chittorgarh Road,'.
add3 = 'Bhilwara, Rajasthan (311025)'.
add4 = 'Tel.:01482-249041'.
cin = 'U17117RJ1993PLC007381'.
pan = 'AACCS9287L'.
gst = '08AACCS9287L1ZK'.

ELSEIF head-plant = '7201'.
add1 = 'SONA TEXFAB PRIVATE LIMITED'.
add2 = '2, Sangam Tower, Old RTO, Gandhi nagar,'.
add3 = 'Bhilwara, Rajasthan (311025)'.
add4 = 'Tel.:01482-299207'.
cin = 'U24304RJ1988PTC004345'.
pan = 'AAGCS0886D'.
gst = '08AAGCS0886D1ZA'.

ENDIF.

data dat type string.
dat = | { head-postingdate+6(2) }/{ head-postingdate+4(2) }/{ head-postingdate+0(4) } | .
data multi type string.
data mandi type string.
if head-multi = 0.
multi =  ''.
else.
multi = head-multi.
ENDIF.

if head-mandi  = 0.
mandi = ''.
else .
mandi = head-mandi .
ENDIF.

lv_xml  =
|<form1> | &&
   |<add1>{ add1 }</add1>|     &&
   |<add2>{ add2 }</add2>| &&
   |<add3>{ add3 }</add3>| &&
   |<add4>{ add4 }</add4>| &&
   |<slipno>{ head-slipno }</slipno>| &&
   |<date>{ dat }</date>| &&
   |<multi>{ multi }</multi>| &&
   |<mandi>{ mandi }</mandi>| &&
   |<peace>{ noofpeace1 }</peace>| &&


   |<shift>{ head-shift }</shift>| .
data beamlenth_tot TYPE p DECIMALS 3.
data beamWeight_tot TYPE p DECIMALS 3.
data totalcosttot TYPE p DECIMALS 2.
data qty TYPE p DECIMALS 3.



LOOP at it INTO data(wa_it).

SELECT * FROM I_ManufacturingOrder WITH PRIVILEGED ACCESS  AS a WHERE
Batch = @wa_it-beamno INTO TABLE @DATA(ORDER).

DATA ORRDER TYPE STRING.
DATA ORRDERFIN TYPE STRING.
DATA SalesORRDER TYPE STRING.
DATA SalesORRDERItem TYPE STRING.
DATA SalesORRDERFIN TYPE STRING.

SORT ORDER BY ManufacturingOrder.

LOOP AT ORDER  INTO DATA(WA_ORDER).

ORRDER = |{ WA_ORDER-ManufacturingOrder ALPHA = OUT }|.
IF ORRDERFIN IS NOT INITIAL.
CONCATENATE ORRDER ORRDERFIN INTO ORRDERFIN SEPARATED BY ''.
ELSE.
ORRDERFIN = |{ WA_ORDER-ManufacturingOrder ALPHA = OUT }|.
ENDIF.

SalesORRDER = |{ WA_ORDER-SalesOrder ALPHA = OUT }|.
SalesORRDERItem = |{ WA_ORDER-SalesOrderItem ALPHA = OUT }|.

IF SalesORRDERFIN IS NOT INITIAL.
CONCATENATE SalesORRDER '/' SalesORRDERItem SalesORRDERFIN INTO SalesORRDERFIN SEPARATED BY ''.
ELSE.
CONCATENATE SalesORRDER '/' SalesORRDERItem INTO SalesORRDERFIN SEPARATED BY ''.

ENDIF.

CLEAR:WA_ORDER,ORRDER,SalesORRDER,SalesORRDERItem.
ENDLOOP.

    lv_xml  =  lv_xml &&

   |<tab1Row2>| &&
    |  <RT>{ wa_it-rt }</RT>| &&
     | <BeamNo>{ wa_it-beamno }</BeamNo>| &&
     | <prodOrder>{ ORRDERFIN }</prodOrder>| &&
     | <matDes>{ wa_it-materialdes }</matDes>| &&
     | <Beamlen>{ wa_it-beamlength }</Beamlen>| &&
     | <BeamW>{ wa_it-beamweight }</BeamW>| &&
     | <WTMTR>{ wa_it-wtmtr }</WTMTR>| &&
     | <Shade>{ wa_it-shade }</Shade>| &&
     | <partyname>{ wa_it-partyname }</partyname>| &&
     | <SalesOrder>{ SalesORRDERFIN }</SalesOrder>| &&
   |</tab1Row2>| .
   beamlenth_tot = beamlenth_tot + wa_it-beamlength.
   beamWeight_tot = beamWeight_tot + wa_it-beamweight.

   clear: wa_it,ORDER,SalesORRDERFIN,ORRDERFIN.

ENDLOOP.

data totalqty TYPE p DECIMALS 3.
data totcost TYPE p DECIMALS 2.
data dyes TYPE p DECIMALS 3.
data chemical TYPE p DECIMALS 3.
data chemicalpmtr TYPE p DECIMALS 3.
data chemicalpkg TYPE p DECIMALS 3.
data dyespmtr TYPE p DECIMALS 3.
data dyespkg TYPE p DECIMALS 3.
data chemical_total TYPE p DECIMALS 2.
data dyes_total TYPE p DECIMALS 2.
data price TYPE p DECIMALS 2.




DELETE ADJACENT DUPLICATES FROM it COMPARING slipno.
sort it2 ASCENDING by a-dyeschem .

LOOP at it INTO data(wa_it1).

LOOP at it2 INTO data(wa_it2) WHERE a-slipno = wa_it1-slipno.

IF wa_it1-multi = '0'.
wa_it1-multi = 1.
ELSE.
wa_it1-multi = wa_it1-multi.
ENDIF.

if wa_it2-b-StandardPrice is INITIAL .
price = wa_it2-b-MovingAveragePrice .
else.
price = wa_it2-b-StandardPrice .
ENDIF.

*if wa_it2-a-dyeschem = 'D'.
*qty = (  wa_it2-a-quantity * beamWeight_tot ) / 100 .
*ELSE .
*qty = wa_it2-a-quantity .
*ENDIF.

totalqty = wa_it1-multi * wa_it2-a-quantity .    "qty.

IF head-processname = 'DYEING' .
wa_it2-a-qtyper = wa_it2-a-quantity.
ENDIF.

totcost = wa_it2-a-qtyper * price.





   lv_xml  = lv_xml &&
  | <tab2Row2>| &&
  |   <dyes>{ wa_it2-a-dyeschem }</dyes>| &&
  |  <particulers>{ wa_it2-a-material_des }</particulers>| &&
  |  <qty>{ wa_it2-a-quantity }</qty>| &&                                      "qty
  |  <cost>{ price }</cost>| &&
  |  <totalqty>{ wa_it2-a-qtyper }</totalqty>| &&
  |  <totalcost>{ totcost }</totalcost>| &&
  |</tab2Row2>| .

 if  wa_it2-a-dyeschem  = 'C'.
  chemical = chemical + totcost .
  chemical_total = chemical_total + totcost.
    ENDIF.
   if  wa_it2-a-dyeschem  = 'D'.
  dyes = dyes + totcost .
  dyes_total = dyes_total + totcost.
    ENDIF.

  totalcosttot = totalcosttot + totcost .

   clear : wa_it2 , totcost, totalqty, price,qty.

 ENDLOOP.

endloop.

if chemical is NOT INITIAL .

chemicalpmtr  =  chemical / beamlenth_tot.
chemicalpkg =  chemical / beamWeight_tot .
ENDIF.

if dyes is NOT INITIAL.
if beamlenth_tot <> 0.
dyespmtr = dyes / beamlenth_tot.
ENDIF.
if beamWeight_tot <> 0.
dyespkg =  dyes / beamWeight_tot .
ENDIF.
ENDIF.

SHIFT head-machineno LEFT DELETING LEADING '0' .

    lv_xml  = lv_xml &&
   |<machineGroup>{ head-machinegroup }</machineGroup>| &&
   |<header>{ head-machinegroup } SLIP</header>| &&
   |<process>{ head-processname }</process>| &&
   |<method>{ head-method }</method>| &&
   |<machin>{ head-machinename }</machin>| &&
   |<mcno>{ head-machineno }</mcno>| &&

   |<perMd>{ dyespmtr }</perMd>| &&
   |<perKd>{ dyespkg }</perKd>| &&
   |<totalcostD>{ dyes_total }</totalcostD>| &&
   |<perMc>{ chemicalpmtr }</perMc>| &&
   |<perKc>{ chemicalpkg }</perKc>| &&
   |<totcostC>{ chemical_total }</totcostC>| &&
   |<permtrtot>{ dyespmtr + chemicalpmtr  }</permtrtot>| &&
   |<perkgtot>{ dyespkg + chemicalpkg }</perkgtot>| &&
   |<totDC>{ totalcosttot }</totDC>| &&
   |</form1>| .

   CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = 'DYES_CHEMICAL_NEW2'
      RECEIVING
        result   = result12 ).

ENDMETHOD.
ENDCLASS.
