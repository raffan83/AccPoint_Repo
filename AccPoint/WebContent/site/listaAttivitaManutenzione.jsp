<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	


<table id="tabAttvitaManutenzione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Descrizione</th>
 <th>Esito</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_attivita_manutenzione}" var="attivita" varStatus="loop">
<tr>
<td>${attivita.id }</td>
<td>${attivita.tipo_attivita.descrizione}</td>
<td>${attivita.esito}</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
   
<script>
var columsDatatables = [];

$("#tabAttvitaManutenzione").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAttvitaManutenzione thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	var title = $('#tabAttvitaManutenzione thead th').eq( $(this).index() ).text();
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	} );

} );

$(document).ready(function() {
	 
	 tab2 = $('#tabAttvitaManutenzione').DataTable({
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
		      responsive: false,
		      scrollX: false,
		      stateSave: true,
		       columnDefs: [
					   { responsivePriority: 1, targets: 0 },
		                   { responsivePriority: 2, targets: 1 },
		                   
		               ], 

		    	
		    });
		


 		     $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	tab2 = $('#tabAttvitaManutenzione').DataTable();
	//Apply the search
	tab2.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tab2.column( colIdx ).header() ).on( 'keyup', function () {
	   tab2
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
		tab2.columns.adjust().draw();
		

	$('#tabAttvitaManutenzione').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	}); 

 
	 }); 


 </script>
 
				