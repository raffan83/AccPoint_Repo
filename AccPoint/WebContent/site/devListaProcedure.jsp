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


<!-- <a class="btn btn-primary pull-right" onClick="$('#modalNuovaProcedura').modal()"><i class="fa fa-plus"></i>Nuova procedura</a><br><br> -->

	 <table id="tabProcedura" class="table table-bordered table-hover dataTable table-striped" role="dialog" width="100%">
 <thead><tr class="active">

                   <th></th>
 						<th>ID</th>  						
 						  <th>Descrizione</th>
 						  <th>Tipo procedura</th> 
 						  <th>Frequenza</th> 						   
 						     <th>Scadenza contratto</th>	
 </tr></thead>
 
 <tbody>
  <c:forEach items="${lista_procedure }" var="procedura">

 <tr id="proc_${procedura.id }">
 <td></td>
 <td >${procedura.id }</td>
  <td >${procedura.descrizione }</td>

  <td>
  ${procedura.tipo_procedura.descrizione }

  </td>
  <td>${procedura.frequenza }</td>
  <td><fmt:formatDate pattern="dd/MM/yyyy" value="${procedura.scadenza_contratto }"></fmt:formatDate></td>
<%-- <td>
  <a class="btn btn-warning customTooltip" onClicK="modificaProcedura('${procedura.id}','${procedura.tipo_procedura.id }','${utl:escapeJS(procedura.descrizione) }','${utl:escapeJS(procedura.frequenza)}')" title="Click per modificare l'attività"><i class="fa fa-edit"></i></a> 

 </td> --%>
 
 </tr>
 </c:forEach> 
 
 </tbody>
              			   		
              
</table> <br>

<div class="row"> 
<div class="col-xs-12">

<a class="btn btn-primary pull-right" onClick="salvaAssociazioneProcedure()"><i class="fa fa-plus"></i> Salva Associazione</a>
</div>
</div>

<form id="formNuovaProcedura" name="formNuovaProcedura" >
<div id="modalNuovaProcedura" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaProcedura').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Procedura</h4>
      </div>
       <div class="modal-body">     
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo procedura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_procedura" name="tipo_procedura" data-placeholder="Seleziona tipo procedura..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_procedure }" var="tipo">
  
        <option value="${tipo.id }" >${tipo.descrizione }</option>

        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione_procedura" name="descrizione_procedura" required>
       			
       	</div>       	
       </div><br>  
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control" id="frequenza_procedura" name="frequenza_procedura" required>
       			
       	</div>       	
       </div><br> 
       
       
      
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_device" name="id_device" value="${id_device }">
      
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>


<form id="formModificaProcedura" name="formModificaProcedura" >
<div id="modalModificaProcedura" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalModificaProcedura').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Procedura</h4>
      </div>
       <div class="modal-body">     
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo procedura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_procedura_mod" name="tipo_procedura_mod" data-placeholder="Seleziona tipo procedura..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_procedure }" var="tipo">
  
        <option value="${tipo.id }" >${tipo.descrizione }</option>

        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione_procedura_mod" name="descrizione_procedura_mod" required>
       			
       	</div>       	
       </div><br>  
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control" id="frequenza_procedura_mod" name="frequenza_procedura_mod" required>
       			
       	</div>       	
       </div><br> 
       
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_procedura" name="id_procedura">
	<input type="hidden"  class="form-control" id="id_device_mod" name="id_device_mod" value="${id_device }">
      
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>

<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script>


function controllaProcedureAssociate(table, lista_procedure_associate){
	
	//var dataSelected = table.rows( { selected: true } ).data();
	
	var oTable = $('#tabProcedura').dataTable();
	var data = table.rows().data();
	for(var i = 0;i<lista_procedure_associate.length;i++){
	
		var val = lista_procedure_associate[i];		
	
		//var index = table.row("#proc_"+ val, { page: 'all' });
	 	
	 	table.row( "#proc_"+ val, { page:   'all'}).select();

	}

	
}


console.log("test2")

$('#data').change(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima').val(formatDate(c));
			 //   $('#datepicker_data_prossima').datepicker("setDate", c );
			
		}
		
	}
	
});

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

$('#data_mod').change(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima_mod').val(formatDate(c));
			 //   $('#datepicker_data_prossima').datepicker("setDate", c );
			
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
 
 function modificaProcedura(id_procedura, tipo_procedura, descrizione, frequenza){
		
		$('#id_procedura').val(id_procedura);
		$('#tipo_procedura_mod').val(tipo_procedura);
		$('#tipo_procedura_mod').change()
		$('#descrizione_procedura_mod').val(descrizione);
		
		$('#frequenza_procedura_mod').val(frequenza);
		
		$('#modalModificaProcedura').modal();
	}
 

$(document).ready(function(){

	 $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

	var tableNote = $('#tabProcedura').DataTable({
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
	     order:[[1, "desc"]],
	     select: {
	       	style:    'multi-shift',
	       	selector: 'td:nth-child(1)'
	   	},
	    columnDefs: [
	    	{ className: "select-checkbox", targets: 0,  orderable: false }
	    		]

	     
	   });




	$('#tabProcedura thead th').each( function () {
		var title = $('#tabProcedura thead th').eq( $(this).index() ).text();
		if($(this).index()!=0)
		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	} );
		
	$('.inputsearchtable').on('click', function(e){
			e.stopPropagation();    
	});

	// DataTable
		tableNote = $('#tabProcedura').DataTable();

	// Apply the search
	tableNote.columns().eq( 0 ).each( function ( colIdx ) {
		$( 'input', tableNote.column( colIdx ).header() ).on( 'keyup', function () {
			tableNote.column( colIdx ).search( this.value ).draw();		
		} );
	} ); 

	tableNote.columns.adjust().draw();
	
	
	
	var lista_procedure_associate = JSON.parse("${id_associati}");
	
	controllaProcedureAssociate(tableNote, lista_procedure_associate);
	
	
	
});

 
 $('#formNuovaProcedura').on('submit', function(e){
	
	 e.preventDefault();
	 callAjaxForm('#formNuovaProcedura', 'gestioneDevice.do?action=nuova_procedura', function(data, textStatus){
		 
		 $('#report_button').hide();
			$('#visualizza_report').hide();
		  $("#modalNuovoReferente").modal("hide");
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
		$('#myModalError').on('hidden.bs.modal', function(){	         			
			
			$('#modalNuovaProcedura').hide();
		       	   exploreModal("gestioneDevice.do","action=lista_procedure_device&id_device=${id_device}","#gestione_procedure");
		       	    $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
		    
		});
		 
	 });
 });
 
 $('#formModificaProcedura').on('submit', function(e){
		
	 e.preventDefault();
	 callAjaxForm('#formModificaProcedura', 'gestioneDevice.do?action=modifica_procedura', function(data, textStatus){
		 
		 
		 $('#report_button').hide();
			$('#visualizza_report').hide();
		  $("#modalNuovoReferente").modal("hide");
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
		$('#myModalError').on('hidden.bs.modal', function(){	         			
			
			$('#modalModificaProcedura').hide();
		       	   exploreModal("gestioneDevice.do","action=lista_procedure&id_device=${id_device}","#gestione_procedure");
		       	    $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
		    
		});
		 
		 
		 
	 });
 });
 
 function salvaAssociazioneProcedure(){
	 
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  var selezionati ="";
	  
	  var table = $('#tabProcedura').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();

		 for(i=0; i< dataSelected.length; i++){		
			
			selezionati = selezionati +dataSelected[i][1]+";;";
			
		}  
		
		console.log(selezionati);		
		
		dataObj = {},
		dataObj.selezionati = selezionati;

		dataObj.id_device = "${id_device}";
		
		callAjax(dataObj, "gestioneDevice.do?action=associa_procedura", function(data, textStatus){
			
			 $('#report_button').hide();
				$('#visualizza_report').hide();
			  $("#modalNuovoReferente").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
			$('#myModalError').on('hidden.bs.modal', function(){	         			
				
				$('#modalModificaProcedura').hide();
			       	   exploreModal("gestioneDevice.do","action=lista_procedure_device&id_device=${id_device}","#gestione_procedure");
			       	    $( "#myModal" ).modal();
			       	    $('body').addClass('noScroll');
			    
			});
			
		});
		//table.rows().deselect();
 }

</script>