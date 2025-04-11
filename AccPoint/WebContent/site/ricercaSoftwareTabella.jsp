<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<br><br>
<div class="row">
<div class="col-xs-2">
<label>Obsoleto:</label>
 <select id="filterObsoleto" class="form-control">
                <option value="">Tutti</option>
                <option value="SI">SI</option>
                <option value="NO">NO</option>
            </select>
            
</div>

 <div class="col-md-3">
        <label for="filterDataAcquisto" class="form-label">Data Acquisto:</label>
        <input type="text" id="filterDataAcquisto" class="form-control" placeholder="Seleziona intervallo">
    </div>
    <div class="col-md-3">
        <label for="filterDataScadenza" class="form-label">Data Scadenza:</label>
        <input type="text" id="filterDataScadenza" class="form-control" placeholder="Seleziona intervallo">
    </div>
     <div class="col-md-3">
     <label>Tipo Licenza:</label>
     <select id="filterTipoLicenza" class="form-control">
          <option value="">Tutti</option>
                <option value="COMMERCIALE">COMMERCIALE</option>
                <option value="NON COMMERCIALE">N0N COMMERCIALE</option>
                <option value="SVILUPPATO">SVILUPPATO</option>
            </select>
            </div>
            
                 <div class="col-md-1">
    <button class="btn btn-primary" id="reset_button" onclick="resetFiltri()" style="margin-top:25px">Reset filtri</button>
</div>
</div>


<br><br>
 <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Produttore</th>

 <th>Tipo licenza</th> 

<th>Versione</th>
<th>Contratto</th>
<th>Data scadenza contratto</th>
<th>Data acquisto</th>
<th>Data scadenza software</th> 
 <th>Obsoleto</th>
 <th>Utente</th>
 <th>Device</th>
 <th>Company</th>
 
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_software }" var="software" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${software.id }</td>	
	<td>${software.nome }</td>
	<td>${software.produttore }</td>
	<td>${software.tipo_licenza.descrizione }</td>
	<td>${software.versione }</td>
	<td>
	<c:if test="${software.contratto !=null }">
	ID: ${software.contratto.id } - ${software.contratto.fornitore}
	</c:if>
	 </td>
	 <td>
	 <c:if test="${software.contratto !=null }">
	<fmt:formatDate pattern="dd/MM/yyyy" value="${software.contratto.data_scadenza }"></fmt:formatDate>
	 </c:if>
	 </td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${software.data_acquisto }"></fmt:formatDate></td> 
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${software.data_scadenza }"></fmt:formatDate></td>
 	<td>
 	<c:if test="${software.obsoleto == 'S' }">
 	SI
 	</c:if>
 	<c:if test="${software.obsoleto == 'N' }">
 	NO
 	</c:if></td> 
 	<td>${software.utente }</td>
 	<td>
 	<c:if test="${software.device!=null && software.device.codice_interno!=null}">
 	${software.device.denominazione } - CI: ${software.device.codice_interno }
 	</c:if>
 	</td>
 	<td>${software.company }</td>
 	
	<td>

	 <a class="btn btn-warning customTooltip" onClicK="modificaSoftware('${software.id}', '${utl:escapeJS(software.nome) }','${utl:escapeJS(software.produttore) }','${utl:escapeJS(software.versione) }','${software.data_acquisto }','${software.data_scadenza }','${software.tipo_licenza.id }','${software.email_responsabile }')" title="Click per modificare il software"><i class="fa fa-edit"></i></a> 
	  <a class="btn btn-danger customTooltip"onClicK="modalYesOrNo('${software.id}')" title="Click per eliminare il software"><i class="fa fa-trash"></i></a>
	  <a class="btn btn-primary customTooltip" onClick="modalAllegati('${software.id}')" title="Click per aprire gli allegati"><i class="fa fa-archive"></i></a>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
 
 
 <form id="modificaSoftwareForm" name="modificaSoftwareForm">
<div id="myModalModificaSoftware" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Software</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_mod" name="nome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Produttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="produttore_mod" name="produttore_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
             
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo licenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_licenza_mod" name="tipo_licenza_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona tipo licenza...">
        <option value=""></option>
        <c:forEach items="${lista_tipi_licenze }" var="licenza">
        <option value="${licenza.id }">${licenza.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br> 
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto_mod" name="data_acquisto_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 

	<div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Versione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="versione_mod" name="versione_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email Referenti <small>inserire indirizzi separati da ";"</small></label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_referenti_mod" name="email_referenti_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
  		 </div>
      <div class="modal-footer">
		
		<input type="hidden" id="id_software" name="id_software">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>
 
 
 
  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      Sei sicuro di voler eliminare il software?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_software">
      <a class="btn btn-primary" onclick="eliminaSoftware($('#id_elimina_software').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


<style>






        
 /*        .table th input {
    min-width: 45px !important;
} */

</style>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">



function modificaSoftware(id_software, nome, produttore,   versione, data_acquisto, data_scadenza, tipo_licenza,email){
	
	$('#id_software').val(id_software);
	$('#nome_mod').val(nome);
	$('#produttore_mod').val(produttore);
 	$('#tipo_licenza_mod').val(tipo_licenza);
	$('#tipo_licenza_mod').change();
	if(data_acquisto!=null && data_acquisto!=''){
		$('#data_acquisto_mod').val(Date.parse(data_acquisto).toString("dd/MM/yyyy")); 	
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy")); 	
	}
	
	$('#versione_mod').val(versione);
	$('#email_referenti_mod').val(email);
	

	$('#myModalModificaSoftware').modal();
}


var columsDatatables = [];

 $("#tabSoftware").on( 'init.dt', function ( e, settings ) {

    $('#tabSoftware thead th').each( function () {


		    	if($(this).index() == 0){
	 				$(this).append( '<div><input class="inputsearchtable" id="input_search_'+$(this).index()+'" style="width:15px !important" type="text" /></div>');
	 			}

		    	else{
	 				$(this).append( '<div><input class="inputsearchtable" id="input_search_'+$(this).index()+'"  style="width:100%" type="text" /></div>');	
	 			}
    	  
    	} );
    
    

} );
 

 
 
	

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2()
     
 		console.log("log")

 	     table = $('#tabSoftware').DataTable({
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
 			      stateSave: false,	
 			           
 			      columnDefs: [
 			    	  
 			    	  { responsivePriority: 1, targets:12 },
 			    	  
 			    	  
 			               ], 	        
 			              buttons: [ {
 		  	                   extend: 'copy',
 		  	                   text: 'Copia',
 		  	                   /* exportOptions: {
 			                       modifier: {
 			                           page: 'current'
 			                       }
 			                   } */
 		  	               },{
 		  	                   extend: 'excel',
 		  	                   text: 'Esporta Excel',
 		  	                   /* exportOptions: {
 		  	                       modifier: {
 		  	                           page: 'current'
 		  	                       }
 		  	                   } */
 		  	               },
 		  	               {
 		  	                   extend: 'colvis',
 		  	                   text: 'Nascondi Colonne'
 		  	                   
 		  	               }
 		  	        
 		  	                         
 		  	          ]
 			               
 			               
 			    });
 		
 		
 	     
  
  		
     
		table.buttons().container().appendTo( '#tabSoftware_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabSoftware').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	 function initDatePicker(selector) {
	        $(selector).daterangepicker({
	            autoUpdateInput: false,
	            locale: {
	                cancelLabel: 'Cancella',
	                applyLabel: 'Applica',
	                format: 'DD/MM/YYYY'
	            }
	        });

	        // Imposta il valore selezionato
	        $(selector).on('apply.daterangepicker', function(ev, picker) {
	            $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
	            table.draw();
	        });

	        // Cancella il filtro e resetta il valore
	        $(selector).on('cancel.daterangepicker', function(ev, picker) {
	            $(this).val(''); // Svuota il campo input
	            table.draw(); // Ricarica la tabella senza filtri
	        });
	    }

	    // Inizializza i DateRangePicker per Data Acquisto e Data Scadenza
	    initDatePicker('#filterDataAcquisto');
	    initDatePicker('#filterDataScadenza');

	    // Filtro DataTables per il range delle date
	    $.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
	        var minAcq = $('#filterDataAcquisto').val() ? parseDate($('#filterDataAcquisto').val().split(' - ')[0]) : null;
	        var maxAcq = $('#filterDataAcquisto').val() ? parseDate($('#filterDataAcquisto').val().split(' - ')[1]) : null;
	        var minSca = $('#filterDataScadenza').val() ? parseDate($('#filterDataScadenza').val().split(' - ')[0]) : null;
	        var maxSca = $('#filterDataScadenza').val() ? parseDate($('#filterDataScadenza').val().split(' - ')[1]) : null;

	        var dataAcquisto = parseDate(data[7]); // Data acquisto (colonna 5)
	        var dataScadenza = parseDate(data[8]); // Data scadenza (colonna 6)

	        var dentroAcquisto = (!minAcq || (dataAcquisto && dataAcquisto >= minAcq)) &&
	                             (!maxAcq || (dataAcquisto && dataAcquisto <= maxAcq));

	        var dentroScadenza = (!minSca || (dataScadenza && dataScadenza >= minSca)) &&
	                             (!maxSca || (dataScadenza && dataScadenza <= maxSca));

	        return dentroAcquisto && dentroScadenza;
	    });

	    // Ricarica la tabella quando cambia il filtro
	    $('#filterDataAcquisto, #filterDataScadenza').on('apply.daterangepicker cancel.daterangepicker', function() {
	        table.draw();
	    });
	

	
	
});


function modalYesOrNo(id_software){
	
	
	$('#id_elimina_software').val(id_software);
	$('#myModalYesOrNo').modal();
	
}

function eliminaSoftware(id_software){
	
	var dataObj = {};
	dataObj.id_software = id_software;
	
	callAjax(dataObj, "gestioneDevice.do?action=elimina_software");
	
}



function parseDate(dateStr) {
    if (!dateStr) return null;
    var parts = dateStr.split('/');
    return new Date(parts[2], parts[1] - 1, parts[0]); // gg/MM/yyyy -> Date
}

$('#filterObsoleto').on('change', function() {
	$("#input_search_9").val(this.value);
    table.column(9).search(this.value).draw();
});
 
$('#filterTipoLicenza').on('change', function() {
	$("#input_search_3").val(this.value);
    table.column(3).search(this.value).draw();
});


$('#filtroUtenti').on('change', function () {
	var valore_option = $(this).val();
    var valoreFiltro = $("#filtroUtenti option:selected").text()
    $("#input_search_10").val($("#filtroUtenti option:selected").text());
    if (valore_option === "0") {
        // Filtra SOLO le celle vuote (regex per valori vuoti)
        table.column(10) // La colonna "Utente" è la numero 8 (indice base 0)
             .search('^$', true, false)
             .draw();
    } else if(valore_option === "0_0"){
    	 table.column(10)
         .search("")
         .draw();
    }
    else
    {
        // Filtra normalmente per il valore selezionato
        table.column(10)
             .search(valoreFiltro)
             .draw();
    }
});

$('#modificaSoftwareForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaSoftwareForm','gestioneDevice.do?action=modifica_software');
});

function resetFiltri(){
	
	$('#filterDataAcquisto').val("");
	$('#filterDataScadenza').val("");
	$('#filterTipoLicenza').val("");
	$('#filtroUtenti').val("");
	$('#filterObsoleto').val("");
	table.columns()
    .search("")
    .draw();
	
	 $(".inputsearchtable").val("");/* 
	 $("#input_search_7").val("");
	 $("#input_search_3").val(""); */
}
  </script>
  



