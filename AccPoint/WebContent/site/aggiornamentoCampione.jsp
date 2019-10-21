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
        <label for="inputName" class="col-sm-3 control-label">Campo di misura:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="campo_misura" type="text" name="campo_misura"   value="<%if(campione.getCampo_misura()!=null){out.println(campione.getCampo_misura());}%>"/>
                      																											
    </div>																																
       </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Unità di formato:</label>
        <div class="col-sm-9">
                      
                      <input class="form-control" id="unita_formato" type="text" name="unita_formato"  value="<%if(campione.getUnita_formato()!=null){out.println(campione.getUnita_formato());} %>"/>
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
        <label for="inputName" class="col-sm-3 control-label">Frequenza Manutenzioni:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="frequenza_manutenzione" type="text" name="frequenza_manutenzione"   value="<%if(campione.getFrequenza_manutenzione()!=0){out.println(campione.getFrequenza_manutenzione());} %>"/> 
                      
    </div>
       </div>
                <div class="form-group">
        <label for="inputName" class="col-sm-3 control-label">Frequenza Verifica Intermedia:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="frequenza_verifica_intermedia" type="text" name="frequenza_verifica_intermedia"  value="<%if(campione.getFrequenza_verifica_intermedia()!=0){out.println(campione.getFrequenza_verifica_intermedia());} %>"/>
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
        <label for="inputName" class="col-sm-3 control-label">Data Verifica:</label>
        <div class="col-sm-9">

                      <input class="form-control datepicker" id="dataVerifica_" required type="text" name="dataVerifica"  required value="<%
                      
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
        <label for="ente_certificatore" class="col-sm-3 control-label">Ente Certificatore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="ente_certificatore" type="text" name="ente_certificatore"  value="" readonly/>
    </div>
       </div> 
       
       <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Distributore:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="distributore" type="text" name="distributore"  value="<%if(campione.getDistributore()!=null){out.println(campione.getDistributore());}%>" />
    </div>
       </div> 
       <div class="form-group">
        <label for="distributore" class="col-sm-3 control-label">Ubicazione:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="ubicazione" type="text" name="ubicazione"  value="<%if(campione.getUbicazione()!=null){out.println(campione.getUbicazione());}%>" />
    </div>
       </div> 
       <div class="form-group">
        <label for="data_acquisto" class="col-sm-3 control-label">Data Acquisto:</label>
        <div class="col-sm-9">
                      <input class="form-control datepicker required" id="data_acquisto" type="text" name="data_acquisto"   value="<%if(campione.getData_acquisto()!=null){out.println(sdf.format(campione.getData_acquisto()));}%>" data-date-format="dd/mm/yyyy"/>
    </div>
       </div> 
       <div class="form-group">
        <label for="campo_accettabilita" class="col-sm-3 control-label">Campo Di Accettabilità:</label>
        <div class="col-sm-9">
                      <input class="form-control required" id="campo_accettabilita" type="text" name="campo_accettabilita"  value="<%if(campione.getCampo_accettabilita()!=null){out.println(campione.getCampo_accettabilita());}%>" />
    </div>
       </div> 
       <div class="form-group">
        <label for="attivita_di_taratura" class="col-sm-3 control-label">Attività Di Taratura: </label>
       
        <div class="col-sm-4">

         			<select  class="form-control" id="attivita_taratura"  name="attivita_taratura" >
						<option value="0">ESTERNA</option>
         				<option value="1">INTERNA</option>
         			
         			</select>
     	</div>
     	
     	<div class="col-sm-1">
     	 <label for="attivita_taratura_text" class=" control-label pull-right">Presso: </label>
     	 </div>
     	<div class="col-sm-4">
     	 
     	  <input class="form-control required" id="attivita_taratura_text" type="text" name="attivita_taratura_text"  value="<%if(campione.getAttivita_di_taratura()!=null){out.println(campione.getAttivita_di_taratura());}%>" />
     	</div>    
   
       </div> 
       
          <div class="form-group">
        <label for="note_attivita_taratura" class="col-sm-3 control-label">Note Attività di Taratura:</label>
        <div class="col-sm-9">
                      <input class="form-control" id="note_attivita_taratura" type="text" name="note_attivita_taratura"  value="<%if(campione.getNote_attivita()!=null){out.println(campione.getNote_attivita());} %>" />
    </div>
       </div> 
          <div class="form-group">
        <label for="strumento" class="col-sm-3 control-label">Strumento:</label>
        <div class="col-sm-2">
          <input class="form-control" id="strumento" name="strumento" value="<%if(campione.getId_strumento()!=null){out.println(campione.getId_strumento());}%>" readonly> 
    </div>
    <div class="col-sm-4"><a class="btn btn-primary"onClick="caricaListaStrumenti()">Seleziona</a></div>
       </div> 
       
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
<script>


function caricaListaStrumenti(){
	
	exploreModal("listaStrumentiSedeNew.do","action=lista_strumenti_campione","#strumenti_content");
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

$(document).ready(function(){
	console.log("test");
	var selection = $('#attivita_taratura_text').val();
	
	if(selection=="INTERNA"){
		$('#attivita_taratura').val(1);
		$('#attivita_taratura_text').attr("readonly", true);
	}else{
		$('#attivita_taratura').val(0);
		$('#attivita_taratura_text').attr("readonly", false);
	}
	

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

 $('#attivita_taratura').change(function(){
	var selection = $('#attivita_taratura').val();
	
	if(selection==1){
		$('#attivita_taratura_text').val("INTERNA");
		$('#attivita_taratura_text').attr("readonly", true);
		
	}else{
		$('#attivita_taratura_text').val("");
		$('#attivita_taratura_text').attr("readonly", false);
	}
	
}); 

 </script>
 
				