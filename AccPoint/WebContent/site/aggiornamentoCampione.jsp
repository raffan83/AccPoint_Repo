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
	

 
 <form class="form-horizontal" id="formAggiornamentoCampione">
 


   <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Nome:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="nome" type="text" name="nome" required value="<%=campione.getNome() %>"/>
    </div>
     </div>
	<div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Matricola:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="matricola" type="text" required name="matricola"  value="<%=campione.getMatricola() %>"/>
    </div>
    </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Descrizione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="descrizione" type="text" required name="descrizione"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Costruttore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="costruttore" type="text" required name="costruttore"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Modello:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="modello" type="text" required name="modello"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Interpolazione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="interpolazione" type="number" required name="interpolazione"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="freqTaratura" type="number" required name="freqTaratura"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Stato Campione:</label>
        <div class="col-sm-9">

                        <select class="form-control" id="statoCampione" required name="statoCampione" required>
                      
                                            <%
                                     			String def1 = "";
                                            	if(campione.getStatoCampione().equals("S")){
                                            		def1 = "selected";
                                            	}
                                            %> 
                       	            	 	<option <%=def1%> value="S">In Servizio</option>
 											<%
 											String def2 = "";
                                            	if(campione.getStatoCampione().equals("N")){
                                            		def2 = "selected";
                                            	}
                                            %> 
                            	          	<option <%=def2%> value="N">Fuori Servizio</option>
                            	          
                      </select>
                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Verifica:</label>
        <div class="col-sm-9">

                      <input class="form-control datepicker" id="dataVerifica" required type="text" name="dataVerifica"  required value="<%
                      
                      if(campione.getDataVerifica() != null){
                    	 out.println(sdf.format(campione.getDataVerifica()));
                      }
                      %>" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
     
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Certificato:</label>
        <div class="col-sm-9">

                        <input accept="application/pdf" onChange="validateSize(this)" type="file" class="form-control" id="certificato" type="text" name="certificato" />
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Numero Certificato:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="numeroCerificato" type="text" required name="numeroCerificato"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div> 
       <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Distributore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="distributore" type="text" name="distributore"  value="<%=campione.getDistributore()%>" required/>
    </div>
       </div> 
       <div class="form-group">
        <label for="data_acquisto" class="col-sm-3 control-label">Data Acquisto:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker required" id="data_acquisto" type="text" name="data_acquisto"  required value="<%if(campione.getData_acquisto()!=null){out.println(sdf.format(campione.getData_acquisto()));} %>" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       <div class="form-group">
        <label for="campo_accettabilita" class="col-sm-3 control-label">Campo Di Accettabilità:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="campo_accettabilita" type="text" name="campo_accettabilita"  value="<%=campione.getCampo_accettabilita()%>" required/>
    </div>
       </div> 
       <div class="form-group">
        <label for="attivita_di_taratura" class="col-sm-3 control-label">Attività Di Taratura:</label>
       
        <div class="col-sm-4">

         			<select  class="form-control" id="attivita_taratura"  name="attivita_taratura" required>
						<option value="0">ESTERNA</option>
         				<option value="1">INTERNA</option>
         			
         			</select>
     	</div>
     	<div class="col-sm-5">
     	  <input class="form-control required" id="attivita_taratura_text" type="text" name="attivita_taratura_text"  value="<%=campione.getAttivita_di_taratura()%>" required/>
     	</div>    
   
       </div> 
       
        <button type="submit" class="btn btn-danger" >Invia Modifica</button>
    <span id="errorModifica"></span>
   </form>
<script>
$(function(){
	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy"
	});
	$('#formAggiornamentoCampione').on('submit',function(e){
	    e.preventDefault();
	    modificaCampione(<%=campione.getId() %>);

	});

	
 });


$('#attivita_taratura').change(function(){
	var selection = $('#attivita_taratura').val();
	
	if(selection==1){
		$('#attivita_taratura_text').val("INTERNA");
	}else{
		$('#attivita_taratura_text').val("");
	}
	
});

 </script>
 
				