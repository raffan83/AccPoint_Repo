<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<table id="tabUscita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantit�</th>
 <th>Stato</th>
 <th>Destinazione</th>
 <th>Priorit�</th>
 <th>Note</th>
 <th>Attivit�</th>
 <td><label>Action</label> <input type="checkbox" id="check_all"></td> 

 </tr></thead>
 
 <tbody>
 <c:forEach items="${item_pacco_fornitore }" var="item_pacco" varStatus="loop">
 <c:if test="${item_pacco.item.tipo_item.id==1}">
 <tr>
<td>${item_pacco.item.id_tipo_proprio }</td>
<td>${item_pacco.item.tipo_item.descrizione }</td>
<td>${item_pacco.item.descrizione }</td>
<td>${item_pacco.quantita }</td>
<td>${item_pacco.item.stato.descrizione }</td>

<td>${item_pacco.item.destinazione }</td>
<c:choose>
<c:when test="${item_pacco.item.priorita==1}">
<td>Urgente</td>
</c:when>
<c:otherwise>
<td></td>
</c:otherwise>
</c:choose> 
<td>${item_pacco.note}</td>
<td>${item_pacco.item.attivita_item.descrizione }</td>
<td><input type="checkbox" id="checkbox_${item_pacco.item.id_tipo_proprio }"></td> 
</tr>
</c:if>
</c:forEach>
</tbody>
 </table>
 
 
 
 <script type="text/javascript">
 
 var columsDatatables3 = [];
 
	$("#tabUscita").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables3 = state.columns;
	    }
	    $('#tabUscita thead th').each( function () {
	     	if(columsDatatables3.length==0 || columsDatatables3[$(this).index()]==null ){columsDatatables3.push({search:{search:""}});}
	    	  var title = $('#tabUscita thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    

	} );
 
 
	

 		$('#check_all').change(function(){
			   var tabella = $('#tabUscita').DataTable();
			   var rows = tabella.rows()
			   var data = tabella
			     .rows()
			     .data();
				if(this.checked){
					 for(var i = 0; i<data.length; i++){
						 $('#checkbox_'+data[i][0]).prop('checked', true);
					 }
				 }else{
					 for(var i = 0; i<data.length; i++){
						 $('#checkbox_'+data[i][0]).prop('checked', false);				
					 }			 
				 }

		
	}); 
	
	
 $(document).ready(function() {
	 
 table = $('#tabUscita').DataTable({
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
	    	    /*  { responsivePriority: 1, targets: 7 },
	                  { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 0 }, 
	                   { responsivePriority: 4, targets: 8 }, */
	                  // { responsivePriority: 5, targets: 16 }
	    	  //{ responsivePriority: 1, targets: 9 },
	    	  { responsivePriority: 1, targets: 0 },
	    	  { responsivePriority: 2, targets: 8 },	    	  
	    	   { responsivePriority: 3, targets: 9 },
	    	  {orderable: false, targets: 9}
	    	  
	               ], 
	    });
	    
 });
 
/*   $('.inputsearchtable').on('click', function(e){
       e.stopPropagation();    
    }); */
//DataTable
//table = $('#tabPM').DataTable();
//Apply the search
/*       	table = $('#tabUscita').DataTable();
    	     		table.columns().eq( 0 ).each( function ( colIdx ) {
    	    			 $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
    	    				 table
    	    			      .column( colIdx )
    	    			      .search( this.value )
    	    			      .draw();
    	    			 } );
    	    			 } );   
    	    		table.columns.adjust().draw();   */
</script>