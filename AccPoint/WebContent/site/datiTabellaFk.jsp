<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <table id="tabOpt" class="table table-bordered table-hover dataTable table-striped"  width="100%"> 
					 <thead><tr class="active">
					  <c:forEach items="${lista_colonne_fk}" var="colonna">
						  <th id="col_${colonna.name }">${colonna.name }</th>
					  </c:forEach>
					<td>Azione</td>
					 </tr>
					 
					 
					 
					 </thead>
					 
					 
					 <tbody>
					 
					 <c:forEach items="${dati_tabella_fk}" var="riga" varStatus="loop">
					 <tr id="riga_${loop.index}">
					 	<c:forEach items="${riga}" var="cella">
					 	<td>${cella}</td>
					 	</c:forEach>
					 <td><button class="btn btn-warning" title="Click per selezionare il valore" onClick="inserisciValoreFk('#riga_${loop.index}')" data-dismiss="modal"><i class="glyphicon glyphicon-menu-right"></i></button></td>
						</tr>
						
						</c:forEach>
					
						
					 </tbody>
 				</table> 
	
 <script type="text/javascript">
 
 n_colonne_fk = ${lista_colonne_fk.size()};

 var columsDatatables = [];
 
	$("#tabOpt").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabOpt thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabOpt thead th').eq( $(this).index() ).text();
	        /* if($(this).index()!= 0){ */
	        		$(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        //}

	} );

	} );
 	 
 	 
 	 
	function inserisciValoreFk(riga){

		var fk_column = "${colonna_fk}";
		var index = "${index_fk}"
		var col = tab.column("#col_"+fk_column);
		
		var row = tab.row(riga);
		datax = row.data();
	
		if(datax){
			row.child.hide();
	
		for(var i = 0; i<datax.length;i++){
			if(i==col.index()){
				$('#colonna_'+index).val(datax[i]);
				
			}
		}
			
		}
		
	}
	
 
 $(document).ready(function(){

	 
	 tab = $('#tabOpt').DataTable({
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
		       columnDefs: [
					    { responsivePriority: 1, targets: 0 },
					    { responsivePriority: 2, targets: n_colonne_fk }
		                
		               ],  

		    	
		    });
		


		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	tab = $('#tabOpt').DataTable();
	//Apply the search
 	tab.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
		tab
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
	tab.columns.adjust().draw(); 
		

	$('#tabOpt').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	 
	 
 });
 
 </script>
			
			