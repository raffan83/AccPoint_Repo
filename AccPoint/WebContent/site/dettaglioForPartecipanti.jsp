<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row">
<div class="col-xs-12">
 <a class="btn btn-primary pull-right" onClick="associaUtentiModal('${corso.id}')" title="Click per associare gli utenti al corso"><i class="fa fa-plus"></i> Aggiungi Partecipanti</a>
</div>
</div><br>

<table id="tabPartecipanti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID</th>
<th>Nominativo</th>

<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${corso.getListaUtenti() }" var="utente" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${utente.id }</td>
	<td>${utente.nominativo }</td>
	
	<td>
	 
	
	<a href="#" class="btn btn-danger customTooltip" title="Click per eliminare il partecipante dal corso" onclick="associaDissociaUtentiCorso('dissocia',${utente.id},${corso.id })"><i class="fa fa-trash"></i></a> 
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>
        


<div id="myModalAssociaUtenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associa utenti al corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-12">
       
       <select name="utenti" id="utenti" data-placeholder="Seleziona Utenti..."  class="form-control select2" multiple aria-hidden="true" data-live-search="true" style="width:100%"  >
                    
                    <option value=""></option>  
                      <c:forEach items="${lista_utenti}" var="user">
                           <option value="${user.id }">${user.nominativo}</option> 
                     </c:forEach>
                  </select>
                  </div>
       </div>
      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_corso_user" name="id_corso_user">
      <a class="btn btn-primary" onclick="associaDissociaUtentiCorso('associa')" >Associa</a>
		
      </div>
    </div>
  </div>

</div>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
 
 
function associaUtentiModal(id_corso){
	
	$('#id_corso_user').val(id_corso);
	
	var table = $('#tabPartecipanti').DataTable();
	
	var partecipanti = table.rows().data();
	
	  var options = utenti_options;	  
	  var opt=[];
		opt.push("");
 	for(var i = 0; i<partecipanti.length;i++){
 		 for(var  j=0; j<options.length;j++){
 			var str=options[j].value; 	
 			if(partecipanti[i][0] == str){
 				options[j].selected = true;
 			}
 			opt.push(options[j]);
 		 }
	} 
	   

	$('#utenti').html(opt);

	$("#utenti").change();  
	$('#myModalAssociaUtenti').modal();
}
 
 var columsDatatables = [];

 $("#tabPartecipanti").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabPartecipanti thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
 	    	//}

     	} );
     
     

 } );
   
 
 var utenti_options;
    $(document).ready(function() {
    	
    	utenti_options = $('#utenti option').clone();
    	
    	$('.select2').select2();
    	
    	  table = $('#tabPartecipanti').DataTable({
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
  		    	  
  		    	  { responsivePriority: 1, targets: 1 },
  		    	  
  		    	  
  		               ], 	        
  	  	      buttons: [   
  	  	          {
  	  	            extend: 'colvis',
  	  	            text: 'Nascondi Colonne'  	                   
  	 			  } ]
  		               
  		    });
  		
  		table.buttons().container().appendTo( '#tabPartecipanti_wrapper .col-sm-6:eq(1)');
  	 	    $('.inputsearchtable').on('click', function(e){
  	 	       e.stopPropagation();    
  	 	    });

  	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
  	      table
  	          .column( colIdx )
  	          .search( this.value )
  	          .draw();
  	  } );
  	} );  
  	
  	
  	
  		table.columns.adjust().draw();
  		

  	$('#tabPartecipanti').on( 'page.dt', function () {
  		$('.customTooltip').tooltipster({
  	        theme: 'tooltipster-light'
  	    });
  		
  		$('.removeDefault').each(function() {
  		   $(this).removeClass('btn-default');
  		})


  	});
     	

	});


  </script>