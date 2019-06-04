<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\r\n"); %>
<% pageContext.setAttribute("newLineChar2", "\n"); %>
 <br> 
<div class="row">
<div class="col-xs-12">
<table id="tabSegreteria" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Azienda</th>
<th>Località</th>
<th>Telefono</th>
<th>Referente</th>
<th>Mail</th>
<th>Note</th>
<th>Offerta Ricevuta</th>	
<th>Utente</th>
<td></td>

 </tr></thead>
 
 <tbody>
 <c:forEach items="${lista_segreteria}" var="item">
  <tr>
  	<td>${item.id }</td>
 	<td>${item.azienda }</td>
 	<td>${item.localita }</td>
 	<td>${item.telefono }</td>
 	<td>${item.referente }</td>
 	<td>${item.mail }</td>
 	<td>${item.note }</td>
 	<td>${item.offerta }</td> 
 	<td>${item.utente.nominativo }</td>
 	<td style="min-width:80px">
 	<a class="btn btn-warning" onClick="modalItemSegreteria('${item.id}','${item.azienda}','${item.localita}','${item.telefono}','${item.referente }','${item.mail }','${item.offerta }',
 	'${fn:replace(fn:replace(item.note.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2,' ') }')"><i class="fa fa-edit"></i></a>
 	
 	<a class="btn btn-danger" onClick="modalEliminaItemSegreteria('${item.id}')"><i class="fa fa-trash"></i></a>
 	</td>
 </tr> 
 
 </c:forEach>

 </tbody>
</table>
</div>
</div>

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">


function modalItemSegreteria(id, azienda, localita, telefono, referente, mail, offerta, note){
	
	$('#id_segreteria').val(id);
	$('#azienda_mod').val(azienda);
	$('#localita_mod').val(localita);
	$('#telefono_mod').val(telefono);
	$('#referente_mod').val(referente);
	$('#mail_mod').val(mail);
	$('#offerta_mod').val(offerta);
	$('#note_mod').val(note)
	
	$('#myModalModificaItemSegreteria').modal();
	
}

function modalEliminaItemSegreteria(id_item){
	$('#id_item').val(id_item);
	$('#myModalYesOrNo').modal();
}

var columsDatatables = [];


$("#tabSegreteria").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }

	    $('#tabSegreteria thead th').each( function () {
	    	if(columsDatatables.length>0){
	    	  $('#inputsearchtable_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);
	    	}
	    	}); 
} ) ;



$(document).ready(function() {
	$('#cliente').val("");
	$('#cliente').change();
    $('#tabSegreteria thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){
     		columsDatatables.push({search:{search:""}});
     		}
    	  var title = $('#tabSegreteria thead th').eq( $(this).index() ).text();
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
    	
    	} );
    
table = $('#tabSegreteria').DataTable({
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
      searchable: false, 
      targets: 0,
      responsive: true,
      scrollX: false,
      stateSave: true,		     
      columnDefs: [

    	  { responsivePriority: 0, targets: 1 },
    	  { responsivePriority: 1, targets: 9 }
    	  
               ], 	        
	      buttons: [   
	          {
	            extend: 'colvis',
	            text: 'Nascondi Colonne'  	                   
			  } ]
               
    });

table.buttons().container().appendTo( '#tabSegreteria .col-sm-6:eq(1)');
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


$('#tabSegreteria').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})


});
});




</script>
