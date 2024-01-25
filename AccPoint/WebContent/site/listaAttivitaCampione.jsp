<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<% pageContext.setAttribute("newLineChar", "\r\n"); %>
<% pageContext.setAttribute("newLineChar2", "\n"); %>
    <% 

 JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

ArrayList<TipoCampioneDTO> listaTipoCampione = (ArrayList)session.getAttribute("listaTipoCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy"); 
%>
<div class="row">
<div class="col-xs-3">

<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalNuovaAttivita')">Nuova Attività</button><br><br>
<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalPianificaAttivita')">Pianifica Attività</button><br><br>
</div>
<div class="col-xs-9">
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaManutenzioni()" title="Click per scaricare la scheda di manutenzione"><i class="fa fa-file-pdf-o"></i> Scheda Manutenzione</a>
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaVerificaIntermedia()" style="margin-right:5px" title="Click per scaricare la scheda di verifica intermedia"><i class="fa fa-file-pdf-o"></i> Scheda Taratura/Conferma</a>
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaApparecchiaturaCampione()" style="margin-right:5px" title="Click per scaricare la scheda apparecchiatura"><i class="fa fa-file-pdf-o"></i> Scheda Apparecchiatura</a>

</div>
</div>

<div class="row">

<div class="col-xs-12">
<a class="btn customTooltip btn-info pull-right" onClick="apriScadenzario()" title="Click per aprire lo scadenzario"><i class="fa fa-calendar"></i> Vai allo scadenzario</a>


</div>
</div><br>

 <table id="tabAttivitaCampione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data</th>
 <th>Tipo Attivita</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_attivita}" var="attivita" varStatus="loop">
 <c:if test="${attivita.pianificata == 0 }">
 <tr>
<td>${attivita.id }</td>
<td>
<c:if test="${attivita.pianificata== 1}">
<fmt:formatDate pattern = "yyyy-MM-dd" value = "${attivita.data_scadenza}" />
</c:if>
<c:if test="${attivita.pianificata== 0}">
<fmt:formatDate pattern = "yyyy-MM-dd" value = "${attivita.data}" />
</c:if></td>
<td>${attivita.tipo_attivita.descrizione}</td>


</td>
<td>
<c:if test="${attivita.tipo_attivita.id==1}">
<%-- ${fn:replace(fn:replace(evento.descrizione.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')} --%>
<button class="btn customTooltip btn-info" onClick="dettaglioManutenzione('${utl:escapeJS(attivita.descrizione_attivita)}','${attivita.tipo_manutenzione }','${attivita.data }','${utl:escapeJS(attivita.operatore.nominativo) }')" title="Click per visualizzare l'attività di manutenzione"><i class="fa fa-arrow-right"></i></button>
</c:if>
<c:if test="${attivita.tipo_attivita.id==4 }">
<%-- ${fn:replace(fn:replace(evento.descrizione.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')} --%>
<button class="btn customTooltip btn-info" onClick="dettaglioFuoriServizio('${utl:escapeJS(attivita.descrizione_attivita)}','${attivita.data }','${utl:escapeJS(attivita.operatore.nominativo) }')" title="Click per visualizzare l'attività di fuori servizio"><i class="fa fa-arrow-right"></i></button>
</c:if>
<c:if test="${(attivita.tipo_attivita.id==2 || attivita.tipo_attivita.id==3) }">
<button class="btn customTooltip btn-info" onClick="dettaglioVerificaTaratura('${utl:escapeJS(attivita.tipo_attivita.descrizione) }','${attivita.data}','${utl:escapeJS(attivita.ente) }','${attivita.data_scadenza }','${utl:escapeJS(attivita.etichettatura) }','${attivita.stato }','${attivita.campo_sospesi }','${utl:escapeJS(attivita.operatore.nominativo) }','${attivita.certificato.misura.nCertificato }','${attivita.certificato.misura.id }','${utl:encryptData(attivita.certificato.misura.id)}','${attivita.numero_certificato }')" title="Click per visualizzare l'attività di verifica intermedia"><i class="fa fa-arrow-right"></i></button>
</c:if>
<button class="btn customTooltip btn-warning" onClick="modificaAttivita('${attivita.id}','${attivita.tipo_attivita.id }','${utl:escapeJS(attivita.descrizione_attivita)}','${attivita.data}','${attivita.tipo_manutenzione }','${utl:escapeJS(attivita.ente) }','${attivita.data_scadenza }','${utl:escapeJS(attivita.campo_sospesi) }','${attivita.operatore.id }','${utl:escapeJS(attivita.etichettatura) }','${attivita.stato }','${attivita.certificato.id }', '${attivita.pianificata }', '${attivita.numero_certificato }')" title="Click per modificare l'attività"><i class="fa fa-edit"></i></button>
 <c:if test="${attivita.allegato!=null && !attivita.allegato.equals('') }">
 	<button class="btn customTooltip btn-danger" onClick="callAction('gestioneAttivitaCampioni.do?action=download_allegato&id_attivita=${utl:encryptData(attivita.id)}')" title="Click per scaricare l'allegato"><i class="fa fa-file-pdf-o"></i></button>
 </c:if>
<%--  <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('RS') }">
 	<button class="btn customTooltip btn-danger" onClick="modalYesOrNo('${attivita.id}')" title="Click per eliminare l'attivita"><i class="fa fa-trash"></i></button>
 </c:if> --%>
</td>

	</tr>
 
 </c:if>

	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 

 
 
 
 
 
 <form class="form-horizontal" id="formNuovaAttivita">
<div id="modalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_nuova_man" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attività</h4>
      </div>
       <div class="modal-body" id="modalNuovaAttivitaContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_attivita" id="select_tipo_attivita" data-placeholder="Seleziona Tipo Attivita..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="attivita">	  
	                     <option value="${attivita.id}">${attivita.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker">
            <input class="form-control  required" id="data_attivita" type="text" name="data_attivita" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
    <div id="content"> 
       
       <%--
       <div id="content_1" >
       
        <div class="form-group">
         
        <div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
			  <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>
			 <div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">
	     	 <input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>
        			 
        </div><div class="form-group">
			 <div class="col-sm-2"><label class="pull-left">Operatore:</label></div><div class="col-sm-4">
			 <select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>
			 <div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>
			 <div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all" name="fileupload_all" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div> </div>
	</div>

	 
    <div id="content_2" style="display:none">
		
		 
		<div class="form-group"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>
	     	 <div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">
	     	 <input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>
	     	</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>
	     	<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>
	     	<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>
	     	<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>  	
	     	<div class="col-sm-2"><label class="pull-right">Certificato:</label></div><div class="col-sm-2"><input class="form-control" id="id_certificato" name="id_certificato" type="text" readonly/></div>
	     	<div class="col-sm-2"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>
	</div>
		 
  <div id="content_3" style="display:none">
			
		<div class="form-group"><div class="col-sm-2"><label >Ente:</label></div><div class="col-sm-4"><input class="form-control" id="ente" name="ente" type="text"/></div>
     	<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">
     	<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>
     	</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>
     	<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>
     	<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>')
     	<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>
     	<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>
     	<div class="col-sm-2" style="margin-top:15px"><label>Certificato:</label></div><div class="col-sm-4" style="margin-top:15px"><input class="form-control" id="id_certificato" name="id_certificato" type="text" readonly/></div><div>
     	<div class="col-sm-2" style="margin-top:15px"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>
	
		 
	 </div>
	 
	  <div id="content_4" style="display:none">
			
		 <div class='form-group'>			
			 <div class='col-sm-2'><label>Operatore:</label></div><div class='col-sm-4'>
			 <select class='form-control select2' data-placeholder='Seleziona Operatore...' id='operatore' name='operatore'><option value=''></option><c:forEach items='${lista_utenti}' var='utente'><option value='${utente.id}'>${utente.nominativo}</option></c:forEach></select></div></div>
			 <div class='form-group'> <div class='col-sm-2'><label >Descrizione Attività:</label></div>
			 <div class='col-sm-10'><textarea rows='5' style='width:100%' id='descrizione' name='descrizione' required></textarea></div></div><div class='row'><div class='col-sm-2'><span class='btn btn-primary fileinput-button'><i class='glyphicon glyphicon-plus'></i><span>Carica Allegato...</span><input accept='.pdf,.PDF,.p7m'  id='fileupload_all' name='fileupload_all' type='file'></span></div><div class='col-xs-5'><label id='label_file'></label></div> </div>
 
       
       
       </div>
        --%>
   
  
   
	 </div>     

  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="stato" name="stato" value="Idonea"/>
      <input type="hidden" id="etichettatura" name="etichettatura" value="Interna"/>
      <input type="hidden" id="id_affini_checked" name="id_affini_checked"> 
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
   
</div>

   </form>
   
   
<form class="form-horizontal" id="formModificaAttivita">
<div id="modalModificaAttivita" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel" >
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_modifica_man" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Attività</h4>
      </div>
       <div class="modal-body" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_attivita_mod" id="select_tipo_attivita_mod" data-placeholder="Seleziona Tipo Attivita..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="attivita">	  
	                     <option value="${attivita.id}">${attivita.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker_mod">
            <input class="form-control  required" id="data_attivita_mod" type="text" name="data_attivita_mod" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
       <div id="content_mod">

	</div>    

  		 </div>
      <div class="modal-footer">
       <input type="hidden" id="id_attivita" name="id_attivita">
       <input type="hidden" id="stato_mod" name="stato_mod"/>
      <input type="hidden" id="etichettatura_mod" name="etichettatura_mod"/>
     <!--  <input type="hidden" id="id_certificato_mod" name="id_certificato_mod"/> -->
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>

</div>

</form>
   
   

   <div id="modalCertificati" class="modal fade " role="dialog"  aria-labelledby="myModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_cert" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" >Seleziona Certificato</h4>
      </div>
       <div class="modal-body" >
     	<div id="content_certificati">
 
       </div>
	
       </div>      
  		 
      <div class="modal-footer">
       <a  class="btn btn-primary" onClick="selezionaCertificato()">Seleziona</a>
      </div>
      </div>
    </div>
  </div>

   
 <div id="modalDettaglioFuoriServizio" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_man_fs" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Dettaglio Fuori Servizio</h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     
	<div class="form-group">
  <div class="row">
	 <div class="col-sm-12">

        <div class="col-sm-6">
		<label >Data:</label>
			<input type="text" class="form-control" id="dettaglio_data_fs" readonly >
        </div>
		<div class="col-sm-6">
		<label >Operatore:</label>
			<input type="text" class="form-control" id="dettaglio_operatore_fs" readonly >
        </div>
      </div>
      </div><br>
      <div class="row">
        <div class="col-sm-12"><div class="col-sm-12">
             <textarea rows="5" style="width:100%" id="dettaglio_descrizione_fs" name="dettaglio_descrizione_fs" readonly></textarea>
</div>
        </div>
       </div>
       </div>
       </div>      
	
  		
      <div class="modal-footer">
       
      </div>
      </div>
    </div>
  </div>

   <div id="modalDettaglio" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_man" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Dettaglio Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     
	<div class="form-group">
  <div class="row">
	 <div class="col-sm-12">
		<div class="col-sm-4">
		<label >Tipo Manutenzione:</label>
			<input type="text" class="form-control" id="label_tipo_manutenzione" readonly >
        </div>
        <div class="col-sm-4">
		<label >Data:</label>
			<input type="text" class="form-control" id="dettaglio_data" readonly >
        </div>
		<div class="col-sm-4">
		<label >Operatore:</label>
			<input type="text" class="form-control" id="dettaglio_operatore" readonly >
        </div>
      </div>
      </div><br>
      <div class="row">
        <div class="col-sm-12"><div class="col-sm-12">
             <textarea rows="5" style="width:100%" id="dettaglio_descrizione" name="dettaglio_descrizione" readonly></textarea>
</div>
        </div>
       </div>
       </div>
       </div>      
	
  		
      <div class="modal-footer">
       
      </div>
      </div>
    </div>
  </div>


 



<div id="modalDettaglioVerificaTaratura" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_dtl" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabeldtl"></h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     <div class="row">
	<div class="form-group">
  	<div class="row">
	<div class="col-sm-12">
		<div class="col-sm-6">
		<label >Tipo Attività:</label>		
			 <input id="tipo_attivita_dtl" class="form-control pull-right" readonly>
        </div>
		
        <div class="col-sm-6">
        <label >Data Attività:</label>
             <input id="data_attivita_dtl" class="form-control  pull-right" readonly>
        </div>
        
        <div class="col-sm-6">
        <label >Ente:</label>
             <input id="ente_dtl" class="form-control" readonly>
        </div>
         <div class="col-sm-6">
        <label >Data Scadenza:</label>
             <input id="data_scadenza_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <c:if test="${campione.getCodice().startsWith('CDT')}">
        <label >Etichettatura di conferma:</label>
        </c:if>
          <c:if test="${!campione.getCodice().startsWith('CDT')}">
        <label >Laboratorio:</label>
        </c:if>
             <input id="etichettatura_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Stato:</label>
             <input id="stato_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Note:</label>
             <input id="campo_sospesi_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Operatore:</label>
             <input id="operatore_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Numero Certificato:</label>
             <input id="certificato_dtl" class="form-control  pull-right" readonly>
        </div>
        <div class="col-sm-3">
        <label >ID misura:</label>
             <input id="misura_dtl" class="form-control  pull-right" readonly>
             <input id="misura_enc" type="hidden">
        </div>
        <div class="col-sm-3">       
             <a class="btn btn-info customTooltip" style="margin-top:25px"title="Click per aprire il dettaglio della misura" id="btn_dtl" onClick="dettaglioMisura()"><i class="fa fa-tachometer"></i></a>
        </div>
       
    </div>    
        
        </div>
       </div>
       </div>      
	
  		 </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>

</div>




  <form class="form-horizontal" id="formPianificaAttivita">
<div id="modalPianificaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onClick="$('#modalPianificaAttivita').modal('hide');" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Pianifica Attività</h4>
      </div>
       <div class="modal-body" id="modalNuovoEventoContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_evento_pianifica" id="select_tipo_evento_pianifica" data-placeholder="Seleziona Tipo Attività..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="tipo">	  
	                     <option value="${tipo.id}">${tipo.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker_ev_pianifica">
            <input class="form-control  required" id="data_evento_pianifica" type="text" name="data_evento_pianifica" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       


  		 </div>
      <div class="modal-footer">

      
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
   
</div>

   </form>   

<form class="form-horizontal" id="formPianificaAttivitaMod">
<div id="modalPianificaAttivitaMod" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onClick="$('#modalPianificaAttivitaMod').modal('hide');" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Pianifica Attività</h4>
      </div>
       <div class="modal-body" id="modalNuovoEventoContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_evento_pianificato_mod" id="select_tipo_evento_pianificato_mod" data-placeholder="Seleziona Tipo Attività..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="tipo">	  
	                     <option value="${tipo.id}">${tipo.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker_ev_pianifica_mod">
            <input class="form-control  required" id="data_evento_pianificato_mod" type="text" name="data_evento_pianificato_mod" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       


  		 </div>
      <div class="modal-footer">
	<input type="hidden" id="id_evento_pianificato" name="id_evento_pianificato">
      
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
   
</div>

   </form>  
   


  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'attività?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_attivita_id">
      <a class="btn btn-primary" onclick="eliminaAttivita($('#elimina_attivita_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalAffini" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"  onClick="$('#modalAffini').modal('hide');" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione! Sono stati rilevati i seguenti campioni affini. Seleziona i campioni per i quali vuoi creare l'evento. </h4>
      </div>
       <div class="modal-body">       
      	<div id="content_affini"></div>
      	</div>
      <div class="modal-footer">
      

      <button class="btn btn-primary" id="btn_salva_affini" onclick="salvaAttivitaCampioniAffini()" >Salva</button>
		<!-- <a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a> -->
      </div>
    </div>
  </div>

</div>



<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<!--  <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		 -->

 <script type="text/javascript">
 
 
 function modalYesOrNo(id_attivita){
	 
	 $('#elimina_attivita_id').val(id_attivita);
	 $('#myModalYesOrNo').modal()
	 
 }
 
 
 
 function eliminaAttivita(id_attivita){
	  
	  var dataObj = {};
		dataObj.id_attivita = id_attivita;
		
						
	  $.ajax({
 type: "POST",
 url: "gestioneAttivitaCampioni.do?action=elimina",
 data: dataObj,
 dataType: "json",
 //if received a response from the server
 success: function( data, textStatus) {
	  //var dataRsp = JSON.parse(dataResp);
	  if(data.success)
		  {  
			$('#report_button').hide();
				$('#visualizza_report').hide();
				$('#myModalErrorContent').html(data.messaggio);
 			  	$('#myModalError').removeClass();
 				$('#myModalError').addClass("modal modal-success");
 				$('#myModalError').modal('show');      				
 				$('#myModalError').on('hidden.bs.modal', function(){
   					if($('#myModalError').hasClass('modal-success')){
   						
   						location.reload()
   					}
   				}); 
		  }else{
			
			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');			
		
		  }
 },
 error: function( data, textStatus) {

	  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');

 }
 });
}

 
 
 
 function generaSchedaManutenzioni(){
		
	 callAction("gestioneAttivitaCampioni.do?action=scheda_manutenzioni&id_campione="+datax[0]);
 }
 
 function generaSchedaVerificaIntermedia(){
		
	 callAction("gestioneAttivitaCampioni.do?action=scheda_verifiche_intermedie&id_campione="+datax[0]);
 }
 
 function generaSchedaApparecchiaturaCampione(){
		
	 callAction("gestioneAttivitaCampioni.do?action=scheda_apparecchiatura&id_campione="+datax[0]);
 }
 
 function dettaglioMisura(){
	 var id_misura = $('#misura_enc').val();
	 callAction("dettaglioMisura.do?idMisura="+id_misura);
 }
 
 function selezionaCertificato(){
	 $('#id_certificato').val($('#selected').val());
	 $('#id_certificato_mod').val($('#selected').val());
	 $('#modalCertificati').modal("hide");
 }
 
 function apriScadenzario(){
	 callAction("scadenziario.do?action=campioni&id_campione="+datax[0]+"&registro_eventi=0");
 }
 
 $('#select_tipo_attivita').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){		 

		 str_html=' <div class="form-group"> <div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
			.concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')
			.concat('	 <div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
			.concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
	        .concat('</div><div class="form-group">')
	        .concat(' <div class="col-sm-2"><label class="pull-left">Operatore:</label></div><div class="col-sm-4">')
	        .concat(' <select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
	        .concat(' <div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
	        .concat(' <div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all" name="fileupload_all" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div> </div>')
		 
		 
		/*  str_html='<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">'
			 .concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')	
		 .concat('<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>')
			 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')	
			 .concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4">')
			 .concat('<select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
			 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
			 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all" name="fileupload_all" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div> </div>'); */
	 }
	 
	 else if($(this).val()==2 ){
		

		 if(${campione.getCodice().startsWith('CDT')}){	 
		 str_html = '<div class="form-group"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>'
	     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
	     	 .concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
	     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>')
	     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
	     	.concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>')
	     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')     	
	     	.concat('<div class="col-sm-2"><label class="pull-right">Certificato:</label></div><div class="col-sm-2"><input class="form-control" id="id_certificato" name="id_certificato" type="text" readonly/></div>')
	     	.concat('<div class="col-sm-2"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>');
	
	 }else{
		 	str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore">'
		       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
			    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura"><input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
		        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interno</label><br> <input  id="check_esterna" name="check_esterna" type="checkbox"/>')
			    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso" name="presso" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
			    .concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')
			    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato" name="numero_certificato" type="text"/></div></div><div class="row"><div class="col-sm-2">')
			    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload" name="fileupload" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div></div>');
		
	 }
	 }
	 else if($(this).val()==3){
		 

		 
		 if(${campione.getCodice().startsWith('CDT')}){
			 str_html = '<div class="form-group"><div class="col-sm-2"><label >Ente:</label></div><div class="col-sm-4"><input class="form-control" id="ente" name="ente" type="text"/></div>'
		     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
		     	 .concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
		     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>')
		     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
		     	.concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>')
		     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')
		     	.concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>')
		     	.concat('<div class="col-sm-2" style="margin-top:15px"><label>Certificato:</label></div><div class="col-sm-4" style="margin-top:15px"><input class="form-control" id="id_certificato" name="id_certificato" type="text" readonly/></div><div>')
		     	.concat('<div class="col-sm-2" style="margin-top:15px"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>');
		 }else{
				str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore">'
			       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
				    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura"><input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
			        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interno</label><br> <input  id="check_esterna" name="check_esterna" type="checkbox"/>')
				    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso" name="presso" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
				    .concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')
				    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato" name="numero_certificato" type="text"/></div></div><div class="row"><div class="col-sm-2">')
				    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload" name="fileupload" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div></div>');
		 }
			
		 
		 
	 }
	 
	 
	 else if($(this).val()==4){
			

		 str_html="<div class='form-group'>"				
			 .concat("<div class='col-sm-2'><label>Operatore:</label></div><div class='col-sm-4'>")
			 .concat("<select class='form-control select2' data-placeholder='Seleziona Operatore...' id='operatore' name='operatore'><option value=''></option><c:forEach items='${lista_utenti}' var='utente'><option value='${utente.id}'>${utente.nominativo}</option></c:forEach></select></div></div>")
			 .concat("<div class='form-group'> <div class='col-sm-2'><label >Descrizione Attività:</label></div>")
			 .concat("<div class='col-sm-10'><textarea rows='5' style='width:100%' id='descrizione' name='descrizione' required></textarea></div></div><div class='row'><div class='col-sm-2'><span class='btn btn-primary fileinput-button'><i class='glyphicon glyphicon-plus'></i><span>Carica Allegato...</span><input accept='.pdf,.PDF,.p7m'  id='fileupload_all' name='fileupload_all' type='file'></span></div><div class='col-xs-5'><label id='label_file'></label></div> </div>");
	 }
	 
	 $('#content').html(str_html);
	 $('#select_tipo_manutenzione').select2();
	 $('#operatore').select2();
	 $('#datepicker_taratura').bootstrapDP({
		 
			format: "yyyy-mm-dd"
		});

	 $('#check_interna').click(function(){
		$('#check_esterna').prop("checked", false); 
		$('#etichettatura').val("Interna");
		$('#laboratorio').val("Interno");
		$('#presso').prop("readonly", true);
	 });
	 
	 $('#check_esterna').click(function(){
		$('#check_interna').prop("checked", false);
		$('#etichettatura').val("Esterna");
		$('#laboratorio').val("Esterno");
		$('#presso').prop("readonly", false);
	 });
	 

	 
	 $('#check_idonea').click(function(){
		 $('#check_non_idonea').prop("checked", false);
		 $('#stato').val("Idonea");
	 });
	 
	 $('#check_non_idonea').click(function(){
		 $('#check_idonea').prop("checked", false);
		 $('#stato').val("Non Idonea");
	 })

	 $('#fileupload_all').change(function(){
			$('#label_file').html($(this).val().split("\\")[2]);
			 
		 });
	 


 });
 
 function dettaglioFuoriServizio(descrizione,  data,operatore){
	 $('#dettaglio_descrizione_fs').val(descrizione);

	 $('#dettaglio_operatore_fs').val(operatore);
	 $('#dettaglio_data_fs').val(formatDate(data));
	 $('#modalDettaglioFuoriServizio').modal();
 };
 
 $('#select_tipo_attivita_mod').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){
		 
		 
/* 		 str_html=' <div class="form-group"> <div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
				.concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')
				.concat('	 <div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
				.concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
		        .concat('</div><div class="form-group">')
		        .concat(' <div class="col-sm-2"><label class="pull-left">Operatore:</label></div><div class="col-sm-4">')
		        .concat(' <select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
		        .concat(' <div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		        .concat(' <div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all" name="fileupload_all" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div> </div>')
			 */
		 
		          str_html=' <div class="form-group"> <div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione_mod" id="select_tipo_manutenzione_mod" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
				.concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')
				.concat('	 <div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod">')
				.concat('<input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
		        .concat('</div><div class="form-group">')	  
		 .concat('<div class="col-sm-2"><label class="pull-left">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
		 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione_mod" name="descrizione_mod" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all_mod" name="fileupload_all_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div> </div>')
		 
		 
		/*  str_html='<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione_mod" id="select_tipo_manutenzione_mod" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
		 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')	  
		 .concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
		 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione_mod" name="descrizione_mod" required></textarea></div></div><div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_all_mod" name="fileupload_all_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div> </div>') */

	 }
	 
	 else if($(this).val()==2){
			
		 
	 if(${campione.getCodice().startsWith('CDT')}){
		 str_html = '<div class="form-group"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>'
     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod">')
     	 .concat('<input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna_mod" name="check_interna_mod" type="checkbox"/><label >Interna</label><br><input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" /><label >Idonea</label><br>')
     	.concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div>')     	
     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')
     	.concat('<div class="col-sm-2"><label class="pull-right">Certificato:</label></div><div class="col-sm-2"><input class="form-control" id="id_certificato_mod" name="id_certificato_mod" type="text" readonly/></div>')
     	.concat('<div class="col-sm-2"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>');
	
	 }else{
		 str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%">'
		       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
			    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod"><input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
		        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna_mod" name="check_interna_mod" type="checkbox"/><label >Interno</label><br> <input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
			    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso_mod" name="presso_mod" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" checked/><label >Idonea</label><br>')
			    .concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')
			    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato_mod" name="numero_certificato_mod" type="text"/></div></div><div class="row"><div class="col-sm-2">')
			    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_mod" name="fileupload_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div></div>');
	 }
 }
	 else if($(this).val()==3){
	
		 
		 if(${campione.getCodice().startsWith('CDT')}){
				
			 str_html = '<div class="form-group"><div class="col-sm-2"><label >Ente:</label></div><div class="col-sm-4"><input class="form-control" id="ente_mod" name="ente_mod" type="text"/></div>'
	     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod">')
	     	 .concat('<input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
	     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna_mod" name="check_interna_mod" type="checkbox"/><label >Interna</label><br><input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
	     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" /><label >Idonea</label><br>')
	     	.concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div>')
	     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')
	     	.concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>')
	     	.concat('<div class="col-sm-2" style="margin-top:15px"><label>Certificato:</label></div><div class="col-sm-4" style="margin-top:15px"><input class="form-control" id="id_certificato_mod" name="id_certificato_mod" type="text" readonly/></div><div>')
	     	.concat('<div class="col-sm-2" style="margin-top:15px"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>');
		
		 }else{
			 str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%">'
			       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
				    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod"><input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
			        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna_mod" name="check_interna_mod" type="checkbox"/><label >Interno</label><br> <input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
				    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso_mod" name="presso_mod" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" checked/><label >Idonea</label><br>')
				    .concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')
				    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato_mod" name="numero_certificato_mod" type="text"/></div></div><div class="row"><div class="col-sm-2">')
				    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_mod" name="fileupload_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div></div>');
		 }
		 
		 
		 
		 
	 }
	 

	 
	 else if($(this).val()==4){
			
		 str_html="<div class='form-group'>"				
			 .concat("<div class='col-sm-2'><label>Operatore:</label></div><div class='col-sm-4'>")
			 .concat("<select class='form-control select2' data-placeholder='Seleziona Operatore...' id='operatore_mod' name='operatore_mod' style='width:100%'><option value=''></option><c:forEach items='${lista_utenti}' var='utente'><option value='${utente.id}'>${utente.nominativo}</option></c:forEach></select></div></div>")
			 .concat("<div class='form-group'> <div class='col-sm-2'><label >Descrizione Attività:</label></div>")
			 .concat("<div class='col-sm-10'><textarea rows='5' style='width:100%' id='descrizione_mod' name='descrizione_mod' required></textarea></div></div><div class='row'><div class='col-sm-2'><span class='btn btn-primary fileinput-button'><i class='glyphicon glyphicon-plus'></i><span>Carica Allegato...</span><input accept='.pdf,.PDF,.p7m'  id='fileupload_all_mod' name='fileupload_all_mod' type='file'></span></div><div class='col-xs-5'><label id='label_file'></label></div> </div>");
	 }
	 
	 $('#content_mod').html(str_html);
	 $('#select_tipo_manutenzione_mod').select2();
	 $('#operatore_mod').select2();
	 
	 $('#datepicker_taratura_mod').bootstrapDP({
		 
			format: "yyyy-mm-dd"
		});

	  $('#datetimepicker_mod').bootstrapDP({
			format: "yyyy-mm-dd"
		});


	 $('#check_interna_mod').click(function(){
		$('#check_esterna_mod').prop("checked", false); 
		if(${campione.codice.startsWith('CDT')}){
			$('#etichettatura_mod').val("Interna");
		}else{
			$('#etichettatura_mod').val("Interno");	
		}
		
		$('#laboratorio_mod').val("Interno");
		$('#presso_mod').val("");
		$('#presso_mod').prop("readonly", true);
	 });
	 
	 $('#check_esterna_mod').click(function(){
		$('#check_interna_mod').prop("checked", false);
		if(${campione.codice.startsWith('CDT')}){
			$('#etichettatura_mod').val("Esterna");
		}else{
			$('#etichettatura_mod').val("Esterno");	
		}
		
		$('#laboratorio_mod').val("Esterno");
		
		$('#presso_mod').prop("readonly", false);
	 });
	 
	 $('#check_idonea_mod').click(function(){
		 $('#check_non_idonea_mod').prop("checked", false);
		 $('#stato_mod').val("Idonea");
	 });
	 
	 $('#check_non_idonea_mod').click(function(){
		 $('#check_idonea_mod').prop("checked", false);
		 $('#stato_mod').val("Non Idonea");
	 })


	 
	 $('#fileupload_all_mod').change(function(){
			$('#label_file_mod').html($(this).val().split("\\")[2]);
			 
		 });
 });
 
 
function caricaMisura(){
	
	exploreModal("listaCertificati.do","action=certificati_misure_campione&idCamp="+datax[0],"#content_certificati");
	$('#modalCertificati').modal();
	
	 $('#modalCertificati').on('shown.bs.modal', function (){
		 tableCertificati = $('#tabCertificati').DataTable();
	    	tableCertificati.columns().eq( 0 ).each( function ( colIdx ) {
			 $( 'input', tableCertificati.column( colIdx ).header() ).on( 'keyup', function () {
				 tableCertificati
			      .column( colIdx )
			      .search( this.value )
			      .draw();
			 } );
			 } );    
		 tableCertificati.columns.adjust().draw(); 
});
} 

function dettaglioVerificaTaratura(tipo_attivita, data_attivita, ente, data_scadenza, etichettatura, stato, campo_sospesi, operatore, certificato, misura, misura_encrypted, numero_certificato){
	
	$('#myModalLabeldtl').html("Dettaglio "+tipo_attivita);
	
	$('#tipo_attivita_dtl').val(tipo_attivita);
	$('#data_attivita_dtl').val(formatDate(data_attivita));
	$('#ente_dtl').val(ente);

	$('#etichettatura_dtl').val(etichettatura);

	
	$('#stato_dtl').val(stato);
	$('#campo_sospesi_dtl').val(campo_sospesi);
	$('#operatore_dtl').val(operatore);
	$('#data_scadenza_dtl').val(formatDate(data_scadenza));
	
	if(certificato!=null && certificato!=''){
		$('#certificato_dtl').val(certificato);
	}else{
		$('#certificato_dtl').val(numero_certificato);
	}
		
	
	$('#misura_dtl').val(misura);
	if(misura==''){
		$('#btn_dtl').addClass("disabled");
	}else{
		$('#btn_dtl').removeClass("disabled");
	}
	$('#misura_enc').val(misura_encrypted)
	
	$('#modalDettaglioVerificaTaratura').modal();
}
 
 function dettaglioManutenzione(descrizione, tipo, data,operatore){
	 $('#dettaglio_descrizione').val(descrizione);
	 if(tipo==1){
		 $('#label_tipo_manutenzione').val("Preventiva");	 
	 }else{
		 $('#label_tipo_manutenzione').val("Straordinaria");
	 }
	 $('#dettaglio_operatore').val(operatore);
	 $('#dettaglio_data').val(formatDate(data));
	 $('#modalDettaglio').modal();
 };
 
 
 function modificaAttivita(id, tipo_attivita, descrizione, data, tipo_manutenzione, ente, data_scadenza, campo_sospesi, operatore, etichettatura, stato, id_certificato, pianificata, numero_certificato){
	 
	 if(pianificata == 1){
		 
		  $('#id_evento_pianificato').val(id);
		 
		 $('#select_tipo_evento_pianificato_mod').val(tipo_attivita);
		 $('#select_tipo_evento_pianificato_mod').change();
		 var date = formatDate(data_scadenza);
		 		 
		 $('#data_evento_pianificato_mod').val(data_scadenza);
		 
		 
		 $('#datetimepicker_ev_pianifica_mod').bootstrapDP({
			 
				format: "yyyy-mm-dd"
			});
		 
		 $('#modalPianificaAttivitaMod').modal();
		 
	 }else{
	 
	 
	 $('#select_tipo_attivita_mod').val(tipo_attivita);
	 $('#select_tipo_attivita_mod').change();
	 var date = formatDate(data);
	 $('#data_attivita_mod').val(date);
	 if(tipo_manutenzione!=null && tipo_manutenzione!=''){
		 $('#select_tipo_manutenzione_mod').val(tipo_manutenzione);
		 $('#select_tipo_manutenzione_mod').change();
	 }
	 $('#descrizione_mod').val(descrizione)
	 $('#id_attivita').val(id);
	 $('#operatore_mod').val(operatore);
	 $('#operatore_mod').change();
	 var date = formatDate(data_scadenza);
	 $('#data_scadenza_mod').val(date);
	 
	 $('#id_certificato_mod').val(id_certificato);
	 if(tipo_attivita==2 || tipo_attivita==3){
		 $('#ente_mod').val(ente);
		 $('#presso_mod').val(ente);
		 
			
		
		 $('#campo_sospesi_mod').val(campo_sospesi);
		 
		 if(numero_certificato!=null){
			 $('#numero_certificato_mod').val(numero_certificato);
		 }
		 
		 if(etichettatura=='Interna' || etichettatura == 'Interno'){
			 $('#check_interna_mod').prop("checked", true); 
			 $('#etichettatura_mod').val("Interna");
			 $('#presso_mod').prop("readonly", true);
		 }else{
			 $('#check_esterna_mod').prop("checked", true); 
			 $('#etichettatura_mod').val("Esterna");
			 $('#presso_mod').prop("readonly", false);
		 }
		 if(stato=='Idonea'){
			 $('#check_idonea_mod').prop("checked", true);
			 $('#stato_mod').val("Idonea");
		 }else{
			 $('#check_non_idonea_mod').prop("checked", true);
			 $('#stato_mod').val("Non Idonea");
		 }
	 }

	 $('#modalModificaAttivita').modal();
	 }
 }
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("yyyy-MM-dd");
		   }			   
		   return str;	 		
	}
 
	var columsDatatables = [];
	 
	$("#tabAttivitaCampione").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabAttivitaCampione thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabAttivitaCampione thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );



	
	function generaSchedaApparecchiatura(id_evento, id_campione){
		
		var dataString =  "?action=genera_scheda&id_evento="+id_evento+"&id_campione="+id_campione;
		callAction('registroEventi.do'+dataString);
	}
	
  $(document).ready(function() {
 console.log("test");
	  $(".select2").select2();
	  $('#datetimepicker').bootstrapDP({
			format: "yyyy-mm-dd"
		});
	  
	  $('#datetimepicker_ev_pianifica').bootstrapDP({
			format: "yyyy-mm-dd"
		});
	 	
	  $('#modalCertificati').css("overflow", "visible");
	  $('#modalModificaAttivita').css("overflow", "hidden");
	  $('#modalNuovaAttivita').css("overflow", "hidden");
 tab = $('#tabAttivitaCampione').DataTable({
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
     pageLength: 10,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      "order": [[ 0, "desc" ]],
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
tab = $('#tabAttivitaCampione').DataTable();
//Apply the search
tab.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
   tab
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	tab.columns.adjust().draw();
	

$('#tabAttivitaCampione').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 
  
  
  function getCodiciAffini(){
	  
	  dataObj = {};
	  
	  dataObj.id_campione = datax[0]
	  
	  callAjax(dataObj,"gestioneAttivitaCampioni.do?action=codici_affini", function(datab, textStatusb){
		  
			var str = "<ul class='list-group list-group-unbordered'><li class='list-group-item'><div class='row'> <div class='col-xs-8'><label>Codice</label> </div><div class='col-xs-2'><input class='pull-right' type='checkbox' onclick='checkAllAffini()'  id='check_affini_all' name='check_affini_all'><label class='pull-right'>Sel. tutti</label></div></div></li>";

		
		  if(datab.lista_campioni_affini.length>0){
			 
			  for (var i = 0; i < datab.lista_campioni_affini.length; i++) {
				  if(datab.lista_campioni_affini[i].id == datax[0]){
					  str = str + "<li  class='list-group-item'><div class='row'> <div class='col-xs-8'>" +datab.lista_campioni_affini[i].codice+"</div> <div class='col-xs-2'><input class='pull-right check_affini' type='checkbox' onclick='checkCampioneAffine("+datab.lista_campioni_affini[i].id+")' id='check_affini_"+datab.lista_campioni_affini[i].id+"' name='check_affini_"+datab.lista_campioni_affini[i].id+"' checked> </div></div></li>"
					  $("#id_affini_checked").val($("#id_affini_checked").val()+datab.lista_campioni_affini[i].id+";");
				  }else{
					  str = str + "<li  class='list-group-item'><div class='row'> <div class='col-xs-8'>" +datab.lista_campioni_affini[i].codice+"</div> <div class='col-xs-2'><input class='pull-right check_affini' type='checkbox' onclick='checkCampioneAffine("+datab.lista_campioni_affini[i].id+")' id='check_affini_"+datab.lista_campioni_affini[i].id+"' name='check_affini_"+datab.lista_campioni_affini[i].id+"'> </div></div></li>"  
				  }
					
				}
			  
			  $('#content_affini').html(str);
			  
			  $('#modalAffini').modal();
			  
		  }else{
			  nuovaAttivitaCampione(datax[0])
		  }
		  
		  
	  });
	  
  }
  
  function checkCampioneAffine(id){
	  
	  
	  if($("#check_affini_"+id).prop("checked")== false){
		  $("#id_affini_checked").val($("#id_affini_checked").val().replace(id+";", ""));
	  }else{
		  $("#id_affini_checked").val($("#id_affini_checked").val()+id+";");
	  }
	  
	
  }
  function checkAllAffini(){
	  
	  var checked = true;
	  
	  if($("#check_affini_all").prop("checked") == false){
		  checked = false;
	  }
	  	 

	  $(".check_affini").each(function(index, item){
		  var id = item.id;
		  if(checked){
			  
			  if($("#"+id).prop("checked")== false){
				  $("#"+id).prop("checked", true);
				  $("#id_affini_checked").val($("#id_affini_checked").val()+id.split("_")[2]+";");
			  }
			  
		  }else{
			  if($("#"+id).prop("checked") ){
				  $("#"+id).prop("checked", false);
				  $("#id_affini_checked").val($("#id_affini_checked").val().replace(id.split("_")[2]+";", ""));
			  }
		  }
	
	
		  
	  });
	  
	  
  }
 
  
  function salvaAttivitaCampioniAffini(){
	  
	  if($('#id_affini_checked').val()==""){
		  $('#myModalErrorContent').html("Seleziona almeno un campione!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').hide();
			$('#visualizza_report').hide();
			$('#myModalError').modal('show');
	  }else{
		  nuovaAttivitaCampione(datax[0]);  
	  }
	  
	  
  }
  
  
  
  $('#formNuovaAttivita').on('submit',function(e){		
		e.preventDefault();
		
		getCodiciAffini()
		
		//nuovaAttivitaCampione(datax[0]);	  
	});
  
  $('#formModificaAttivita').on('submit',function(e){		
		e.preventDefault();
		var x = $('#etichettatura_mod').val();
		var z = $('#stato_mod').val();
		modificaAttivitaCampione(datax[0]);	  
	});
  
  $('#close_btn_man').on('click', function(){
	  $('#modalDettaglio').modal('hide');
  });
 
  $('#close_btn_nuova_man').on('click', function(){
	  $('#modalNuovaAttivita').modal('hide');
  });
  $('#close_btn_modifica_man').on('click', function(){
	  $('#modalModificaAttivita').modal('hide');
  });
  $('#close_btn_dtl').on('click', function(){
	  $('#modalDettaglioVerificaTaratura').modal('hide');
  });
  $('#close_btn_man_fs').on('click', function(){
	  $('#modalDettaglioFuoriServizio').modal('hide');
  });
  close_btn_cert
  $('#close_btn_cert').on('click', function(){
	  $('#modalCertificati').modal('hide');
  });

	  $('#modalNuovaAttivita').on('hidden.bs.modal', function(){
		  $('#content').html('');
		  $('#select_tipo_attivita').val("");
		  $('#select_tipo_attivita').change();
		  contentID == "registro_attivitaTab";
		  
	  }); 

	  $('#modalModificaAttivita').on('hidden.bs.modal', function(){
		  $('#content_mod').html('');
		  contentID == "registro_attivitaTab";
		  
	  }); 
	  $('#modalDettaglio').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   
	  $('#modalDettaglioFuoriServizio').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });  

	  $('#modalDettaglioVerificaTaratura').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   
	  
	  $('#modalCertificati').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 }); 
	  
	  $('#modalAffini').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 }); 
	  
	  $('#data_attivita').change(function(){
		  var frequenza;
		 
		  if($('#select_tipo_attivita').val()==2){
			  frequenza =  <%=campione.getFrequenza_verifica_intermedia()%>
		  }
		  else if($('#select_tipo_attivita').val()==1){
			  frequenza =  <%=campione.getFrequenza_manutenzione()%>
		  }
		  else if($('#select_tipo_attivita').val()==3){
			  frequenza =  <%=campione.getFreqTaraturaMesi()%>			  
		  }
		  
		  var data = new Date($('#data_attivita').val());		 
		 var data_scadenza = data.addMonths(frequenza);
		  $('#data_scadenza').val(formatDate(data_scadenza));
		 
	  });

	  
	  $('#data_attivita_mod').change(function(){
		  var frequenza;
		 
		  if($('#select_tipo_attivita_mod').val()==2){
			  frequenza =  <%=campione.getFrequenza_verifica_intermedia()%>
		  }
		  else if($('#select_tipo_attivita_mod').val()==1){
			  frequenza =  <%=campione.getFrequenza_manutenzione()%>
		  }
		  else if($('#select_tipo_attivita_mod').val()==3){
			  frequenza =  <%=campione.getFreqTaraturaMesi()%>			  
		  }
		  var data = new Date($('#data_attivita_mod').val());		 
		 var data_scadenza = data.addMonths(frequenza);
		  $('#data_scadenza_mod').val(formatDate(data_scadenza));
		 
	  });
	  
	  
	  $('#formPianificaAttivita').on('submit',function(e){		
			e.preventDefault();
			
			callAjaxForm('#formPianificaAttivita', 'gestioneAttivitaCampioni.do?action=pianifica_attivita&idCamp='+datax[0]);
		});
	  															
	  
	  $('#formPianificaAttivitaMod').on('submit',function(e){		
			e.preventDefault();
			
			callAjaxForm('#formPianificaAttivitaMod', 'gestioneAttivitaCampioni.do?action=modifica_attivita_pianificata&idCamp='+datax[0]);
		});
	  
</script>