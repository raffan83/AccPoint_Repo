<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<table id="tabVerificheIntermedie" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data</th>
 <th>Etichettatura di conferma</th>
 <th>Data scadenza</th>
 <th>Stato</th>
 <th>Operatore</th>
 <th>Numero Certificato</th>
 <th>ID misura</th>
 <th>Campo Sospesi</th>
 <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_attivita}" var="attivita" varStatus="loop">
<tr>
<td>${attivita.id }</td>
<td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${attivita.data}" /></td>
<td>${attivita.etichettatura}</td>
<td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${attivita.data_scadenza}" /></td>
<td>${attivita.stato }</td>
<td>${attivita.operatore.nominativo }</td>
<td>${attivita.certificato.misura.nCertificato }</td>
<td>${attivita.certificato.misura.id }</td>
<td>${attivita.campo_sospesi }</td>
<td>
<c:if test="${attivita.certificato.misura.file_xls_ext!=null &&  attivita.certificato.misura.file_xls_ext!=''}">
	<a href="#" class="btn btn-success" title="Click per scaricare il file" onClick="scaricaPacchettoUploaded('${attivita.certificato.misura.interventoDati.nomePack}')"><i class="fa fa-file-excel-o"></i></a>
</c:if>
</td>	
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 <input type="hidden" id="verifica_selected" name="verifica_selected">
 <input type="hidden" id="data_selected" name="data_selected">
 
 <link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
   
<script>
var columsDatatables = [];

$("#tabVerificheIntermedie").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabVerificheIntermedie thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	var title = $('#tabVerificheIntermedie thead th').eq( $(this).index() ).text();
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	} );

} );

$(document).ready(function() {
	 
	 table2 = $('#tabVerificheIntermedie').DataTable({
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
		      select: true,
		      order: [[ 0, "desc" ]],
		       columnDefs: [
					   { responsivePriority: 1, targets: 0 },
		                   { responsivePriority: 2, targets: 1 },
		                   { responsivePriority: 3, targets: 9 },
		               ], 

		    	
		    });
		


 		     $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	table2 = $('#tabVerificheIntermedie').DataTable();
	//Apply the search
	table2.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', table2.column( colIdx ).header() ).on( 'keyup', function () {
		table2
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
	table2.columns.adjust().draw();
		

	$('#tabVerificheIntermedie').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	}); 
	
	
	$('#tabVerificheIntermedie tbody').on( 'click', 'tr', function () {
	     
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            $('#verifica_selected').val("");
            $('#data_selected').val("");
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $('#verifica_selected').val($(this).find("td").eq(0).text());
            $('#data_selected').val($(this).find("td").eq(1).text());
        }
        
        
    } );

 
	 }); 


 </script>
 
				