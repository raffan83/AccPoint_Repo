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

<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalNuovoEvento')">Nuovo Evento</button><br><br>
</div>
<div class="col-xs-9">
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaManutenzioni()" title="Click per scaricare la scheda di manutenzione"><i class="fa fa-file-pdf-o"></i> Scheda Manutenzione</a>
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaTaratura()" style="margin-right:5px" title="Click per scaricare la scheda di verifica intermedia"><i class="fa fa-file-pdf-o"></i> Scheda Taratura</a>
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaApparecchiaturaCampione()" style="margin-right:5px" title="Click per scaricare la scheda apparecchiatura"><i class="fa fa-file-pdf-o"></i> Scheda Apparecchiatura</a>

</div>
</div>


 <table id="tabRegistroEventi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data</th>
 <th>Tipo Evento</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_eventi}" var="evento" varStatus="loop">
<tr>
<td>${evento.id }</td>
<td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${evento.data_evento}" /></td>
<td>${evento.tipo_evento.descrizione}</td>
<td>
<c:if test="${evento.tipo_evento.id==1 }">
<button class="btn customTooltip btn-info" onClick="dettaglioEventoManutenzione('${fn:replace(fn:replace(evento.descrizione.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')}','${evento.tipo_manutenzione.id }','${evento.data_evento }','${evento.operatore.nominativo }')" title="Click per visualizzare il dettaglio dell'evento"><i class="fa fa-arrow-right"></i></button>
</c:if>
<c:if test="${evento.tipo_evento.id==4 }">
<%-- ${fn:replace(fn:replace(evento.descrizione.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')} --%>
<button class="btn customTooltip btn-info" onClick="dettaglioFuoriServizio('${utl:escapeJS(evento.descrizione)}','${evento.data_evento }','${utl:escapeJS(evento.operatore.nominativo) }')" title="Click per visualizzare l'attività di fuori servizio"><i class="fa fa-arrow-right"></i></button>
</c:if>
<c:if test="${evento.tipo_evento.id==2 || evento.tipo_evento.id == 5  }">
<button class="btn customTooltip btn-info" onClick="dettaglioEventoTaratura('${evento.data_evento }','${evento.data_scadenza }','${evento.laboratorio }','${evento.campo_sospesi }','${evento.operatore.nominativo }','${evento.numero_certificato }','${evento.stato}')" title="Click per visualizzare il dettaglio dell'evento"><i class="fa fa-arrow-right"></i></button>
</c:if>

<a class="btn btn-warning customTooltip" title="Click per modificare l'evento" onClick="modificaEvento('${evento.id}','${evento.tipo_evento.id }','${utl:escapeJS(evento.descrizione)}','${evento.data_evento }','${evento.tipo_manutenzione.id }','${evento.data_scadenza }','${evento.campo_sospesi }','${evento.operatore.id }','${evento.laboratorio }','${evento.stato }','${evento.numero_certificato }')"><i class="fa fa-edit"></i></a>

<%-- ${fn:replace(fn:replace(attrezzatura.note_tecniche.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')}' --%>
  <%-- <a class="btn btn-warning customTooltip" title="Click per modificare l'evento" onClick="modificaEvento('${evento.id}','${evento.tipo_evento.id }','${fn:replace(fn:replace(evento.descrizione.replace('\'',' ').replace('\\','/'),newLineChar, ' '),newLineChar2, ' ')}','${evento.data_evento }','${evento.tipo_manutenzione.id }','${evento.data_scadenza }','${evento.campo_sospesi }','${evento.operatore.id }','${evento.laboratorio }','${evento.stato }','${evento.numero_certificato }')"><i class="fa fa-edit"></i></a> --%> 
 <%-- <a class="btn btn-warning customTooltip" title="Click per modificare l'evento" onClick="modificaEvento('${evento.id}','${evento.tipo_evento.id }','${evento.descrizione.replace('\'',' ').replace('\\','/') }','${evento.data_evento }','${evento.tipo_manutenzione.id }','${evento.data_scadenza }','${evento.campo_sospesi }','${evento.operatore.id }','${evento.laboratorio }','${evento.stato }','${evento.numero_certificato }')"><i class="fa fa-edit"></i></a> --%>
 <c:if test="${evento.allegato!=null && !evento.allegato.equals('') }">
 	<button class="btn customTooltip btn-danger" onClick="callAction('registroEventi.do?action=download&id_evento=${utl:encryptData(evento.id)}')" title="Click per scaricare l'allegato o il certificato"><i class="fa fa-file-pdf-o"></i></button>
 </c:if>
 

</td>

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 

 
 
 
 
 
  <form class="form-horizontal" id="formNuovoEvento">
<div id="modalNuovoEvento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_nuovo_evento" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Evento</h4>
      </div>
       <div class="modal-body" id="modalNuovoEventoContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Evento:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_evento" id="select_tipo_evento" data-placeholder="Seleziona Tipo Evento..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_evento}" var="tipo">	  
	                     <option value="${tipo.id}">${tipo.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Evento:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker_ev">
            <input class="form-control  required" id="data_evento" type="text" name="data_evento" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
       <div id="content_evento">
   
  
   
	</div>    

  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="stato" name="stato" value="Idonea"/>
      <input type="hidden" id="laboratorio" name="laboratorio" value="Interno"/>
      
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
   
</div>

   </form>
   
   
<form class="form-horizontal" id="formModificaEvento">
<div id="modalModificaEvento" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel" >
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_modifica_evento" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Evento</h4>
      </div>
       <div class="modal-body" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_evento_mod" id="select_tipo_evento_mod" data-placeholder="Seleziona Tipo Evento..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_evento}" var="tipo">	  
	                     <option value="${tipo.id}">${tipo.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Evento:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker_ev_mod">
            <input class="form-control  required" id="data_evento_mod" type="text" name="data_evento_mod" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
       <div id="content_evento_mod">

	</div>    

  		 </div>
      <div class="modal-footer">
       <input type="hidden" id="id_evento" name="id_evento">
       <input type="hidden" id="stato_mod" name="stato_mod"/>
      <input type="hidden" id="laboratorio_mod" name="laboratorio_mod"/>
     <!--  <input type="hidden" id="id_certificato_mod" name="id_certificato_mod"/> -->
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>

</div>

</form> 
   
   

   <!-- <div id="modalCertificati" class="modal fade " role="dialog"  aria-labelledby="myModalLabel" >

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
 -->
   


   <div id="modalDettaglioEventoManutenzione" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_evento_man_dtl" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Dettaglio Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalDettaglioEventoContent" >
     
	<div class="form-group">
  <div class="row">
	 <div class="col-sm-12">
		<div class="col-sm-4">
		<label >Tipo Manutenzione:</label>
			<input type="text" class="form-control" id="lbl_tipo_manutenzione" readonly >
        </div>
        <div class="col-sm-4">
		<label >Data:</label>
			<input type="text" class="form-control" id="lbl_dettaglio_data" readonly >
        </div>
		<div class="col-sm-4">
		<label >Operatore:</label>
			<input type="text" class="form-control" id="lbl_dettaglio_operatore" readonly >
        </div>
      </div>
      </div><br>
      <div class="row">
        <div class="col-sm-12"><div class="col-sm-12">
             <textarea rows="5" style="width:100%" id="lbl_dettaglio_descrizione" name="lbl_dettaglio_descrizione" readonly></textarea>
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



<div id="modalDettaglioEventoTaratura" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_evento_dtl" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
         <h4 class="modal-title" id="myModalLabel">Dettaglio Taratura</h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     <div class="row">
	<div class="form-group">
  	<div class="row">
	<div class="col-sm-12">
		
        <div class="col-sm-6">
        <label >Data Attività:</label>
             <input id="lbl_data_attivita_dtl" class="form-control  pull-right" readonly>
        </div>
        
         <div class="col-sm-6">
        <label >Data Scadenza:</label>
             <input id="lbl_data_scadenza_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Laboratorio:</label>
             <input id="lbl_laboratorio_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Stato:</label>
             <input id="lbl_stato_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Campo sospesi:</label>
             <input id="lbl_campo_sospesi_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Operatore:</label>
             <input id="lbl_operatore_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Numero Certificato:</label>
             <input id="lbl_certificato_dtl" class="form-control  pull-right" readonly>
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








<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<!--  <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		 -->

 <script type="text/javascript">
 
 

 $('#data_evento').change(function(){
	  var frequenza;
	 
	 
	frequenza =  <%=campione.getFreqTaraturaMesi()%>			  
	  
	  
	  var data = new Date($('#data_evento').val());		 
	 var data_scadenza = data.addMonths(frequenza);
	  $('#data_scadenza').val(formatDate(data_scadenza));
	 
 });
 
 
 function generaSchedaManutenzioni(){
		
	 callAction("registroEventi.do?action=scheda_manutenzioni&id_campione="+datax[0]);
 }
 
 function generaSchedaTaratura(){
		
	 callAction("registroEventi.do?action=scheda_tarature&id_campione="+datax[0]);
 }
 
 function generaSchedaApparecchiaturaCampione(){
		
	 callAction("registroEventi.do?action=scheda_apparecchiatura&id_campione="+datax[0]);
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
 
 
 function dettaglioFuoriServizio(descrizione,  data,operatore){
	 $('#dettaglio_descrizione_fs').val(descrizione);

	 $('#dettaglio_operatore_fs').val(operatore);
	 $('#dettaglio_data_fs').val(formatDate(data));
	 $('#modalDettaglioFuoriServizio').modal();
 };
 
 $('#select_tipo_evento').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){		 
		 

		 str_html='<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
			 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')	
			 .concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4">')
			 .concat('<select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
			 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
			 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div> <div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_man" name="fileupload_man" type="file"></span></div><div class="col-xs-5"><label id="label_file_man"></label></div>  </div>');
	 }
	 
	 else if($(this).val()==2 ){
	       	
	       	str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore">'
	       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
		    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura"><input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
	        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interno</label><br> <input  id="check_esterna" name="check_esterna" type="checkbox"/>')
		    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso" name="presso" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
		    .concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')
		    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato" name="numero_certificato" type="text"/></div></div><div class="row"><div class="col-sm-2">')
		    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload" name="fileupload" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div></div>');
	
	 }

	 else if($(this).val()==4){
			
		 str_html="<div class='form-group'>"				
			 .concat("<div class='col-sm-2'><label>Operatore:</label></div><div class='col-sm-4'>")
			 .concat("<select class='form-control select2' data-placeholder='Seleziona Operatore...' id='operatore' name='operatore'><option value=''></option><c:forEach items='${lista_utenti}' var='utente'><option value='${utente.id}'>${utente.nominativo}</option></c:forEach></select></div></div>")
			 .concat("<div class='form-group'> <div class='col-sm-2'><label >Descrizione Attività:</label></div>")
			 .concat("<div class='col-sm-10'><textarea rows='5' style='width:100%' id='descrizione' name='descrizione' required></textarea></div></div><div class='row'><div class='col-sm-2'><span class='btn btn-primary fileinput-button'><i class='glyphicon glyphicon-plus'></i><span>Carica Allegato...</span><input accept='.pdf,.PDF,.p7m'  id='fileupload_all' name='fileupload_all' type='file'></span></div><div class='col-xs-5'><label id='label_file'></label></div> </div>");
	 }
	 
	 
 else if($(this).val()==5 ){
		
		 
		 str_html = '<div class="form-group"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>'
	     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
	     	 .concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
	     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>')
	     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
	     	.concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>')
	     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')     	
	     	  .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato" name="numero_certificato" type="text"/></div></div><div class="row"><div class="col-sm-2">')
			    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload" name="fileupload" type="file"></span></div><div class="col-xs-5"><label id="label_file"></label></div></div>');
	
		 
	 }
	 
	 $('#content_evento').html(str_html);
	 $('#select_tipo_manutenzione').select2();
	 $('#operatore').select2();
	 $('#datepicker_taratura').bootstrapDP({
		 
			format: "yyyy-mm-dd"
		});

	 $('#check_interna').click(function(){
		$('#check_esterna').prop("checked", false); 
		$('#laboratorio').val("Interno");
		$('#presso').prop("readonly", true);
		
	 });
	 
	 $('#check_esterna').click(function(){
		$('#check_interna').prop("checked", false);
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

	 
	 $('#fileupload').change(function(){
			$('#label_file').html($(this).val().split("\\")[2]);
			 
		 });
	 
	 $('#fileupload_man').change(function(){
			$('#label_file_man').html($(this).val().split("\\")[2]);
			 
		 });

 });
 
 

 $('#select_tipo_evento_mod').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){
		 
		 str_html='<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione_mod" id="select_tipo_manutenzione_mod" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
		 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')	  
		 .concat('<div class="col-sm-2"><label class="pull-right">Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%"><option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div></div>')
		 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione_mod" name="descrizione_mod" required></textarea></div></div> <div class="row"><div class="col-sm-2"><span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Allegato...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_man_mod" name="fileupload_man_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_man_mod"></label></div> </div>')

	 }
	 
	 else if($(this).val()==2){
		
			str_html = '<div class="row"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%">'
		       	.concat('<option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div><div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div>')
			    .concat('<div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura_mod"><input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></div>')
		        .concat('</div><div class="row"><div class="col-sm-2"><label >Laboratorio:</label></div><div class="col-sm-4"> <input id="check_interna_mod" name="check_interna_mod" type="checkbox"/><label >Interno</label><br> <input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
			    .concat('<label >Esterno  </label> <input type="text" class ="form-control pull-right" style="width:60%" id="presso_mod" name="presso_mod" readonly></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" checked/><label >Idonea</label><br>')
			    .concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div></div><br><div class="row"><div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')
			    .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato_mod" name="numero_certificato_mod" type="text"/></div></div><div class="row"><div class="col-sm-2">')
			    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_mod" name="fileupload_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div></div>');
	 }
	 
	 else if($(this).val()==4){
			
		 str_html="<div class='form-group'>"				
			 .concat("<div class='col-sm-2'><label>Operatore:</label></div><div class='col-sm-4'>")
			 .concat("<select class='form-control select2' data-placeholder='Seleziona Operatore...' id='operatore_mod' name='operatore_mod' style='width:100%'><option value=''></option><c:forEach items='${lista_utenti}' var='utente'><option value='${utente.id}'>${utente.nominativo}</option></c:forEach></select></div></div>")
			 .concat("<div class='form-group'> <div class='col-sm-2'><label >Descrizione Attività:</label></div>")
			 .concat("<div class='col-sm-10'><textarea rows='5' style='width:100%' id='descrizione_mod' name='descrizione_mod' required></textarea></div></div><div class='row'><div class='col-sm-2'><span class='btn btn-primary fileinput-button'><i class='glyphicon glyphicon-plus'></i><span>Carica Allegato...</span><input accept='.pdf,.PDF,.p7m'  id='fileupload_all_mod' name='fileupload_all_mod' type='file'></span></div><div class='col-xs-5'><label id='label_file'></label></div> </div>");
	 }
	 
 else if($(this).val()==5 ){
		
		 
		 str_html = '<div class="form-group"><div class="col-sm-2"><label>Operatore:</label></div><div class="col-sm-4"><select class="form-control select2" data-placeholder="Seleziona Operatore..." id="operatore_mod" name="operatore_mod" style="width:100%" > <option value=""></option><c:forEach items="${lista_utenti}" var="utente"><option value="${utente.id}">${utente.nominativo}</option></c:forEach></select></div>'
	     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datepicker_taratura">')
	     	 .concat('<input class="form-control  required" id="data_scadenza_mod" type="text" name="data_scadenza_mod" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
	     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna_mod" name="check_interna_mod" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna_mod" name="check_esterna_mod" type="checkbox"/>')
	     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea_mod" name="check_idonea_mod" type="checkbox" checked/><label >Idonea</label><br>')
	     	.concat('<input  id="check_non_idonea_mod" name="check_non_idonea_mod" type="checkbox"/><label >Non Ideonea</label></div>')
	     	.concat('<div class="col-sm-2"><label>Note:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi_mod" name="campo_sospesi_mod" type="text"/></div>')     	
	     	  .concat('<div class="col-sm-2"><label class="pull-right">Numero Certificato:</label></div><div class="col-sm-3"><input class="form-control" id="numero_certificato_mod" name="numero_certificato_mod" type="text"/></div></div><div class="row"><div class="col-sm-2">')
			    .concat('<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.p7m"  id="fileupload_mod" name="fileupload_mod" type="file"></span></div><div class="col-xs-5"><label id="label_file_mod"></label></div></div>');
	
		 
	 }

	 $('#content_evento_mod').html(str_html);
	 $('#select_tipo_manutenzione_mod').select2();
	 $('#operatore_mod').select2();
	 
	 $('#datepicker_taratura_mod').bootstrapDP({
		 
			format: "yyyy-mm-dd"
		});

	  $('#datetimepicker_ev_mod').bootstrapDP({
			format: "yyyy-mm-dd"
		});


	 $('#check_interna_mod').click(function(){
		$('#check_esterna_mod').prop("checked", false); 
		$('#laboratorio_mod').val("Interno");
		$('#presso_mod').val("");
		$('#presso_mod').prop("readonly", true);
	 });
	 
	 $('#check_esterna_mod').click(function(){
		$('#check_interna_mod').prop("checked", false);
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
	 $('#fileupload_mod').change(function(){
			$('#label_file_mod').html($(this).val().split("\\")[2]);
			 
		 });
	 
	 $('#fileupload_man_mod').change(function(){
			$('#label_file_man_mod').html($(this).val().split("\\")[2]);
			 
		 });
	 
	 $('#fileupload_all_mod').change(function(){
			$('#label_file_mod').html($(this).val().split("\\")[2]);
			 
		 });
   
 });
 $('#fileupload_all').change(function(){
		$('#label_file').html($(this).val().split("\\")[2]);
		 
	 });
 


function dettaglioEventoTaratura(data_attivita, data_scadenza, laboratorio, campo_sospesi, operatore, certificato, stato){
	
	$('#lbl_data_attivita_dtl').val(formatDate(data_attivita));
	$('#lbl_laboratorio_dtl').val(laboratorio);
	$('#lbl_stato_dtl').val(stato);
	$('#lbl_campo_sospesi_dtl').val(campo_sospesi);
	$('#lbl_operatore_dtl').val(operatore);
	$('#lbl_data_scadenza_dtl').val(formatDate(data_scadenza));
	$('#lbl_certificato_dtl').val(certificato);

	$('#modalDettaglioEventoTaratura').modal();
}
 
 function dettaglioEventoManutenzione(descrizione, tipo, data,operatore){
	 $('#lbl_dettaglio_descrizione').val(descrizione);
	 if(tipo==1){
		 $('#lbl_tipo_manutenzione').val("Preventiva");	 
	 }else{
		 $('#lbl_tipo_manutenzione').val("Straordinaria");
	 }
	 $('#lbl_dettaglio_operatore').val(operatore);
	 $('#lbl_dettaglio_data').val(formatDate(data));
	 $('#modalDettaglioEventoManutenzione').modal();
 };
 
 
 
 function modificaEvento(id, tipo_evento, descrizione, data, tipo_manutenzione, data_scadenza, campo_sospesi, operatore, laboratorio, stato, numero_certificato){
	 
	 $('#select_tipo_evento_mod').val(tipo_evento);
	 $('#select_tipo_evento_mod').change();
	 var date = formatDate(data);
	 $('#data_evento_mod').val(date);
	 if(tipo_manutenzione!=null && tipo_manutenzione!=''){
		 $('#select_tipo_manutenzione_mod').val(tipo_manutenzione);
		 $('#select_tipo_manutenzione_mod').change();
	 }
	 $('#descrizione_mod').val(descrizione)
	 $('#id_evento').val(id);
	 $('#operatore_mod').val(operatore);
	 $('#operatore_mod').change();
	 
	 $('#numero_certificato_mod').val(numero_certificato);
	 if(tipo_evento==2 || tipo_evento == 5){		
		 var date = formatDate(data_scadenza);
		 $('#data_scadenza_mod').val(date);
		 $('#campo_sospesi_mod').val(campo_sospesi);		 
		 
		 if(laboratorio=='Interno'){
			 $('#check_interna_mod').prop("checked", true); 
			 $('#laboratorio_mod').val("Interno");
			 $('#presso_mod').prop("readonly", true);
		 }else{
			 $('#check_interna_mod').prop("checked", false); 
			 $('#check_esterna_mod').prop("checked", true);
			 $('#presso_mod').prop("readonly", false);
			 if(laboratorio!='Esterno'){
				 $('#presso_mod').val(laboratorio);	 
			 }
			 
			 $('#laboratorio_mod').val("Esterno");
		 }
		 if(stato=='Idonea'){
			 $('#check_idonea_mod').prop("checked", true);
			 $('#check_non_idonea_mod').prop("checked", false);
			 $('#stato_mod').val("Idonea");
		 }else{
			 $('#check_non_idonea_mod').prop("checked", true);
			 $('#check_idonea_mod').prop("checked", false);
			 $('#stato_mod').val("Non Idonea");
		 }
	 }

	 $('#modalModificaEvento').modal();
	 
 }
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("yyyy-MM-dd");
		   }			   
		   return str;	 		
	}
 
	var columsDatatables = [];
	 
	$("#tabRegistroEventi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabRegistroEventi thead th').each( function () {
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
	  $('#datetimepicker_ev').bootstrapDP({
			format: "yyyy-mm-dd"
		});
	 	
	  $('#modalCertificati').css("overflow", "hidden");
	  $('#modalModificaAttivita').css("overflow", "hidden");
	  $('#modalNuovaAttivita').css("overflow", "hidden");
 tab = $('#tabRegistroEventi').DataTable({
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
tab = $('#tabRegistroEventi').DataTable();
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
	

$('#tabRegistroEventi').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 
  
 
  $('#formNuovoEvento').on('submit',function(e){		
		e.preventDefault();
		
		nuovoEventoCampione(datax[0]);	  
	});
  
  $('#formModificaEvento').on('submit',function(e){		
		e.preventDefault();
		var x = $('#laboratorio_mod').val();
		var z = $('#stato_mod').val();
		modificaEventoCampione(datax[0]);	  
	});
  
  $('#close_btn_man').on('click', function(){
	  $('#modalDettaglio').modal('hide');
  });
 
  $('#close_btn_nuovo_evento').on('click', function(){
	  $('#modalNuovoEvento').modal('hide');
  });
  $('#close_btn_modifica_evento').on('click', function(){
	  $('#modalModificaEvento').modal('hide');
  });
  $('#close_btn_evento_dtl').on('click', function(){
	  $('#modalDettaglioEventoTaratura').modal('hide');
  });
  $('#close_btn_evento_man_dtl').on('click', function(){
	  $('#modalDettaglioEventoManutenzione').modal('hide');
  });
  
  $('#close_btn_man_fs').on('click', function(){
	  $('#modalDettaglioFuoriServizio').modal('hide');
  });
 
  $('#close_btn_cert').on('click', function(){
	  $('#modalCertificati').modal('hide');
  });

	  $('#modalNuovoEvento').on('hidden.bs.modal', function(){
		  $('#content_evento').html('');
		  $('#select_tipo_evento').val("");
		  $('#select_tipo_evento').change();
		  contentID == "registro_eventiTab";
		  
	  }); 

	  $('#modalModificaEvento').on('hidden.bs.modal', function(){
		  $('#content_evento_mod').html('');
		  contentID == "registro_attivitaTab";
		  
	  }); 
	  $('#modalDettaglio').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   

	  $('#modalDettaglioFuoriServizio').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });  
	  
	  $('#modalDettaglioEventoTaratura').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   
	  
	  $('#modalDettaglioEventoManutenzione').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   
	  
	  $('#modalCertificati').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 }); 
	  
<%-- 	  $('#data_evento').change(function(){
		  var frequenza;
		 
		  if($('#select_tipo_evento').val()==2){
			  frequenza =  <%=campione.getFrequenza_verifica_intermedia()%>
		  }
		  else{
			  frequenza =  <%=campione.getFreqTaraturaMesi()%>			  
		  }
		  
		  var data = new Date($('#data_evento').val());		 
		 var data_scadenza = data.addMonths(frequenza);
		  $('#data_scadenza').val(formatDate(data_scadenza));
		 
	  }); --%>

	  
	  $('#data_evento_mod').change(function(){
		  var frequenza;
		 
		
			 frequenza =  <%=campione.getFreqTaraturaMesi()%>			  
		
		  
		  var data = new Date($('#data_evento_mod').val());		 
		 var data_scadenza = data.addMonths(frequenza);
		  $('#data_scadenza_mod').val(formatDate(data_scadenza));
		 
	  });
	  
</script>