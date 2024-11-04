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
        Lista Librerie Elettrici
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
	 Lista Librerie Elettrici
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<a class="btn btn-primary pull-right" onClick="modalNuovaLibreriaElettrici()"><i class="fa fa-plus"></i> Nuova Libreria Elettrici</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabLibrerie" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th style="max-width:40px">ID</th>

<th>Marca Strumento</th>
<th>Modello Strumento</th>
<th>Campione di Riferimento</th>

<th>Note</th>
<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_librerie }" var="libreria" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${libreria.id }</td>	
	
	<td>${libreria.marca_strumento }</td>
	
	<td>${libreria.modello_strumento }</td>
	<td>${libreria.campione_riferimento}</td>
	<td>${libreria.note }</td>

	<td>
<a class="btn btn-info customTooltip" href="gestioneLibrerieElettrici.do?action=download_file&id_libreria=${libreria.id}" title="Click per scaricare il file di configuazione"><i class="fa fa-arrow-down"></i></a>
	 <a class="btn btn-warning customTooltip" onClicK="modificaLibrerieElettrici('${libreria.id}', '${libreria.marca_strumento }', '${libreria.modello_strumento }', '${libreria.campione_riferimento }','${utl:escapeJS(libreria.note) }', '${libreria.filename_config }')" title="Click per modificare la libreria elettrici"><i class="fa fa-edit"></i></a>
	  <a class="btn btn-danger customTooltip" onClicK="modalEliminaLibrerieElettrici('${libreria.id }')" title="Click per eliminare la libreria elettrici"><i class="fa fa-trash"></i></a>
	 
	  
	 
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

  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'elemento selezionato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_libreria_elimina">
      <a class="btn btn-primary" onclick="eliminaLibrerieElettrici($('#id_libreria_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="nuovaLibreriaElettriciForm" name="nuovaLibreriaElettriciForm">
<div id="myModalNuovaLibreriaElettrici" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Libreria Elettrici</h4>
      </div>
       <div class="modal-body">
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Marca strumento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="marca" name="marca" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello Strumento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Campione di Riferimento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="campione_riferimento" name="campione_riferimento" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>

       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea id="note" name="note" class="form-control" rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
 
       
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>File di Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input   id="fileupload_config" name="fileupload_config" type="file" required></span><label id="label_fileupload"></label>
       	</div>       	
       </div>
       
       </div>
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaLibreriaElettriciForm" name="modificaLibreriaElettriciForm">
<div id="myModalModificaLibreriaElettrici" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Libreria Elettrici</h4>
      </div>
           <div class="modal-body">
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Marca strumento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="marca_mod" name="marca_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello Strumento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Campione di Riferimento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="campione_riferimento_mod" name="campione_riferimento_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>

       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea id="note_mod" name="note_mod" class="form-control" rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>File di Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input   id="fileupload_config_mod" name="fileupload_config_mod" type="file" ></span><label id="label_fileupload_mod"> </label>
       	</div>       	
       </div>
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_libreria" name="id_libreria">
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

<style>
      .img-container {
            max-width: 200px;
            max-height: 200px;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: auto;
        }
        
        .table th input {
    min-width: 45px !important;
}

</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovaLibreriaElettrici(){
	
	$('#myModalNuovaLibreriaElettrici').modal();
	
}


function modificaLibrerieElettrici(id_libreria, marca, modello, campione_riferimento,note, filename_config){
	
	$('#id_libreria').val(id_libreria);
	$('#marca_mod').val(marca);
	$('#modello_mod').val(modello);
	$('#campione_riferimento_mod').val(campione_riferimento);
	
	$('#note_mod').val(note);
	$('#label_fileupload_mod').html(filename_config);
	

	$('#myModalModificaLibreriaElettrici').modal();
}



function modalEliminaLibrerieElettrici(id_libreria){
	
	
	$('#id_libreria_elimina').val(id_libreria);
	$('#myModalYesOrNo').modal()
	
}


$('#fileupload_config').change(function(){
	$('#label_fileupload').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_config_mod').change(function(){
	$('#label_fileupload_mod').html($(this).val().split("\\")[2]);
	 
 });
 


function eliminaLibrerieElettrici(){
	
	dataObj = {};
	
	dataObj.id_libreria_elimina = $('#id_libreria_elimina').val();
	
	callAjax(dataObj, "gestioneLibrerieElettrici.do?action=elimina_libreria");
}


var columsDatatables = [];

 $("#tabLibrerie").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabLibrerie thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabLibrerie thead th').eq( $(this).index() ).text();

		  
	 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
	 		
    	  
    	} );
    
    

} );
 


$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2()
     
  
 	     table = $('#tabLibrerie').DataTable({
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
 			    	  
 			    	  { responsivePriority: 1, targets: 5 },
 			    	  
 			    	  
 			               ], 	        
 		  	      buttons: [   
 		  	          {
 		  	            extend: 'colvis',
 		  	            text: 'Nascondi Colonne'  	                   
 		 			  } ]
 			               
 			    });
 		
  
  		
     
		table.buttons().container().appendTo( '#tabLibrerie_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabLibrerie').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaLibreriaElettriciForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaLibreriaElettriciForm','gestioneLibrerieElettrici.do?action=modifica_libreria');
});
 

 
 $('#nuovaLibreriaElettriciForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovaLibreriaElettriciForm','gestioneLibrerieElettrici.do?action=nuova_libreria');
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

