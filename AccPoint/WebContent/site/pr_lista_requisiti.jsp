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
        Lista Requisiti
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

<a class="btn btn-primary pull-right" onClick="modalNuovaRisorsa()"><i class="fa fa-plus"></i> Nuovo Requisito Sanitario</a> 
<a class="btn btn-primary pull-right" onClick="modalNuovaRisorsa()"><i class="fa fa-plus"></i> Nuovo Requisito Documentale</a>
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabReqSanitari" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_sanitari}" var="req" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${req.id }</td>	
	<td>${req.descrizione }</td>
	
	<td>

 <%-- 	<a  class="btn btn-warning" onClicK="modificaRisorsaModal('${risorsa.id}')" title="Click per modificare la risorsa"><i class="fa fa-edit"></i></a>
 	<a  class="btn btn-danger" onClicK="modalEliminaRisorsa('${risorsa.id}')" title="Click per eliminare la risorsa"><i class="fa fa-trash"></i></a>
 --%>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>

<div class="row">
<div class="col-sm-12">

 <table id="tabReqDocumentali" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Codice</th>
<th>Descrizione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_documentali}" var="req" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${req.id }</td>	
	<td>${req.categoria.codice }</td>
	<td>${req.categoria.descrizione }</td>
	
	<td>

 <%-- 	<a  class="btn btn-warning" onClicK="modificaRisorsaModal('${risorsa.id}')" title="Click per modificare la risorsa"><i class="fa fa-edit"></i></a>
 	<a  class="btn btn-danger" onClicK="modalEliminaRisorsa('${risorsa.id}')" title="Click per eliminare la risorsa"><i class="fa fa-trash"></i></a>
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
        
			<select id="utente" name="utente" class="form-control select2" style="width:100%" data-placeholder="Seleziona utente..." required>
			<option value=""></option>
		
				<c:forEach items="${lista_utenti_all}" var="utente">
				<c:if test="${!lista_utenti.contains(utente) }">
			<option value="${utente.id }" disabled>${utente.nominativo }</option>
			</c:if>
			<c:if test="${lista_utenti.contains(utente) }">
			<option value="${utente.id }">${utente.nominativo }</option>
			</c:if>
			</c:forEach>
			
			</select>
       	</div>       	
       	
       	<div class="col-sm-6">
       		<label>Partecipante</label>
        
			<select id="partecipante" name="partecipante" class="form-control select2" style="width:100%" data-placeholder="Seleziona partecipante..." required>
			<option value=""></option>
			<c:forEach items="${lista_partecipanti_all}" var="partecipante">
				<c:if test="${!lista_partecipanti.contains(partecipante) }">
			<option value="${partecipante.id }" disabled>${partecipante.nome } ${partecipante.cognome }</option>
			</c:if>
			<c:if test="${lista_partecipanti.contains(partecipante) }">
			<option value="${partecipante.id }">${partecipante.nome } ${partecipante.cognome }</option>
			</c:if>
			</c:forEach>
		
			</select>
       	</div>  
       </div><br>
      
      <div class="row">
<div class="col-sm-12">
<label>REQUISITI DOCUMENTALI</label>
</div>
</div>
 <div class="row">
<div class="col-sm-12">
 <table id="tabRequisitiDocumentali" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID</th>
<th>Codice</th>
<th>Categoria</th>
<th>Descrizione</th>
<th>Data Scadenza</th>
 </tr></thead>
 
 <tbody>
 
 	<%-- <c:forEach items="${lista_requisiti_documentali}" var="requisito" varStatus="loop">
 
	<tr id="row_${loop.index}" >
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.categoria.codice }</td>
	<td>${requisito.categoria.descrizione }</td>	
	</tr>
	</c:forEach>
	  --%>

 </tbody>
 </table>  
</div>
</div>
       
       
             <div class="row">
<div class="col-sm-12">
<label>REQUISITI SANITARI</label>
</div>
</div>
 <div class="row">
<div class="col-sm-12">
 <table id="tabRequisitiSanitari" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<td></td>
<th>ID</th>
<th>Descrizione</th>
<th style="max-width:50px">Stato</th>
<th style="max-width:100px">Data inizio</th>
<th style="max-width:100px">Data fine</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_sanitari}" var="requisito" varStatus="loop">
 	
	<tr >
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.descrizione }</td>
	<td id="stato_${requisito.id }"></td>	
	<td id="datainizio_${requisito.id }"></td>
	<td id="datafine_${requisito.id }"></td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
       
       </div>
  		 
      <div class="modal-footer">
		<input id="id_req_documentali" name="id_req_documentali" type="hidden">
		<input id="id_req_sanitari" name="id_req_sanitari" type="hidden">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>


<form id="modificaRisorsaForm" name="nuovaRisorsaForm">
<div id="modalModificaRisorsa" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Risorsa</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-6">
       		<label>Utente</label>
        
			<select id="utente_mod" name="utente_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona utente..." required>
			<option value=""></option>
			<c:forEach items="${lista_utenti_all}" var="utente">
				
			<option value="${utente.id }" >${utente.nominativo }</option>
			
			</c:forEach>
			</select>
       	</div>       	
       	
       	<div class="col-sm-6">
       		<label>Partecipante</label>
        
			<select id="partecipante_mod" name="partecipante_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona partecipante..." required>
			<option value=""></option>
			<%-- <c:forEach items="${lista_partecipanti_all}" var="partecipante">
				<c:if test="${!lista_partecipanti.contains(partecipante) }">
			<option value="${partecipante.id }" disabled>${partecipante.nome } ${partecipante.cognome }</option>
			</c:if>
			<c:if test="${lista_partecipanti.contains(partecipante) }">
			<option value="${partecipante.id }">${partecipante.nome } ${partecipante.cognome }</option>
			</c:if>
			</c:forEach> --%>
			<c:forEach items="${lista_partecipanti_all}" var="partecipante">
			
			<option value="${partecipante.id }" >${partecipante.nome } ${partecipante.cognome }</option>
	
		
			</c:forEach>
			</select>
       	</div>  
       </div><br>
      
      <div class="row">
<div class="col-sm-12">
<label>REQUISITI DOCUMENTALI</label>
</div>
</div>
 <div class="row">
<div class="col-sm-12">
 <table id="tabRequisitiDocumentali_mod" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active" >

<th>ID</th>
<th>Codice</th>
<th>Categoria</th>
<th>Descrizione</th>
<th>Data Scadenza</th>
 </tr></thead>
 
 <tbody>
 
<%--  	<c:forEach items="${lista_requisiti_documentali}" var="requisito" varStatus="loop">
 
	<tr id="row_doc_mod_${requisito.id }">
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.categoria.codice }</td>
	<td>${requisito.categoria.descrizione }</td>	
	</tr>
	</c:forEach> --%>
	 

 </tbody>
 </table>  
</div>
</div>
       
       
             <div class="row">
<div class="col-sm-12">
<label>REQUISITI SANITARI</label>
</div>
</div>
 <div class="row">
<div class="col-sm-12">
 <table id="tabRequisitiSanitari_mod" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<td></td>
<th>ID</th>
<th>Descrizione</th>
<th style="max-width:50px">Stato</th>
<th style="max-width:100px">Data inizio</th>
<th style="max-width:100px">Data fine</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_requisiti_sanitari}" var="requisito" varStatus="loop">
 	
	<tr id="row_san_mod_${requisito.id }">
	<td></td>
	<td>${requisito.id }</td>	
	<td>${requisito.descrizione }</td>
	<td id="stato_mod_${requisito.id }"></td>	
	<td id="datainizio_mod_${requisito.id }"></td>
	<td id="datafine_mod_${requisito.id }"></td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
       
       </div>
  		 
      <div class="modal-footer">
      <input id="id_risorsa" name="id_risorsa" type="hidden">
		<input id="id_req_documentali_mod" name="id_req_documentali_mod" type="hidden">
		<input id="id_req_sanitari_mod" name="id_req_sanitari_mod" type="hidden">
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
      	Sei sicuro di voler eliminare la risorsa?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="risorsa_elimina">
      <a class="btn btn-primary" onclick="eliminaRisorsa($('#risorsa_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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

function modalEliminaRisorsa(id_risorsa){
	
	$('#risorsa_elimina').val(id_risorsa)
	$('#myModalYesOrNo').modal()
}

function eliminaRisorsa(id_risorsa){
	
	dataObj ={};
	dataObj.id_risorsa = id_risorsa
	callAjax(dataObj, "gestioneRisorse.do?action=elimina_risorsa")
	
}


var flag = false;
function modificaRisorsaModal(id_risorsa){
	
	flag = true;
	var response = getRisorsa(id_risorsa, null, function(response){
	
		    var lista_requisiti_risorsa = response.lista_requisiti_risorsa;
		    var risorsa = response.risorsa;
		    var lista_corsi = response.lista_corsi
		    
		     var tableSan = $('#tabRequisitiSanitari_mod').DataTable();
		    $('#id_risorsa').val(id_risorsa)
		
	      	
	  		$('#utente_mod').val(risorsa.utente.id);
			$('#partecipante_mod').val(risorsa.partecipante.id);
			$('#partecipante_mod').change();
			$('#utente_mod').change();
			
	
			for (var i = 0; i < lista_requisiti_risorsa.length; i++) {
				var r = lista_requisiti_risorsa[i];
				
				
	
				if(r.req_sanitario!=null){
					
					tableSan.row( "#row_san_mod_"+ r.req_sanitario.id, { page:   'all'}).select();
					
					 var row = $("#row_san_mod_"+ r.req_sanitario.id);
				       

				        row.find('td').each(function(i, cell) {
				            let testo = "";

				           if (i === 3) {
				                // SELECT
				                let select = $(cell).find("select");
				                
				                $(select[0]).val(r.stato)
				               
				            } else if(i == 4){
				                // Datepicker input
				                let input = $(cell).find("input");
				                $(input[0]).val(r.req_san_data_inizio)
				            }
				            else if(i == 5){
				            	let input = $(cell).find("input");
				                $(input[0]).val(r.req_san_data_fine)
				            }
				            
				});
				}	   
			}
			});
			$('#modalModificaRisorsa').modal();
		 flag = false;
	
}

var columsDatatables = [];

$("#tabReqDocumentali").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabReqDocumentali thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabReqDocumentali thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$(document).ready(function() {
	


     $('.dropdown-toggle').dropdown();

     table = $('tabReqDocumentali').DataTable({
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
		
		table.buttons().container().appendTo( '#tabReqDocumentali_wrapper .col-sm-6:eq(1)');
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
		


		
		
		
	     t = $('tabReqSanitari').DataTable({
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
			
			t.buttons().container().appendTo( '#tabtabReqSanitari_wrapper .col-sm-6:eq(1)');
		 	    $('.inputsearchtable').on('click', function(e){
		 	       e.stopPropagation();    
		 	    });

		 	     t.columns().eq( 0 ).each( function ( colIdx ) {
		  $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
		      t
		          .column( colIdx )
		          .search( this.value )
		          .draw();
		  } );
		} );  
		
		
		
			t.columns.adjust().draw();
			



	
	
	
	

    
	
	
});
	


 
 $('#nuovaRisorsaForm').on('submit', function(e){
	 e.preventDefault();
	 
	    var id_req_documentali = "";
	    t1.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
	        id_req_documentali += id + ";";
	    });

	   var id_req_sanitari = "";
	   t2.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	        var valori = "";

	        $row.find('td').each(function(i, cell) {
	            let testo = "";

	            if (i === 0 || i === 2) return; // Salta checkbox e descrizione

	            if (i === 1) {
	                // ID
	                testo = $(cell).text().trim();
	            } else if (i === 3) {
	                // SELECT
	                let select = $(cell).find("select");
	                if (select.length) {
	                    testo = select.val();
	                }
	            } else {
	                // Datepicker input
	                let input = $(cell).find("input");
	                if (input.length) {
	                    testo = input.val();
	                }
	            }

	            valori += testo + ",";
	        });

	        id_req_sanitari += valori.slice(0, -1) + ";";
	    });
	    
	    
	$('#id_req_sanitari').val(id_req_sanitari)
	$('#id_req_documentali').val(id_req_documentali)
	
	callAjaxForm('#nuovaRisorsaForm','gestioneRisorse.do?action=nuova_risorsa');
});
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

