<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:choose>
<c:when test="${lista_email.size()>0 }">
<table id="tabStorico" class="table table-hover table-striped" role="grid" width="100%">
				<thead><tr class="active">
				<th>Utente</th>
				<th>Data invio</th>
				<th>Destinario</th>
				</thead>
				<tbody>
				
 				<c:forEach items="${lista_email}" var="email">	
 		 		<tr>
 		 		<td>${email.utente.nominativo }</td>
				<td><fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss" value="${email.data_invio}" /></td>
				<td>${email.destinatario }</td>
				
		 		</tr>
		 		</c:forEach>
				</tbody>
				</table>
</c:when>
<c:otherwise>

Non è stata ancora inviata nessuna email per il certificato!
</c:otherwise>
</c:choose>				

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">

 
$(document).ready(function(){
	
	console.log("test");
	
	table = $('#tabStorico').DataTable({
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
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      searching: false,
	      order: [1,"desc"]
	        /* columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ],   */

	    	
	    });


	
});


 </script>