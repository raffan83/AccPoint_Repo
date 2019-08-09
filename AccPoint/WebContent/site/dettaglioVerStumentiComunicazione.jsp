<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<div class="row">
<div class="col-sm-12">

 <table id="tabStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Denominazione</th>
<th>Cliente</th>
<th>Sede</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Matricola</th>
<th>Classe</th>
<th>Tipo</th>
<th>Tipologia</th>
<th>Data ultima verifica</th>
<th>Data prossima verifica</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${loop.index}" >
	<td>${strumento.id }</td>	
	<td>${strumento.denominazione }</td>
	<td>${strumento.nome_cliente }</td>
	<td>${strumento.nome_sede }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.modello }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.classe }</td>
	<td>${strumento.tipo.descrizione }</td>
	<td>${strumento.tipologia.descrizione }</td>		
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_ultima_verifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.data_prossima_verifica }" /></td>	
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>



<script type="text/javascript">

var columsDatatables = [];

$("#tabStrumenti").on( 'init.dt', function ( e, settings ) {
   var api = new $.fn.dataTable.Api( settings );
   var state = api.state.loaded();

   if(state != null && state.columns!=null){
   		console.log(state.columns);
   
   columsDatatables = state.columns;
   }

   

} ); 



$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
    $('.select2').select2();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
     $('#tabStrumenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabStrumenti thead th').eq( $(this).index() ).text();
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
     
     var table = $('#tabStrumenti').DataTable({
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
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,		     
		      columnDefs: [

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 11 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabStrumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabStrumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	}); 
     
     
});


</script>