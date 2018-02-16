<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%



	%>
	<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoTrend')" style="margin-bottom:30px">Nuovo Trend</button>
</div>
</div>
	<div class="row">
<div class="col-lg-12">
  <table id="tabTrend" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Data</th>
 <th>Valore</th>
  <th>Company</th>
  <th>Tipo Trend</th>
  <td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaTrend}" var="trend" varStatus="loop">

	 <tr role="row" id="tabTrendTr_${trend.id}">

	<td>${trend.id}</td>
	<td> 	<fmt:formatDate pattern="dd/MM/yyyy" value="${trend.data}" /> </td>
	<td>${trend.val}</td>
	<td>${trend.company.denominazione}</td>
	<td>${trend.tipoTrend.descrizione}</td>
	<td>
		
		
		
		<%-- 	<a href="#" onClick="modalModificaTrend('${trend.id}','${trend.data}','${trend.val}','${trend.company.id}','${trend.tipoTrend.id}')" class="btn btn-warning "><i class="fa fa-edit"></i></a>  --%>
		<a href="#" onClick="modalEliminaTrend('${trend.id}')" class="btn btn-danger "><i class="fa fa-remove"></i></a> 

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>
	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>

		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/additional-methods.min.js"></script>
	

<script type="text/javascript">



   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {

    	tabTrend = $('#tabTrend').DataTable({
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
    	
    	tabTrend.buttons().container().appendTo( '#tabTrend_wrapper .col-sm-6:eq(1)');
  
  $('#tabTrend thead th').each( function () {
      var title = $('#tabTrend thead th').eq( $(this).index() ).text();
      $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
  } );
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tabTrend = $('#tabTrend').DataTable();
  // Apply the search
  tabTrend.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tabTrend.column( colIdx ).header() ).on( 'keyup', function () {
    	  tabTrend
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tabTrend.columns.adjust().draw();
    	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})

  	 $('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     });
    	
	      
});


	  

  </script>

