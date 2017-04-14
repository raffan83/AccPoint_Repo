<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

%>

 <form class="form-horizontal">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Proprietario:</label>

         <div class="col-sm-10">
			<input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=campione.getCompany().getDenominazione() %>" />
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Nome:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getNome() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Campione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getTipo_campione().getNome()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=campione.getCodice() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Descrizione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq Taratura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Stato Campione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getStatoCampione() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getDataVerifica() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Scadenza:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getDataScadenza() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getTipo_Verifica() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Certificato:</label>
        <div class="col-sm-10">

                      <a href="#" onClick="scaricaCertificato('<%=campione.getFilenameCertificato()%>')">Scarica Certificato</a>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Numero Certificato:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getCompany_utilizzatore().getDenominazione() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Inizio:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getDataInizioPrenotazione() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Fine:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=campione.getDataFinePrenotazione() %>"/>
    </div>
       </div> 
       
     
        </form>

				