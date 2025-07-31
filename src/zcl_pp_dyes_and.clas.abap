class ZCL_PP_DYES_AND definition
  public
  create public .

public section.

class-data : pdf type string ,

 pdf_xstring TYPE xSTRING.

  interfaces IF_HTTP_SERVICE_EXTENSION .

      TYPES : BEGIN OF ty,


               Beamno         TYPE string, "zdyes_and_che-beamno,
               PartyName      TYPE string, "zdyes_and_che-partyname,
               SalesOrder     TYPE string,
               ManufacturingOrder  TYPE string, "zdyes_and_che-salesorder,
               MaterialDes    TYPE string ,  "zdyes_and_che-materialdes ,
               BeamLength     TYPE zdyes_and_che-beamlength,
               BeamWeight     TYPE zdyes_and_che-beamweight,
               Shade          type string,
               RT             type string,
               Wtmtr          type string,
               Deletion       type string,
         END OF ty.

         TYPES : BEGIN OF ty3,
                 Material TYPE string,
                 MaterialDescription TYPE string,
                 Quantity TYPE I_MaterialDocumentItem_2-QuantityInBaseUnit,
                 MaterialTemp type string,
                 Qty type string,
                 BOMItemSorter TYPE STRING,
                 Deletion      TYPE STRING,
                 Add      TYPE STRING,
                 Add1      TYPE STRING,

         end of ty3.




 CLASS-DATA IT TYPE TABLE OF ty .
 CLASS-DATA it2 TYPE TABLE of ty3.




   TYPES : BEGIN OF STR,


SlipNo             type string,
Shift              type string,    "       zdyes_and_che-Shift        ,
MachineName        type string,    "       zdyes_and_che-machinename     ,
MachineGroup       type string,    "       zdyes_and_che-machinename     ,
ProcessName        type string,    "       zdyes_and_che-processname     ,
Method             type string,    "       zdyes_and_che-method          ,
Multi              type string,    "       zdyes_and_che-multi           ,
Mandi              type string,    "       zdyes_and_che-mandi           ,
Remark             type string,    "       zdyes_and_che-remark          ,
Additionchk        type string,    "       zdyes_and_che-additionchk     ,
Plant              type string,    "       zdyes_and_che-plant           ,
StorageLocation    type string,    "       zdyes_and_che-storagelocation ,
MachineNo          type string,    "       zdyes_and_che-machineno       ,
Date               type string,
 tabledata like it,
 table2data like it2,
User               type string,
Department         type string,
   END OF STR.





CLASS-DATA RESPO TYPE STR .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_DYES_AND IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


  DATA(req) = request->get_form_fields(  ).
  DATA(body)  = request->get_text(  )  .
  data(type) =  value #( req[ name = 'type' ]-value optional ) .
  data(slipNo) =  value #( req[ name = 'slipno' ]-value optional ) .
  data(slipno1) =  value #( req[ name = 'slipno1' ]-value optional ) .
  data json TYPE string.
  data slip2(10) TYPE c .

  slip2 = |{ slipNo ALPHA = in }|.
if  type <> 'Print' .

 xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).
ENDIF.

SELECT SINGLE SUM( beamlength ) FROM @respo-tabledata as beamweight INTO @DATA(TOTbeamlength) .
IF type = 'Change' .

 DELETE respo-tabledata WHERE beamno IS INITIAL .

  DATA : WA_ZTAB TYPE zdyes_and_che .



       LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<ZGs>).

       WA_ZTAB-slipno            = respo-slipno .
       WA_ZTAB-shift             = respo-shift        .
       WA_ZTAB-machinename       = respo-machinename     .
       wa_ztab-prod_order        = |{ <zGs>-manufacturingorder ALPHA = IN }|.
       WA_ZTAB-processname       = respo-processname     .
       WA_ZTAB-machinegroup      = respo-machinegroup.
       WA_ZTAB-method            = respo-method          .
       WA_ZTAB-multi             = respo-multi           .
       WA_ZTAB-mandi             = respo-mandi           .
       WA_ZTAB-remark            = respo-remark          .
       WA_ZTAB-additionchk       = respo-additionchk     .
       WA_ZTAB-plant             = respo-plant           .
       WA_ZTAB-storagelocation   = respo-storagelocation .
       WA_ZTAB-machineno         = respo-machineno       .
       WA_ZTAB-beamno            = <ZGs>-beamno        .
       WA_ZTAB-partyname         = <ZGs>-partyname     .
       WA_ZTAB-salesorder        = |{ <ZGs>-salesorder  ALPHA = IN }|  .
       WA_ZTAB-materialdes       = <ZGs>-materialdes   .
       WA_ZTAB-beamlength        = <ZGs>-beamlength    .
       WA_ZTAB-beamweight        = <ZGs>-beamweight    .
       WA_ZTAB-rt                = <ZGs>-rt    .
       WA_ZTAB-wtmtr             = <ZGs>-wtmtr    .
       WA_ZTAB-shade             = <ZGS>-shade .
       WA_ZTAB-postingdate       = respo-date+0(4) && respo-date+5(2) && respo-date+8(2).
       wa_ztab-postingdate1      = respo-date.
       WA_ZTAB-deletionflag      = <ZGS>-deletion.
       WA_ZTAB-totbeamlength     = TOTbeamlength.
       WA_ZTAB-department        = respo-department.

      MODIFY zdyes_and_che FROM  @WA_ZTAB.
       CLEAR WA_ZTAB .

       ENDLOOP.

DATA : WA_ZTABLE TYPE zdyes_and_che2  .


*DELETE respo-table2data WHERE  Add1 = 0 .

 LOOP AT respo-table2data INTO DATA(WA1) .

  WA_ZTABLE-slipno        = respo-slipno .
  wa_ztable-plant         = respo-plant.
  wa_ztable-postingdate   = respo-date+0(4) && respo-date+5(2) && respo-date+8(2).
  WA_ZTABLE-material      = WA1-material .
  WA_ZTABLE-material_temp = wa1-materialtemp.
  WA_ZTABLE-material_des  = wa1-materialdescription.
  WA_ZTABLE-quantity      = wa1-quantity + WA1-Add1.
  WA_ZTABLE-qtyper        = wa1-qty.
  wa_ztable-dyeschem      = WA1-bomitemsorter.
  WA_ZTABLE-deletionflag  = WA1-deletion.
  WA_ZTABLE-qtyadd        = WA1-add + WA1-Add1.
  MODIFY zdyes_and_che2 FROM @WA_ZTABLE.
  CLEAR: WA_ZTABLE ,WA1.

  ENDLOOP.

 if sy-subrc is INITIAL.
 json = ' Data Update Succesfully ' . " && ' ' &&  RESPO-slipno .
 else.
 json = 'Error'.
 ENDIF.

 response->set_text(  json  )  .

ELSEif slipNo is not INITIAL AND type = 'Print'.


*data(pdf) = zcl_dyes_print_class=>read_posts( slip_no = slipNo ).
*response->set_text( pdf ).

**********************************************************************


IF slipno1 <> 0 and  slipno1 is NOT INITIAL.

      select slipno from zdyes_and_che  where slipno BETWEEN @slipno and @slipno1 into table  @data(zdyes_it).

ELSE.
      select slipno from zdyes_and_che  where slipno = @slipno  into table  @zdyes_it.


ENDIF.


SORT zdyes_it  BY slipno .
DELETE ADJACENT DUPLICATES FROM zdyes_it COMPARING  slipno  .



 if lines( zdyes_it ) le 30 .
  data(l_merger) = cl_rspo_pdf_merger=>create_instance( ).

 loop at zdyes_it INTO data(wa_zdyes_it)  .
*احصل على بيانات pdf11 الخاصة بنا بتنسيق base64
  slipno   =  wa_zdyes_it-slipno .

      data(pdf) = zcl_dyes_print_class=>read_posts( slip_no = slipNo ) .
      response->set_text(  pdf  )  .
*نقوم بتحويل سلسلة Base64 الخاصة بنا إلى 'Xstri23
 pdf_xstring = xco_cp=>string( pdf )->as_xstring( xco_cp_binary=>text_encoding->base64 )->value.
*نقوم الآن بدمج مستند الطباعة الخاص بنا في فئة الدمج
 l_merger->add_document( pdf_xstring ).

ENDLOOP.

 TRY .
    data(l_poczone_PDF) = l_merger->merge_documents( ).
      CATCH cx_rspo_pdf_merger INTO data(l_exception).
        " Add a useful error handling here
    ENDTRY.
       DATA(response_final) = xco_cp=>xstring( l_poczone_PDF
      )->as_string( xco_cp_binary=>text_encoding->base64
      )->value .

  response->set_text( response_final ) .

else .

  json = 'Error Please Select Maximum 30 Document' .
  response->set_text( json ) .

*ENDIF.
ENDIF.
**********************************************************************









else.
"""""""""""""""""""Number Range"""""""""""""""""""""""""""""""""
DELETE respo-tabledata WHERE beamno IS INITIAL .

 DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZPP_DYES_N'
            quantity    = 0000000001
          IMPORTING
            number      = nr_number.

      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr TYPE C LENGTH 9.
    lv_nr = |{ nr_number ALPHA = OUT }|.
""""""""""""""""""""""""""""""Number Range End"""""""""""""""""""""""""""""""""""D
DATA BEAMWT TYPE P DECIMALS 2.
DATA sr TYPE string.
       LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<Zfs>).

sr = sr + 1.

       WA_ZTAB-slipno            = lv_nr .
       WA_ZTAB-sr                = sr .
       WA_ZTAB-shift             = respo-shift        .
       WA_ZTAB-machinename       = respo-machinename     .
       wa_ztab-prod_order        = |{ <zfs>-manufacturingorder  ALPHA = IN }|  .
       WA_ZTAB-processname       = respo-processname     .
       WA_ZTAB-machinegroup      = respo-machinegroup.
       WA_ZTAB-method            = respo-method          .
       WA_ZTAB-multi             = respo-multi           .
       WA_ZTAB-mandi             = respo-mandi           .
       WA_ZTAB-remark            = respo-remark          .
       WA_ZTAB-additionchk       = respo-additionchk     .
       WA_ZTAB-plant             = respo-plant           .
       WA_ZTAB-storagelocation   = respo-storagelocation .
       WA_ZTAB-machineno         = respo-machineno       .
       WA_ZTAB-beamno            = <Zfs>-beamno        .
       WA_ZTAB-partyname         = <Zfs>-partyname     .
       WA_ZTAB-salesorder        = |{  <Zfs>-salesorder   ALPHA = IN }|    .
       WA_ZTAB-materialdes       = <Zfs>-materialdes   .
       WA_ZTAB-beamlength        = <Zfs>-beamlength    .
       WA_ZTAB-beamweight        = <Zfs>-beamweight    .
       BEAMWT = BEAMWT + <Zfs>-beamweight    .
       WA_ZTAB-rt                = <Zfs>-rt    .
       WA_ZTAB-wtmtr             = <Zfs>-wtmtr    .
       WA_ZTAB-shade             = <ZFS>-shade .
       IF respo-date IS NOT INITIAL .
       WA_ZTAB-postingdate       =  respo-date+0(4) && respo-date+5(2) && respo-date+8(2).
       wa_ztab-postingdate1      =  respo-date+0(4) && '-' && respo-date+5(2) && '-' && respo-date+8(2).
       ENDIF.
       WA_ZTAB-deletionflag      = <ZFS>-deletion.
       WA_ZTAB-totbeamlength     = TOTbeamlength.
       wa_ztab-department        = respo-department.
      MODIFY zdyes_and_che FROM  @WA_ZTAB.
       CLEAR WA_ZTAB .

       ENDLOOP.
 DATA :  WA_ZTAB2 TYPE zdyes_and_che2 .

DELETE respo-table2data WHERE quantity = 0 AND Add1 = 0 .
LOOP AT respo-table2data ASSIGNING FIELD-SYMBOL(<Zfs2>).


    IF respo-USER = 'Plant' AND <ZFS2>-bomitemsorter = 'D'.

    DATA QTY TYPE P DECIMALS 3.
    QTY = ( BEAMWT * <Zfs2>-quantity  ) / 100 .

    ELSE.
    QTY = <Zfs2>-quantity  .
    ENDIF.

 WA_ZTAB2-slipno            = lv_nr .
 WA_ZTAB2-plant            = respo-plant.
 WA_ZTAB2-postingdate      = respo-date+0(4) && respo-date+5(2) && respo-date+8(2).
 WA_ZTAB2-material          =  <Zfs2>-material  .
 WA_ZTAB2-material_des      =  <Zfs2>-materialdescription  .
 WA_ZTAB2-quantity          =   QTY  .
 WA_ZTAB2-material_temp     =  <Zfs2>-materialtemp.
 WA_ZTAB2-qtyper            = <Zfs2>-qty.
 WA_ZTAB2-dyeschem          =  <ZFS2>-bomitemsorter.
 wa_ztab2-deletionflag      =  <ZFS2>-deletion.

 MODIFY zdyes_and_che2 FROM @WA_ZTAB2.

 CLEAR :WA_ZTAB2,QTY .
ENDLOOP.

* if sy-subrc is INITIAL.
 json = ' Data Save Succesfully ' && '  ' &&  lv_nr .
* else.
* json = 'Error'.
* ENDIF.

 response->set_text(  json  )  .

ENDIF.
  endmethod.
ENDCLASS.
