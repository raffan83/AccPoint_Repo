<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%-- <c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_VER_STRUMENTI') }">  --%>

<div class="row">
<div class="col-sm-12">
 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br>
		   	 
		   	 </div>
		   	 </div>
		   	<%--  </c:if> --%>
<div class="row">
<div class="col-sm-12">
<c:choose>
<c:when test="${lista_allegati!=null && lista_allegati.size()>0}">
<ul class="list-group list-group-bordered">
<c:forEach items="${lista_allegati }" var="allegato">
                <li class="list-group-item">
                <div class="row">
                
	                <div class="col-xs-10">
	                  <b>${allegato.nome_file }</b>
	                  </div>
	                  <div class="col-xs-2 pull-right"> 	           
	               
	                    <a class="btn btn-danger btn-xs pull-right" onClick="modalEliminaDevAllegato('${allegato.id  }')"><i class="fa fa-trash"></i></a>
	                  <a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="gestioneDevice.do?action=download_allegato&id_allegato=${allegato.id }&id_device=${id_device}&id_software=${id_software}"><i class="fa fa-arrow-down small"></i></a>
	                  </div>
                  </div>
                </li>
                </c:forEach>
                </ul>
</c:when> 

<c:otherwise>
<ul class="list-group list-group-bordered">
 <li class="list-group-item">

Nessun file allegato presente!
</li>
 </ul>
</c:otherwise>
</c:choose>

 </div>
 </div>
 
 
   <div id="myModalYesOrNoAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index:9999">
   
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
      <input type="hidden" id="elimina_allegato_id">
      <input type="hidden" id="elimina_id_strumento">
      
       <c:if test="${allegati_software == 1 }">    
	               <a class="btn btn-primary" onclick="eliminaDevAllegato($('#elimina_allegato_id').val(),null, ${id_software})" >SI</a>
	                  </c:if> 
	                  
	                   <c:if test="${allegati_device == 1 }">    
	                   <a class="btn btn-primary" onclick="eliminaDevAllegato($('#elimina_allegato_id').val(), ${id_device}, null)" >SI</a>
	                  </c:if> 
      
      
		<a class="btn btn-primary" onclick="$('#myModalYesOrNoAllegati').modal('hide')" >NO</a>
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

console.log("test1");


function modalEliminaDevAllegato(id_allegato){
	  
    $('#elimina_allegato_id').val(id_allegato);
    
    $('#myModalYesOrNoAllegati').removeClass('modal-fullscreen')
    
    $('#myModalYesOrNoAllegati').modal();
}


$('#myModalAllegati').on('hidden.bs.modal',function(){
	
	$(document.body).css('padding-right', '0px');
});


if(${id_device!=null}){
	var url = "gestioneDevice.do?action=upload_allegati&id_device=${id_device}"	
}else{
	var url = "gestioneDevice.do?action=upload_allegati&id_software=${id_software}"
}



$('#fileupload').fileupload({
	 url: url,
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
				
				
				if(${id_device!=null}){
					exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device=${id_device}","#lista_allegati");
				}else{
					exploreModal("gestioneDevice.do","action=lista_allegati_software&id_software=${id_software}","#content_allegati");
				}
				
			   $('.modal-backdrop').hide()    	
				   
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



function eliminaDevAllegato(id_allegato, id_device, id_software ){
	
	dataObj = {};
	dataObj.id_allegato = id_allegato;
	
	if(id_device!=null){		
		dataObj.id_device = id_device;		
	}else{
		dataObj.id_software = id_software;		
	}
	
	callAjax(dataObj, "gestioneDevice.do?action=elimina_allegato", function(data, textStatus){
		
		 $('#report_button').hide();
			$('#visualizza_report').hide();
		  $("#modalNuovoReferente").modal("hide");
		  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
		$('#myModalError').on('hidden.bs.modal', function(){	         			
			
			$('#modalNuovaProcedura').hide();
			if(id_device!=null){
				exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device="+id_device,"#lista_allegati");
			}else{
				exploreModal("gestioneDevice.do","action=lista_allegati_software&id_software="+id_software,"#content_allegati");
			}
			
		   $('.modal-backdrop').hide()    	   
		    
		});
		
	});
	
}



 </script>
 
 
 