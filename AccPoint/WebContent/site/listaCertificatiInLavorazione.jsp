<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");


	%>
	<div class="row padding-bottom-30" >
	     <div class="col-xs-12" id="apporvaSelectedButtonGroup">
            <button id="approvaSelected" class="btn btn-success">Genera Selezionati</button>
            <button id="annullaSelected" class="btn btn-danger">Annulla Selezionati</button>
         </div>
	  </div>
	  
	  <c:if test="${userObj.checkRuolo('AM') }">
	  	<div class="row" >
	  		<div class="col-sm-3">
       		<label>Data Emissione</label>
       	</div>
	     <div class="col-xs-12" >
	              <div class='input-group date datepicker' id='datepicker_data_emissione' style="width:370px">
               <input type='text' class="form-control input-small" id="data_emissione" name="data_emissione" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
	     </div>
	     </div><br>
	  
	  </c:if>
	<div class="row" >
	     <div class="col-xs-12" >
	     
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
  <th><input id="selectAlltabPM" type="checkbox" /></th>
   <th>ID Certificato</th>
  <th>Commessa</th>
  <th>Strumento</th>
  <th>Matricola | Cod</th>
 <th>Cliente</th>
 <th>Presso</th>
 <th>Data Misura</th>
   <th>Obsoleta</th>
    <th>Operatore</th>
    <th>Numero certificato</th>
 <th style="min-width:250px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	<td></td>
		<td></td>
	<td>${certificato.id}</td>
	
 		<td>${certificato.misura.intervento.idCommessa}</td>
		<td>${certificato.misura.strumento.denominazione}</td>
		<td>${certificato.misura.strumento.matricola} | ${certificato.misura.strumento.codice_interno}</td>
		<td>${certificato.misura.intervento.nome_cliente} - ${certificato.misura.intervento.nome_sede}</td>
		<td> 
		
		<c:choose>
  <c:when test="${certificato.misura.intervento.pressoDestinatario == 0}">
		<span class="label label-success">IN SEDE</span>
  </c:when>
  <c:when test="${certificato.misura.intervento.pressoDestinatario == 1}">
		<span class="label label-info">PRESSO CLIENTE</span>
  </c:when>
   <c:when test="${certificato.misura.intervento.pressoDestinatario == 2}">
		<span class="label label-warning">MISTO CLIENTE - SEDE</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
		
		</td>

		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataMisura}" /></td>
						<td align="center"> 
			<span class="label bigLabelTable <c:if test="${certificato.misura.obsoleto == 'S'}">label-danger</c:if><c:if test="${certificato.misura.obsoleto == 'N'}">label-success </c:if>">${certificato.misura.obsoleto}</span> </td>
 				
 		


<td>${certificato.misura.interventoDati.utente.nominativo}</td>
<td>${certificato.misura.nCertificato}</td>
		<td class="actionClass" align="center" style="min-width:200px">
		<a  target="_blank"  class="btn btn-info customTooltip" title="Click per aprire il dettaglio delle Misure"  href="dettaglioMisura.do?idMisura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"  onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}"   onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a>
			<c:choose>
			<c:when test="${certificato.misura.misuraLAT.misura_lat.id==1 }">
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="openModalLoadFile(${certificato.id}, 0)"><i class="fa fa-check"></i></button>
			</c:when>
			<c:when test="${certificato.misura.misuraLAT.misura_lat.id==2 }">
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaCertificatoLat(${certificato.id},${certificato.misura.misuraLAT.misura_lat.id })"><i class="fa fa-check"></i></button>
			</c:when>
			<c:when test="${certificato.misura.lat=='E' }">
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaCertificatoSE(${certificato.id})"><i class="fa fa-check"></i></button>
			</c:when>			
			<c:otherwise>
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaCertificato(${certificato.id})"><i class="fa fa-check"></i></button>
			</c:otherwise>
			</c:choose>
			
			<button class="btn btn-danger  customTooltip" title="Click per anullare il Certificato" onClick="annullaCertificato(${certificato.id})"><i class="fa fa-close"></i></button>
 			<c:if test="${certificato.misura.misuraLAT.misura_lat.id==2 }">
			<button class="btn btn-success  customTooltip" title="Riemetti certificato esistente" onClick="getListaCertificatiprecedenti('${certificato.misura.misuraLAT.strumento.__id}','${certificato.id }')"><i class="fa fa-copy"></i></button>
			</c:if> 
			 <c:if test="${certificato.misura.misuraLAT.misura_lat.id==1 }">
			<button class="btn btn-success  customTooltip" title="Riemetti certificato esistente" onClick="getListaCertificatiprecedenti('${certificato.misura.misuraLAT.strumento.__id}','${certificato.id }')"><i class="fa fa-copy"></i></button>
			</c:if> 
		</td>
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table>  
   </div>
	  </div>


<c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">
	      
	    <c:set var = "intervento" scope = "session" value = "${certificato.misura.intervento}"/>
	 	<c:set var = "interventoDati" scope = "session" value = "${certificato.misura.interventoDati}"/>
	 
	 <div id="interventiModal${loop.index}" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="interventoModalTitle">Dettaglio Intervento</h4>
      </div>
       <div class="modal-body" id="interventoModalLabelContent">


			<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                   <b>ID</b> <a class="btn customlink pull-right" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(intervento.id)}');">${intervento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Presso</b> <a class="pull-right">
<c:choose>
  <c:when test="${intervento.pressoDestinatario == 0}">
		<span class="label label-info">IN SEDE</span>
  </c:when>
  <c:when test="${intervento.pressoDestinatario == 1}">
		<span class="label label-warning">PRESSO CLIENTE</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
   
		</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${intervento.nome_sede}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
			<c:if test="${not empty intervento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataCreazione}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">

   						 <span class="label label-info">${intervento.statoIntervento.descrizione}</span>


				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nominativo}</a>
                </li>
                
                <li class="list-group-item">
                  <b>Nome pack</b>  

    <a class="pull-right">${intervento.nomePack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Generati</b> <a class="pull-right">${intervento.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">

  					 ${intervento.nStrumentiMisurati}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${intervento.nStrumentiNuovi}</a>
                </li>
                
                
        	</ul>





  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
	 
<div id="interventiDatiModal${loop.index}" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="interventoModalTitle">Dettaglio Intervento Dati</h4>
      </div>
       <div class="modal-body" id="interventoModalLabelContent">


			<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Data Caricamento</b> <a class="pull-right">
                  <c:if test="${not empty interventoDati.dataCreazione}">
   					<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoDati.dataCreazione}" />
					</c:if></a>
                </li>
               
                <li class="list-group-item">
                  <b>Nome Pasck</b> <a class="pull-right">${interventoDati.nomePack}</a>
                </li>
               

                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">

   						 <span class="label label-info">${interventoDati.stato.descrizione}</span>


				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventoDati.utente.nominativo}</a>
                </li>
                
            
                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">

  					 ${interventoDati.numStrMis}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${interventoDati.numStrNuovi}</a>
                </li>
                
                
        	</ul>





  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>


<div id="modalLoadFile" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel"  style="z-index:10000">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="interventoModalTitle">Caricare Immagine Livella</h4>
      </div>
       <div class="modal-body" >
       <div class="row">
		<div class="col-xs-6">
		<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload" accept=".png,.PNG,.jpg,.JPG,.jpeg,.JPEG"  type="file" name="fileupload" class="form-control"/>
		   	 </span>
		   	 </div>
		   	 <div class="col-xs-6">
			<div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
			</div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
	 
	 
	</c:forEach>
	
	   <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index:10000">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler riemettere il certificato selezionato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_certificato_riemissione">
      <input type="hidden" id="id_certificato_new">
      <input type="hidden" id="lat_master_type">
      
      <a class="btn btn-primary" onclick="checkLatMaster($('#lat_master_type').val(), $('#lat_master_type').val())">SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Seleziona il certificato da riemettere</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th>ID Certificato</th>
<th>ID Misura</th>
<th>Strumento</th>
<th>Matricola</th>
<th>Data misura</th>
<th>Operatore</th>
<th>Commessa</th>
<th>Numero certificato</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		<a class="btn btn-default pull-right"  style="margin-left:5px"onClick="modalYesOrNo()">Riemetti</a>
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
  </div>
</div>
</div>

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">

	var listaStrumenti = '${listaCampioniJson}';

   </script>
   
   <script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>

  <script type="text/javascript">
  
  function checkLatMaster(type){
	  
	  if(type == 1){
		  riemettiCertificato($('#id_certificato_riemissione').val(), $('#id_certificato_new').val());
	  }else{
		  openModalLoadFile($('#id_certificato_new').val(), 1);
	  }
	  
  }

  function riemettiCertificato(id_certificato_old, id_certificato_new){
		 
		 var dataObj = {};
		 dataObj.id_certificato_old = id_certificato_old;
		 dataObj.id_certificato_new = id_certificato_new;
		
		  
		  $.ajax({
		    	  type: "POST",
		    	  url: "listaCertificati.do?action=riemetti_certificato",
		    	  data: dataObj,
		    	  dataType: "json",
		    	  success: function( data, textStatus) {
		    		  
		    		  pleaseWaitDiv.modal('hide');
		    		  $(".ui-tooltip").remove();
		    		  if(data.success)
		    		  { 
		    			 location.reload()

		    		
		    		  }else{
		    			  $('#myModalErrorContent').html("Errore nel salvataggio!");
		    			  
		    			  	$('#myModalError').removeClass();
		    				$('#myModalError').addClass("modal modal-danger");
		    				$('#report_button').show();
		    	  			$('#visualizza_report').show();
		    				$('#myModalError').modal('show');
		    			 
		    		  }
		    	  },
		
		    	  error: function(jqXHR, textStatus, errorThrown){
		    		  pleaseWaitDiv.modal('hide');
		
		    		  $('#myModalErrorContent').html(textStatus);
		    		  $('#myModalErrorContent').html(data.messaggio);
		    		  	$('#myModalError').removeClass();
		    			$('#myModalError').addClass("modal modal-danger");
		    			$('#report_button').show();
		  			$('#visualizza_report').show();
						$('#myModalError').modal('show');
							
		    	  }
	});
		 
	 }
	 
	 function modalYesOrNo(){

		 
	 var table = $("#table_storico").DataTable();
		 
		 var str = "";
		 
		 
		 $('#table_storico tbody tr').each(function(){
			 if($(this).hasClass("selected")){
				 var td = $(this).find('td').eq(1);
				 str = str+td[0].innerText;
			 }
			
		 });
		 
		if(str == ''){
			$('#myModalErrorContent').html("Nessun certificato selezionato!")
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#myModalError').modal('show');		
		}else{

			 $('#id_certificato_riemissione').val(str);			 
			 
			 $('#myModalYesOrNo').modal();
		}
		 
		 
		

	 }
	 
  
  
function getListaCertificatiprecedenti(id_strumento, id_certificato, lat_master){
	  
	  dataString ="action=certificati_precedenti&id_strumento="+ id_strumento;
	     exploreModal("listaCertificati.do",dataString,null,function(datab,textStatusb){
	   	  	
	   	  var result =datab;
	   	  
	   	  if(result.success){
	   		 
	   		  var table_data = [];
	   		  
	   		  var lista_certificati = result.lista_certificati;
	   		  
	   		  for(var i = 0; i<lista_certificati.length;i++){
	   			  var dati = {};
	   			   				 
	   			  dati.check="";
	   			  dati.id = lista_certificati[i].id;	   			
	   			  dati.id_misura = lista_certificati[i].misura.id;	   			  
	   			  dati.strumento = lista_certificati[i].misura.strumento.denominazione;  
	   			  dati.matricola = lista_certificati[i].misura.strumento.matricola;  
	   			  dati.data_misura = lista_certificati[i].misura.dataMisura;
	   			  dati.operatore = lista_certificati[i].misura.user.nominativo;
	   			  dati.commessa = lista_certificati[i].misura.intervento.idCommessa;
	   			  if(lista_certificati[i].misura.nCertificato!=null){
	   				dati.numero_certificato = lista_certificati[i].misura.nCertificato;
	   			  }else{
	   				dati.numero_certificato = "";  
	   			  }
	   			  
	   			 
	   			  table_data.push(dati);
	   			  
	   		  }
	   		  var t = $('#table_storico').DataTable();
	   		  
	    		   t.clear().draw();
	    		   
	    			t.rows.add(table_data).draw();
	    			t.columns.adjust().draw();
	  			
	  		  $('#myModalStorico').modal();
	  			
	  		  
	  		$('#id_certificato_new').val(id_certificato);
	  		$('#lat_master_type').val(lat_master);
	   	  }
	   	  
	   	  $('#myModalStorico').on('shown.bs.modal', function () {
	   		  var t = $('#table_storico').DataTable();
	   		  
	   			t.columns.adjust().draw();
	 			
	   		})
	   	  
	     });
	  
 }
  
  
  
  function openModalLoadFile(id_certificato, type){
	  $('#myModalYesOrNo').hide();
	  $('#modalLoadFile').modal();
	  
	  if(type==0){
		 var url =  "listaCertificati.do?action=livella_bolla&idCertificato="+id_certificato
	  }else if(type==1){
		  var id_certificato_old = $('#id_certificato_riemissione').val();
		  var url =  "listaCertificati.do?action=riemetti_certificato&id_certificato_old="+id_certificato_old+"&id_certificato_new="+id_certificato
	  }
	  
	  $('#fileupload').fileupload({
			 url: url,
			 dataType: 'json',	 
			 getNumberOfFiles: function () {
			     return this.filesContainer.children()
			         .not('.processing').length;
			 }, 
			 start: function(e){
			 	pleaseWaitDiv = $('#pleaseWaitDialog');
			 	pleaseWaitDiv.modal();
			 	
			 },
			 singleFileUploads: false,
			  add: function(e, data) {
			     var uploadErrors = [];
			     var acceptFileTypes = /(\.|\/)(jpg|jpeg|png)$/i;
			   
			     for(var i =0; i< data.originalFiles.length; i++){
			    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
				         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
				         break;
				     }	 
			    	 if(data.originalFiles[i]['size'] > 30000000) {
				         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 30mb');
				         break;
				     }
			     }	     		     
			     if(uploadErrors.length > 0) {
			     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
			 			$('#myModalError').removeClass();
			 			$('#myModalError').addClass("modal modal-danger");
			 			$('#myModalError').modal('show');
			     } 
			     else {
			         data.submit();
			     }  
			 },
			
			 done: function (e, data) {
			 		
			 	pleaseWaitDiv.modal('hide');
			 	
			 	if(data.result.success){
			 		
			 		$('#modalLoadFile').modal('hide');
			 		$('#myModalAllegatiArchivio').modal('hide');
			 		$('#myModalErrorContent').html(data.result.messaggio);
		 			$('#myModalError').removeClass();
		 			$('#myModalError').addClass("modal modal-success");
		 			$('#myModalError').modal('show');
			 	}else{		 			
			 			$('#myModalErrorContent').html(data.result.messaggio);
			 			$('#myModalError').removeClass();
			 			$('#myModalError').addClass("modal modal-danger");
			 			$('#report_button').show();
			 			$('#visualizza_report').show();
			 			$('#myModalError').modal('show');
			 		}
			 },
			 fail: function (e, data) {
			 	pleaseWaitDiv.modal('hide');

			     $('#myModalErrorContent').html(errorMsg);
			     
			 		$('#myModalError').removeClass();
			 		$('#myModalError').addClass("modal modal-danger");
			 		$('#report_button').show();
			 		$('#visualizza_report').show();
			 		$('#myModalError').modal('show');

			 		$('#progress .progress-bar').css(
			                'width',
			                '0%'
			            );
			 },
			 progressall: function (e, data) {
			     var progress = parseInt(data.loaded / data.total * 100, 10);
			     $('#progress .progress-bar').css(
			         'width',
			         progress + '%'
			     );

			 }
		 });		
	  
  }

	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}

	        if( $(this).index() == 2 || $(this).index() == 3 || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 8 || $(this).index() == 9 || $(this).index() == 10 || $(this).index() == 11){
	      	      var title = $('#tabPM thead th').eq( $(this).index() ).text();
	          	$(this).append( '<div><input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	          }else if($(this).index() != 0 && $(this).index() != 1  ){
	            	$(this).append( '<div style="height:34px"><input class="inputsearchtable" type="text" disabled /></div>');
	          }
	    } );
	} );
 
    $(document).ready(function() {
        $('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 });   
    	
    	table = $('#tabPM').DataTable({
    		pageLength: 100,
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
   	      order: [[ 2, "desc" ]],
   	   stateSave: true,
  	    select: {
        	style:    'multi+shift',
        	selector: 'td:nth-child(2)'
    	},
  	      columnDefs: [
						  
  	                 { targets: 0,  orderable: false },
  	                 { className: "select-checkbox", targets: 1,  orderable: false },
  	               { responsivePriority: 1, targets: 0 },
  	             { responsivePriority: 2, targets: 1 },
 	                { responsivePriority: 3, targets: 2 },
	                { responsivePriority: 4, targets: 3 },
	             	{ responsivePriority: 5, targets: 12 },
	               	{ responsivePriority: 6, targets: 4 },
	               	{ responsivePriority: 7, targets: 5 },
	               	{ responsivePriority: 8, targets: 8 },
	              	{ responsivePriority: 9, targets: 10 }
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 exportOptions: {
                         rows: { selected: true }
                     }
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 exportOptions: {
                         rows: { selected: true }
                     }
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	             
  	          ],
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
  	        }
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
 
     	    
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	
     	});
     	 $('#myModalError').on('hidden.bs.modal', function (e) {
     		 if($('#myModalError').hasClass('modal-success')){
     			filtraCertificati();
     			
     		 }
     		
       	  	
       	});

  
 
  $('.inputsearchtable').on('click', function(e){
	   e.stopPropagation();    
	});
  // DataTable
	table = $('#tabPM').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  
  table.columns.adjust().draw();
  
  var column = table.column( 3 );
  
	$('<div id="selectSearchTop"> </div>').appendTo( "#tabPM_length" );
	  var select = $('<select class="select2" style="width:370px"><option value="">Seleziona una Commessa</option></select>')
	      .appendTo( "#selectSearchTop" )
	      .on( 'change', function () {
	          var val = $.fn.dataTable.util.escapeRegex(
	              $(this).val()
	          );

	       column
	              .search( val ? '^'+val+'$' : '', true, false )
	              .draw();
	      } );
	  column.data().unique().sort().each( function ( d, j ) {
	      select.append( '<option value="'+d+'">'+d+'</option>' )
	  } );
	  
	 $(".select2").select2();
	 
	 
  	table.columns.adjust().draw();
    	
    	
  	
  	
  	
  	
  	
  	t = $('#table_storico').DataTable({
		language: {
	        	emptyTable : 	"Non sono presenti documenti antecedenti",
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
        pageLength: 25,
        "order": [[ 0, "desc" ]],
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,  
	      scrollX: false,
	      stateSave: true,	
	      select: {		
	    	  
	        	style:    'single',
	        	selector: 'td:nth-child(1)'
	    	}, 
	      columns : [
	    	{"data" : "check"},
	      	{"data" : "id"},
	      	{"data" : "id_misura"},
	      	{"data" : "strumento"},
	      	{"data" : "matricola"},
	      	{"data" : "data_misura"},
	      	{"data" : "operatore"},
	      	{"data" : "commessa"},
	      	{"data" : "numero_certificato"}
	       ],	
	           
	      columnDefs: [
	    	  
	    	  { className: "select-checkbox", targets:  0, orderable: false },
	    	  
	    	  
	               ], 	        
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	t.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	     t.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
      t
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  
	
/*     }); */

  	
  	
  	
  	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});
    	

  	$('input').on('ifChecked', function(event){  		
  		
    		   //table.rows().select();
    		   table.rows({ filter : 'applied'}).select();
    		      	  
  	});
  	$('input').on('ifUnchecked', function(event){
  		
    		 table.rows().deselect();
    	  
  	});
 
  	$("#approvaSelected").click(function(){
  	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
  		var dataSelected = table.rows( { selected: true } ).data();
  		var selezionati = {
  			    ids: [],  			    
  			};
  		for(i=0; i< dataSelected.length; i++){
  			dataSelected[i];
  			selezionati.ids.push(dataSelected[i][2]);
  		}
  		
  		approvaCertificatiMulti(selezionati);
  		
  	});
	$("#annullaSelected").click(function(){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		var dataSelected = table.rows( { selected: true } ).data();
		var selezionati = {
  			    ids: []
  			};
  		for(i=0; i< dataSelected.length; i++){
  			dataSelected[i];
  			selezionati.ids.push(dataSelected[i][2]);
  		}
  		
  		annullaCertificatiMulti(selezionati);
  	});
	
	  $('#selectAlltabPM').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	
	
    });

	
    $('#myModalError').on('hidden.bs.modal', function(){
    	 $('.modal-backdrop').hide();
    });
    
    

  </script>


 
