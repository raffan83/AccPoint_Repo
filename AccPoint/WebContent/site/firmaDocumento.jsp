<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Firma Documento
        <small>Firma un documento digitalmente</small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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
	
	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	Carica documento
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">


<div class="col-xs-2">
			    <span class="btn btn-primary fileinput-button pull-left">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input accept="application/x-sqlite3,.pdf"  id="fileupload" type="file" name="file">
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
		         <button class="btn btn-warning" onClick="openModalPin()"><i class="glyphicon glyphicon-pencil"></i> Firma</button> 
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


       <div id="modalPin" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Inserisci il PIN per la firma digitale</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-3">
			
        <label >Inserisci PIN:</label>
        </div>
        <div class="col-sm-9">
                      <input class="form-control" id="pin" type="password" name="pin"/>
   			 </div>
     		</div><br>

  		 </div>
      <div class="modal-footer">
 		<div class="row">
 		<div class="col-sm-2">
 		<a id="close_button" type="button" class="btn btn-info pull-left" onClick="checkPIN()">Firma</a> 
 		</div>
 		<div class="col-sm-10">
 		
 		<label class="pull-left" id="result_label" style="display:none"></label>
 		</div>
 		</div>
         
         
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>

<script type="text/javascript">  
var filename = "";

$('#fileupload').change(function() {
	 
	  var file = $('#fileupload')[0].files[0].name;
	 $('#caricato_label').html(file + " Caricato!");
	});
	


function openModalPin(){	
	
	if($('#caricato_label').is(":visible") ){	
		
		$('#modalPin').modal();

		}else{
			
			$('#myModalErrorContent').html("Nessun File selezionato!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
							
			$('#myModalError').modal('show');
			$('#progress .progress-bar').css(
	                'width',
	                '0%'
	            );
			$('#caricato_label').hide();
			
		}
	
}


function checkPIN(){
	$('#result_label').hide();
	var pin = $('#pin').val();
	$('#pin').css('border', '1px solid #d2d6de');
	
	if(isNaN(pin)){
		$('#result_label').html("Attenzione! Il PIN deve essere un numero!");
		$('#result_label').css("color", "red");
		$('#pin').css('border', '1px solid #f00');
		$('#result_label').show();
	}
	else if(pin.length!=4){
		$('#result_label').html("Attenzione! Il PIN deve essere di 4 cifre!");
		$('#result_label').css("color", "red");
		$('#pin').css('border', '1px solid #f00');
		$('#result_label').show();
	}	
	else{
		$('#modalPin').modal('toggle');
		verificaPinFirma(pin, filename);
		$('#pin').val("");
	}
	
}

$(document).ready(function() { 
	
		
    	 $('#fileupload').fileupload({
            url: "firmaDocumento.do?action=upload",
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
                var acceptFileTypes = /(\.|\/)(pdf)$/i;
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
					
					$('#myModalErrorContent').html(data.result.messaggio);
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
	  				$('#visualizza_report').show();
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
    	 
	});

 $('#modalPin').on('hidden.bs.modal', function(){
		$('#progress .progress-bar').css(
                'width',
                '0%'
            );
		$('#caricato_label').hide();
	
});

</script>

</jsp:attribute> 
</t:layout>