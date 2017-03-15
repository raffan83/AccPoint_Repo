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

UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
%>

 
 <form class="form-horizontal">
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Proprietario:</label>

         <div class="col-sm-10">
			<input class="form-control" id="name" type="text" name="name"   value="<%=campione.getProprietario() %>" />
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Nome:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"   value="<%=campione.getNome() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Campione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"   value="<%=campione.getTipoCampione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"   value="<%=campione.getCodice() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"   value="<%=campione.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Descrizione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"    value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name"   value="<%=campione.getCostruttore() %>"/>
    </div>


       
         <div class="form-group">
      

       <div class="col-sm-offset-2 col-sm-10">
                   <div class="box-footer">
<!-- <button type="submit" class="btn btn-primary" >Modifica Dati</button> -->
 <button type="submit" class="btn btn-danger" >Invia Modifica</button>
</div>   
              </div>




  </div>  
     
        </form>
	

				