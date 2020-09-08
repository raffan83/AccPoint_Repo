<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Docenti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	 Lista Docenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoDocente()"><i class="fa fa-plus"></i> Nuovo Docente</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForDocenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Formatore</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_docenti }" var="docente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${docente.id }</td>	
	<td>${docente.nome }</td>
	<td>${docente.cognome }</td>
	<td>
	<c:if test="${docente.formatore==1 }">
	SI
	</c:if>
	<c:if test="${docente.formatore!=1 }">
	NO
	</c:if>
	</td>	
	<td>
	<c:if test="${docente.cv !=null && docente.cv != '' }">
	<a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_curriculum&id_docente=${utl:encryptData(docente.id)}" title="Click per scaricare il cv"><i class="fa fa-file-pdf-o"></i></a>
	</c:if>
	<a class="btn btn-warning" onClicK="modificaDocenteModal('${docente.id}','${docente.nome }','${docente.cognome.replace('\'','&prime;')}','${docente.formatore }','${docente.cv }')" title="Click per modificare il docente"><i class="fa fa-edit"></i></a> 
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



<form id="nuovoDocenteForm" name="nuovoDocenteForm">
<div id="myModalnuovoDocente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Docente</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome" name="nome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome" name="cognome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Formatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_formatore" name="check_formatore" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Curriculum</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload" name="fileupload" type="file" ></span><label id="label_file"></label></div>
       	</div>		
            	
       
       
       
       
       </div>
  		 
      <div class="modal-footer">
		<input type="hidden" id="formatore" name="formatore">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDocenteForm" name="nuovoDocenteForm">
<div id="myModalModificaDocente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Docente</h4>
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
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome_mod" name="cognome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Formatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_formatore_mod" name="check_formatore_mod" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Curriculum</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label></div>
       	</div>		
            	
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_docente" name="id_docente">
		<input type="hidden" id="formatore_mod" name="formatore_mod">
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

<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovoDocente(){
	
	$('#myModalnuovoDocente').modal();
	
}



function modificaDocenteModal(id_docente, nome, cognome, formatore, cv){
	
	$('#id_docente').val(id_docente);
	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	if(formatore =='1'){	

		$('#check_formatore_mod').iCheck('check');
		$('#formatore_mod').val(1); 
	}else{
		$('#check_formatore_mod').iCheck('uncheck');
		$('#formatore_mod').val(0);
	}
	
	
	$('#label_file_mod').html(cv);

	$('#myModalModificaDocente').modal();
}

$('#check_formatore').on('ifClicked',function(e){
	if($('#check_formatore').is( ':checked' )){
		$('#check_formatore').iCheck('uncheck');
		$('#formatore').val(0); 
	}else{
		$('#check_formatore').iCheck('check');
		$('#formatore').val(1); 
	}
});
	 

$('#check_formatore_mod').on('ifClicked',function(e){
	if($('#check_formatore_mod').is( ':checked' )){
		$('#check_formatore_mod').iCheck('uncheck');
		$('#formatore_mod').val(0); 
	}else{
		$('#check_formatore_mod').iCheck('check');
		$('#formatore_mod').val(1); 
	}
});

var columsDatatables = [];

$("#tabForDocenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForDocenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForDocenti thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     

     table = $('#tabForDocenti').DataTable({
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
		
		table.buttons().container().appendTo( '#tabForDocenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabForDocenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaDocenteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForDocente();
});
 

 
 $('#nuovoDocenteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForDocente();
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

