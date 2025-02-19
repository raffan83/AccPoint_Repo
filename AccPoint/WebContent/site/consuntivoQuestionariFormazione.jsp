<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Consuntivo Questionari
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
<div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Cosnuntivo questionari
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

         <div class="row">
         	<div class="col-xs-2">
			 
				 <label  class="control-label">Scegli filtro:</label>
					<select class="form-control select2" id="filtro" name="filtro" data-placeholder="Scegli filtro corsi...">
					<option value=""></option>
					<option value="data">Data Inizio</option>
					<option value="commessa">Commessa</option>
		
					</select>						
			 </div>	

	<div class="col-xs-5" id="content_filtro_date" style="display:none">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data:</label>
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
		<div id="content_filtro_commessa" style="display:none">
			 	<div class="col-xs-3" >
				 <label class="control-label">Filtra Commessa:</label>
					<select class="form-control select2" id="commessa" name="commessa" style="width:100%">
					<option value=""></option>
					<c:forEach items="${lista_commesse }" var="comm">
					        <option value="${comm.ID_COMMESSA }">${comm.ID_COMMESSA }</option>
					</c:forEach>
					</select>	
					
							
							
			 </div>	
			 <div class="col-xs-2" >
		
<button type="button" class="btn btn-info " style="margin-top:25px" onclick="filtraCommesse()">Cerca</button>	
</div>
	</div>

</div><br>



<div id="content_consuntivo"></div>
	     
    
    <br>

</div>
</div>
</div>
       
 </div>


          
   
        

</div>
</div>
</div>
 </div> 
</section>
</div>



  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>


<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>

  <script src="plugins/datatables-rowsgroup/dataTables.rowsGroup.js"></script>
  
 <script type="text/javascript">
 
 $('#filtro').change(function(){
	
	 $('#content_consuntivo').html("")
	 if($(this).val()=="data"){
		 $('#content_filtro_date').show();
		 $('#content_filtro_commessa').hide();
		 
		 
	 }else{
		 $('#content_filtro_date').hide();
		 $('#content_filtro_commessa').show();
	 }
	 
 })
 
 

 function filtraDate(){
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "action=consuntivo_questionari_table&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD');
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 //	callAction("gestioneFormazione.do?"+ dataString, false,true);

	 	exploreModal("gestioneFormazione.do", dataString, '#content_consuntivo');
	}

 
 function filtraCommesse(){
		
	 if($('#commessa').val()!=null){
			
		 	dataString = "action=consuntivo_questionari_table&commessa=" + $('#commessa').val();
		 	
		 	 pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();

		 //	callAction("gestioneFormazione.do?"+ dataString, false,true);

		 	exploreModal("gestioneFormazione.do", dataString, '#content_consuntivo');
	 }

	}




	function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("gestioneFormazione.do?action=consuntivo_questionari");

	}
 
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
        $('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 });    
        
        $('.select2').select2();

        
        
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
    	
    	
    });
    
    
	
    function formatDate(data){
    	
    	   var mydate =  Date.parse(data);
    	   
    	   if(!isNaN(mydate.getTime())){
    	   
    		var   str = mydate.toString("dd/MM/yyyy");
    	   }			   
    	   return str;	 		
    }
  </script>
  
</jsp:attribute> 
</t:layout>

