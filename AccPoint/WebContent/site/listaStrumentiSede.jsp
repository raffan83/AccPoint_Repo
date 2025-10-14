<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.StatoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>

<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="java.util.Date"%>
<%@page import="it.portaleSTI.Util.Utility" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
//JsonObject json = (JsonObject)session.getAttribute("myObj");
//JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
//Gson gson = new Gson();
//Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
//ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");


ArrayList<StrumentoDTO> listaStrumenti=(ArrayList)session.getAttribute("listaStrumenti");
ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


%>

<style>
.table th input {
    min-width: 45px !important;
}

.lamp {
    height: 20px;
    width: 20px;
    border-style: solid;
    border-width: 2px;
    border-radius: 15px;
}
.lampRed {
    background-color: #FF8C00;
}
.lampGreen {
    background-color: green;
}
.lampYellow {
    background-color: yellow;
}

.lampNI {
    background-color: #8B0000;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.4);
  display: none;
  justify-content: center;
  align-items: center;
  z-index: 9999;
}

/* Modale al centro */
.modal-indice {
  position: relative;
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  width: 400px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

/* Pulsante X */
.close-button {
  position: absolute;
  top: 8px;
  right: 12px;
  font-size: 20px;
  cursor: pointer;
}
</style>

<%-- <% if(user.checkPermesso("NUOVO_STRUMENTO_METROLOGIA")){ %>
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoStrumento')">Nuovo Strumento</button>
<div id="errorMsg" ></div>
</div>
</div>
<%  } %> --%>

 
	
<div style="height:10px;">

</div>
<div class="row">
<!--  <div id="modalOverlay" class="modal-overlay">
  <div id="indiceModal" class="modal-indice">
    <span class="close-button" onclick="closeModal()">×</span>
    <div id="modalBody"></div>
  </div>
</div>  -->
 

   <div id="indiceModal" class="modal fade" role="dialog"  style="z-index:999999">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Indice di prestazione</h4>
      </div>
       <div class="modal-body" id="modalBody">       
      
      	</div>
      <div class="modal-footer">
	    
		<a class="btn btn-primary" onclick="$('#indiceModal').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div> 



<div class="col-xs-12">
 
 
<!-- <button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraStrumenti('tutti')" disabled>Visualizza Tutti</button> -->

<%--  	<%
     for(StatoStrumentoDTO str :listaStatoStrumento)
     {
     	 %> 
     	 <button class="btn btn-primary btnFiltri" id="btnFiltri_<%=str.getId() %>" onClick="filtraStrumenti('<%=str.getNome() %>','<%=str.getId() %>')" ><%=str.getNome() %></button>
  	 <%	 
     }
     %> --%>
     
     <button class="btn btn-primary" onClick="filtraStrumenti(7226,'<%=idCliente %>','<%=idSede %>')" disabled id="in_servizio">In Servizio</button>
     <button class="btn btn-primary" onClick="filtraStrumenti(7225,'<%=idCliente %>','<%=idSede %>')" id="fuori_servizio">Fuori Servizio</button>
     <button class="btn btn-primary" onClick="filtraStrumenti(7227,'<%=idCliente %>','<%=idSede %>')" id="annullati">Annullati</button>
	<button class="btn btn-warning" id="downloadfiltrati" onClick="downloadStrumentiFiltrati()" >Download PDF</button>
	<c:if test="${userObj.checkRuolo('OP') || userObj.checkRuolo('AM') }">
	<button class="btn btn-warning" id="downloadNoteTecniche" onClick="downloadNoteTecniche()" >Download Note tecniche</button>
 </c:if>
</div>
 <div class="col-xs-12" id="divFiltroDate" style="">

						<div class="form-group">
						        <label for="datarange" class="control-label">Date Filtro:</label>
								<div class="row">
						     		<div class="col-md-3">
						     		<div class="input-group">
				                    		 <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
				                    		<input type="text" class="form-control" id="datarange" name="datarange" value=""/>
				                  	</div>
								    </div>
								     <div class="col-md-9">
 				                      	<button type="button" class="btn btn-info" onclick="filtraStrumentiInScadenza('prossima')">Filtra Prossima Verifica</button>
 				            
 				                      	<button type="button" class="btn btn-info" onclick="filtraStrumentiInScadenza('ultima')">Filtra Ultima Verifica</button>
				                     
				                   		 <button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraStrumenti(7226,'<%=idCliente %>','<%=idSede %>')">Reset</button>
 				                
 								</div>
  								</div>
						   </div> 


	</div>
 </div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

                       
                       <th></th>
 						<th>ID</th>
 						<c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
 						<th>Ind. Prestazione</th>
 						</c:if>
  						<th>Stato Strumento</th>
 						  <th>Codice Interno</th>
 						  <th>Matricola</th>
 						  <th>Denominazione</th>
 						   <th>Costruttore</th> 						      
 						      <th>Modello</th> 					   
            	       <th>Campo Misura</th>
            	      
            	        <th>Reparto</th>
            	          <th>Utilizzatore</th>
            	               <th>Freq. Verifica</th> 
                    <th>Divisione</th>
            	       <th>Altre Matricole</th>
                       <th>Data Ultima Verifica</th>
                       <th>Data Prossima Verifica</th>    
                          <th>Tipo Strumento</th>
                         <th>Tipo Rapporto</th>
                          <th>Luogo Verifica</th>
                            <th>Interpolazione</th> 
                            <th>Classificazione</th>
                             <th>Company</th>
                              <th>Data Modifica</th>
                             <th>Utente Modifica</th> 
                       <th>Note</th>
                        <td style="min-width:135px;">Azioni</td>  
                       
 </tr></thead>
 
 <tbody>

 <%
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 
 for(StrumentoDTO strumento :listaStrumenti)
 {
	 String classValue="";
	 if(listaStrumenti.indexOf(strumento)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 <c:set var="str" value="<%= strumento %>" scope="request"/>
	 
	 	 <tr class="<%=classValue %> customTooltip" title="Doppio Click per aprire il dettaglio dello Strumento" role="row" id="<%=strumento.get__id() %>" data-encrypted-id="${utl:encryptData(str.__id)}">
	 						 <td></td>		
	 								

	 								 <td id="row_<%=strumento.get__id()%>"><%=strumento.get__id()%></td>
	 								 <c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
	 								 
	 								 <c:set var="indice" value="<%=strumento.getIndice_prestazione() %>"></c:set>
	 								 <c:set var="ip" value="<%=strumento.getIp() %>"></c:set>
	 								 <c:if test='${ip==0 }'>
	 								
	 								<td id="indice_prestazione_str_<%=strumento.get__id()%>" style="cursor: pointer;">
	 								<div class="lampNP" style="margin:auto">NON DETERMINATO</div>
	 								</td>
	 								</c:if>
	 								 <c:if test="${ip==1  }">
	 					
	 								 <c:if test='${indice == null || indice.equals("")}'>
	 								 <td id="indice_prestazione_str_<%=strumento.get__id()%>" style="cursor: pointer;">
	 								<div class="lampNP" style="margin:auto">NON DETERMINATO</div>
	 								</td>
	 								</c:if> 
	 								
	 								<c:if test="${indice != null  && !indice.equals('') }">
	 								 <td id="indice_prestazione_str_<%=strumento.get__id()%>" onclick="openModal(<%=strumento.get__id()%>,null,event)" style="cursor: pointer;">
	 								<c:if test='${indice.equals("V") }'>
	 								<div class="lamp lampGreen" style="margin:auto"></div>
	 								</c:if>
	 								<c:if test='${indice.equals("G")}'>
	 								<div class="lamp lampYellow" style="margin:auto"></div>
	 								</c:if>
	 								<c:if test='${indice.equals("R")}'>
	 								<div class="lamp lampRed" style="margin:auto"></div>
	 								</c:if>
	 								<c:if test='${indice.equals("X")}'>
	 							<div class="lamp lampNI" style="margin:auto"></div>
	 								</c:if>
	 								 </td>
	 								</c:if>
	 	
	 								
	 								 
	 								 </c:if>
	 								 </c:if>
	 								   <td id="stato_<%=strumento.get__id() %>"><span class="label
	 								 <% if(strumento.getStato_strumento().getId()==7225){
	 									 out.print("label-warning");
	 								}else if(strumento.getStato_strumento().getId()==7226){
	 									 out.print("label-success");
	 								}else {
	 									 out.print("label-default");
	 								}
	 								%>
                       				"><%=strumento.getStato_strumento().getNome() %></span></td>
	 								  <td><c:out value='${str.codice_interno}'/></td>
                    	            
                    	             <td><c:out value='${str.matricola}'/></td>
                    	               <td><c:out value='${str.denominazione}'/></td>
                    	             <td><c:out value='${str.costruttore}'/></td>
                    	           
                    	             <td><c:out value='${str.modello}'/></td>
	 								
                       			       <td><c:out value='${str.campo_misura}'/></td>
                    	            
                    	             
                    	             <td><c:out value='${str.reparto}'/></td>
                    	             
                    	                <td><c:out value='${str.utilizzatore}'/></td>
                    	                
                     	                 <td>
                     	                 
                     	                   <%
                     	             
                    	             if(strumento.getFrequenza() != 0){                    	            	 
                    	            		
                    	            		 out.println(strumento.getFrequenza());
                    	            	 
                   	            		 }else{
                   	            	 	%> 
                   	            	 		-
                   	            	 	<%	 
                   	             	  }
                    	             
                    	             %> 
                    	              
                    	             </td> 
                    	            
                    	           <td><c:out value='${str.risoluzione}'/></td>
                    	             <td>
                    	             <%if(strumento.getAltre_matricole()!=null){ %>
                    	             <c:out value='${str.altre_matricole}'/>
                    	             <% }else{%>
                    	             <%out.print("");
                    	             } %>
                    	             </td>
                    	             
                    	            
                    	             <td>
                    	             
                    	              <%
                    	             if(strumento.getDataUltimaVerifica()!= null){
                    	            	
                    	            	 out.println(sdf.format(strumento.getDataUltimaVerifica()));
                    	            	
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             %>
                    	              
                    	             </td>
                    	             
                    	             <td>
                    	             
                    	               <%
                    	             if(strumento.getDataProssimaVerifica() != null){
                    	            	
                    	            	out.println(sdf.format(strumento.getDataProssimaVerifica()));
                    	            	
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %>   
                    	             
                    	             </td>
                    	               <td><%=strumento.getTipo_strumento().getNome() %></td>
                    	             
                    	              <td>
                    	                 <%
                    	             if(strumento.getTipoRapporto() != null){
                    	            	
                    	            	 out.println(strumento.getTipoRapporto().getNoneRapporto());
                    	            
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             %> 
                    	             
                    	             </td> 
                    	             
                    	          
                    	             <td><% 
                    	             if(strumento.getLuogo()!=null){
                    	            	 out.println(strumento.getLuogo().getDescrizione());
                    	            	 
                    	             }
                    	             %></td>
                    	           <td><%
                    	             if(strumento.getInterpolazione()!=null){%>
                    	             <c:out value='${str.interpolazione}'/>
                    	           <% 	
                    	             }
                    	             %></td> 
                    	             <td><%=strumento.getClassificazione().getDescrizione()%></td>
                    	             <td><c:out value='${str.company.denominazione}'/></td>
								 <td><%
                    	            	 if(strumento.getDataModifica() != null){
                    	            		 out.println(sdf.format(strumento.getDataModifica()));
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
								<td><%
                    	            	 if(strumento.getUserModifica() != null){
                    	            		 out.println(strumento.getUserModifica().getNominativo());
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             
	  							
                    	             
                    	           
                    	             <td><c:out value='${str.note}'/></td>
                    	                <td>
                    	               <button  class="btn btn-primary" onClick="checkMisure('<%=Utility.encryptData(String.valueOf(strumento.get__id()))%>')">Misure</button>	 									
	 									
	 									<button  class="btn btn-danger" onClick="openDownloadDocumenti('<%=strumento.get__id()%>')"><i class="fa fa-file-text-o"></i></button>
	 									<%if(idCliente.equals("0") && idSede.equals("0")){ %>
	 									<button class="btn btn-info" title="Sposta strumento"onClick="modalSposta('<%=strumento.get__id()%>','<%= idSede %>','<%= idCliente %>')"><i class="fa fa-exchange"></i></button>
	 									
	 									<%} %>
	 									<%if(strumento.getStato_strumento().getId() != 7227){ %> 
	 									<button  class="btn btn-primary" onClick="toggleFuoriServizio('<%=strumento.get__id()%>','<%= idSede %>','<%= idCliente %>')">Cambia Stato</button>
	 									<% if(user.checkRuolo("AM") || user.checkRuolo("OP")){ %>
	 									<button  class="btn btn-danger" onClick="annullaStrumentoModal('<%=strumento.get__id()%>','<%= idSede %>','<%= idCliente %>', 0)">Annulla</button>
	 									
	 									<%} %>
	 									
	 									<% if(user.checkRuolo("AM")){ %>
	 									<button  class="btn btn-danger" onClick="annullaStrumentoModal('<%=strumento.get__id()%>','<%= idSede %>','<%= idCliente %>', 1)">Elimina</button>
	 									
	 									<%} %>
	 									<%}else{ %>
	 									<% if(user.checkRuolo("AM")){ %>
	 									<button  class="btn btn-primary" onClick="toggleFuoriServizio('<%=strumento.get__id()%>','<%= idSede %>','<%= idCliente %>')">Rimetti in servizio</button>
	 									<%} %>
	 									<%} %>
	 								</td>   
	
	</tr>
<% 	 
 } 
 

 %>
 </tbody>
 </table>  
</div>
</div>




   <div id="modalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler annullare lo strumento?
      	</div>
      <div class="modal-footer">
		<input id="id_strumento" type="hidden">
		<input id="id_sede" type="hidden">
		<input id="id_cliente" type="hidden">
		<input id="elimina" type="hidden">
        <button  class="btn btn-primary" onClick="annullaStrumento($('#id_strumento').val(),$('#id_sede').val(),$('#id_cliente').val(),$('#elimina').val())">SI</button>
	               
	                
	   
      
      
		<a class="btn btn-primary" onclick="$('#modalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


<%-- <div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Strumento</h4>
      </div>
       <div class="modal-body">

        <form class="form-horizontal" id="formNuovoStrumento">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>

         <div class="col-sm-10">
         
         <select class="form-control" id="ref_stato_strumento" name="ref_stato_strumento" required>
                      
                       <option></option>
                                            <%
                                            for(StatoStrumentoDTO str :listaStatoStrumento)
                                            {
                                            	 %> 
                            	            	 <option value="<%=str.getId() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
         

     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazione" type="text" name="denominazione" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" maxlength="22" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" required  value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modello" type="text" name="modello" required value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="matricola" type="text" name="matricola" maxlength="22" required  value=""/>
    </div>
     </div>
     
            <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Altre matricole:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="altre_matricole" type="text" name="altre_matricole" value=""/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Divisione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="risoluzione" type="text"  name="risoluzione"  required value=""/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura" required value=""/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">

                      <select class="form-control" id="ref_tipo_strumento" name="ref_tipo_strumento" required>
                      
                       <option></option>
                                            <%
                                            for(TipoStrumentoDTO str :listaTipoStrumento)
                                            {
                                            	 %> 
                            	            	 <option value="<%=str.getId() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
    </div>
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <div class="col-sm-10">

                                            <select class="form-control" id="ref_tipo_rapporto"  name="ref_tipo_rapporto" required >
                                            <option></option>
                                            <%
                                            for(TipoRapportoDTO rapp :listaTipoRapporto)
                                            {
                                            	 %> 
                            	            	 <option value="<%=rapp.getId() %>"><%=rapp.getNoneRapporto() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
                      
    </div>
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="freq_mesi" type="number" max="120" name="freq_mesi"  disabled="disabled" value=""/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Ultima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker" id="dataUltimaVerifica" type="text" name="dataUltimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Prossima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker" id="dataProssimaVerifica" type="text" name="dataProssimaVerifica" disabled="disabled" value="" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
       
       
       
                 <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Reparto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="reparto" type="text" name="reparto" value=""/>
    </div>
       </div> 
       
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore"  value=""/>
    </div>
       </div> 

	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note:</label>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note" type="text" name="note" value=""></textarea>
    </div>
       </div> 
	
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Luogo Verifica:</label>
        <div class="col-sm-10">
                      <select class="form-control" id="luogo_verifica"  name="luogo_verifica" required >
                                            <option></option>
                                            <%
                                            for(LuogoVerificaDTO luogo :listaLuogoVerifica)
                                            {
                                            	 %> 
                            	            	 <option value="<%=luogo.getId() %>"><%=luogo.getDescrizione() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 
<!-- 	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">

                          <select class="form-control" id="interpolazione"  name="interpolazione" required >
                                            <option></option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="10">10</option>
                                           
                                            
                                            </select>
    </div>
    </div> -->
   

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <div class="col-sm-10">

                       <select class="form-control" id="classificazione"  name="classificazione" required >
                                            <option></option>
                                            <%
                                            for(ClassificazioneDTO clas :listaClassificazione)
                                            {
                                            	 %> 
                            	            	 <option value="<%=clas.getId() %>"><%=clas.getDescrizione() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 

       
                <button type="submit" class="btn btn-primary" >Salva</button>
        
     
      </form>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
 --%>



  <div id="myModalSposta" class="modal fade" role="dialog" aria-labelledby="myModalCertificatiCampione">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scegli un cliente o una sede</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-6">
       <select id="cliente" name="cliente" class="form-control select2"  data-placeholder="Seleziona Cliente..." aria-hidden="true" data-live-search="true" style="width:100%">
       <option value=""></option>
      	<c:forEach items="${listaClienti}" var="cl">
      	<option value="${cl.__id }">${cl.nome }</option>
      	</c:forEach>
      
      </select>
      </div>
      <div class="col-xs-6">
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%">
       <option value=""></option>
      	<c:forEach items="${listaSedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
      </div>
       </div>
      
      
      
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_str">
     <a class="btn btn-primary" onClick="spostaStrumento('<%= idCliente %>','<%= idSede %>')">Salva</a>

      </div>
    </div>
  </div>

</div>

 <script>
 
 function annullaStrumentoModal(id_strumento, id_sede, id_cliente, elimina){
	 $('#id_strumento').val(id_strumento);	 
	 $('#id_sede').val(id_sede);	 
	 $('#id_cliente').val(id_cliente);
	 $('#elimina').val(elimina);	 
	$('#modalYesOrNo').modal();
 }
 
 
 
 
 function modalSposta(id_strumento, id_sede, id_cliente){
	 
	 if(id_cliente!=null){
		 $('#cliente').val(id_cliente);	 
		 $('#cliente').change();
	 }
	 if(id_sede!=null){
		 if(id_sede!=0){
			 $('#sede').val(id_sede +"_"+id_cliente);	 
		 }else{
			 $('#sede').val(0);
		 }
		 
		 $('#sede').change();
	 }
	 $('#id_str').val(id_strumento);
	 $('#myModalSposta').modal();
	 
 }
 
/* function openModal(id, event) {
	  document.getElementById("modalBody").innerText =
	    "Hai cliccato sull'indice di prestazione dello strumento con ID: " + id;
	  document.getElementById("modalOverlay").style.display = "flex";
	
 
 }*/
 
 function openModal(id, id_misura,event) {

	  dataObj = {};
	  dataObj.id_str = id;
	  dataObj.id_misura = id_misura;
		 
		 callAjax(dataObj,"listaStrumentiSedeNew.do?action=dettaglioIndicePrestazione",function(data){
			
			if(data.success)
			{
				var dati=data.dati_indice
				
				 modalBody.innerHTML = ' <table style="width: 100%; border-collapse: collapse;">'+
				        '  <tr><td><b>Matricola</b></td><td>'+dati.matricola+'</td></tr>'+
				        '  <tr><td><b>Punto riferimento (WC):</b></td><td>'+dati.puntoRiferimento+'</td></tr>'+
				        '  <tr><td><b>U</b></td><td>'+dati.incertezza+'</td></tr>'+
				        '  <tr><td><b>Acc</b></td><td>'+dati.valAccettabilita+'</td></tr>'+
				        '  <tr><td><b>iP</b></td><td>'+dati.indice+'</td></tr>'+
				        '<tr><td><b>Misura</b></td>'+dati.link+'</tr>'+
				        '</table>';
				 
				        $('#indiceModal').modal('show')
			}
			
		 });
		
	}


	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {

	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		//console.log(state.columns);
	    
	    		 columsDatatables = [];
	    		state.columns.forEach(function(item, index, array){
	    		
	    			if(item.visible){
	    				if( !item.search.search.startsWith("lamp")){
	    					columsDatatables.push(item);	
	    				}else{
	    					item.search.search = "";
	    					columsDatatables.push(item);
	    				}
	    				
	    			}
	    		   });
	    		
	    }
	    
	    
	    
	  
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	   var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	   if($(this).index()!= 0 && $(this).index()!= 1 && $(this).index()!= 2){
	    
	    			   $(this).append( '<div ><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');   
	    	
	    	   } 
	    	   if($(this).index()==1){
	    		   $(this).append( '<div ><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:30px !important"  type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    	   }
	    	  
	    		   if($(this).index()==2 ){
	    			   if(${userObj.checkRuolo('AM') || userObj.checkRuolo('OP') || userObj.checkRuolo('CI')}){
			    		   columsDatatables[$(this).index()].search.search = "";
			    		   $(this).append( '<div id="filtro_select"></div>')
		    		   }else{
		    			   $(this).append( '<div ><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');	   
		    		   }
	    	  
	    		   
	    		   }
	    	  
	    	} );

	    //console.log(new Date());
	} );
	
 	var param =null;
 	var col_data_prossima = 15;
 	var col_data_ultima = 14;
 	var col_def = [];

 //$(function(){
 $(document).ready(function() {
	 //$('.select2').select2();
	 
	 

	
	if(${userObj.checkRuolo('AM') || userObj.checkRuolo('OP') || userObj.checkRuolo('CI')}){
	 
    param = function (settings, data) {
        // Rimuovi i dati relativi alla colonna che vuoi escludere (ad esempio, colonna 2)
        var columnIndexToExclude = 2;
        data.columns.splice(columnIndexToExclude, 1);

    }
    
    
 	 col_data_prossima = 16;
 	 col_data_ultima = 15;
 	col_def = [
	     
		 
        { orderable: false, targets: 2 }
   ]
	}
	 
	 console.log("test")
 
	 $('#cliente').select2();
	 $('#sede').select2();
	 table = $('#tabPM').DataTable({
		 language: {
	        	emptyTable : 	"Nessun dato presente nella tabella",
	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
	        	infoPostFix:	"",
	        infoThousands:	".",
	        lengthMenu:	"Visualizza _MENU_ elementi",
	        loadingRecords:	"Caricamento...",
	        	processing:	"Elaborazione...",
	        	search:	"Cerca:",
	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
	        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
	        	},
	        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
	        }
       },
       pageLength: 100,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      stateSaveParams: param,
	      /* stateSaveParams: function (settings, data) {
	          // Rimuovi i dati relativi alla colonna che vuoi escludere (ad esempio, colonna 2)
	          var columnIndexToExclude = 2;
	          data.columns.splice(columnIndexToExclude, 1);
	      }, */
	      order:[[1, "desc"]],
	      select: 'single',
	      columnDefs: col_def,
        
	               buttons: [ {
	                   extend: 'copy',
	                   text: 'Copia',
	                   /* exportOptions: {
                      modifier: {
                          page: 'current'
                      }
                  } */
	               },{
	                   extend: 'excel',
	                   text: 'Esporta Excel',
	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
	               },
	               {
	                   extend: 'colvis',
	                   text: 'Nascondi Colonne'
	                   
	               }
	                         
	                          ]
	    	
	      
	    });
	 
	 
	 var uniqueClasses = [];
	 uniqueClasses.push("lampNP");
	 uniqueClasses.push("lampGreen");
	 uniqueClasses.push("lampYellow");
	 uniqueClasses.push("lampRed");
/* 	    table.column(2).data().each(function(value, index) {
	    	if(value!=null && value!=''){
	    		 var classes = $(value).attr('class').split(' ');
	 	        for (var i = 0; i < classes.length; i++) {
	 	            var className = classes[i];
	 	            if (uniqueClasses.indexOf(className) === -1) {
	 	                uniqueClasses.push(className);
	 	            }
	 	        }
	    	}
	    
	       
	    }); */

	    // Creare il filtro select
	  //     .appendTo($('#filtro_select').find('.dataTables_filter'))
	    var select = $('<select id="filtro_indice" class="form-control select2" style="max-width:100px"><option value="" selected>TUTTI</option></select>')
	    .appendTo($('#filtro_select'))
	        .on('change', function() {
/* 	            var selectedClass = $(this).val();
	            table = $('#tabPM').DataTable();
	            if(selectedClass!="lampNP"){
	            	table.column(2).search(selectedClass)	
	         	}else{
	            	table.column(2).search("NON DETERMINATO")	
	            } 
	            
	            var x = table.rows().data()
	            table.draw(); */
	            
	            
	            var selectedClass = $(this).val();
	            table = $('#tabPM').DataTable();
	        	$.fn.dataTable.ext.search.push(function(settings, data, dataIndex) {
	                if (selectedClass === "") {
	                    return true; // Nessun filtro, mostra tutte le righe
	                }
	                
	                var cell = table.cell(dataIndex, 2).node();
	                var divElement = $(cell).find('div');
	                var cellClasses = divElement[0].className.split(" ");
	                
	                // Controlla se la classe selezionata è presente nella cella
	                return cellClasses.includes(selectedClass);
	            });
	            
	            // Esegui la ricerca
	            table.draw();
	            
	            // Rimuovi la funzione di ricerca personalizzata dopo aver completato la ricerca
	            $.fn.dataTable.ext.search.pop();
	            
	            
	        });

	    // Popolare il filtro select con le classi CSS uniche
	    for (var i = 0; i < uniqueClasses.length; i++) {
	    	
	    	if(uniqueClasses[i]=="lampNP"){
	    		select.append('<option value="' + uniqueClasses[i] + '">NON DETERMINATO</option>');
	    	}
	    	else if(uniqueClasses[i]=="lampGreen"){
	    		select.append('<option value="' + uniqueClasses[i] + '">PERFORMANTE</option>');
	    	}
	    	else if(uniqueClasses[i]=="lampYellow"){
	    		select.append('<option value="' + uniqueClasses[i] + '">STABILE</option>');
	    	}else if(uniqueClasses[i]=="lampRed"){
	    		select.append('<option value="' + uniqueClasses[i] + '">ALLERTA</option>');
	    	}else if(uniqueClasses[i]=="lampNI"){
	    		select.append('<option value="' + uniqueClasses[i] + '">NON IDONEO</option>');
	    	}
	    
	        
	    }
	 
	 
	    $('#filtro_indice').select2()
	    
/* 	    var maxColumnWidth = table.column(1).data().reduce(function(max, data) {
	        var cellWidth = $('<div>').css('display', 'inline').html(data).appendTo('body').width();
	        return cellWidth > max ? cellWidth : max;
	    }, 0);

	    // Imposta la larghezza massima della colonna 1
	    table.column(1).nodes().to$().css('width', maxColumnWidth + 'px'); */
	    
	    
	table.buttons().container()
   .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
	    
	    
	   
		$('#tabPM').on( 'dblclick','tr', function () {

  		var id = $(this).attr('id');
  		
  		var encryptedId = $(this).data('encrypted-id');
  		
  		
  		var row = table.row('#'+id);
  		datax = row.data();

	   if(datax){
		  // console.log(datax);
 	    	row.child.hide();
 	    	
 	    	exploreModal("dettaglioStrumento.do","id_str="+encryptedId,"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	$('body').addClass('noScroll');
 	    }
	   
	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


       	var  contentID = e.target.id;

       	if(contentID == "dettaglioTab"){
       		
       	}
       	if(contentID == "misureTab"){
       		exploreModal("strumentiMisurati.do?action=ls&id="+encryptedId,"","#misure")
       	}
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+encryptedId,"","#modifica")
       	}
       	if(contentID == "documentiesterniTab"){
       		exploreModal("documentiEsterni.do?id_str="+encryptedId,"","#documentiesterni")
       	}
       	
       	if(contentID == "noteStrumentoTab"){
    		
       		exploreModal("listaStrumentiSedeNew.do?action=note_strumento&id_str="+encryptedId,"","#notestrumento")
       	 }
       		
     	
       	

 		});
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	$('.modal-backdrop').hide();
    	 	
    	});
	   
	 
	   
  	});
  	    
  	    



$('.inputsearchtable').on('click', function(e){
    e.stopPropagation();    
 });
// DataTable
	table = $('#tabPM').DataTable();
// Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
   $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
       table
           .column( colIdx )
           .search( this.value )
           .draw();
   } );
} ); 
	table.columns.adjust().draw();
	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});
	 
	
	$('#formNuovoStrumento').on('submit',function(e){
	    e.preventDefault();
		nuovoStrumento('<%= idSede %>','<%= idCliente %>')

	});
	
	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
	
	var today = moment();


//	$("#dataUltimaVerifica").attr("value", today.format('DD/MM/YYYY'));
	
	$( "#ref_tipo_rapporto" ).change(function() {

		  if(this.value == 7201 || this.value == 7203){
			  $("#freq_mesi").attr("disabled", false);
			  $("#freq_mesi").attr("required", true);
 			  $("#dataProssimaVerifica").attr("required", true);
 			  $("#freq_mesi").val("");
 			  $("#dataProssimaVerifica").val("");

		  }else{
			  $("#freq_mesi").attr("disabled", true);
			  $("#freq_mesi").attr("required", false);
 			  $("#dataProssimaVerifica").attr("required", false);
 			  $("#freq_mesi").val("");
 			  $("#dataProssimaVerifica").val("");
		  }
 		});
	
	/*$( "#freq_mesi" ).change(function() {

		  if(this.value > 0){

			  var futureMonth = moment(today).add(this.value, 'M');
			  var futureMonthEnd = moment(futureMonth).endOf('month');
			 
 
			  $("#dataProssimaVerifica").val(futureMonth.format('DD/MM/YYYY'));
			  $("#dataProssimaVerifica").attr("required", true);

		  }else{
			  $("#freq_mesi").val("");
		  }
		});*/
	 $('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	 
	 
	//Grafici

	var statoStrumentiJson = <%= request.getSession().getAttribute("statoStrumentiJson") %>;
	var tipoStrumentiJson = <%= request.getSession().getAttribute("tipoStrumentiJson") %>;
	var denominazioneStrumentiJson = <%= request.getSession().getAttribute("denominazioneStrumentiJson") %>;
	var freqStrumentiJson = <%= request.getSession().getAttribute("freqStrumentiJson") %>;
	var repartoStrumentiJson = <%= request.getSession().getAttribute("repartoStrumentiJson") %>;
	var utilizzatoreStrumentiJson = <%= request.getSession().getAttribute("utilizzatoreStrumentiJson") %>;

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
		var total1 = 0;
		$.each(statoStrumentiJson, function(i,val){
			grafico1.labels.push(i);
			dataset1.data.push(val);
			itemHeight1 += 12;
			total1 += val;
		});
		//$(".grafico1").height(itemHeight1);
		 grafico1.datasets = [dataset1];
		 
		 var ctx1 = document.getElementById("grafico1").getContext("2d");;
		
		 if(myChart1!= null){

			 myChart1.destroy();
		 }
		 	var config1 = {

				     data: grafico1,
				     options: {
				    	 responsive: true, 
				    	 maintainAspectRatio: true,
				         
				     }
				 };
			if(Object.keys(statoStrumentiJson).length<5){
				config1.type = "pieLabels";
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
				$('#grafico1').addClass("col-lg-6");
			}else{
				config1.type = "bar";	
				config1.options.legend = {display : false}
				$('#grafico1').removeClass("col-lg-6");
			
			}
		  myChart1 = new Chart(ctx1, config1);
	 
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
		var total2 = 0;
		$.each(tipoStrumentiJson, function(i,val){
			grafico2.labels.push(i);
			dataset2.data.push(val);
			itemHeight2 += 12;
			total2 += val;
		});
		//$(".grafico2").height(itemHeight2);
		 grafico2.datasets = [dataset2];
		 
		 var ctx2 = document.getElementById("grafico2").getContext("2d");;
		 
		 if(myChart2!= null){
			 myChart2.destroy();
		 }
			var config2 = {

				     data: grafico2,
				     options: {
				    	 responsive: true, 
				    	 maintainAspectRatio: true
				    	 
				    	
				     }
				 };
			if(Object.keys(tipoStrumentiJson).length<5){
				config2.type = "pieLabels";
				config2.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total2 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico2').addClass("col-lg-6");
			}else{
				config2.type = "bar";	
				config2.options.legend = {display : false}
				config2.options.scales = {
			    		 xAxes: [{
				    		 ticks: {
				    		 autoSkip: false
				    		 }
				    		 }]
			    	 }
				$('#grafico2').removeClass("col-lg-6");
			
			}
		  myChart2 = new Chart(ctx2, config2);
	 
	 }else{
		 if(myChart2!= null){
			 myChart2.destroy();
		 }
	 }
	 
 	/* GRAFICO 3*/
	 
	 numberBack3 = Math.ceil(Object.keys(denominazioneStrumentiJson).length/6);
	 if(numberBack3>0){
		 
	 
		grafico3 = {};
		grafico3.labels = [];
		 
		dataset3 = {};
		dataset3.data = [];
	
		dataset3.label = "# Strumenti per Denominazione";
	
		
 		dataset3.backgroundColor = [ ];
		dataset3.borderColor = [ ];
		for (i = 0; i < numberBack3; i++) {
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
			
			dataset3.backgroundColor = dataset3.backgroundColor.concat(newArr);
			dataset3.borderColor = dataset3.borderColor.concat(newArrB);
		}
		

		dataset3.borderWidth = 1;
		
		var itemHeight3 = 200;
		var total3 = 0;
		$.each(denominazioneStrumentiJson, function(i,val){
			grafico3.labels.push(i);
			dataset3.data.push(val);
			itemHeight3 += 12;
			total3 += val;
		});
		$(".grafico3").height(itemHeight3);
		
		
		
		 grafico3.datasets = [dataset3];
		 
		 var ctx3 = document.getElementById("grafico3").getContext("2d");;
		 
		 if(myChart3!= null){
			 myChart3.destroy();
		 }
		 var config3 = {

			     data: grafico3,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: false,
			         
			     }
			 };
			if(Object.keys(denominazioneStrumentiJson).length<5){
				config3.type = "pieLabels";
				config3.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total3 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico3').addClass("col-lg-6");
			}else{
				config3.type = "horizontalBar";	
				config3.options.legend = {display : false}
				$('#grafico3').removeClass("col-lg-6");
			}
		  myChart3 = new Chart(ctx3, config3);
	 
	 }else{
		 if(myChart3!= null){
			 myChart3.destroy();
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
		var total4 = 0;
		$.each(freqStrumentiJson, function(i,val){
			grafico4.labels.push(i);
			dataset4.data.push(val);
			itemHeight4 += 12;
			total4 += val;
		});
	//	$(".grafico4").height(itemHeight4);

		
		 grafico4.datasets = [dataset4];
		 
		 var ctx4 = document.getElementById("grafico4").getContext("2d");;

		 if(myChart4!= null){
			 myChart4.destroy();
		 }
		 var config4 = {


			     data: grafico4,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: true,
			         
			     }
			 };
			if(Object.keys(freqStrumentiJson).length<5){
				config4.type = "pieLabels";
				config4.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total4 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico4').addClass("col-lg-6");
			}else{
				config4.type = "horizontalBar";	
				config4.options.legend = {display : false}
				$('#grafico4').removeClass("col-lg-6");
			}
		  myChart4 = new Chart(ctx4, config4);
	 
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
		var total5 = 0;
		$.each(repartoStrumentiJson, function(i,val){
			grafico5.labels.push(i);
			dataset5.data.push(val);
			itemHeight5 += 12;
			total5 += val;
		});
		$(".grafico5").height(itemHeight5);

		
		 grafico5.datasets = [dataset5];
		 
		 var ctx5 = document.getElementById("grafico5").getContext("2d");;
		

		 if(myChart5!= null){
			 myChart5.destroy();
		 }
		 var config5 =  {


			     data: grafico5,
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: false,
			          
			     }
			 };
			if(Object.keys(repartoStrumentiJson).length<5){
				config5.type = "pieLabels";
				config5.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total5 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico5').addClass("col-lg-6");
			}else{
				config5.type = "horizontalBar";	
				config5.options.legend = {display : false}
				$('#grafico5').removeClass("col-lg-6");
			}
		  myChart5 = new Chart(ctx5,config5);
	 
	 }else{
		 if(myChart5!= null){
			 myChart5.destroy();
		 }
	 }
	 
 /* GRAFICO 6*/
	 
	 numberBack6 = Math.ceil(Object.keys(utilizzatoreStrumentiJson).length/6);
	 if(numberBack6>0){
		 
	 
		grafico6 = {};
		grafico6.labels = [];
		 
		dataset6 = {};
		dataset6.data = [];
		dataset6.label = "# Strumenti Utilizzatore";
		
		
 		dataset6.backgroundColor = [ ];
		dataset6.borderColor = [ ];
		for (i = 0; i < numberBack6; i++) {
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
			
			dataset6.backgroundColor = dataset6.backgroundColor.concat(newArr);
			dataset6.borderColor = dataset6.borderColor.concat(newArrB);
		}
		

		dataset6.borderWidth = 1;
		var itemHeight6 = 200;
		var total6 = 0;
		$.each(utilizzatoreStrumentiJson, function(i,val){
			grafico6.labels.push(i);
			dataset6.data.push(val);
			itemHeight6 += 12;
			total6 += val;
		});

		 grafico6.datasets = [dataset6];
		 
		 var ctx6 = document.getElementById("grafico6").getContext("2d");;
		 
		 if(myChart6!= null){
			 myChart6.destroy();
		 }
		 var config6 = {

			     data: grafico6,
			     
			     options: {
			    	 responsive: true, 
			    	 maintainAspectRatio: false,
			         scales: {
			             yAxes: [{
			                 ticks: {
			                     beginAtZero:true,
			                     autoSkip: true,
			                     barThickness : 100
			                 }
			             }],
			             xAxes: [{
			                 ticks: {
			                     autoSkip: true
			                 }
			             }]
			         }
			     }
			 };
			if(Object.keys(utilizzatoreStrumentiJson).length<5){
				config6.type = "pieLabels";
				config6.options.tooltips = {
			    		 callbacks: {
			    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
			    		      // data : the chart data item containing all of the datasets
			    		      label: function(tooltipItem, data) {
			    		    	  var value = data.datasets[0].data[tooltipItem.index];
			                      var label = data.labels[tooltipItem.index];
			                      var percentage =  value / total6 * 100;
			                     
			                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';

			    		      }
			    		    }
	  		 		 };
				$('#grafico6').addClass("col-lg-6");
			}else{
				config6.type = "horizontalBar";	
				config6.options.legend = {display : false}
				$('#grafico6').removeClass("col-lg-6");
			}
		 $(".grafico6").height(itemHeight6);
		  myChart6 = new Chart(ctx6, config6);
	 
	 }else{
		 if(myChart6!= null){
			 myChart6.destroy();
		 }
	 }
	 
	 if(	numberBack1==0 && numberBack2==0 && numberBack3==0 && numberBack4==0 && numberBack5==0 && numberBack6==0){
		 $(".boxgrafici").hide();
		 
	 }else{
		 $(".boxgrafici").show();
	 }
	 
	 
	 
		$('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YYYY'
		    }
		}, 
		function(start, end, label) {

		});
 });

 
//Date range filter
 minDateFilter = "";
 maxDateFilter = "";
 dataType = "";

  $.fn.dataTableExt.afnFiltering.push(
		  
  
   function(oSettings, aData, iDataIndex) {
	   console.log(aData);
	   
		if(oSettings.nTable.getAttribute('id') == "tabPM"){
			 if(dataType == "prossima"){
				   if (aData[col_data_prossima]) {

			    	 	var dd = aData[col_data_prossima].split("/");

			       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();
			       console.log("Prossima:"+minDateFilter);
				   console.log("MIN:"+minDateFilter);
				   console.log("MAX:"+maxDateFilter);
				   console.log("VAL:"+aData._date);
				   console.log( dd);


			     }
				   
			   }else{
				   if (aData[col_data_ultima]) {

			    	 	var dd = aData[col_data_ultima].split("/");

			       aData._date = new Date(dd[2],dd[1]-1,dd[0]).getTime();
			       console.log("Ultima:"+minDateFilter);
				   console.log("MIN:"+minDateFilter);
				   console.log("MAX:"+maxDateFilter);
				   console.log("VAL:"+aData._date);
				   console.log( dd);


			     }
				   
			   }
			  
			  
		     if (minDateFilter && !isNaN(minDateFilter)) {
		    	 if(isNaN(aData._date)){
		    		 return false;
		     
		     }
		       if (aData._date < minDateFilter) {
		          return false;
		       }
		   		
		     }

		     if (maxDateFilter && !isNaN(maxDateFilter)) {
		    	 if(isNaN(aData._date)){
		    		 return false;
		     
		     }
		       if (aData._date > maxDateFilter) {
		    	  
		         return false;
		       }
		      }

		     
		   }
		  return true;
		}	
	   
 
 ); 
 
 function openDownloadDocumenti(id){

		
		var row = table.row('#'+id);
		datax = row.data();

	   if(datax){
 	    	row.child.hide();
	  
	    	$( "#myModal" ).modal();
	    	$('body').addClass('noScroll');
	    }
	   
	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {

		   var encryptedId = $('#'+id).data('encrypted-id');
    	var  contentID = e.target.id;

    	if(contentID == "dettaglioTab"){
    		exploreModal("dettaglioStrumento.do","id_str="+encryptedId,"#dettaglio");
    	}
    	if(contentID == "misureTab"){
    		exploreModal("strumentiMisurati.do?action=ls&id="+encryptedId,"","#misure")
    	}
    	if(contentID == "modificaTab"){
    		exploreModal("modificaStrumento.do?action=modifica&id="+encryptedId,"","#modifica")
    	}
    	if(contentID == "documentiesterniTab"){
    		exploreModal("documentiEsterni.do?id_str="+encryptedId,"","#documentiesterni")
     	}
		if(contentID == "noteStrumentoTab"){
    		
       		exploreModal("listaStrumentiSedeNew.do?action=note_strumento&id_str="+encryptedId,"","#notestrumento")
       	 }
    	
    	

		});
	   $('#documentiesterniTab').tab('show');
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

		   $('.modal-backdrop').hide();
    	 	$('#dettaglioTab').tab('show');
    	 	
    	});
	   
 }
 
 $("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  

		$("#sede").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 

	});
 

 
 </script>