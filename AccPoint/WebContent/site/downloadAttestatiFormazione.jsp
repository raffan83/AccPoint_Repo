
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  
 
 

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

 <div class="box box-primary box-solid">
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
       
       	<div class="col-sm-12">
       		<label>Inserisci Codice Fiscale</label>
       	</div>
       	<div class="col-sm-12">      
       	  	
        <input id="cf" name="cf" class="form-control" type="text" style="width:100%">
       			
       	</div>       	
       </div><br>
       
             
       



	   <div>
			
			<a class="btn btn-primary" id="invia"  href="#" >Download Attestato</a>
		</div>
		
		

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

  
</div>

   


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
    
    
    <script type="text/javascript">
 	
    $("#invia").on("click", function(e) {
        e.preventDefault(); // blocca il comportamento predefinito del link
        var cf = $("#cf").val();
        var idCorso = "${corso.id}";
        var url = "downloadAttestatiFormazione.do?action=download&id_corso=" + idCorso + "&cf=" + encodeURIComponent(cf);
        window.location.href = url;
    });


       /*  function downloadAttestato()
        {
				
	
        	 pleaseWaitDiv = $('#pleaseWaitDialog');
       	  pleaseWaitDiv.modal();
       	  var dataObj = {};
       	  dataObj.cf = cf;
       	  $.ajax({
       	    	  type: "POST",
       	    	  url: "gestioneFormazione.do?action=check_cf",
       	    	  data: dataObj,
       	    	  dataType: "json",
       	    	  success: function( data, textStatus) {
       	    		  
       	    		  pleaseWaitDiv.modal('hide');
       	    		  $(".ui-tooltip").remove();
       	    		  if(data.success)
       	    		  { 

       	    			 
       	    			  	
       	    		
       	    		  }else{
       	    			  $('#myModalErrorContent').html(data.messaggio);
       	    			  
       	    			  	$('#myModalError').removeClass();
       	    				$('#myModalError').addClass("modal modal-danger");
       	    				$('#report_button').show();
       	    	  			$('#visualizza_report').show();
       	    				$('#myModalError').modal('show');
       	    			 
       	    		  }
       	    	  },
       	
       	    	  error: function(jqXHR, textStatus, errorThrown){
       	    		  pleaseWaitDiv.modal('hide');
       	
       	    		  $('#myModalErrorContent').html(textStatus);
       	    		  $('#myModalErrorContent').html(data.messaggio);
       	    		  	$('#myModalError').removeClass();
       	    			$('#myModalError').addClass("modal modal-danger");
       	    			$('#report_button').show();
           	  			$('#visualizza_report').show();
       					$('#myModalError').modal('show');
       						
       	    	  }
             });	


        }  */


</script>
  
</jsp:attribute> 
</t:layout>

