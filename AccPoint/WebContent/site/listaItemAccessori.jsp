<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    



 <table id="tabAccessoriItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Nome</th>
 <th>Descrizione</th>
 <th></th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_accessori}" var="accessorio" varStatus="loop">
<tr>
<td>${accessorio.id}</td>
<td>${accessorio.nome}</td>
<td>${accessorio.descrizione}</td>
<td>
<a   class="btn btn-primary pull-center"  title="Click per inserire l'item"   onClick="insertEntryItem('${accessorio.id}','${accessorio.descrizione}', 'Accessorio' ,3)"><i class="fa fa-plus"></i></a>

</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 

	

       
<!--         <link type="text/css" href="plugins/timepicker/bootstrap-timepicker.css" /> 
        <link type="text/css" href="plugins/timepicker/bootstrap-timepicker.min.css" /> 
        <link type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.min.css" /> -->

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 

/*  function inserisciAccessorioItem(id_accessorio, denominazione){
		
		
		var x = document.getElementById("tabItem");
		
		var row = x.insertRow(1);
		
		var html_to_insert = '<td>'+id_accessorio+'</td><td>Accessorio</td><td>'+denominazione+'</td>';

		row.innerHTML = html_to_insert;

	}
  */
 
 
 
 
  $(document).ready(function() {
 
 table = $('#tabAccessoriItem').DataTable({
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
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	

 $('#tabAccessoriItem thead th').each( function () {
var title = $('#tabAccessoriItem thead th').eq( $(this).index() ).text();
$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} );
	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
table = $('#tabAccessoriItem').DataTable();
//Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
   table
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	table.columns.adjust().draw();
	

$('#tabAccessoriItem').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 


</script>