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
        Lista Risorse
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
	Lista Risorse
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<a class="btn btn-primary pull-right" onClick="modalNuovaRisorsa()"><i class="fa fa-plus"></i> Nuova Risorsa</a> 

</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabRisorse" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_risorse}" var="risorsa" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${risorsa.id }</td>	
	<td>${risorsa.partecipante.nome }</td>
	<td>${risorsa.partecipante.cognome }</td>	<td>

<%-- 	<a  class="btn btn-warning" onClicK="modificaCategoriaModal('${corso_cat.id}','${corso_cat.codice }','${corso_cat.descrizione.replace('\'','&prime;')}','${corso_cat.frequenza }')" title="Click per modificare la categoria"><i class="fa fa-edit"></i></a>
	<a href="#" class="btn btn-primary customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${corso_cat.id }')"><i class="fa fa-archive"></i></a>
 --%>
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


</section>



  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>

<form id="nuovaRisorsaForm" name="nuovaRisorsaForm">
<div id="modalNuovaRisorsa" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Risorsa</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-6">
       		<label>Utente</label>
        
			<select id="utente" name="utente" class="form-control select2" style="width:100%" data-placeholder="Seleziona utente...">
			<option value=""></option>
			<c:forEach items="${lista_utenti}" var="utente">
			<option value="${utente.id }">${utente.nominativo }</option>
			</c:forEach>
			</select>
       	</div>       	
       	
       	<div class="col-sm-6">
       		<label>Partecipante</label>
        
			<select id="partecipante" name="partecipante" class="form-control select2" style="width:100%" data-placeholder="Seleziona partecipante...">
			<option value=""></option>
			<c:forEach items="${lista_partecipanti}" var="partecipante">
			<option value="${partecipante.id }">${partecipante.nome } ${partecipante.cognome }</option>
			</c:forEach>
			</select>
       	</div>  
       </div><br>
      
      <div class="row">
<div class="col-sm-12">

 <table id="tabRequisitiDocumentali" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<td></td>
<th>ID</th>
<th>Codice</th>
<th>Descrizione</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_documentali}" var="requisito" varStatus="loop">
 
	<tr id="row_${loop.index}" >
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.categoria.codice }</td>
	<td>${requisito.categoria.descrizione }</td>	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
       
       
             <div class="row">
<div class="col-sm-12">

 <table id="tabRequisitiSanitari" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<td></td>
<th>ID</th>
<th>Descrizione</th>
<th>Stato</th>
<th>Data inizio</th>
<th>Data fine</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_sanitari}" var="requisito" varStatus="loop">
 	
	<tr >
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.descrizione }</td>
	<td></td>	
	<td></td>
	<td></td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
       
       </div>
  		 
      <div class="modal-footer">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaCategoriaForm" name="modificaCategoriaForm">
<div id="myModalModificaCategoria" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Tipologia Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_mod" name="codice_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
	
            	       
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_categoria" name="id_categoria"> 
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>





  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalModificaFrequenza" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	La frequenza è stata modificata, vuoi estendere la modifica a tutti i corsi di questa categoria?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="modificaForCategoriaCorso(1)" >SI</a>
		<a class="btn btn-primary" onclick="modificaForCategoriaCorso(0)" >NO</a>
      </div>
    </div>
  </div>

</div>



</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />



</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovaRisorsa(){
	
	$('#modalNuovaRisorsa').modal();
	
}



function modificaCategoriaModal(id_categoria, codice, descrizione,frequenza, durata){
	
	$('#id_categoria').val(id_categoria);
	$('#codice_mod').val(codice);
	$('#descrizione_mod').val(descrizione);
	$('#frequenza_mod').val(frequenza);
	
	frequenza_modifica = frequenza;

	$('#myModalModificaCategoria').modal();
}

var columsDatatables = [];

$("#tabRisorse").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabRisorse thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabRisorse thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalArchivio(id_categoria){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria="+id_categoria+"&id_corso=0";
   exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
   });
$('#myModalArchivio').modal();
}


var frequenza_modifica;

let syncing = false;

function sincronizzaSelect(sourceSelectId, targetSelectId) {
	
	 if (syncing) return;

	    syncing = true;
	    
    var selectedText = $('#' + sourceSelectId).find('option:selected').text().toLowerCase();
    var found = false;

    $('#' + targetSelectId + ' option').each(function () {
        if ($(this).text().toLowerCase() === selectedText) {
            $(this).prop('selected', true);
            found = true;
            return false; // esci dal ciclo
        }
    });

    if (found) {
        $('#' + targetSelectId).trigger('change'); // opzionale
    }
    
    syncing = false;
}

$('#utente').on('change', function () {
    sincronizzaSelect('utente', 'partecipante');
});

$('#partecipante').on('change', function () {
    sincronizzaSelect('partecipante', 'utente');
});

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     
	$('.select2').select2()
     table = $('#tabRisorse').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabRisorse_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabRisorse').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
    t1 = $('#tabRequisitiDocumentali').DataTable({
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
	      select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { className: "select-checkbox", targets: 0,  orderable: false }
	    	  
	               ], 	        
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
    
    
    
    
    
    t2 = $('#tabRequisitiSanitari').DataTable({
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
	      select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  
	    	  { className: "select-checkbox", targets: 0,  orderable: false }
	               ], 	        
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	
});


$('#modificaCategoriaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 if($('#frequenza_mod').val() != frequenza_modifica){
		 
		 $('#modalModificaFrequenza').modal();
		 
		 
	 }else{
		 modificaForCategoriaCorso(0);
	 }
	 
	 
});
 

 
 $('#nuovaRisorsaForm').on('submit', function(e){
	 e.preventDefault();

	
	callAjaxForm('#nuovaRisorsaForm','gestioneRisorse.do?action=nuova_risorsa');
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

