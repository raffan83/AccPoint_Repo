<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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

      Scadenzario Verificazione Strumenti

      </h1><br><br>
      
        
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
<div class="row">

	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data Scadenza:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	



</div>


<div class="row">	

	<div class="col-xs-12">
	 <div id="calendario" >
	</div>

	</div>
	
	<input type="hidden" id="data_start">
	<input type="hidden" id="data_end">
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 </div>
</div>


</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<style>
.btn-circle.btn-xl {
    width: 70px;
    height: 70px;
    padding: 10px 16px;
    border-radius: 35px;
    font-size: 24px;
    line-height: 1.33;
}

.btn-circle {
    width: 30px;
    height: 30px;
    padding: 6px 0px;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 1.42857;
}
</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>

<script type="text/javascript">




/* $('#button_export').click(function(){
	
	var start = $('#data_start').val();
	var end = $('#data_end').val();	
	
	$('#button_export').attr("href",'listaCampioni.do?action=campioni_scadenza&data_start='+start+'&data_end='+end);
}); */

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

function filtraDate(){
	
	var tipo_data = $('#tipo_data').val();
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "action=scadenzario&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_data="+tipo_data;
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 
	 	exploreModal("scadenzarioVerificazione.do", dataString, '#calendario');

}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("scadenzarioVerificazione.do");

}




$(document).ready(function() {
	

	 var start = "${dateFrom}";
	  	var end = "${dateTo}";

	  	$('input[name="datarange"]').daterangepicker({
	 	    locale: {
	 	      format: 'DD/MM/YYYY'
	 	    
	 	    }
	 	}, 
	 	function(start, end, label) {

	 	});
	  	
	  	if(start!=null && start!=""){
	 	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
	 	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
	 	
	 	 }
	
	
//	addCalendarVerificazione();
	
	

	});
	
	
</script>
 
</jsp:attribute> 
</t:layout>