<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

 <a href="#" class="btn customTooltip customlink pull-right" title="Click per aprire il dettaglio della commessa" onclick="callAction('gestioneIntervento.do?idCommessa=${utl:encryptData(id_commessa)}');">${id_commessa }</a><label class="pull-right" style="margin-top:7px;">Commessa</label><br><br> 
       <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>Descrizione Attivita</th>
 <th>Note</th>
 <th>Descrizione Articolo</th>
 <th>Quantit&agrave;</th>

 </tr></thead>
 
 <tbody>

 <c:forEach items="${lista_attivita}" var="attivita">
 
 <tr role="row">

	<td>
  ${attivita.descrizioneAttivita}
	</td>
		<td>
  ${attivita.noteAttivita}
	</td>	
	<td>
  ${attivita.descrizioneArticolo}
	</td>	
	<td>
  ${attivita.quantita}
	</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  

 <div class="form-group">
 
                  <label>Note Commessa</label>
   <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-12">             
		<textarea id="note_commessa" name="note_commessa" rows="6" style="width:100%" disabled>${note_commessa }</textarea>
  </div>
   
 </div> 
</div>

		
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>

<script type="text/javascript" src="plugins/datejs/date.js"></script>
 <script type="text/javascript">

 var columsDatatables1 = [];
 
	$("#tabAttivita").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabAttivita thead th').each( function () {
	    	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
	    	var title = $('#tabItems thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');
	    	} );

	} );
 
	 $(document).ready(function() {
 
 table = $('#tabAttivita').DataTable({
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
	      searchable: true, 
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

	  table = $('#tabAttivita').DataTable();
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


	   $('#tabAttivita').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
	 theme: 'tooltipster-light'
	}); 

	 $('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})  


	});  
 
	 });
</script>
  


