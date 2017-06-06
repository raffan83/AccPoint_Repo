<%@page import="it.portaleSTI.Util.Utility"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.ValoreCampioneDTO"%>
<% 
String idC = (String)session.getAttribute("idCamp");
JsonObject json = (JsonObject)session.getAttribute("myObj");

JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);

%>



<table class="table table-hover table-striped">
                <tbody><tr>
                   		<th>Valore Nominale</th>
 	                   	<th>Valore Taratura</th>
 	                   	<th>Incertezza Assoluta</th>
 	                   	<th>Incertezza Relativa</th>
 	                   	<th>Parametri Taratura</th>
 	                   	<th>UM</th>
 	                   	<th>Interpolato</th>
 	                   	<th>Valore Composto</th>
 	                   	<th>Divisione UM</th>
 	                   	<th>Tipo Grandezza</th>
                </tr>
                <%

                
 for(ValoreCampioneDTO valori :listaValori)
 {
	 String classValue="";
	 if(listaValori.indexOf(valori)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "even";
	 }
	 
	 %>
	 <tr class="<%=classValue %>" role="row" >
	
	<td><%=Utility.checkFloatNull(valori.getValore_nominale()) %></td>
	<td><%=Utility.checkFloatNull(valori.getValore_taratura()) %></td>
    <td><%=Utility.checkFloatNull(valori.getIncertezza_assoluta()) %></td>
	<td><%=Utility.checkFloatNull(valori.getIncertezza_relativa()) %></td>
	<td><%=Utility.checkStringNull(valori.getParametri_taratura()) %></td>
	<td><%=Utility.checkStringNull(valori.getUnita_misura().getNome()) %></td>
	<td><% 

		if(valori.getInterpolato()==0){
		
			%>
			NO
			<%
		}else{
			%>
			SI
			<%
		}
	%></td>
	<td><% 
	if(valori.getValore_composto()!=null){
		if(valori.getValore_composto()==0){
		
			%>
			NO
			<%
		}else{
			%>
			SI
			<%
		}
	}
	%></td>
	<td><%=valori.getDivisione_UM()%></td>
	<td><%=Utility.checkStringNull(valori.getTipo_grandezza().getNome())%></td>
	</tr>
<% 	 
 } 
 %>       
</tbody></table>

<button onClick='callAction("modificaValoriCampione.do?view=edit&idC=<%= idC %>")' class="btn btn-warning"><i class="fa fa-edit"></i> MODIFICA VALORI</button>