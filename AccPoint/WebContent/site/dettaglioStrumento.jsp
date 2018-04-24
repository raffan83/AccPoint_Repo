<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.ScadenzaDTO" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
StrumentoDTO strumento=(StrumentoDTO)gson.fromJson(jsonElem,StrumentoDTO.class); 
SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");
UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");
%>
<% if(user.checkPermesso("CAMBIO_STATO_STRUMENTO_METROLOGIA")){ %>
<button  class="btn btn-primary" onClick="toggleFuoriServizio('<%=strumento.get__id()%>','<%=idSede%>','<%=idCliente%>')">Cambia Stato</button>
<% } %>
 <form class="form-horizontal">
              
<%if(strumento.getStato_strumento()!=null) {%>
    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>

         <div class="col-sm-10">
			<input class="form-control" id="ref_stato_strumento" type="text" name="ref_stato_strumento" disabled="disabled" value="<%=strumento.getStato_strumento().getNome() %>" />
     	</div>
   </div>
<%} %>
<%if(strumento.getDenominazione()!=null) {%>
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazione" type="text" name="denominazione" disabled="disabled"  value="<%=strumento.getDenominazione() %>"/>
    </div>
     </div>
     
     <%} %>
<%if(strumento.getCodice_interno()!=null) {%>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" disabled="disabled"  value="<%=strumento.getCodice_interno() %>"/>
    </div>
     </div>
     
     <%} %>
<%if(strumento.getCostruttore()!=null) {%>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" disabled="disabled" value="<%=strumento.getCostruttore() %>"/>
    </div>
     </div>
     <%} %>
<%if(strumento.getModello()!=null) {%>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modello" type="text" name="modello" disabled="disabled"  value="<%=strumento.getModello() %>"/>
    </div>
     </div>
     
     <%} %>
<%if(strumento.getMatricola()!=null) {%>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="matricola" type="text" name="matricola" disabled="disabled"  value="<%=strumento.getMatricola() %>"/>
    </div>
     </div>
     
     <%} %>
<%if(strumento.getRisoluzione()!=null) {%>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Divisione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="risoluzione" type="text" name="risoluzione" disabled="disabled"  value="<%=strumento.getRisoluzione() %>"/>
    </div>
       </div>
       <%} %>
<%if(strumento.getCampo_misura()!=null) {%>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura" disabled="disabled"  value="<%=strumento.getCampo_misura() %>"/>
    </div>
       </div> 
       <%} %>
<%if(strumento.getTipo_strumento()!=null) {%>
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_strumento" type="text" name="ref_tipo_strumento" disabled="disabled"  value="<%=strumento.getTipo_strumento().getNome() %>"/>
    </div>
       </div> 
       <%} %>
<%if(strumento.getScadenzaDTO()!=null) {%>
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="freq_mesi" type="text" name="freq_mesi" disabled="disabled"  value="<%
                   			if(strumento.getScadenzaDTO()!=null){	 
                    		  if(strumento.getScadenzaDTO().getFreq_mesi() != 0){
                   	 			  out.println(strumento.getScadenzaDTO().getFreq_mesi());
                    			 }
                    		  }
                    			  %>"/>
    </div>
       </div> 
   <%} %>
<%if(strumento.getScadenzaDTO()!=null) {%>    
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Ultima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="dataUltimaVerifica" type="text" name="dataUltimaVerifica" disabled="disabled"  value="<%
                    		  if(strumento.getScadenzaDTO()!=null){
                      if(strumento.getScadenzaDTO().getDataUltimaVerifica()!=null){
                    	  out.println(sdf.format(strumento.getScadenzaDTO().getDataUltimaVerifica())); 
                      }
                    		  }
                       %>"/>
    </div>
       </div> 
     <%} %>
<%if(strumento.getScadenzaDTO()!=null) {%>  
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Prossima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="dataProssimaVerifica" type="text" name="dataProssimaVerifica" disabled="disabled"  value="<%
                    		  if(strumento.getScadenzaDTO()!=null){
                    		  if(strumento.getScadenzaDTO().getDataProssimaVerifica()!=null){
                    			  out.println(sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
                              }
                    		  }
                               %>"/>
    </div>
       </div> 
  <%} %>
<%if(strumento.getScadenzaDTO()!=null) {%>     
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_rapporto" type="text" name="ref_tipo_rapporto" disabled="disabled"  value="<%
                    		  if(strumento.getScadenzaDTO()!=null){
                    			  if(strumento.getScadenzaDTO().getTipo_rapporto()!=null){
                    			  out.println(strumento.getScadenzaDTO().getTipo_rapporto().getNoneRapporto());
                    			  }
                      }
                      %>"/>
    </div>
       </div> 
       
      <%} %>
<%if(strumento.getReparto()!=null) {%> 
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Reparto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="reparto" type="text" name="reparto" disabled="disabled"  value="<%=strumento.getReparto() %>"/>
    </div>
       </div> 
       <%} %>
<%if(strumento.getUtilizzatore()!=null) {%>
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore" disabled="disabled"  value="<%=strumento.getUtilizzatore() %>"/>
    </div>
       </div> 
<%} %>
<%if(strumento.getNote()!=null) {%>
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note:</label>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note" type="text" name="ref_tipo_rapporto" disabled="disabled" ><%=strumento.getNote() %></textarea>
    </div>
       </div> 
	<%} %>
<%if(strumento.getLuogo()!=null) {%>
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Luogo Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="luogo_verifica" type="text" name="luogo_verifica" disabled="disabled"  value="<%
                      if(strumento.getLuogo() != null){
                    	  out.println(strumento.getLuogo().getDescrizione());
                      }
                      %>"/>
    </div>
       </div> 
       <%} %>
<%if(strumento.getInterpolazione()!=null) {%>
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="interpolazione" type="text" name="interpolazione" disabled="disabled"  value="<%
                    		  if(strumento.getInterpolazione() != null){
                    			  out.println(strumento.getInterpolazione()) ;
                      			}
                      				%>"/>
    </div>
       </div> 
<%} %>
<%if(strumento.getClassificazione()!=null) {%>
				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="classificazione" type="text" name="classificazione" disabled="disabled"  value="<%=strumento.getClassificazione().getDescrizione() %>"/>
    </div>
       </div> 
			<%} %>
<%if(strumento.getCompany()!=null) {%>
				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Company:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="company" type="text" name="company" disabled="disabled"  value="<%=strumento.getCompany().getDenominazione() %>"/>
    </div>
       </div> 
<%--   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Modifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="dataModifica" type="text" name="dataModifica" disabled="disabled"  value="<%
                    		  if(strumento.getDataModifica()!=null){
                     			  out.println(sdf.format(strumento.getDataModifica()));
                     		  }
                               %>"/>
    </div>
   </div>  --%>
   <%} %>
<%if(strumento.getUserModifica()!=null) {%>
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modificato Da:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modificatoDa" type="text" name="modificatoDa" disabled="disabled"  value="<%
                    		  if(strumento.getUserModifica()!=null){
                     			  out.println(strumento.getUserModifica().getNominativo());
 
                    		  }
                               %>"/>
    </div>
   </div>       
            <%} %>

        </form>

				