<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.RuoloDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%



	%>
	

  <table id="tabUtenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Nome</th>
 <th>Cognome</th>
  <td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaUtenti}" var="utente" varStatus="loop">

	 <tr <c:if test = "${utente.checkRuolo(ruolo.sigla)}">class="bg-blue color-palette"</c:if> role="row" id="tabUtentiTr_${utente.id}">

	<td>${utente.id}</td>
	<td>${utente.nome}</td>
	<td>${utente.cognome}</td>
	<td>
		
			<button id="btnAssociaUtente_${utente.id}" onClick="associaUtente('${utente.id}','${idRuolo}')" class="btn btn-success customTooltip" title="Abilita Utente" <c:if test = "${utente.checkRuolo(ruolo.sigla)}">disabled="disabled"</c:if> ><i class="fa fa-check"></i></button> 
			<button id="btnDisAssociaUtente_${utente.id}" onClick="disassociaUtente('${utente.id}','${idRuolo}')" class="btn btn-danger customTooltip" title="Disabilita Utente"  <c:if test = "${!utente.checkRuolo(ruolo.sigla)}">disabled="disabled"</c:if> ><i class="fa fa-remove"> </i></button>
		
		

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">



   </script>

  <script type="text/javascript">


	var columsDatatables = [];
	 
	$("#tabUtenti").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabUtenti thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabUtenti thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} );

    $(document).ready(function() {

    	tabUtenti = $('#tabUtenti').DataTable({
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
  	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 }

  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	                         
  	          ]
  	    	
  	      
  	    });
    	
    	tabUtenti.buttons().container().appendTo( '#tabUtenti_wrapper .col-sm-6:eq(1)');
  

  $('.inputsearchtable').on('click', function(e){
	    e.stopPropagation();    
	 });
  // DataTable
	tabUtenti = $('#tabUtenti').DataTable();
  // Apply the search
  tabUtenti.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tabUtenti.column( colIdx ).header() ).on( 'keyup', function () {
    	  tabUtenti
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tabUtenti.columns.adjust().draw();
    	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
    $('#myModalError').on('hidden.bs.modal', function (e) {
		if($( "#myModalError" ).hasClass( "modal-success" )){

		}
		
		});
  	 $('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     });
    	
	      
});


	  

  </script>

