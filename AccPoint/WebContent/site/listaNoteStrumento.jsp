<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

	 <table id="tabNote" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

                       
                       
 						<th>ID</th>
  						<th>Modifiche</th>
 						  <th>Utente</th>
 						  <th>Data</th>                      
 </tr></thead>
 
 <tbody>
 <c:forEach items="${lista_note }" var="nota">

 <tr>
 <td>${nota.id }</td>
 <%-- <td><c:forEach items="${nota.getDescrizione().split('|')}" var="modifica" varStatus="loop">${nota.getDescrizione().split('|')[loop.index]}</c:forEach></td> --%>
 <td>-${nota.descrizione.replace('|', '<br>-') }</td>
 <td>${nota.user.nominativo }</td>
 <td><fmt:formatDate pattern="dd/MM/yyyy" value="${nota.data }"></fmt:formatDate></td>
 
 
 
 </tr>
 </c:forEach>
 
 </tbody>
              			   		
              
</table> 


<script>
var tableNote = $('#tabNote').DataTable({
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
  pageLength: 100,
     paging: true, 
     ordering: true,
     info: true, 
     searchable: false, 
     targets: 0,
     responsive: true,
     scrollX: false,
     stateSave: true,
     order:[[0, "desc"]],
     columnDefs: [
				 /* 
                  { responsivePriority: 1, targets: 0 },
                  { responsivePriority: 2, targets: 1 },
                  { responsivePriority: 3, targets: 2 },
                  { responsivePriority: 4, targets: 3 },	                 
                  { responsivePriority: 5, targets: 4 },
                  { responsivePriority: 6, targets: 5 },
                  { responsivePriority: 7, targets: 23 }, 
                  { responsivePriority: 8, targets: 8},
                 /*  { orderable: false, targets: 6 }, */
              ],
   

     
   });




$('#tabNote thead th').each( function () {
	var title = $('#tabNote thead th').eq( $(this).index() ).text();
	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} );
	
$('.inputsearchtable').on('click', function(e){
		e.stopPropagation();    
});

// DataTable
	tableNote = $('#tabNote').DataTable();

// Apply the search
tableNote.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tableNote.column( colIdx ).header() ).on( 'keyup', function () {
		tableNote.column( colIdx ).search( this.value ).draw();		
	} );
} ); 

tableNote.columns.adjust().draw();
</script>