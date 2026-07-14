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
        Andamento temporale
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">


              <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Andamento temporale
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 
<div class="row">
<div class="col-xs-4">
<label>Lista Misure</label>
<select id="select_misura" name="select_misura" class="form-control select2"  data-placeholder="Seleziona Misura...">
<option value=""></option>
<c:forEach items="${lista_misure }" var="misura" varStatus="loop">
<option value="${misura.id }"><fmt:formatDate pattern="dd/MM/yyyy" value="${misura.dataMisura}"/></option>
</c:forEach>

</select>

</div>
<div class="col-xs-4">
<label>Tipo Prova</label>
<select id="select_tabella" name="select_tabella" class="form-control select2" disabled data-placeholder="Seleziona Tipo Prova...">

</select>

</div>
<div class="col-xs-2">

<a class="btn btn-primary" style="margin-top:25px" onClick="addGrafico()">Aggiungi grafico</a>
</div>
<div class="col-xs-2">

<a class="btn btn-primary pull-right" style="margin-top:25px"  onClick="resetGrafico()">Reset grafico</a>
</div>
</div>
<div class="row">
<div class="grafico">
        
         <canvas id="grafico1" style="height:200"></canvas>
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 </div>
</div>



<c:if test="${tipoRapporto == 'SVT'}">


<c:set var="indiciJson">
[
  <c:forEach items="${indiciPrestazioni}" var="item" varStatus="loop">
    {
      "id": ${item.misura.id},
      "data": "${item.misura.dataMisura}",
      "indice": ${item.indice}
    }${!loop.last ? ',' : ''}
  </c:forEach>
]
</c:set>

<c:set var="indiciMaxJson">
[
  <c:forEach items="${listaindiciPrestazioniMax}" var="item" varStatus="loop">
    {
      "id": ${item.misura.id},
      "data": "${item.misura.dataMisura}",
      "indice": ${item.indice}
    }${!loop.last ? ',' : ''}
  </c:forEach>
]
</c:set>



<div class="row" style="margin-top:20px;">
  <div class="col-xs-12">
    <div class="box box-danger box-solid">
      <div class="box-header with-border">
        Andamento indice di prestazione D nel tempo
        <div class="box-tools pull-right">
          <button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
        </div>
      </div>
      <div class="box-body">

        <div class="row" style="margin-bottom:15px;">
          <div class="col-xs-12">
            <a class="btn btn-primary"  onClick="mostraIndiceD()">
              <i class="fa fa-line-chart"></i> Mostra andamento indice D
            </a>
          </div>
        </div>

        <!-- grafico nascosto finché non si clicca il tasto -->
        <div id="container_indiceD" style="display:none;">

  <!-- legenda soglie -->
  <div style="margin-bottom:10px; display:flex; gap:15px; align-items:center; flex-wrap:wrap;">
    <span style="font-weight:bold;">Legenda:</span>
    <span>
      <span style="display:inline-block; width:7px; height:7px; background:green; border-radius:50%; vertical-align:middle; margin-right:4px;"></span>
      <strong>Performante</strong>  D &lt; 0.25
    </span>
    <span>
      <span style="display:inline-block; width:7px; height:7px; background:yellow; border-radius:50%; vertical-align:middle; margin-right:4px;"></span>
      <strong>Stabile</strong>  0.25 &lt; D &lt; 0.75
    </span>
    <span>
      <span style="display:inline-block; width:7px; height:7px; background:orange; border-radius:50%; vertical-align:middle; margin-right:4px;"></span>
      <strong>Non conforme</strong>  D &gt; 0.75
    </span>
    <span style="margin-left:20px; border-left:1px solid #ccc; padding-left:15px;">

      <span style="display:inline-block; width:9px; height:9px; background:black; border-radius:50%; vertical-align:middle; margin-right:4px;"></span>
      Indice D medio
    </span>
    <span>
    <svg width="10" height="10" style="vertical-align:middle; margin-right:4px;">
  <polygon points="5,0 10,10 0,10" fill="black"/>
</svg>
      Indice D max <em style="font-size:11px; color:black">(clicca per dettaglio)</em>
    </span>
    <span>
      <span style="display:inline-block; width:20px; height:2px; background:#E6331A; vertical-align:middle; margin-right:4px; border-top: 2px dashed #E6331A;"></span>
      Limite accettabilità (D=1)
    </span>
  </div>

  <div style="position:relative; height:350px; width:100%;">
    <canvas id="graficoIndiceD"></canvas>
  </div>
</div>

      </div>
    </div>
  </div>
</div>
</c:if>

<!-- Modale dettaglio punto -->
<div class="modal modal-default fade" id="modalDettaglioPunto" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
        <h4 class="modal-title" id="modalDettaglioTitolo">Dettaglio misura</h4>
      </div>
      <div class="modal-body">
        <div id="containerTabellePunti">
          <!-- popolato dinamicamente -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
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
 <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!--   <script type="text/javascript" src="js/customCharts.js"></script> -->
<!--   <script src="path/to/chartjs/dist/chart.min.js"></script> -->
<script src="https://hammerjs.github.io/dist/hammer.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-zoom/1.0.1/chartjs-plugin-zoom.min.js"></script>
<!-- <script src="path/to/chartjs-plugin-zoom/dist/chartjs-plugin-zoom.min.js"></script> -->

  
 <script type="text/javascript">
 
 function resetGrafico(){
	 
	 $('#select_tabella').siblings(".select2-container").css('border', '0px solid #f00');
	 $('#select_misura').siblings(".select2-container").css('border', '0px solid #f00');
	 
	 $('#select_misura').val("");
	 $('#select_misura').change();
	 
	 $('#select_tabella').val("");
	 $('#select_tabella').change();	 
	 
	 $('#select_tabella').prop('disabled', true);
	 if(myLineChart!=null){
		 myLineChart.destroy();	 
		 myLineChart = null;
	 }
	 
 }

 
 
 
 $('#select_misura').change(function(){
	
	 var id = $(this).val();
	 $('#select_misura').siblings(".select2-container").css('border', '0px solid #f00');
	 
	 dataObj={}
	 
	 if(id!=''){
		 $.ajax({
			  type: "POST",
			  url: "dettaglioMisura.do?action=select_tabella&id_misura="+id,
			  data: dataObj,
			  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
		 	  processData: false, // NEEDED, DON'T OMIT THIS
			  success: function( data, textStatus) {
				  
				  var data = JSON.parse(data);
				  punti = data.listaPuntiJson;
				  var opt = []
				  opt.push('<option value=""></option>');
				  opt.push('<option value="0">TUTTE</option>');
				  for (var i = 0; i < data.listaPuntiJson.length; i++) {
					  var totPunti =  data.listaPuntiJson[i].length;
					  if(data.listaPuntiJson[i][0].tipoProva.startsWith('L')){
						  opt.push('<option value="'+(i+1)+'">LINEARITÀ '+totPunti+' PUNTI ['+(i+1)+']</option>');
					  }else if(data.listaPuntiJson[i][0].tipoProva.startsWith('R')){
						  opt.push('<option value="'+(i+1)+'">RIPETIBILITÀ '+totPunti+' PUNTI ['+(i+1)+']</option>');
					  }
					  

				}
				  var val = $('#select_tabella').val()
				  $('#select_tabella').prop('disabled', false);
					 $('#select_tabella').html(opt);
					 $('#select_tabella').select2();
					 if(val== null || val==''){
						 $('#select_tabella').val("");	 
					 }else{
						 $('#select_tabella').val(val);
						 $('#select_tabella').prop('disabled', true);
					 }
					 
					 $('#select_tabella').change()
				  
			  },

			  error: function(jqXHR, textStatus, errorThrown){
				  pleaseWaitDiv.modal('hide');

				  $('#myModalErrorContent').html(textStatus);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
						$('#visualizza_report').show();
					$('#myModalError').modal('show');

			  }
		 });
	 }
	 
	 
	
 });
 
 
 $('#select_tabella').change(function(){


 }) ;
 
 
 function addGrafico(){
	 
	 var id_tabella = $('#select_tabella').val();
	
	 if(id_tabella!=null && id_tabella!=''){
		 var id_misura = $('#select_misura').val();
		 $('#select_tabella').prop('disabled', true);

		  newArr = ['#FF6633', '#FFB399', '#FF33FF',  '#00B3E6', 
			  '#E6B333', '#3366E6', '#999966', '#99FF99', '#B34D4D',
			  '#80B300', '#809900', '#E6B3B3', '#6680B3', '#66991A', 
			  '#FF99E6', '#CCFF1A', '#FF1A66', '#E6331A', '#33FFCC',
			  '#66994D', '#B366CC', '#4D8000', '#B33300', '#CC80CC', 
			  '#66664D', '#991AFF', '#E666FF', '#4DB3FF', '#1AB399',
			  '#E666B3', '#33991A', '#CC9999', '#B3B31A', '#00E680', 
			  '#4D8066', '#809980', '#E6FF80', '#1AFF33', '#999933',
			  '#FF3380', '#CCCC00', '#66E64D', '#4D80CC', '#9900B3', 
			  '#E64D66', '#4DB380', '#FF4D4D', '#99E6E6', '#6666FF'];
		
		newArrB = [		    		         
	         'rgba(54, 162, 235, 1)',
	         'rgba(255,99,132,1)',
	         'rgba(255, 206, 86, 1)',
	         'rgba(75, 192, 192, 1)',
	         'rgba(153, 102, 255, 1)',
	         'rgba(255, 159, 64, 1)'
	     ]; 
		 
		 var dataset = {
				 label : "MISURA DEL "+$( "#select_misura option:selected" ).text(),
				 backgroundColor : newArr[$('#select_misura')[0].selectedIndex],
		 		 borderColor : newArr[$('#select_misura')[0].selectedIndex]
		 
		 };
		 dataset.data = []
		 var labels = [];
		 for (var i = 0; i < punti.length; i++) {
			for (var j = 0; j < punti[i].length; j++) {
				if(id_tabella== 0 || punti[i][j].id_tabella == id_tabella){
					if(punti[i][j].tipoProva.startsWith('L')){
						var val = punti[i][j].valoreStrumento;
					}else{
						var val = punti[i][j].valoreMedioStrumento;	
					}
					
					var label = punti[i][j].tipoVerifica;
					dataset.data.push(val);
					labels.push(label)	
				}
				
			}
		}
		 
		var x = [];
		x.push(dataset)

		 var data = {
				  labels: labels,
				  datasets: x
				};

				var options = {
				    animation: false,
				    ///Boolean - Whether grid lines are shown across the chart
				    scaleShowGridLines : true,
				    //Boolean - Whether to show vertical lines (except Y axis)
				    scaleShowVerticalLines: true,
				    showTooltips: false,
				    type: "line",
				    data: data,
				    options: {
	   		    	 responsive: true, 
	   		    	 maintainAspectRatio: true,
	   		    	 scales: {
	   		    	        yAxes: [{
	   		    	            ticks: {
	   		    	                beginAtZero: false
	   		    	            }
	   		    	        }],
	   		    	        xAxes: [{
	   		    	            ticks: {
	   		    	                autoSkip: true
	   		    	            }
	   		    	        }]
	   		    	    },
			 plugins: {
			      zoom: {
			        zoom: {
			          wheel: {
			            enabled: true,
			          },
			          pinch: {
			            enabled: true
			          },
			          mode: 'y',
			        },
			        pan: {
			        	enabled: true,
			        	mode : 'xy'
			        	
			        }
			      },
			      
			      tooltip:{
			    	  
			    	   callbacks: {
		    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
		    		      // data : the chart data item containing all of the datasets
		    		      label: function(tooltipItem, data) {
		    		    	  
		    		    	 var label = tooltipItem.dataset.label;
		    		    	var index = tooltipItem.dataIndex;	 			    		    	
		    		    	  	 			    		    	  
		    		    	  return label +": " + tooltipItem.dataset.data[index]

		    		      }
		    		    } 
			    	  
			    	  
			      }
	   		    	    
	   		    	    
	   		    	    
			    }
	   		     }
				};

				var ctx = document.getElementById("grafico1").getContext("2d");
				
				if(myLineChart == null){
					myLineChart = new Chart(ctx, options);	
				}else{
					myLineChart.data.datasets.push(dataset)
					
					
					myLineChart.update();
				}
	 }else{
		 
		 
		 if($('#select_misura').val()==null || $('#select_misura').val()==''){
			 //$('#select_misura').css('border', '1px solid #f00');
			 $('#select_misura').siblings(".select2-container").css('border', '1px solid #f00');
		 }
		 
		 $('#select_tabella').css('border', '1px solid #f00');
		 $('#select_tabella').siblings(".select2-container").css('border', '1px solid #f00');
		 
	 }
	
	 
	
			 
	 
	 
 }
 
 var chartIndiceD = null;

 function mostraIndiceD() {
	  var indiciData    = ${indiciJson};
	  var indiciMaxData = ${indiciMaxJson};   


	  var labels = indiciData.map(function(item) {
		    return item.data.split(' ')[0];
		});
	  var values = indiciData.map(function(item) {
		    return parseFloat(item.indice.toFixed(4));
		});
	  var valuesMax = indiciMaxData.map(function(item) {
		    return parseFloat(item.indice.toFixed(4));
		});
	  
	  var colors = values.map(function(v) {
		  if (v <= 0.25) {
		    return 'green';
		  } else if (v <= 0.75) {
		    return 'yellow';
		  } else {
		    return 'orange';
		  }
		});
	  
	  var colorsMax = valuesMax.map(function(v) {
		  if (v <= 0.25) {
		    return 'green';
		  } else if (v <= 0.75) {
		    return 'yellow';
		  } else {
		    return 'orange';
		  }
		});

	  $('#container_indiceD').show();
	  if (chartIndiceD != null) return;

	  var ctx = document.getElementById("graficoIndiceD").getContext("2d");

	  chartIndiceD = new Chart(ctx, {
	    type: 'line',
	    data: {
	      labels: labels,
	      datasets: [
	        {
	          label: 'Indice D medio',
	          data: values,
	          borderColor: '#3366E6',
	          backgroundColor: colors,
	          pointBackgroundColor: colors,
	          pointBorderColor: 'black',
	          pointRadius: 5,
	          pointHoverRadius: 5,
	          borderWidth: 1, 
	          showLine: true
	    
	        },
	        {
	          label: 'Indice D max',          //  nuovo dataset
	          data: valuesMax,
	          borderColor: 'black',
	          backgroundColor: colorsMax,
	          pointBackgroundColor: colorsMax,
	          pointBorderColor:  'black',
	          pointRadius: 6,
	          pointHoverRadius: 6,
	          pointStyle: 'triangle',         // forma diversa per distinguerli
	          borderWidth: 1, 
	          showLine: true

	        },
	        {
	          label: 'Limite accettabilità (D=1)',
	          data: labels.map(function() { return 1; }),
	          borderColor: '#E6331A',
	          backgroundColor: 'transparent',
	          borderWidth: 2,
	          borderDash: [6, 4],
	          pointRadius: 0,
	          showLine: true
	        },
	        {
	          label: 'Zero',
	          data: labels.map(function() { return 0; }),
	          borderColor: '#999966',
	          backgroundColor: 'transparent',
	          borderWidth: 2,
	          borderDash: [3, 3],
	          pointRadius: 0,
	          showLine: true
	        }
	      ]
	    },
	    options: {
	      animation: false,
	      responsive: true,
	      maintainAspectRatio: false,
	      
	      onClick: function(event, elements) {
	          if (!elements || elements.length === 0) return;
	          var el = elements[0];
	          var idx = el.index;


	          if (el.datasetIndex === 1) {
	            // click su punto MAX  chiamata AJAX
	            var entryMax = indiciMaxData[idx];
	            var id_misura = entryMax.id;
	            
	            

	            $.ajax({
	            	  type: 'POST',
	            	  url: 'dettaglioMisura.do?action=dettaglio_indice_max&id_misura=' + id_misura,
	            	  contentType: false,
	            	  processData: false,
	            	  success: function(data) {
	            	    var result = JSON.parse(data);  // questo riceve {"success":true, "listaPuntiJson":[...]}
	            	    
	            	    if (result.success) {
	            	      // ora carica il fragment separato (questo ritorna HTML, non JSON)
	            	      $('#containerTabellePunti').load(
	            	        'dettaglioMisura.do?action=dettaglio_indice_max_fragment',
	            	        function() {
	            	            $('#modalDettaglioTitolo').text('Dettaglio Indici Prestazione - misura del ' + entryMax.data.split(' ')[0]);
	            	            $('#modalDettaglioPunto').modal('show');
	            	          }
	            	      );
	            	    }
	            	  },
	            	  error: function(jqXHR, textStatus, errorThrown) {
	            	    $('#myModalErrorContent').html(textStatus);
	            	    $('#myModalError').removeClass();
	            	    $('#myModalError').addClass("modal modal-danger");
	            	    $('#report_button').show();
	            	    $('#visualizza_report').show();
	            	    $('#myModalError').modal('show');
	            	  }
	            	});                            
	          }
	        },
	      
	      scales: {
	        x: {
	          offset: true,
	          title: { display: true, text: 'Data misura' },
	          ticks: { autoSkip: false, maxRotation: 45, minRotation: 45 }
	        },
	        y: {
	          title: { display: true, text: 'indice di prestazione D' },
	          beginAtZero: true,
	          suggestedMax: 1.2
	        }
	      },
	      plugins: {
	        legend: { display: false },
	        tooltip: {
	          callbacks: {
	            label: function(item) {
	              if (item.datasetIndex === 0) {
	                var d = item.parsed.y;
	                var esito;
	                if (d <= 0.25 && d>0)      esito = ' performante';
	                else if (d> 0.25 &&d <= 0.75) esito = ' stabile';
	                else if (d>0.75 && d <= 100) esito = ' allerta';
	                else                esito = 'non conforme';
	                return 'D medio= ' + d.toFixed(4) + '  ' + esito;
	              }
	              if (item.datasetIndex === 1) {
	                var d = item.parsed.y;
	                var esito;
	                if (d <= 0.25 && d>0)      esito = ' performante';
	                else if (d> 0.25 &&d <= 0.75) esito = ' stabile';
	                else if (d>0.75 && d <= 100) esito = ' allerta';
	                else                esito = 'non conforme';
	                return 'D max= ' + d.toFixed(4) + '  ' + esito;
	              }
	              return null;
	            }
	          }
	        },
	        zoom: {
	          zoom:  { wheel: { enabled: true }, pinch: { enabled: true }, mode: 'y' },
	          pan:   { enabled: true, mode: 'xy' }
	        }
	      }
	    }
	  });
	}
 
 function addData(chart, label, data) {
	   // chart.data.labels.push(label);
	    
	    // chart.data.datasets.forEach((dataset) => {
	     //   dataset.data.push(data);
	    //}); 
	    
	}
 
 
 var dataSets = [];
 
 var labels = [];
 
 var myLineChart = null;
 
 var punti;

    $(document).ready(function() {

					
				$('#select_misura').select2()

				
				
				
				

		  				
    		
		    	/* GRAFICO incertezza*/

		    	
	/* 	    var  myChart1 = null;	
		    	numberBack1 = Math.ceil(Object.keys(arrayListaPuntiJson).length/6);
		    	if(numberBack1>0){
		    		grafico1 = {};
		    		grafico1.labels = [];
		    		 
		    		dataset1 = {};
		    		dataset1.data = [];
		    		dataset1.label = "Andamento Incertezza";
		    		
		   
		    		
		    			dataset1.backgroundColor = [];
		    			dataset1.borderColor = [];

		    		     
		    		      
		    			
		    			colorBg=[];
		    			colorLine=[];
		    	
		    			colorBg2=[];
		    			colorLine2=[];
		    			
		    			dataset1.borderWidth = 1;
		    		
		    		
		    		
		    			dataset2 = {};
			    		dataset2.data = [];
			    		dataset2.label = "Andamento Accettabilità";
			    		dataset2.borderWidth = 1;
			    		dataset2.backgroundColor = [];
		    			dataset2.borderColor = [];
		
		    		
		    		var itemHeight1 = 200;
		    		var total1 = 0;
		    		$.each(arrayListaPuntiJson, function(i,val){
		    		
		    			idRip=0;
			    		$.each(val, function(j,punto){
			    			
			    			
			    			
					    	tipoProva = punto.tipoProva.substring(0, 1);
			    			
			    			if(tipoProva == "L"){
			    				grafico1.labels.push(punto.tipoVerifica);
				    			dataset1.data.push(punto.incertezza);
				    			if(tipoRapporto=="SVT"){
				    				dataset2.data.push(punto.accettabilita);
				    			  	colorBg2.push(newArr[1]);
							    	colorLine2.push(newArrB[1]);
				    			}
				    			itemHeight1 += 12;
				    			total1 += val;
				    			colorBg.push(newArr[0]);
						    	colorLine.push(newArrB[0]);
						  
			    			}else if(tipoProva == "R"){
			    				if(idRip!=punto.id_ripetizione){
			    					grafico1.labels.push(punto.tipoVerifica);
					    			dataset1.data.push(punto.incertezza);
					    			if(tipoRapporto=="SVT"){
					    				dataset2.data.push(punto.accettabilita);
					    				colorBg2.push(newArr[1]);
								    	colorLine2.push(newArrB[1]);
					    			}
					    			itemHeight1 += 12;
					    			total1 += val;
					    			idRip = punto.id_ripetizione;
					    			colorBg.push(newArr[0]);
							    	colorLine.push(newArrB[0]);
			    				}
			    				
			    			}
			    			
		    			});
		    		});
		    		
		    		dataset1.backgroundColor = dataset1.backgroundColor.concat(colorBg);
	    			dataset1.borderColor = dataset1.borderColor.concat(colorLine);
		    		$(".graficoIncertezza").height("390");
 		    		
		    		if(tipoRapporto=="SVT"){
		    			dataset2.backgroundColor = dataset2.backgroundColor.concat(colorBg2);
		    			dataset2.borderColor = dataset2.borderColor.concat(colorLine2);
		    			grafico1.datasets = [dataset1,dataset2];
		    		}else{
		    			grafico1.datasets = [dataset1];
		    		}
		    		 var ctx1 = document.getElementById("graficoIncertezza").getContext("2d");
		    		
		    		
		    		 var config1 = {
		        		     data: grafico1,
		        		     options: {
		        		    	 responsive: true, 
		        		    	 maintainAspectRatio: false,
		        		    	 scales: {
		        		    	        yAxes: [{
		        		    	            ticks: {
		        		    	                beginAtZero:true
 		        		    	            }
		        		    	        }],
		        		    	        xAxes: [{
		        		    	            ticks: {
 		        		    	                autoSkip: false
		        		    	            }
		        		    	        }]
		        		    	    }
		        		         
		        		     }
		        		 };
		 			 
		 				config1.type = "bar";	
		 				config1.options.tooltips = {
		 			    		 callbacks: {
		 			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
		 			    		      // data : the chart data item containing all of the datasets
		 			    		      label: function(tooltipItem, data) {
		 			    		    	  var value = data.datasets[0].data[tooltipItem.index];
		 			                      var label = data.labels[tooltipItem.index];
		 			                      var percentage =  value / total1 * 100;
		 			                     
		 			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

		 			    		      }
		 			    		    }
		 	  		 		 };
 		 		
		    		  myChart1 = new Chart(ctx1, config1);
		    	 
		    	}else{
		    		if(myChart1!= null){
		    		 	myChart1.destroy();
		    		 }
		    	}
				 */
    		
    });
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



