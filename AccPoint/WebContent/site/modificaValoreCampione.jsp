<%@page import="it.portaleSTI.Util.Utility"%>
<%@page import="it.portaleSTI.DTO.ValoreCampioneDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%
System.out.println("***"+request.getSession().getAttribute("listaValoriCampione"));	

%>
	
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Modifica Valore Campione
        <small></small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">

          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Modifica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" style="overflow: scroll;">
 
 <form action="" method="post" id="formAppGrid">
<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
</table>


<button onClick="saveValoriCampione(${idCamp})" class="btn btn-success"  type="button">Salva</button>
<sapn id="ulError"></span>

</form>


</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





 


<div id="myModalSuccess" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Success</h4>
      </div>
       <div class="modal-body" id="myModalPrenotazioneContent" >

      <div class="form-group">

Salvataggio effettuato con successo, click su Chiudi per tornare alla lista dei campioni                </div>
        
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger"onclick="$(myModalSuccess).modal('hide');"   >Chiudi</button>

      </div>
    </div>
  </div>
</div>

<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
  		 </div>
      
    </div>
  </div>
    </div>

</div>
</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

<link href="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.css" rel="stylesheet"/>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

	<script type="text/javascript">


   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {
    
    	var json = JSON.parse('${listaValoriCampioneJson}');
    	
    	var umJson = JSON.parse('${listaUnitaMisura}');
    	var tgJson = JSON.parse('${listaTipoGrandezza}');
    	
    	$('#tblAppendGrid').appendGrid({
            caption: 'Valori Campione',
            captionTooltip: 'This is my CD collection list!',
            initRows: 1,
            columns: [

                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'text', ctrlClass: 'required' },
                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'text', ctrlClass: 'required'  },
                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'text'  },
                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'text'  },
                      { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text', ctrlClass: 'required'  },
                      { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required', ctrlOptions: umJson  },
                      { name: 'interpolato', display: 'Interpolato', type: 'text', ctrlClass: 'required'  },
                      { name: 'valore_composto', display: 'Valore Composto', type: 'text', ctrlClass: 'required'  },
                      { name: 'divisione_UM', display: 'Divisione UM', type: 'text', ctrlClass: 'required'  },
                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required', ctrlOptions: tgJson  },
                      { name: 'id', type: 'hidden', value: 0 }
                  ] ,
               	initData : json,
               	
                beforeRowRemove: function (caller, rowIndex) {
                    return confirm('Are you sure to remove this row?');
                },
                afterRowRemoved: function (caller, rowIndex) {
                	$(".ui-tooltip").remove();
                }
        });
      
    });


    var validator = $("#formAppGrid").validate({
    	showErrors: function(errorMap, errorList) {
    	  
    	    this.defaultShowErrors();
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
    		 }
    });
    
  

  </script>
</jsp:attribute> 
</t:layout>
  
 