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
        Lista Partecipanti
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
	 Lista Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<a class="btn btn-primary pull-right" onClick="modalNuovoPartecipante()"><i class="fa fa-plus"></i> Nuovo Partecipante</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForPartecipante" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Data di nascita</th>
<th>Azienda</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_partecipanti }" var="partecipante" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${partecipante.id }</td>	
	<td>${partecipante.nome }</td>
	<td>${partecipante.cognome }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${partecipante.data_nascita}" /></td>
	<td>${partecipante.azienda }</td>	
	<td>
	
	<a class="btn btn-info" title="Click per aprire il dettaglio" onClick="dettaglioPartecipante('${utl:encryptData(partecipante.id)}')"><i class="fa fa-search"></i></a>
	<a class="btn btn-warning" onClicK="modificaPartecipanteModal('${partecipante.id}','${partecipante.nome }','${partecipante.cognome.replace('\'','&prime;')}','${partecipante.data_nascita }','${partecipante.azienda }')" title="Click per modificare il partecipante"><i class="fa fa-edit"></i></a> 
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



 <form id="nuovoPartecipanteForm" name="nuovoPartecipanteForm">  
<div id="modalNuovoPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Partecipante</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome" name="nome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome" name="cognome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita" name="data_nascita" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="azienda" name="azienda" class="form-control" style="width:100%" required>
        </div>      
       </div>

      	
      	</div>
      <div class="modal-footer">
      
      <a class="btn btn-primary" onclick="nuovoForPartecipante()" >Salva</a>
		
      </div>
    </div>
  </div>

</div>
</form>



 <form id="modificaPartecipanteForm" name="modificaPartecipanteForm">  
<div id="modalModificaPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Partecipante</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome_mod" name="nome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome_mod" name="cognome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita_mod" name="data_nascita_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="azienda_mod" name="azienda_mod" class="form-control" style="width:100%" required>
        </div>      
       </div>

      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_partecipante" name="id_partecipante">
      <a class="btn btn-primary" onclick="modificaForPartecipante()" >Salva</a>
		
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
      	Sei sicuro di voler eliminare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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


function modalNuovoPartecipante(){
	
	$('#modalNuovoPartecipante').modal();
	
}

function dettaglioPartecipante(id_partecipante){
	
	callAction('gestioneFormazione.do?action=dettaglio_partecipante&id_partecipante='+id_partecipante,null,true);
}


function modificaPartecipanteModal(id_partecipante, nome, cognome, data_nascita, azienda){
	
	$('#id_partecipante').val(id_partecipante);
	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	$('#data_nascita_mod').val(Date.parse(data_nascita).toString("dd/MM/yyyy"));
	$('#azienda_mod').val(azienda);

	$('#modalModificaPartecipante').modal();
}

	 



var columsDatatables = [];

$("#tabForPartecipante").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForPartecipante thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForPartecipante thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );




$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabForPartecipante').DataTable({
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
		
		table.buttons().container().appendTo( '#tabForPartecipante_wrapper .col-sm-6:eq(1)');
		
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
		

	$('#tabForPartecipante').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		});


	});
	
	
	
	

	
	
});


$('#modificaPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForPartecipante();
});
 

 
 $('#nuovoPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForPartecipante();
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>
