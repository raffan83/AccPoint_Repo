<%@page import="java.util.ArrayList"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.StatoStrumentoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
StrumentoDTO strumento=(StrumentoDTO)gson.fromJson(jsonElem,StrumentoDTO.class); 
session.setAttribute("strumento", strumento);
SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");

ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");
%>


        <form class="form-horizontal" id="formModificaStrumento">
              


   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazione_mod" type="text" name="denominazione_mod" required value="<%= strumento.getDenominazione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice Interno:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="codice_interno_mod" type="text" name="codice_interno_mod" maxlength="22" required value="<%= strumento.getCodice_interno() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="costruttore_mod" type="text" name="costruttore_mod" required  value="<%= strumento.getCostruttore() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="modello_mod" type="text" name="modello_mod" required value="<%= strumento.getModello() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="matricola_mod" type="text" name="matricola_mod" maxlength="22" required  value="<%= strumento.getMatricola() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Divisione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="risoluzione_mod" type="text"  name="risoluzione_mod"  required value="<%= strumento.getRisoluzione() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Campo Misura:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="campo_misura_mod" type="text" name="campo_misura_mod" required value="<%= strumento.getCampo_misura() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Strumento:</label>
        <div class="col-sm-10">

                      <select class="form-control" id="ref_tipo_strumento_mod" name="ref_tipo_strumento_mod" required>
                      
                       <option></option>
                                            <%
                                            for(TipoStrumentoDTO str :listaTipoStrumento)
                                            {
                                             	if(strumento.getTipo_strumento() != null && strumento.getTipo_strumento().getId() == str.getId()){
                                            		%> 
                               	            	 <option selected="selected" value="<%=str.getId() %>"><%=str.getNome() %></option>
                               	            	 <%	 
                                            	
                                            	}else{
                                            	 %> 
                            	            	  <option value="<%=str.getId() %>"><%=str.getNome() %></option>
                            	            	 <%	 
                                            	}
                                            }
                            	       
                                            %>
                                            
                      </select>
    </div>
       </div> 
         

       
                 <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Reparto:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="reparto_mod" type="text" name="reparto_mod" value="<%= strumento.getReparto() %>"/>
                      
    </div>
       </div> 
       
                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="utilizzatore_mod" type="text" name="utilizzatore_mod"  value="<%= strumento.getUtilizzatore() %>"/>
    </div>
       </div> 
                       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Procedura:</label>
        <div class="col-sm-10">
        <%if(strumento.getProcedura()!=null){ %>
                      <input class="form-control" id="procedura_mod" type="text" name="procedura_mod"  value="<%= strumento.getProcedura() %>"/>
                      <%}else{ %>
                    <input class="form-control" id="procedura_mod" type="text" name="procedura_mod"  value=""/>	  
                    	 <%} %>
                      
    </div>
       </div> 

	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Note:</label>
        <div class="col-sm-10">
                      <textarea class="form-control" id="note_mod" type="text" name="note_mod" value=""><%= strumento.getNote() %></textarea>
    </div>
       </div> 
	
	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Luogo Verifica:</label>
        <div class="col-sm-10">
                      <select class="form-control" id="luogo_verifica_mod"  name="luogo_verifica_mod" required >
                                            <option></option>
                                            <%
                                            for(LuogoVerificaDTO luogo :listaLuogoVerifica)
                                            {
                                            	if(strumento.getLuogo() != null && strumento.getLuogo().getId() == luogo.getId()){
                                            		%> 
                               	            	 <option selected="selected" value="<%= luogo.getId() %>"><%=luogo.getDescrizione() %></option>
                               	            	 <%	 
                                            	
                                            	}else{
                                            	 %> 
                            	            	   <option value="<%=luogo.getId() %>"><%=luogo.getDescrizione() %></option>
                            	            	 <%	 
                                            	}
                                         
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 
<%-- 	                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">
                       <select class="form-control" id="interpolazione_mod"  name="interpolazione_mod" required >
                                            <option></option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 1){ out.println("selected=\"selected\""); }%>  value="1">1</option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 2){ out.println("selected=\"selected\""); }%>  value="2">2</option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 3){ out.println("selected=\"selected\""); }%>  value="3">3</option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 4){ out.println("selected=\"selected\""); }%>  value="4">4</option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 5){ out.println("selected=\"selected\""); }%>  value="5">5</option>
                                            <option <%if(strumento.getInterpolazione() != null && strumento.getInterpolazione() == 10){ out.println("selected=\"selected\""); }%>  value="10">10</option>
                                           
                                            
                                            </select>
    </div>
       </div>  --%>

				                <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Classificazione:</label>
        <div class="col-sm-10">

                       <select class="form-control" id="classificazione_mod"  name="classificazione_mod" required >
                                            <option></option>
                                            <%
                                            for(ClassificazioneDTO clas :listaClassificazione)
                                            {
                                            	if(strumento.getClassificazione() != null && strumento.getClassificazione().getId() == clas.getId()){
                                            		%> 
                               	            	 <option selected="selected" value="<%= clas.getId() %>"><%=clas.getDescrizione() %></option>
                               	            	 <%	 
                                            	
                                            	}else{
                                            	 %> 
                            	            	  <option value="<%=clas.getId() %>"><%=clas.getDescrizione() %></option>
                            	            	 <%	 
                                            	}
                                            	 %> 
                            	            	 
                            	            	 <%	 
                                            }
                                            %>
                                            
                                            </select>
    </div>
       </div> 

       
                <button type="submit" class="btn btn-primary" >Salva</button>
        
     
        </form>
        
   
   
 <script>

 $(function(){
		$('#formModificaStrumento').on('submit',function(e){
		    e.preventDefault();
			modificaStrumento(<%= idSede %>,<%= idCliente %>,<%= strumento.get__id() %>)

		});
 });
	 
	 
	 </script>
 
