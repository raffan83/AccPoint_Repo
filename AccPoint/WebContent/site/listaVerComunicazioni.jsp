<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Comunicazioni
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Interventi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">


<div class="row">
<div class="col-sm-12">

 <table id="tabComunicazioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Tipo Comunicazione</th>
<th>Utente</th>
<th>Data</th>
<th>Nome Comunicazione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_comunicazioni }" var="comunicazione" varStatus="loop">
	<tr id="row_${loop.index}" >
	<td>${comunicazione.id }</td>		
	<td>
	<c:choose>
		<c:when test="${comunicazione.tipoComunicazione == 'P'}">
		Preventiva		
	</c:when>
	<c:when test="${comunicazione.tipoComunicazione == 'S'}">
		Straordinaria		
	</c:when>
	<c:otherwise>
		Esito Verifica
	</c:otherwise>
	</c:choose>
	</td>	
	<td>${comunicazione.utente.nominativo }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${comunicazione.dataComunicazione }" /></td>
	<td>${comunicazione.filename.substring(0, comunicazione.filename.lastIndexOf('.')) }</td>
	<td>
	<a class="btn btn-info" title="Click per aprire il dettaglio degli sturmenti" onClick="dettaglioVerStrumenti('${comunicazione.idsStrumenti}')"><i class="fa fa-search"></i></a>
	<a class="btn btn-danger" title="Click per scaricare il file" onClick="callAction('gestioneVerComunicazionePreventiva.do?action=download&filename=${comunicazione.filename}')"><i class="fa fa-arrow-down"></i></a>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>

</div>
</section>




  <div id="myModalDettaglio" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Strumenti</h4>
      </div>
       <div class="modal-body" id="body_dettaglio">       
      
      	</div>
      <div class="modal-footer">
   
   
      </div>
    </div>
  </div>

</div>


</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">

function dettaglioVerStrumenti(ids){

	 
	  dataString = "action=dettaglio_strumenti&ids="+ids;

	   exploreModal("gestioneVerComunicazionePreventiva.do",dataString,"#body_dettaglio",function(datab,textStatusb){});
	   $('#myModalDettaglio').modal();
	   
	   
		 $('#myModalDettaglio').on('shown.bs.modal', function (){
			t = $('#tabStrumenti').DataTable();
		    	t.columns().eq( 0 ).each( function ( colIdx ) {
				 $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
					 t
				      .column( colIdx )
				      .search( this.value )
				      .draw();
				 } );
				 } );    
			 t.columns.adjust().draw(); 
	});
	 
}


$('#myModalDettaglio').on('hidden.bs.modal', function (){
	$(document.body).css('padding-right', '0px');
});

var columsDatatables = [];

$("#tabComunicazioni").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabComunicazioni thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabComunicazioni thead th').eq( $(this).index() ).text();
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );

var commessa_options;
$(document).ready(function() {
 
	$('.select2').select2();
	$('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
     $('.dropdown-toggle').dropdown();
     
     commessa_options = $('#commessa option').clone();

     table = $('#tabComunicazioni').DataTable({
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

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 5 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabComunicazioni_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabComunicazioni').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
});


  </script>
  
</jsp:attribute> 
</t:layout>

