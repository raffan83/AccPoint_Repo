<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<table id="tabPuntiQuota" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%"> 
 <thead><tr class="active">
 	<th>Quota</th>
	<th>Tolleranza -</th>
	<th>Tolleranza +</th>
	<th>Coordinata</th>
	<th>Valore Nominale</th>
	<th>Valore Pezzo</th>
 </tr>
 
 </thead>
 
 <tbody>
 
 <c:forEach items="${lista_punti_quote}" var="punto_quota" varStatus="loop">
 <tr id="riga_${loop.index}">
<%--  	<c:forEach items="${punti}" var="punto_quota">
 	<td>${punto_quota.quota.tolleranza_negativa }</td>
 	<td>${punto_quota.quota.tolleranza_positiva }</td>
 	<td>${punto_quota.quota.coordinata }</td>
 	<td>${punto_quota.quota.val_nominale }</td>
 	<td>${punto_quota.valore_punto }</td>
 	</c:forEach> --%>
 	<%-- <c:forEach items="${punti}" var="punto_quota"> --%>
 	<td>${punto_quota.quota.id }</td>
 	<td>${punto_quota.quota.tolleranza_negativa }</td>
 	<td>${punto_quota.quota.tolleranza_positiva }</td>
 	<td>${punto_quota.quota.coordinata }</td>
 	<td>${punto_quota.quota.val_nominale }</td>
 	<td>${punto_quota.valore_punto }</td>
 	<%-- </c:forEach>  --%>
 
	</tr>
	
	</c:forEach>

	
 </tbody>
 </table>
 
  <script type="text/javascript">


 $(document).ready(function(){

	 
	 tab = $('#tabPuntiQuota').DataTable({
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
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,
		       columnDefs: [
					    { responsivePriority: 1, targets: 0 },
					    { responsivePriority: 2, targets: 1 }
		                
		               ],  

		    	
		    });
		


		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	tab = $('#tabPuntiQuota').DataTable();
	//Apply the search
 	tab.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
		tab
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
	tab.columns.adjust().draw(); 
		

	$('#tabPuntiQuota').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	 
	 
 });
 
 </script>
			
			 