<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    



 <table id="tabAccessoriItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>Nome</th>
 <th>Descrizione</th>
 <th>Note</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_accessori}" var="accessorio" varStatus="loop">
<tr>
<td align="center">
<a   class="btn btn-primary pull-center"  title="Click per inserire l'item"   onClick="insertItem('${accessorio.id}','${accessorio.descrizione.replace('\'',' ').replace('\\','/')}')"><i class="fa fa-plus"></i></a>

</td>
<td>${accessorio.id}</td>
<td>${accessorio.nome}</td>
<td>${accessorio.descrizione}</td>
<td><input type="text" id="note_item${accessorio.id}" style="width:100%" ></td> 

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 
 


 function insertItem(id, descrizione){
	 
	 var note = $('#note_item'+id).val();
	
	 insertEntryItem(id,descrizione, 'Accessorio', 3, note,null, null, null, null, null, null);
	 //insertEntryItem(id,descrizione, 'Generico', 3, note,null, null, null, null, matricola, null);
 }

	var columsDatatables = [];
	 
	$("#tabAccessoriItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabAccessoriItem thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabAccessoriItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );



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
	      stateSave: true,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


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