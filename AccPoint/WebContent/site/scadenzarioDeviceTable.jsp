<meta http-equiv = "Content-type" content = "text / html; charset = utf-8" />
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<!-- <div class="row">
      <div class="col-xs-12">
      
      <a class="btn btn-primary" href="gestioneDocumentale.do?action=scadenzario_dipendenti">Vista Dipendenti</a>
      <a class="btn btn-primary" onclick="exploreModal('gestioneDocumentale.do','action=scadenzario_dipendenti','#calendario')">Vista Dipendenti</a>
      </div>
      </div> -->
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Device
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-sm-12">

 <table id="tabDevice" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID Device</th>
<th>Codice Interno</th>
<th>Data attività</th>
<th>Data prossima attività</th>
<th>Tipo Manutenzione</th>
<th>Tipo Device</th>
<th>Company Device</th>
<th>Denominazione</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Distributore</th>
<th>Data Creazione</th>
<th>Data Acquisto</th>
<th>Ubicazione</th>
<th>Dipendente</th>
<TH>Note evento</TH>
<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_scadenze }" var="scadenza" varStatus="loop">
	<tr id="row_${scadenza.device.id }" >

	<td>${scadenza.device.id }</td>	
	<td>${scadenza.device.codice_interno }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${scadenza.data_evento }"></fmt:formatDate></td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${scadenza.data_prossima }"></fmt:formatDate></td>
	<td><c:if test="${scadenza.tipo_evento.id!=5 }">
	INTERNA
	</c:if>
	<c:if test="${scadenza.tipo_evento.id ==5 }">
	ESTERNA
	</c:if>
	</td>
	<td>${scadenza.device.tipo_device.descrizione }</td>
	<td>${scadenza.device.company_util.ragione_sociale }</td>
	<td>${scadenza.device.denominazione }</td>
	<td>${scadenza.device.costruttore }</td>
	<td>${scadenza.device.modello }</td>
	<td>${scadenza.device.distributore }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${scadenza.device.data_creazione }"></fmt:formatDate></td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${scadenza.device.data_acquisto }"></fmt:formatDate></td>
	<td>${scadenza.device.ubicazione }</td>
	<td>${scadenza.device.dipendente.nome } ${scadenza.device.dipendente.cognome }</td>
	<td>${scadnza.note_evento }</td>
	<td>

	<%-- <a class="btn btn-info customTooltip" onClicK="$(this).dblclick()" title="Click per aprire il dettaglio device"><i class="fa fa-search"></i></a>
	 <a class="btn btn-warning customTooltip" onClicK="modificaDevice('${device.id}', '${device.codice_interno }','${device.tipo_device.id }','${device.company.id }','${utl:escapeJS(device.denominazione) }','${utl:escapeJS(device.costruttore) }','${utl:escapeJS(device.modello) }','${utl:escapeJS(device.distributore) }','${device.data_acquisto }','${utl:escapeJS(device.ubicazione) }','${device.dipendente.id }', '${utl:escapeJS(device.configurazione) }')" title="Click per modificare il tipo device"><i class="fa fa-edit"></i></a> 
	 <a class="btn btn-info customTooltip" onClicK="modalSoftware('${device.id}')" title="Click per associare un software al device"><i class="fa fa-file-code-o"></i></a>
	 <a class="btn btn-danger customTooltip"onClicK="modalYesOrNo('${device.id}')" title="Click per eliminare il device"><i class="fa fa-trash"></i></a> --%>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>
</div>






  <div id="myModalEmail" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Invia Comunicazione</h4>
      </div>
       <div class="modal-body">       
      	<label>A (Referente fornitore):</label><input type="text" class="form-control" id="destinatario" name="destinatario"/>
      	<label>CC (committente):</label><input type="text" class="form-control" id="copia" name="copia"/>
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_docum" name="id_docum">
      <a class="btn btn-primary" onclick="inviaEmail()" >Invia</a>
		
      </div>
    </div>
  </div>

</div>

 <div id="myModalStoricoEmail" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Storico email</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico_email" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>Utente</th>
<th>Data</th>
<th>Destinatario</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
  </div>
</div>
</div>

 <div id="myModal" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Registro Attività</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
            <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="detttaglioTab">Dettaglio</a></li>
              <li class=""><a href="#registro_attivita" data-toggle="tab" aria-expanded="true"   id="registroAttivitaTab">Registro attività</a></li>
              <li class=""><a href="#gestione_procedure" data-toggle="tab" aria-expanded="true"   id="gestioneProcedureTab">Gestione procedure</a></li>
              <li class=""><a href="#lista_allegati" data-toggle="tab" aria-expanded="true"   id="listaAllegatiTab">Lista allegati</a></li>
            </ul>
            
            <div class="tab-content">
            
            <div class="tab-pane active" id="dettaglio">
            
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice interno</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_interno_dtl" name="codice_interno_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo device</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_device_dtl" name="tipo_device_dtl" data-placeholder="Seleziona tipo device..." class="form-control select2" style="width:100%" disabled>
        <option value=""></option>
        <c:forEach items="${lista_tipi_device }" var="tipo_device">
        <option value="${tipo_device.id }">${tipo_device.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="denominazione_dtl" name="denominazione_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_dtl" name="company_dtl" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" disabled>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Operatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="dipendente_dtl" name="dipendente_dtl" data-placeholder="Seleziona operatore..." class="form-control select2" style="width:100%" disabled >
        <option value=""></option>
        <c:forEach items="${lista_dipendenti }" var="dipendente">
        <option value="${dipendente.id }">${dipendente.nome } ${dipendente.cognome }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
      
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="costruttore_dtl" name="costruttore_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_dtl" name="modello_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Distributore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="distributore_dtl" name="distributore_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto_dtl" name="data_acquisto_dtl" class="form-control datepicker" type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ubicazione_dtl" name="ubicazione_dtl" class="form-control " type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
       
             
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <textarea id="configurazione_dtl" name="configurazione_dtl" class="form-control " rows="5" style="width:100%" readonly></textarea>
       			
       	</div>       	
       </div><br>
       
      <div class="row">
       
       	<div class="col-sm-3">
       	<label>Software Associati</label>
       	</div>
       	</div><br>
       
		       
		     <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
		 <thead><tr class="active">
		
		
		<th>ID</th>
		<th>Nome</th>
		<th>Produttore</th>
		<th>Stato validazione</th>
		<th>Data validazione</th>
		<th>Product key</th>
		<th>Autorizzato</th>
		<th>Versione</th>
		 </tr></thead>
		 
		 <tbody> 
		
		 </tbody>
		 </table>  
       
       
       
            
            </div>
            
              <div class="tab-pane" id="registro_attivita">


    			</div> 

	<div class="tab-pane" id="gestione_procedure">


    			</div> 


<div class="tab-pane" id="lista_allegati">


    			</div> 

              <!-- /.tab-pane -->


              
              
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="device_dettaglio">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>






  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il documento?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_documento_id">
      <a class="btn btn-primary" onclick="eliminaDocumento($('#elimina_documento_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>




	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>
.btn-primary>.badge {
    position: relative;
    top: -20px;
    right: -25px;
    font-size: 10px;
    font-weight: 400;
}

/*  .btn .badge {
    position: relative;
    top: -1px;
}
  */

  
  </style>



<script src="plugins/iCheck/icheck.min.js"></script> 
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
<script type="text/javascript">





function inviaEmail(){
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	   pleaseWaitDiv.modal();
	  
	  dataObj = {}
	  dataObj.id_documento = $('#id_docum').val();
	  dataObj.destinatario = $('#destinatario').val();
	  dataObj.copia = $('#copia').val();
	  
	  if($('#destinatario').val()==''){
		  pleaseWaitDiv.modal('hide');
		  $('#myModalErrorContent').html("Nessun destinatario inserito!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').hide();
			$('#visualizza_report').hide();
				$('#myModalError').modal('show');	
	  }else{
		  
		  
		  $.ajax({
			  type: "POST",
			  url: "gestioneDocumentale.do?action=invia_email",
			data: dataObj,
			dataType: "json",
			 
			  success: function( data, textStatus) {
				pleaseWaitDiv.modal('hide');
				  	      		  
				  if(data.success)
				  { 
					$('#myModalEmail').hide();
					  $('#myModalErrorContent').html(data.messaggio);
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-success");
						$('#report_button').hide();
						$('#visualizza_report').hide();
							$('#myModalError').modal('show');	 
							
							$('#myModalError').on('hidden.bs.modal',function(){
								location.reload();
								$(".modal-backdrop").hide();
							});
					  
				  }else{
					  $('#myModalErrorContent').html("Errore nell'invio dell'email!");
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').hide();
						$('#visualizza_report').hide();
							$('#myModalError').modal('show');	      			 
				  }
			  },

			  error: function(jqXHR, textStatus, errorThrown){
				  pleaseWaitDiv.modal('hide');

				  $('#myModalErrorContent').html("Errore nell'invio dell'email!");
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
						$('#visualizza_report').show();
						$('#myModalError').modal('show');
						

			  }
		  });
		  
	  }
	
}

function createTableAssociati(){
	
	var id_device = $('#device_dettaglio').val()

	
	dataString ="action=software_associati&id_device="+ id_device;
    exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
    	
    	  var result = JSON.parse(datab);
    	  
    	  var table_data = [];
    	  
    	  var lista_software_associati = result.lista_software_associati;
      	  
      	  if(result.success){ 

				var table_data = [];
				
				  for(var i = 0; i<lista_software_associati.length;i++){
					  var dati = {};
					  
					  dati.id = lista_software_associati[i].software.id; 
					  dati.nome = lista_software_associati[i].software.nome;
					  dati.produttore = lista_software_associati[i].software.produttore;
					 
					  if(lista_software_associati[i].data_validazione!=null){
				  			dati.stato = lista_software_associati[i].stato_validazione.descrizione;  
				  		  }else{
				  			dati.stato = '' 
				  		  }
					  if(lista_software_associati[i].data_validazione!=null){
				  			dati.data_validazione = lista_software_associati[i].data_validazione;  
				  		  }else{
				  			dati.data_validazione = '' 
				  		  }
					  if(lista_software_associati[i].product_key!=null){
				  			dati.product_key = lista_software_associati[i].product_key;  
				  		  }else{
				  			dati.product_key = '' 
				  		  }
					  if(lista_software_associati[i].software.autorizzato!=null){
						  dati.autorizzato = lista_software_associati[i].software.autorizzato; 
					  }else{
						  dati.autorizzato = '';
					  }
					  
					  dati.versione =  lista_software_associati[i].software.versione;
					  table_data.push(dati);
				  }
				  			
				var table = $('#tabSoftware').DataTable();
				
				table.clear().draw();
				
				table.rows.add(table_data).draw();
				
				
				
				table.columns.adjust().draw();
				
				 $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
				
		       	 pleaseWaitDiv = $('#pleaseWaitDialog');
		   	  pleaseWaitDiv.modal('hide');
				
				/* $('#modalSoftwareAssociati').on('shown.bs.modal', function () {
				var table = $('#tabSoftware').DataTable();
				table.columns.adjust().draw();
				
				}); */

      	  }
	});
}

function modalEmail(id_documento, id_fornitore, id_committente){
	
	
	$('#id_docum').val(id_documento);
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	   pleaseWaitDiv.modal();
	  
	  dataObj = {}
  $.ajax({
	  type: "POST",
	  url: "gestioneDocumentale.do?action=email_forn_comm&id_fornitore="+id_fornitore+"&id_committente="+id_committente,
	data: dataObj,
	dataType: "json",
	 
	  success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  	      		  
		  if(data.success)
		  { 
			
			$('#destinatario').val(data.destinatario);
			$('#copia').val(data.copia);
			$('#myModalEmail').modal();
			  
		  }else{
			  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');	      			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				

	  }
  });
	
}





var columsDatatables = [];

$("#tabDevice").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDevice thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDevice thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );




	

	
function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate)){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

var content_id = 0

$(document).ready(function() {
	
	console.log("test");
	
	
	 $('#tabDevice').on( 'dblclick','tr', function () {   
      	 
	    	var id = $(this).attr('id').split("_")[1];
	    	
	    	$('#device_dettaglio').val(id);
	    	
	      	if(content_id == 0){
	      		
	      	 exploreModal("gestioneDevice.do","action=dettaglio_device&id_device="+id, null, function(datab,textStatusb){
	      		 
	      		 var result = JSON.parse(datab);
	      		 
	      		 if(result.success){
	      			 
					var device = result.device;
					
					$('#id_device_dtl').val(device.id);
					$('#codice_interno_dtl').val(device.codice_interno);
					$('#tipo_device_dtl').val(device.tipo_device.id);
					$('#tipo_device_dtl').change();
					$('#company_dtl').val(device.tipo_device.id);
					$('#company_dtl').change();
					$('#denominazione_dtl').val(device.denominazione);
					$('#costruttore_dtl').val(device.costruttore);
					$('#modello_dtl').val(device.modello);
					$('#distributore_dtl').val(device.distributore);
					$('#ubicazione_dtl').val(device.ubicazione);
					if(device.data_acquisto!=null && device.data_acquisto!=''){
						$('#data_acquisto_dtl').val(Date.parse(device.data_acquisto).toString("dd/MM/yyyy"));	
					}
					if(device.dipendente!=null){
						$('#dipendente_dtl').val(device.dipendente.id);
						$('#dipendente_dtl').change();
					}
									
					
					$('#configurazione_dtl').val(device.configurazione);
					
					createTableAssociati()
	      			 
	      		 }
	      		 
	      		
	      	 });
	      	   
	      		
	      	}	 
	      	
	      	if(content_id == 1){
	      		
	    		
	     	   exploreModal("gestioneDevice.do","action=registro_attivita&id_device="+id+"&id_company=${id_company}","#registro_attivita");
	     	    $( "#myModal" ).modal();
	     	    $('body').addClass('noScroll');
	      	}
	      	
	      	if(content_id == 2){
	      		
	    		
	      	   exploreModal("gestioneDevice.do","action=lista_procedure&id_device="+id,"#gestione_procedure");
	      	    $( "#myModal" ).modal();
	      	    $('body').addClass('noScroll');
	       	}
	      	
	    	if(content_id == 3){
	      		
	    		
	       	   exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device="+id,"#lista_allegati");
	       	  
	        	}
			
		});
	    
	    
	    
	    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {


	    	var  contentID = e.target.id;

	    	var id = $('#device_dettaglio').val();
	    	
	    	if(contentID == "dettaglioTab"){
	    		
	    		 exploreModal("gestioneDevice.do","action=dettaglio_device&id_device="+id,null, function(datab,textStatusb){
	          		 
	          		 var result = JSON.parse(datab);
	          		 
	          		 if(result.success){
	          			 
	    				var device = result.device;
	    				
	    				$('#id_device_dtl').val(device.id);
	    				$('#codice_interno_dtl').val(device.codice_interno);
	    				$('#tipo_device_dtl').val(device.tipo_device.id);
	    				$('#tipo_device_dtl').change();
	    				$('#company_dtl').val(device.tipo_device.id);
	    				$('#company_dtl').change();
	    				$('#denominazione_dtl').val(device.denominazione);
	    				$('#costruttore_dtl').val(device.costruttore);
	    				$('#modello_dtl').val(device.modello);
	    				$('#distributore_dtl').val(device.distributore);
	    				$('#ubicazione_dtl').val(device.ubicazione);
	    				if(device.data_acquisto!=null && device.data_acquisto!=''){
	    					$('#data_acquisto_dtl').val(Date.parse(device.data_acquisto).toString("dd/MM/yyyy"));	
	    				}
	    				
	    				if(device.dipendente!=null){
	    					$('#dipendente_dtl').val(device.dipendente.id);
	    					$('#dipendente_dtl').change();
	    				}
	    				$('#dipendente_dtl').change();
	    				
	    				$('#configurazione_dtl').val(device.configurazione);
	          			 
	          		 }
	          		 
	          		 
	          		 
	          		 
	          	 });
	          	    $( "#myModal" ).modal();
	          	    $('body').addClass('noScroll');
	    	}
	    	if(contentID == "registroAttivitaTab"){
	    		$("#myModal").addClass("modal-fullscreen");
	    		exploreModal("gestioneDevice.do","action=registro_attivita&id_device="+id+"&id_company=${id_company}","#registro_attivita");
	    	}
	    	
	    	if(contentID == "gestioneProcedureTab"){
	      		
	    		
	       	   exploreModal("gestioneDevice.do","action=lista_procedure&id_device="+id,"#gestione_procedure");
	       	    $( "#myModal" ).modal();
	       	    $('body').addClass('noScroll');
	        }
	    	
	    	if(contentID == "listaAllegatiTab"){
	      		
	    		
	    		  exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device="+id,"#lista_allegati");
	        	   
	         }
		});
	
 
$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     table = $('#tabDevice').DataTable({
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
	        pageLength: 25,
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	 /*  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 8 }, */
		    	  
		               ], 	        
		               buttons: [ {
	  	                   extend: 'copy',
	  	                   text: 'Copia',
	  	                   /* exportOptions: {
		                       modifier: {
		                           page: 'current'
		                       }
		                   } */
	  	               },{
	  	                   extend: 'excel',
	  	                   text: 'Esporta Excel',
	  	                   title: 'LTA-'+ nome_company,
	  	                   /* exportOptions: {
	  	                       modifier: {
	  	                           page: 'current'
	  	                       }
	  	                   } */
	  	               },
	  	               {
	  	                   extend: 'colvis',
	  	                   text: 'Nascondi Colonne'
	  	                   
	  	               }
	  	        
	  	                         
	  	          ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDevice_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		table.columns.adjust().draw();
		

	$('#tabDevice').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	 tabSW = $('#tabSoftware').DataTable({
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
	  ordering: false,
		  columns : [
			  {"data" : "id"},
	    	  {"data" : "nome"},
	    	  {"data" : "produttore"},
	    	  {"data" : "stato"},
	    	  {"data" : "data_validazione"},
	    	  {"data" : "product_key"},
	    	  {"data" : "autorizzato"},
	    	  {"data" : "versione"}
	    	  
	    	  
	  ]
	
	
});
	
		table.columns.adjust().draw();
		
/* 
	$('#tabDocumDocumento').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	 */
	
});


$('#modificaDocumentoForm').on('submit', function(e){
	 e.preventDefault();
	 
	 
	 if($('#dipendenti_mod').val()!=null && $('#dipendenti_mod').val()!=''){
		 
		 var values = $('#dipendenti_mod').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#ids_dipendenti_mod').val(ids);
	 }else {
		 $('#ids_dipendenti_mod').val("");
	 }
	 modificaDocumento();
});
 

 
 $('#nuovoDocumentoForm').on('submit', function(e){
	 
	 if($('#dipendenti').val()!=null && $('#dipendenti').val()!=''){
		 
		 var values = $('#dipendenti').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#ids_dipendenti').val(ids);
	 }
	 
	 e.preventDefault();
	 nuovoDocumento();
});
 
 

 
 $('#myModalStorico').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
 $('#myModalEmail').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
 $('#myModal').on("hidden.bs.modal", function(){
		$(document.body).css('padding-right', '0px');
	$('.modal-backdrop').hide();
	$('body').removeClass('noScroll')
		
	})
 
  </script>
  

