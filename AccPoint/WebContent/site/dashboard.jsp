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
UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");

ArrayList<TipoTrendDTO> tipoTrend = (ArrayList<TipoTrendDTO>)GestioneTrendBO.getListaTipoTrend();
String tipoTrendJson = new Gson().toJson(tipoTrend);

ArrayList<TrendDTO> trend = (ArrayList<TrendDTO>)GestioneTrendBO.getListaTrendUser(""+user.getCompany().getId());
String trendJson = new Gson().toJson(trend);

request.getSession().setAttribute("tipoTrend", tipoTrend);
request.getSession().setAttribute("trend", trend);
request.getSession().setAttribute("trendJson", trendJson);
request.getSession().setAttribute("tipoTrendJson", tipoTrendJson);
%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
     <c:if test="${userObj.checkPermesso('GRAFICI_TREND') || userObj.checkRuolo('AM')}"> 
     
     
     	<div id="graficiDaschboard">
			<div class="row">
			   <c:forEach items="${tipoTrend}" var="val" varStatus="loop">

 				<div class="col-sm-6 col-xs-12 grafico1">
					<canvas id="${val.id}_${val.descrizione}"></canvas>
				</div>
				
				</c:forEach>
			</div>
		
		</div>
		
     
     
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




    	numberBack1 = Math.ceil(Object.keys(trendJson).length/6);
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# Andamento";

    		dataset1.backgroundColor =  'rgba(54, 162, 235, 0.2)';
		dataset1.borderColor =  'rgba(54, 162, 235, 0.2)';
    		dataset1.borderWidth = 1;
    		var itemHeight1 = 200;
    		$.each(trendJson, function(i,val){

m = moment(val.data,'MMM DD, YYYY').format("M/Y");
    			grafico1.labels.push(m);
    			dataset1.data.push(val.val);
    			itemHeight1 += 12;
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


