<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Segnalazioni
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Segnalazioni
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<a class="btn btn-primary pull-right" onclick="$('#modalRapporto').modal()">Crea Rapporto</a>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabSegnalazioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th style="max-width:40px">ID</th>
<th>Targa</th>
<th>Modello</th>
<th>Data Segnalazione</th>
<th>Tipo Segnalazione</th>
<th>Stato</th>
<th>Note</th>
<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_segnalazioni }" var="segnalazione" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${segnalazione.id }</td>	
	
	<td>${segnalazione.prenotazione.veicolo.targa }</td>
	<td>${segnalazione.prenotazione.veicolo.modello }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${segnalazione.data_segnalazione }"></fmt:formatDate></td>
	<td>${segnalazione.tipo.descrizione }</td>
	<td>
	<c:if test="${segnalazione.stato == 0 }">
	
			<span class="label label-warning">DA EVADERE</span>
	</c:if>
		<c:if test="${segnalazione.stato == 1 }">
	
			<span class="label label-success">EVASA</span>
	</c:if>
	</td>

	<td>${segnalazione.note }</td>

	<td>

	<a class="btn btn-info customTooltip" onClicK="cambiaStatoSegnalazione('${segnalazione.id}')" title="Click per cambiare lo stato della segnalazione"><i class="glyphicon glyphicon-refresh"></i></a>
 
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

</section>

  <div id="modalRapporto" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Crea Rapporto Segnalazioni</h4>
      </div>
       <div class="modal-body">       
      	<div class="row">
      	<div class="col-xs-12">
      	<select id="veicolo" name="veicolo" class="form-control select2" data-placeholder="Seleziona veicolo..." style="width:100%">
      	<option value=""></option>
      	<c:forEach items="${lista_veicoli }" var="veicolo">
      	<option value="${veicolo.id }">${veicolo.targa} - ${veicolo.modello }</option>
      	</c:forEach>
      	</select>
      	</div>
      	</div>
      	</div>
      <div class="modal-footer">
 
      <a class="btn btn-primary" onclick="creaRapporto($('#veicolo').val())" >Crea Rapporto</a>
		
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
      	Sei sicuro di voler eliminare il segnalazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_segnalazione_elimina">
      <a class="btn btn-primary" onclick="eliminaSegnalazione($('#id_segnalazione_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


<form id="nuovaSegnalazioneForm" name="nuovaSegnalazioneForm">
<div id="myModalNuovoSegnalazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Segnalazione</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Targa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="targa" name="targa" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="company" id="company" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona company..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Km Percorsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="km_percorsi" name="km_percorsi" class="form-control" type="number" step="1" min="0" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Portata max</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="portata_max" name="portata_max" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Dispositivo pedaggio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="dispositivo_pedaggio" name="dispositivo_pedaggio" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Immagine Segnalazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".jpg,.JPG,.png,.PNG"  id="fileupload_immagine_segnalazione" name="fileupload_immagine_segnalazione" type="file" ></span><label id="label_immagine_segnalazione"></label>
       	</div>       	
       </div><br> 
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Carta di circolazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.jpg,.JPG,.png,.PNG"  id="fileupload_carta_circolazione" name="fileupload_carta_circolazione" type="file" ></span><label id="label_carta_circolazione"></label>
       	</div>       	
       </div><br> 
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Autorizzazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="autorizzazione" name="autorizzazione" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea id="note" name="note" class="form-control" rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaSegnalazioneForm" name="modificaSegnalazioneForm">
<div id="myModalModificaSegnalazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Segnalazione</h4>
      </div>
          <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Targa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="targa_mod" name="targa_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="company_mod" id="company_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona company..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Km Percorsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="km_percorsi_mod" name="km_percorsi_mod" class="form-control" type="number" step="1" min="0" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Portata max</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="portata_max_mod" name="portata_max_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Dispositivo pedaggio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="dispositivo_pedaggio_mod" name="dispositivo_pedaggio_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
  
       
       
   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Immagine Segnalazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".jpg,.JPG,.png,.PNG"  id="fileupload_immagine_segnalazione_mod" name="fileupload_immagine_segnalazione_mod" type="file" ></span><label id="label_immagine_segnalazione_mod"></label>
       	</div>       	
       </div><br> 
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Carta di circolazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.jpg,.JPG,.png,.PNG"  id="fileupload_carta_circolazione_mod" name="fileupload_carta_circolazione_mod" type="file" ></span><label id="label_carta_circolazione_mod"></label>
       	</div>       	
       </div><br> 
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Autorizzazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="autorizzazione_mod" name="autorizzazione_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea id="note_mod" name="note_mod" class="form-control" rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_segnalazione" name="id_segnalazione">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>
      .img-container {
            max-width: 200px;
            max-height: 200px;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: auto;
        }
        
        .table th input {
    min-width: 45px !important;
}

</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function cambiaStatoSegnalazione(id_segnalazione){
	dataObj ={};
	dataObj.id_segnalazione = id_segnalazione;
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=cambia_stato_segnalazione");
	
}

function creaRapporto(id_veicolo){
	
	callAction("gestioneParcoAuto.do?action=crea_rapporto_veicolo&id_veicolo="+id_veicolo)
	
}


function modalNuovoSegnalazione(){
	
	$('#myModalNuovoSegnalazione').modal();
	
}


function modificaSegnalazione(id_segnalazione, targa, modello, id_company, km_percorsi, carta_circolazione, portata_max_segnalazione, immagine_segnalazione, dispositivo_pedaggio,note, autorizzazione){
	
	$('#id_segnalazione').val(id_segnalazione);
	$('#targa_mod').val(targa);
	$('#modello_mod').val(modello);
	$('#company_mod').val(id_company);
	$('#company_mod').change();
	$('#km_percorsi_mod').val(km_percorsi);
	$('#label_carta_circolazione_mod').html(carta_circolazione);
	$('#portata_max_mod').val(portata_max_segnalazione);
	$('#label_immagine_segnalazione_mod').html(immagine_segnalazione);
	$('#dispositivo_pedaggio_mod').val(dispositivo_pedaggio);
	$('#note_mod').val(note)
	$('#autorizzazione_mod').val(autorizzazione)

	$('#myModalModificaSegnalazione').modal();
}



function modalEliminaSegnalazione(id_segnalazione){
	
	
	$('#id_segnalazione_elimina').val(id_segnalazione);
	$('#myModalYesOrNo').modal()
	
}


$('#fileupload_immagine_segnalazione').change(function(){
	$('#label_immagine_segnalazione').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione').change(function(){
	$('#label_carta_circolazione').html($(this).val().split("\\")[2]);
	 
 });
 
 
$('#fileupload_immagine_segnalazione_mod').change(function(){
	$('#label_immagine_segnalazione_mod').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione_mod').change(function(){
	$('#label_carta_circolazione_mod').html($(this).val().split("\\")[2]);
	 
 });

function eliminaSegnalazione(){
	
	dataObj = {};
	
	dataObj.id_segnalazione_elimina = $('#id_segnalazione_elimina').val();
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=elimina_segnalazione");
}


var columsDatatables = [];

 $("#tabSegnalazioni").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabSegnalazioni thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabSegnalazioni thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    //	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

		    	if($(this).index() == 0){
	 				$(this).append( '<div><input class="inputsearchtable"  style="width:15px !important" type="text" /></div>');
	 			}else{
	 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
	 			}
    	  
    	} );
    
    

} );
 


$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2()
     
  


 		
 		

 	     table = $('#tabSegnalazioni').DataTable({
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
 		        "order": [[ 0, "asc" ]],
 			      paging: true, 
 			      ordering: true,
 			      info: true, 
 			      searchable: true, 
 			      targets: 0,
 			      responsive: true,
 			      scrollX: false,
 			      stateSave: true,	
 			           
 			      columnDefs: [
 			    	  
 			    	  { responsivePriority: 1, targets: 6 },
 			    	  
 			    	  
 			               ], 	        
 		  	      buttons: [   
 		  	          {
 		  	            extend: 'colvis',
 		  	            text: 'Nascondi Colonne'  	                   
 		 			  } ]
 			               
 			    });
 		
 		
 	     
  
  		
     
		table.buttons().container().appendTo( '#tabSegnalazioni_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabSegnalazioni').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaSegnalazioneForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaSegnalazioneForm','gestioneParcoAuto.do?action=modifica_segnalazione');
});
 

 
 $('#nuovaSegnalazioneForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovaSegnalazioneForm','gestioneParcoAuto.do?action=nuova_segnalazione');
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

