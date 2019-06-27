<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<div class="row">
<div class="col-xs-12">
<table id="tabAllegati" class="table table-hover table-striped" role="grid" width="100%">
				<thead><tr class="active">
				<th></th>
				<th></th>
				</thead>
				<tbody>
				
 				<c:forEach items="${lista_allegati}" var="allegato">	
 		 		<tr>
 		 		<td>
				${allegato.allegato }
				
				<c:url var="url_allegato" value="gestionePacco.do">
                  <c:param name="allegato"  value="${allegato.allegato}" />
                  <c:param name="codice_pacco"  value="${allegato.pacco.codice_pacco}" />
  					<c:param name="action" value="download_allegato" />
				  </c:url></td>
				
				<td>
				<span class="pull-right"><a   class="btn btn-primary customTooltip  btn-xs"  title="Click per scaricare l'allegato"   onClick="callAction('${url_allegato}')"><i class="fa fa-arrow-down"></i></a>
				<a   class="btn btn-danger customTooltip  btn-xs"  title="Click per eliminare l'allegato"   onClick="modalYesOrNo('${allegato.id }','${allegato.pacco.id }')"><i class="fa fa-trash"></i></a>
				<%-- <a   class="btn btn-danger customTooltip  btn-xs"  title="Click per eliminare l'allegato"   onClick="eliminaAllegatoMagazzino('${allegato.id }','${allegato.pacco.id }')"><i class="fa fa-trash"></i></a> --%>
						</span></td>
		 		</tr>
		 		</c:forEach>
				</tbody>
				</table>
</div>
</div>


				
 <script type="text/javascript">

 
$(document).ready(function(){
	
	console.log("test");
	
	table = $('#tabAllegati').DataTable({
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
	      ordering: false,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      searching: false,
	       columns : [
	     	 {"data" : "allegato"},
	     	 {"data" : "action"}
	      ],	
	        /* columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ],   */

	    	
	    });


	
});


 </script>
 