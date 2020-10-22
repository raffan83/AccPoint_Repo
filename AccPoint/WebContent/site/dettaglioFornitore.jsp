<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Fornitore
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-12">
<div class="box box-success box-solid">
<div class="box-header with-border">
	 Dettaglio Fornitore
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${fornitore.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Ragione Sociale</b> <a class="pull-right">${fornitore.ragione_sociale}</a>
                </li>
                
                  <li class="list-group-item">
                <b>Indirizzo</b> <a class="pull-right">${fornitore.indirizzo} ${fornitore.cap } ${fornitore.comune} (${fornitore.provincia })</a>
                </li>
                
                <li class="list-group-item">
                  <b>Partita Iva</b> <a class="pull-right"> ${fornitore.p_iva} </a>
                </li>
                
                <li class="list-group-item">
                  <b>Codice Fiscale</b> <a class="pull-right">${fornitore.cf} </a>
                </li>
                <li class="list-group-item">
                <b>Stato</b> <a class="pull-right">${fornitore.stato.nome }</a>
                </li>
                
                <li class="list-group-item">
                <b>Committente</b> <a class="pull-right">${fornitore.committente.nome_cliente } - ${fornitore.committente.indirizzo_cliente }</a>
                </li>
                

                
               
        </ul>

</div>
</div>
</div>



       
 </div>



    
    <div class="row">
<div class="col-md-12">
<div class="box box-success box-solid">
<div class="box-header with-border">
	 Documenti Fornitore
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-sm-12">

<a class="btn btn-primary pull-right" onClick="modalNuovoDocumento()"><i class="fa fa-plus"></i> Nuovo Documento</a> 

</div></div><br>
<div class="row">
<div class="col-sm-12">

 <table id="tabDocumDocumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Fornitore</th>
<th>Nome Documento</th>
<th>Data caricamento</th>
<th>Frequenza</th>
<th>Data scadenza</th>
<th>Rilasciato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${fornitore.getListaDocumenti()}" var="documento" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${documento.id }</td>	
	<td>${documento.nome_fornitore }</td>
	<td>${documento.nome_documento }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_caricamento}" /></td>
	<td>${documento.frequenza_rinnovo_mesi }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_scadenza}" /></td>
	<td>${documento.rilasciato }</td>
		
	<td>	
	<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento&id_documento=${utl:encryptData(documento.id)}" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>
	  <a class="btn btn-warning" onClicK="modificaDocumentoModal('${documento.id}','${documento.id_fornitore}','${documento.nome_documento}','${documento.data_caricamento}','${documento.frequenza_rinnovo_mesi }',
	   '${documento.data_scadenza}','${documento.nome_file }','${documento.rilasciato }')" title="Click per modificare il Documento"><i class="fa fa-edit"></i></a>
	   
	   <a class="btn btn-danger" onClick="modalEliminaDocumento('${documento.id}')"><i class="fa fa-trash"></i></a>   
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
        
        
        

</div>
</div>
</div>
 </div> 
</section>
</div>




<form id="nuovoDocumentoForm" name="nuovoDipendenteForm">
<div id="myModalnuovoDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Documento</h4>
      </div>
       <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn" id="forn" class="form-control select2" data-placeholder="Seleziona fornitore..." disabled aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento" name="nome_documento" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Caricamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_caricamento'>
               <input type='text' class="form-control input-small" id="data_caricamento" name="data_caricamento" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
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
       </div><br>
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato" name="rilasciato" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload" name="fileupload" type="file" required></span><label id="label_file"></label>
       	</div>       	
       </div><br> 


       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="fornitore" name="fornitore">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDocumentoForm" name="modificaDocumentoForm">
<div id="myModalModificaDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Documento</h4>
      </div>
            <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_mod" id="forn_mod" class="form-control select2" data-placeholder="Seleziona fornitore..." disabled aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento_mod" name="nome_documento_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Caricamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_caricamento_mod'>
               <input type='text' class="form-control input-small" id="data_caricamento_mod" name="data_caricamento_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
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
       </div><br>
      
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato_mod" name="rilasciato_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label>
       	</div>       	
       </div><br> 


       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_documento" name="id_documento">
		<input type="hidden" id="fornitore_mod" name="fornitore_mod">

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
      	Sei sicuro di voler eliminare il documento?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_documento_id">
      <a class="btn btn-primary" onclick="eliminaDocumento($('#elimina_documento_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />


<style>

  .table th {
    background-color: #00a65a !important;
  }
  
  </style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
  
 <script type="text/javascript">
 

 function modalNuovoDocumento(){
 	
 	$('#myModalnuovoDocumento').modal();
 	
 }

 function modalEliminaDocumento(id_documento){
	 
	 
	 $('#elimina_documento_id').val(id_documento);
		$('#myModalYesOrNo').modal();
 }

 function modificaDocumentoModal(id_documento, fornitore, nome_documento, data_caricamento, frequenza,  data_scadenza, nome_file, rilasciato){

 	$('#id_documento').val(id_documento);
 		
 	$('#fornitore_mod').val(fornitore);
 	$('#fornitore_mod').change();

 	$('#nome_documento_mod').val(nome_documento);
 	$('#frequenza_mod').val(frequenza);	
 	
 	if(data_caricamento!=null && data_caricamento!=''){
 		$('#data_caricamento_mod').val(Date.parse(data_caricamento).toString("dd/MM/yyyy"));
 	}
 	if(data_scadenza!=null && data_scadenza!=''){
 		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
 	}
 	$('#rilasciato_mod').val(rilasciato);
 	$('#label_file_mod').html(nome_file);
 	
 	$('#myModalModificaDocumento').modal();
 }





 var columsDatatables = [];

 $("#tabDocumDocumento").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabDocumDocumento thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabDocumDocumento thead th').eq( $(this).index() ).text();
     	
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


	$('#data_caricamento').change(function(){
		
		var frequenza = $('#frequenza').val();
		
		if(frequenza!=null && frequenza!=''){
			var date = $('#data_caricamento').val();
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza').val(formatDate(c));
				
			}
			
		}
		
	});

	$('#data_caricamento_mod').change(function(){
		
		var frequenza = $('#frequenza_mod').val();
		
		if(frequenza!=null && frequenza!=''){
			var date = $('#data_caricamento_mod').val();
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_mod').val(formatDate(c));
				
			}
			
		}
		
	});


	$('#frequenza').change(function(){
		
		var date = $('#data_caricamento').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza').val(formatDate(c));
				
			}
			
		}
		
	});

		$('#frequenza_mod').change(function(){
			
			var date = $('#data_caricamento_mod').val();
			var frequenza = $(this).val();
			if(date!=null && date!='' && frequenza!=''){
				
				var d = moment(date, "DD-MM-YYYY");
				if(date!='' && d._isValid){
					
					   var year = d._pf.parsedDateParts[0];
					   var month = d._pf.parsedDateParts[1];
					   var day = d._pf.parsedDateParts[2];
					   var c = new Date(year, month + parseInt(frequenza), day);
					    $('#data_scadenza_mod').val(formatDate(c));
					
				}
				
			}
			
		});

	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}
    $(document).ready(function() {
    
    	$('.select2').select2();
    	  $('.datepicker').datepicker({
    			 format: "dd/mm/yyyy"
    		 });  
    	
    	  $('.dropdown-toggle').dropdown();
    	     
    	  
    	  
    	$('#fornitore_mod').val('${fornitore.id}')
    	$('#fornitore').val('${fornitore.id}')
    	
    	
    	 table = $('#tabDocumDocumento').DataTable({
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
 		
 		table.buttons().container().appendTo( '#tabDocumDipendenti_wrapper .col-sm-6:eq(1)');
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
 		

 	$('#tabDocumDocumento').on( 'page.dt', function () {
 		$('.customTooltip').tooltipster({
 	        theme: 'tooltipster-light'
 	    });
 		
 		$('.removeDefault').each(function() {
 		   $(this).removeClass('btn-default');
 		})


 	});
 	
    });
    
    
    $('#modificaDocumentoForm').on('submit', function(e){
   	 e.preventDefault();
   	 modificaDocumento();
   });
    

    
    $('#nuovoDocumentoForm').on('submit', function(e){
   	 e.preventDefault();
   	 nuovoDocumento();
   });
    


  </script>
  
</jsp:attribute> 
</t:layout>

