<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<a class="btn btn-primary pull-right" onClick="$('#modalNuovaAttivita').modal()"><i class="fa fa-plus"></i>Nuova attività</a><br><br>

	 <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="dialog" width="100%">
 <thead><tr class="active">

                   
 						<th>ID</th>
  						<th>Tipo Evento</th>
  						<th>Company</th>
 						  <th>Descrizione</th>
 						  <th>Data</th>
 						  <th>Frequenza (Mesi)</th>
 						  <th>Data prossima</th> 
 						  <th>Utente</th>         
 						  <th>Note evento</th>      
 						  <th>Azioni</th>         
 </tr></thead>
 
 <tbody>
  <c:forEach items="${registro_attivita }" var="attivita">

 <c:set var = "descrizione_attivita" value = "${fn:split(attivita.getDescrizione(), '|')}" />
 <tr>
 <td >${attivita.id }</td>
  <td >${attivita.tipo_evento.descrizione } 
  <c:if test="${attivita.tipo_manutenzione_straordinaria ==1 }">
   - Hardware
  </c:if>
    <c:if test="${attivita.tipo_manutenzione_straordinaria ==2 }">
   - Software
  </c:if>
    <c:if test="${attivita.tipo_manutenzione_straordinaria ==3 }">
   - Supporto Operatore
  </c:if>
  </td>
  <td >${attivita.company.ragione_sociale }</td>
 <td>
 <ul class="list-group ">
                

 <c:forEach items='${descrizione_attivita}' var="descr" varStatus="loop">
 <c:if test="${loop.index == 0 }">
 <li class="list-group-item" style="background-color:#ffe6cc">${descr}<br></li>
 </c:if>
  <c:if test="${loop.index > 0 }">
 <li class="list-group-item" style="background-color:#ffffe6">${descr}<br></li>
 </c:if>
 </c:forEach> 
</ul>
 </td> 
  <td><fmt:formatDate pattern="dd/MM/yyyy" value="${attivita.data_evento }"></fmt:formatDate></td>
  <td>
  <c:if test="${attivita.frequenza == 0 }">
  
  </c:if>
  <c:if test="${attivita.frequenza != 0 }">
  ${attivita.frequenza }
  </c:if>
  </td>
  <td><fmt:formatDate pattern="dd/MM/yyyy" value="${attivita.data_prossima }"></fmt:formatDate></td>
 

 <td>${attivita.utente.nominativo }</td>

 <td>${attivita.note_evento }</td>
 <td>
 <c:if test="${attivita.tipo_evento.id == 2 }">
 
 <a class="btn btn-warning customTooltip customLink" onClicK="modificaAttivita('${attivita.id}','${attivita.tipo_evento.id }','${utl:escapeJS(attivita.descrizione) }','${attivita.data_evento}','${attivita.frequenza }','${attivita.data_prossima }','${utl:escapeJS(attivita.note_evento) }','${utl:escapeJS(attivita.tipo_intervento) }','${attivita.tipo_manutenzione_straordinaria.id }')" title="Click per modificare l'attività"><i class="fa fa-edit"></i></a>
 <a class="btn btn-info customTooltip customLink" onClicK="rinnovaManutenzione('${attivita.id}','${attivita.tipo_evento.id }','${utl:escapeJS(attivita.descrizione) }','${attivita.frequenza }','${utl:escapeJS(attivita.note_evento) }','${utl:escapeJS(attivita.tipo_intervento) }')" title="Click per rinnovare l'attività"><i class="fa fa-copy"></i></a>
 </c:if>
 
 </td>
 
 </tr>
 </c:forEach> 
 
 </tbody>
              			   		
              
</table> 



<form id="formNuovaAttivita" name="formNuovaAttivita" >
<div id="modalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaAttivita').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attivita</h4>
      </div>
       <div class="modal-body">     
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo evento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_evento" name="tipo_evento" data-placeholder="Seleziona tipo evento..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_evento }" var="tipo">
        <c:if test="${tipo.id == 2}">
        <option value="${tipo.id }" selected>${tipo.descrizione }</option>
        </c:if>
         <c:if test="${tipo.id != 2}">
        <option value="${tipo.id }">${tipo.descrizione }</option>
        </c:if>
        
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
      <div id="content_tipo_man" style="display:none">
       <div class="row" >
       	<div class="col-sm-3">
       		<label>Tipo manutenzione straordinaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_manutenzione_straordinaria" name="tipo_manutenzione_straordinaria" data-placeholder="Seleziona tipo manutenzione straordinaria..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
         <option value="1">Hardware</option>
          <option value="2">Software</option>
           <option value="3">Supporto Operatore</option>
           
 
        </select>
       			
       	</div>       	
       </div><br>
       </div>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione" name="descrizione" required onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Label tipo intervento</label>
       	</div>
       	<div class="col-sm-8">      
       	  	
        <select id="label_tipo" name="label_tipo" data-placeholder="Seleziona label..." class="form-control select2" style="width:100%" multiple >
        <option value=""></option>
        <c:forEach items="${lista_label_tipo_intervento }" var="tipo">
        
        <option value="${tipo.id }">${tipo.descrizione }</option>
      
        </c:forEach>
        
        </select>
       			
       	</div>       
       	<div class="col-sm-1">  
		<a class="btn btn-primary customTooltip pull-right" title="Crea nuova label" onClick="modalNuovaLabelTipo('')"><i class="fa fa-plus"></i></a>
	
	  </div>  	
       </div><br> 
        <div class="row">
         	<div class="col-sm-3">
       		<label>Tipo intervento</label>
       	</div>
       <div class="col-xs-9">
       

       <textarea id="tipo_intervento" name="tipo_intervento" rows="3" class="form-control" ></textarea>
       </div>
       </div><br>
       
              
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="number" step="1" min="0" class="form-control " id="frequenza" name="frequenza" onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data" name="data" required onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
       

       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossima</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data_prossima" name="data_prossima" onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
      
        <div class="row">
       <div class="col-xs-12">
       <label>Note evento</label>

       <textarea id="note_evento" name="note_evento" rows="3" class="form-control"></textarea>
       </div>
       </div>
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_device" name="id_device" value="${id_device }">
      <input type="hidden" id="nuova_label_tipo" name="nuova_label_tipo">
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>

<form id="formModificaAttivita" name="formNuovaAttivita" >
<div id="modalModificaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalModificaAttivita').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Attivita</h4>
      </div>
       <div class="modal-body">     
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo evento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_evento_mod" name="tipo_evento_mod" data-placeholder="Seleziona tipo evento..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_evento }" var="tipo">

         <c:if test="${tipo.id != 1}">
        <option value="${tipo.id }">${tipo.descrizione }</option>
        </c:if>
        
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       
       <div id="content_tipo_man_mod" style="display:none">
       <div class="row" >
       	<div class="col-sm-3">
       		<label>Tipo manutenzione straordinaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_manutenzione_straordinaria_mod" name="tipo_manutenzione_straordinaria_mod" data-placeholder="Seleziona tipo manutenzione straordinaria..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
         <option value="1">Hardware</option>
          <option value="2">Software</option>
           <option value="3">Supporto Operatore</option>
           
 
        </select>
       			
       	</div>       	
       </div><br>
       </div>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione_mod" name="descrizione_mod" required onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br>  
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Label tipo intervento</label>
       	</div>
       	<div class="col-sm-8">      
       	  	
        <select id="label_tipo_mod" name="label_tipo_mod" data-placeholder="Seleziona label..." class="form-control select2" style="width:100%" multiple>
        <option value=""></option>
        <c:forEach items="${lista_label_tipo_intervento }" var="tipo">
        
        <option value="${tipo.id }">${tipo.descrizione }</option>
      
        </c:forEach>
        
        </select>
       			
       	</div>       
       	<div class="col-sm-1">  
		<a class="btn btn-primary customTooltip pull-right" title="Crea nuova label" onClick="modalNuovaLabelTipo('_mod')"><i class="fa fa-plus"></i></a>
	
	  </div>  	
       </div><br> 
        <div class="row">
         	<div class="col-sm-3">
       		<label>Tipo intervento</label>
       	</div>
       <div class="col-xs-9">
       

       <textarea id="tipo_intervento_mod" name="tipo_intervento_mod" rows="3" class="form-control" ></textarea>
       </div>
       </div><br>
       
     
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="number" step="1" min="0" class="form-control " id="frequenza_mod" name="frequenza_mod" onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data_mod" name="data_mod" required onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossima</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data_prossima_mod" name="data_prossima_mod" onkeydown="preventEnter(event)">
       			
       	</div>       	
       </div><br> 
      
        <div class="row">
       <div class="col-xs-12">
       <label>Note evento</label>

       <textarea id="note_evento_mod" name="note_evento_mod" rows="3" class="form-control" ></textarea>
       </div>
       </div>
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_attivita" name="id_attivita">
	<input type="hidden"  class="form-control" id="id_device_mod" name="id_device_mod" value="${id_device }">
      <input type="hidden" id="nuova_label_tipo_mod" name="nuova_label_tipo_mod">
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>


<div id="modalNuovaLabelTipo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova label tipo intervento</h4>
      </div>
       <div class="modal-body">       
     	<input type="text" id="descrizione_label_tipo" name="descrizione_label_tipo" class="form-control">
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id="isModTipo">
      
		<a class="btn btn-primary" onclick="assegnaValoreOpzioneTipo($('#isModTipo').val())" >Salva</a>
      </div>
    </div>
  </div>

</div>

<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script>


console.log("test2")

$('#data').focusout(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    //$('#data_prossima').val(formatDate(c));
			    $('#data_prossima').datepicker("setDate", c );
			
		}
		
	}
	
});





//$('#data').keydown(myfunction);





function modalNuovaLabelTipo(isMod){
	
	$('#isModTipo').val(isMod);
	
	$('#modalNuovaLabelTipo').modal();
}


var id_new_label = 0;
function assegnaValoreOpzioneTipo(mod){
	
	var data = {
		    id: "new_tipo_"+id_new_label,
		    text: $('#descrizione_label_tipo').val().toUpperCase()
		};

		var newOption = new Option(data.text, data.id, false, false);
		
		var opt = $('#label_tipo'+mod).val();
			
			$('#label_tipo'+mod).append(newOption);
			
		
			if(opt==null || opt == ""){
				opt= [];
			}
			opt.push("new_tipo_"+id_new_label);
			
			$('#label_tipo'+mod).val(opt).trigger('change');
				
			
			if($('#nuova_label_tipo'+mod).val()==''){
				$('#nuova_label_tipo'+mod).val($('#descrizione_label_tipo').val().toUpperCase());
			}else{
				$('#nuova_label_tipo'+mod).val($('#nuova_label_tipo'+mod).val()+";"+$('#descrizione_label_tipo').val().toUpperCase());	
			}

			$('#modalNuovaLabelTipo').modal('hide');
			id_new_label++;
	
}


$('#modalNuovaLabelTipo').on('hidden.bs.modal',function(){
	
	$('#descrizione_label_tipo').val("");
});


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

$('#data_mod').focusout(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			   // $('#data_prossima_mod').val(formatDate(c));
			    $('#data_prossima_mod').datepicker("setDate", c );
			
		}
		
	}
	
});


$('#frequenza').change(function(){
	
	var date = $('#data').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima').val(formatDate(c));
			    
			
		}
	}
	
});
 
 
$('#frequenza_mod').change(function(){
	
	var date = $('#data_mod').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima_mod').val(formatDate(c));
			    
			
		}
	}
	
});



previouslySelected = []
$('#label_tipo').on('change', function(e, params){
	
	var value = $(this).val();
	
	if(value!=null){
		var x = value.filter(function (element) {
            return previouslySelected.indexOf(element) == -1;
        });
    	
    	previouslySelected = value;
    	
    	var text = $('#label_tipo option[value="'+x+'"]').text()
    	if($('#tipo_intervento').val()==''){
    		if(text!= null && text!=''){
    			$('#tipo_intervento').val($('#tipo_intervento').val()+text+":");       	
    		}
    		
    	}else{
    		if(text!= null && text!=''){
    			$('#tipo_intervento').val($('#tipo_intervento').val()+"\n"+text+":");
    		}
    			
    	}
	
	
	
	}
	
	
});



previouslySelectedMod = []
$('#label_tipo_mod').on('change', function(e, params){

var value = $(this).val();

if(value!=null){
	var x = value.filter(function (element) {
        return previouslySelectedMod.indexOf(element) == -1;
    });
	
	previouslySelectedMod = value;
	
	var text = $('#label_tipo_mod option[value="'+x+'"]').text()
	if($('#tipo_intervento_mod').val()==''){
		if(text!= null && text!=''){
			$('#tipo_intervento_mod').val($('#tipo_intervento_mod').val()+text+":");       	
		}
		
	}else{
		if(text!= null && text!=''){
			$('#tipo_intervento_mod').val($('#tipo_intervento_mod').val()+"\n"+text+":");
		}    			
	}	
}	
});

 
 function modificaAttivita(id_attivita, tipo_evento, descrizione, data, frequenza, data_prossima, note, tipo_intervento, tipo_manutenzione_straordinaria){
		
		$('#id_attivita').val(id_attivita);
		$('#tipo_evento_mod').val(tipo_evento);
		$('#tipo_evento_mod').change()
		$('#descrizione_mod').val(descrizione);
		if(data!=null && data != ''){
			$('#data_mod').val(Date.parse(data).toString("dd/MM/yyyy"));
		}
		$('#frequenza_mod').val(frequenza);
		if(data_prossima!=null && data_prossima != ''){
			$('#data_prossima_mod').val(Date.parse(data_prossima).toString("dd/MM/yyyy"));	
		}
		
		$('#note_evento_mod').val(note);
		$('#tipo_intervento_mod').val(tipo_intervento);
		
		if(tipo_manutenzione_straordinaria!=null && tipo_manutenzione_straordinaria!=''){
			$('#tipo_manutenzione_straordinaria_mod').val(tipo_intervento);
			$('#tipo_manutenzione_straordinaria_mod').change();
		}
		
		
		$('#modalModificaAttivita').modal();
	}
 
 
 
 function rinnovaManutenzione(id_attivita, tipo_evento, descrizione, frequenza,  note, tipo_intervento){
	 

		$('#tipo_evento').val(tipo_evento);
		$('#tipo_evento').change()
		$('#descrizione').val(descrizione);
		$('#frequenza').val(frequenza);

		$('#data').val(Date.parse(new Date()).toString("dd/MM/yyyy"));
		
		
		$('#data').focusout();
		
		$('#note_evento').val(note);
		$('#tipo_intervento').val(tipo_intervento);
		
		
		$('#modalNuovaAttivita').modal();
 }
 
 
 $('#tipo_evento').change(function(){
	
	 var val = $(this).val();
	 
	 if(val == 3){
		 
		 $('#content_tipo_man').show();
		 
	 }else{
		 $('#content_tipo_man').hide();
	 }
	 
 });
 
 $('#tipo_evento_mod').change(function(){
		
	 var val = $(this).val();
	 
	 if(val == 3){
		 
		 $('#content_tipo_man_mod').show();
		 
	 }else{
		 $('#content_tipo_man_mod').hide();
	 }
	 
 });


$(document).ready(function(){

	 $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
      $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });  
	 

	 
	 



	 
	var tableNote = $('#tabAttivita').DataTable({
		 language: {
	       	emptyTable : 	"Nessun dato presente nella tabella",
	       	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
	       	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
	       	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
	       	infoPostFix:	"",
	       infoThousands:	".",
	       lengthMenu:	"Visualizza _MENU_ elementi",
	       loadingRecords:	"Caricamento...",
	       	processing:	"Elaborazione...",
	       	search:	"Cerca:",
	       	zeroRecords	:"La ricerca non ha portato alcun risultato.",
	       	paginate:	{
	 	        	first:	"Inizio",
	 	        	previous:	"Precedente",
	 	        	next:	"Successivo",
	 	        last:	"Fine",
	       	},
	       aria:	{
	 	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	 	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
	       }
	  },
	  pageLength: 10,
	     paging: true, 
	     ordering: true,
	     info: true, 
	     searchable: false, 
	     targets: 0,
	     responsive: true,
	     scrollX: false,
	     stateSave: true,
	     order:[[0, "desc"]],

	   

	     
	   });




	$('#tabAttivita thead th').each( function () {
		var title = $('#tabAttivita thead th').eq( $(this).index() ).text();
		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	} );
		
	$('.inputsearchtable').on('click', function(e){
			e.stopPropagation();    
	});

	// DataTable
		tableNote = $('#tabAttivita').DataTable();

	// Apply the search
	tableNote.columns().eq( 0 ).each( function ( colIdx ) {
		$( 'input', tableNote.column( colIdx ).header() ).on( 'keyup', function () {
			tableNote.column( colIdx ).search( this.value ).draw();		
		} );
	} ); 

	tableNote.columns.adjust().draw();
	
});

 
 $('#formNuovaAttivita').on('submit', function(e){
	
	 e.preventDefault();
	 callAjaxForm('#formNuovaAttivita', 'gestioneDevice.do?action=nuova_attivita', function(data, textStatus){
		 
		 $('#report_button').hide();
			$('#visualizza_report').hide();
		  $("#modalNuovoReferente").modal("hide");
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
		$('#myModalError').on('hidden.bs.modal', function(){	         			
			
			$('#modalNuovaAttivita').hide();
		       	   exploreModal("gestioneDevice.do","action=registro_attivita&id_device=${id_device}&id_company=${id_company}","#registro_attivita");
		       	    $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
		    
		});
		 
	 });
 });
 
 $('#formModificaAttivita').on('submit', function(e){
		
	 if(e.key === "Enter"){
			e.preventDefault()
			alert("inside")
		}
	 
	 
	 e.preventDefault();
	 callAjaxForm('#formModificaAttivita', 'gestioneDevice.do?action=modifica_attivita', function(data, textStatus){
		 
		 $('#report_button').hide();
			$('#visualizza_report').hide();
		  $("#modalNuovoReferente").modal("hide");
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
		$('#myModalError').on('hidden.bs.modal', function(){	         			
			
			$('#modalNuovaAttivita').hide();
		       	   exploreModal("gestioneDevice.do","action=registro_attivita&id_device=${id_device}&id_company=${id_company}","#registro_attivita");
		       	    $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
		    
		});
		 
	 });
 });
 
 function preventEnter(event) {
	    if (event.keyCode === 13) {
	      event.preventDefault(); // Previeni l'invio del modulo se il tasto premuto è Enter (codice 13)
	    }
	  }
	 

</script>