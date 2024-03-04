<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
	%>

<style>
.lamp {
    height: 20px;
    width: 20px;
    border-style: solid;
    border-width: 2px;
    border-radius: 15px;
}
.lampRed {
    background-color: #FF8C00;
}
.lampGreen {
    background-color: green;
}
.lampYellow {
    background-color: yellow;
}

.lampNI {
    background-color: #8B0000;
}

</style>

<div class="row">
        <div class="col-xs-12">
        <c:if test="${userObj.checkRuolo('AM') }">
        <a class="btn btn-primary pull-right" onClick="modalNuovaMisura()">Nuova Misura</a>
        </c:if>
        </div>
        </div><br><br>
<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">


          </div>
            <div class="box-body">
            
            <c:if test="${listaMisure.size()>1}">
                                    <div class="row">
        <div class="col-xs-12">
        <a class="btn btn-primary pull-right" target="_blank" href="dettaglioMisura.do?action=andamento_temporale&id_strumento=${id_strumento}">Vedi andamento temporale </a>
        </div>
        </div><br>
            </c:if>
            
              <div class="row">
        <div class="col-xs-12">


  <table id="tabMisure" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>Data Misura</th>
  <th>Strumento</th>
       <th>Codice Interno</th>
    
   <th>Stato Ricezione</th>
    <th>Obsoleta</th>
    <th>Note Obsolescenza</th>
     <th>Certificato</th>  
     <c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
       <th>Indice Prestazione</th>
       </c:if>
     <th>Allegati</th>
     <th>Note Allegati</th>
     <th>Azioni</th>
    
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaMisure}" var="misura" varStatus="loop">
<c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || (userObj.checkRuolo("CL") && misura.obsoleto=="N")}'>
	 <tr role="row" id="${misura.id}-${loop.index}">
	<td></td>
	<td><a href="dettaglioMisura.do?idMisura=${utl:encryptData(misura.id)}" target="_blank">${misura.id}</a></td>

<td>
<c:if test="${not empty misura.dataMisura}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${misura.dataMisura}" />
</c:if></td>
<td>${misura.strumento.denominazione}</td>
<td>${misura.strumento.codice_interno}</td>
<td>${misura.statoRicezione.nome}</td>
<td align="center">			
	<span class="label bigLabelTable <c:if test="${misura.obsoleto == 'S'}">label-danger</c:if><c:if test="${misura.obsoleto == 'N'}">label-success </c:if>">${misura.obsoleto}</span> </td>
<td>${misura.note_obsolescenza }</td>
<td align="center">			
 <c:set var = "certificato" value = '${arrCartificati[""+misura.id]}'/>

<c:forEach var="entry" items="${arrCartificati}">
<c:if test="${entry.key eq misura.id}">

  	<c:set var="certificato" value="${entry.value}"/>
  	<c:if test="${certificato.stato.id == 2}">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
		<%-- <a  target="_blank" class="btn btn-primary customTooltip" title="Click per scaricare il PDF dell'etichetta"  href="scaricaEtichetta.do?action=stampaEtichetta&idMisura=${utl:encryptData(misura.id)}" ><i class="fa fa-print"></i></a> --%>
		<a  class="btn btn-primary customTooltip" title="Click per scaricare il PDF dell'etichetta" onclick="openModalStampa('${utl:encryptData(misura.id)}')"  ><i class="fa fa-print"></i></a>
	</c:if>
</c:if>
</c:forEach>

</td>
<c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP") || userObj.checkRuolo("CI")}'>
<td style="text-align:center" id="ind_prest_${misura.id }">
<c:if test="${misura.indice_prestazione=='V' }">
<div class="lamp lampGreen" style="margin:auto"></div>
</c:if>

<c:if test="${misura.indice_prestazione=='G' }">
 <div class="lamp lampYellow"  style="margin:auto"></div> 
</c:if>

<c:if test="${misura.indice_prestazione=='R' }">
 <div class="lamp lampRed" style="margin:auto"></div> 
</c:if>

<c:if test="${misura.indice_prestazione=='X' }">
<div class="lamp lampNI" style="margin:auto"></div> 
</c:if>

<c:if test="${misura.indice_prestazione==NULL || misura.indice_prestazione==''}">
NON DETERMINATO
</c:if>
</td>
</c:if>
<td>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="scaricaCertificato.do?action=download_allegato&id_misura=${utl:encryptData(misura.id)}" ><i class="fa fa-file-pdf-o"></i></a>
</c:if>
<a class="btn btn-primary customTooltip" title="Click per allegare un Pdf" onClick="modalAllegati('${misura.intervento.nomePack}','${misura.id }','${misura.note_allegato}')" ><i class="fa fa-arrow-up"></i></a>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a class="btn btn-danger customTooltip" title="Click per eliminare l'allegato" onClick="eliminaAllegato('${misura.id}','${misura.strumento.__id }','fromModal')" ><i class="fa fa-trash"></i></a>
</c:if>
</td>
<td>${misura.note_allegato }</td>
<td>
<%-- <a class="btn btn-primary customTooltip" title="Aggiorna indice di prestazione" onclick="aggiornaIndicePrestazione('${misura.id}')"><i class="fa fa-refresh"></i></a> --%>
<c:if test='${userObj.checkRuolo("AM") || userObj.checkRuolo("OP")}'>
		<select class="form-control indicePrest" id="indice_prestazione_${misura.id}" onchange="aggiornaIndicePrestazione('${misura.id}')" data-placeholder="Aggiorna indice di prestazione" style ="width:80%">
		<option value=""></option>
		<c:choose>
		<c:when test="${misura.indice_prestazione == '0' }">
			<option value="0" selected>NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X">NON IDONEO</option>
		</c:when>
		<c:when test="${misura.indice_prestazione == 'V' }">
			<option value="0">NON DETERMINATO</option>
			<option value="V" selected>PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X">NON IDONEO</option>
		</c:when>
		<c:when test="${misura.indice_prestazione == 'G' }">
			<option value="0">NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G" selected>STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X">NON IDONEO</option>
		</c:when>
		<c:when test="${misura.indice_prestazione == 'R' }">
			<option value="0">NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R" selected>ALLERTA</option>
			<option value="X">NON IDONEO</option>
		</c:when>
		<c:when test="${misura.indice_prestazione == 'X' }">
			<option value="0">NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X" selected>NON IDONEO</option>
		</c:when>
			<c:when test="${misura.indice_prestazione == null || misura.indice_prestazione == '' }">
			<option value="0"selected>NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X" >NON IDONEO</option>
		</c:when>
		<c:otherwise>
			<option value="0">NON DETERMINATO</option>
			<option value="V">PERFORMANTE</option>
			<option value="G">STABILE</option>
			<option value="R">ALLERTA</option>
			<option value="X">NON IDONEO</option>
		</c:otherwise>
		</c:choose>
		
		</select>

</c:if>
</td>


	</tr>
	
</c:if>	 
	</c:forEach>
 
	
 </tbody>
 </table>  

</div>
</div>
</div>
</div>
</div>
</div>


<c:if test="${listaMisure.size()>0 && listaMisure.get(0).getStrumento().getTipoRapporto().getId()==7201}">
<div class="row">
<div class="col-xs-5"></div>
<div class="col-xs-4">
<label>Legenda Indice Prestazione</label>

</div>
<div class="col-xs-4"></div>
</div><br>
<div class="row">
<div class="col-xs-4"></div>
<div class="col-xs-1" >
<label>PERFORMANTE</label>
<div class="lamp lampGreen" ></div>
</div>
<div class="col-xs-1">
<label>STABILE</label>
<div class="lamp lampYellow"></div>
</div>
<div class="col-xs-1">
<label>ALLERTA</label>
<div class="lamp lampRed"></div>
</div>
<div class="col-xs-2">
<label>NON IDONEO</label>
<div class="lamp lampNI"></div>
</div>
</div>
</c:if>

  <div id="modalStampaEtichetta" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalStampaEtichetta').modal('hide')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Stampa Etichetta</h4>
      </div>
       <div class="modal-body">
		
		<div class="row">

		<div class="col-xs-12" style="text-align:center">
		
				<a target="_blank"  style="height:50px;width:220px" class="btn btn-primary btn-lg" href='' onclick="this.href='scaricaEtichetta.do?action=stampaEtichetta&idMisura='+document.getElementById('id_misura_stampa').value+'&check_fuori_servizio='+document.getElementById('check_fuori_servizio').value">Stampa </a>

        
      
        
		
		</div>
<!-- <div class="col-xs-3">
	</div> -->
		</div>
	
	<br>
	<div class="row">

		<div class="col-xs-12"  style="text-align:center">
		

               <input type="checkbox" id="check_fs" name="check_fs"><label>&nbsp Fuori Servizio</label>
        
		
		</div>

		</div>
	
	
	
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<input id="check_fuori_servizio" name="check_fuori_servizio" value="0" type="hidden">
		<input  id="id_misura_stampa" name="id_misura_stampa" type="hidden">
      </div>
    </div>
  </div>
</div> 





<form id="formNuovaMisura" name="formNuovaMisura">
  <div id="modalNuovaMisura" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaMisura').modal('hide')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Misura</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-4">
      <label>Intervento:</label> 
       </div>
       <div class="col-xs-8">
       <select  class="form-control select2" id="id_intervento" name="id_intervento" required style ="width:100%" data-placeholder="Seleziona intervento...">
   	<c:set var ="lista_interventi_utente_size" value="${lista_interventi_utente.size()  }"></c:set>
   	<option value=""></option>
       <c:forEach items="${lista_interventi_utente }" var ="intervento">
       <fmt:formatDate value="${intervento.dataCreazione}" pattern="dd/MM/yyyy" var="formattedDate" />
       <c:if test="${lista_interventi_utente.size()==1 }">
        <option value="${intervento.id }" selected>ID55: ${intervento.id } - Data: ${formattedDate } - Utente: ${intervento.user.nominativo }</option>
       </c:if>
              <c:if test="${lista_interventi_utente.size()>1 }">
        <option value="${intervento.id }">ID: ${intervento.id } - Data: ${formattedDate } - Utente: ${intervento.user.nominativo }</option>
       </c:if>
      
       </c:forEach>
       </select>
       </div>
       </div><br>

         <div class="row">
       <div class="col-xs-4">
        <label>Data Misura:</label>
       </div>
       <div class="col-xs-8">
              		<div class='input-group date datepicker' id='datepicker_data_misura'>
               <input type='text' class="form-control input-small" id="data_misura" name="data_misura" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       
       </div>
       </div><br>
       <div class="row">
       <div class="col-xs-4">
        <label>Numero Certificato:</label>
       </div>
       <div class="col-xs-8">
       <input type="text" class="form-control" id="nCertificato" name="nCertificato" required>
       </div>
       </div><br>
<!--               <div class="row">
       <div class="col-xs-4">
        <label>Data Emissione:</label>
       </div>
       <div class="col-xs-8">
              		<div class='input-group date datepicker' id='datepicker_data_emissione'>
               <input type='text' class="form-control input-small" id="data_emissione" name="data_emissione">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       
       </div>
       </div><br> -->
       
       		<div class="row">
      <!--  <div class="col-xs-12"> -->
   
       <div class="col-xs-4">
        <label>Indice di prestazione:</label>
       </div>
           <div class="col-xs-8">
				<select class="form-control select2" id="indice_prestazione" name="indice_prestazione" style ="width:100%">
		<option value="" selected>NON DETERMINATO</option>
		<option value="V">PERFORMANTE</option>
		<option value="G">STABILE</option>
		<option value="R">ALLERTA</option>
		<option value="X">NON IDONEO</option>
		
		</select>
		
		
		</div>
		</div><br>
       


		<div class="row">
      <!--  <div class="col-xs-12"> -->
       <div class="col-xs-4">
		   	 <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Certificato...</span>
				<input accept=".pdf,.PDF"  id="fileupload_certificato" name="fileupload_certificato" type="file"  required>
		       
		   	 </span>
   </div> 
		 <div class="col-xs-8">
		 <label id="label_certificato"></label>
		 </div>
		</div> 
		<br>
		


  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" >
 		<%-- <input type="hidden" id="id_intervento" name="id_intervento" value="${intervento.id }"> --%>
 		<input type="hidden"  id="id_strumento" name="id_strumento" value="${id_strumento }">

        <button  class="btn btn-primary" type="submit">Salva</button>
      </div>
    </div>
  </div>
</div>
</form>




           
<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade modal-md" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onClick="closeModal()"aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="pack" name=pack>
        <input type="hidden" id="id_misura" name=id_misura>
        <div class="row">
       <div class="col-xs-12">
        <label>Note Allegato</label>
        <textarea rows="5" style="width:100%" id="note_allegato" name="note_allegato"></textarea>        
       </div>
       </div>
       <div class="row">
       <div class="col-xs-12">
       <label>Attenzione! L'upload potrebbe sovrascrivere un altro file precedentemente caricato!</label>
       </div>
       </div>
  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateAllegati()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>



  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">


  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>
<%-- <jsp:attribute name="extra_css">

<link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
</jsp:attribute> --%>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script src="plugins/iCheck/icheck.min.js"></script> 
<script src="plugins/iCheck/icheck.js"></script> 
<script type="text/javascript" src="plugins/datepicker/bootstrap-datepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>  
<script type="text/javascript" src="plugins/datejs/date.js"></script>




  <script type="text/javascript">
  
  
  $(".indicePrest").select2();
  function aggiornaIndicePrestazione(id_misura){
	  
	  
	  var stato = $('#indice_prestazione_'+id_misura).val()
	  
	  
	  
	  $.ajax({
		  url: 'gestioneMisura.do?action=aggiorna_indice_prestazione&id_misura='+id_misura+"&stato="+stato, // Specifica l'URL della tua servlet
		  method: 'POST',
		  dataType: 'json',
		  success: function(response) {
		   
		if(response.success){
			var id_strumento = response.id_strumento;
			 var t = document.getElementById("tabMisure");
			    var rows = t.rows;
			   
			  
			    tableMisure = $('#tabMisure').DataTable();
				  
				  var html = "";
			    	
				  if(stato == "V"){
					  html = '<div class="lamp lampGreen" style="margin:auto"></div>'
						  var opzioneDaAggiungere = "lampGreen";
					  var text = "PERFORMANTE"
				  }else if(stato == "G"){
					  html = '<div class="lamp lampYellow" style="margin:auto"></div>'
						  var opzioneDaAggiungere = "lampYellow";
					 	 var text = "STABILE"
				  }else if(stato == "R"){
					  html = '<div class="lamp lampRed" style="margin:auto"></div>'
						  var opzioneDaAggiungere = "lampRed"
						  var text = "ALLERTA"
				  }else if(stato == "X"){
					  html = '<div class="lamp lampNI" style="margin:auto"></div>';
					  	  var text = "NON IDONEO"
						  var opzioneDaAggiungere = "lampNI"
				  }else{
					  html = '<div class="lampNP" style="margin:auto">NON DETERMINATO</div>';
					  var text = "NON DETERMINATO"
						  var opzioneDaAggiungere = "lampNP"
				  	  
				  }
				  
					var cell = $("#ind_prest_"+id_misura);
					cell.html(html);
					
				
			
					var cell2 = $("#indice_prestazione_str_"+id_strumento);
					cell2.html(html);
					
					table.cell(cell2).invalidate();
					table =  $('#tabPM').DataTable();
					table.draw(false);
					
					var select = $("#filtro_indice");
		            ; // Valore dell'opzione da aggiungere

		            // Verifica se l'opzione esiste già
		            var opzioneEsistente = select.find('option[value="' + opzioneDaAggiungere + '"]').length > 0;

		            // Se l'opzione non esiste, aggiungila
		            if (!opzioneEsistente) {
		                select.append($('<option>', {
		                    value: opzioneDaAggiungere,
		                    text: text // Testo da visualizzare per l'opzione
		                }));
		            }
		            
		            
		            
		            var selectedClass = $('#filtro_indice').val();
		            
		            
		            var x = table.rows().data();
		            table.column(2).search(selectedClass).draw();
		         
		} 
		   
			
	
		  }
	
	});
	  
  }
  
  

  $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    }); 
  
  
  function openModalStampa(idMisura){
	  
	  
	  $('#id_misura_stampa').val(idMisura);
	  
	  $('#modalStampaEtichetta').modal();
  }
  
  
  $('#modalStampaEtichetta').on("hidden.bs.modal", function(){
	  
		$('#check_fs').iCheck('uncheck');
		$('#check_fuori_servizio').val(0); 
	  
  });
  
  $('#check_fs').on('ifClicked',function(e){
		if($('#check_fs').is( ':checked' )){
			$('#check_fs').iCheck('uncheck');
			$('#check_fuori_servizio').val(0); 
		}else{
			$('#check_fs').iCheck('check');
			$('#check_fuori_servizio').val(1); 
		}
	});

  
  
  function modalAllegati(pack,id_misura, note){
	  $('#myModalAllegati').modal();
	  $('#id_misura').val(id_misura);
	  $('#pack').val(pack);
	  $('#note_allegato').html(note);
  }
  
  
	$("#fileupload_pdf").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_pdf')[0].files[0].name;
       	 $('#filename_label').html(file );
        }
        
		
	});

	var columsDatatables = [];
	 
	$("#tabMisure").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabMisure thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabMisure thead th').eq( $(this).index() ).text();
	        if($(this).index()!= 0 ){
	        	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	    } );

	} );

	
	function validateAllegati(){
		var filename = $('#fileupload_pdf').val();
		//var filename = $('#fileupload_pdf')[0].files[0].name;
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegati("fromModal");
		}
	}
  
	 function modalNuovaMisura(){
		 
		 var lista_interventi_utenti = "${lista_interventi_utente_size}";
		 
		 if(lista_interventi_utenti == "0"){
			 $('#myModalErrorContent').html("Nessun intervento associato all'utente! Contattare l'amministratore");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#myModalError').modal();
		 }else{
			 $("#modalNuovaMisura").removeClass("modal-fullscreen");
			 $('#modalNuovaMisura').modal();
		 }
		 
		
	 }
	 
	 $('#fileupload_certificato').change(function(){
			$('#label_certificato').html($(this).val().split("\\")[2]);
			 
		 });
	
	 
	 $('#formNuovaMisura').on('submit',function(e){
		    e.preventDefault();
		    
		    $('#id_strumento').val("${id_strumento}")
		    if($('#id_strumento').val()!=null && $('#id_strumento').val()!=''){
		    	submitNuovaMisura(null,cliente);
		    }else{
		    	  $('#myModalErrorContent').html("Attenzione! Nessuno strumento selezionato!");
	 			  	$('#myModalError').removeClass();
	 				$('#myModalError').addClass("modal modal-danger");	 
	 				$('#myModalError').modal('show');
		    }
		}); 
	 
	 
   	 $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	 
    $(document).ready(function() {
    	
    	$('#id_intervento').select2();
    	$('#indice_prestazione').select2();
    
    	
    	var colDef =[];
    	
    	if("${userObj.checkRuolo('AM') || userObj.checkRuolo('OP') || userObj.checkRuolo('CI')}"){
    		colDef=	[
				   { responsivePriority: 1, targets: 1 },
           { responsivePriority: 2, targets: 2 },
         	{ responsivePriority: 3, targets: 8 },
           { responsivePriority: 4, targets: 3 },
        
          { responsivePriority: 4, targets: 12 },
          { responsivePriority: 4, targets: 9 }
        
       ]
    	}else{
    		colDef=	[
				   { responsivePriority: 1, targets: 1 },
              { responsivePriority: 2, targets: 2 },
            	{ responsivePriority: 3, targets: 8 },
              { responsivePriority: 4, targets: 3 },
           
             { responsivePriority: 4, targets: 11 }
           
          ]
    	}

    	console.log("test");

    	tableMisure = $('#tabMisure').DataTable({
    		language: {
  	        	emptyTable : 	"Nessun dato presente nella tabella",
  	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
  	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
  	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
  	        	infoPostFix:	"",
  	        infoThousands:	".",
  	        lengthMenu:	"Visualizza _MENU_ elementi",
  	        loadingRecords:	"Caricamento...",
  	        	processing:	"Elaborazione...",
  	        	search:	"Cerca:",
  	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
  	        	paginate:	{
	  	        	first:	"Inizio",
	  	        	previous:	"Precedente",
	  	        	next:	"Successivo",
	  	        last:	"Fine",
  	        	},
  	        aria:	{
	  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
	  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
  	        }
	        },
	        pageLength: 100,
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: false,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 1 },
  	                   { responsivePriority: 2, targets: 2 },
  	                 	{ responsivePriority: 3, targets: 8 },
  	                   { responsivePriority: 4, targets: 3 },
  	                
  	                  { responsivePriority: 4, targets: 12 },
 	                  { responsivePriority: 4, targets: 9 }
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
    				
  	                         
  	          ]
  	    	
  	      
  	    });
    	
    	tableMisure.buttons().container().appendTo( '#tabMisure_wrapper .col-sm-6:eq(1)');
 
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	resetCalendar("#prenotazione");
     	})


  	    $('.inputsearchtable').on('click', function(e){
  	       e.stopPropagation();    
  	    });
  // DataTable
	tableMisure = $('#tabMisure').DataTable();
  // Apply the search
   tableMisure.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableMisure.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableMisure
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } );  
  tableMisure.columns.adjust().draw();
    	
	
	$('#tabMisure').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });

    function closeModal(){
    	$('#myModalAllegati').modal('hide');
    }
    
  </script>


  
 

 