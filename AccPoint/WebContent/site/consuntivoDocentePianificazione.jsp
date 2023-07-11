<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


 <table id="tabConsuntivo" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Commessa</th>

<th>Tipo</th>
<th>Stato</th>
<th>Data</th>
<th>Note</th>
<th>Ora Inizio</th>
<th>Ora Fine</th>
<th>Pausa Pranzo</th>


 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_pianificazioni }" var="pianificazione" varStatus="loop">
	<tr class="riga" id="row_${loop.index}" >

<td>${pianificazione.id_commessa }</td>
<td>${pianificazione.tipo.descrizione }</td>
<td>${pianificazione.stato.descrizione }</td>
<td><fmt:formatDate value="${pianificazione.data }" pattern="dd/MM/yyyy"/></td>
<td>
<c:if test="${fn:length(pianificazione.note)>20 }">
${utl:escapeJS(pianificazione.note.substring(0,20)) }...
</c:if>
<c:if test="${fn:length(pianificazione.note)<=20 }">
${utl:escapeJS(pianificazione.note) }
</c:if>
</td>
<td class="col_inizio">${pianificazione.ora_inizio }</td>
<td class="col_fine">${pianificazione.ora_fine }</td>
<td class="pausa_pranzo">${pianificazione.pausa_pranzo }</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
 <div class="row">
 <div class="col-xs-10
 "></div>
 <div class="col-xs-2">
 <label>Tot. Ore Pianificate</label>
 <input class="form-control" readonly type="text" id="tot_durata">
 </div>

 
 </div>
 
 
 <style>


.table th {
    background-color: #3c8dbc !important;
  }</style>
 
 
 <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
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



 
 function sommaDati(){
	 
	 var sommaOre = 0; // Variabile per la somma delle ore
	  var sommaMinuti = 0;


	  $('.riga').each(function() {
	    var orario1 = $(this).find('.col_inizio').text().trim(); // Ottieni il testo della colonna1 e rimuovi spazi bianchi
	    var orario2 = $(this).find('.col_fine').text().trim(); // Ottieni il testo della colonna2 e rimuovi spazi bianchi
		var pausa_pranzo = $(this).find('.pausa_pranzo').text().trim();
	    
	    if (orario1 && orario2) {
	      // Trasforma gli orari in istanze di Moment.js
	      var orarioMoment1 = moment(orario1, "HH:mm");
	      var orarioMoment2 = moment(orario2, "HH:mm");
	      

	      // Calcola la differenza tra gli orari e aggiungila alla somma delle differenze
	      if(pausa_pranzo == "SI"){
	    	 
	    	  var differenza = moment.duration(orarioMoment2.diff(orarioMoment1));
	    	  differenza.subtract(moment.duration({ hours: 1 }));
	      }else{
	    	  var differenza = moment.duration(orarioMoment2.diff(orarioMoment1));
	      }
	    
	      
	      
	      sommaOre += differenza.hours();
	      sommaMinuti += differenza.minutes();

	      // Aggiungi 1 all'ora se i minuti superano 59
	      if (sommaMinuti >= 60) {
	        sommaOre += Math.floor(sommaMinuti / 60);
	        sommaMinuti = sommaMinuti % 60;
	      }
	    }
	  });

	  // Formatta la somma delle differenze
	 // var sommaFormattata = moment.utc(sommaDifferenze.asMilliseconds()).format("HH:mm");
	  var oreFormattate = sommaOre.toString().padStart(2, '0');
	  var minutiFormattati = sommaMinuti.toString().padStart(2, '0');

	  // Crea la stringa formattata "HH:mm"
	  var sommaFormattata = oreFormattate + ":" + minutiFormattati;

	  $('#tot_durata').val(sommaFormattata);

	 
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

     table = $('#tabConsuntivo').DataTable({
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
		
		table.buttons().container().appendTo( '#tabConsuntivo_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	      sommaDati();
	  } );
	} );  
	
	
	
		table.columns.adjust().draw();
		

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