
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoCampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
%>

 <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th>Id Certificato</th>
  <th>Numero Certificato</th>
 <th>Data Creazione</th>

	<th>Action</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${campione.listaCertificatiCampione}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	
		<td>${certificato.id}</td>
		<td>${certificato.numero_certificato}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.dataCreazione}" /></td>

		<td><a href="scaricaCertificato.do?action=certificatoCampioneDettagglio&idCert=${certificato.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a></td>
	
		
	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 

				