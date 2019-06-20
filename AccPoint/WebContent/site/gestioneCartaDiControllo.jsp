<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


 <div class="row">       
       <div class="col-xs-4">
			<!-- <span class="btn btn-primary fileinput-button disabled" id="btn_carica">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Carta Di Controllo...</span>
				<input accept=".xls,.xlsx"  id="fileupload_excel" name="fileupload_excel" type="file" >
		       
		   	 </span> -->
		   	 <a class="btn btn-primary fileinput-button" id="btn_carica">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Carta Di Controllo...</span>
				<input accept=".xls,.xlsx"  id="fileupload_excel" name="fileupload_excel" type="file" >
		       
		   	 </a>
		   	 <div id="files" class="files"></div>
		   	</div> 
		 <div class="col-xs-8">
		 <label id="label_excel"></label>
		 </div>		
		</div><br>
<div class="row">
<div class="col-xs-12">
 <table id="tabCartaDiControllo" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data Caricamento</th>
 <th>Utente</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>


<tr>
<td>${carta.id }</td>
<td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${carta.data_caricamento}" /></td>
<td>${carta.utente.nominativo}</td>
<td>
<c:if test="${carta.filename!=null && carta.filename!=''}">
<a class="btn customTooltip btn-success" onClick="gestisciFile('${carta.filename}')" title="Click per scaricare o modificare il file"><i class="fa fa-file-excel-o"></i></a>
<%-- <a class="btn customTooltip btn-danger" onClick="eliminaCartaDiControllo('${carta.id}')" title="Click per eliminare il file"><i class="fa fa-trash"></i></a> --%>
<a class="btn customTooltip btn-danger" onClick="modalYesOrNo('${carta.id}')" title="Click per eliminare il file"><i class="fa fa-trash"></i></a>
</c:if>
</td>

	</tr>
	

 
	
 </tbody>
 </table> 

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
      	Sei sicuro di voler eliminare la Carta di controllo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_carta_id">
      <a class="btn btn-primary" onclick="eliminaCartaDiControllo($('#elimina_carta_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
		
      </div>
    </div>
  </div>

</div>




<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>

<!-- <script type="text/javascript" src="https://apis.google.com/js/client.js"></script> -->



 <script type="text/javascript">
 
 function downloadCartaDiControllo(){
		var file = "${carta.filename}";
		callAction('gestioneCartaDiControllo.do?action=download&filename='+file+'&idCamp='+datax[0]);
		
	}
 

 function getFileToUpload(filename) {
	  
	    var location = './images/temp/'+filename;
	    var blob = null;
	    var xhr = new XMLHttpRequest();
	    xhr.open("GET", location, true);
	    xhr.onreadystatechange = function () {
	        if (xhr.readyState == XMLHttpRequest.DONE) {
	            var blob = xhr.response;
	            var file = new File([blob], filename, { type: '', lastModified: Date.now() });
	            uploadDrive(file, filename);
	        }
	    }
	    xhr.responseType = "blob";
	    xhr.send();
	    
	}


function gestisciFile(nome_file){
	
	scaricaCartaDiControllo(nome_file, datax[0]);
	  
}



function deleteFileDrive(){
	  var request = gapi.client.drive.files.delete({
		    'fileId': id
		  });
		  request.execute(function(resp) { }); 

}

function downloadGDriveFile (file) {
	 
	 if(file.webContentLink!=null){
		 var link = file.webContentLink;
	
		 sostituisciExcelPacchetto(link, filename, datax[0]);
		 
	 }else{
		 scaricaPacchettoUploaded(filename);
	 }
	
}

	$('#modalDrive').on("hidden.bs.modal", function(){	
	        //  updateMetadata();
		deleteFileDrive();
	})
	
	
	

	function updateMetadata(){
		
		 gapi.client.drive.permissions.create({
		      fileId: id,
		    	  resource:{
		          role:"reader",
		          type:"anyone"
		      }}).then(function(err,result){
		        if(err){ console.log(err);
		        var request = gapi.client.drive.files.get({'fileId': id, "fields":"*"});
		    		request.execute(downloadGDriveFile);
		        }
		      });
	}
 
 
 
/* 	var columsDatatables = [];
	 
	$("#tabCartaDiControllo").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabCartaDiControllo thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabCartaDiControllo thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );
 */
 
 function modalYesOrNo(id_carta){
	 $('#elimina_carta_id').val(id_carta);
	 $('#myModalYesOrNo').modal();
 }
	
/*  function nascondiYesOrNo(){
	
	 $('#myModalYesOrNo').modal();
 } */
 $('#myModalYesOrNo').on('hidden.bs.modal', function(){
	  contentID == "registro_attivitaTab";
	  
});   
	
  $(document).ready(function() {
	
	   var id_carta = '${carta.id}';
	  if(id_carta!=null && id_carta!=''){
		  $('#btn_carica').addClass('disabled');
	  } 
	  console.log("d")
	  
	  tabCarta = $('#tabCartaDiControllo').DataTable({
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
	     pageLength: 10,
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,
		      "order": [[ 0, "desc" ]],
		       columnDefs: [
					   { responsivePriority: 1, targets: 0 },
		                   { responsivePriority: 2, targets: 3 }
		               ], 

		    	
		    });
		


		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
/* 	tabCarta = $('#tabTaratureEsterne').DataTable();
	//Apply the search
	tabCarta.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tabCarta.column( colIdx ).header() ).on( 'keyup', function () {
		tabCarta
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
	tabCarta.columns.adjust().draw(); */
		

	$('#tabCartaDiControllo').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	  
	  
	  
	  $('#fileupload_excel').fileupload({
	        url: "gestioneCartaDiControllo.do?action=upload&idCamp="+datax[0],
	        dataType: 'json',
	        maxNumberOfFiles : 1,
	        getNumberOfFiles: function () {
	            return this.filesContainer.children()
	                .not('.processing').length;
	        },
	        start: function(e){
	        	pleaseWaitDiv = $('#pleaseWaitDialog');
				pleaseWaitDiv.modal();
	        },
	        add: function(e, data) {
	            var uploadErrors = [];
	            var acceptFileTypes = /(\.|\/)(xls|xlsx|XLS|XLSX)$/i;
	            if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
	                uploadErrors.push('Tipo File non accettato. ');
	            }
	            if(data.originalFiles[0]['size'] > 30000000) {
	                uploadErrors.push('File troppo grande, dimensione massima 30mb');
	            }
	            if(uploadErrors.length > 0) {
	            	//$('#files').html(uploadErrors.join("\n"));
	            	$('#myModalErrorContent').html(uploadErrors.join("\n"));
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					
					$('#myModalError').modal('show');
				
	            } else {
	                data.submit();
	            }
	    	},
	        done: function (e, data) {
				
	        	pleaseWaitDiv.modal('hide');
	        	
	        	if(data.result.success)
				{
	        		$('#myModalErrorContent').html(data.result.messaggio);
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-success");
					$('#myModalError').modal('show');
					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
				
				}else{
					
					$('#myModalErrorContent').html(uploadErrors.join("\n"));
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					
					$('#myModalError').modal('show');
					
					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );

				}


	        },
	        fail: function (e, data) {
	        	pleaseWaitDiv.modal('hide');
	        	$('#files').html("");
	        	var errorMsg = "";
	            $.each(data.messages, function (index, error) {

	            	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
	       

	            });
	        		$('#myModalErrorContent').html(uploadErrors.join("\n"));
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#myModalError').find('.modal-footer').append('<button type="button" class="btn btn-outline" id="report_button" onClick="sendReport($(this).parents(\'.modal\'))">Invia Report</button>');
				$('#myModalError').modal('show');
				$('#progress .progress-bar').css(
	                    'width',
	                    '0%'
	                );
				$('#myModal').on('hidden.bs.modal', function(){
					$('#myModal').find('#report_button').remove();
				});
	        },
	        progressall: function (e, data) {
	            var progress = parseInt(data.loaded / data.total * 100, 10);
	            $('#progress .progress-bar').css(
	                'width',
	                progress + '%'
	            );

	        }
	    }).prop('disabled', !$.support.fileInput)
	        .parent().addClass($.support.fileInput ? undefined : 'disabled');
	  
	  

	});

	
</script>