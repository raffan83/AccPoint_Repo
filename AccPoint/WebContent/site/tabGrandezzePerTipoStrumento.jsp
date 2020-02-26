<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

    <table id="tabTipoGrandezzeAdd" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Tipo Grandezza</th>
<th></th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_tipo_grandezza }" var="grandezza" varStatus="loop">
 	<tr id="rowadd_${grandezza.id }">
	<td>${grandezza.nome }</td>	
	<td >
	
	<c:choose>
	<c:when test="${lista_grandezze_tipo.contains(grandezza.id) }">
		<input type="checkbox"id="id_add_${grandezza.id }" data-toggle="toggle" data-size="mini" data-on=" " data-off=" " checked disabled>
		</c:when>
		<c:otherwise>
		<input type="checkbox" id="idadd_${grandezza.id }" data-toggle="toggle" data-size="mini" data-on=" " data-off=" " >
		</c:otherwise>
	</c:choose>
		
	</td>
	
	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>
 
 <div class="row">
       <div class="col-xs-12">
       <button class="btn btn-primary pull-right" id="save_button_add"  onclick="aggiungiTipoStrumento()">Salva</button>
       </div>
       </div>


 <script type="text/javascript">
 
 var columsDatatables2 = [];

 $("#tabTipoGrandezzeAdd").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     		columsDatatables2 = state.columns;
     }
     $('#tabTipoGrandezzeAdd thead th').each( function () {
      	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
     	  var title = $('#tabTipoGrandezzeAdd thead th').eq( $(this).index() ).text();
     	
     	  if($(this).index()==0){
     	  	$(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
     	  }    	
     	} );
     
     

 } );
 
 




 
 $(document).ready(function(){

	 console.log("test")
	 
	 $('input[type="checkbox"]').each( function (e) {
    
		 $(this).bootstrapToggle();
	

});
		
	 tab = $('#tabTipoGrandezzeAdd').DataTable({
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
	 	        	previous:	"Prec.",
	 	        	next:	"Succ.",
	 	        last:	"Fine",
	         	},
	         aria:	{
	 	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	 	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
	         }
	     },
	     pageLength: 10,
	     "order": [[ 0, "asc" ]],
	       paging: true, 
	       ordering: true,
	       info: true, 
	       searchable: false, 
	       targets: 0,
	       responsive: true,
	       scrollX: false,
	       stateSave: true,			       
	       columnDefs: [
	     	  {orderable: false, targets: 1} 
	                ], 	        
	 	      /* buttons: [   
	 	          {
	 	            extend: 'colvis',
	 	            text: 'Nascondi Colonne'  	                   
	 			  } ] */
	                
	     });

	 tab.buttons().container().appendTo( '#tabTipoGrandezzeAdd_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	   tab.columns().eq( 0 ).each( function ( colIdx ) {
	 $( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
		 tab
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	 } );
	 } ); 
	 	  tab.columns.adjust().draw();


	 $('#tabTipoGrandezzeAdd').on( 'page.dt', function () {
	 $('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });

	 $('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})

	 });
	 
 });
 
 function aggiungiTipoStrumento(){


		var tabella = $('#tabTipoGrandezzeAdd').DataTable();
		var id_tipo_strumento = $('#descrizione_mod').val();

			var checked = false;
			var ids = "";
			for(var i = 0; i<tabella.rows()[0].length; i++){
				var id_row = tabella.row(i).id();	
				if($('#idadd_'+id_row.split("_")[1]).prop('checked')){
					ids = ids+id_row.split("_")[1]+";"
					checked = true;				
				}
			}
			
			if(checked){
				submitAggiungiGrandezzaTipoStrumento(ids, id_tipo_strumento);
			}
			
	} 
 
 </script>  