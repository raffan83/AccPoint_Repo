<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoCampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonArray("dataInfo");

Gson gson = new Gson();
StrumentoDTO strumento =(StrumentoDTO)session.getAttribute("strumento");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


%>

<c:if test="${userObj.checkPermesso('CARICAMENTO_DOCUMENTI_ESTERNI_STRUMENTO_METROLOGIA')}">
<div class="row">
<h4>CARICAMENTO DOCUMENTI</h4>
</div>
	<div class="row">
	<c:if test="${userObj.checkRuolo('RS') }">
	<div class="col-xs-4">
			<label>Data Verifica</label>
  		</div>
  		</c:if>
  	<div class="col-xs-4">
			<label>Documento da allegare</label>
  		</div>
  			</div>
	<div class="row">
<c:if test="${userObj.checkRuolo('RS') }">
		<div class="col-xs-4">
 			<input class="form-control datepicker" id="dataVerifica" type="text" name="dataVerifica"  value="" data-date-format="dd/mm/yyyy"/>
  		</div>
  		</c:if>
		    <div class="col-xs-3">
		        <span class="btn btn-primary fileinput-button ">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<!-- <input accept="application/pdf" id="fileupload" type="file" name="files"> -->
		        		 <input accept=".pdf,.xls,.xlsx,.docx,.doc,.jpg,.png" id="fileupload" type="file" name="files">
		   	 </span>
		       
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
	    </div>
		    <div class="col-xs-4">
		       
		        <div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
	    </div>


	</div>
	<div class="row">
<h4>LISTA DOCUMENTI</h4>
</div>
</c:if>		

 <table id="tabDocumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th></th>
 <th>ID</th>
  <th>Nome Documento</th>
 <th>Data Caricamento</th>
	<%-- <c:if test="${userObj.checkPermesso('LISTA_DOCUMENTI_ESTERNI_STRUMENTO_METROLOGIA')}"> --%>

	<th>Azioni</th>
		<%-- </c:if>		 --%>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${strumento.listaDocumentiEsterni}" var="documento" varStatus="loop">
 	<tr role="row" id="${certificatocamp.id}-${loop.index}">
	
		<td></td>
		<td>${documento.id}</td>
		<td>${documento.nomeDocumento}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${documento.dataCaricamento}" /></td>
	
		<td>

		<a href="scaricaDocumentoEsternoStrumento.do?action=scaricaDocumento&idDoc=${documento.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a>
		<c:if test="${userObj.checkPermesso('LISTA_DOCUMENTI_ESTERNI_STRUMENTO_METROLOGIA')}">
		<a href="#" onClick="modalEliminaDocumentoEsternoStrumento(${documento.id})" class="btn btn-danger"><i class="fa fa-remove"></i></a>
			</c:if>		
		</td>
	

	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 

<div id="modalEliminaDocumentoEsternoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare il documento?
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaDocumentoEsternoStrumento()">Elimina</button>
    </div>
  </div>
    </div>

</div>


<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
 <script type="text/javascript">

 
 var columsDatatables = [];
 
	$("#tabDocumenti").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	}
	    $('#tabDocumenti thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        if($(this).index()!= 0){
	        		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	    } );

	} );
 
  
    $(document).ready(function() {
    
    	
    	var strumento_id = <%=strumento.get__id() %>    	
     	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
 		   var datepicker = $.fn.datepicker.noConflict();
 		   $.fn.bootstrapDP = datepicker;
 		}

 	$('.datepicker').bootstrapDP({
 		format: "dd/mm/yyyy",
 	    //startDate: '-3d'
 	});
 	
 	
 	
 	
	$('#fileupload').fileupload({
        url: "scaricaDocumentoEsternoStrumento.do?action=caricaDocumento",
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
            var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx|dxf|dwg|stp|igs|iges|catpart|eml|msg|rar|zip)$/i;
            if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
                uploadErrors.push('Tipo File non accettato. ');
            }
            if(data.originalFiles[0]['size'] > 10000000) {
                uploadErrors.push('File troppo grande, dimensione massima 10mb');
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
        			$('#myModalErrorContent').html("CARICATO CON SUCCESSO <input type='hidden' id='uploadSuccess' value='12'>");
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
	
	
 	$('#fileupload').bind('fileuploadsubmit', function (e, data) {
	    // The example input, doesn't have to be part of the upload form:
	    var date = $('#dataVerifica').val();

	    if(date==null){
	    	date='';
	    }
	    data.formData = {dataVerifica: date, idStrumento: strumento_id};
	    
/* 	    if (!data.formData.dataVerifica) {
	        
	        $('#myModalErrorContent').html("INSERIRE DATA DI VERIFICA");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');
			$('#progress .progress-bar').css(
                    'width',
                    '0%'
                );
	        
	        return false;
	      } */
	   
	}); 
	
 	
    	
    	
   var tableDocumenti = $('#tabDocumenti').DataTable({
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
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      order: [[ 0, "desc" ]],
  	      
  
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	  
  	                         
  	          ]
  	    	
  	      
  	    });
    	
   tableDocumenti.buttons().container().appendTo( '#tabDocumenti_wrapper .col-sm-6:eq(1)');
	    
  
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tableDocumenti = $('#tabDocumenti').DataTable();
  // Apply the search
  tableDocumenti.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableDocumenti.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableDocumenti
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tableDocumenti.columns.adjust().draw();
    	
	
	$('#tabDocumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
  	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});

  	

 
    });

 
  </script>				