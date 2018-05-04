<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    

<button class="btn btn-primary" onClick="nuovoGenericoFromModal()">Nuovo Generico</button>

<br><br>

 <table id="tabGenericiItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Descrizione</th>
 <th>Categoria</th>
 <th>Note</th>
 <td></td>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_generici}" var="generico" varStatus="loop">
<tr>
<td>${generico.id}</td>
<td>${generico.descrizione}</td>
<td>${generico.categoria.descrizione}</td>
<td><input type="text" id="note_item${generico.id}" style="width:100%"></td> 

<td>
<a   class="btn btn-primary pull-center"  title="Click per inserire l'item"   onClick="insertItem('${generico.id}','${generico.descrizione}')"><i class="fa fa-plus"></i></a>
<%-- <a   class="btn btn-primary pull-center"  title="Click per inserire l'item"   onClick="insertEntryItem('${generico.id}','${generico.descrizione}', 'Generico', 3)"><i class="fa fa-plus"></i></a> --%>
</td>

	</tr>
	</c:forEach>
 </tbody>
 </table> 
 
 
 <div id="modalNuovoGenerico" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
             <button type="button" class="close" id=close_button aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Generico</h4>
      </div>
       <div class="modal-body">

        <form class="form-horizontal" id="formNuovoGenerico">
              

    <div class="form-group">
          <label class="col-sm-2 control-label">Categoria:</label>

         <div class="col-sm-10">
         
         <select class="form-control" id="categoria" name="categoria" required>
                      <c:forEach items="${categoria_generico }" var="categoria">
                       <option value="${categoria.id }">${categoria.descrizione }</option>
						</c:forEach>
         </select>
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Descrizione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="descrizione" type="text" name="descrizione" required />
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Quantità:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="quantita" type="number" name="quantita" min="1" />
    </div>
     </div>
          <button type="submit" class="btn btn-primary" >Salva</button>
        
        </form>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>





<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 
 function insertItem(id, descrizione){
	 
	 var note = $('#note_item'+id).val();
	
	 insertEntryItem(id,descrizione, 'Generico', 3, note);
 }
 

 function nuovoGenericoFromModal(){
	 
	 $('#modalNuovoGenerico').modal();
 }
 
	$('#formNuovoGenerico').on('submit',function(e){
	    e.preventDefault();
		nuovoGenerico();
	});
 

 	$('#myModalError').on("hidden.bs.modal", function (){
		
		$('.modal-backdrop').remove();
	
	}); 
	

 	 $('#close_button').on('click', function(){
 		$('#modalNuovoGenerico').modal('hide');
 	});

var columsDatatables = [];
 
$("#tabGenericiItem").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabGenericiItem thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	var title = $('#tabGenericiItem thead th').eq( $(this).index() ).text();
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	} );

} );


  $(document).ready(function() {
 

	  
	  
 table = $('#tabGenericiItem').DataTable({
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
	      searchable: false, 
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
table = $('#tabGenericiItem').DataTable();
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
	

$('#tabGenericiItem').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 


</script>