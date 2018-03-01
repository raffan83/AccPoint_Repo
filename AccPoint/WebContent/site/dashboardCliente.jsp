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
    	
    	
    	//Custom Pie
    	
    	Chart.defaults.pieLabels = Chart.helpers.clone(Chart.defaults.pie);

    		var helpers = Chart.helpers;
    		var defaults = Chart.defaults;

    		Chart.controllers.pieLabels = Chart.controllers.pie.extend({
    			updateElement: function(arc, index, reset) {
    		    var _this = this;
    		    var chart = _this.chart,
    		        chartArea = chart.chartArea,
    		        opts = chart.options,
    		        animationOpts = opts.animation,
    		        arcOpts = opts.elements.arc,
    		        centerX = (chartArea.left + chartArea.right) / 2,
    		        centerY = (chartArea.top + chartArea.bottom) / 2,
    		        startAngle = opts.rotation, // non reset case handled later
    		        endAngle = opts.rotation, // non reset case handled later
    		        dataset = _this.getDataset(),
    		        circumference = reset && animationOpts.animateRotate ? 0 : arc.hidden ? 0 : _this.calculateCircumference(dataset.data[index]) * (opts.circumference / (2.0 * Math.PI)),
    		        innerRadius = reset && animationOpts.animateScale ? 0 : _this.innerRadius,
    		        outerRadius = reset && animationOpts.animateScale ? 0 : _this.outerRadius,
    		        custom = arc.custom || {},
    		        valueAtIndexOrDefault = helpers.getValueAtIndexOrDefault;

    		    helpers.extend(arc, {
    		      // Utility
    		      _datasetIndex: _this.index,
    		      _index: index,

    		      // Desired view properties
    		      _model: {
    		        x: centerX + chart.offsetX,
    		        y: centerY + chart.offsetY,
    		        startAngle: startAngle,
    		        endAngle: endAngle,
    		        circumference: circumference,
    		        outerRadius: outerRadius,
    		        innerRadius: innerRadius,
    		        label: valueAtIndexOrDefault(dataset.label, index, chart.data.labels[index])
    		      },

    		      draw: function () {
    		      	var ctx = this._chart.ctx,
    								vm = this._view,
    								sA = vm.startAngle,
    								eA = vm.endAngle,
    								opts = this._chart.config.options;
    						
    							var labelPos = this.tooltipPosition();
    							var segmentLabel = vm.circumference / opts.circumference * 100;
    							
    							//labelPos.x = labelPos.x * 1.1;
    							//labelPos.y = labelPos.y * 1.1;
    							
    							ctx.beginPath();
    							
    							ctx.arc(vm.x, vm.y, vm.outerRadius, sA, eA);
    							ctx.arc(vm.x, vm.y, vm.innerRadius, eA, sA, true);
    							
    							ctx.closePath();
    							ctx.strokeStyle = vm.borderColor;
    							ctx.lineWidth = vm.borderWidth;
    							
    							ctx.fillStyle = vm.backgroundColor;
    							
    							ctx.fill();
    							ctx.lineJoin = 'bevel';
    							
    							if (vm.borderWidth) {
    								ctx.stroke();
    							}
    							
    							if (vm.circumference > 0.6) { // Trying to hide label when it doesn't fit in segment
    								ctx.beginPath();
    								ctx.font = helpers.fontString(opts.defaultFontSize, opts.defaultFontStyle, opts.defaultFontFamily);
    								ctx.fillStyle = "#818181";
    								ctx.textBaseline = "center";
    								ctx.textAlign = "center";
    		            
    		            // Round percentage in a way that it always adds up to 100%
    								ctx.fillText(segmentLabel.toFixed(2) + "%", labelPos.x, labelPos.y);
    							

    		          }
    		          //display in the center the total sum of all segments
    		        /*   var total = dataset.data.reduce((sum, val) => sum + val, 0);
    		          ctx.fillText('Total = ' + total, vm.x, vm.y-20, 200); */
    		      }
    		    });

    		    var model = arc._model;
    		    model.backgroundColor = custom.backgroundColor ? custom.backgroundColor : valueAtIndexOrDefault(dataset.backgroundColor, index, arcOpts.backgroundColor);
    		    model.hoverBackgroundColor = custom.hoverBackgroundColor ? custom.hoverBackgroundColor : valueAtIndexOrDefault(dataset.hoverBackgroundColor, index, arcOpts.hoverBackgroundColor);
    		    model.borderWidth = custom.borderWidth ? custom.borderWidth : valueAtIndexOrDefault(dataset.borderWidth, index, arcOpts.borderWidth);
    		    model.borderColor = custom.borderColor ? custom.borderColor : valueAtIndexOrDefault(dataset.borderColor, index, arcOpts.borderColor);

    		    // Set correct angles if not resetting
    		    if (!reset || !animationOpts.animateRotate) {
    		      if (index === 0) {
    		        model.startAngle = opts.rotation;
    		      } else {
    		        model.startAngle = _this.getMeta().data[index - 1]._model.endAngle;
    		      }

    		      model.endAngle = model.startAngle + model.circumference;
    		    }

    		    arc.pivot();
    		  }
    		});

    		
    	
    	
    	
    	
    	  
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
    	
    	newArr = [
	         'rgba(255, 99, 132, 0.2)',
	         'rgba(54, 162, 235, 0.2)',
	         'rgba(255, 206, 86, 0.2)',
	         'rgba(75, 192, 192, 0.2)',
	         'rgba(153, 102, 255, 0.2)',
	         'rgba(255, 159, 64, 0.2)',
	         'rgba(255,0,0,0.2)',
	         'rgba(46,46,255,0.2)',
	         'rgba(255,102,143,0.2)',
	         'rgba(255,240,36,0.2)',
	         'rgba(255,54,255,0.2)',
	         'rgba(107,255,235,0.2)',
	         'rgba(255,83,64,0.2)',
	         'rgba(43,255,72,0.2)'
	     ];
    	newArrB = [
	         'rgba(255, 99, 132, 1)',
	         'rgba(54, 162, 235, 1)',
	         'rgba(255, 206, 86, 1)',
	         'rgba(75, 192, 192, 1)',
	         'rgba(153, 102, 255, 1)',
	         'rgba(255, 159, 64, 1)',
	         'rgba(255,0,0,1)',
	         'rgba(46,46,255,1)',
	         'rgba(255,102,143,1)',
	         'rgba(255,240,36,1)',
	         'rgba(255,54,255,1)',
	         'rgba(107,255,235,1)',
	         'rgba(255,83,64,1)',
	         'rgba(43,255,72,1)'
	     ];
    	
    	
    	if(numberBack1>0){
    		
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# Strumenti in Servizio";
    		
    		
    		
    		
    		
    			dataset1.backgroundColor = [];
    			dataset1.borderColor = [];
    		for (i = 0; i < numberBack1; i++) {
    			
    			
    			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArr);
    			dataset1.borderColor = dataset1.borderColor.concat(newArrB);
    		}
    		dataset1.borderWidth = 1;
    		var itemHeight1 = 200;
    		var total = 0;
    		$.each(statoStrumentiJson, function(i,val){
    			grafico1.labels.push(i);
    			dataset1.data.push(val);
    			total += val;
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
    				typeChart1 = "pieLabels";
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
    		    	 tooltips: {
    		    		 callbacks: {
    		    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
    		    		      // data : the chart data item containing all of the datasets
    		    		      label: function(tooltipItem, data) {
    		    		    	  var value = data.datasets[0].data[tooltipItem.index];
    		                      var label = data.labels[tooltipItem.index];
    		                      var percentage =  value / total * 100;
    		                      console.log(total);
    		                      
    		                      return label + ' ' + value + ' ' + percentage.toFixed(2) + '%';

    		    		      }
    		    		    }
    		    		  } 
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
    		    	 scaleShowValues: true,
	    		    	 scales: {
		    		    	 yAxes: [{
			    		    	 ticks: {
			    		    		 beginAtZero: true
			    		    	 }
		    		    	 }],
		    		    	 xAxes: [{
			    		    	 ticks: {
			    		    	 	autoSkip: false
			    		    	 }
		    		    	 }]
	    		    	 }    
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
    			
    			
    			dataset4.backgroundColor = dataset4.backgroundColor.concat(newArr);
    			dataset4.borderColor = dataset4.borderColor.concat(newArrB);
    		}
    		

    		dataset4.borderWidth = 1;
    		var itemHeight4 = 200;
		var total = 0;
    		$.each(freqStrumentiJson, function(i,val){
    			grafico4.labels.push(i);
    			dataset4.data.push(val);
    			total += val;
    			itemHeight4 += 12;
    		}); 
    		//$(".grafico4  .chart").height(itemHeight4);

  
    			
    		
    		 grafico4.datasets = [dataset4];
    		 
    		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

    		 if(myChart4!= null){
    			 myChart4.destroy();
    		 }
    		 var typeChart4 = "";
    			 
    				typeChart4 = "pieLabels";
    				$('#grafico4').addClass("col-lg-6");
    		 
    		  myChart4 = new Chart(ctx4, {

    		     type: typeChart4,
    		     data: grafico4,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: true,
    		    	 tooltips: {
    		    		 callbacks: {
    		    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
    		    		      // data : the chart data item containing all of the datasets
    		    		      label: function(tooltipItem, data) {
    		    		    	  var value = data.datasets[0].data[tooltipItem.index];
    		                      var label = data.labels[tooltipItem.index];
    		                      var percentage =  value / total * 100;
    		                      console.log(total);
    		                      console.log(Object.keys(freqStrumentiJson).length);
    		                      return label + ' ' + value + ' ' + percentage.toFixed(2) + '%';

    		    		      }
    		    		    }
    		    		  } 
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


