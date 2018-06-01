<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.Util.Utility"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.ValoreCampioneDTO"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");

String idC = (String)session.getAttribute("idCamp");
JsonObject json = (JsonObject)session.getAttribute("myObjValoriCampione");

JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);

%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- <div class="col-xs-12"> -->
          <div class="box"> 
          <!-- <div class="box-header">

          </div> -->
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

<!--  <div class="box box-danger box-solid"> -->
<!-- <div class="box-header with-border">
	 <i class="fa fa-edit"></i>
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div> -->
<!-- <div class="box-body" > -->
 
 <form action="" method="post" id="formModificaAppGrid">
  
   
    <div class="col-xs-12 margin-bottom">
<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
</table>

<span id="ulError"></span>
</div>


</form>


</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          <!--  </div>
     -->
     <!--    </div>
        </div> --> 
        
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
	<script src="plugins/fileSaver/FileSaver.js"></script>
	<script type="text/javascript">

	var json = JSON.parse('${listaValoriCampioneJson}');
	
	var umJson = JSON.parse('${listaUnitaMisura}');
	var tgJson = JSON.parse('${listaTipoGrandezza}');
	
 	function selection(i){
 			
			//$('#select3 option').clone()
			var select = $('#tblAppendGrid_tipo_grandezza_'+(i+1));  
			
			//var options = $('#tblAppendGrid_tipo_grandezza_'+(i+1) +'option').clone();
			 var opt = $('#tblAppendGrid_tipo_grandezza_'+(i+1))[0];
			for(var j=0;j<opt.length;j++){
				if(opt[j].value==json[i].tipo_grandezza.id.toString()){					

				opt[j].selected = true;
 				$('#tblAppendGrid_tipo_grandezza_'+(i+1)).val(opt[j].value).trigger('change');  
				}
			}	
		selection2(i);
	}
 	
 	
 	function selection2(i){
 
			var select = $('#tblAppendGrid_unita_misura_'+(i+1));  
			
			var opt = $('#tblAppendGrid_unita_misura_'+(i+1))[0];
			for(var j=0;j<opt.length;j++){

				if(opt[j].value==json[i].unita_misura.id.toString()){
					
				opt[j].selected = true;
 				$('#tblAppendGrid_unita_misura_'+(i+1)).val(opt[j].value).trigger('change');  
				}
			}
			
  
	}
	 
    var validator = $("#formModificaAppGrid").validate({
    	
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

  
    $(document).ready(function() {
    

    	
    	$('#tblAppendGrid').appendGrid({
            //caption: 'Valori Campione',
            //captionTooltip: '',
            initRows: 1,
            hideButtons: {
                remove: true,
                insert:true,
                moveUp:true,
                moveDown:true
            },
            columns: [

					  { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text',ctrlCss: { width: '100%' , 'min-width':"150px"}, ctrlClass: 'required'  },
                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}, ctrlClass: 'required' },
                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'text', ctrlClass: 'numberfloat ', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}, ctrlClass: 'required'  },
                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'text', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"} },
                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'text', ctrlClass: 'numberfloat incRelativa', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      //  { name: 'interpolato', display: 'Interpolato', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required' , ctrlCss: { 'min-width': '100px'} },
                      // { name: 'valore_composto', display: 'Valore Composto', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'min-width': '100px'}  },
                      { name: 'divisione_UM', display: 'Divisione UM', type: 'text', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%', 'min-width':"100px"}  },
                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required select2MV tipograndezzeselect', ctrlOptions: tgJson, ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}},
                      { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required select2MV', ctrlCss: { 'text-align': 'center', "width":"100%", 'max-width': '150px'}   }, 
                        
                      { name: 'id', type: 'hidden', value: 0 }
                  
                  ] ,
                  /* customFooterButtons: [
	                     
                      {
                          uiButton: { icons: { primary: 'ui-icon-arrowthickstop-1-s' }, text: false },
                          btnAttr: { title: 'Download Data' },
                          click: function (evt) {
	                        generacsv();
                          }
                      }
                  ], */
               	
               	initData : json,
               	
                beforeRowRemove: function (caller, rowIndex) {
                    return confirm('Are you sure to remove this row?');
                },
                afterRowRemoved: function (caller, rowIndex) {
                	$(".ui-tooltip").remove();
                },
                rowDataLoaded: function (caller, record, addedRowIndex, uniqueIndex) {
                    // Copy data of `Year` from parent row to new added rows
                   
              modificaValoriCampioneTrigger(umJson, addedRowIndex+1);
                    
                    selection(addedRowIndex);
                	 
                },
                afterRowAppended: function (caller, parentRowIndex, addedRowIndex) {
                    // Copy data of `Year` from parent row to new added rows
                   
             /*  modificaValoriCampioneTrigger(umJson);
                    selection(addedRowIndex);
                	 */

                	 modificaValoriCampioneTrigger(umJson, parseInt(addedRowIndex)+1);
                	$('#tblAppendGrid_tipo_grandezza_'+(parseInt(addedRowIndex)+1)).select2();
                	$('#tblAppendGrid_unita_misura_'+(parseInt(addedRowIndex)+1)).select2();
                	
                },
      
        });
    	
    	
    	//modificaValoriCampioneTrigger(umJson);
    	
   $('.select2MV').select2({
  	//	placeholder: "Seleziona",
  		dropdownCssClass: "select2MVOpt",  		
  	});

    });

</script>