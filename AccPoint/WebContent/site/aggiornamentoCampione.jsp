<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

ArrayList<TipoCampioneDTO> listaTipoCampione = (ArrayList)session.getAttribute("listaTipoCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
%>
	
 <c:set var="tipo_camp" value="<%=campione.getTipo_campione().getId() %>"></c:set>
 <form class="form-horizontal" id="formAggiornamentoCampione">
 
           <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Tipo Campione:</label>
        <div class="col-sm-9">
                     
					   <select class="form-control" id="tipoCampione_mod" name="tipoCampione_mod" required >
                      
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
        <label for="inputName" class="col-sm-3 control-label">Campione Verificazione:</label>
        <div class="col-sm-9">
        <%if(campione.getCampione_verificazione()==1){      	%>
        
        <input  id="check_verificazione_mod" type="checkbox" name="check_verificazione_mod" checked/>
        
        <%}else{ %>
        
                      <input  id="check_verificazione_mod" type="checkbox" name="check_verificazione_mod" />
                      <%} %>
    </div>
     </div>


   <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Nome:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="nome_mod" type="text" name="nome_mod" required value="<%=campione.getNome() %>"/>
    </div>
     </div>
     
            <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Descrizione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="descrizione_mod" type="text" required name="descrizione_mod"  value="<%=campione.getDescrizione() %>"/>
    </div>
     </div>
     
              <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Modello:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="modello_mod" type="text" required name="modello_mod"  value="<%=campione.getModello() %>"/>
    </div>
       </div> 
       
              <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Costruttore:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="costruttore_mod" type="text" required name="costruttore_mod"  value="<%=campione.getCostruttore() %>"/>
    </div>
       </div>
	<div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Matricola:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="matricola_mod" type="text" required name="matricola_mod"  value="<%=campione.getMatricola() %>"/>
    </div>
    </div>

       <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Distributore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="distributore_mod" type="text" name="distributore_mod"  value="<%if(campione.getDistributore()!=null){out.println(campione.getDistributore());}%>" />
    </div>
       </div> 
       
              <div class="form-group">
        <label for="data_acquisto" class="col-sm-3 control-label">Data Acquisto:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker required" id="data_acquisto_mod" type="text" name="data_acquisto_mod"   value="<%if(campione.getData_acquisto()!=null){out.println(sdf.format(campione.getData_acquisto()));}%>" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
       
                     <div class="form-group">
        <label for="data_acquisto" class="col-sm-3 control-label">Data Messa in servizio:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker required" id="data_messa_in_servizio_mod" type="text" name="data_messa_in_servizio_mod"   value="<%if(campione.getData_messa_in_servizio()!=null){out.println(sdf.format(campione.getData_messa_in_servizio()));}%>" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       
       
              <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Ubicazione:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="ubicazione_mod" type="text" name="ubicazione_mod"  value="<%if(campione.getUbicazione()!=null){out.println(campione.getUbicazione());}%>" />
    </div>
       </div> 
       
          <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Campo di misura:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="campo_misura_mod" type="text" name="campo_misura_mod"   value="<%if(campione.getCampo_misura()!=null){out.println(campione.getCampo_misura());}%>"/>
                      																											
    </div>																																
       </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Unità di formato:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="unita_formato_mod" type="text" name="unita_formato_mod"  value="<%if(campione.getUnita_formato()!=null){out.println(campione.getUnita_formato());} %>"/>
    </div>
       </div>
       
       
                  <div class="form-group">
          <label  class="col-sm-3 control-label">Descrizione attività di manutenzione:</label>

         <div class="col-sm-4">
         <select class="form-control select2" id="select_manutenzione_mod" data-placeholder="Seleziona descrizione manutenzione..." name="select_manutenzione_mod" style="width:100%">
         <option value=""></option>
         <option value="Controllo presenza di ammaccature o malformazioni (visivo)">Controllo presenza di ammaccature o malformazioni (visivo)</option>
         <option value="Controllo presenza di ossidazione / ruggine (visivo)">Controllo presenza di ossidazione / ruggine (visivo)</option>
         <option value="Controllo integrità indicatore (visivo)">Controllo integrità indicatore (visivo)</option>
         <option value="Controllo integrità segmenti del display (visivo)">Controllo integrità segmenti del display (visivo)</option>
         <option value="Controllo integrità terminali di collegamento (visivo)">Controllo integrità terminali di collegamento (visivo)</option>
         <option value="Controllo dello stato delle batterie (visivo)">Controllo dello stato delle batterie (visivo)</option>
         <option value="Controllo buono stato delle connessioni (visivo)">Controllo buono stato delle connessioni (visivo)</option>
         <option value="Controllo dello stato qualitativo (visivo)">Controllo dello stato qualitativo (visivo)</option>
         <option value="Pulizia">Pulizia</option>
         <option value="Controllo presenza grasso di vaselina (visivo)">Controllo presenza grasso di vaselina (visivo) </option>
         <option value="Controllo interno / esterno dello stato del contenitore (visivo)">Controllo interno / esterno dello stato del contenitore (visivo)</option>
         <option value="Verifica sicurezza elettrica">Verifica sicurezza elettrica</option>
          <option value="Controllo dello stato integrità del vetro (visivo)">Controllo dello stato integrità del vetro (visivo)</option>
         <option value="Controllo stato di serraggio del vetro al contenitore (pratico)">Controllo stato di serraggio del vetro al contenitore (pratico)</option>
         <option value="Controllo della presenza di elementi che ostruiscono il passaggio del fluido nel condotto (Visivo)">Controllo della presenza di elementi che ostruiscono il passaggio del fluido nel condotto (Visivo)</option>
         <option value="Controllo stato della filettatura (visivo)">Controllo stato della filettatura (visivo)</option>
         </select>
			
     	</div>
     	<div class="col-sm-5">
     	<textarea id="descrizione_manutenzione_mod" name ="descrizione_manutenzione_mod" style="width:100%" class="form-control" rows="3"><%if(campione.getDescrizione_manutenzione()!=null){out.println(campione.getDescrizione_manutenzione());} %></textarea>
     	</div>
   </div>
   
      <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Verificazione Sicurezza Elettrica:</label>
        <div class="col-sm-9">
        <%if(campione.getVerifica_se()==1){      	%>
        
        <input  id="check_verifica_se_mod" type="checkbox" name="check_verifica_se_mod" checked/>
        
        <%}else{ %>
        
                      <input  id="check_verifica_se_mod" type="checkbox" name="check_verifica_se_mod" />
                      <%} %>
    </div>
     </div>
       
        <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Manutenzioni:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="frequenza_manutenzione_mod" type="text" name="frequenza_manutenzione_mod"   value="<%if(campione.getFrequenza_manutenzione()!=0){out.println(campione.getFrequenza_manutenzione());} %>"/> 
                      
    </div>
       </div>
       
               <div class="form-group">
        <label for="attivita_di_taratura" class="col-sm-3 control-label">Attività Di Taratura:</label>
       
        <div class="col-sm-4">
				
         			<select  class="form-control" id="attivita_taratura_mod"  name="attivita_taratura_mod" >
						<option value="0">ESTERNA</option>
         				<option value="1">INTERNA</option>
         			
         			</select>
     	</div>
     	<div class="col-sm-1">
     	 <label for="attivita_taratura_text" class=" control-label pull-right">Presso: </label>
     	 </div>
     	<div class="col-sm-4">
     	  <input class="form-control required" id="attivita_taratura_text_mod" type="text" name="attivita_taratura_text_mod"  value="<%if(campione.getAttivita_di_taratura()!=null){out.println(campione.getAttivita_di_taratura());} %>"/>
    </div>
     	</div>    
   
       </div> 
       
             <div class="form-group">
        <label for="note_attivita_taratura" class="col-sm-3 control-label">Descrizione Attività di Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="note_attivita_taratura_mod" type="text" name="note_attivita_taratura_mod"  value="<%if(campione.getNote_attivita()!=null){out.println(campione.getNote_attivita());} %>" />
    </div>
       </div> 
       
                <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="freqTaratura_mod" type="number" required name="freqTaratura_mod"  value="<%=campione.getFreqTaraturaMesi() %>"/>
    </div>
       </div> 
       
              <div class="form-group">
        <label for="campo_accettabilita" class="col-sm-3 control-label">Campo Di Accettabilità:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="campo_accettabilita_mod" type="text" name="campo_accettabilita_mod"  value="<%if(campione.getCampo_accettabilita()!=null){out.println(campione.getCampo_accettabilita());}%>" />
    </div>
       </div> 
       
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Interpolazione:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="interpolazione_mod" type="number" required name="interpolazione_mod"  value="<%=campione.getInterpolazionePermessa() %>"/>
    </div>
       </div> 
       
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Data Verifica:</label>
        <div class="col-sm-9">

                      <input class="form-control datepicker" id="dataVerifica_mod" required type="text" name="dataVerifica_mod"  required value="<%
                      
                      if(campione.getDataVerifica() != null){
                    	 out.println(sdf.format(campione.getDataVerifica()));
                      }
                      %>" />
<!-- data-date-format="dd/mm/yyyy" -->
    </div>
       </div> 
     
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Certificato:</label>
        <div class="col-sm-9">

                        <input accept="application/pdf" onChange="validateSize(this)" type="file" class="form-control" id="certificato_mod" type="text" name="certificato_mod" />
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Numero Certificato:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="numeroCerificato_mod" type="text" required name="numeroCerificato_mod"  value="<%=campione.getNumeroCertificato() %>"/>
    </div>
       </div> 
       
       <div class="form-group">
        <label for="ente_certificatore" class="col-sm-3 control-label">Ente Certificatore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="ente_certificatore_mod" type="text" name="ente_certificatore_mod"  value="" readonly/>
    </div>
       </div> 
       
                         <div class="form-group">
        <label for="note_attivita_taratura" class="col-sm-3 control-label">Descrizione attività di verifica intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="descrizione_verifica_intermedia_mod" type="text" name="descrizione_verifica_intermedia_mod" value="<%=campione.getDescrizione_verifica_intermedia()%>"/>
    </div>
       </div>  

                <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Verifica Intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="frequenza_verifica_intermedia_mod" type="text" name="frequenza_verifica_intermedia_mod"  value="<%if(campione.getFrequenza_verifica_intermedia()!=0){out.println(campione.getFrequenza_verifica_intermedia());} %>"/>
    </div>
       </div>
       
       
         <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Stato Campione:</label>
        <div class="col-sm-9">

                        <select class="form-control" id="statoCampione_mod" required name="statoCampione_mod" required>
                      
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
       
         
       
      
          <div class="form-group">
        <label for="strumento" class="col-sm-3 control-label">Strumento:</label>
        <div class="col-sm-2">
          <input class="form-control" id="strumento" name="strumento" value="<%if(campione.getId_strumento()!=null){out.println(campione.getId_strumento());}%>" readonly> 
    </div>
    <div class="col-sm-4"><a class="btn btn-primary"onClick="caricaListaStrumenti(<%=campione.getCompany().getId()%>)">Seleziona</a></div>
       </div> 
         <%if(campione.getCampione_verificazione()==1){      	%>
        
       <input type="hidden" id="campione_verificazione_mod" name="campione_verificazione_mod" value="1">
       <%}else{ %>
       
        <input type="hidden" id="campione_verificazione_mod" name="campione_verificazione_mod" value="0">
       <%} %>
       
         <%if(campione.getVerifica_se()==1){      	%>
        
       <input type="hidden" id="verifica_se_mod" name="verifica_se_mod" value="1">
       <%}else{ %>
       
        <input type="hidden" id="verifica_se_mod" name="verifica_se_mod" value="0">
       <%} %>
       
       
        <button type="submit" class="btn btn-danger" >Invia Modifica</button>
    <span id="errorModifica"></span>
   </form>
   
   
   
   
   
   <div id="modalStrumenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close"  aria-label="Close" id="close_modal_str"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Strumento</h4>
      </div>
   
       <div class="modal-body">
		<div id="strumenti_content">
		
		</div>
        
  		 </div>
      
   
    <div class="modal-footer">
    	
    	<button type="button" class="btn btn-primary" onClick="selezionaStrumento()">Seleziona</button>
    </div>
     
  </div>
    </div>

</div>

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>   
<script src="plugins/iCheck/icheck.js"></script> 
<script>


$('#check_verificazione_mod').on('ifClicked',function(e){
	
	 if($('#check_verificazione_mod').is( ':checked' )){
		
		$('#check_verificazione_mod').iCheck('uncheck');
		$('#campione_verificazione_mod').val(0);
	 }else{
		
		$('#check_verificazione_mod').iCheck('check');				
		$('#campione_verificazione_mod').val(1);
	 }

});  

$('#check_verifica_se_mod').on('ifClicked',function(e){
	
	 if($('#check_verifica_se_mod').is( ':checked' )){
		
		$('#check_verifica_se_mod').iCheck('uncheck');
		$('#verifica_se_mod').val(0);
	 }else{
		
		$('#check_verifica_se_mod').iCheck('check');				
		$('#verifica_se_mod').val(1);
	 }

});  




function caricaListaStrumenti(id_company){
	
	exploreModal("listaStrumentiSedeNew.do","action=lista_strumenti_campione&id_company="+id_company,"#strumenti_content");
	$('#modalStrumenti').modal();
	
 	$('#modalStrumenti').on('shown.bs.modal', function (){
    	t = $('#tabStrumentiCampioni').DataTable();
    	
/* 		  t.columns().eq( 0 ).each( function ( colIdx ) {
			  
		 $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
			 if(this.value <colIdx){
			 t.column( colIdx )
		      .search( this.value )
		      .draw();
			 }
		 } );
				
		 } );    
     */
	t.columns.adjust().draw();
 
});   
}



function selezionaStrumento(){
	var id_strumento =  $('#selected').val();
	$('#strumento').val(id_strumento);
	
	$('#modalStrumenti').modal("hide");
}

$('#modalStrumenti').on('hidden.bs.modal', function(){
	  contentID == "registro_attivitaTab";
	  
}); 

$('#close_modal_str').on('click', function(){
	$('#modalStrumenti').modal('hide');
})


	$('#select_manutenzione_mod').change(function(){	
		var selection = $(this).val();
		
		
		$('#descrizione_manutenzione_mod').append(selection+";\n");
	});
	
$('#tipoCampione_mod').change(function(){
	
	if($(this).val() == 3){
		$('#attivita_taratura_mod').attr('disabled', true);
		$('#attivita_taratura_text_mod').attr('disabled', true);
		$('#note_attivita_taratura_mod').attr('disabled', true);
		$('#freqTaratura_mod').attr('disabled', true);
		$('#campo_accettabilita_mod').attr('disabled', true);
		$('#interpolazione_mod').attr('disabled', true);
		$('#dataVerifica_mod').attr('disabled', true);
		$('#codice_mod').attr('readonly', true);
		
	/* 	$('#certificato_mod').attr('disabled', true); */
		$('#numeroCerificato_mod').attr('disabled', true);
		$('#ente_certificatore_mod').attr('disabled', true);
		$('#descrizione_verifica_intermedia_mod').attr('disabled', true);
		$('#frequenza_verifica_intermedia_mod').attr('disabled', true);
		$('#interpolato_mod').attr('disabled', true);
		$('#attivita_taratura_mod').attr('required', false);
		$('#attivita_taratura_text_mod').attr('required', false);
		$('#note_attivita_taratura_mod').attr('required', false);
		$('#freqTaratura_mod').attr('required', false);
		$('#select_manutenzione_mod').attr('disabled', false);
		$('#descrizione_manutenzione_mod').attr('disabled', false);
		$('#frequenza_manutenzione_mod').attr('disabled', false);
		$('#campo_accettabilita_mod').attr('required', false);
		$('#interpolazione_mod').attr('required', false);
		/* $('#dataVerifica_mod').attr('readonly', false); */
		/* $('#certificato_mod').attr('required', false); */
		$('#numeroCerificato_mod').attr('required', false);
		$('#ente_certificatore_mod').attr('required', false);
		$('#descrizione_verifica_intermedia_mod').attr('required', false);
		$('#frequenza_verifica_intermedia_mod').attr('required', false);
		$('#interpolato_mod').attr('required', false);
		
		
		$('#attivita_taratura_mod').val("");
		$('#attivita_taratura_text_mod').val("");
		$('#note_attivita_taratura_mod').val("");
		$('#freqTaratura_mod').val("");
		$('#campo_accettabilita_mod').val("");
		$('#interpolazione_mod').val("");
		$('#dataVerifica_mod').val("");
		$('#numeroCerificato_mod').val("");
		$('#ente_certificatore_mod').val("");
		$('#descrizione_verifica_intermedia_mod').val("");
		$('#frequenza_verifica_intermedia_mod').val("");
		$('#interpolato_mod').val("");

		
	}
	else if($(this).val() == 4){
		$('#codice_mod').attr('readonly',false);		
		
		$('#attivita_taratura_mod').attr('disabled', false);
		$('#attivita_taratura_text_mod').attr('disabled', false);
		$('#note_attivita_taratura_mod').attr('disabled', false);
		$('#freqTaratura_mod').attr('disabled', false);
		$('#campo_accettabilita_mod').attr('disabled', false);
		$('#interpolazione_mod').attr('disabled', false);
		$('#dataVerifica_mod').attr('disabled', false);
		/* $('#certificato_mod').attr('disabled', false); */
		$('#numeroCerificato_mod').attr('disabled', false);
		$('#ente_certificatore_mod').attr('disabled', false);
		$('#descrizione_verifica_intermedia_mod').attr('disabled', true);
		$('#frequenza_verifica_intermedia_mod').attr('disabled', true);
		$('#select_manutenzione_mod').attr('disabled', false);
		$('#descrizione_manutenzione_mod').attr('disabled', false);
		$('#frequenza_manutenzione_mod').attr('disabled', false);
		$('#select_manutenzione_mod').attr('disabled', true);
		$('#descrizione_manutenzione_mod').attr('disabled', true);
		$('#frequenza_manutenzione_mod').attr('disabled', true);
		$('#interpolato_mod').attr('disabled', false);
		$('#attivita_taratura_mod').attr('required', true);
		$('#attivita_taratura_text_mod').attr('required', true);
		$('#note_attivita_taratura_mod').attr('required', true);
		$('#freqTaratura_mod').attr('required', true);
		$('#campo_accettabilita_mod').attr('required', false);
		$('#interpolazione_mod').attr('required', false);
		$('#dataVerifica_mod').attr('required', false);
		/* $('#certificato_mod').attr('required', false); */
		$('#numeroCerificato_mod').attr('required', false);
		$('#ente_certificatore_mod').attr('required', false);
		$('#descrizione_verifica_intermedia_mod').attr('required', false);
		$('#frequenza_verifica_intermedia_mod').attr('required', false);
		$('#interpolato_mod').attr('required', false);

		
		$('#select_manutenzione_mod').val("");
		$('#descrizione_manutenzione_mod').val("");
		$('#frequenza_manutenzione_mod').val("");
		$('#descrizione_verifica_intermedia_mod').val("");
		$('#frequenza_verifica_intermedia_mod').val("");
		
	}
	else{
		
	


		/* $('#ente_certificatore').attr('required', true); 
		$('#descrizione_verifica_intermedia').attr('required', true);
		$('#frequenza_verifica_intermedia').attr('required', true);*/
		$('#select_manutenzione_mod').attr('disabled', false);
		$('#descrizione_manutenzione_mod').attr('disabled', false);
		$('#frequenza_manutenzione_mod').attr('disabled', false);
		$('#interpolato_mod').attr('required', true);
		$('#attivita_taratura_mod').attr('disabled', false);
		$('#attivita_taratura_text_mod').attr('disabled', false);
		$('#note_attivita_taratura_mod').attr('disabled', false);
		$('#freqTaratura_mod').attr('disabled', false);
		$('#campo_accettabilita_mod').attr('disabled', false);
		$('#interpolazione_mod').attr('disabled', false);
		$('#dataVerifica_mod').attr('disabled', false);
		/* $('#certificato_mod').attr('disabled', false); */
		$('#numeroCerificato_mod').attr('disabled', false);
		$('#ente_certificatore_mod').attr('disabled', false);
		$('#descrizione_verifica_intermedia_mod').attr('disabled', false);
		$('#frequenza_verifica_intermedia_mod').attr('disabled', false);
		$('#interpolato_mod').attr('disabled', false);
		
		$('#attivita_di_taratura').attr('required', true);
		$('#attivita_di_taratura_text').attr('required', true);
		$('#note_attivita_taratura').attr('required', true);
		$('#freqTaratura_mod').attr('required', true);
		$('#campo_accettabilita_mod').attr('required', true);
		$('#interpolazione_mod').attr('required', true);
		$('#dataVerifica_mod').attr('required', true);
		/* $('#certificato_mod').attr('required', true); */
		$('#numeroCerificato_mod').attr('required', true);
	}
	
});


$(document).ready(function(){
	
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
      }); 
	
	console.log("test");
	
	
	var tipo_camp = ${tipo_camp};
	
	
	if(tipo_camp == 3) {
		$('#attivita_taratura_mod').attr("disabled", true);
		$('#attivita_taratura_text_mod').attr("disabled", true);
		$('#note_attivita_taratura_mod').attr('disabled', true);
		$('#freqTaratura_mod').attr('disabled', true);
		$('#campo_accettabilita_mod').attr('disabled', true);
		$('#interpolazione_mod').attr('disabled', true);
		$('#dataVerifica_mod').attr('disabled', true);
		$('#numeroCerificato_mod').attr('disabled', true);
		$('#ente_certificatore_mod').attr('disabled', true);
		$('#descrizione_verifica_intermedia_mod').attr('disabled', true);
		$('#frequenza_verifica_intermedia_mod').attr('disabled', true);
		$('#interpolato_mod').attr('disabled', true);
	}
	else if(tipo_camp==4){
		$('#select_manutenzione_mod').attr('disabled', true);
		$('#descrizione_manutenzione_mod').attr('disabled', true);
		$('#frequenza_manutenzione_mod').attr('disabled', true);
		$('#descrizione_verifica_intermedia_mod').attr('disabled', true);
		$('#frequenza_verifica_intermedia_mod').attr('disabled', true);
	}
	
	$('#tipoCampione_mod').select2();	
	
	var selection = $('#attivita_taratura_text_mod').val();
	
	if(selection=="INTERNA"){
		$('#attivita_taratura_mod').val(1);
		$('#attivita_taratura_text_mod').attr("readonly", true);
	}else{
		$('#attivita_taratura_mod').val(0);
		$('#attivita_taratura_text_mod').attr("readonly", false);
	}
	
$('#select_manutenzione_mod').select2();
 $('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy"
	});
	 
/* 	$('#dataVerifica_').bootstrapDP({
		format: "dd/mm/yyyy"
	});
	$('#data_acquisto').bootstrapDP({
		format: "dd/mm/yyyy"
	}); */
	
});


$('#formAggiornamentoCampione').on('submit',function(e){
    e.preventDefault();
    modificaCampione(<%=campione.getId() %>);

});

$('.form-control').keypress(function(e){
    if(e.key==";")
      return false;
    });


/* $(function(){
	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	

	
 });
 */

 $('#attivita_taratura_mod').change(function(){
	var selection = $('#attivita_taratura_mod').val();
	
	if(selection==1){
		$('#attivita_taratura_text_mod').val("INTERNA");
		$('#attivita_taratura_text_mod').attr("readonly", true);
		
	}else{
		$('#attivita_taratura_text_mod').val("");
		$('#attivita_taratura_text_mod').attr("readonly", false);
	}
	
}); 

 </script>
 
				