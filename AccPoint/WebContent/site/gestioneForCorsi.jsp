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
        Lista Corsi
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
	Lista Corsi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<a class="btn btn-primary pull-right" onClick="modalnuovoCorso()"><i class="fa fa-plus"></i> Nuovo Corso</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForCorso" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Categoria</th>
<th>Docente</th>
<th>Data Inizio</th>
<th>Data Scadenza</th>
<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_corsi }" var="corso" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${corso.id }</td>	
	<td>${corso.corso_cat.descrizione }</td>
	<td>${corso.docente.nome } ${corso.docente.cognome }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso.data_inizio}" /></td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso.data_scadenza}" /></td>
	<td>
	 
	<a class="btn btn-warning" onClicK="modificaCorsoModal('${corso.id}','${corso.corso_cat.id }','${corso.docente.id}','${corso.data_inizio }','${corso.data_scadenza }','${corso.documento_test }')" title="Click per modificare il corso"><i class="fa fa-edit"></i></a>
	<a class="btn btn-info" onClick="dettaglioCorso('${utl:encryptData(corso.id)}')"><i class="fa fa-search"></i></a>
	
	<a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_documento_test&id_corso=${utl:encryptData(corso.id)}" title="Click per scaricare il documento del test"><i class="fa fa-file-pdf-o"></i></a>
	<a href="#" class="btn btn-primary customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${corso.id }')"><i class="fa fa-archive"></i></a>
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

<form id="nuovoCorsoForm" name="nuovoCorsoForm">
<div id="myModalNuovoCorso" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Categoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="categoria" name="categoria" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Categoria Corso..." required>
        <option value=""></option>
        <c:forEach items="${lista_corsi_cat }" var="categoria">
        <option value="${categoria.id }">${categoria.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Docente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         	<select id="docente" name="docente" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Docente..." required>
        <option value=""></option>
        <c:forEach items="${lista_docenti }" var="docente">
        <option value="${docente.id }">${docente.nome } ${docente.cognome }</option>
        </c:forEach>
        </select>	
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Inizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio" name="data_inizio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
        
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       	</div>			<br>	
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Documento Test</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload" name="fileupload" type="file" required></span><label id="label_file"></label>
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




<form id="modificaCorsoForm" name="modificaCorsoForm">
<div id="myModalModificaCorso" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Categoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="categoria_mod" name="categoria_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Categoria Corso..." required>
        <option value=""></option>
        <c:forEach items="${lista_corsi_cat }" var="categoria">
        <option value="${categoria.id }">${categoria.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Docente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         	<select id="docente_mod" name="docente_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Docente..." required>
        <option value=""></option>
        <c:forEach items="${lista_docenti }" var="docente">
        <option value="${docente.id }">${docente.nome } ${docente.cognome }</option>
        </c:forEach>
        </select>	
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Inizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio_mod" name="data_inizio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
        
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       	</div>	<br>	
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Documento Test</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload_mod" name="fileupload_mod" type="file" required></span><label id="label_file_mod"></label>
       	    </div>
        
       	</div>
       	</div>		
     
       
     
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_corso" name="id_corso">
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


function modalnuovoCorso(){
	
	$('#myModalNuovoCorso').modal();
	
}


function modificaCorsoModal(id_corso,id_categoria, id_docente, data_inizio, data_scadenza, documento_test){
	
	$('#id_corso').val(id_corso);
	$('#categoria_mod').val(id_categoria);
	$('#categoria_mod').change();
	$('#docente_mod').val(id_docente);
	$('#docente_mod').change();
	$('#data_inizio_mod').val(Date.parse(data_inizio).toString("dd/MM/yyyy"));
	$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	$('#label_file_mod').html(documento_test);
	
	
	$('#myModalModificaCorso').modal();
}




$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });


var columsDatatables = [];

$("#tabForCorso").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForCorso thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalArchivio(id_corso){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria=0&id_corso="+ id_corso;
    exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}

function dettaglioCorso(id_corso){
	
	callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso='+id_corso);
}


$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();

     table = $('#tabForCorso').DataTable({
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
		
		table.buttons().container().appendTo( '#tabForCorso_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabForCorso').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});


$('#modificaCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForCorso();
});
 

 
 $('#nuovoCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForCorso();
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

