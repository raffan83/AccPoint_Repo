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
        Lista Sistemi
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Sistemi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoSistema()"><i class="fa fa-plus"></i> Nuovo Sistema</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabTipiManutenzione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_sistemi }" var="sistema" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${sistema.id }</td>	
	<td>${sistema.descrizione }</td>

	<td>

	<a class="btn btn-primary customTooltip" onClick="$('#myModalNuovaAttivita').modal()" title="Inserisci attività di manutenzione"><i class="fa fa-plus"></i></a>
	<a class="btn btn-warning customTooltip" onClicK="modificaSistema('${sistema.id}', '${sistema.descrizione }')" title="Click per modificare il sistema"><i class="fa fa-edit"></i></a>
	  <a class="btn btn-danger customTooltip" onClicK="modalEliminaSistema('${sistema.id }')" title="Click per eliminare il sistema"><i class="fa fa-trash"></i></a>
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


</section>

  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il sistema?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_sistema_elimina">
      <a class="btn btn-primary" onclick="eliminaSistema($('#id_sistema_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="nuovoSistemaForm" name="nuovoSistemaForm">
<div id="myModalNuovoSistema" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Sistema</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
<!--             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Aggiungi Attività</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <a class="btn btn-primary" id="button_aggiungi_attivita" onClick="aggiungiAttivita()"><i class="fa fa-plus"></i></a>
       			
       	</div>       	
       </div><br>
        <div class="row">
       
       	<div class="col-sm-12">
         <div id="attivitaContainer"></div>
       </div>
       </div> -->
       </div>
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaSistemaForm" name="modificaSistemaForm">
<div id="myModalModificaSistema" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Sistema</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div>
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_sistema" name="id_sistema">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>





<form id="nuovaAttivitaForm" name="nuovaAttivitaForm">
<div id="myModalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attività di Manutenzione</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione Manutenzione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_manutenzione" name="descrizione_manutenzione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Periodicità (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="periodicita" name="periodicita" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-12">
       		<label>Aggiungi Intervento</label> <a class="btn btn-primary" onClick="aggiungiIntervento()"><i class="fa fa-plus"></i></a>
       	</div>
       	</div><br>
      <div class="row">
       
       	<div class="col-sm-12"> 	     
       	     <div id="interventiContainer" >
       	     <select id="hidden_tipi_manutenzione">
       	     <c:forEach items="${lista_tipi_manutenzione }" var="tipo">
       	     <option value="${tipo.id }">${tipo.descrizione }</option>
       	     </c:forEach>
       	     </select>
       	     
       	     
       	     </div>
       	      	
    
       
       </div>
  		 </div>
  		 </div>
      <div class="modal-footer">
		
		<input type="hidden" id="id_sistema" name="id_sistema">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




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


function modalNuovoSistema(){
	
	$('#myModalNuovoSistema').modal();
	
}


function modificaSistema(id_sistema, descrizione){
	
	$('#id_sistema').val(id_sistema);
	$('#descrizione_mod').val(descrizione);

	$('#myModalModificaSistema').modal();
}



function modalEliminaSistema(id_sistema){
	
	
	$('#id_sistema_elimina').val(id_sistema);
	$('#myModalYesOrNo').modal()
	
}

//var tipi_man_options= $('#hidden_tipi_manutenzione').options.clone()

var index = 0;

/*  function aggiungiIntervento() {	

    var interventiHtml = '<ul class="list-group list-group-unbordered"><li id="list_'+index+'" class="list-group-item"><div class="row"><div class="col-xs-12"> <div class="col-xs-3">'
    	interventiHtml += '<label>Tipo Manutenzione:</label>';
    	interventiHtml += '<select id="tipo_man_'+index+'" name="tipo_man_'+index+'" class="form-control inputIntervento inputInterventoSelect"></select></div>';
    interventiHtml += '<div class="col-xs-3"><label>Descrizione Intervento:</label>';
    interventiHtml += '<input type="text" class="form-control inputIntervento" id="descrizione_intervento_'+index+'" name="descrizione_intervento_'+index+'">';
    interventiHtml += '</div>';
    interventiHtml += '<div class="col-xs-2"><label>Esito:</label><input type="text" class="form-control inputIntervento" id="esito_'+index+'" name="esito_'+index+'"></div>';
    interventiHtml += '<div class="col-xs-3"><label>Data:</label><div class="input-group date datepicker inputIntervento" id=datepicker_data_inizio><input type="text" class="form-control input-small" id="data_intervento_'+index+'" name="data_intervento_'+index+'" ><span class="input-group-addon"><span class="fa fa-calendar" ></span></span></div></div>';
    
    interventiHtml += '<a class="btn btn-danger customTooltip" onclick="removeIntervento('+index+')" title="Rimuovi intervento"><i class="fa fa-minus"></i></a></li></ul>'
    // Aggiungi l'intervento al contenitore specificato
    //container.append(interventiHtml);
     $("#interventiContainer").append(interventiHtml);
     // $("#tipo_man").append($('#hidden_tipi_manutenzione option').clone());
      
      $('.inputInterventoSelect').html($('#hidden_tipi_manutenzione option').clone());
      index++;
   
} */ 
 
 function aggiungiIntervento() {
	    var interventiHtml = '<ul class="list-group list-group-unbordered"><li id="list_' + index + '" class="list-group-item"><div class="row"><div class="col-xs-12"> <div class="col-xs-3">'
	    interventiHtml += '<label>Tipo Manutenzione:</label>';
	    interventiHtml += '<select name="int_tipo_man_' + index + '" class="form-control inputIntervento inputInterventoSelect"></select></div>';
	    interventiHtml += '<div class="col-xs-3"><label>Descrizione Intervento:</label>';
	    interventiHtml += '<input type="text" class="form-control inputIntervento" name="descrizione_intervento_' + index + '"></div>';
	    interventiHtml += '<div class="col-xs-2"><label>Esito:</label><input type="text" class="form-control inputIntervento" name="esito_' + index + '"></div>';
	    interventiHtml += '<div class="col-xs-3"><label>Data:</label><div class="input-group date datepicker inputIntervento" id="datepicker_data_inizio"><input type="text" class="form-control input-small" name="data_intervento_' + index + '"><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div></div>';
	    interventiHtml += '<a class="btn btn-danger customTooltip" onclick="removeIntervento(' + index + ')" title="Rimuovi intervento"><i class="fa fa-minus"></i></a></li></ul>';

	    // Aggiungi l'intervento al contenitore specificato
	    $("#interventiContainer").append(interventiHtml);

	    // Aggiungi opzioni di tipo manutenzione al campo select
	    $('select[name="int_tipo_man_' + index + '"]').html($('#hidden_tipi_manutenzione').html());

	    index++;
	}




function removeIntervento(index){
	
	$('#list_'+index).remove()
	
}

function eliminaSistema(){
	
	dataObj = {};
	
	dataObj.id_sistema_elimina = $('#id_sistema_elimina').val();
	
	callAjax(dataObj, "gestioneSistemiManutenzione.do?action=elimina_sistema");
}


var columsDatatables = [];

$("#tabTipiManutenzione").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabTipiManutenzione thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabTipiManutenzione thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('#hidden_tipi_manutenzione').hide()
     
  

     table = $('#tabTipiManutenzione').DataTable({
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
		
		table.buttons().container().appendTo( '#tabTipiManutenzione_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabTipiManutenzione').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaSistemaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaSistemaForm','gestioneSistemiManutenzione.do?action=modifica_sistema');
});
 

 
 $('#nuovoSistemaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovoSistemaForm','gestioneSistemiManutenzione.do?action=nuovo_sistema');
	
});
 
 
 $('#nuovaAttivitaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 var jsonArrayParam = [];

	 callAjaxForm('#nuovaAttivitaForm','gestioneSistemiManutenzione.do?action=nuova_manutenzione');
	
});


 
  </script>
  
</jsp:attribute> 
</t:layout>


