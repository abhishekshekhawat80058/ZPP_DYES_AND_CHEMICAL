class ZCL_DYES_CHEMICAL_PRINT definition
 public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
      CLASS-DATA : multi_pdf   TYPE string,
                 pdf_xstring TYPE xstring.
protected section.
private section.
ENDCLASS.



CLASS ZCL_DYES_CHEMICAL_PRINT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


  data(slipNo) =  value #( req[ name = 'slipno' ]-value optional ) .
  data(slipno1) =  value #( req[ name = 'slipno1' ]-value optional ) .
  data json TYPE string.
  data slip2(10) TYPE c .

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

* if sy-subrc <> 0 .
*     json = 'Error Please input correct details'.
*      response->set_text(  json  )  .
* else .

         if lines( zdyes_it ) le 30 .
          data(l_merger) = cl_rspo_pdf_merger=>create_instance( ).

 loop at zdyes_it INTO data(wa_zdyes_it)  .
*احصل على بيانات pdf11 الخاصة بنا بتنسيق base64
  slipno   =  wa_zdyes_it-slipno .

      data(pdf) = zcl_dyes_print_2=>read_posts( slip_no = slipNo ) .
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

ENDIF.
*ENDIF.
**********************************************************************







  endmethod.
ENDCLASS.
