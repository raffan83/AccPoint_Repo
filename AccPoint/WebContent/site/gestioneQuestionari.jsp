<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Gestione Questionari Regionali

      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-primary box-solid">
<div class="box-header with-border">
	Questionari regionali
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-xs-2">
			    <span class="btn btn-primary fileinput-button pull-left">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica questionari corso</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<!-- <input accept="application/x-sqlite3,.pdf"  id="fileupload" type="file" name="file"> -->
		        		<input accept=".zip,.ZIP"  id="fileupload" type="file" name="file">
		   	 </span>
		    </div>
		    <div class="col-xs-5">
		        <div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
		    	<label id="caricato_label" style="display:none;color:green"></label>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
		    </div>
			<div class="col-xs-4">
		       <a class="btn btn-success pull-right" onClick="$('#modalYesOrNo').modal()"><i class="fa fa-arrow-up"></i> Carica consuntivo manualmente</a>
	    </div>
	    
	    </div><br><br>
	    
	    <div class="row">
	    <div class="col-xs-4">
	    </div>
	    <div class="col-xs-4">
	    <a class="btn btn-success btn-lg" style="height:50px;width:300px" href="gestioneFormazione.do?action=download_template_questionari"><i class="fa fa-file-excel-o" ></i> Download consuntivo questionari</a>
	    </div>
	    <div class="col-xs-4">
	    </div>
	    </div>

</div>
</div>
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 
</div>
</div>


   <div id="modalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler sovrascrivere il file consuntivo?
      	</div>
      <div class="modal-footer">

        
	               <a class="btn btn-primary" onclick="$('#modalCaricaConsuntivo').modal()" >SI</a>
	                
	   
      
      
		<a class="btn btn-primary" onclick="$('#modalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


   <div id="modalCaricaConsuntivo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega file...</span>
				<input accept=".xls,.xlsx"  id="fileupload_excel" type="file">
		       
		   	 </span>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_allegato_id">
      <input type="hidden" id="elimina_id_strumento">
        
	               <a class="btn btn-primary" onclick="modalCaricaConsuntivo()" >SI</a>
	                
	   
      
      
		<a class="btn btn-primary" onclick="$('#modalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


 
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>
</jsp:attribute>



<jsp:attribute name="extra_js_footer">



<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>

<script type="text/javascript">  
var filename = "";
var pin0;

$('#fileupload').change(function() {
	 
	  var file = $('#fileupload')[0].files[0].name;
	 $('#caricato_label').html(file + " Caricato!");
	});
	
	
	

$(document).ready(function() { 
	

    	 $('#fileupload').fileupload({
            url: "gestioneFormazione.do?action=carica_file_questionari",
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
                 var acceptFileTypes = /(\.|\/)(zip)$/i;
                if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
                    uploadErrors.push('Tipo File non accettato. ');
                } 
                if(data.originalFiles[0]['size'] > 200000000) {
                    uploadErrors.push('File troppo grande, dimensione massima 200mb');
                }
                if(uploadErrors.length > 0) {
                	//$('#files').html(uploadErrors.join("\n"));
                	$('#myModalErrorContent').html(uploadErrors.join("\n"));
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
									
					$('#myModalError').modal('show');
					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
					$('#caricato_label').hide();
					
                }  else {
                    data.submit();
                  
                } 
        	},
            done: function (e, data) {
				
            	pleaseWaitDiv.modal('hide');
            	
            	if(data.result.success)
				{
            		$('#report_button').hide();
	  				$('#visualizza_report').hide();
					filename = data.result.filename;
					  $('#caricato_label').show();

				}else{
					$('#report_button').hide();
	  				$('#visualizza_report').hide();
					$('#myModalErrorContent').html(data.result.messaggio);
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					
					$('#myModalError').modal('show');
					 $('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                ); 
					$('#caricato_label').hide();
	               // $('#files').html("ERRORE SALVATAGGIO");
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
								
				$('#myModalError').modal('show');
			
				$('#progress .progress-bar').css(
	                    'width',
	                    '0%'
	                );
				$('#caricato_label').hide();
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
    	 

    	 
    	 
    	 
    	 
    	 
    	 $('#fileupload_excel').fileupload({
    		 url: "gestioneFormazione.do?action=upload_consuntivo_questionari",
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
    		    	 if(data.originalFiles[i]['size'] > 60000000) {
    			         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 60mb');
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
    		 	$('#modalYesOrNo').modal('hide');
    		 	$('#modalCaricaConsuntivo').modal('hide');
    		 	if(data.result.success){
   
    		 		$('#myModalErrorContent').html(data.result.messaggio);
    				$('#myModalError').removeClass();
    				$('#myModalError').addClass("modal modal-success");
    				$('#myModalError').modal('show');    				
    				
    		
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
    	 
    	 
    	 
    	 


		$('#caricato_label').hide();
	
});

</script>

</jsp:attribute> 
</t:layout>