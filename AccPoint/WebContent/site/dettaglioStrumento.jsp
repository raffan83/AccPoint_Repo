<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="com.google.gson.GsonBuilder"%>

<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
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
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>
<%if(strumento.getStato_strumento()!=null) {%>
         <div class="col-sm-10">
			<input class="form-control" id="ref_stato_strumento" type="text" name="ref_stato_strumento" disabled="disabled" value="<%=strumento.getStato_strumento().getNome() %>" />
     	</div>
     	<%}else { %>
     	  <div class="col-sm-10">
			<input class="form-control" id="ref_stato_strumento" type="text" name="ref_stato_strumento" disabled="disabled" value="" />
     	</div>
     	<%} %>
   </div>
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <%if(strumento.getDenominazione()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazione" type="text" name="denominazione" disabled="disabled"  value="<%=strumento.getDenominazione() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                  <input class="form-control" id="denominazione" type="text" name="denominazione" disabled="disabled"  value=""/>
    </div>
     <%} %>
     </div>
     
    

       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <%if(strumento.getCodice_interno()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" disabled="disabled"  value="<%=strumento.getCodice_interno() %>"/>
    </div>
    <%}else{ %>
     <div class="col-sm-10">
                      <input class="form-control" id="codice_interno" type="text" name="codice_interno" disabled="disabled"  value=""/>
    </div>
     <%} %>
     </div>
         

       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <%if(strumento.getCostruttore()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" disabled="disabled" value="<%=strumento.getCostruttore() %>"/>
    </div>
    <%}else{%>
    <div class="col-sm-10">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" disabled="disabled" value=""/>
    </div>
       <%} %>
     </div>
  

       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <%if(strumento.getModello()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="modello" type="text" name="modello" disabled="disabled"  value="<%=strumento.getModello() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="modello" type="text" name="modello" disabled="disabled"  value=""/>
    </div>
     <%} %>
     </div>
     
    
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <%if(strumento.getMatricola()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="matricola" type="text" name="matricola" disabled="disabled"  value="<%=strumento.getMatricola() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="matricola" type="text" name="matricola" disabled="disabled"  value=""/>
    </div>
         <%} %>
     </div>
     

       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Divisione:</label>
        <%if(strumento.getRisoluzione()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="risoluzione" type="text" name="risoluzione" disabled="disabled"  value="<%=strumento.getRisoluzione() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="risoluzione" type="text" name="risoluzione" disabled="disabled"  value=""/>
    </div>
       <%} %>
       </div>
       
       
              <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Altre matricole:</label>
        <%if(strumento.getAltre_matricole()!=null) {%>
        <div class="col-sm-10">
     
                      <input class="form-control" id="altre_matricole" type="text" name="altre_matricole" disabled="disabled"  value="<%=strumento.getAltre_matricole() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="altre_matricole" type="text" name="altre_matricole" disabled value=""/>
    </div>
       <%} %>
       </div>
       
       


       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <%if(strumento.getCampo_misura()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura" disabled="disabled"  value="<%=strumento.getCampo_misura() %>"/>
    </div>
    <%}else{ %>
       <div class="col-sm-10">
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura" disabled="disabled"  value=""/>
    </div>
      <%} %>
       </div> 
     

         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <%if(strumento.getTipo_strumento()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_strumento" type="text" name="ref_tipo_strumento" disabled="disabled"  value="<%=strumento.getTipo_strumento().getNome() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_strumento" type="text" name="ref_tipo_strumento" disabled="disabled"  value=""/>
    </div>
    <%} %>
       </div> 
       

         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq verifica:</label>
        <%if(strumento.getFrequenza()!=0) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="freq_mesi" type="text" name="freq_mesi" disabled="disabled"  value="<%
                   			 
                    		  
                   	 			  out.println(strumento.getFrequenza());
                    			
                    		  
                    			  %>"/>
    </div>
    <%}else{ %>    
     <div class="col-sm-10">
                      <input class="form-control" id="freq_mesi" type="text" name="freq_mesi" disabled="disabled"  value=""/>
    </div>
      <%} %>
       </div> 
 

         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Ultima Verifica:</label>
        <%if(strumento.getDataUltimaVerifica()!=null) {%>    
        <div class="col-sm-10">
                      <input class="form-control" id="dataUltimaVerifica" type="text" name="dataUltimaVerifica" disabled="disabled"  value="<%
                    		  
                    
                    	  out.println(sdf.format(strumento.getDataUltimaVerifica())); 
                     
                       %>"/>
    </div>
    <%}else{ %>
      <div class="col-sm-10">
                      <input class="form-control" id="dataUltimaVerifica" type="text" name="dataUltimaVerifica" disabled="disabled"  value=""/>
    </div>
      <%} %>
       </div> 
   

         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Prossima Verifica:</label>
        <%if(strumento.getDataProssimaVerifica()!=null) {%>  
        <div class="col-sm-10">
                      <input class="form-control" id="dataProssimaVerifica" type="text" name="dataProssimaVerifica" disabled="disabled"  value="<%
                    		 
                    			  out.println(sdf.format(strumento.getDataProssimaVerifica()));
                              
                               %>"/>
    </div>
    <%}else {%>
    <div class="col-sm-10">
                      <input class="form-control" id="dataProssimaVerifica" type="text" name="dataProssimaVerifica" disabled="disabled"  value=""/>
    </div>
      <%} %>
       </div> 

    
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <%if(strumento.getTipoRapporto()!=null) {%> 
        <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_rapporto" type="text" name="ref_tipo_rapporto" disabled="disabled"  value="<%
                    		 
                    			  out.println(strumento.getTipoRapporto().getNoneRapporto());
                    	
                      %>"/>
    </div>
     <%}else{ %>
      <div class="col-sm-10">
                      <input class="form-control" id="ref_tipo_rapporto" type="text" name="ref_tipo_rapporto" disabled="disabled"  value=""/>
    </div>
     <%} %>
       </div> 
       
     

                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Reparto:</label>
        <%if(strumento.getReparto()!=null) {%> 
        <div class="col-sm-10">
                      <input class="form-control" id="reparto" type="text" name="reparto" disabled="disabled"  value="<%=strumento.getReparto() %>"/>
    </div>
     <%}else{ %>
     <div class="col-sm-10">
                      <input class="form-control" id="reparto" type="text" name="reparto" disabled="disabled"  value=""/>
    </div>
     <%} %>
       </div> 
      

                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <%if(strumento.getUtilizzatore()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore" disabled="disabled"  value="<%=strumento.getUtilizzatore() %>"/>
    </div>
    <%} else {%>
       <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore" disabled="disabled"  value=""/>
       </div> 
 	<%} %>
       </div> 

	   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Procedura:</label>
       <%if(strumento.getProcedura()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="note" type="text" name="ref_tipo_rapporto" disabled="disabled" value="<%=strumento.getProcedura() %>"/>
    </div>
    <%} else {%>
     <div class="col-sm-10">
                      <input class="form-control" id="note" type="text" name="ref_tipo_rapporto" disabled="disabled" value=""/>
    </div>
    <%} %>
       </div> 
	
	

	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note:</label>
        <%if(strumento.getNote()!=null) {%>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note" type="text" name="ref_tipo_rapporto" disabled="disabled" ><%=strumento.getNote() %></textarea>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <textarea class="form-control" id="note" type="text" name="ref_tipo_rapporto" disabled="disabled" ></textarea>
    </div>
    <%} %>
       </div> 
	
		

	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Luogo Verifica:</label>
        <%if(strumento.getLuogo()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="luogo_verifica" type="text" name="luogo_verifica" disabled="disabled"  value="<%
                      if(strumento.getLuogo() != null){
                    	  out.println(strumento.getLuogo().getDescrizione());
                      }
                      %>"/>
    </div>
    <%}else{ %>
     <div class="col-sm-10">
                      <input class="form-control" id="luogo_verifica" type="text" name="luogo_verifica" disabled="disabled"  value=""/>
    </div>
    <%} %>
       </div> 
       
<%-- <%if(strumento.getInterpolazione()!=null) {%>
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
<%} %> --%>

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <%if(strumento.getClassificazione()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="classificazione" type="text" name="classificazione" disabled="disabled"  value="<%=strumento.getClassificazione().getDescrizione() %>"/>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <input class="form-control" id="classificazione" type="text" name="classificazione" disabled="disabled"  value=""/>
    </div>
    <%} %>
       </div> 
			

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Company:</label>
        <%if(strumento.getCompany()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="company" type="text" name="company" disabled="disabled"  value="<%=strumento.getCompany().getDenominazione() %>"/>
    </div>
     <%}else{ %>
      <div class="col-sm-10">
                      <input class="form-control" id="company" type="text" name="company" disabled="disabled"  value=""/>
    </div>
      <%} %>
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
  

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modificato Da:</label>
        <%if(strumento.getUserModifica()!=null) {%>
        <div class="col-sm-10">
                      <input class="form-control" id="modificatoDa" type="text" name="modificatoDa" disabled="disabled"  value="<%
                    		  if(strumento.getUserModifica()!=null){
                     			  out.println(strumento.getUserModifica().getNominativo());
 
                    		  }
                               %>"/>
    </div>
      <%}else{ %>
       <div class="col-sm-10">
                      <input class="form-control" id="modificatoDa" type="text" name="modificatoDa" disabled="disabled"  value=""/>
    </div>
        <%} %>
   </div>       
     <% if(user.checkRuolo("AM") || user.checkRuolo("OP")){ %>
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note tecniche:</label>
        <%if(strumento.getNote_tecniche()!=null) {%>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note_tecniche"  name="note_tecniche" disabled="disabled" ><%=strumento.getNote_tecniche() %></textarea>
    </div>
    <%}else{ %>
    <div class="col-sm-10">
                      <textarea class="form-control" id="note_tecniche"  name="note_tecniche" disabled="disabled" ></textarea>
    </div>
    <%} %>
    <%} %>
    
       </div> 
        </form>

				