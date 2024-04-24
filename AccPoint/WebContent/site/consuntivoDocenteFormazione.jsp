<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

 <table id="tabConsuntivo" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID Corso</th>

<th>Categoria</th>
<th>Descrizione</th>
<th>Tipologia</th>
<th>Commessa</th>
<th>Durata (Ore)</th>
<th>Data</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_corsi }" var="corso" varStatus="loop">
	<tr id="row_${loop.index}" >
<td>
<a class="btn customTooltip customlink" onClick="dettaglioCorso('${utl:encryptData(corso.id)}')" title="Vai al corso">${corso.id}</a>
</td>

<td>${corso.corso_cat.descrizione }</td>
<td>${corso.descrizione }</td>
<td>${corso.tipologia }</td>
<td>${corso.commessa }</td>
<td>${corso.durata }</td>
<td><fmt:formatDate value="${corso.data_corso }" pattern="dd/MM/yyyy"/></td>

	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
 <div class="row">
 <div class="col-xs-10
 "></div>
 <div class="col-xs-2">
 <label>Tot. Durata (Ore)</label>
 <input class="form-control" readonly type="text" id="tot_durata">
 </div>

 
 </div>
 
 
 <style>


.table th {
    background-color: #3c8dbc !important;
  }</style>
 
 <script type="text/javascript">

 
 
 var columsDatatables = [];

 $("#tabConsuntivo").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabConsuntivo thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabConsuntivo thead th').eq( $(this).index() ).text();
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
 	    	//}

     	} );
     
     

 } );

 function dettaglioCorso(id_corso){
 	
 	callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso='+id_corso);
 }

 
 function sommaDati(){
	 
	 var tabella = $('#tabConsuntivo').DataTable();
	 

	 var tot_ore = 0;
	 
	 var data = tabella.rows({ search: 'applied' }).data();
	 
	 for(var i = 0; i<data.length; i++){
		 
	
		if(data[i][5]!=null && data[i][5]!=''){
			tot_ore = tot_ore  + parseInt(data[i][5]);	 
		 }
		 
		 
	 }
	 
	 $('#tot_durata').val(tot_ore);

	 
 }
 
 
 
 $(document).ready(function() {
	 
	 
	 

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();
     
     
     
     var start = "${dateFrom}";
  	var end = "${dateTo}";

  	$('input[name="datarange"]').daterangepicker({
 	    locale: {
 	      format: 'DD/MM/YYYY'
 	    
 	    }
 	}, 
 	function(start, end, label) {

 	});
  	
  	if(start!=null && start!=""){
 	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
 	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
 	
 	 }

     tabella = $('#tabConsuntivo').DataTable({
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
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 0 },
		    	
		    	  
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  },  {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  } ]
		               
		    });
		
		tabella.buttons().container().appendTo( '#tabConsuntivo_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tabella.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tabella.column( colIdx ).header() ).on( 'keyup', function () {
	      tabella
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	      sommaDati();
	  } );
	} );  
	
	
	
		tabella.columns.adjust().draw();
		

	$('#tabConsuntivo').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	sommaDati();
	
});

 
 </script>