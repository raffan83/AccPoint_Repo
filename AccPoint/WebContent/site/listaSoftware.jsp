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
        Lista Software
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
	 Lista Software
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoSoftware()"><i class="fa fa-plus"></i> Nuovo Software</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Produttore</th>
<%-- <th>Stato validazione</th>
<th>Data validazione</th> --%>
<%-- <th>Autorizzato</th> --%>
<th>Versione</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_software }" var="software" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${software.id }</td>	
	<td>${software.nome }</td>
	<td>${software.produttore }</td>
<%-- 	<td>${software.stato_validazione.descrizione }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${software.data_validazione }"></fmt:formatDate></td> --%>
<%-- 	<td>${software.autorizzato }</td> --%>
	<td>${software.versione }</td>
	<td>

	 <a class="btn btn-warning customTooltip" onClicK="modificaSoftware('${software.id}', '${utl:escapeJS(software.nome) }','${utl:escapeJS(software.produttore) }','${utl:escapeJS(software.versione) }')" title="Click per modificare il tipo device"><i class="fa fa-edit"></i></a> 
	  <a class="btn btn-danger customTooltip"onClicK="modalYesOrNo('${software.id}')" title="Click per eliminare il software"><i class="fa fa-trash"></i></a>
	  <a class="btn btn-primary customTooltip" onClick="modalAllegati('${software.id}')" title="Click per aprire gli allegati"><i class="fa fa-archive"></i></a>
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



<form id="nuovoSoftwareForm" name="nuovoSoftwareForm">
<div id="myModalNuovoSoftware" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Software</h4>
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
       		<label>Produttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="produttore" name="produttore" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
             
       
       <%--  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Stato validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="stato_validazione" name="stato_validazione" data-placeholder="Seleziona stato validazione..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_stati_validazione }" var="stato">
        <option value="${stato.id }">${stato.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_validazione" name="data_validazione" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> --%>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Versione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="versione" name="versione" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
<!--                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Autorizzato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="autorizzato" name="autorizzato" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       </div> -->
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaSoftwareForm" name="modificaSoftwareForm">
<div id="myModalModificaSoftware" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Software</h4>
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
       		<label>Produttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="produttore_mod" name="produttore_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
             
       <%-- 
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Stato validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="stato_validazione_mod" name="stato_validazione_mod" data-placeholder="Seleziona stato validazione..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_stati_validazione }" var="stato">
        <option value="${stato.id }">${stato.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_validazione_mod" name="data_validazione_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> --%>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Versione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="versione_mod" name="versione_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
<!--                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Autorizzato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="autorizzato_mod" name="autorizzato_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       </div> -->
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_software" name="id_software">
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
      Sei sicuro di voler eliminare il software?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_software">
      <a class="btn btn-primary" onclick="eliminaSoftware($('#id_elimina_software').val())" >SI</a>
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


function modalNuovoSoftware(){
	
	$('#myModalNuovoSoftware').modal();
	
}


function modificaSoftware(id_software, nome, produttore,   versione){
	
	$('#id_software').val(id_software);
	$('#nome_mod').val(nome);
	$('#produttore_mod').val(produttore);
/* 	$('#stato_validazione_mod').val(id_stato_validazione);
	$('#stato_validazione_mod').change();
	$('#data_validazione_mod').val(Date.parse(data_validazione).toString("dd/MM/yyyy")); */
	//$('#autorizzato_mod').val(autorizzato);	
	$('#versione_mod').val(versione);

	$('#myModalModificaSoftware').modal();
}


var columsDatatables = [];

$("#tabSoftware").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabSoftware thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabSoftware thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_software){
	
	
	$('#id_elimina_software').val(id_software);
	$('#myModalYesOrNo').modal();
	
}

function eliminaSoftware(id_software){
	
	var dataObj = {};
	dataObj.id_software = id_software;
	
	callAjax(dataObj, "gestioneDevice.do?action=elimina_software");
	
}


function modalAllegati(id_software){
	
	 exploreModal("gestioneDevice.do","action=lista_allegati_software&id_software="+id_software,"#content_allegati");
	 $('#myModalAllegati').modal();
}

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
  

     table = $('#tabSoftware').DataTable({
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
		
		table.buttons().container().appendTo( '#tabSoftware_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabSoftware').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaSoftwareForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaSoftwareForm','gestioneDevice.do?action=modifica_software');
});
 

 
 $('#nuovoSoftwareForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#nuovoSoftwareForm','gestioneDevice.do?action=nuovo_software');
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>


