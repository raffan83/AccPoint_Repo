<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:choose>
<c:when test="${item_pacco_fornitore.size()>0 && item_pacco_fornitore.get(0).getItem()!=null && item_pacco_fornitore.get(0).getItem().getTipo_item().getId()==4 }">
<c:set var="rilievi_dimensionali" value="1" ></c:set>
<table id="tabUscita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Rilievo</th>
 <th>Disegno</th>
 <th>Variante</th>
 <th>Pezzi in Ingresso</th>
 <th>Note</th>
 <td><label>Seleziona</label> <input type="checkbox" id="check_all"></td> 

 </tr></thead>
 
 <tbody>
 <c:forEach items="${item_pacco_fornitore }" var="item_pacco" varStatus="loop">
<%--  <c:if test="${item_pacco.item.tipo_item.id==1}">  --%>
 <tr>
<td>${item_pacco.item.id_tipo_proprio }</td>
<td>${item_pacco.item.disegno }</td>
<td>${item_pacco.item.variante }</td>
<c:if test="${item_pacco.gia_spediti!=null && item_pacco.gia_spediti!=0 }">
<td>${item_pacco.item.pezzi_ingresso } (Spediti ${item_pacco.gia_spediti })</td>
</c:if>
<c:if test="${item_pacco.gia_spediti==null || item_pacco.gia_spediti==0 }">
<td>${item_pacco.item.pezzi_ingresso }</td>
</c:if>
<td>${item_pacco.note}</td>

<td><input class="check_strumenti" type="checkbox" id="checkbox_${item_pacco.item.id_tipo_proprio }"></td> 
</tr>
<%--  </c:if>  --%>
</c:forEach>
</tbody>
 </table>

</c:when>
<c:otherwise>

<table id="tabUscita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
<c:set var="rilievi_dimensionali" value="0" ></c:set>
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Denominazione</th>
 <th>Matricola</th>
 <th>Stato</th>
 <th>Quantit�</th>
  <th>Tipo</th>
 
 <th>Destinazione</th>
 <th>Priorit�</th>
 <th>Note</th>
 <th>Attivit�</th>
 <td><label>Seleziona</label> <input type="checkbox" id="check_all"></td> 

 </tr></thead>
 
 <tbody>
 <c:forEach items="${item_pacco_fornitore }" var="item_pacco" varStatus="loop">
<%--  <c:if test="${item_pacco.item.tipo_item.id==1}">  --%>
 <tr>
<td>${item_pacco.item.id_tipo_proprio }</td>
<td>${item_pacco.item.descrizione }</td>
<td>${item_pacco.item.matricola }</td>
<td>${item_pacco.item.stato.descrizione }</td>
<td>${item_pacco.quantita }</td>
<td>${item_pacco.item.tipo_item.descrizione }</td>


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
<td><input class="check_strumenti" type="checkbox" id="checkbox_${item_pacco.item.id_tipo_proprio }"></td> 
</tr>
<%--  </c:if>  --%>
</c:forEach>
</tbody>
 </table>


</c:otherwise>



</c:choose>


<input type="hidden" id="totale">

 
 
 
 <script type="text/javascript">

   var columsDatatables = [];
 
	$("#tabUscita").on( 'init.dt', function ( e, settings ) {
	
	   var t = $('#tabUscita').DataTable();
	   var state = t.state.loaded();
	   	
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables = state.columns;
	    }
	    $('#tabUscita thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabUscita thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    

	} );   
 
/* 	var columsDatatables3 = [];
	 
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
	    

	} ); */


 		$('#check_all').change(function(){
			   var tabella = $('#tabUscita').DataTable();			  
				if(this.checked){					
					 var rows = tabella.rows({ 'search': 'applied' }).nodes();				    
				      $('input[type="checkbox"]', rows).prop('checked', true);
				 }else{					
					 var rows = tabella.rows({ 'search': 'applied' }).nodes();				    
				      $('input[type="checkbox"]', rows).prop('checked', false);
				 }
		}); 
	
	
 $(document).ready(function() {
	 $('#label_spediti').hide();
	 
	 console.log("itemUscita")

 
	 var ril = "${rilievi_dimensionali}";
	 if(ril=="1"){
		 isRilievi = "1";
		 coldef = [	 { responsivePriority: 1, targets: 0 },			 
			  {orderable: false, targets: 5}]
		
	 }else{
		 isRilievi = "0";
		 coldef = [	 { responsivePriority: 1, targets: 0 },
			  { responsivePriority: 2, targets: 8 },	    	  
			   { responsivePriority: 3, targets: 10 },
			  {orderable: false, targets: 10}];
	 }
	 



 
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
        pageLength: 100,
        "order": [[ 0, "desc" ]],
	      paging: true, 
	      ordering: false,
	      info: true, 
	      searchable: true, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: false,
	      columnDefs: coldef, 
	    });
	 coloraRigheUscita(table);
	 

 });
 
 
 $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
	 function coloraRigheUscita(tabella){
		var x = '${item_spediti_json}';
	  	 
		var item_spediti = JSON.parse(x)
		   var data = tabella
		     .rows()
		     .data();
	   		
	 		for(var i=0;i<data.length;i++){	
	 	 	    var node = $(tabella.row(i).node());  	    
	 	 	 
	 	 	    for(var j = 0;j<item_spediti.length;j++){
	 	 	    	if(data[i][0] == item_spediti[j].id_tipo_proprio){
	 	 	    		node.css('backgroundColor',"#FFE118");
	 	 	    		$('#label_spediti').css("color","#FFBF18");
	 	 	    		$('#label_spediti').show();
	 	 	    	}
	 	 	    }

	 	 	 }	
		}    
	 		

</script>