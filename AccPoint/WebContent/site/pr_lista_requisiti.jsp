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
        Lista Requisiti
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
	Lista Risorse
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<a class="btn btn-primary pull-right" onClick="modalNuovoReqSanitario()"><i class="fa fa-plus"></i> Nuovo Requisito Sanitario</a> 
<a class="btn btn-primary pull-right" style="margin-right:5px" onClick="modalNuovoReqDocumentale()"><i class="fa fa-plus"></i> Nuovo Requisito Documentale</a>
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabReqSanitari" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Descrizione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_req_sanitari}" var="req" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${req.id }</td>	
	<td>${req.descrizione }</td>
	
	<td>

	<a  class="btn btn-warning" onClicK="modificaRequisitoModal('${req.id}' ,'${req.descrizione }')" title="Click per modificare il requisito sanitario"><i class="fa fa-edit"></i></a>
 	<a  class="btn btn-danger" onClicK="modalEliminaRequisito('${req.id}')" title="Click per eliminare il requisito"><i class="fa fa-trash"></i></a>

	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>

<div class="row">
<div class="col-sm-12">

 <table id="tabReqDocumentali" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Codice</th>
<th>Descrizione</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_req_documentali}" var="req" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${req.id }</td>	
	<td>${req.categoria.codice }</td>
	<td>${req.categoria.descrizione }</td>
	
	
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




<form id="NuovoReqSanitario" name="NuovoReqSanitario">
<div id="modalNuovoReqSanitario" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Requisito Sanitario</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-12">
       		<label>Descrizione</label>
        
			<input type="text" id="descrizione" name="descrizione" class="form-control">
       	</div>  
       </div><br>
      
       </div>
  		 
      <div class="modal-footer">
	
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>


<form id="ModificaReqSanitario" name="ModificaReqSanitario">
<div id="modalModificaRequisito" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Requisito Sanitario</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-12">
       		<label>Descrizione</label>
        
			<input type="text" id="descrizione_mod" name="descrizione_mod" class="form-control">
       	</div>  
       </div><br>
      
       </div>
  		 
      <div class="modal-footer">
				<input type="hidden" id="id_requisito" name="id_requisito" class="form-control">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>


<form id="NuovoReqDocumentale" name="NuovoReqDocumentale">
<div id="modalNuovoReqDocumentale" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">AGGIUNGI REQUISITI DOCUMENTALI</h4>
      </div>
       <div class="modal-body">

      
      
      <div class="row">
<div class="col-sm-12">
<label>Categorie corsi</label>
</div>
</div>
 <div class="row">
<div class="col-sm-12">
 <table id="tabCategorie" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active" >

<td></td>
<th>ID</th>
<th>Codice</th>
<th>Categoria</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_categorie}" var="categoria" varStatus="loop">
 
	<tr id="row_cat_${categoria.id }">
	<td></td>
	<td>${categoria.id }</td>	
	<td>${categoria.codice }</td>
	<td>${categoria.descrizione }</td>	
	</tr>
	</c:forEach> 
	 

 </tbody>
 </table>  
</div>
</div>
       
       
           
       </div>
  		 
      <div class="modal-footer">
     
		<input id="id_categorie" name="id_categorie" type="hidden">
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
      	Sei sicuro di voler eliminare il requisito sanitario?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_requisito_elimina">
      <a class="btn btn-primary" onclick="eliminaRisorsa($('#id_requisito_elimina').val())" >SI</a>
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


function modalNuovoReqDocumentale(){
	
	
	var lista_req_json =${lista_req_documentali_json};
	
	for (var i = 0; i < lista_req_json.length; i++) {
		t2.row( "#row_cat_"+ lista_req_json[i].categoria.id, { page:   'all'}).select();
		
	}
	
	$('#modalNuovoReqDocumentale').modal();
	
}
function modalNuovoReqSanitario(){
	
	$('#modalNuovoReqSanitario').modal();
	
}
function modalEliminaRequisito(id_requisito){
	
	$('#id_requisito_elimina').val(id_requisito)
	$('#myModalYesOrNo').modal()
}

function eliminaRisorsa(id_requisito){
	
	dataObj ={};
	dataObj.id_requisito = id_requisito
	callAjax(dataObj, "gestioneRisorse.do?action=elimina_requisito")
	
}

function modificaRequisitoModal(id_requisito, descrizione){
	

		    $('#id_requisito').val(id_requisito)
		
	      	
	  		$('#descrizione_mod').val(descrizione);
			
	
			$('#modalModificaRequisito').modal();
		
	
}

var columsDatatables = [];

$("#tabReqDocumentali").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabReqDocumentali thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabReqDocumentali thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


var columsDatatables1 = [];

$("#tabReqSanitari").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables1 = state.columns;
    }
    $('#tabReqSanitari thead th').each( function () {
     	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
    	  var title = $('#tabReqSanitari thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


$(document).ready(function() {
	


     $('.dropdown-toggle').dropdown();

     table = $('#tabReqDocumentali').DataTable({
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
		
		table.buttons().container().appendTo( '#tabReqDocumentali_wrapper .col-sm-6:eq(1)');
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
		


		
		
		
	     t = $('#tabReqSanitari').DataTable({
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
			
			 t.buttons().container().appendTo( '#tabtabReqSanitari_wrapper .col-sm-6:eq(1)');
		 	    $('.inputsearchtable').on('click', function(e){
		 	       e.stopPropagation();    
		 	    });

 		 	     t.columns().eq( 0 ).each( function ( colIdx ) {
		  $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
		      t
		          .column( colIdx )
		          .search( this.value )
		          .draw();
		  } ); 
		} );   
		
		
		
			t.columns.adjust().draw();
			



	
	
			 t2 = $('#tabCategorie').DataTable({
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
				      select: {
						    style: 'multi-shift',
						    selector: 'td:nth-child(1)' // attenzione: meglio usare 'first-child' che 'nth-child(1)'
						  },   
				      columnDefs: [
						    {
						      targets: 0,
						      className: 'select-checkbox',
						      orderable: false,
						      defaultContent: ''
						    }       
						    ],
			  	      buttons: [   
			  	          {
			  	            extend: 'colvis',
			  	            text: 'Nascondi Colonne'  	                   
			 			  } ]
				               
				    });
	

    
	
			 t2.columns.adjust().draw();
});
	


 
 $('#NuovoReqDocumentale').on('submit', function(e){
	 e.preventDefault();
	 

	   var id_req_documentali = "";
	    var valori = "";
	   t2.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	    

	        $row.find('td').each(function(i, cell) {
	            let testo = "";

	            if (i === 0 || i === 2) return; // Salta checkbox e descrizione

	            if (i === 1) {
	                // ID
	                testo = $(cell).text().trim();
	                id_req_documentali += testo +";";
	            }

	        });

	        
	    });
	    
	    
	$('#id_categorie').val(id_req_documentali);
	
	callAjaxForm('#NuovoReqDocumentale','gestioneRisorse.do?action=nuovo_requisito');
});
 
 
 $('#NuovoReqSanitario').on('submit', function(e){
	 e.preventDefault();
	 
	
	callAjaxForm('#NuovoReqSanitario','gestioneRisorse.do?action=nuovo_requisito');
});
 
 $('#ModificaReqSanitario').on('submit', function(e){
	 e.preventDefault();
	 
	
	callAjaxForm('#ModificaReqSanitario','gestioneRisorse.do?action=modifica_requisito');
});

 
  </script>
  
</jsp:attribute> 
</t:layout>

