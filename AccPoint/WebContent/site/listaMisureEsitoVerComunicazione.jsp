<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="creaEsito()"><i class="fa fa-plus"></i> Crea Esito</a>
</div>
</div><br>
<div class="row">
<div class="col-xs-12">
<table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  
 <thead><tr class="active">
  	 <th></th>
  <th style="max-width:65px" class="text-center"></th>
  <th>ID</th>   
 <th>Strumento</th>
 <th>Data Verificazione</th>
 <th>Tecnico Verificatore</th>	
 <th>Data Scadenza</th>
 <th>Data Riparazione</th>
 <th>Numero Rapporto</th>
 <th>Numero Attestato</th>
 <td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaMisure}" var="misura">
 
 	<tr role="row" id="${misura.id}">
 	<td></td>
 	<td class="select-checkbox"></td>
<td>${misura.id}</td>
<td>${misura.verStrumento.denominazione}</td>
<td> <fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataVerificazione}" />	</td>
<td>${misura.tecnicoVerificatore.nominativo }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataScadenza}" /></td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataRiparazione}" /></td>
<td>${misura.numeroRapporto }</td>
<td>${misura.numeroAttestato }</td>
<td>
<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della misura" onClick="callAction('gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-search"></i></a>

</td>
		
		
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  

</div>
</div>

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>

<script type="text/javascript">

var columsDatatables = [];

$("#tabPM").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabPM thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
        var title = $('#tabPM thead th').eq( $(this).index() ).text();
       // $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
       

  	  if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
	    	else if($(this).index() ==1){
	    	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
	      }
	    	 $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
       
    } );
    
    

} );



function creaEsito(){
	
	 var table = $("#tabPM").DataTable();
		 
		 var str = "";
		 
		 
		 $('#tabPM tbody tr').each(function(){
			 if($(this).hasClass("selected")){
				 var td = $(this).find('td').eq(2);
				 str = str+td[0].innerText+";"
			 }
			
		 });
		 
		if(str == ''){
			$('#myModalErrorContent').html("Nessuna misura selezionata!")
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#myModalError').modal('show');		
		}else{
			creaEsitoComunicazione(str);
				
		}
	}

$(document).ready(function() {
	
	table = $('#tabPM').DataTable({
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
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      order: [[ 2, "desc" ]],
	      select: {		
	    	  
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},   
	      columnDefs: [
	    	  { className: "select-checkbox", targets: 1,  orderable: false },
					   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 3, targets: 2 },
	                   { responsivePriority: 4, targets: 3 },
	                   { responsivePriority: 2, targets: 10 }
	                  /*  { orderable: false, targets: 6 },
	                   { width: "50px", targets: 0 },
	                   { width: "70px", targets: 1 },
	                   { width: "50px", targets: 4 }, */
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
	                         
	                          ],
	                          "rowCallback": function( row, data, index ) {
	                        	   
	                        	      $('td:eq(1)', row).addClass("centered");
	                        	      $('td:eq(4)', row).addClass("centered");
	                        	  }
	    	
	      
	    });
	table.buttons().container()
    .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
 	   
   	    
   	    
// DataTable
	table = $('#tabPM').DataTable();
// Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
    $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
        table
            .column( colIdx )
            .search( this.value )
            .draw();
    } );
} ); 

table.columns.adjust().draw();
$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );

	
	
	
	$('#checkAll').on('ifChecked', function (ev) {

		$("#checkAll").prop('checked', true);
		table.rows().deselect();
		var allData = table.rows({filter: 'applied'});
		table.rows().deselect();
		i = 0;
		table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
		    //if(i	<maxSelect){
				 this.select();
		   /*  }else{
		    		tableLoop.exit;
		    }
		    i++; */
		    
		} );

  	});
	$('#checkAll').on('ifUnchecked', function (ev) {

		
			$("#checkAll").prop('checked', false);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();

	  	});
	
	
});
</script>


