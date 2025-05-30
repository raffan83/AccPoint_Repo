<%@page import="java.util.ArrayList"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="it.portaleSTI.DTO.AMOperatoreDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
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
        Lista Immagini Campioni
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
	 Lista Immagini Campioni A.M. Engineering
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">



<div class="col-xs-12">
<button class="btn btn-primary pull-right" onClick="$('#modalNuovaImmagine').modal()" style="margin-right:5px"><i class="fa fa-plus"></i> Carica Nuova Immagine</button> 
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAMImmagini" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Descrizione</th>
<th>Nome file</th>
<th>Anteprima</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_immagini }" var="immagine" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${immagine.id }</td>
	<td>${immagine.descrizione }</td>
	<td>${immagine.nome_file }</td>		
	<td style="text-align:center"><c:if test="${immagine.nome_file!=null }">
	<img src="amGestioneInterventi.do?action=immagine&id_immagine=${immagine.id }" alt="Descrizione Immagine" style="max-height: 150px; height: auto; width: auto;">

	</c:if></td>
<td>
	<a class="btn btn-warning" title="Click per modificare l'immagine" onClick="modificaImmagine('${immagine.id}','${immagine.descrizione}','${immagine.nome_file}')"><i class="fa fa-edit"></i></a>
	<a class="btn btn-danger customTooltip" title="Click per eliminare l'immagine" onClick="modalYesOrNo('${immagine.id}')"><i class="fa fa-trash"></i></a>
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
      	Sei sicuro di voler eliminare l'immagine?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_immagine_elimina">
      <a class="btn btn-primary" onclick="eliminaImmagine($('#id_immagine_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


<form id="nuovaImmagineForm">

  <div id="modalNuovaImmagine" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Carica Nuova Immagine</h4>
      </div>
       <div class="modal-body">


<div class="row">
	<div class="col-sm-3">
		<label>Descrizione</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="descrizione" name="descrizione" style="width:100%" >
	</div>
</div><br>

	
	<div class="row">
	
		   <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagine...</span>
				<input accept=".jpg,.png"  id="fileupload" name="fileupload" type="file" REQUIRED >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_immagine"></label>
		 </div>
	</div><br>
      
       
  		 </div>
      <div class="modal-footer">

        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


<form id="modificaImmagineForm">

  <div id="modalModificaImmagine" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Campione</h4>
      </div>
      <div class="modal-body">

	

<div class="row">
	<div class="col-sm-3">
		<label>Descrizione</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="descrizione_mod" name="descrizione_mod" style="width:100%" >
	</div>
</div><br>

	
	<div class="row">
	
		   <div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagine...</span>
				<input accept=".jpg,.png"  id="fileupload_mod" name="fileupload_mod" type="file" >
		       
		   	 </span>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_immagine_mod"></label>
		 </div>
	</div><br>
      

</div>

      <div class="modal-footer">
		<input type="hidden" id="id_immagine" name="id_immagine">
        <button type="submit" class="btn btn-danger"  >Salva</button>
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
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">



function modalYesOrNo(id_immagine){

	 
		$('#id_immagine_elimina').val(id_immagine)
		 
		 
		 $('#myModalYesOrNo').modal();
	
}

function eliminaImmagine(id_immagine){
	
	dataObj = {};
	dataObj.id_immagine = id_immagine;
	
	callAjax(dataObj, "amGestioneInterventi.do?action=elimina_immagine")
	
}


$('#fileupload').change(function(){
	
	
	$('#label_immagine').html($(this).val().split("\\")[2]);
});


$('#fileupload_mod').change(function(){


$('#label_immagine_mod').html($(this).val().split("\\")[2]);
});


var columsDatatables = [];

$("#tabAMImmagini").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAMImmagini thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAMImmagini thead th').eq( $(this).index() ).text();
    	    	  
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    		
    	} );
    
} );




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


function modificaImmagine(id_immagine,descrizone, nome_file){

			
			$('#id_immagine').val(id_immagine);
			$('#descrizione_mod').val(descrizone);
			$('#label_immagine_mod').html(nome_file);


			$('#modalModificaImmagine').modal()

}


$(document).ready(function() {
 
	$(".select2").select2();

	

	$('#sede_mod').select2();
	$('#commessa_mod').select2();
	$('#tecnico_verificatore_mod').select2();
	$('#luogo_mod').select2();
	$('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	//$('.datepicker').datepicker('setDate', new Date());
    $('.dropdown-toggle').dropdown();
     



     table = $('#tabAMImmagini').DataTable({
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
		    	  
		    	  { responsivePriority: 0, targets: 2 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAMImmagini_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAMImmagini').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
});


 
 
 $('#modificaImmagineForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#modificaImmagineForm','amGestioneInterventi.do?action=modifica_immagine');
	 
 });
 
 $('#nuovaImmagineForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#nuovaImmagineForm','amGestioneInterventi.do?action=nuova_immagine');
	 
 });
 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

