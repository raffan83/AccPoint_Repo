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
        Lista Servizi
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
	 Lista  Servizi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoServizio()"><i class="fa fa-plus"></i> Nuovo Servizio</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabServizi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Company</th>
<th>Tipo Servizio</th>
<th>Descrizione</th>
<th>Tipo Rinnovo</th>

<th>Data scadenza</th>
<th>Fornitore</th>
<th>Data acquisto</th>
<th>Email Referenti</th>
<th>Modalità di pagamento</th>
<th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_servizi}" var="servizio" varStatus="loop">
	<c:if test="${servizio.disabilitato ==0 }">
	<jsp:useBean id="now" class="java.util.Date"/>
	<c:choose>

	<c:when test="${servizio.data_scadenza lt now}">
	
	<tr id="row_${loop.index}" style="background-color:#FA8989">
	</c:when>
	<c:otherwise>
		<tr id="row_${loop.index}" >
	</c:otherwise>
	</c:choose>
	
 

	<td>${servizio.id }</td>	
	<td>${servizio.id_company.ragione_sociale }</td>
	<td>${servizio.tipo_servizio.descrizione }</td>
	<td>${servizio.descrizione }</td>
	<td>${servizio.tipo_rinnovo.descrizione }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy" value="${servizio.data_scadenza }"></fmt:formatDate></td>	
	<td>${servizio.fornitore }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${servizio.data_acquisto }"></fmt:formatDate></td>	
		<td>${servizio.email_referenti }</td>
		<td>${servizio.modalita_pagamento }</td>		
		
	<td>	

  	  <a class="btn btn-warning customTooltip" onClicK="modalModificaServizio('${servizio.id }','${servizio.tipo_servizio.id }','${servizio.tipo_rinnovo.id }','${utl:escapeJS(servizio.descrizione) }','${utl:escapeJS(servizio.fornitore) }','${utl:escapeJS(servizio.email_referenti) }','${utl:escapeJS(servizio.modalita_pagamento) }','${servizio.data_scadenza }','${servizio.data_acquisto }','${servizio.id_company.id }')" title="Click per modificare l'servizio"><i class="fa fa-edit"></i></a>
	  
 	<a class="btn btn-danger customTooltip" onClicK="modalEliminaServizio('${servizio.id }')" title="Click per eliminare l'servizio"><i class="fa fa-trash"></i></a>
 
	</td >

	</tr>
	</c:if>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>


</section>



<form id="nuovoServizioForm" name="nuovoServizioForm">
<div id="myModalNuovoServizio" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Servizio</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Servizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_servizio" id="tipo_servizio" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipo Servizio..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipi_servizi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       
       
              
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Proprietaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company" name="company" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
       


   
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione Servizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Rinnovo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_rinnovo" id="tipo_rinnovo" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipo Rinnovo" data-live-search="true" style="width:100%" required>
                <option value=""></option>
                       <c:forEach items="${lista_tipi_rinnovo}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="fornitore" name="fornitore" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
      
       
       	   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br> 
       
     
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email referenti <small>Inserire gli indirizzi separati da ";"</small></label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_referenti" name="email_referenti" class="form-control" type="text" style="width:100%" required>
       			
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
       		<label>Modalità pagamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modalita_pagamento" name="modalita_pagamento" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
   
       
       </div>
  		 
      <div class="modal-footer">
<input type="hidden" id="nuovo_tipo_servizio" name="nuovo_tipo_servizio">
<input type="hidden" id="nuovo_tipo_rinnovo" name="nuovo_tipo_rinnovo">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaServizioForm" name="nuovoServizioForm">
<div id="myModalModificaServizio" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Servizio</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Servizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_servizio_mod" id="tipo_servizio_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipi_servizi}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       

       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Proprietaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_mod" name="company_mod" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
       
   
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione Servizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Rinnovo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_rinnovo_mod" id="tipo_rinnovo_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipo Rinnovo" data-live-search="true" style="width:100%" required>
                <option value=""></option>
                       <c:forEach items="${lista_tipi_rinnovo}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="fornitore_mod" name="fornitore_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
      
       
       	   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control datepicker" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br> 
       
     
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email referenti <small>Inserire gli indirizzi separati da ";"</small></label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_referenti_mod" name="email_referenti_mod" class="form-control" type="text" style="width:100%" required >
       			
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
       		<label>Modalità pagamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modalita_pagamento_mod" name="modalita_pagamento_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
      <input type="hidden" id="id_servizio" name="id_servizio">
<input type="hidden" id="nuovo_tipo_servizio_mod" name="nuovo_tipo_servizio_mod">
<input type="hidden" id="nuovo_tipo_rinnovo_mod" name="nuovo_tipo_rinnovo_mod">

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
      	Sei sicuro di voler eliminare il servizio?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_servizio">
      <a class="btn btn-primary" onclick="eliminaServizio($('#elimina_servizio').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalNuovoTipoRinnovo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci descrizione</h4>
      </div>
       <div class="modal-body">    
       <div class="row">
       <div class="col-xs-12">
         <label>Descrizione</label>
      <input class="form-control" type="text" id="descrizione_nuovo_tipo">
       </div>
       </div>   <br>

    
      	</div>
      <div class="modal-footer">
<input type="hidden" id=isMod>
      <a class="btn btn-primary" onclick="assegnaValoreOpzione()" >Salva</a>
		<a class="btn btn-primary" onclick="$('#modalNuovoTipoRinnovo').modal('hide')" >Chiudi</a>
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


function modalEliminaServizio(id_servizio){
	
	
	$('#elimina_servizio').val(id_servizio);
	$('#myModalYesOrNo').modal()
	
}


function eliminaServizio(){
	
	dataObj = {};
	
	dataObj.id_servizio_elimina = $('#elimina_servizio').val();
	
	callAjax(dataObj, "gestioneScadenzarioIT.do?action=elimina_servizio");
}










function modalNuovoServizio(){
	
	$('#myModalNuovoServizio').modal();
	
}

function modalNuovoTipoRinnovo(){
	
	$('#modalNuovoTipoRinnovo').modal();
}









function assegnaValoreOpzione(){
	

	
	var data = {
		    id: 0,
		    text: $('#descrizione_nuovo_tipo').val()
		};

		var newOption = new Option(data.text, data.id, false, false);
		var tag = $('#isMod').val();
		

		$('#'+tag).append(newOption).trigger('change');
		$('#'+tag+' option[value="'+0+'"]').prop("selected", true)
		
	
		$('#nuovo_'+tag).val($('#descrizione_nuovo_tipo').val());
	
		
		

		$('#descrizione_nuovo_tipo').val("");
		$('#modalNuovoTipoRinnovo').modal('hide');
	
}




function modalModificaServizio(id,id_tipo_servizio, id_tipo_rinnovo, descrizione, fornitore, email_referenti, modalita_pagamento, data_scadenza,data_acquisto, id_company){
	
	
	$('#id_servizio').val(id);
	
	
	$('#descrizione_mod').val(descrizione);
	$('#tipo_servizio_mod').val(id_tipo_servizio);
	$('#tipo_servizio_mod').change();
	$('#tipo_rinnovo_mod').val(id_tipo_rinnovo);
	$('#tipo_rinnovo_mod').change();
	$('#fornitore_mod').val(fornitore);
	$('#email_referenti_mod').val(email_referenti);
	$('#modalita_pagamento_mod').val(modalita_pagamento);
	$('#company_mod').val(id_company);
	$('#company_mod').change();
	
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));	
	}
	if(data_acquisto!=null && data_acquisto!=''){
		$('#data_acquisto_mod').val(Date.parse(data_acquisto).toString("dd/MM/yyyy"));	
	}


	$('#myModalModificaServizio').modal();
}



var columsDatatables = [];

$("#tabServizi").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabServizi thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabServizi thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function aggiungiOpzione(tag){


	
	$('#isMod').val(tag);
	
	$('#'+tag).select2('close');
	modalNuovoTipoRinnovo(tag);
	
}

$(document).ready(function() {
 
$('#company').select2();
$('#company_mod').select2();

$('#tipo_servizio')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_servizio\')">Crea Nuovo Tipo Servizio</a>');
});

$('#tipo_servizio_mod')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_servizio_mod\')">Crea Nuovo Tipo Servizio</a>');
});


$('#tipo_rinnovo')
.select2()
.on('select2:open', () => {
    $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_rinnovo\')">Crea Nuovo Tipo Rinnovo</a>');
});

$('#tipo_rinnovo_mod')
.select2()
.on('select2:open', () => {
    $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_rinnovo_mod\')">Crea Nuovo Tipo Rinnovo</a>');
});


	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabServizi').DataTable({
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
		    
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 10 },
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
		
		table.buttons().container().appendTo( '#tabServizi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabServizi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	 
	 	     

	
	
});


$('#modificaServizioForm').on('submit', function(e){
	 e.preventDefault();
	
	 
	 callAjaxForm('#modificaServizioForm','gestioneScadenzarioIT.do?action=modifica_servizio');
});
 

 
 $('#nuovoServizioForm').on('submit', function(e){
	 e.preventDefault();


	 
	 
	 callAjaxForm('#nuovoServizioForm','gestioneScadenzarioIT.do?action=nuovo_servizio');
	 
});


$('#myModalNuovoServizio').on('hidden.bs.modal', function(){
	
	$('#descrizione').val("");
	$('#tipo_servizio').val("");
	$('#tipo_servizio').change();
	$('#tipo_rinnovo').val("");
	$('#tipo_rinnovo').change();
	$('#fornitore').val("");
	$('#email_referenti').val("");
	$('#modalita_pagamento').val("");
	$('#data_acquisto').val("");
	$('#data_scadenza').val("");	
	
	
});

 
  </script>
  
</jsp:attribute> 
</t:layout>


