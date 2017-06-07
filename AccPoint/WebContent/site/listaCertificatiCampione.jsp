<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
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
CampioneDTO dettaglioCampionec=(CampioneDTO)session.getAttribute("dettaglioCampione");

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
 
 <c:forEach items="${dettaglioCampione.listaCertificatiCampione}" var="certificatocamp" varStatus="loop">

	<tr role="row" id="${certificatocamp.id}-${loop.index}">
	
		<td>${certificatocamp.id}</td>
		<td>${certificatocamp.numero_certificato}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificatocamp.dataCreazione}" /></td>

		<td><a href="scaricaCertificato.do?action=certificatoCampioneDettaglio&idCert=${certificatocamp.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a></td>
	
		
	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 

				