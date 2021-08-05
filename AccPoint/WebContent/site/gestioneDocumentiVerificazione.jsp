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
        Documenti Verificazione

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
	Documenti Verificazione
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

	
	<c:set var="admin" value="1"></c:set>
<a class="btn btn-primary pull-right" onClick="modalNuovoDocumento()"><i class="fa fa-plus"></i> Nuovo documento</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabDocumenti" class="table table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th>ID</th>

<th>Costruttore</th>
<th>Modello</th>
<th>Tipo documento</th>
<th>Data caricamento</th>
<th style="min-width:120px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_documenti }" var="documento" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${documento.id }</td>
	<td>${documento.costruttore }</td>
	<td>${documento.modello}</td>
	<td>${documento.tipo_documento.descrizione}</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_caricamento}" /></td>
	<td>
	<%-- <a class="btn btn-warning customTooltip"title="Click per modificare il provvedimento"  onClick="modalModificaProvvedimento('${provvedimento.id }','${utl:escapeJS(provvedimento.costruttore) }','${utl:escapeJS(provvedimento.modello) }',
	'${utl:escapeJS(provvedimento.classe) }','${provvedimento.tipo_approvazione.id }', '${provvedimento.tipo_provvedimento.id }', '${provvedimento.numero_provvedimento }', '${provvedimento.data_provvedimento }', '${provvedimento.rev }')"><i class="fa fa-edit"></i></a>
	<a class="btn btn-info customTooltip" title="Click per clonare il provvedimento" onClick="modalClonaProvvedimento('${utl:escapeJS(provvedimento.descrizione_strumento)}','${provvedimento.tipo_approvazione.id }', '${provvedimento.tipo_provvedimento.id }', '${provvedimento.numero_provvedimento }', '${provvedimento.data_provvedimento }', '${provvedimento.rev }')"><i class="fa fa-clone"></i></a>
	<a href="#" class="btn btn-primary customTooltip customLink" title="Click per visualizzare gli allegati" onclick="modalAllegatiProvvedimento('${provvedimento.id }')"><i class="fa fa-archive"></i></a>
 --%>
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

 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br>

       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_provvedimento_allegato" name="id_provvedimento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>

<form id="nuovoDocumentoForm" name="nuovoDocumentoForm">
<div id="mymodalNuovoDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo documento</h4>
      </div>
       <div class="modal-body">
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="costruttore" name="costruttore" class="form-control" required>
       			
       	</div>       	
       </div><br>
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="modello" name="modello" class="form-control" required>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_documento" name="tipo_documento" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Tipo di documento..." required>
        <option value=""></option>
        <c:forEach items="${lista_tipo_documenti }" var="tipo_documento">
        <option value="${tipo_documento.id }">${tipo_documento.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
	 <div class="row">
        <div class="col-xs-12">

 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload_documento" type="file" name="files[]" multiple>
		       
		   	 </span> <label id="label_fileupload"></label>

		   	 <br><br>

       <div id="tab_allegati"></div>
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



<form id="modificaProvvedimentoForm" name="nuovoCorsoForm">
<div id="myModalModificaProvvedimento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica provvedimento</h4>
      </div>
       <div class="modal-body">
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Strumento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="strumento_mod" name="strumento_mod" class="form-control">
       			
       	</div>       	
       </div><br>
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="costruttore_mod" name="costruttore_mod" class="form-control">
       			
       	</div>       	
       </div><br>
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="modello_mod" name="modello_mod" class="form-control">
       			
       	</div>       	
       </div><br>
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Classe</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="classe_mod" name="classe_mod" class="form-control">
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo di approvazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_approvazione_mod" name="tipo_approvazione_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Tipo di approvazione..." required>
        <option value=""></option>
        <c:forEach items="${lista_tipo_approvazione }" var="tipo_approvazione">
        <option value="${tipo_approvazione.id }">${tipo_approvazione.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
		<div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo provvedimento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_provvedimento_mod" name="tipo_provvedimento_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Tipologia Provvedimento..." required>
        <option value=""></option>
        <c:forEach items="${lista_tipo_provvedimento }" var="tipo_provvedimento">
        <option value="${tipo_provvedimento.id }">${tipo_provvedimento.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero provvedimento</label>
       	</div>
       	<div class="col-sm-9">      
       	 <input type="text" id="numero_provvedimento_mod" name="numero_provvedimento_mod" class="form-control"> 	
      	
       			
       	</div>       	
       </div><br>
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data provvedimento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         <div class='input-group date datepicker' id='datepicker_provvedimento_mod'>
               <input type='text' class="form-control input-small" id="data_provvedimento_mod" name="data_provvedimento_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
        
       			
       	</div>       	
       </div><br>
       
 	
    <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rev.</label>
       	</div>
       	<div class="col-sm-9">      
       	 <input type="text" id="rev_mod" name="rev_mod" class="form-control"> 	
      	
       			
       	</div>       	
       </div><br>
      
       
       
       </div>
  		 
      <div class="modal-footer">
	
	  	 <input type="hidden" id="id_provvedimento" name="id_provvedimento" class="form-control"> 	
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
      <input type="hidden" id="id_allegato_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoLegalizzazione($('#id_allegato_elimina').val())" >SI</a>
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


  </style>

</jsp:attribute>

  
<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript">



$('#fileupload_documento').change(function(){
	
	var list = this.files;
	var html ="";
	for(var i = 0;i<list.length;i++){
		html = html +list[i].name+"; <br>"
	}
	
	//$('#label_fileupload').html($(this).val().split("\\")[2]);
	$('#label_fileupload').html(html);
	 
 });




function modalAllegatiProvvedimento(id_provvedimento){

	$('#id_provvedimento_allegato').val(id_provvedimento);
	 $('#tab_archivio').html("");
	 
	 dataString ="action=lista_allegati&id_provvedimento="+ id_provvedimento;
    exploreModal("gestioneVerLegalizzazioneBilance.do",dataString,null,function(datab,textStatusb){
    	
    	var result = JSON.parse(datab);
    	
    	if(result.success){
    		
    		var lista_allegati = result.lista_allegati;
    		var html = '<ul class="list-group list-group-bordered">';
    		if(lista_allegati.length>0){
    			for(var i= 0; i<lista_allegati.length;i++){
       			 html= html + '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nome_file+'</b></div><div class="col-xs-2 pull-right">' 	           
                +'<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>'
    	           +'<a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestioneVerLegalizzazioneBilance.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>'
    	           +'</div></div></li>';
       		}
    		}else{
    			 html= html + '<li class="list-group-item"> Nessun file allegato allo strumento! </li>';
    		}
    		
    		$("#tab_allegati").html(html+"</ul>");
    	}
    	
    	
    	
    });
    
    
    
    
    $('#fileupload').fileupload({
    	 url: "gestioneVerLegalizzazioneBilance.do?action=upload_allegato&id_provvedimento="+$('#id_provvedimento_allegato').val(),
    	 dataType: 'json',	 
    	 getNumberOfFiles: function () {
    	     return this.filesContainer.children()
    	         .not('.processing').length;
    	 }, 
    	 start: function(e){
    	 	pleaseWaitDiv = $('#pleaseWaitDialog');
    	 	pleaseWaitDiv.modal();
    	 	
    	 },
    	 singleFileUploads: false,
    	  add: function(e, data) {
    	     var uploadErrors = [];
    	     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx)$/i;
    	   
    	     for(var i =0; i< data.originalFiles.length; i++){
    	    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
    		         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
    		         break;
    		     }	 
    	    	 if(data.originalFiles[i]['size'] > 30000000) {
    		         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 30mb');
    		         break;
    		     }
    	     }	     		     
    	     if(uploadErrors.length > 0) {
    	     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
    	 			$('#myModalError').removeClass();
    	 			$('#myModalError').addClass("modal modal-danger");
    	 			$('#myModalError').modal('show');
    	     } 
    	     else {
    	         data.submit();
    	     }  
    	 },
    	
    	 done: function (e, data) {
    	 		
    	 	pleaseWaitDiv.modal('hide');
    	 	
    	 	if(data.result.success){
    	 		//$('#myModalAllegatiArchivio').modal('hide');
    	 		$('#myModalAllegati').hide();
    	 		$('#myModalErrorContent').html(data.result.messaggio);
    			$('#myModalError').removeClass();
    			$('#myModalError').addClass("modal modal-success");
    			$('#myModalError').modal('show');
    			
    			
    			$('#myModalError').on("hidden.bs.modal",function(){
    				
    		 	if($('#cliente').val()==null && $("#sede").val()==null){
    				
    				location.reload();
    			}else{ 
    				dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val();
    				   exploreModal('gestioneVerStrumenti.do',dataString,'#posTab', function(){
    						$(document.body).css('padding-right', '0px');
    						$('.modal-backdrop').hide();
    				   });
    				   
    			}
    				  
    				   
    			});
    	 	}else{		 			
    	 			$('#myModalErrorContent').html(data.result.messaggio);
    	 			$('#myModalError').removeClass();
    	 			$('#myModalError').addClass("modal modal-danger");
    	 			$('#report_button').show();
    	 			$('#visualizza_report').show();
    	 			$('#myModalError').modal('show');
    	 		}
    	 },
    	 fail: function (e, data) {
    	 	pleaseWaitDiv.modal('hide');

    	     $('#myModalErrorContent').html(errorMsg);
    	     
    	 		$('#myModalError').removeClass();
    	 		$('#myModalError').addClass("modal modal-danger");
    	 		$('#report_button').show();
    	 		$('#visualizza_report').show();
    	 		$('#myModalError').modal('show');

    	 		$('#progress .progress-bar').css(
    	                'width',
    	                '0%'
    	            );
    	 },
    	 progressall: function (e, data) {
    	     var progress = parseInt(data.loaded / data.total * 100, 10);
    	     $('#progress .progress-bar').css(
    	         'width',
    	         progress + '%'
    	     );

    	 }
    });		
    
$('#myModalArchivio').modal();
	
}

function modalNuovoDocumento(){
	
	$('#mymodalNuovoDocumento').modal();
	
}

function eliminaAllegatoModal(id_allegato){
	
	$('#id_allegato_elimina').val(id_allegato);
	
	$('#myModalYesOrNo').modal();
}


function modalModificaProvvedimento(id_provvedimento,descrizione_strumento, costruttore, modello, classe, tipo_approvazione, tipo_provvedimento, numero_provvedimento, data_provvedimento, rev){
	
	$('#id_provvedimento').val(id_provvedimento);
	$('#strumento_mod').val(descrizione_strumento);
	$('#costruttore_mod').val(costruttore);
	$('#modello_mod').val(modello);
	$('#classe_mod').val(classe);
	$('#numero_provvedimento_mod').val(numero_provvedimento);
	$('#data_provvedimento_mod').val(Date.parse(data_provvedimento).toString("dd/MM/yyyy"));
	$('#tipo_approvazione_mod').val(tipo_approvazione);
	$('#tipo_approvazione_mod').change();
	$('#tipo_provvedimento_mod').val(tipo_provvedimento);
	$('#tipo_provvedimento_mod').change();
	$('#rev_mod').val(rev);

	$('#myModalModificaProvvedimento').modal();
}

function modalClonaProvvedimento(descrizione_strumento,tipo_approvazione, tipo_provvedimento, numero_provvedimento, data_provvedimento, rev ){
		
	$('#strumento').val(descrizione_strumento);

	$('#numero_provvedimento').val(numero_provvedimento);
	$('#data_provvedimento').val(Date.parse(data_provvedimento).toString("dd/MM/yyyy"));
	$('#tipo_approvazione').val(tipo_approvazione);
	$('#tipo_approvazione').change();
	$('#tipo_provvedimento').val(tipo_provvedimento);
	$('#tipo_provvedimento').change();
	$('#rev').val(rev);

	$('#mymodalNuovoDocumento').modal();
	
	
}


var columsDatatables = [];

$("#tabDocumenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDocumenti thead th').each( function () {
    	
    	//$(this).css('background-color','#3c8dbc');  	
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDocumenti thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
    		 
    			  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
    			
	    	//}

    	} );
    
    

} );




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}



$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();

     table = $('#tabDocumenti').DataTable({
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
	        pageLength: 100,
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
		    	  { responsivePriority: 2, targets: 10 },
		    	   { targets: 1,  orderable: false }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDocumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDocumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});



});


$('#nuovoDocumentoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoDocumento();
});

 
 $('#modificaProvvedimentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaProvvedimento();
});
 
 


 $('#myModalArchivio').on('hidden.bs.modal',function(){
		
		$(document.body).css('padding-right', '0px');
	});

 
  </script>
  
</jsp:attribute> 
</t:layout>

