<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoCampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");

Gson gson = new Gson();
CampioneDTO dettaglioCampionec=(CampioneDTO)session.getAttribute("dettaglioCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


%>

 <table id="tabCertificati" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th>Id Certificato</th>
  <th>Numero Certificato</th>
 <th>Data Creazione</th>
 <th>Ente Certificatore</th>
	<c:if test="${userObj.checkPermesso('LISTA_CERTIFICATI_CAMPIONE_METROLOGIA')}">

	<th>Azioni</th>
		</c:if>		
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${dettaglioCampione.listaCertificatiCampione}" var="certificatocamp" varStatus="loop">
	<c:if test="${certificatocamp.obsoleto eq 'N'}">
	<tr role="row" id="${certificatocamp.id}-${loop.index}">
	
		<td>${certificatocamp.id}</td>
		<td>${certificatocamp.numero_certificato}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificatocamp.dataCreazione}" /></td>
		<td>${certificatocamp.ente_certificatore}</td>
	<c:if test="${userObj.checkPermesso('LISTA_CERTIFICATI_CAMPIONE_METROLOGIA')}">
		<td>

		<a href="scaricaCertificato.do?action=certificatoCampioneDettaglio&idCert=${certificatocamp.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a>
		<a href="#" onClick="modalEliminaCertificatoCampione(${certificatocamp.id})" class="btn btn-danger"><i class="fa fa-remove"></i></a>
		
		</td>
	
	</c:if>		
	
	
	</tr>
</c:if>
	</c:forEach>
 
	
 </tbody>
 </table> 





 <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabCaetificati").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabCertificati thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    } );
	} );
  
    $(document).ready(function() {
    
   var tableCertificati = $('#tabCertificati').DataTable({
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
     
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      order: [[ 0, "desc" ]],
  	      
  	      columnDefs: [
  	                  { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 }
  	       
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	  
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	tableCertificati.buttons().container().appendTo( '#tabCertificati_wrapper .col-sm-6:eq(1)');
	    
  
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tableCertificati = $('#tabCertificati').DataTable();
  // Apply the search
  tableCertificati.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableCertificati.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableCertificati
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tableCertificati.columns.adjust().draw();
    	
	
	$('#tabCertificati').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
  	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});


 
    });



  </script>				