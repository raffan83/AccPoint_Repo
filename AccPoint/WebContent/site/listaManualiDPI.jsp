<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        Lista Manuale
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
	 Lista  Manuale
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoManuale()"><i class="fa fa-plus"></i> Nuovo Manuale</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabManuali" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo DPI</th>
<th>Descrizione</th>
<th>Modello</th>
<th>Conformità</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_manuali}" var="manuale" varStatus="loop">

 	<tr id="row_${loop.index}" >

	<td>${manuale.id }</td>	
	<td>${manuale.tipo_dpi.descrizione }</td>


	<td>${manuale.descrizione }</td>
	<td>${manuale.modello }</td>
	<td>${manuale.conformita }</td>

	<td>	

 	  <a class="btn btn-warning customTooltip" onClicK="modalModificaManuale('${manuale.id }','${manuale.tipo_dpi.id }','${utl:escapeJS(manuale.modello) }','${utl:escapeJS(manuale.conformita) }','${utl:escapeJS(manuale.descrizione) }')" title="Click per modificare il manuale dpi"><i class="fa fa-edit"></i></a>
 	   <a class="btn btn-primary customTooltip" onClick="modalAllegati('${manuale.id}')" title="Click per aprire gli allegati"><i class="fa fa-archive"></i></a>   
<%-- 	  <c:if test="${dpi.is_restituzione==0 }">
	  <a class="btn btn-success customTooltip" onClicK="modalCreaRestituzione('${dpi.id }', ${dpi.quantita })" title="Crea restituzione DPI"><i class="fa fa-arrow-left"></i></a>
	  </c:if> --%>
 
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



<form id="nuovoManualeForm" name="nuovoManualeForm">
<div id="myModalNuovoManuale" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo DPI</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_dpi" id="tipo_dpi" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_dpi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
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
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Conformità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="conformita" name="conformita" class="form-control" type="text" style="width:100%" required>
       			
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




<form id="modificaManualeForm" name="modificaManualeForm">
<div id="myModalModificaManuale" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
     <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica DPI</h4>
      </div>
              <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo DPI</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_dpi_mod" id="tipo_dpi_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_dpi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
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
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Conformità</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="conformita_mod" name="conformita_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       

       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="id_manuale" name="id_manuale">

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


  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">       
      <div id="content_allegati"></div>
      	</div>
      <div class="modal-footer">      
      
		<a class="btn btn-primary" onclick="$('#myModalAllegati').modal('hide')" >Chiudi</a>
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






function modalNuovoManuale(){
	
	$('#myModalNuovoManuale').modal();
	
}




function modalAllegati(id_manuale){
	
	 exploreModal("gestioneDpi.do","action=lista_allegati_dpi&id_manuale="+id_manuale,"#content_allegati");
	 $('#myModalAllegati').modal();
}




function modalModificaManuale(id,id_tipo,  modello, conformita, descrizione){
	
	$('#id_manuale').val(id);
	
	$('#tipo_dpi_mod').val(id_tipo);
	$('#tipo_dpi_mod').change();
		
	
	$('#modello_mod').val(modello);
	$('#conformita_mod').val(conformita);
	$('#descrizione_mod').val(descrizione);

	
	$('#myModalModificaManuale').modal();
}



var columsDatatables = [];

$("#tabManuali").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabManuali thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabManuali thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$(document).ready(function() {
 
$('.select2').select2();





	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabManuali').DataTable({
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
	 			  },
	 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  }
	 			  
	 			  ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabManuali_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabManuali').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	



	
	
});


$('#modificaManualeForm').on('submit', function(e){
	 e.preventDefault();
	callAjaxForm("#modificaManualeForm", "gestioneDpi.do?action=modifica_manuale_dpi");
});
 

 
 $('#nuovoManualeForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm("#nuovoManualeForm", "gestioneDpi.do?action=nuovo_manuale_dpi");
});
 
/*  $('#formScheda').on('submit', function(e){
	 e.preventDefault();
	 nuovaSchedaManuale();
}); */


$('#modalScheda').on('hidden.bs.modal', function(){
	
	$('#tipo_scheda').val("");
	$('#tipo_scheda').change();
	$('#lavoratore_scheda').val("");
	$('#lavoratore_scheda').change();
	
});

 
  </script>
  
</jsp:attribute> 
</t:layout>


