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
        Lista Tipologie Corsi
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
	Lista Tipologie Corsi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalnuovaCategoria()"><i class="fa fa-plus"></i> Nuova Tipologia Corso</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForCat" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Codice</th>
<th>Descrizione</th>
<th>Frequenza</th>
<th>Durata</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_corsi_cat }" var="corso_cat" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${corso_cat.id }</td>	
	<td>${corso_cat.codice }</td>
	<td>${corso_cat.descrizione }</td>
	<td>${corso_cat.frequenza}</td>	
	<td>${corso_cat.durata}</td>
	<td>
	<%-- <a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_curriculum&id_docente=${utl:encryptData(docente.id)}" title="Click per scaricare il cv"><i class="fa fa-file-pdf-o"></i></a> --%> 
	<a  class="btn btn-warning" onClicK="modificaCategoriaModal('${corso_cat.id}','${corso_cat.codice }','${corso_cat.descrizione.replace('\'','&prime;')}','${corso_cat.frequenza }','${corso_cat.durata }')" title="Click per modificare la categoria"><i class="fa fa-edit"></i></a>
	<a href="#" class="btn btn-primary customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${corso_cat.id }')"><i class="fa fa-archive"></i></a>
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



  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>

<form id="nuovaCategoriaForm" name="nuovoDocenteForm">
<div id="myModalnuovaCategoria" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Tipologia Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice" name="codice" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Durata (Ore)</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	<input id="durata" name="durata" class="form-control" type="number" step="1" min="0" style="width:100%" required>
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




<form id="modificaCategoriaForm" name="modificaCategoriaForm">
<div id="myModalModificaCategoria" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Tipologia Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_mod" name="codice_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Durata (Ore)</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	<input id="durata_mod" name="durata_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       	</div>
       	</div>		
            	       
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_categoria" name="id_categoria"> 
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
      	Sei sicuro di voler eliminare l'allegato?
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


function modalnuovaCategoria(){
	
	$('#myModalnuovaCategoria').modal();
	
}



function modificaCategoriaModal(id_categoria, codice, descrizione,frequenza, durata){
	
	$('#id_categoria').val(id_categoria);
	$('#codice_mod').val(codice);
	$('#descrizione_mod').val(descrizione);
	$('#frequenza_mod').val(frequenza);
	$('#durata_mod').val(durata);

	$('#myModalModificaCategoria').modal();
}

var columsDatatables = [];

$("#tabForCat").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForCat thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForCat thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalArchivio(id_categoria){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria="+id_categoria+"&id_corso=0";
   exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
   });
$('#myModalArchivio').modal();
}




$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     

     table = $('#tabForCat').DataTable({
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
		
		table.buttons().container().appendTo( '#tabForCat_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabForCat').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});


$('#modificaCategoriaForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForCategoriaCorso();
});
 

 
 $('#nuovaCategoriaForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForCategoriaCorso();
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

