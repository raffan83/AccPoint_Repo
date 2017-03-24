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

%>

 <form class="form-horizontal">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Stato Strumento:</label>

         <div class="col-sm-10">
			<input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=strumento.getRef_stato_strumento() %>" />
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getDenominazione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getCodice_interno() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=strumento.getCostruttore() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getModello() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Risoluzione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getRisoluzione() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getCampo_misura() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getRef_tipo_strumento() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Freq verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getScadenzaDto().getFreq_mesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Ultima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=sdf.format(strumento.getScadenzaDto().getDataUltimaVerifica()) %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Prossima Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=sdf.format(strumento.getScadenzaDto().getDataProssimaVerifica()) %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Rapporto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=strumento.getScadenzaDto().getRef_tipo_rapporto() %>"/>
    </div>
       </div> 
       
        
     
        </form>

				