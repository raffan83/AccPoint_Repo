<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

ArrayList<TipoCampioneDTO> listaTipoCampione = (ArrayList)session.getAttribute("listaTipoCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
%>

 <form class="form-horizontal">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-3 control-label">Proprietario:</label>

         <div class="col-sm-9">
			<input class="form-control" id="proprietario" type="text" name="proprietario" disabled="disabled" value="<%=campione.getCompany().getDenominazione() %>" />
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Nome:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="nome" type="text" name="nome" disabled="disabled"  value="<%=campione.getNome() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Tipo Campione:</label>
        <div class="col-sm-9">
                     
					   <select class="form-control" id="tipoCampione" name="tipoCampione" required disabled>
                      
                                            <%
                                            for(TipoCampioneDTO cmp :listaTipoCampione)
                                            {
                                            	String def = "";
                                            	if(campione.getTipo_campione().getId() == cmp.getId()){
                                            		def = "default";
                                            	}else{
                                            		def = "";
                                            	}
                                            	 %> 
                            	            	 <option <%=def%> value="<%=cmp.getId() %>"><%=cmp.getNome() %></option>
                            	            	 <%	 
                                            }
                                            %>
                                            
                      </select>
                      
                      
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Codice:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="codice" type="text" name="codice" disabled="disabled" value="<%=campione.getCodice() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Matricola:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="matricola" type="text" name="matricola" disabled="disabled"  value="<%=campione.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Descrizione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="descrizione" type="text" name="descrizione" disabled="disabled"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Costruttore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="costruttore" type="text" name="costruttore" disabled="disabled"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Modello:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="modello" type="text" name="modello" disabled="disabled"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Interpolazione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="interpolazione" type="text" name="interpolazione" disabled="disabled"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="freqTaratura" type="text" name="freqTaratura" disabled="disabled"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Stato Campione:</label>
        <div class="col-sm-9">

                        <select class="form-control" id="statoCampione" name="statoCampione" required disabled>
                      
                                            <%
                                     			String def = "";
                                            	if(campione.getStatoCampione().equals("S")){
                                            		def = "default";
                                            	}
                                            %> 
                       	            	 	<option <%=def%> value="S">In Servizio</option>
 											<%
                                     			def = "";
                                            	if(campione.getStatoCampione().equals("N")){
                                            		def = "default";
                                            	}
                                            %> 
                            	          	<option <%=def%> value="N">Furoi Servizio</option>
                            	          
                      </select>
                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Verifica:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="dataVerifica" type="text" name="dataVerifica" disabled="disabled"  required value="<%=sdf.format(campione.getDataVerifica()) %>" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Scadenza:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="dataScadenza" type="text" name="dataScadenza" disabled="disabled"  datepicker  value="<%=sdf.format(campione.getDataScadenza()) %>"  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div> 

         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Certificato:</label>
        <div class="col-sm-9">

                        <input type="hidden" class="form-control" id="certificato" type="text" name="certificato" disabled="disabled" /><a href="#" onClick="scaricaCertificato('<%=campione.getFilenameCertificato()%>')">Scarica Certificato</a>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Numero Certificato:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="numeroCerificato" type="text" name="numeroCerificato" disabled="disabled"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Utilizzatore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore" disabled="disabled"  value="<%=campione.getCompany_utilizzatore().getDenominazione() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Inizio:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataInizio" type="text" name="dataInizio" disabled="disabled"  value="<%=sdf.format(campione.getDataInizioPrenotazione()) %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Fine:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataFine" type="text" name="dataFine" disabled="disabled"  value="<%=sdf.format(campione.getDataFinePrenotazione()) %>"/>
    </div>
       </div> 
       
    
   </form>

				