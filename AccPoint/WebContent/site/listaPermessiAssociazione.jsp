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
	

  <table id="tabPermessi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Chiave Permesso</th>
 <th>Descrizione</th>
 <th>Pagina</th>
 <th>Percorso</th>
  <th>Azioni</th>
  
 </tr></thead>
  
 <tbody>
 
 <c:forEach items="${listaPermessi}" var="permesso" varStatus="loop">

	 <tr <c:if test = "${ruolo.checkPermesso(permesso.chiave_permesso)}">class="bg-blue color-palette"</c:if> role="row" id="tabPermessiTr_${permesso.idPermesso}">

	<td>${permesso.idPermesso}</td>
	<td>${permesso.chiave_permesso}</td>
	<td>${permesso.descrizione}</td>
	<td>${permesso.pagina }
	<td>${permesso.percorso }
	<td>
		
			<button id="btnAssociaPermessi_${permesso.idPermesso}" onClick="associaPermesso('${permesso.idPermesso}','${idRuolo}')" class="btn btn-success  customTooltip" title="Abilita Permesso" <c:if test = "${ruolo.checkPermesso(permesso.chiave_permesso)}">disabled="disabled"</c:if> ><i class="fa fa-check"></i></button> 
			<button id="btnDisAssociaPermessi_${permesso.idPermesso}" onClick="disassociaPermesso('${permesso.idPermesso}','${idRuolo}')" class="btn btn-danger  customTooltip" title="Disabilita Permesso" <c:if test = "${!ruolo.checkPermesso(permesso.chiave_permesso)}">disabled="disabled"</c:if> ><i class="fa fa-remove"> </i></button>
		
		

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


/* 	var columsDatatables = [];
	 
	$("#tabPermessi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
 	    $('#tabPermessi thead th').each( function () {
	    	  $('#inputsearchtable_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);
	    	 
	    	});

	} ); */
	

    $(document).ready(function() {
    	

            $('#tabPermessi thead th').each( function () {
             	
            	var title = $('#tabPermessi thead th').eq( $(this).index() ).text();
            	
            	$(this).append( '<div><input class="inputsearchtable" style="width:100%" id=search_item_'+$(this).index()+' type="text"  value=""/></div>');
            	
            	} );

    	tabPermessi = $('#tabPermessi').DataTable({
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
  	                 
  	                 { responsivePriority: 2, targets: 5 },
  	               { responsivePriority: 3, targets: 3 },
  	             { responsivePriority: 4, targets: 4 },
  	           { responsivePriority: 5, targets: 2 }
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
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
  	                         
  	          ]
  	    	
  	      
  	    });
    	
    	tabPermessi.buttons().container().appendTo( '#tabPermessi_wrapper .col-sm-6:eq(1)');
  

  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tabPermessi = $('#tabPermessi').DataTable();
  // Apply the search
  tabPermessi.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tabPermessi.column( colIdx ).header() ).on( 'keyup', function () {
    	  tabPermessi
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tabPermessi.columns.adjust().draw();
    	
	
	$('#tabPermessi').on( 'page.dt', function () {
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

