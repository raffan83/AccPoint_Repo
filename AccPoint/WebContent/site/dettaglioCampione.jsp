<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");

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
          <label for="inputEmail" class="col-sm-3 control-label">Settore:</label>

         <div class="col-sm-9">
         <select class="form-control select2" id="" name="settore" disabled>
         <option value=""></option>
        <%if(campione.getSettore()==0){ %>
         <option value="0" selected>Laboratorio metrologico</option>
         <%}else{ %>
         <option value="1" selected>Centro di taratura LAT</option>
         <%} %>
         </select>
			
     	</div>
   </div>
   
          <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Tipo Campione:</label>
        <div class="col-sm-9">
                     
					   <select class="form-control" id="" name="tipoCampione" required disabled>
                      
                                            <%
                                            for(TipoCampioneDTO cmp :listaTipoCampione)
                                            {
                                            	String def = "";
                                            	if(campione.getTipo_campione().getId() == cmp.getId()){
                                            		def = "selected";
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
                      <input class="form-control" id="codiceCampioneDettaglio" type="text" name="codiceCampioneDettaglio" disabled="disabled" value="<%=campione.getCodice() %>"/>
    </div>
     </div>
     
        <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Campione Verificazione:</label>
        <div class="col-sm-9">
        <%if(campione.getCampione_verificazione()==1){      	%>
        
        <input  id="campione_verificazione_dtl" type="checkbox" name="campione_verificazione_dtl" value="1" checked disabled/>
        
        <%}else{ %>
        
                      <input  id="campione_verificazione_dtl" type="checkbox" name="campione_verificazione_dtl" value="0" disabled/>
                      <%} %>
    </div>
     </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Nome:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="nome" disabled="disabled"  value="<%=campione.getNome() %>"/>
    </div>
     </div>
     
            <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Descrizione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="descrizione" disabled="disabled"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
              <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Modello:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="modello" disabled="disabled"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
     
          <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Costruttore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="costruttore" disabled="disabled"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>  
     
            <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Matricola:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="matricola" disabled="disabled"  value="<%=campione.getMatricola() %>"/>
    </div>
     </div>
          
                <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Distributore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="" type="text" name="distributore"  value="<%if(campione.getDistributore()!=null){out.println(campione.getDistributore());}%>" disabled/>
    </div>
       </div> 
       
                     <div class="form-group">
        <label for="data_acquisto" class="col-sm-3 control-label">Data Acquisto:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="data_acquisto" disabled  value="<%if(campione.getData_acquisto()!=null){out.println(sdf.format(campione.getData_acquisto()));}%>" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 



<%--          <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Inizio:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataInizio" type="text" name="dataInizio" disabled="disabled"  value="<%if(campione.getDataInizioPrenotazione()!=null){out.println(sdf.format(campione.getDataInizioPrenotazione()));} %>"/>
    </div>
       </div>  --%>
       
                <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data messa in servizio:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="dataInizio" disabled="disabled"  value="<%if(campione.getData_messa_in_servizio()!=null){out.println(sdf.format(campione.getData_messa_in_servizio()));} %>"/>
    </div>
       </div> 
       
       

       <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Ubicazione:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="" type="text" name="ubicazione"  value="<%if(campione.getUbicazione()!=null){out.println(campione.getUbicazione());}%>" disabled/>
    </div>
       </div> 

       
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Campo di misura:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="" type="text" name="campo_misura" disabled="disabled"  value="<%if(campione.getCampo_misura()!=null){out.println(campione.getCampo_misura());}%>"/>
                      																											
    </div>																																
       </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Unit� di formato:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="" type="text" name="unita_formato" disabled="disabled"  value="<%if(campione.getUnita_formato()!=null){out.println(campione.getUnita_formato());} %>"/>
    </div>
       </div>
       
       
           <div class="form-group">
          <label  class="col-sm-3 control-label">Descrizione attivit� di manutenzione:</label>

         <div class="col-sm-9">
         <%
                                     			String descr = "";
                                            	if(campione.getDescrizione_manutenzione()!=null){
                                            		descr = campione.getDescrizione_manutenzione();
                                            	}
                                         
                                            %> 
         <textarea class="form-control select2" id="" name="descrizione_manutenzione" rows="3" style="width:100%" readonly><%=descr %></textarea> 
        
			
     	</div>
   </div>
   

       
              <div class="form-group">
        <label for="attivita_di_taratura" class="col-sm-3 control-label">Attivit� Di Taratura:</label>
       
    
     	<div class="col-sm-9">
     	  <input class="form-control required" id="" type="text" name="attivita_di_taratura"  value="<%if(campione.getAttivita_di_taratura()!=null){out.println(campione.getAttivita_di_taratura());}%>" disabled/>
     	</div>    
   
       </div> 
       
           <div class="form-group">
        <label for="note_attivita_taratura" class="col-sm-3 control-label">Descrizione attivit� di taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="note_attivita_taratura"  value="<%if(campione.getNote_attivita()!=null){out.println(campione.getNote_attivita());} %>" disabled/>
    </div>
       </div> 
       

       
              <div class="form-group">
        <label for="campo_accettabilita" class="col-sm-3 control-label">Campo Di Accettabilit�:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="" type="text" name="campo_accettabilita"  value="<%if(campione.getCampo_accettabilita()!=null){out.println(campione.getCampo_accettabilita());}%>" disabled/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Interpolazione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="interpolazione" disabled="disabled"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
<div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataVerifica" disabled="disabled"  required value="<% if(campione.getDataVerifica()!=null){out.println(sdf.format(campione.getDataVerifica()));} %>" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
       
                       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="freqTaratura" disabled="disabled"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Scadenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataScadenza" disabled="disabled"  datepicker  value="<% if(campione.getDataScadenza()!=null){out.println(sdf.format(campione.getDataScadenza()));} %>"  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div> 
       
       
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Manutenzione:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataManutenzione" disabled="disabled"  required value="<% if(campione.getDataManutenzione()!=null){out.println(sdf.format(campione.getDataManutenzione()));} %>" data-date-format="dd/mm/yyyy"/>

    </div>
    
       </div> 
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Manutenzioni:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="frequenza_manutenzione" disabled="disabled"  value="<%if(campione.getFrequenza_manutenzione()!=0){out.println(campione.getFrequenza_manutenzione());} %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Scadenza Manutenzione:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataScadenza" disabled="disabled"  datepicker  value="<% if(campione.getDataScadenzaManutenzione()!=null){out.println(sdf.format(campione.getDataScadenzaManutenzione()));} %>"  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div> 
       
       

              <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Verifica Intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataVerifica" disabled="disabled"  required value="<% if(campione.getDataVerificaIntermedia()!=null){out.println(sdf.format(campione.getDataVerificaIntermedia()));} %>" data-date-format="dd/mm/yyyy"/>

    </div>
    
       </div> 
       
             <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Verifica Intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="frequenza_verifica_intermedia" disabled="disabled"  value="<%if(campione.getFrequenza_verifica_intermedia()!=0){out.println(campione.getFrequenza_verifica_intermedia());} %>"/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Scadenza Verifica Intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker" id="" type="text" name="dataScadenza" disabled="disabled"  datepicker  value="<% if(campione.getDataScadenzaVerificaIntermedia()!=null){out.println(sdf.format(campione.getDataScadenzaVerificaIntermedia()));} %>"  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div> 
       
       
       
	<%if(utente.checkPermesso("SCARICA_CERTIFICATO_CAMPIONE_METROLOGIA")){ %>
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Certificato:</label>
        <div class="col-sm-9">
 		
                        <input type="hidden" class="form-control" id="certificato" type="text" name="certificato" disabled="disabled" />
                        <%if(campione.getCertificatoCorrente(campione.getListaCertificatiCampione()) != null){ %>
                        	<a class="btn btn-info" href="#" onClick="scaricaCertificato('<%=campione.getId()%>')">Scarica Certificato</a>
                        <%}else{ %>
                        	<button class="btn" disabled="disabled">Scarica Certificato</button>
                        <%} %>
                        <c:set var ="id_campione" value="<%=campione.getId()%>"></c:set>
                   
                        <a target="_blank"  class="btn btn-primary " href='' onclick="this.href='scaricaEtichetta.do?action=campione&id_campione=${id_campione}'">Stampa Etichetta</a>



    </div>
       </div> 
               <%} %>
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Numero Certificato:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="numeroCerificato" disabled="disabled"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div>
       
                  <div class="form-group">
        <label for="note_attivita_taratura" class="col-sm-3 control-label">Descrizione attivit� di verifica intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="" type="text" name="descrizione_verifica_intermedia" value="<%if(campione.getDescrizione_verifica_intermedia()!=null){out.println(campione.getDescrizione_verifica_intermedia());} %>" disabled/>
    </div>
       </div> 


       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Stato Campione:</label>
        <div class="col-sm-9">

                        <select class="form-control" id="" name="statoCampione" required disabled>
                      
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
                            	          	<option <%=def2%> value="N">Scaduto</option>
                            	          	<%
 											String def3 = "";
                                            	if(campione.getStatoCampione().equals("F")){
                                            		def3 = "selected";
                                            	}
                                            %> 
                            	          	<option <%=def3%> value="F">Fuori Servizio</option>
                            	          
                      </select>
                      
    </div>
       </div> 
       
          
       
      <!--     <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Utilizzatore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="utilizzatore" type="text" name="utilizzatore" disabled="disabled"  value="<%=campione.getCompany_utilizzatore().getDenominazione() %>"/>
    </div>
       </div>--> 
       

       
<%--          <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Fine:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="dataFine" type="text" name="dataFine" disabled="disabled"  value="<% if(campione.getDataFinePrenotazione()!=null){out.println(sdf.format(campione.getDataFinePrenotazione()));} %>"/>
    </div>
       </div>  --%>





       

       
    
   </form>

<script>
$(document).ready(function(){

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
      }); 

})

</script>

				