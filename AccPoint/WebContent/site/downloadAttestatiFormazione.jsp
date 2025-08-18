
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  
 
 
<t:main-header  />
  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
   
    <section class="content-header">
          <h1 class="pull-left">
        Download Attestato Corso: ${corso.descrizione } 
        <small></small>
      </h1>

    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">
	
	<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Documenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


</div>

</div><br>

<div class="row">
<div class="col-sm-12">



<form id="uploadDocumento" name="uploadDocumento">

   
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
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento" name="numero_documento" class="form-control" type="text" style="width:100%" >
       			
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
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
			<textarea id="note" name="note" rows="4" class="form-control" style="width:100%"></textarea>
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
       



	   <div>
			
			<button class="btn btn-primary" id="invia" type="submit"  >Salva</button>
		</div>
		
		
		<input type="hidden" id="id_documento" name ="id_documento" value="${documento}" style="width:200px;" >
	   

</form>



</div>
</div>


</div>

 
</div>
</div>
</div>

	
	

</section>
</div>


       <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabelHeader">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
 
        <button  type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>

        <button style="display:none" type="button" class="btn btn-outline" id="report_button" data-dismiss="modal" onClick="sendReport($(this).parents('.modal'))">Invia Report</button>
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
<link type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />


<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

 <script  src="https://code.jquery.com/jquery-3.5.1.slim.min.js"  integrity="sha256-4+XzXVhsDmqanXGHaHvgh1gMQKX40OUvDEBTu8JcmNs="  crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
    <script type="text/javascript">
 	
	$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
 
 $('#uploadDocumento').on('submit', function(e){
	
	e.preventDefault();
	
	SendCustomerData();
 });
        function SendCustomerData()
        {
				
		  var form = $('#uploadDocumento')[0]; 
		  var formData = new FormData(form);
		 
		  var id_documento = $('#id_documento').val();
    $.ajax({
  	  type: "POST",
  	 // url: "http://portale.ecisrl.it/FormInputDoc/uploadDocumento.do",
  	  url: "http://localhost:8080/FormInputDoc/uploadDocumento.do",
  	  data: formData,
  	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
  	  processData: false, // NEEDED, DON'T OMIT THIS
  	  success: function( data, textStatus) {
  	
  		  	      		  
  		  if(data.success)
  		  { 
				$('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-success");
  				$('#report_button').hide();
  				$('#visualizza_report').hide();
					$('#myModalError').modal('show');	
					
  		
  		  }else{
  			  $('#myModalErrorContent').html(data.messaggio);
  			  	$('#myModalError').removeClass();
  				$('#myModalError').addClass("modal modal-danger");
  				$('#report_button').hide();
  				$('#visualizza_report').hide();
					$('#myModalError').modal('show');	      			 
  		  }
  	  },

  	  error: function(jqXHR, textStatus, errorThrown){
  		

  		  $('#myModalErrorContent').html("Errore nell'upload! Timeout connessione!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').hide();
  				$('#visualizza_report').hide();
				$('#myModalError').modal('show');
				
  
  	  }
    });
				


        } 


</script>
  
</jsp:attribute> 
</t:layout>

