<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@ page language="java" import="java.util.ArrayList" %>
 <%@page import="com.google.gson.Gson"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
      
     <section class="content-header">
      <h1>
        Dashboard
        <small></small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="/"><i class="fa fa-dashboard"></i> Home</a></li>
       </ol>
    </section>
     	 <section class="content">
			<div class="row">
			 <div id="grafici">
					
			 
			 
			<div class="row">
				<div class="col-md-6 grafico1">
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">NUMERO STRUMENTI IN SERVIZIO/FUORI SERVIZIO</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="grafico1"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div> 
			 
				</div>
				<div class="col-md-6 grafico2" >
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">NUMERO STRUMENTI PER TIPOLOGIA</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="grafico2"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div> 
			 
				</div>
					</div>
				<div class="row">
				

				<div class="col-md-6 grafico4">
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">NUMERO STRUMENTI PER FREQUENZA TARATURA</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="grafico4"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div> 
			 
				</div>
				
					<div class="col-md-6 grafico5">
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">NUMERO STRUMENTI PER REPARTO</h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="grafico5"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div> 
			 
				</div>
				</div>
			
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>

<script type="text/javascript">


    $(document).ready(function() { 
    	  
    	  var myChart1 = null;
    	  var myChart2 = null;
    	  var myChart3 = null;
    	  var myChart4 = null;
    	  var myChart5 = null;
    	  var myChart6 = null;
    	//Grafici

    	var statoStrumentiJson = ${statoStrumentiJson};
    	var tipoStrumentiJson = ${tipoStrumentiJson};
    	var denominazioneStrumentiJson = ${denominazioneStrumentiJson};
    	var freqStrumentiJson = ${freqStrumentiJson};
    	var repartoStrumentiJson = ${repartoStrumentiJson};
    	var utilizzatoreStrumentiJson = ${utilizzatoreStrumentiJson};

    	/* GRAFICO 1*/

    	numberBack1 = Math.ceil(Object.keys(statoStrumentiJson).length/6);
    	

    	
    	
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# Strumenti in Servizio";
    		
    		
    		
    		
    		
    			dataset1.backgroundColor = [];
    			dataset1.borderColor = [];
    		for (i = 0; i < numberBack1; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArr);
    			dataset1.borderColor = dataset1.borderColor.concat(newArrB);
    		}
    		dataset1.borderWidth = 1;
    		var itemHeight1 = 200;
    		$.each(statoStrumentiJson, function(i,val){
    			grafico1.labels.push(i);
    			dataset1.data.push(val);
    			itemHeight1 += 12;
    		});
    		//$(".grafico1 .chart").height(itemHeight1);
    		 grafico1.datasets = [dataset1];
    		 
    		 var ctx1 = document.getElementById("grafico1").getContext("2d");;
    		
    		 if(myChart1!= null){

    			 myChart1.destroy();
    		 }
    		 	var typeChart1 = "";
    			if(Object.keys(statoStrumentiJson).length<5){
    				typeChart1 = "pie";
    				$('#grafico1').addClass("col-lg-6");
    			}else{
    				typeChart1 = "bar";	
    				$('#grafico1').removeClass("col-lg-6");
    			
    			}
    		  myChart1 = new Chart(ctx1, {
    		     type: typeChart1,
    		     data: grafico1,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: true,
    		         
    		     }
    		 });
    	 
    	}else{
    		if(myChart1!= null){
    		 	myChart1.destroy();
    		 }
    	}
    	 /* GRAFICO 2*/
    	 
    	 numberBack2 = Math.ceil(Object.keys(tipoStrumentiJson).length/6);
    	 if(numberBack2>0){
    		 
    	 
    		grafico2 = {};
    		grafico2.labels = [];
    		 
    		dataset2 = {};
    		dataset2.data = [];
    		dataset2.label = "# Strumenti per Tipologia";
    		
    		
     		dataset2.backgroundColor = [ ];
    		dataset2.borderColor = [ ];
    		for (i = 0; i < numberBack2; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset2.backgroundColor = dataset2.backgroundColor.concat(newArr);
    			dataset2.borderColor = dataset2.borderColor.concat(newArrB);
    		}
    		

    		dataset2.borderWidth = 1;
    		var itemHeight2 = 200;

    		$.each(tipoStrumentiJson, function(i,val){
    			grafico2.labels.push(i);
    			dataset2.data.push(val);
    			itemHeight2 += 12;

    		});
    		//$(".grafico2 .chart").height(itemHeight2);
    		 grafico2.datasets = [dataset2];
    		 
    		 var ctx2 = document.getElementById("grafico2").getContext("2d");;
    		 
    		 if(myChart2!= null){
    			 myChart2.destroy();
    		 }
    			var typeChart2 = "";
    			if(Object.keys(tipoStrumentiJson).length<5){
    				typeChart2 = "pie";
    				$('#grafico2').addClass("col-lg-6");
    			}else{
    				typeChart2 = "bar";	
    				$('#grafico2').removeClass("col-lg-6");
    			
    			}
    		  myChart2 = new Chart(ctx2, {
    		     type: typeChart2,
    		     data: grafico2,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: true,
    		          
    		     }
    		 });
    	 
    	 }else{
    		 if(myChart2!= null){
    			 myChart2.destroy();
    		 }
    	 }
    	 
    
    	 
     /* GRAFICO 4*/
    	 
    	 numberBack4 = Math.ceil(Object.keys(freqStrumentiJson).length/6);
    	 if(numberBack4>0){
    		 
    	 
    		grafico4 = {};
    		grafico4.labels = [];
    		 
    		dataset4 = {};
    		dataset4.data = [];
    		dataset4.label = "# Strumenti per Frequenza";
    		
    		
     		dataset4.backgroundColor = [ ];
    		dataset4.borderColor = [ ];
    		for (i = 0; i < numberBack4; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset4.backgroundColor = dataset4.backgroundColor.concat(newArr);
    			dataset4.borderColor = dataset4.borderColor.concat(newArrB);
    		}
    		

    		dataset4.borderWidth = 1;
    		var itemHeight4 = 200;

    		$.each(freqStrumentiJson, function(i,val){
    			grafico4.labels.push(i);
    			dataset4.data.push(val);
    			itemHeight4 += 12;
    		});
    		//$(".grafico4  .chart").height(itemHeight4);

    		
    		 grafico4.datasets = [dataset4];
    		 
    		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

    		 if(myChart4!= null){
    			 myChart4.destroy();
    		 }
    		 var typeChart4 = "";
    			 
    				typeChart4 = "pie";
    				$('#grafico4').addClass("col-lg-6");
    		 
    		  myChart4 = new Chart(ctx4, {

    		     type: typeChart4,
    		     data: grafico4,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: true,
    		         
    		     }
    		 });
    	 
    	 }else{
    		 if(myChart4!= null){
    			 myChart4.destroy();
    		 }
    	 }
    	 
     /* GRAFICO 5*/
    	 
    	 numberBack5 = Math.ceil(Object.keys(repartoStrumentiJson).length/6);
    	 if(numberBack5>0){
    		 
    	 
    		grafico5 = {};
    		grafico5.labels = [];
    		 
    		dataset5 = {};
    		dataset5.data = [];
    		dataset5.label = "# Strumenti per Reparto";
    		

     		dataset5.backgroundColor = [ ];
    		dataset5.borderColor = [ ];
    		for (i = 0; i < numberBack5; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset5.backgroundColor = dataset5.backgroundColor.concat(newArr);
    			dataset5.borderColor = dataset5.borderColor.concat(newArrB);
    		}
    		

    		dataset5.borderWidth = 1;
    		var itemHeight5 = 200;
    		$.each(repartoStrumentiJson, function(i,val){
    			grafico5.labels.push(i);
    			dataset5.data.push(val);
    			itemHeight5 += 12;
    		});
    		$(".grafico5  .chart").height(itemHeight5);

    		
    		 grafico5.datasets = [dataset5];
    		 
    		 var ctx5 = document.getElementById("grafico5").getContext("2d");;
    		

    		 if(myChart5!= null){
    			 myChart5.destroy();
    		 }
    		 var typeChart5 = "";
    			if(Object.keys(repartoStrumentiJson).length<5){
    				typeChart5 = "pie";
    				$('#grafico5').addClass("col-lg-6");
    			}else{
    				typeChart5 = "horizontalBar";	
    				$('#grafico5').removeClass("col-lg-6");
    			}
    		  myChart5 = new Chart(ctx5, {

    		     type: typeChart5,
    		     data: grafico5,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: false,
    		          
    		     }
    		 });
    	 
    	 }else{
    		 if(myChart5!= null){
    			 myChart5.destroy();
    		 }
    	 }
    	 if(	numberBack1==0){
    		 $(".grafico1").hide();
    	 } 
    	 
    	 if(numberBack2==0){
    		 $(".grafico2").hide();
    	 } 
    	 
    	 if(numberBack4==0){
    		 $(".grafico4").hide();
    	 }
    	 if(numberBack5==0){ 
    		 $(".grafico5").hide();
    	 }
    
    	 
    	 if(	numberBack1==0 && numberBack2==0 && numberBack4==0 && numberBack5==0){
    		 $(".boxgrafici").hide();
    		 
    	 }else{
    		 $(".boxgrafici").show();
    	 }
    	 
    	
    	
    	
});


		
    
</script>
</jsp:attribute> 
</t:layout>


