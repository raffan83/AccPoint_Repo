<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="org.json.simple.JSONObject" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
 
<%UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj"); 
String permesso = "0";
 if(utente.checkPermesso("CAMBIO_STATO_STRUMENTO_PACCO")){
	 
	 permesso ="1";
 }
%>

<c:set var="permesso_cambio_stato" value="<%=permesso %>"></c:set>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Pacco
        <small></small>
      </h1>
   <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
   <a class="btn btn-default pull-right" href="#" onClick="tornaItem()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna agli Item</a>
   <a class="btn btn-default pull-right" href="#" onClick="tornaMagazzino()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna al Magazzino</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
  <div class="row">
  



<div class="col-xs-3">
  
<button class="btn btn-info pull-left" onClick="testaPacco('${pacco.id}')">Crea Testa Pacco</button><br><br></div>

 <div class="col-xs-3"> 
<%--  <button class="btn btn-info pull-right" onClick="caricaAllegati('${pacco.id}')">Carica Allegati</button><br><br></div> 
 --%><span class="btn btn-primary fileinput-button pull-right">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Allegati</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input accept="image/x-png,image/gif,image/jpeg, .msg,.eml" multiple name=allegati[] id="allegati" type="file" >
		        
		   	 </span></div>
<div class="col-xs-6">
<c:if test="${pacco.chiuso==0 }">
<a class="btn customTooltip btn-info pull-right" style="background-color:#990099;border-color:#990099"  title="Forza chiusura" onClick="chiudiPacchiOrigine('${pacco.origine}')"><i class="glyphicon glyphicon-remove"></i></a>
</c:if>
</div>
<div class="col-xs-12"></div>
<div class="col-xs-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Pacco
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${pacco.id}</a>
                </li>
                 <li class="list-group-item">
                  <b>Data Pacco</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${pacco.data_lavorazione}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Data Arrivo/Rientro</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${pacco.data_arrivo}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Data Spedizione</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${pacco.data_spedizione}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Codice Pacco</b> <a class="pull-right">${pacco.codice_pacco}</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">${pacco.stato_lavorazione.descrizione}</a>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Cliente</b> <a class="pull-right">${pacco.nome_cliente}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">    
                    <div class="row">
                     <div class="col-xs-12"> 
                    <b>Sede</b> <a class="pull-right">${pacco.nome_sede}</a>
                    </div>
                     </div> 
                  </li>
                  <li class="list-group-item">
                  <div class="row">
                     <div class="col-xs-12"> 
                  <b>Cliente Utilizzatore</b> <a class="pull-right">${pacco.nome_cliente_util}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">    
                    <div class="row">
                     <div class="col-xs-12"> 
                    <b>Sede Utilizzatore</b> <a class="pull-right">${pacco.nome_sede_util}</a>
                    </div>
                     </div> 
                  </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Fornitore</b> <a class="pull-right">${pacco.fornitore}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <b>Pacco di Origine</b><a href="#" class="pull-right btn customTooltip customlink" title="Click per aprire il dettaglio del pacco origine" onclick="callAction('gestionePacco.do?action=dettaglio&id_pacco=${utl:encryptData(pacco.origine.split('_')[1])}')">${pacco.origine} </a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${pacco.utente.nominativo} </a>
                </li>
                <li class="list-group-item">
             
                  <b>Commessa</b>    <c:if test="${pacco.commessa!=null && pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink pull-right" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${pacco.commessa}');">${pacco.commessa}</a>
</c:if>
                </li>				
                <c:if test="${pacco.ddt.numero_ddt !=''}">
                <li class="list-group-item">
                  <b>DDT</b> <a href="#" class="pull-right btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${utl:encryptData(pacco.ddt.id)}')">${pacco.ddt.numero_ddt} </a>
                </li></c:if>
                 <c:if test="${pacco.link_testa_pacco!='' && pacco.link_testa_pacco!=null}">  
                <li class="list-group-item" id="link">
                
                   <b>Testa Pacco</b> 
                  <c:url var="url" value="gestionePacco.do">                  
  					<c:param name="action" value="download_testa_pacco" />
  					<c:param name="filename"  value="${utl:encryptData(pacco.codice_pacco)}" />
				  </c:url>
                 
				<a  target="_blank" class="btn btn-danger customTooltip pull-right  btn-xs"  title="Click per scaricare il Testa Pacco"   href="${url}"><i class="fa fa-file-pdf-o"></i></a>
                     
                </li>
                 </c:if> 
                 <c:if test="${allegati.size()>0}">  
                <li class="list-group-item" id="link">
                
                   <b>Allegati</b> 
                 
                 
<a class="btn btn-primary customTooltip pull-right btn-xs"  title="Click per scaricare gli allegati"   onClick="apriAllegati()"><i class="fa fa-arrow-down"></i></a>
                     
                </li>
                 </c:if> 
        </ul>

</div>
</div>
</div>

</div>


 <div class="form-group" id="tabItemGeneral">
 <label>Item Nel Pacco</label>
<table id="tabItems" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID Item</th>
 <th>Denominazione</th>
 <th>Matricola</th>
 <th>Cod. Interno</th>
 <th>Stato</th>
 <th>Tipo</th>
 <th>Quantit&agrave;</th>
 <th>Attivit&agrave;</th>
 <th>Destinazione</th>
 <th>Priorit&agrave;</th>
 <th>Note</th>
 <th>Action</th>

<%-- <th hidden="hidden"></th> --%>
 <th hidden="hidden"></th>
 </tr></thead>
 
 <tbody id="tbodyitem">
 
  <c:forEach items="${lista_item_pacco}" var="item_pacco" varStatus="loop">
  <tr>

  <c:choose>
  <c:when test="${item_pacco.item.tipo_item.descrizione =='Strumento'}">
  <td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dello strumento" onclick="dettaglioStrumento('${item_pacco.item.id_tipo_proprio}')">${item_pacco.item.id_tipo_proprio}</a></td>
  </c:when>
  <c:otherwise>
  <td>${item_pacco.item.id_tipo_proprio }</td>
  </c:otherwise> 
  </c:choose>
  <td>${item_pacco.item.descrizione }</td>
  <td>${item_pacco.item.matricola }</td>
  <td>${item_pacco.item.codice_interno }</td> 
  <td>${item_pacco.item.stato.descrizione }</td>
  <td>${item_pacco.item.tipo_item.descrizione }</td> 
  
  <td>${item_pacco.quantita}</td>

  <td>${item_pacco.item.attivita_item.descrizione }</td>
  <c:choose>
  <c:when test="${item_pacco.item.destinazione !='undefined'}">
 <td>${item_pacco.item.destinazione }</td>
  </c:when>
  <c:otherwise><td></td></c:otherwise>
  </c:choose>

  <c:if test="${item_pacco.item.priorita ==1}">
  <td>Urgente</td>
  </c:if>
  <c:if test="${item_pacco.item.priorita ==0}">
  <td></td>
  </c:if>

  <td>${item_pacco.note }</td>
  <c:choose>
  <c:when test="${permesso_cambio_stato=='1'}">
  	<c:choose>
     <c:when test="${item_pacco.item.stato.id!=3}">
 <td>
 <a class="btn btn-primary pull-center customTooltip"  title="Click per cambiare lo stato dell'Item"   onClick="cambiaStatoItem('${item_pacco.item.id}','${item_pacco.item.stato.id}')"><i class="glyphicon glyphicon-refresh"></i></a>
 <c:if test="${item_pacco.item.tipo_item.id==1 }">
 <a class="btn btn-warning pull-center customTooltip"  title="Click per modificare l'Item"   onClick="modificaCampiItemModal('${item_pacco.item.id}','${utl:escapeJS(item_pacco.item.matricola) }','${utl:escapeJS(item_pacco.item.codice_interno) }','${utl:escapeJS(item_pacco.item.descrizione) }')"><i class="glyphicon glyphicon-pencil"></i></a>
 </c:if>
 </td>
</c:when>
 <c:otherwise><td></td></c:otherwise>
 </c:choose> 
</c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>
    
<%--   <td hidden="hidden">${item_pacco.item.codice_interno }</td> --%>
    <td hidden="hidden">${item_pacco.item.id }</td>
  </tr>
  
  </c:forEach>
 

</tbody>
 </table>
 
 
 </div>
 
 
 
 <div class="form-group" id="tabItemRilievi" style="display:none">
 <label>Item Nel Pacco</label>
<table id="tabItemsRil" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID Rilievo</th>
 <th>Disegno</th>
 <th>Variante</th>
 <th>Pezzi in ingresso</th>
 <th>Note</th>
 <th>Azioni</th>


<%-- <th hidden="hidden"></th> --%>
 <th hidden="hidden"></th>
 </tr></thead>
 
 <tbody id="tbodyitem">
 
  <c:forEach items="${lista_item_pacco}" var="item_pacco" varStatus="loop">
  <tr>

  <td>
  
  <a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${utl:encryptData(item_pacco.item.id_tipo_proprio)}')">${item_pacco.item.id_tipo_proprio}</a></td>

  <td>${item_pacco.item.disegno }</td>
  <td>${item_pacco.item.variante }</td>

  <td>${item_pacco.item.pezzi_ingresso }</td> 
   <td>${item_pacco.note }</td>
 <td>
<%--  <a class="btn btn-primary pull-center customTooltip"  title="Click per cambiare lo stato dell'Item"   onClick="cambiaStatoItem('${item_pacco.item.id}','${item_pacco.item.stato.id}')"><i class="glyphicon glyphicon-refresh"></i></a>
 <c:if test="${item_pacco.item.tipo_item.id==1 }">
 <a class="btn btn-warning pull-center customTooltip"  title="Click per modificare l'Item"   onClick="modificaCampiItemModal('${item_pacco.item.id}','${item_pacco.item.matricola }','${item_pacco.item.codice_interno }','${item_pacco.item.descrizione }')"><i class="glyphicon glyphicon-pencil"></i></a> 
 </c:if> --%>
 </td>

  <td hidden="hidden">${item_pacco.item.id }</td>
  </tr>
  
  </c:forEach>
 

</tbody>
 </table>
 
 
 </div>
 
 
 

<%--  <c:if test="${userObj.checkPermesso('ACCETTAZIONE_PACCO') && pacco.stato_lavorazione.id==1}"> --%>
  <div class="box box-danger box-solid collapsed-box" id="boxAccettazione">
<div class="box-header with-border" >
	 Accettazione
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">
<a class="btn btn-primary pull-right" onClick="accettaItem()" title="Click per accettare gli item selezionati">Salva</a><br>


 <label>Accettazione Item</label>
<table id="tabAccettazione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">

<thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantità</th>
 
 <th>Note</th>
<td><input type="checkbox" id="checkbox_all" name="checkbox_all"/><b>  Accettato</b></td>
 </tr></thead>
 
 <tbody id="tbodyitem">
 
  <c:forEach items="${lista_item_pacco}" var="item_pacco" varStatus="loop">
  <tr>

  <td>${item_pacco.item.id_tipo_proprio}</td>
  <td>${item_pacco.item.tipo_item.descrizione }</td>
  <td>${item_pacco.item.descrizione }</td>
  <td>${item_pacco.quantita}</td>
  <td><input type="text" id="note_accettazione_${item_pacco.item.id_tipo_proprio}" name="note_accettazione_${item_pacco.item.id_tipo_proprio}" style="width:100%" value="${item_pacco.note_accettazione }"/></td>
  <td>
  <c:choose>
  <c:when test="${item_pacco.accettato==1 }">
  <input type="checkbox"  id="checkbox_accettazione_${item_pacco.item.id_tipo_proprio}" name="checkbox_accettazione_${item_pacco.item.id_tipo_proprio }" checked/>
  </c:when>
  <c:otherwise>
    <input type="checkbox"  id="checkbox_accettazione_${item_pacco.item.id_tipo_proprio }" name="checkbox_accettazione_${item_pacco.item.id_tipo_proprio }"/>
  </c:otherwise>  
  </c:choose>
  </td>
  
  
 

  </tr>
  
  </c:forEach>
 

</tbody>

</table>
</div>
</div>


 
 <div class="form-group">

<div class="col-12">
  <label>Note</label></div>
  <div class="col-12">
 <textarea id="note_pacco" name="note_pacco" rows="5" style= "background-color: white; width:100%" disabled>${pacco.note_pacco}</textarea></div><br>


 <%-- <button class="btn btn-primary" onClick="modificaPaccoModal(attivita_json, ${pacco.id_cliente}, ${pacco.id_sede })"><i class="fa fa-pencil-square-o"></i> Modifica Pacco</button> --%> 
 <button class="btn btn-primary" onClick="modificaPaccoModal(attivita_json, '${pacco.id_cliente}', '${pacco.nome_cliente.replace('\'','') }','${pacco.id_sede}')"><i class="fa fa-pencil-square-o"></i> Modifica Pacco</button>




            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
 </div>
</div>
       
     </section>   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


      </div>
      
      
      <form name="ModificaPaccoForm" method="post" id="ModificaPaccoForm" action="gestionePacco.do?action=new" enctype="multipart/form-data" accept-charset="UTF-8">
         <div id="myModalModificaPacco" class="modal fade" data-backdrop="static" role="dialog" aria-labelledby="myLargeModalLabel">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Pacco</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
       
      <div class="form-group">
      <div class="row">
  <div class="col-md-6"> 
                  <label>Tipologia</label>
                  
                  <select name="tipologia" id="tipologia" data-placeholder="Seleziona Tipologia..." class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" >
                  <option value=""></option>
                  <option value="1">Cliente</option>
             		<option value="2">Fornitore</option>
                  </select>
        </div>
       </div>
       <div class="row">
       <div class="col-md-6" style="display:none">  
                  <label>Cliente</label>
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
                
        </div> 
       
           <div class="col-md-6">  
                  <label>Cliente</label>
            <%--       <select name="select1" id="select1" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                            <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option>
                     
                     </c:forEach>

                  </select> --%>
                  <input id="select1" name="select1" class="form-control" style="width:100%" required>
        </div> 
        
        
 <div class="form-group">
 	                  <select name="select3" id="select3" data-placeholder="Seleziona Fornitore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" >
	                 
	                  <c:if test="${userObj.idCliente != 0}">
	                  
	                      <c:forEach items="${lista_fornitori}" var="fornitore">
	                       <c:if test="${userObj.idCliente == fornitore.__id}">
	                           <option value="${fornitore.__id}_${fornitore.nome}">${fornitore.nome}</option> 
	                        </c:if>
	                     </c:forEach>
	                  
	                  </c:if>
	                 
	                  <c:if test="${userObj.idCliente == 0}">
	                  <option value=""></option>
	                      <c:forEach items="${lista_fornitori}" var="fornitore">
	                           <option value="${fornitore.__id}_${fornitore.nome}">${fornitore.nome}</option> 
	                     </c:forEach>
	                  
	                  </c:if>
	                    
	                  </select>
 
 </div>
 
 <!-- </div>  -->
 <!-- </div>  -->
 

 
 <div class="col-md-6">
         <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
             			<c:forEach items="${lista_sedi}" var="sedi">
                          	 <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>     
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                     	</c:forEach>
              
                  </select>
                  
        </div>
        </div>
        
 </div>   
 
 <div class="row">
  <div class="col-md-6"> 
                  <label>Cliente Utilizzatore</label>
                  
	                 <%--  <select name="cliente_utilizzatore" id="cliente_utilizzatore" data-placeholder="Seleziona Cliente Utilizzatore..."   class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%" required>

	                    <option value=""></option>
	                      <c:forEach items="${lista_clienti}" var="cliente">
	                           <option value="${cliente.__id}">${cliente.nome}</option> 
	                     </c:forEach>
	         
	                  </select> --%>
                  <input id="cliente_utilizzatore" name="cliente_utilizzatore" class="form-control" style="width:100%" required>
        </div>

    <div class="col-md-6">
 <div class="form-group">
                  <label>Sede Utilizzatore</label>
                 
                <select name="sede_utilizzatore" id="sede_utilizzatore" data-placeholder="Seleziona Sede utilizzatore..."  disabled class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="true">
          			<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">             			
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>     
                                        
                     	</c:forEach>
                 
                  </select> 
        </div>
</div>   
 
 
  

        </div> 


        
<div class="form-group">
 
                  <label>Commessa</label>
     <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-4">             
                  <select name="commessa" id="commessa" data-placeholder="Seleziona Commessa..."  class="form-control select2 pull-left" style="width:100%"  aria-hidden="true" data-live-search="true">
                   <option value=""></option>   
             			<c:forEach items="${lista_commesse}" var="commessa">
                          	  <%-- <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>     --%>
                          	  <option value="${commessa.ID_COMMESSA}*${commessa.ID_ANAGEN}">${commessa.ID_COMMESSA}</option> 
                     	</c:forEach>
                  </select> 
  </div>
   <div class= "col-xs-4">
                
                  <input type="text" id="commessa_text" name="commessa_text" class="form-control pull-right" value="${pacco.commessa}" style="margin-down:35px;">
   </div>
   
    <div class="col-xs-4">
<a class="btn btn-primary" id="import_button" onClick="importaInfoDaCommessa($('#commessa_text').val(),0)">Importa Da Commessa</a>
</div>
 </div>
</div>

 <div class="form-group">
 
                  <label>Note Commessa</label>
   <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-12">             
		<textarea id="note_commessa" name="note_commessa" rows="6" style="width:100%" readonly>${utl:escapeHTML(commessa.NOTE_GEN) }</textarea> 
		
  </div>
   
 </div> 
</div>

<div class="form-group">
   <div class="row" style="margin-down:35px;">                 
<div class= "col-xs-6">

            <b>Codice Pacco</b><br>
             <a class="pull-center" ><input type="text" class="pull-left form-control" id=codice_pacco name="codice_pacco" value="${pacco.codice_pacco }"style="margin-top:6px;" readonly ></a> 
        </div>
        <div class= "col-xs-6">
	 
         <label class="pull-center">Stato Lavorazione</label> 
         <select name="stato_lavorazione" id="stato_lavorazione" data-placeholder="Seleziona Stato Lavorazione" class="form-control select2"   aria-hidden="true" style="width:100%" data-live-search="true">
     	 	<option value=${pacco.stato_lavorazione.id }>${pacco.stato_lavorazione.descrizione}</option> 
                   		<c:forEach items="${lista_stato_lavorazione}" var="stato">
                   		<c:if test="${stato.id != pacco.stato_lavorazione.id}">
                          	 <option value="${stato.id}">${stato.descrizione}</option>    
                          	 </c:if>
                     	</c:forEach>
                  </select>
                  
        </div>
</div >
</div>


  <div class="form-group" >
   <div class="row" style="margin-down:35px;">   
 <div class= "col-xs-6">             
 <label>Data Arrivo</label>
            <div class='input-group date datepicker' id='datepicker_data_arrivo'>
            <c:choose>
            <c:when test="${pacco.data_arrivo!=null && pacco.data_arrivo!=''}">
               <input type='text' class="form-control input-small" id="data_arrivo" name="data_arrivo" value="${pacco.data_arrivo }">
               </c:when>
               <c:otherwise>
               <input type='text' class="form-control input-small" id="data_arrivo" name="data_arrivo" >
               </c:otherwise>
               </c:choose>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </div> 
 
   
 </div> 

 <div class= "col-xs-6"> 

                  <label>Data Spedizione</label>
            <div class='input-group date datepicker' id='datepicker_data_spedizione' >
            <c:choose>
            <c:when test="${pacco.data_spedizione!=null && pacco.data_spedizione!='' }">
               <input type='text' class="form-control input-small" id="data_spedizione" name="data_spedizione" value="${pacco.data_spedizione }"/>
               </c:when>
               <c:otherwise>
               <input type='text' class="form-control input-small" id="data_spedizione" name="data_spedizione" />
               </c:otherwise>
               </c:choose>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </div> 
  </div>
   
 </div> 
</div> 


  <div class="form-group" >

 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right" >
		
		<button data-widget="collapse" class="btn btn-box-tool" id="collapsed_box_btn"><i class="fa fa-plus" ></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-md-12">
<a class="btn btn-primary pull-right disabled" id="conf_button" onClick="importaConfigurazioneDDT()" title="Click per importare la configurazione"><i class="fa fa-arrow-down"></i></a>
</div>
</div>
<div class="row">
<div class="col-md-4">
<label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.numero_ddt}" id="numero_ddt" name="numero_ddt" ></a>
</div>
<div class="col-md-4">
<label>Data DDT</label>    
     
            <span class='date datepicker' id='datepicker_ddt'>
           		<span class="input-group">
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" value="${pacco.ddt.data_ddt }"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </span>
        </span> 

</div>
<div class="col-md-4">
<label>N. Colli</label> <a class="pull-center"><input type="number" class="form-control" id="colli" name="colli"  min=0   value="${pacco.ddt.colli }"> </a>
</div>

</div>
<div class="row">
<div class="col-md-12">
 <div  class="box box-danger box-solid" >

<div class="box-body">

<div class="row" id="row_destinazione">
<div class="col-md-4">

<label>Destinazione</label> 
                 <a class="pull-center">
                 <%--  <select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%" >
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select> --%>
 <input id="destinazione" name="destinazione" style="width:100%" data-placeholder="Seleziona Destinazione..." class="form-control">
                  </a> 
</div>

<div class="col-md-4">

<label>Sede Destinazione</label> 
                  <a class="pull-center">
                 <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">               	  
               	 	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 

                  
                  </a> 
</div>
</div>

<div class="row">
<div class="col-md-4">
<label id="mitt_dest">Destinatario</label> 
                  <a class="pull-center">
                  
                  <%-- <select class="form-control select2"  id="destinatario" name="destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select> --%>
                  <input id="destinatario" name="destinatario" style="width:100%" class="form-control">
                  </a>

</div>
<div class="col-md-4">

<label id="sede_mitt_dest">Sede Destinatario</label> 
                  <a class="pull-center">
                   <c:choose>
                  <c:when test="${pacco.stato_lavorazione.id==4 || pacco.stato_lavorazione.id==5 }">
                    
                  <select class="form-control select2"  id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%> 
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>
                  </c:forEach>
                  </select>
                                   
                  </c:when>
                  <c:otherwise>
                  
                  <select class="form-control select2"  id="sede_destinatario" name="sede_destinatario" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>  
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
                  
                  
                  </c:otherwise>
                  </c:choose> 
              
                  
                  </a> 

</div>
<!-- <div class="col-md-2">
<a class="btn btn-primary" style="margin-top:25px" onClick="importaInfoDaCommessa($('#commessa_text').val(),0)">Importa Da Commessa</a>

</div> -->

</div>

</div>
</div> 
</div>
</div>
<div class="row">
<div class= "col-md-4">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">

		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
			<c:choose>
			<c:when test="${tipo_ddt.id==pacco.ddt.tipo_ddt.id }">
			<option value="${tipo_ddt.id}" selected>${tipo_ddt.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
	</select>
</div>
<div class= "col-md-4">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
			<c:forEach items="${lista_tipo_aspetto}" var="aspetto">
			<c:choose>
			<c:when test="${aspetto.id==pacco.ddt.aspetto.id }">
			<option value="${aspetto.id}" selected>${aspetto.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${aspetto.id}">${aspetto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
	</select>

	


</div>

<div class= "col-md-4">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">

			<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
			<c:choose>
			<c:when test="${tipo_porto.id==pacco.ddt.tipo_porto.id }">
			<option value="${tipo_porto.id}" selected>${tipo_porto.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
</div>

<div class="row">
<div class="col-md-4">
<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">	
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<c:choose>
			<c:when test="${tipo_trasporto.id==pacco.ddt.tipo_trasporto.id }">
			<option value="${tipo_trasporto.id}" selected>${tipo_trasporto.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>

</div>
<div class="col-md-4">
<label>Causale</label> 
<%-- <input type="text" class="form-control" value="${pacco.ddt.causale_ddt }" id="causale" name="causale" > --%>
<select name="causale" id="causale" data-placeholder="Seleziona Causale..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
		<option value=""></option>
		<c:forEach items="${lista_causali}" var="causale">
			<c:choose>
			<c:when test="${causale.id==pacco.ddt.causale.id }">
			<option value="${causale.id}" selected>${causale.descrizione}</option>
			</c:when>
			<c:otherwise>
			<option value="${causale.id}">${causale.descrizione}</option>
			</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
</div>
<div class="col-md-4">
<label>Data Trasporto</label>    

 <span class="date datepicker"  id="datepicker_trasporto" > 
        <span class="input-group">
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto" value="${pacco.ddt.data_trasporto }" name="data_ora_trasporto"/>
            
            <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
        </span>
         </span> 

</div>


</div>
<div class="row">

<div class="col-md-4">
 <div class="row" id="operatore_section" style="display:none">
<div class="col-md-12" >
<label>Operatore Trasporto</label>
	<input type="text" id="operatore_trasporto" name="operatore_trasporto" class="form-control">
</div>

</div>  
 <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.annotazioni }" id="annotazioni" name="annotazioni"> </a>
 <div class="row">
<div class="col-md-12" >
<label>Magazzino</label>
	<select id="magazzino" name="magazzino" class="form-control">
	<option value="Principale">Principale</option>
	</select>
</div>
</div>
</div>
<div class="col-md-4">

<label>Spedizioniere</label> 
<a class="pull-center"><input type="text" class="form-control" value="${pacco.ddt.spedizioniere }" id="spedizioniere" name="spedizioniere"> </a>

 <div class="row">
<div class="col-md-12" >
<label>Peso (Kg)</label>
	<input type="text" id="peso" name="peso" class="form-control" value="${pacco.ddt.peso }">
</div>

</div> 
</div>
<div class="col-md-4">
 <div class="row">
<div class="col-md-12" >
<label>Account Spedizioniere</label>
<input type="text" id="account" name="account" class="form-control" value="${pacco.ddt.account }"/> 
</div>
</div> 

<label>Cortese Attenzione</label>
	<input type="text" id="cortese_attenzione" name="cortese_attenzione" class="form-control" value="${pacco.ddt.cortese_attenzione }">

</div>
</div>
<div class= "row">
<div class="col-md-6">
<label>Note DDT</label>
<select  id= tipo_note_ddt data-placeholder="Seleziona Note..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
	<option value=""></option>
		<c:forEach items="${lista_note_ddt}" var="nota_ddt">
			<option value="${nota_ddt.descrizione}">${nota_ddt.descrizione}</option>
		</c:forEach>
	</select>

</div>
<div class="col-md-2">

<a class="btn btn-primary" id="addNotaButton" onClick="aggiungiNotaDDT($('#tipo_note_ddt').val())" style="margin-top:25px"><i class="fa fa-plus"></i></a>
</div>
<div class="col-md-4">
<label>Allega File</label>
 <input id="fileupload_ddt" type="file" name="file" class="form-control"/>
</div>
</div><br>
<div class= "row">
 <div class="col-md-12">
 <a class="pull-center">
		<textarea name="note" form="ModificaPaccoForm" id="note" class="form-control" rows=3 style="width:100%">${pacco.ddt.note }</textarea></a> 
 
 </div>
 
 
 
 
 

</div>

</div>
</div>
</div>
	

 
<div class="form-group">
 <div class="box box-danger box-solid collapsed-box">
<div class="box-header with-border">
	 Item
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">	
<div class= "col-md-6">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
	<label>Tipo Item</label>
	<select name="tipo_item" id="tipo_item" data-placeholder="Seleziona Tipo item" class="form-control select2"  aria-hidden="true" data-live-search="false" style="width:100%">
	<option value=""></option>
		<c:forEach items="${lista_tipo_item}" var="tipo">

			<option value="${tipo.id}">${tipo.descrizione}</option>

		</c:forEach>
		
	</select>

	</li>
		
	</ul>

</div>

<div class= "col-md-6">

<button  class="btn btn-primary pull-left" style="margin-top:35px" onClick="inserisciItem()"><i class="fa fa-plus"></i></button>


</div>
</div>
</div>
</div>




 <div class="form-group" id="tabModGeneral">
 <label>Item Nel Pacco</label>
 <div class="table-responsive">
 <table id="tabItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantit&agrave;</th>
 <th>Stato</th>
 <th>Matr.</th>
 <th>Cod. Int.</th>
 <th>Attivit&agrave;</th> 
 <th>Destinazione</th>
 <th>Priorit&agrave;</th>
 <th>Note</th> 
 <th>Action</th>
 </tr></thead>
 
 <tbody id="tbodymodifica">

</tbody>
 </table> 
 </div>
 
 </div>
 
 
 
 
  <div class="form-group" id="tabModRilievi">
 <label>Item Nel Pacco</label>
 <div class="table-responsive">
 <table id="tabItemModRil" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active" >
 <th>ID Item</th>
  <th>Disegno</th>
 <th>Variante</th>
 <th>Pezzi in ingresso</th>
<th>Note</th>	
 <td><label>Action</label></td>

 </tr></thead>
 
 <tbody id="tbodymodificaRil">

</tbody>
 </table> 
 </div>
 
 </div>
 
 
 
  <div class="col-12">
  <label>Note</label></div>
 <textarea id="note_pacco" name="note_pacco" rows="5"  style="width:100%">${utl:escapeHTML(pacco.note_pacco)}</textarea>


</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="json" name="json">
		<input type="hidden" class="pull-right" id="json_rilievi" name="json_rilievi">
		<input type="hidden" class="pull-right" id="select_nota_pacco" name="select_nota_pacco">
		<input type="hidden" class="pull-right" id="id_pacco" name="id_pacco">
		<input type="hidden" class="pull-right" id="id_ddt" name="id_ddt">
		<input type="hidden" class="pull-right" id="pdf_path" name="pdf_path" value="${pacco.ddt.link_pdf }">
		<input type="hidden" class="pull-right" id="origine_pacco" name="origine_pacco">
		 <input type="hidden" class="pull-right" id="testa_pacco" name="testa_pacco" value="${pacco.link_testa_pacco }"> 
		<input type="hidden" class="pull-right" id="select_fornitore" name="select_fornitore" value=""> 
		<input type="hidden" class="pull-right" id="configurazione" name="configurazione" > 
		<input type="hidden" class="pull-right" id="ritardo" name="ritardo" value="${pacco.ritardo }">
		<input type="hidden" class="pull-right" id="data_lavorazione" name="data_lavorazione" value="${pacco.data_lavorazione}">
		
		<!--  <input type="file" id="modifica_pezzi_rilievo_upload" name="modifica_pezzi_rilievo_upload[]" style="display:none" multiple> --> 
		<input type="hidden" id="modifica_pezzi_rilievo_id" name="modifica_pezzi_rilievo_id" >
		
		<div id="fileInputsContainer"></div>
		
		<!-- <button class="btn btn-default pull-left" onClick="modificaPaccoSubmit()"><i class="glyphicon glyphicon"></i> Modifica Pacco</button> -->  
		<!-- <button class="btn btn-default pull-left" onClick="modalConfigurazione()"><i class="glyphicon glyphicon"></i> Modifica Pacco</button> -->
  <button class="btn btn-default pull-left" onClick="chooseSubmit()" id="button_submit"><i class="glyphicon glyphicon"></i> Modifica Pacco</button>
    </div>
    </div>
      </div>
    
      </div>
</div>







 <div id="modalModificaPezziIngresso" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Aggiungi pezzi in ingresso </h4>
      </div>
       <div class="modal-body" >
       
       <div class="row">
       <div class="col-xs-12">
       <label>Numero Pezzi Da Aggiungere</label>
       <input type="number" min="0" step="1" class="form-control" id="pezzi_ingresso_mod" name="pezzi_ingresso_mod"/>
       </div>
       </div><br><br>
       
       <div class="row">
       <div class="col-xs-12">
       
       </div>
       <div class="col-xs-4">
        		
 		
 				<!-- 	<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica File...</span>
				<input id="fileupload_rilievi" accept=".pdf, .PDF" type="file" name="fileupload_rilievi" class="form-control"/>
				<input id="modifica_pezzi_rilievo_upload" accept=".pdf, .PDF" type="file" name="modifica_pezzi_rilievo_upload" multiple class="form-control"/>
		       
		   	 </span> -->
		   	 <button class="btn btn-primary" id="btnAddFileInput">Aggiungi File</button>
       </div>
        <div class="col-xs-8">
		 <label id="label_file_rilievi"></label>
		 </div>
       </div>
   

  		 </div>
      <div class="modal-footer">
 
		<input id="id_item_rilievi_modifica"  type="hidden"  /> 
		<input id="id_row_rilievi"  type="hidden"  /> 

	<button  class="btn btn-primary" id="salva_btn_rilievi" disabled onclick="aggiornaTabellaRilievi($('#pezzi_ingresso_mod').val())">Salva</button>
       
      </div>
    </div>
  </div>
</div>


 </form>  
 
   <div id="myModalItem" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Item</h4>
      </div>
       <div class="modal-body">
       <div id="listaItemTop"></div><br>
       <div id="listaItem"></div>
			 <div id="listaRilievi" style="display:none">
			<div class="row">
			<div class="col-xs-3">
			<label>Disegno</label>
			</div>
			<div class="col-xs-9">
				<input type="text" class="form-control" id="disegno" name="disegno" required/>
			</div>
			</div><br>
		
			<div class="row">
			<div class="col-xs-3">
			<label>Variante</label>
			</div>
			<div class="col-xs-9">
				<input type="text" class="form-control" id="variante" name="variante" required/>
			</div>
			</div><br>
			
				<div class="row">
			<div class="col-xs-3">
			<label>Numero Pezzi in ingresso</label>
			</div>
			<div class="col-xs-9">
				<input type="number" min="0" step="1" class="form-control" id="pezzi_ingresso" name="pezzi_ingresso" required/>
			</div>
			</div><br>
			
			<div class="row">
			<div class="col-xs-3">
			<label>Note</label>
			</div>
			<div class="col-xs-9">
			<textarea id="note_rilievo" name="note_rilievo" style="width:100%" rows="3" class="form-control"></textarea>
				
			</div>
			</div><br>
			
		</div>	 
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
<a id="btn_save_rilievo" class="btn btn-primary" style="display:none" onClick="insertRilievo()">Inserisci</a>
       
      </div>
    </div>
  </div>
</div>
      
      <div id="myModalSaveStato" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Salva Configurazione</h4>
      </div>
       <div class="modal-body">
       Vuoi salvare la configurazione del DDT per la sede selezionata?
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "yes_button" onClick="salvaConfigurazione(1)">SI</button>
		<button class="btn btn-primary"  id = "no_button"  onClick="salvaConfigurazione(0)">NO</button>
       
      </div>
    </div>
  </div>
</div>
   
<div id="myModalRilItem" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      <div id="modalContent"></div>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="ril_item">
      
      <a class="btn btn-primary" onclick="changeTable()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalRilItem').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalAllegatiPacco" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     
     <div class="modal-header ">
     

        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4  class="modal-title" id="myModalLabelHeader">Allegati</h4>
      </div>
      
       <div class="modal-body">
       
       			<div id="myModalAllegatiContent">
			<div class="table-responsive mailbox-messages">
				<table id="tabAllegati" class="table table-hover table-striped" role="grid" width="100%">
				<thead><tr class="active">
				<th></th>
				<th></th>
				</thead>
				<tbody>
				
 				<c:forEach items="${allegati}" var="allegato">	
 		 		<tr>
 		 		<td>
				${allegato.allegato }
				
				<c:url var="url_allegato" value="gestionePacco.do">
                  <c:param name="allegato"  value="${allegato.allegato}" />
                  <c:param name="codice_pacco"  value="${allegato.pacco.codice_pacco}" />
  					<c:param name="action" value="download_allegato" />
				  </c:url></td>
				
				<td>
				<span class="pull-right"><a   class="btn btn-primary customTooltip  btn-xs"  title="Click per scaricare l'allegato"   onClick="callAction('${url_allegato}')"><i class="fa fa-arrow-down"></i></a>
				<a   class="btn btn-danger customTooltip  btn-xs"  title="Click per eliminare l'allegato"   onClick="modalYesOrNo('${allegato.id }','${allegato.pacco.id }')"><i class="fa fa-trash"></i></a>
						</span></td>
		 		</tr>
		 		</c:forEach>
				</tbody>
				</table>
				
			</div>
			
			</div>

  		 </div>

    </div>
  </div>
</div>

<div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_allegato_elimina">
      <input type="hidden" id="id_pacco_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoMagazzino($('#id_allegato_elimina').val(),$('#id_pacco_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>
</div>

<div id="myModalSpostaStrumenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	&Egrave; stato modificato l'utilizzatore, spostare gli strumenti sotto il nuovo utilizzatore? 
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_util">
      <input type="hidden" id="id_sede_util">
      <a class="btn btn-primary" onclick="spostaStrumentoPacco($('#id_util').val(),$('#id_sede_util').val(),'${pacco.id}')" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalSpostaStrumenti').modal('hide')" >NO</a>
      </div>
    </div>
  </div>
</div>


  <div id="myModalModificaItem" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     
     <div class="modal-header ">
     

        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4  class="modal-title" id="myModalLabelHeader">Modifica Item</h4>
      </div>
      
       <div class="modal-body">
       <label>Denominazione</label>
       		<input type="text" class="form-control" id="denominazione_item" name="denominazione_item"><br>
       <label>Matricola</label>
       		<input type="text" class="form-control" id="matricola_item" name="matricola_item"><br>
       	<label>Codice Interno</label>
       		<input type="text" class="form-control" id="codice_interno_item" name="codice_interno_item">

   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <a  class="btn btn-primary " onClick="modificaCampiItem(item_modifica,$('#matricola_item').val(), $('#codice_interno_item').val(), $('#denominazione_item').val())" data-dismiss="modal">Salva</a>
      </div>
    </div>
  </div>
</div>




   <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
      
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
             </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div> 


     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  


<div id="myModalCommessa" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Attivit&agrave; </h4>
      </div>
       <div class="modal-body" id="commessa_body">
       
       
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


       
      </div>
    </div>
  </div>
</div>






  <!--  <div id="modalModificaPezziIngresso" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica pezzi in ingresso </h4>
      </div>
       <div class="modal-body" >
       
       <div class="row">
       <div class="col-xs-12">
       <label>Numero Pezzi</label>
       <input type="number" min="0" step="1" class="form-control" id="pezzi_ingresso_mod" name="pezzi_ingresso_mod"/>
       </div>
       </div><br><br>
       
       <div class="row">
       <div class="col-xs-12">
       
       </div>
       <div class="col-xs-4">
        		
 		
 					<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica File...</span>
				<input id="fileupload_rilievi" accept=".pdf, .PDF" type="file" name="fileupload_rilievi" class="form-control"/>
		       
		   	 </span>
       </div>
        <div class="col-xs-8">
		 <label id="label_file_rilievi"></label>
		 </div>
       </div>
   

  		 </div>
      <div class="modal-footer">
 
		<input id="id_item_rilievi_modifica"  type="hidden"  /> 
		<input id="id_row_rilievi"  type="hidden"  /> 

	<button  class="btn btn-primary" id="salva_btn_rilievi" disabled onclick="aggiornaTabellaRilievi($('#pezzi_ingresso_mod').val())">Salva</button>
       
      </div>
    </div>
  </div>
</div> -->
</div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

<!-- </div> -->
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

  
        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 
</jsp:attribute>

<jsp:attribute name="extra_js_footer">


		
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<!-- <script type="text/javascript" src="https://www.datejs.com/build/date.js"></script> -->
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>


 <script type="text/javascript">
 
 var attivita_json = JSON.parse('${attivita_json}');
 
 nuovo= false;
 var rows_accettazione = ${lista_item_pacco.size()};
 
 
  $('#commessa_text').on('change', function(){
		
	 id_commessa = $('#commessa_text').val();
	 if(id_commessa!=""){
		showNoteCommessa(id_commessa);
	 }
		
	});  

 $('#tipo_trasporto').change(function(){
	
	 var sel =  $('#tipo_trasporto').val();
	 if(sel==2){
		 $('#operatore_section').show();
	 }else{
		 $('#operatore_trasporto').val("");
		 $('#operatore_section').hide();
	 }
	 
 });
 
 function inserisciItem(){
	 $('#listaItemTop').html('');
	 $('#codice_pacco').removeAttr('required');
		//var id_cliente = document.getElementById("select1").value;
		//var id_sede = document.getElementById("select2").value;
		var id_cliente = $('#cliente_utilizzatore').val();
		var id_sede = $('#sede_utilizzatore').val()
		var tipo_item = document.getElementById("tipo_item").value;
		inserisciItemModal(tipo_item,id_cliente,id_sede);
		};
 
		var fornitore = "${pacco.ddt.id_destinatario}"+"_"+"${pacco.fornitore}";
		
	function modificaPaccoSubmit(configurazione){
		

		
			items_json.forEach(function(item, index){

				item.note=$('#note_item_'+item.id_proprio).val();
			
				if($('#priorita_item_'+item.id_proprio).is( ':checked' ) ){
					 item.priorita=1;
				}else{
					 item.priorita=0;
				 }
				
				if($('#attivita_item_'+item.id_proprio).val()!=null){
					item.attivita = $('#attivita_item_'+item.id_proprio).val();
				}else{
					item.attivita="";
				}
				if($('#destinazione_item_'+item.id_proprio).val()!=null){
					item.destinazione = $('#destinazione_item_'+item.id_proprio).val();
				}else{
					item.destinazione= "";
				}
				
			}); 
	 		
			var json_data = JSON.stringify(items_json);
			$('#json').val(json_data);
			
		if(rilievi){
			
			
	 		
			var json_data = JSON.stringify(items_rilievo);
			$('#json_rilievi').val(json_data);
		}
 		
		
		var id_pacco= ${pacco.id};
		var id_ddt = ${pacco.ddt.id};
		var nota_pacco = '${pacco.tipo_nota_pacco.id}'
		var origine = '${pacco.origine}';
		
		
		$('#select_nota_pacco').val(nota_pacco);
		
		$('#id_pacco').val(id_pacco);
		$('#id_ddt').val(id_ddt);
		$('#origine_pacco').val(origine);
		$('#codice_pacco').attr('required', 'true');
		$('#select_fornitore').val(fornitore);
		$('#configurazione').val(configurazione);
		var esito = validateForm();
		
		if(esito==true){
			pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();
		$('#data_arrivo').attr('required', false);
		$('#data_spedizione').attr('required', false);
		$('#select1').prop('disabled', false);
		
		destinazioneBox();
		
		 
		document.getElementById("ModificaPaccoForm").submit();
		
		
		}
		else{};
	}
	

	
	function aggiungiNotaDDT(nota){
		if(nota!=""){
			$('#note').append(nota+ " ");
		}	
	}
	
 	function destinazioneBox(){
 		
		var destinatario = "${pacco.ddt.id_destinatario}";
		var sede_destinatario = "${pacco.ddt.id_sede_destinatario}";
		var destinazione = "${pacco.ddt.id_destinazione}";
		var sede_destinazione = "${pacco.ddt.id_sede_destinazione}";
		
		/*  if(destinatario!=null && destinatario !='0'){
			$('#destinatario option[value=""]').remove();
		}
		if(sede_destinatario!=null && sede_destinatario !='0'){
			$('#sede_destinatario option[value=""]').remove();
		}
		if(destinazione!=null && destinazione !='0'){
			$('#destinazione option[value=""]').remove();
			
		}
		if(sede_destinazione!=null && sede_destinazione !='0'){
			$('#sede_destinazione option[value=""]').remove();
		}  */
		
			
	/* 	$('#destinatario option[value="'+destinatario+'"]').attr("selected", true);
		$('#destinatario').change();				
		$('#sede_destinatario option[value="'+sede_destinatario+'_'+destinatario+'"]').attr("selected", true);
		$('#destinazione option[value="'+destinazione+'"]').attr("selected", true);
		$('#destinazione').change();		
		$('#sede_destinazione option[value="'+sede_destinazione+'_'+destinazione+'"]').attr("selected", true);  */
		
		
		if($('#destinatario').val()== null || $('#destinatario').val()==''){
			$('#destinatario').val(destinatario);
			$('#destinatario').change();	
			if(sede_destinatario==0){
				$('#sede_destinatario option[value="0"]').attr("selected", true);
			}else{
				$('#sede_destinatario option[value="'+sede_destinatario+'_'+destinatario+'"]').attr("selected", true);
			}
		}
		
		
		
		if($('#destinazione').val()== null || $('#destinazione').val()==''){
			$('#destinazione').val(destinazione);
		$('#destinazione').change();	
		
		if(sede_destinazione==0){
			$('#sede_destinazione option[value="0"]').attr("selected", true); 
		}else{
			$('#sede_destinazione option[value="'+sede_destinazione+'_'+destinazione+'"]').attr("selected", true); 	
		}
		}
					
		
		
		initSelect2('#destinazione');
		initSelect2('#destinatario');

	} 
	
 	
	function importaConfigurazioneDDT(){
		
		 var lista_save_stato = '${lista_save_stato_json}';
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  
		  if(lista_save_stato!=null && lista_save_stato!=''){
		  var save_stato_json = JSON.parse(lista_save_stato);
		  
		  save_stato_json.forEach(function(item){
		  	
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				  $('#spedizioniere').val(item.spedizioniere);
				  $('#account').val(item.account);
				  $('#cortese_attenzione').val(item.ca);
				  $('#tipo_porto').val(item.tipo_porto);
				  $('#aspetto').val(item.aspetto);				  
			  }
		  
		  
		  });
		  }
	} 
 	
 	
	
	function apriAllegati(){
		
		$('#myModalAllegatiPacco').modal();

	}
	
	
	

	
	
	
	
	
	
	
	
	
	
 	$('#select_fornitore').change(function(){
		var value=$('#select_fornitore').val();
		$('#destinazione').val(value);
		$('#destinazione option[value="'+value+'"]').attr('selected', true);
				
		$('#destinazione').change();
		
	}); 
	

 	function modalConfigurazione(){

 			if($('#numero_ddt').val()!=null && $('#numero_ddt').val()!=""){
 				var esito = validateForm();
 				if(esito){
 					$('#myModalSaveStato').modal();
 				}
 			}else{
 				modificaPaccoSubmit(0);
 			}
 		 		
 	}
 	
	function salvaConfigurazione(si_no){

			if(si_no==1){
				modificaPaccoSubmit(1);
			}else{
				modificaPaccoSubmit(0);
			}

	}

 	
$('#stato_lavorazione').change(function(){
 		
 		var selection = $('#stato_lavorazione').val()
 		var fornitore = "${pacco.fornitore}";
 		if(selection==4){
 			
 			$('#select_fornitore').attr("disabled", false);
 			
 			if(fornitore!=null && fornitore!=""){
 				
 				$("#select_fornitore option[value='']").remove();
 			}
 			$('#data_arrivo').attr("disabled", true);
 			$('#data_arrivo').val('');
 			$('#data_spedizione').attr("disabled", false);
 			$('#mitt_dest').html("Destinatario");
 			$('#sede_mitt_dest').html("Sede Destinatario");
 			
 			/* $('#destinatario').select2({
			placeholder : "Seleziona Destinatario..."
			}); */
 			
 			initSelect2('#destinatario', "Seleziona Destinatario...");
 			$('#sede_destinatario').select2({
 				placeholder : "Seleziona Sede Destinatario..."
 			});

			 $('#row_destinazione').show();
			 $('#tipo_ddt').val(2);
			 $('#tipo_ddt').change();
			 //destinazioneOptions(selection);
 		}
 		else if(selection==5){
		$('#select_fornitore').attr("disabled", false);
		
 			if(fornitore!=null && fornitore!=""){
 				
 				$("#select_fornitore option[value='']").remove();
 			}
 			$('#data_arrivo').attr("disabled", false);
 			$('#data_spedizione').attr("disabled", true);
 			$('#data_spedizione').val('');
 			 $('#mitt_dest').html("Mittente");
 			$('#sede_mitt_dest').html("Sede Mittente");
 			/*  $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
			 }); */
 			initSelect2('#destinatario', "Seleziona Mittente...");
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Mittente..."
		 	});
			 $('#row_destinazione').hide();
			 $('#tipo_ddt').val(1);
			 $('#tipo_ddt').change();
 		}
 		else if(selection==3){
 			
 			$('#select_fornitore').attr("disabled", true);
 			$("#select_fornitore").prepend("<option value='' selected='selected'></option>");
 			$('#data_arrivo').attr("disabled", true);
 			$('#data_arrivo').val('');
 			$('#data_spedizione').attr("disabled", false);
 			 $('#mitt_dest').html("Destinatario");
 			$('#sede_mitt_dest').html("Sede Destinatario");
			 $('#row_destinazione').show();
			 /* $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
			 }); */
			 initSelect2('#destinatario', "Seleziona Destinatario...");
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Destinatario..."
		 	});
		 	$('#tipo_ddt').val(2);
			 $('#tipo_ddt').change();
			// destinazioneOptions(selection);
 		}
 		
 		else if(selection==2){
 			
 			$('#data_arrivo').attr("disabled", true);
 			$('#data_spedizione').attr("disabled", true);
 			$('#data_arrivo').val('');
 			$('#data_spedizione').val('');
 			 $('#mitt_dest').html("Destinatario");
 			$('#sede_mitt_dest').html("Sede Destinatario");
 			/*  $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
			 }); */
			 initSelect2('#destinatario', "Seleziona Destinatario...");
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Destinatario..."
		 	});
			 $('#row_destinazione').show();
			 $('#tipo_ddt').val(2);
			 $('#tipo_ddt').change();
			// destinazioneOptions(selection);
 		}else{
 			
 			$('#select_fornitore').attr("disabled", true);
 			$("#select_fornitore").prepend("<option value='' selected='selected'></option>");
 			$('#data_arrivo').attr("disabled", false);
 			$('#data_spedizione').val('');
 			$('#data_spedizione').attr("disabled", true);
 			 $('#mitt_dest').html("Mittente");
 			$('#sede_mitt_dest').html("Sede Mittente");
 			 /* $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
			 }); */
			 initSelect2('#destinatario', "Seleziona Mittente...");
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Mittente..."
		 	});
			 $('#row_destinazione').hide();
			 $('#tipo_ddt').val(1);
			 $('#tipo_ddt').change();
 		}
 		
 	});

function chooseSubmit(){	
	
	if(id_cliente_utilizzatore!=$('#cliente_utilizzatore').val() || id_sede_utilizzatore!= $('#sede_utilizzatore').val().split("_")[0]){
		modalSpostaStrumenti($('#cliente_utilizzatore').val(), $('#sede_utilizzatore').val());
	}else{
		if($('#tipo_ddt').val()==1){
			modificaPaccoSubmit(0);
		}else{
			modalConfigurazione();
		}
	}
}

function modalSpostaStrumenti(id_util, id_sede_util){
	
	$('#id_util').val(id_util);
	$('#id_sede_util').val(id_sede_util);
	$('#myModalSpostaStrumenti').modal();
}



	function validateForm() {
	    var codice_pacco = document.forms["ModificaPaccoForm"]["codice_pacco"].value;
	    var cliente = document.forms["ModificaPaccoForm"]["select1"].value;
	  
	    if($('#data_arrivo').val()=='' && !$('#data_arrivo').prop('disabled')){
			$('#data_arrivo').attr('required', true);
			return false;
		}
		if($('#data_spedizione').val()=='' && !$('#data_spedizione').prop('disabled')){
			$('#data_spedizione').attr('required', true);
			return false;
		}	    
	    
	    if (codice_pacco=="" || cliente =="") {
	      
	        return false;
	    }else{
	    	return true;
	    }
	}

 	function formatDate(data, container){
	
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   if(container == '#data_ora_trasporto'){
			 str = mydate.toString("dd/MM/yyyy");
		   }else{
			   str = mydate.toString("dd/MM/yyyy");
		   }
		   
		   $(container).val(str );
 		}
	
	}
 function modificaPaccoModal(attivita_json, id_cliente,nome_cliente, id_sede, nome_sede){
	 
	 //<option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option>
	// $('#select1').val(id_cliente+"_"+nome_cliente);
	 $('#select1').val(id_cliente);
	 $('#select1').change();
	 
	 
 	 var commessa ="${commessa}";
 	/*	 if(commessa!=''){
		 var utilizzatore = "${commessa.ID_ANAGEN_UTIL}";
		 var sede_utilizzatore = "${commessa.getK2_ANAGEN_INDR_UTIL()}";
	 }else{
		 var utilizzatore = id_cliente;
		 var sede_utilizzatore = id_sede;
	 } */
	 
	 var utilizzatore = "${pacco.id_cliente_util}";
	 var sede_utilizzatore = "${pacco.id_sede_util}";
	 
	 if(utilizzatore == '0' && sede_utilizzatore == '0'){
		 if(commessa!=''){
			 utilizzatore = "${commessa.ID_ANAGEN_UTIL}";
			 sede_utilizzatore = "${commessa.getK2_ANAGEN_INDR_UTIL()}"; 
		 }else{
			 utilizzatore = id_cliente;
			 sede_utilizzatore = id_sede;
		 } 
	 }
	
	 $('#cliente_utilizzatore').val(utilizzatore);
	 $('#cliente_utilizzatore').change();
	 if(sede_utilizzatore!='0'){
		 $('#sede_utilizzatore').val(sede_utilizzatore+"_"+utilizzatore);
		 $('#sede_utilizzatore').change();	 
	 }else{
		 $('#sede_utilizzatore').val(0);
		 $('#sede_utilizzatore').change();
	 }
	 
	 initSelect2('#select1');
	 initSelect2('#cliente_utilizzatore');
	 id_cliente_utilizzatore = utilizzatore;
	 id_sede_utilizzatore = sede_utilizzatore;
	 
	 
	 modificaPacco(attivita_json, rilievi);
	 
 }
 	
 	
	$("#fileupload_ddt").change(function(event){
			
     if ($(this).val().split('.').pop()!= 'pdf' && $(this).val().split('.').pop()!= 'PDF') {
        	$('#myModalLabelHeader').html("Attenzione!");
        	
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').modal('show');
        	
			$(this).val("");
        }
		
	});
	
	var item_modifica;
	function modificaCampiItemModal(id_item, matricola, codice_interno, denominazione){
		item_modifica=id_item;
		$('#matricola_item').val(matricola);
		$('#codice_interno_item').val(codice_interno);
		$('#denominazione_item').val(denominazione);
		$('#myModalModificaItem').modal();
	}
 	
	
	function dettaglioStrumento(id_strumento){

		$('#myModalLabelHeader').html("");
    	
		$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-success");
		$('#myModalError').css("z-index", "1070");
 	    	exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	//$('body').addClass('noScroll');
 
	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


       	var  contentID = e.target.id;

       	if(contentID == "dettaglioTab"){
       		exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
       	}
       	if(contentID == "misureTab"){
       		exploreModal("strumentiMisurati.do?action=ls&id="+id_strumento,"","#misure")
       	}
       	if(contentID == "modificaTab"){
       		exploreModal("modificaStrumento.do?action=modifica&id="+id_strumento,"","#modifica")
       	}
       	if(contentID == "documentiesterniTab"){
       		exploreModal("documentiEsterni.do?id_str="+id_strumento,"","#documentiesterni")
       
       	}
       	
       	
       	

 		});
	   
	   $('#myModal').on('hidden.bs.modal', function (e) {

    	 	$('#dettaglioTab').tab('show');
    	 	
    	});
	   
	}
	
	
	
	 function dettaglioRilievo(id_rilievo) {
			
		 var cliente =  '${utl:encryptData(pacco.id_cliente_util)}';
		 
		  var filtro =  '${utl:encryptData(0)}';

	 	 //dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+$('#cliente_filtro').val()+"&filtro_rilievi=" +$('#filtro_rilievi').val();
		 dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+cliente+"&filtro_rilievi="+filtro; 
	 	 
		  callAction("gestioneRilievi.do"+dataString, false, false);
	 }
	
	
	var columsDatatables1 = [];
	  
	$("#tabItems").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabItems thead th').each( function () {
	    	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
	    	var title = $('#tabItems thead th').eq( $(this).index() ).text();
	    
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');
	    	} );

	} );
	
	
	
	var columsDatatables4 = [];
	  
	$("#tabItemsRil").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabItemsRil thead th').each( function () {
	    	if(columsDatatables4.length==0 || columsDatatables4[$(this).index()]==null ){columsDatatables4.push({search:{search:""}});}
	    	var title = $('#tabItemsRil thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables4[$(this).index()].search.search+'" type="text" /></div>');
	    	} );

	} );
	
	
 //  	 var columsDatatables2 = [];
	  
 	$("#tabItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	    }
	  /*   $('#tabItem thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} ); */

	} );    
 	
 	
 	$("#tabItemModRil").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	    }
	  /*   $('#tabItem thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} ); */

	} );    
	

 	$('#tabItem').on('draw.dt', function() {
  	    $('input').iCheck({
  	        checkboxClass: 'icheckbox_square-blue',
  	        radioClass: 'iradio_square-blue',
  	        increaseArea: '20%' // optional
  	    });
  	});
 	
 	
	var columsDatatables3 = [];
	  
 	$("#tabAccettazione").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables3 = state.columns;
	    }

		   
		   $('#tabAccettazione thead th').each( function () {
	    		if(columsDatatables3.length==0 || columsDatatables3[$(this).index()]==null ){columsDatatables3.push({search:{search:""}});}
	  	 		var title = $('#tabAccettazione thead th').eq( $(this).index() ).text();
	 	  		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables3[$(this).index()].search.search+'"/></div>');
	   		} ); 

	} ); 
 	
 	
	$("#commessa").change(function(){
		if($("#commessa").val()!= null && $("#commessa").val()!=''){
		$("#commessa_text").val($("#commessa").val().split("*")[0]);
		 id_commessa = $('#commessa_text').val();
		showNoteCommessa(id_commessa); 
		}
	});

	$(".select2").select2();
	
	$("#commessa").select2({
        dropdownParent: $('#myModalModificaPacco')
    });		
	
	
	
	
	 function checkStatoLavorazione(stato){
		 
		 if(stato == 1){
			 $('#select_fornitore').attr('disabled', true);
			 $('#data_spedizione').attr('disabled', true);
			 $('#mitt_dest').html("Mittente");
			 $('#sede_mitt_dest').html("Sede Mittente");
			 $('#row_destinazione').hide();
			 $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
				}); 
			 
		 }
		 else if( stato == 2){
			 $('#select_fornitore').attr('disabled', true);
			 $('#data_spedizione').attr('disabled', true);
			 $('#data_arrivo').attr('disabled', true);
			 $('#row_destinazione').show();
			 $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
				}); 
		 }
		 else if(stato==3){
			 $('#select_fornitore').attr('disabled', true);
			 $('#data_arrivo').attr('disabled', true);
			 $('#row_destinazione').show();
			 $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
				}); 
			
		 }else if(stato == 4){
			 $('#select_fornitore').attr('disabled', false);
			 $('#data_spedizione').attr('disabled', false);
			 $('#data_arrivo').attr('disabled', true);
			 $('#row_destinazione').show();
			 $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
				}); 
		 }else{
			 $('#select_fornitore').attr('disabled', false);
			 $('#data_arrivo').attr('disabled', false);
			 $('#data_spedizione').attr('disabled', true);
			 $('#sede_mitt_dest').html("Sede Mittente");
			 $('#row_destinazione').hide();
			 $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
				}); 
		 }
	 }

	function tornaMagazzino(){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaPacchi.do');
	}
	
	function tornaItem(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		  callAction('listaItem.do?action=lista');
	}
	
	function modalYesOrNo(id_allegato, id_pacco){
		$('#id_allegato_elimina').val(id_allegato);
		$('#id_pacco_elimina').val(id_pacco);
		
		$('#myModalYesOrNo').modal();
	}
	
	
/* 	$('#tipo_item').change(function(){
		
		$('#tabModRilievi').hide();
		$('#btn_save_rilievo').hide();
		
		
		if($(this).val()==4){
			$('#tabModGeneral').hide();
			$('#tabModRilievi').show();
			
		}else{
			$('#tabModRilievi').hide();
			$('#tabModGeneral').show();
		}
		
	}); */
	
	var previous = $('#tipo_item').val(); 


	$('#tipo_item').change(function(event, clickedIndex, newValue, oldValue){
		
		$('#tabModRilievi').hide();
		$('#btn_save_rilievo').hide();

		
		   var table_ril = $('#tabItemModRil').DataTable();
		   
		   var table_item = $('#tabItem').DataTable();
		
			   
			var row_ril = table_ril.rows().data();
			var row_item = table_item.rows().data();
		
		
		if($(this).val()==4){
			
			if(row_item.length>0){			
		
	    				
	    				  $('#modalContent').html("Attenzione! Non &egrave; possibile aggiungere un rilievo al pacco contenente altri item!<br>Vuoi eliminare gli item e inserire rilievi?");    				 
	    	        
	          			 $("#myModalRilItem").modal();
	          			 $('#ril_item').val(previous);
	          			 
				
			}else{
				$('#tabModGeneral').hide();
				$('#tabModRilievi').show();	
			}		
			rilievi = true;
			
		}else{
			
			if(row_ril.length>0){
		
					  $('#modalContent').html("Attenzione! Non &egrave; possibile aggiungere un item al pacco contenente rilievi dimensionali!<br>Vuoi eliminare i rilievi e inserire altri item?");
					 
	      			 $("#myModalRilItem").modal();
	      			$('#ril_item').val(previous);
			}else{
				$('#tabModGeneral').show();
				$('#tabModRilievi').hide();
			}
			rilievi = false;
		}
		previous = $(this).val();
		
	}); 


	$('#myModalRilItem').on('hidden.bs.modal',function(){
		
		if($('#tipo_item').val()!=$('#ril_item').val()){
			$('#tipo_item').val($('#ril_item').val());
			$('#tipo_item').change();	
		}
		
	});

	function changeTable(){
		
		$('#ril_item').val($('#tipo_item').val());
		$('#myModalRilItem').modal('hide');
		$('#listaRilievi').hide();
		$('#btn_save_rilievo').hide();
		
		if($('#tipo_item').val()==4){
			
			  var tab = $('#tabItem').DataTable();
			  items_json =[];
			  tab.clear().draw();
			$('#tabModGeneral').hide();
			$('#tabModRilievi').show();	
			rilievi = true;
			
		}else{
			  var tab = $('#tabItemModRil').DataTable();
			  items_rilievo = []
			  tab.clear().draw();
			$('#tabModGeneral').show();
			$('#tabModRilievi').hide();
			rilievi = false;
		}
		
	}
	

	var items_rilievo = [];

	function insertRilievo(){
		
		//items_rilievo = items_json;
		
		if($('#disegno').val()=='' || $('#variante').val()=='' || $('#pezzi_ingresso').val()==''){
			
			$('#myModalErrorContent').html('Attenzione! Inserisci tutti i campi!');
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#myModalError').modal();
			
		}else{
			
			
			var flag = true;
			
			if(items_rilievo.length>0){
			
				for(var i = 0; i<items_rilievo.length; i++){
					if(items_rilievo[i].disegno == $('#disegno').val()){
						flag = false;
					}
				}
			}
			
			if(flag){
				
				var rilievo = {};
				
				rilievo.id_proprio ="";
				rilievo.disegno = $('#disegno').val();
				rilievo.variante = $('#variante').val();
				rilievo.pezzi_ingresso = $('#pezzi_ingresso').val();
				rilievo.note_rilievo = $('#note_rilievo').val();
				/* rilievo.action = '<button class="btn btn-danger" onClick="eliminaRilievoTable(\''+ $('#disegno').val()+'\')"><i class="fa fa-trash"></i></button>'; */
				rilievo.action = '<button class="btn btn-warning" onClick="modificaRilievoTable(\''+ rilievo.id+'\', this)"><i class="fa fa-edit"></i></button> <button class="btn btn-danger" onClick="eliminaRilievoTable(null,\''+ rilievo.id+'\')"><i class="fa fa-trash"></i></button>';
				items_rilievo.push(rilievo)
				
				   var table_ril = $('#tabItemModRil').DataTable();
					  
				table_ril.clear().draw();
				   
				table_ril.rows.add(items_rilievo).draw();
				

				    
				table_ril.columns().eq( 0 ).each( function ( colIdx ) {
				  	  $( 'input', table_ril.column( colIdx ).header() ).on( 'keyup', function () {
				  		table_ril
				  	          .column( colIdx )
				  	          .search( this.value )
				  	          .draw();
				  	  } );
				  	} ); 
				table_ril.columns.adjust().draw();
			}else{
				
				$('#myModalErrorContent').html('Attenzione! Hai gi&agrave; inserito questo disegno!');
				$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#myModalError').modal();
				
			}

			
		}
		
		


	}

	
	function eliminaRilievoTable(disegno, id){	
		
		
		new_items_rilievo=[];
		
		items_rilievo.forEach( function (item){
			if(id!=null && disegno==null){
				if(item.id_proprio == id){
					
				}else{
					new_items_rilievo.push(item);
				}
			}else{
				if(item.disegno == disegno){
					
				}else{
					new_items_rilievo.push(item);
				}
			}
				
				
			});
			

		items_rilievo = new_items_rilievo;
		
		   var table_ril = $('#tabItemModRil').DataTable();
			  
			table_ril.clear().draw();
			   
			table_ril.rows.add(items_rilievo).draw();
			    
			 table_ril.columns().eq( 0 ).each( function ( colIdx ) {
			  	  $( 'input', table_ril.column( colIdx ).header() ).on( 'keyup', function () {
			  		table_ril
			  	          .column( colIdx )
			  	          .search( this.value )
			  	          .draw();
			  	  } );
			  	} );  
			table_ril.columns.adjust().draw();
	}

	$('#btnAddFileInput').on('click', function() {
        createFileInput();
        var input = $('#fileInputsContainer input[type="file"]:last');
        input.trigger('click');
      });
	
	 function createFileInput() {
	        var input = $('<input type="file">');
	        id = $('#id_item_rilievi_modifica').val()
	        
	        input.attr('name', 'modifica_pezzi_rilievo_upload_' + id);
	        input.attr("accept", ".pdf,.PDF");
	        
	        // Assegna il file selezionato all'input corrispondente
	        input.on('change', function() {
	          var file = this.files[0];
	          console.log('File selezionato:', file);
	          $('#label_file_rilievi').html($(this).val().split("\\")[2]);
	  		if($(this).val()!=null && $(this).val()!='' && $('#pezzi_ingresso_mod').val()!=null && $('#pezzi_ingresso_mod').val()!=''){
	  			$('#salva_btn_rilievi').attr('disabled', false);
	  		}else{
	  			$('#salva_btn_rilievi').attr('disabled', true);
	  		}
	        });
	        
	        // Aggiungi l'input al container
	        $('#fileInputsContainer').append(input);
	        input.hide();
	        
	  
	      }
	
	$('#fileupload_rilievi').change(function(){
		
		$('#label_file_rilievi').html($(this).val().split("\\")[2]);
		if($(this).val()!=null && $(this).val()!='' && $('#pezzi_ingresso_mod').val()!=null && $('#pezzi_ingresso_mod').val()!=''){
			$('#salva_btn_rilievi').attr('disabled', false);
		}else{
			$('#salva_btn_rilievi').attr('disabled', true);
		}

	})
	
	
	function modificaRilievoTable(id_item,button){
		console.log(id_item);
		$('#id_item_rilievi_modifica').val(id_item);
		
		 var component = $(button);
		  var rowId = component.closest('tr').attr('id');
		$('#id_row_rilievi').val(rowId);
		
		
		console.log(id_item_rilievi_modifica);
		$('#modalModificaPezziIngresso').modal();
		
	

		
		$('#pezzi_ingresso_mod').change(function(){
			
			if($(this).val()!=null && $(this).val()!='' && $('#label_file_rilievi').html()!=null && $('#label_file_rilievi').html()!=''){
				$('#salva_btn_rilievi').attr('disabled', false);
			}else{
			
				$('#salva_btn_rilievi').attr('disabled', true);
			}
			
		});
		
		
	}
	
	var id_item_rilievi_modifica = null;
 	var stato_lav = null;
 	 
 	var commessa_options;

 	var id_cliente_utilizzatore;
 	var id_sede_utilizzatore;
 	
 	
 	var myJSONString = JSON.stringify(${item_pacco_json});
 	var myEscapedJSONString = myJSONString.replace(/\\n/g, "\\n")
 	                                      .replace(/\\'/g, "\\'")
 	                                      .replace(/\\"/g, '\\"')
 	                                      .replace(/\\&/g, "\\&")
 	                                      .replace(/\\r/g, "\\r")
 	                                      .replace(/\\t/g, "\\t")
 	                                      .replace(/\\b/g, "\\b")
 	                                      .replace(/\\f/g, "\\f");
 	 
 	var item_pacco_json = JSON.parse(myEscapedJSONString);
 	var rilievi = false;
 	
 
 	
   $(document).ready(function() {
	   
	  console.log("test")
	   
	   commessa_options = $('#commessa option').clone();
	   
    stato_lav = ${pacco.stato_lavorazione.id};


    checkStatoLavorazione(stato_lav);
    
    
	   var columsDatatables2 = [];
	   
	   $('#tabItem thead th').each( function () {
    		if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
  	 		var title = $('#tabItem thead th').eq( $(this).index() ).text();
 	  		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
   		} ); 
	   
	   $('#tabItemModRil thead th').each( function () {
   		if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
 	 		var title = $('#tabItemModRil thead th').eq( $(this).index() ).text();
	  		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
  		} ); 
	   
	   

	   $('#commessa_text').change();
	   
		$('#select3').parent().hide();
		selection1= $('#select1').html();		

	  	$('#select1').select2({
			placeholder : "Seleziona Cliente...",
			
		});  



	   var data_ora_trasporto = $('#data_ora_trasporto').val();
	   var data_ddt = $('#data_ddt').val();
	   var data_arrivo = $('#data_arrivo').val();
	   var data_lavorazione = $('#data_lavorazione').val();
	   var data_spedizione = $('#data_spedizione').val();
	   
	   formatDate(data_ora_trasporto, '#data_ora_trasporto');	   
	   formatDate(data_ddt, '#data_ddt');	   
	   formatDate(data_arrivo, '#data_arrivo');	   
	   formatDate(data_lavorazione, '#data_lavorazione');
	   formatDate(data_spedizione, '#data_spedizione');
	  
 	$('.datepicker').datepicker({
			format : "dd/mm/yyyy"
				
		}); 
	 

 table_items = $('#tabItems').DataTable({
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
	      searchable: true, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      columnDefs: [
/*   				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                      */
  	              	    { responsivePriority: 1, targets: 10 },
	                   { responsivePriority: 2, targets: 11 },
	                   { responsivePriority: 3, targets: 12 },
	                   { responsivePriority: 4, targets: 3 },
	                   { responsivePriority: 5, targets: 0 },
	                   { responsivePriority: 6, targets: 1 },
	                   { responsivePriority: 7, targets: 2 },
	                   { responsivePriority: 8, targets: 7 },
	                   { responsivePriority: 9, targets: 5 },
	                   { responsivePriority: 10, targets: 6 } 


	               ], 
	               buttons: [   
	        	          {
	        	            extend: 'colvis',
	        	            text: 'Nascondi Colonne'  	                   
	       			  } ]

	    	
	    });
	
 table_items.buttons().container().appendTo( '#tabItems_wrapper .col-sm-6:eq(1)');



	
  $('#tabItems').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	 
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});  
  
  
  
  
  table_items = $('#tabItems').DataTable();
//Apply the search
table_items.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table_items.column( colIdx ).header() ).on( 'keyup', function () {
	table_items
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
table_items.columns.adjust().draw();  







table_items_ril = $('#tabItemsRil').DataTable({
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
      searchable: true, 
      targets: 0,
      responsive: true,
      scrollX: false,
      stateSave: true,
      columnDefs: [
/*   				   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                      */
	              	    { responsivePriority: 1, targets: 0 },
                


               ], 
               buttons: [   
        	          {
        	            extend: 'colvis',
        	            text: 'Nascondi Colonne'  	                   
       			  } ]

    	
    });

table_items_ril.buttons().container().appendTo( '#tabItemsRil_wrapper .col-sm-6:eq(1)');




$('#tabItemsRil').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
 theme: 'tooltipster-light'
});
 
$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})


});  




table_items_ril = $('#tabItemsRil').DataTable();
//Apply the search
table_items_ril.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table_items_ril.column( colIdx ).header() ).on( 'keyup', function () {
	table_items_ril
   .column( colIdx )
   .search( this.value )
   .draw();
} );
} ); 
table_items_ril.columns.adjust().draw();  



 

 
 table = $('#tabItem').DataTable({
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
      responsive: false,
      scrollX: true,
      stateSave: true,
      fixedColumns: false,
      columns : [
     	 {"data" : "id_proprio"},
     	 {"data" : "tipo"},
     	 {"data" : "denominazione"},
     	 {"data" : "quantita"},
     	 {"data" : "stato"},
     	 {"data" : "matricola"},
     	 {"data" : "codice_interno"},
     	 {"data" : "attivita"},
     	 {"data" : "destinazione"},     	
     	 {"data" : "priorita","className": "text-center"},
     	 {"data" : "note"},
     	 {"data" : "action"}
     	
      ],	
         columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   { responsivePriority: 3, targets: 2 }
               ],  
               buttons: [   
     	          {
     	            extend: 'colvis',
     	            text: 'Nascondi Colonne'  	                   
    			  } ]
    	
    });
 table.buttons().container().appendTo( '#tabItem_wrapper .col-sm-6:eq(1)');

 
     $('.inputsearchtable').on('click', function(e){
       e.stopPropagation();    
    });     
//DataTable

  table = $('#tabItem').DataTable();
//Apply the search
table.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
table
   .column( colIdx )
   .search( this.value )
   .draw();
} );
} ); 
table.columns.adjust().draw();  






 
tableModRil = $('#tabItemModRil').DataTable({
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
      stateSave: true,
      fixedColumns: false,
      rowCallback: function(row, data, index) {
    	    // Genera un ID univoco per ogni riga
    	    var rowId = 'row_' + index;
    	    
    	    // Assegna l'ID alla riga
    	    $(row).attr('id', rowId);
    	  },
      columns : [
     	 {"data" : "id_proprio"},
     	 {"data" : "disegno"},
     	 {"data" : "variante"},
     	 //{"data" : "pezzi_ingresso", createdCell: editableCell},
     	{"data" : "pezzi_ingresso"},
     	 {"data": "note_rilievo"},
     	{"data" : "action"}

     	
      ],	
         columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   { responsivePriority: 3, targets: 2 }
               ],  
               buttons: [   
     	          {
     	            extend: 'colvis',
     	            text: 'Nascondi Colonne'  	                   
    			  } ]
    	
    });
tableModRil.buttons().container().appendTo( '#tabItemModRil_wrapper .col-sm-6:eq(1)');

 
     $('.inputsearchtable').on('click', function(e){
       e.stopPropagation();    
    });     


  /* tableModRil = $('#tabItemModRil').DataTable(); */

tableModRil.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tableModRil.column( colIdx ).header() ).on( 'keyup', function () {
	tableModRil
   .column( colIdx )
   .search( this.value )
   .draw();
} );
} ); 
tableModRil.columns.adjust().draw();  



 
var permesso = ${userObj.checkPermesso('ACCETTAZIONE_PACCO')};
if(stato_lav==1 && permesso==true){
	$('#boxAccettazione').show();

   
   table_accettazione = $('#tabAccettazione').DataTable({
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
	      searchable: true, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      serverSide: false,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 3 }
	               ], 
	    	
	    });



	
 $('#tabAccettazione').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});
	 
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});  
 $('.inputsearchtable').on('click', function(e){
     e.stopPropagation();    
  });   
 
 
 table_accettazione = $('#tabAccettazione').DataTable();
//Apply the search
table_accettazione.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table_accettazione.column( colIdx ).header() ).on( 'keyup', function () {
	table_accettazione
      .column( colIdx )
      .search( this.value )
      .draw();
} );
} ); 
table_accettazione.columns.adjust().draw();  
   

}else{
	$('#boxAccettazione').hide();
}


   $('#checkbox_all').on('ifClicked',function(e){
	   var tabella = $('#tabAccettazione').DataTable();
	   var data = tabella
	     .rows()
	     .data();
		 if($('#checkbox_all').is( ':checked' )){
			 for(var i = 0; i<rows_accettazione; i++){
				 $('#checkbox_accettazione_'+data[i][0]).iCheck('uncheck');
			 }
		 }else{
			 for(var i = 0; i<rows_accettazione; i++){
				 $('#checkbox_accettazione_'+data[i][0]).iCheck('check');				
			 }			 
		 }

	 });   



if(idCliente != 0 && idSede != 0){
	 $("#select1").prop("disabled", true);
	$("#select2").change();
}else if(idCliente != 0 && idSede == 0){
	 $("#select1").prop("disabled", true);
	 $("#select1").attr("disabled", true);
	 $("#select2").prop("disabled", false);
	$("#select1").change();
}else{
	clienteSelected =  $("#select1").val();
	sedeSelected = $("#select2").val();
	
	if((clienteSelected != null && clienteSelected != "") && (sedeSelected != null && sedeSelected != "")){
		$("#select2").change();
		 $("#select2").prop("disabled", false);
		 $("#select1").prop("disabled", false);
	}else if((clienteSelected != null && clienteSelected != "") && (sedeSelected == null || sedeSelected == "")){
		$("#select1").change();
		 $("#select1").prop("disabled", false);
		 $("#select2").prop("disabled", false);
	}
}




$('#allegati').fileupload({
    url: "gestionePacco.do?action=upload_allegati&id_pacco="+"${pacco.id}",
    dataType: 'json',
    maxNumberOfFiles : 100,
    getNumberOfFiles: function () {
        return this.filesContainer.children()
            .not('.processing').length;
    },
    start: function(e){
    	 pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal(); 
    },
    add: function(e, data) {
        var uploadErrors = [];
        var acceptFileTypes =  /(\.|\/)(eml|msg|gif|png|jpe?g)$/i;       
       if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
               uploadErrors.push('Tipo File non accettato. ');
           }
       if(data.originalFiles[0]['size'] > 10000000) {
               uploadErrors.push('File troppo grande, dimensione massima 10mb');
           }      
       if(uploadErrors.length > 0) {
          	//$('#files').html(uploadErrors.join("\n"));
          	$('#myModalErrorContent').html(uploadErrors.join("\n"));
  			$('#myModalError').removeClass();
  			$('#myModalError').addClass("modal modal-danger");
  			$('#myModalError').modal('show');
        } else {
            data.submit();
        }
	},
    done: function (e, data) {
		
    	pleaseWaitDiv.modal('hide');
    	
    	if(data.result.success)
		{
    		$('#myModalErrorContent').html("Upload completato con successo!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
			$('#myModalError').on('hidden.bs.modal', function(){
				location.reload();
			});
			
			
			
		}else{
			
			$('#myModalErrorContent').html("Errore nell'upload!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');
			$('#progress .progress-bar').css(
                    'width',
                    '0%'
                ); 
            //$('#files').html("ERRORE SALVATAGGIO");
		}


    },
    fail: function (e, data) {
    	pleaseWaitDiv.modal('hide');
    	//$('#files').html("");
    	var errorMsg = "";
        $.each(data.messages, function (index, error) {

        	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
   
        });
        $('#myModalError').html(errorMsg);
		$('#myModal').removeClass();
		$('#myModal').addClass("modal modal-danger");
		$('#myModalErrorContent').modal('show');
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
}).prop('disabled', !$.support.fileInput)
.parent().addClass($.support.fileInput ? undefined : 'disabled');


table = $('#tabAllegati').DataTable({
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
      paging: false, 
      ordering: false,
      info: false, 
      searchable: false, 
      targets: 0,
      responsive: true,
      scrollX: false,
      stateSave: true,
      searching: false,
       columns : [
     	 {"data" : "allegato"},
     	 {"data" : "action"}
      ],	
        /* columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   { responsivePriority: 3, targets: 2 }
               ],   */

    	
    });



if(item_pacco_json.length>0 && item_pacco_json[0].item!=null && item_pacco_json[0].item.tipo_item.id==4){
	   $('#tabItemGeneral').hide();
	   $('#tabItemRilievi').show();
	   $('#btn_save_rilievo').show();
	   $('#tipo_item ').val(4);
	   $('#tipo_item ').change();  
	   
	   $('#tipo_item option').each(function(){
		   
		   var id = $(this).val();
		   
		   if(id!="4"){
			   this.selected = false;
			   this.disabled = true;
		   } 

	   });
	   
	   rilievi = true;
}
else if(item_pacco_json.length==0){
	   $('#tipo_item ').val(1);
	   $('#tipo_item ').change(); 
}
else{
	   $('#tipo_item ').val(1);
	   $('#tipo_item ').change(); 
		$('#tipo_item option').each(function(){
		   
		   var id = $(this).val();
		   
		   if(id=="4"){
			   this.selected = false;
			   this.disabled = true;
		   }
		  

	   });
}



 });  
   
   

	      $('#sede_destinazione').change(function(){
	    	  $('#conf_button').addClass("disabled");
	   if($('#tipo_ddt').val() != 1){
		  var id_cliente = $('#destinazione').val();
		  var id_sede = $('#sede_destinazione').val().split('_')[0];
		  var lista_save_stato = '${lista_save_stato_json}';
		  
		  
		  var save_stato_json = JSON.parse(lista_save_stato);
		  save_stato_json.forEach(function(item){
			 
			  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
				 $('#conf_button').removeClass("disabled");	 			 
			  }
		  
		  
		  });
	   }
		  
	  }); 
	
   
   
   $('#tipo_ddt').change(function(){
		 $('#select2').change();
	  });
   
   $('#tipologia').on('change', function(){
		
		selection= $(this).val();

		if(selection=="1"){
		
	 		$('#select1').select2({
				placeholder : "Seleziona Cliente..."
			}); 
	 		
			$('#select1').html(selection1);	
			
		}else{

	 		$('#select1').select2({
				placeholder : "Seleziona Fornitore..."
			}); 
	 		
			$('#select1').html($('#select3 option').clone());
		} 

	});
   
   
   
   var idCliente = ${userObj.idCliente}
   var idSede = ${userObj.idSede}

    $body = $("body");
      


     $("#select1").change(function() {
    
  	  if ($(this).data('options') == undefined) 
  	  {
  
  	    $(this).data('options', $('#select2 option').clone());
  	  }
  	  
  	  var id = $(this).val()

  	  var options = $(this).data('options');
  	 
  	  
  	  var opt=[];
  	  
  	 opt.push("<option value = 0>Non Associate</option>");

  	   for(var  i=0; i<options.length;i++)
  	   {
  		var str=options[i].value; 
  	
  		if(str!='' && str.split("_")[1]==id)
  		{
  			opt.push(options[i]);
  		}   
  	   }
  	 $("#select2").prop("disabled", false);   	 
  	  $('#select2').html(opt);   
  	  var sede = '${pacco.id_sede}';
  	  if(sede=='0'){
  		$("#select2").val('${pacco.id_sede}');
  	  }else{
  		$("#select2").val('${pacco.id_sede}_${pacco.id_cliente}');  
  	  }
		
  		$("#select2").change();  
  	   
  		var id_cliente = id;
		  
  		
		  var options = commessa_options;
		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			var str=options[i].value; 		
			
			if(str.split("*")[1] == id_cliente)	
			{
				opt.push(options[i]);
			}   
	    
		   } 
		$('#commessa').html(opt);
		$('#commessa').val("");
		$("#commessa").change();  
  	  	$('#commessa_text').val("${pacco.commessa}");
  	}); 
   	
     
     $("#select2").change(function(){
    	 if($('#select1').val()== $('#cliente_utilizzatore').val()){
    		 $('#sede_utilizzatore').val($(this).val());
  	   		 $('#sede_utilizzatore').change();
    	 }
     });  
     
     
     
     $("#cliente_utilizzatore").change(function() {
   	  
   	  if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#sede_utilizzatore option').clone());
   	  }
   	  
   	  var id = $(this).val()
   	 
   	 // var id = selection.substring(0,selection.indexOf("_"));
   	  
   	  var options = $(this).data('options');

   	  var opt=[];
   	
   	  opt.push("<option value = 0>Non Associate</option>");

   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 
   	
   		if(str!='' && str.split("_")[1]==id)
   		{
   			opt.push(options[i]);
   		}   
   	   }
   	 $("#sede_utilizzatore").prop("disabled", false);
   	 
   	  $('#sede_utilizzatore').html(opt);
   		$("#sede_utilizzatore").change();  
   	});
   	
   	
     	 $("#destinatario").change(function() {         
        	  if ($(this).data('options') == undefined) 
        	  {
        	   
        	    $(this).data('options', $('#sede_destinatario option').clone());
        	  }
        	  
        	  var id = $(this).val();
        	  var options = $(this).data('options');
        	//  var id_sede = ${pacco.ddt.id_sede_destinazione };      	  
        	  var opt=[];      	
        	  opt.push("<option value = 0 >Non associate</option>");
        	   for(var  i=0; i<options.length;i++)
        	   {
        		   
        		var str=options[i].value.split("_");       		
        		if(str[1]==id)
        		{
        			opt.push(options[i]);      			
        		}   
        	   }
        	 $("#sede_destinatario").prop("disabled", false);   	 
        	  $('#sede_destinatario').html(opt);   	  
        	  //$("#sede_destinatario").trigger("chosen:updated");   	  
        		$("#sede_destinatario").change();  
        	});
       
       $("#destinazione").change(function() {    
    	   
 	   
    	   
       	  if ($(this).data('options') == undefined) 
       	  {
       	    
       	    $(this).data('options', $('#sede_destinazione option').clone());
       	  }
       	var id2 = $(this).val();
       	
       	       	      
       	if($(this).val()!=""){
       		id = $(this).val().split("_");
       	}else{
       		id=$(this).val();
       	}
       	
       	  var options = $(this).data('options');
       	  var id_sede = ${pacco.id_sede };      	  
       	  var opt=[];      	

       	opt.push("<option value = 0>Non Associate</option>");
       	  
       	   for(var  i=0; i<options.length;i++)
       	   {
       		var str=[]
    		str=options[i].value.split("_");       		
    		if(str[1]==id[0])
       		{
       			opt.push(options[i]);      			
       		}   
       	   }
       	 $("#sede_destinazione").prop("disabled", false);   	 
       	  $('#sede_destinazione').html(opt);   	  
       	  //$("#sede_destinazione").trigger("chosen:updated");   	  
       		$("#sede_destinazione").change();  
       		

       	}); 
       

       
       $('#collapsed_box_btn').click(function(){
    	 //  destinazioneBox();
    	   var bf = $('#collapsed_box').find(".box-body, .box-footer");
    	   
    	   if (bf.is(':hidden')) {
    	        destinazioneBox();
    	    }
    	   bf.slideDown();
       });
       
   	 $('#ModificaPaccoForm').on('submit',function(e){
   	 	    e.preventDefault();

   	 	});    
   	 

     
     $("#myModalError").on("hidden.bs.modal", function () {
   	  
   	  if($('#myModalError').hasClass("modal-success")){
   		if(!$('#myModalModificaPacco').hasClass('in')){
   	  		location.reload();
   		}
     }
   	    
   	}); 
     
     
     
     function aggiornaTabellaRilievi(numero_pezzi, item){
    	 
   
    	 var row = $('#id_row_rilievi').val();
    	 
    	    	 
    
    	    var colIndex = 3;
    	    var rowIndex = parseInt(row.split("_")[1]);
    	    
    	    var n_pezzi_old = tableModRil.cell(rowIndex, colIndex).data();
    	    var note = tableModRil.cell(rowIndex, 4).data();
    	    
    	    var tot = parseInt(numero_pezzi)+parseInt(n_pezzi_old);
    	    tableModRil.cell(rowIndex, colIndex).data(tot);
    	    var oggi = new Date();
    	    var giorno = oggi.getDate();
    	    var mese = oggi.getMonth() + 1;
    	    var anno = oggi.getFullYear();
    	    if(mese<10){
    	    	mese = "0"+mese;
    	    }

    	    var dataOggi = giorno + '/' + mese + '/' + anno;
    	    tableModRil.cell(rowIndex, 4).data(note+"- N. pezzi mod. da "+n_pezzi_old+" a " +tot+" in data "+dataOggi+" da ${utente.getNominativo()} ");
    	   // tableModRil.columns.adjust().draw();
    	
    	$('#modalModificaPezziIngresso').modal("hide");
     }
     
     
     $('#modalModificaPezziIngresso').on("hidden.bs.modal", function(){
    	
    	 $('#pezzi_ingresso_mod').val("");
    	 $('#fileupload_rilievi').val(null);
    	 $('#label_file_rilievi').html("");
    	 
    	 
     });


	     function accettaItem(){
			   var tabella = $('#tabAccettazione').DataTable();
			   var data = tabella
			     .rows()
			     .data();
			   
			   accettati=[];
			   non_accettati=[];
			   note_acc=[];
			   note_non_acc=[];
				for(var i=0; i<rows_accettazione; i++){
					 if($('#checkbox_accettazione_'+data[i][0]).is( ':checked' )){					 
						accettati.push(data[i][0]);
						note_acc.push($('#note_accettazione_'+data[i][0]).val());
					 }else{
						 non_accettati.push(data[i][0]);
						 note_non_acc.push($('#note_accettazione_'+data[i][0]).val());
					 }
				}			
				var accettati_json = JSON.stringify(accettati);
				var non_accettati_json = JSON.stringify(non_accettati);
				var note_acc_json = JSON.stringify(note_acc);
				var note_non_acc_json = JSON.stringify(note_non_acc);
				accettazione(accettati_json,non_accettati_json, note_acc_json, note_non_acc_json, '${pacco.id}');
			}
		
		
	     
	     
	     
	     var options =  $('#cliente_appoggio option').clone();
	     function mockData() {
	     	  return _.map(options, function(i) {		  
	     	    return {
	     	      id: i.value,
	     	      text: i.text,
	     	    };
	     	  });
	     	}
	     	


	     function initSelect2(id_input, placeholder) {

	    	 if(placeholder==null){
	   		  placeholder = "Seleziona Cliente...";
	   	  }
	     	$(id_input).select2({
	     		dropdownParent: $('#myModalModificaPacco'),
	     	    data: mockData(),
	     	    placeholder: placeholder,
	     	    multiple: false,
	     	    // query with pagination
	     	    query: function(q) {
	     	      var pageSize,
	     	        results,
	     	        that = this;
	     	      pageSize = 20; // or whatever pagesize
	     	      results = [];
	     	      if (q.term && q.term !== '') {
	     	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
	     	        results = _.filter(x, function(e) {
	     	        	
	     	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
	     	        });
	     	      } else if (q.term === '') {
	     	        results = that.data;
	     	      }
	     	      q.callback({
	     	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
	     	        more: results.length >= q.page * pageSize,
	     	      });
	     	    },
	     	  });
	     }
	     
	     
	     
	     
	     const editableCell = function(cell) {
	    		
	    		
	   	  let original

	   	  cell.setAttribute('contenteditable', true)
	   	  cell.setAttribute('spellcheck', false)
	   	  var index = cell._DT_CellIndex;
	   	  cell.setAttribute('id',""+index.row+""+index.column)	
	   	   $(cell).css('text-align', 'center');
	   	  
	   	  
	   	  cell.addEventListener('focus', function(e) {
	   	    original = e.target.textContent

	   	     $(cell).css('border', '2px solid red');
	   	    
	   	  })
	   	
	   	   cell.addEventListener('focusout', function(e) {
	   	    original = stripHtml(e.target.textContent)
	   	
	   	    $(cell).css('border', '1px solid #d1d1d1');
	   	   $(cell).css('border-bottom-width', '0px');
	   	    $(cell).css('border-left-width', '0px');
	   	     
	   	     
	   	    //$(e.currentTarget).html('<input type="text" value="'+original+'" onChange="salvaModificaQuestionario()">');
	   	  })
	   	  
	   	  cell.addEventListener('blur', function(e) {
	   	    if (original !== e.target.textContent) {
	   	      const row = tableModRil.row(e.target.parentElement)
	   	      tableModRil.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
	   	      var x = tableModRil.rows().data();
	   	      
	   	   items_rilievo[row.index()].pezzi_ingresso = e.target.textContent;
	   	      	//salvaModificaQuestionario();
	   	      console.log('Row changed: ', row.data())
	   	    }
	   	  })
	   	  
	   	
	   }

	     
</script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



