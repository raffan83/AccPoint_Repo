<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>




<div class="row">
<div class="col-sm-12">

 <table id="tabInteventiRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
<th>ID</th>
<th>Commessa</th>
<th>Cliente</th>
<th>Sede</th>
<th>Stato</th>
<th>Data apertura</th>
<th>Data chiusura</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_interventi }" var="intervento" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${intervento.id }</td>
	<td>${intervento.commessa }</td>
	<td>${intervento.nome_cliente }</td>
	<td>${intervento.nome_sede }</td>
	<td>
	
	<c:if test="${intervento.stato_intervento==1 }">
	<span class="label label-success">APERTO</span>
	</c:if>
	
	<c:if test="${intervento.stato_intervento==2 }">
	<span class="label label-danger">CHIUSO</span>
	</c:if>
	
	</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.data_apertura }" /></td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.data_chiusura }" /></td>	
<td>
<a class="btn btn-info" onClick="callAction('listaRilieviDimensionali.do?action=lista_rilievi_intervento&id_intervento=${intervento.id}')"><i class="fa fa-search"></i></a>
</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>

 <script type="text/javascript">
 
 
 

 





 
 

 
	var columsDatatables = [];
	 
	$("#tabInteventiRilievi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabInteventiRilievi thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabInteventiRilievi thead th').eq( $(this).index() ).text();
	    	
	    	
	    		  
		    $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');  
		    	  
	    	
	    	  
	    	
	    	} );
	    
	    

	} );
	

	

	
 
 
     var commessa_options;
$(document).ready(function() {
	 $('#label').hide();

	
	 
	 $('#mod_label').hide();
	 $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });

     
     
     var col_def = [];
     
     col_def =  [

   	  { responsivePriority: 1, targets: 1 }
   	 
              ] 
     

     

     
     
     
     commessa_options = $('#commessa option').clone();
	 
	 $('.dropdown-toggle').dropdown();
	 
	 table = $('#tabInteventiRilievi').DataTable({
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
		      "order": [[ 0, "desc" ]],
		      columnDefs: col_def,      
		
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabInteventiRilievi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabInteventiRilievi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	

});






	</script>