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
        Inserimento Nuovi Valori Campione (${campione.codice})
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
	 <i class="fa fa-edit"></i>
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" style="overflow: scroll;">
 
 <form action="" method="post" id="formAppGrid">
         <div class="col-xs-12 margin-bottom">
     <div class="form-group">
          <label for="interpolato" class="col-sm-2 control-label">Interpolato:</label>

         <div class="col-sm-2">

         			<select  class="form-control" id="interpolato" type="text" name="interpolato" required>
						<option value="0">NO</option>
         				<option value="1">SI</option>
         			
         			</select>
     	</div>
         </div>
   </div>
    <div class="col-xs-12 margin-bottom">
<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
</table>
</div>
    <div class="col-xs-12">
<button onClick="saveValoriCampione(${idCamp})" class="btn btn-success"  type="button">Salva</button>
<sapn id="ulError"></span>

</div>
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

      <div class="form-group" id="myModalSuccessContent">

               </div>
        
        
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
     <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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
            //caption: 'Valori Campione',
            //captionTooltip: '',
            initRows: 1,
            hideButtons: {
                remove: true,
                insert:true
            },
            columns: [

					  { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text',ctrlCss: { width: '100%' , 'min-width':"150px"}, ctrlClass: 'required'  },
                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"} },
                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'text', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"} },
                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'text', ctrlClass: 'numberfloat incRelativa', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      //  { name: 'interpolato', display: 'Interpolato', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required' , ctrlCss: { 'min-width': '100px'} },
                      // { name: 'valore_composto', display: 'Valore Composto', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'min-width': '100px'}  },
                      { name: 'divisione_UM', display: 'Divisione UM', type: 'text', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required select2MV tipograndezzeselect', ctrlOptions: tgJson, ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}  },
                      { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required select2MV', ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}   },
                      { name: 'id', type: 'hidden', value: 0 }
                  
                  ] ,
               	initData : json,
               	
                beforeRowRemove: function (caller, rowIndex) {
                    return confirm('Are you sure to remove this row?');
                },
                afterRowRemoved: function (caller, rowIndex) {
                	$(".ui-tooltip").remove();
                },
                afterRowAppended: function (caller, parentRowIndex, addedRowIndex) {
                    // Copy data of `Year` from parent row to new added rows
                	modificaValoriCampioneTrigger(umJson);

                }
        });
    	
    	
    	modificaValoriCampioneTrigger(umJson);
      
    	
    	$("#interpolato").change(function(){
    	
    		if($("#interpolato").val()==1){
    			$('#tblAppendGrid tbody tr').each(function(){
    			    var td = $(this).find('td').eq(1);
    			    attr = td.attr('id');
    			    $("#" + attr  + " input").val("${campione.codice}");
    			    $("#" + attr  + " input").prop('disabled', false);

    			   // alert(td.attr('id'));
    			})
    		}else{
    			i = 1;
    			$('#tblAppendGrid tbody tr').each(function(){
    				var td = $(this).find('td').eq(1);
    				attr = td.attr('id');
    			    $("#" + attr  + " input").val("${campione.codice}"+"_"+i);
    			    $("#" + attr  + " input").prop('disabled', false);
    			    i++;
    			})
    		}
    	});
    });

    

    var validator = $("#formAppGrid").validate({
    	
    	onkeyup: false,
    	showErrors: function(errorMap, errorList) {
    	  
    	    this.defaultShowErrors();
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#ulError").html("<span class='label label-danger'>Errore inserimento valori (" + error[0].innerHTML + ")</span>");
    		 }
    });
    
    jQuery.validator.addMethod("numberfloat", function(value, element) {
  	  return this.optional(element) || /^(-?\d+(?:[\.]\d{1,30})?)$/.test(value);
  	}, "Questo campo deve essere un numero");
    
  

  </script>
</jsp:attribute> 
</t:layout>
  
 
