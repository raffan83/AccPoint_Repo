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
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
DotazioneDTO campione=(DotazioneDTO)gson.fromJson(jsonElem,DotazioneDTO.class); 


SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
%>


<p>Dettaglio Campione</p>
				