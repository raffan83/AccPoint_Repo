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

<c:if test="${userObj.checkPermesso('CARICAMENTO_DOCUMENTI_ESTERNI_STRUMWENTO_METROLOGIA')}">
	<div>FORM CARICAMENTO</div>
</c:if>		

 <table id="tabDocumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 

  <th>Nome Documento</th>
 <th>Data Caricamento</th>
	<c:if test="${userObj.checkPermesso('LISTA_DOCUMENTI_ESTERNI_STRUMWENTO_METROLOGIA')}">

	<th>Azioni</th>
		</c:if>		
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${strumento.listaDocumentiEsterni}" var="documento" varStatus="loop">
 	<tr role="row" id="${certificatocamp.id}-${loop.index}">
	

		<td>${documento.nomeDocumento}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${documento.dataCaricamento}" /></td>
	<c:if test="${userObj.checkPermesso('LISTA_DOCUMENTI_ESTERNI_STRUMWENTO_METROLOGIA')}">
		<td>

		<a href="scaricaDocumentoEsternoStrumento.do?action=scaricaDocumento&idDoc=${documento.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a>
		<a href="#" onClick="modalEliminaDocumentoEsternoStrumento(${documento.id})" class="btn btn-danger"><i class="fa fa-remove"></i></a>
		
		</td>
	
	</c:if>		
	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 





 <script type="text/javascript">

  
    $(document).ready(function() {
    
   var tableDocumenti = $('#tabDocumenti').DataTable({
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
  	      order: [[ 0, "desc" ]],
  	      
  	      columnDefs: [
  	                  { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 }
  	       
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
    	
   tableDocumenti.buttons().container().appendTo( '#tableDocumenti_wrapper .col-sm-6:eq(1)');
	    
  $('#tableDocumenti thead th').each( function () {
      var title = $('#tabPM thead th').eq( $(this).index() ).text();
      $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
  } );
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tableDocumenti = $('#tableDocumenti').DataTable();
  // Apply the search
  tableDocumenti.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableCertificati.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableCertificati
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tableDocumenti.columns.adjust().draw();
    	
	
	$('#tableDocumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
  	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});


 
    });


  </script>				