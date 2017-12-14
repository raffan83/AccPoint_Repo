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
     <c:if test="${userObj.checkPermesso('GRAFICI_TREND') || userObj.checkRuolo('AM')}"> 
     
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
			   <c:forEach items="${tipoTrend}" var="val" varStatus="loop">

 				<div class="col-sm-6 col-xs-12 grafico1">
					
					
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title"></h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="${val.id}_${val.descrizione}"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>
				
				</c:forEach>
			</div>
		
		</section>
		
     
     
     </c:if>
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
	var tipoTrendJson = ${tipoTrendJson};
	var trendJson = ${trendJson};

    $(document).ready(function() { 

    	tipoTrendJson.forEach(function(item, index) {

    		newArrColor = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)'
		     ];
     		newArrColorBorder = [
		         'rgba(255, 99, 132, 1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)'
		     ];


    	numberBack1 = Math.ceil(Object.keys(trendJson).length/6);
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# "+item.descrizione;

    		dataset1.backgroundColor = newArrColor[Math.floor(Math.random() * newArrColor.length)];
		dataset1.borderColor = newArrColorBorder[Math.floor(Math.random() * newArrColor.length)];
    		dataset1.borderWidth = 1;
    		var itemHeight1 = 200;
    		$.each(trendJson, function(i,val){
		if(val.tipoTrend.id == item.id){
			m = moment(val.data,'MMM DD, YYYY').format("M/Y");
    			grafico1.labels.push(m);
    			dataset1.data.push(val.val);
    			itemHeight1 += 12;
		}
    		});
    		//$(".grafico1").height(itemHeight1);
    		 grafico1.datasets = [dataset1];
    		 
    		 var ctx1 = document.getElementById(item.id+"_"+item.descrizione).getContext("2d");
 
    		  myChart1 = new Chart(ctx1, {
    		     type: 'line',
    		     data: grafico1,
    		     options: {
    		    	 responsive: true, 
    		    	 maintainAspectRatio: true,
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
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
    	}
   
    	
    	});
});

</script>
</jsp:attribute> 
</t:layout>


