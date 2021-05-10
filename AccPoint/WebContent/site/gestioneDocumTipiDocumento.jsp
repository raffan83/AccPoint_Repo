<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
     
        Lista Tipo Documento
     

        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Tipi Documento
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="$('#modalNuovoTipoDocumento').modal()"><i class="fa fa-plus"></i> Nuovo tipo documento</a>
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabTipiDocumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Aggiornamento cliente abilitato</th>
<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_tipi_documento}" var="tipo" varStatus="loop">

	<tr id="row_${loop.index}" >
	<td>${tipo.id }</td>
	<td>${tipo.descrizione }</td>	
	<td>
	<c:if test="${tipo.aggiornabile_cl_default == 0}">
	NO
	</c:if>
	
		<c:if test="${tipo.aggiornabile_cl_default == 1}">
	SI
	</c:if>
	
	</td>
	<td>	
	<a class="btn btn-warning customTooltip" onClick="modalModificaTipoDocumento('${tipo.id}','${tipo.descrizione}','${tipo.aggiornabile_cl_default}')" title="Click per modificare il tipo documento"><i class="fa fa-edit"></i></a>
    <a class="btn btn-danger customTooltip" onClick="modalEliminaTipoDocumento('${tipo.id}')" title="Click per eliminare il documento"><i class="fa fa-trash"></i></a>
	
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


<form id="formNuovoTipoDocumento" name="formNuovoTipoDocumento">
<div id="modalNuovoTipoDocumento" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Nuovo Tipo Documento</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-3">
       <label>Descrizione</label>
		</div>
		
		<div class="col-sm-9">
       <input type="text" class="form-control" id="descrizione" name="descrizione" required>
		</div>
		</div><br>
		<div class="row">
       <div class="col-sm-3">
       <label>Aggiornabile dal cliente (default)</label>
		</div>
		
		<div class="col-sm-9">
       <input type="checkbox" class="form-control" id="aggiornabile_cl_default" name="aggiornabile_cl_default" value="0">
		</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		
         <button type="submit" class="btn btn-primary pull-right"> Salva</button>
         
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
      	Sei sicuro di voler eliminare il tipo documento?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_tipo">
      <a class="btn btn-primary" onclick="eliminaTipoDocumento($('#id_elimina_tipo').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>



<form id="formModificaTipoDocumento" name="formModificaTipoDocumento">
<div id="modalModificaTipoDocumento" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Nuovo Tipo Documento</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-3">
       <label>Descrizione</label>
		</div>
		
		<div class="col-sm-9">
       <input type="text" class="form-control" id="descrizione_mod" name="descrizione_mod" required>
		</div>
		</div><br>
		<div class="row">
       <div class="col-sm-3">
       <label>Aggiornabile dal cliente (default)</label>
		</div>
		
		<div class="col-sm-9">
       <input type="checkbox" class="form-control" id="aggiornabile_cl_default_mod" name="aggiornabile_cl_default_mod" value="0">
		</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<input type="hidden" id="id_tipo_documento" name="id_tipo_documento">
 		<input type="hidden" id="aggiornabile_mod" name="aggiornabile_mod">
         <button type="submit" class="btn btn-primary pull-right"> Salva</button>
         
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


.table th {
    background-color: #00a65a !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">




$('#aggiornabile_cl_default').on('ifClicked',function(e){
	if($('#aggiornabile_cl_default').is( ':checked' )){
		$('#aggiornabile_cl_default').iCheck('uncheck');
		$(this).val(0);
	}else{
		$('#aggiornabile_cl_default').iCheck('check');
		$(this).val(1);
	}
});

$('#aggiornabile_cl_default_mod').on('ifClicked',function(e){
	if($('#aggiornabile_cl_default_mod').is( ':checked' )){
		$('#aggiornabile_cl_default_mod').iCheck('uncheck');
		$('#aggiornabile_mod').val(0);
	}else{
		$('#aggiornabile_cl_default_mod').iCheck('check');
		$('#aggiornabile_mod').val(1);
	}
});

function modalModificaTipoDocumento(id_tipo, descrizione, aggiornabile){
	$('#id_tipo_documento').val(id_tipo);
	$('#descrizione_mod').val(descrizione);
	
	if(aggiornabile == 1){
		$('#aggiornabile_cl_default_mod').iCheck("check");
		$('#aggiornabile_mod').val(1);
	}else{
		$('#aggiornabile_mod').val(0);
	}
	
	$('#modalModificaTipoDocumento').modal();
}


function modalEliminaTipoDocumento(id_tipo){
	
	$('#id_elimina_tipo').val(id_tipo);
	
	$('#myModalYesOrNo').modal();
}



var columsDatatables = [];

$("#tabTipiDocumento").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabTipiDocumento thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabTipiDocumento thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}



$(document).ready(function() {
 
$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     table = $('#tabTipiDocumento').DataTable({
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
		    	  { responsivePriority: 2, targets: 3 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabTipiDocumento_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabTipiDocumento').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
		table.columns.adjust().draw();
		

});


$('#myModalStorico').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
});

$('#formNuovoTipoDocumento').on('submit', function(e){
	e.preventDefault();
	
	nuovoTipoDocumento();
	
})
 
$('#formModificaTipoDocumento').on('submit', function(e){
	e.preventDefault();
	
	modificaTipoDocumento();
	
})
 
  </script>
  
</jsp:attribute> 
</t:layout>

