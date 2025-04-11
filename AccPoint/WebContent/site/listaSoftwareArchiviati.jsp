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
        Lista Software Archiviati
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
	 Lista Software Archiviati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">


<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-left" onClick="callAction('gestioneDevice.do?action=lista_software')" style="margin-left:5px">Software In Servizio</a>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Produttore</th>

 <th>Tipo licenza</th> 

<th>Versione</th>
<th>Data acquisto</th>
<th>Data scadenza</th> 
 <th>Obsoleto</th>
 <th>Contratto</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_software }" var="software" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${software.id }</td>	
	<td>${software.nome }</td>
	<td>${software.produttore }</td>
	<td>${software.tipo_licenza.descrizione }</td>
	<td>${software.versione }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${software.data_acquisto }"></fmt:formatDate></td> 
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${software.data_scadenza }"></fmt:formatDate></td>
 	<td>
 	<c:if test="${software.obsoleto == 'S' }">
 	SI
 	</c:if>
 	<c:if test="${software.obsoleto == 'N' }">
 	NO
 	</c:if></td> 
 	<td>
 	<c:if test="${software.contratto!=null }">
 	ID: ${software.contratto.id } - ${software.contratto.fornitore }
 	
 	</c:if>
 	
 	</td>
	<td>

	 <a class="btn btn-warning customTooltip" onClicK="modificaSoftware('${software.id}', '${utl:escapeJS(software.nome) }','${utl:escapeJS(software.produttore) }','${utl:escapeJS(software.versione) }','${software.data_acquisto }','${software.data_scadenza }','${software.tipo_licenza.id }', '${software.email_responsabile }')" title="Click per modificare il software"><i class="fa fa-edit"></i></a> 
	  <a class="btn btn-success customTooltip"onClicK="modalYesOrNo('${software.id}')" title="Click per rimettere in servizio il software"><i class="fa fa-check"></i></a>
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
       
  
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo licenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_licenza" name="tipo_licenza" class="form-control select2" style="width:100%" data-placeholder="Seleziona tipo licenza...">
        <option value=""></option>
        <c:forEach items="${lista_tipi_licenze }" var="licenza">
        <option value="${licenza.id }">${licenza.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br> 
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto" name="data_acquisto" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 

	<div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Versione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="versione" name="versione" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email Referenti <small>inserire indirizzi separati da ";"</small></label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_referenti" name="email_referenti" class="form-control " type="text" style="width:100%" >
       			
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
       
             
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo licenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_licenza_mod" name="tipo_licenza_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona tipo licenza...">
        <option value=""></option>
        <c:forEach items="${lista_tipi_licenze }" var="licenza">
        <option value="${licenza.id }">${licenza.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br> 
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto_mod" name="data_acquisto_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 

	<div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Versione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="versione_mod" name="versione_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email Referenti <small>inserire indirizzi separati da ";"</small></label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_referenti_mod" name="email_referenti_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
  		 </div>
      <div class="modal-footer">
		
		<input type="hidden" id="id_software" name="id_software">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



<div id="modalEsporta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Esporta Lista Software</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-12">
       		<label>Filtra Company</label>
         
       	  	
        <select id="company" name="company" data-placeholder="Seleziona Company Proprietaria..." class="form-control select2" style="width:100%" >
 	 <option value="" ></option>
        <c:forEach items="${lista_company }" var="cmp">

        <option value="${cmp.id }" >${cmp.ragione_sociale }</option>

        </c:forEach>
        
        </select>
      
       	</div>       	
       </div><br>

  		 </div>
      <div class="modal-footer">

		<button class="btn btn-primary" onclick="esportaListaSoftware()">Esporta</button> 
       
      </div>
    </div>
  </div>

</div>





  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      Sei sicuro di voler rimettere in servizio il software?
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


function modificaSoftware(id_software, nome, produttore,   versione, data_acquisto, data_scadenza, tipo_licenza,email){
	
	$('#id_software').val(id_software);
	$('#nome_mod').val(nome);
	$('#produttore_mod').val(produttore);
 	$('#tipo_licenza_mod').val(tipo_licenza);
	$('#tipo_licenza_mod').change();
	if(data_acquisto!=null && data_acquisto!=''){
		$('#data_acquisto_mod').val(Date.parse(data_acquisto).toString("dd/MM/yyyy")); 	
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy")); 	
	}
	
	$('#versione_mod').val(versione);
	$('#email_referenti_mod').val(email);
	

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
	dataObj.stato="0";
	
	callAjax(dataObj, "gestioneDevice.do?action=elimina_software");
	
}


function modalAllegati(id_software){
	
	 exploreModal("gestioneDevice.do","action=lista_allegati_software&id_software="+id_software,"#content_allegati", function(datab, status){
		 $('#myModalAllegati').modal();	 
	 });
	 
}


function esportaListaSoftware(){
	
	var id_company = $('#company').val();
	
	callAction("gestioneDevice.do?action=esporta_lista_sw&id_company="+id_company);
	
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
		    	  
		    	  { responsivePriority: 1, targets: 9 },
		    	  
		    	  
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


