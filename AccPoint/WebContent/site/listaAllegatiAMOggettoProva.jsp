<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<div class="row">
<div class="col-sm-12">
 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o pi� file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br>
		   	 
		   	 </div>
		   	 </div>
		   	<%--  </c:if> --%>
<div class="row">
<div class="col-sm-12">
<c:choose>
<c:when test="${lista_allegati_strumento!=null && lista_allegati_strumento.size()>0}">
<ul class="list-group list-group-bordered">
<c:forEach items="${lista_allegati_strumento }" var="allegato">
                <li class="list-group-item">
                <div class="row">
                
	                <div class="col-xs-10">
	                  <b>${allegato.filename }</b>
	                  </div>
	                  <div class="col-xs-2 pull-right"> 	           
	                   
	                  <a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegato('${allegato.id  }','${id_strumento}','0')"><i class="fa fa-trash"></i></a>
	               
	                  <a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="amGestioneStrumenti.do?action=download_allegato&id_allegato=${allegato.id }&id_strumento=${id_strumento}"><i class="fa fa-arrow-down small"></i></a>
	                   
	                  </div>
                  </div>
                </li>
                </c:forEach>
                </ul>
</c:when> 

<c:otherwise>
<ul class="list-group list-group-bordered">
 <li class="list-group-item">

Nessun file allegato allo strumento!
</li>
 </ul>
</c:otherwise>
</c:choose>

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
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_allegato_id">
      <input type="hidden" id="elimina_id_strumento">
      
      <a class="btn btn-primary" onclick="eliminaAllegatoAMStrumento($('#elimina_allegato_id').val(), $('#elimina_id_strumento').val())" >SI</a>
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
 
 <script type="text/javascript">

console.log("test1");


var id_strumento = ${id_strumento};


function eliminaAllegato(id_allegato, id_strumento){
	  
    $('#elimina_allegato_id').val(id_allegato);
    $('#elimina_id_strumento').val(id_strumento);    
    
    $('#myModalYesOrNo').modal();
}


$('#myModalAllegati').on('hidden.bs.modal',function(){
	
	$(document.body).css('padding-right', '0px');
});


$('#fileupload').fileupload({
	 url: "amGestioneStrumenti.do?action=upload_allegati&id_strumento="+id_strumento,
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
			location.reload();
	
				  
				   
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

 </script>
 
 
 