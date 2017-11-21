<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.DotazioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray prenotazioni = (JsonArray)json.getAsJsonArray("dataInfo");

Gson gson = new Gson();

 

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
%>


<p>Dettaglio Campione</p>
<div id="prenotazioni">

</div>				

  <script type="text/javascript">


		var prenotazioni=<%=prenotazioni%>;
		$("#prenotazioni").fullCalendar({
		 	events:prenotazioni,
		 	selectable:false,
		 	selectHelper: true,
		 	eventOverlap: false,
	
			header: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'month'
		      },
	// 	    buttonText: {
	//	        today: 'today',
	//	        month: 'month'
		
	//	      } 

		}); 
		
		$('#prenotazioniModal').on('shown.bs.modal', function () {
			   $("#prenotazioni").fullCalendar('render');
			});

</script>