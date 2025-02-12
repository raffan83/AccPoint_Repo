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
	 Lista Dpi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-sm-12">

 <table id="tabDpi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipologia</th>
<th>Tipo Accessorio</th>
<th>Tipo DPI</th>
<th>Collettivo</th>
<th>Company</th>
<th>Descrizione</th>
<th>Modello</th>
<th>Conformitą</th>
<th>Lavoratore</th>
<th>Data scadenza</th>

<%-- <th>Azioni</th> --%>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_dpi}" var="dpi" varStatus="loop">
 	<c:if test="${dpi.collettivo == 1 }">
 	<tr id="row_${loop.index}" ondblclick="openStoricoModal('${dpi.id }')" >
 	</c:if>
 	 <c:if test="${dpi.collettivo == 0 }">
 	<tr id="row_${loop.index}" >
 	</c:if>
	

	<td>${dpi.id }</td>	
	<td>
	<c:if test="${dpi.tipologia == 1 }">
	DPI
	</c:if>
	<c:if test="${dpi.tipologia == 2 }">
	Accessorio
	</c:if>
	</td>
	<c:if test="${dpi.tipo_accessorio.id!=null }">
	<td>${dpi.tipo_accessorio.descrizione }</td>
	</c:if>
	<c:if test="${dpi.tipo_accessorio.id==null }">
	<td></td>
	</c:if>
	<td>${dpi.tipo_dpi.descrizione }</td>
	<td>
	<c:if test="${dpi.collettivo == 1 }">
	SI
	</c:if>
	<c:if test="${dpi.collettivo == 0 }">
	NO
	</c:if>
</td>
	<td>${dpi.company.ragione_sociale }</td>
	<td>${dpi.descrizione }</td>
	<td>${dpi.modello }</td>
	<td>${dpi.conformita }</td>
	<td>${dpi.nome_lavoratore }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${dpi.data_scadenza }"></fmt:formatDate></td>
<%-- 	<td>	

 	   <a class="btn btn-warning customTooltip" onClicK="modalModificaDpi('${dpi.id }','${dpi.tipo.id }','${dpi.collettivo }','${dpi.company.id }','${utl:escapeJS(dpi.modello) }','${utl:escapeJS(dpi.conformita) }','${utl:escapeJS(dpi.descrizione) }','${dpi.data_scadenza }')" title="Click per modificare la dpi"><i class="fa fa-edit"></i></a>    
	  <c:if test="${dpi.is_restituzione==0 }">
	  <a class="btn btn-success customTooltip" onClicK="modalCreaRestituzione('${dpi.id }', ${dpi.quantita })" title="Crea restituzione DPI"><i class="fa fa-arrow-left"></i></a>
	  </c:if> 
 
	</td> --%>
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



<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Storico documento</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome documento</th>
<th>Numero documento</th>
<th>Tipo documento</th>
<th>Data caricamento</th>
<th>Data rilascio</th>
<th>Data scadenza</th>
<th>Frequenza</th>
<th>Rilasciato</th>
<th>Azioni</th>
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

<form id="formAggiornaDocumento" name="formAggiornaDocumento">
  <div id="myModalAggiornaDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Carica il documento aggiornato</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento_agg" name="nome_documento_agg" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento_agg" name="numero_documento_agg" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Rilascio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_rilascio_agg'>
               <input type='text' class="form-control input-small" id="data_rilascio_agg" name="data_rilascio_agg" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_agg" name="frequenza_agg" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza_agg" name="data_scadenza_agg" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
      
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato_agg" name="rilasciato_agg" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload_agg" name="fileupload_agg" type="file"  required></span><label id="label_file_agg"></label>
       	</div>       	
       </div><br> 
     
     
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="aggiorna_documento_id"  name="aggiorna_documento_id">
      <button type="submit" class="btn btn-primary" >Salva</button>
      </div>
    </div>
  </div>

</div>
</form>



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


function modalAggiornaDocumento(id_documento, nome_documento, frequenza){
	
	$('#aggiorna_documento_id').val(id_documento);
	$('#nome_documento_agg').val(nome_documento);
	$('#frequenza_agg').val(frequenza);
	
	$('#myModalAggiornaDocumento').modal();
}

function modalStorico(id_documento){
	
	  dataString ="action=storico_documento&id_documento="+ id_documento;
      exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
    	  	
    	  var result =datab;
    	  
    	  if(result.success){
    		  
    		 
    		  var table_data = [];
    		  
    		  var lista_documenti = result.lista_documenti;
    		  
    		  for(var i = 0; i<lista_documenti.length;i++){
    			  var dati = {};
    			  if( lista_documenti[i].id!= id_documento){
    				  
    			  
    			  dati.id = lista_documenti[i].id;
    			  dati.committente = lista_documenti[i].committente.nome_cliente +" - "+lista_documenti[i].committente.indirizzo_cliente;
    			  dati.fornitore = lista_documenti[i].fornitore.ragione_sociale;
    			  dati.nome_documento = lista_documenti[i].nome_documento;
    			  if(lista_documenti[i].numero_documento==null){
    				  dati.numero_documento = ''; 
    			  }else{
    				  dati.numero_documento = lista_documenti[i].numero_documento;
    			  }    	
    			  if(lista_documenti[i].tipo_documento==null){
    				  dati.tipo_documento = ''; 
    			  }else{
    				  dati.tipo_documento = lista_documenti[i].tipo_documento.descrizione;
    			  } 
    			  dati.data_caricamento = formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
    			  dati.data_rilascio =  formatDate(moment(lista_documenti[i].data_rilascio, "DD, MMM YY"));
    			  dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
    			  dati.data_scadenza =  formatDate(moment(lista_documenti[i].data_scadenza, "DD, MMM YY"));
    			  dati.rilasciato = lista_documenti[i].rilasciato;
    			  dati.azioni = '<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento_table&id_documento='+lista_documenti[i].id+'" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>';
    			
    			  table_data.push(dati);
    			  }
    		  }
    		  var table = $('#table_storico').DataTable();
    		  
     		   table.clear().draw();
     		   
     			table.rows.add(table_data).draw();
     			table.columns.adjust().draw();
   			
   		  $('#myModalStorico').modal();
   			
    	  }
    	  
    	  $('#myModalStorico').on('shown.bs.modal', function () {
    		  var table = $('#table_storico').DataTable();
    		  
    			table.columns.adjust().draw();
  			
    		})
    	  
      });
	  

	
}


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


function modalNuovoDocumento(){
	
	$('#myModalnuovoDocumento').modal();
	
}


$('#committente_docum').change(function(){
	
	 var id_committente = $(this).val();
	 getFornitoriCommittente("", id_committente);
	 $('#fornitore').attr('disabled', false);
});



$('#committente_docum_mod').change(function(){

	 var id_committente = $(this).val();
	 getFornitoriCommittente("_mod", id_committente);
	 
});

$('#fornitore').change(function(){
	
	var id_committente = $('#committente_docum').val();
	var id_fornitore = $(this).val();
	getDipendenteFornitoreCommittente("", id_committente, id_fornitore);
	
	
});


$('#fornitore_mod').change(function(){
	
	var id_committente = $('#committente_docum_mod').val();
	var id_fornitore = $(this).val();
	var id_documento = $('#id_documento').val();
	getDipendenteFornitoreCommittente("_mod", id_committente, id_fornitore, id_documento);
	
	
});

function modificaDocumentoModal(id_committente, id_documento, fornitore, nome_documento, data_rilascio, frequenza,  data_scadenza, nome_file, rilasciato, numero_documento, tipo_documento, aggiornabile, aggiornabile_default){

	$('#id_documento').val(id_documento);
		
	
	$('#fornitore_temp').val(fornitore);	

	
	$('#committente_docum_mod').val(id_committente);
	$('#committente_docum_mod').change();
	
	if(tipo_documento!=null){
		$('#tipo_documento_mod').val(tipo_documento+"_"+aggiornabile_default);
		$('#tipo_documento_mod').change();
	}
	
	if(aggiornabile!=null && aggiornabile==1){
		$('#aggiornabile_cl_mod').iCheck("check");
		$('#aggiornabile_cliente_mod').val(1);
		
	}else{
		$('#aggiornabile_cl_mod').iCheck("uncheck");
		$('#aggiornabile_cliente_mod').val(0);
	}

	$('#nome_documento_mod').val(nome_documento);
	$('#frequenza_mod').val(frequenza);	
	
	$('#numero_documento_mod').val(numero_documento);
	
	if(data_rilascio!=null && data_rilascio!=''){
		$('#data_rilascio_mod').val(Date.parse(data_rilascio).toString("dd/MM/yyyy"));
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
	$('#rilasciato_mod').val(rilasciato);
	$('#label_file_mod').html(nome_file.split("\\")[1]);
	
	$('#myModalModificaDocumento').modal();
}


var columsDatatables = [];

$("#tabDpi").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDpi thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDpi thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$('#fileupload_agg').change(function(){
	$('#label_file_agg').html($(this).val().split("\\")[2]);
	 
 });

$('#data_rilascio').change(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			
		}
		
	}
	
});

$('#data_rilascio_mod').change(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza_mod').val(formatDate(c));
			
		}
		
	}
	
});


$('#data_rilascio_agg').change(function(){
	
	var frequenza = $('#frequenza_agg').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio_agg').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza_agg').val(formatDate(c));
			
		}
		
	}
	
});



$('#frequenza').change(function(){
	
	var date = $('#data_rilascio').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			
		}
	}
	
});

	$('#frequenza_mod').change(function(){
		
		var date = $('#data_rilascio_mod').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_mod').val(formatDate(c));
			}
		}
	});

	
	$('#frequenza_agg').change(function(){
		
		var date = $('#data_rilascio_agg').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_agg').val(formatDate(c));
				
			}
		}
		
	});
	
function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate)){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

function modalEliminaDocumento(id_documento){	
	
	 $('#elimina_documento_id').val(id_documento);
		$('#myModalYesOrNo').modal();
}


$('#dipendenti_mod').on('change', function() {
  
	var selected = $(this).val();
	var selected_before = $('#ids_dipendenti_mod').val().split(";");
	var deselected = "";
	

	if(selected!=null && selected.length>0){
		
		for(var i = 0; i<selected_before.length;i++){
			var found = false
			for(var j = 0; j<selected.length;j++){
				if(selected_before[i] == selected[j]){
					found = true;
				}
			}
			if(!found && selected_before[i]!=''){
				deselected = deselected+selected_before[i]+";";
			}
		}
	}else{
		deselected = $('#ids_dipendenti_mod').val();
	}
	 
	
	$('#ids_dipendenti_dissocia').val(deselected)
	
  });

  $('#tipo_documento_mod').change(function(){
		 
	  var value = $(this).val();
	  
	  if(value!=null && value.split("_")[1] == 1){
		
		  $('#aggiornabile_cl_mod').iCheck("check");
		  $('#aggiornabile_cliente_mod').val(1);
	  }else{
		  $('#aggiornabile_cl_mod').iCheck("uncheck");
		  $('#aggiornabile_cliente_mod').val(0);
	  }
	  
  });

  

	$('#aggiornabile_cl_mod').on('ifClicked',function(e){
		if($('#aggiornabile_cl_mod').is( ':checked' )){
			$('#aggiornabile_cl_mod').iCheck('uncheck');
			$('#aggiornabile_cliente_mod').val(0);
		}else{
			$('#aggiornabile_cl_mod').iCheck('check');
			$('#aggiornabile_cliente_mod').val(1);
		}
	});
  

$(document).ready(function() {
	
	console.log("test");
 
$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     table = $('#tabDpi').DataTable({
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
		
		table.buttons().container().appendTo( '#tabDpi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDpi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	/* 
	  tab = $('#table_storico').DataTable({
			language: {
		        	emptyTable : 	"Non sono presenti documenti antecedenti",
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
		      paging: false, 
		      ordering: true,
		      info: false, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: true,	
		      columns : [
		      	{"data" : "id"},
		      	{"data" : "committente"},
		      	{"data" : "fornitore"},
		      	{"data" : "nome_documento"},
		      	{"data" : "numero_documento"},
		      	{"data" : "tipo_documento"},
		      	{"data" : "data_caricamento"},
		      	{"data" : "data_rilascio"},
		      	{"data" : "frequenza"},
		      	{"data" : "data_scadenza"},
		      	{"data" : "rilasciato"},
		      	{"data" : "azioni"},
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 10 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		tab.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tab.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      tab
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	 */
	
	
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
 
 
 $('#formAggiornaDocumento').on('submit', function(e){

	 e.preventDefault();
	 aggiornaDocumento();
});
 
 $('#myModalStorico').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
 $('#myModalEmail').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
  </script>
  

