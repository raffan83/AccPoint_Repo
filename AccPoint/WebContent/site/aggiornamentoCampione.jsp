<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat"%>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

ArrayList<TipoCampioneDTO> listaTipoCampione = (ArrayList)session.getAttribute("listaTipoCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
%>
	

 <form class="form-horizontal">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-3 control-label">Proprietario:</label>

         <div class="col-sm-9">
			<input class="form-control" id="proprietario" type="text" name="proprietario" value="<%=campione.getCompany().getDenominazione() %>" />
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Nome:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="nome" type="text" name="nome"  value="<%=campione.getNome() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Tipo Campione:</label>
        <div class="col-sm-9">
                     
					   <select class="form-control" id="tipoCampione" name="tipoCampione" required>
                      
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
                      <input class="form-control" id="codice" type="text" name="codice" value="<%=campione.getCodice() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Matricola:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="matricola" type="text" name="matricola"  value="<%=campione.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Descrizione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="descrizione" type="text" name="descrizione"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Costruttore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="costruttore" type="text" name="costruttore"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Modello:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="modello" type="text" name="modello"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Interpolazione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="interpolazione" type="text" name="interpolazione"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="freqTaratura" type="text" name="freqTaratura"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Stato Campione:</label>
        <div class="col-sm-9">

                        <select class="form-control" id="statoCampione" name="statoCampione" required>
                      
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
                      <input class="form-control datepicker" id="dataVerifica" type="text" name="dataVerifica"  required value="<%=sdf.format(campione.getDataVerifica()) %>" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Scadenza:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="dataScadenza" type="text" name="dataScadenza"  datepicker  value="<%=sdf.format(campione.getDataScadenza()) %>"  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Tipo Verifica:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="tipoVerifica" type="text" name="tipoVerifica"  value="<%=campione.getTipo_Verifica() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Certificato:</label>
        <div class="col-sm-9">

                        <input type="file" class="form-control" id="certificato" type="text" name="certificato" />
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Numero Certificato:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="numeroCerificato" type="text" name="numeroCerificato"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Utilizzatore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore"  value="<%=campione.getCompany_utilizzatore().getDenominazione() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Inizio:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataInizio" type="text" name="dataInizio"  value="<%=sdf.format(campione.getDataInizioPrenotazione()) %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Fine:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataFine" type="text" name="dataFine"  value="<%=sdf.format(campione.getDataFinePrenotazione()) %>"/>
    </div>
       </div> 
        <button type="button" class="btn btn-danger" onClick="modificaCampione(<%=campione.getId() %>)" >Invia Modifica</button>
    
   </form>

				