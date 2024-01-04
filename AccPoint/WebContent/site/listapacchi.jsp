
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%-- <%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> --%>
<%-- 	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");

	
	%> --%>
<%
	ArrayList<ClienteDTO> lista_clienti = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
	ArrayList<ClienteDTO> lista_fornitori = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_fornitori");
%>	
<c:set var="listaClienti" value="<%=lista_clienti %>"></c:set>
<c:set var="listaFornitori" value="<%=lista_clienti %>"></c:set>
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
        Lista Pacchi
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
       <a class="btn btn-default pull-right" href="#" id="tornaMagazzino" onClick="tornaMagazzino()" style="margin-right:5px;display:none"><i class="fa fa-dashboard"></i> Torna al Magazzino</a>
       
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista pacchi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-sm-12">

<button class="btn btn-primary" onClick="creaNuovoPacco()">Nuovo Pacco</button>
<button class="btn btn-primary customTooltip" onClick="pacchiEsterno()" title="Click per visualizzare i pacchi fuori dal magazzino" style="margin-left:5px">Pacchi all'esterno</button>
<button class="btn btn-primary customTooltip" onClick="pacchiInMagazzino()" title="Click per visualizzare i pacchi in magazzino" style="margin-left:5px">Pacchi in magazzino</button>
<!--  <button class="btn btn-primary btnFiltri pull-right" id="btnFiltri_APERTO" onClick="filtraPacchi('APERTO')" >APERTI</button>
 <button class="btn btn-primary btnFiltri pull-right" id="btnFiltri_CHIUSO" onClick="filtraPacchi('CHIUSO')" style="margin-right:3px">CHIUSI</button>
<button class="btn btn-primary btnFiltri pull-right" id="btnTutti" onClick="filtraPacchi('tutti')" style="margin-right:3px">TUTTI</button>  -->

<button class="btn btn-primary btnFiltri pull-right" id="btnFiltri_APERTO" onClick="filtraPacchi()" >APERTI</button>
 <button class="btn btn-primary btnFiltri pull-right" id="btnFiltri_CHIUSO" onClick="filtraPacchi('chiusi')" style="margin-right:3px">CHIUSI</button>
<button class="btn btn-primary btnFiltri pull-right" id="btnTutti" onClick="filtraPacchi('tutti')" style="margin-right:3px">TUTTI</button>

</div>
</div>


 <div class="row" style="margin-top:15px">
 <div class="col-xs-2">
 <div class="row" >
 <div class="col-xs-12">
 <label for="tipo_data" class="control-label">Tipo Data:</label>
 <select class="form-control select2" data-placeholder="Seleziona Tipo di Data..."  aria-hidden="true" data-live-search="true" style="width:100%" id="tipo_data" name="tipo_data">
 <option value=""></option>
 <option value="1">Data Creazione</option>
 <option value="2">Data Arrivo/Rientro</option>
 <option value="3">Data Spedizione</option>
 </select>
 </div>
 </div> 
 </div>
	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Date:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraPacchiPerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	<div class="col-md-3">
<label>Commessa</label>
<select class="form-control select2" data-placeholder="Seleziona Commessa..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_commessa" name="filtro_commessa">
<option value=""></option>
<c:forEach items="${lista_commesseTutte }" var="commessa" varStatus="loop">
	<option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
</c:forEach>
</select>

</div><button type="button" style="margin-top:25px" class="btn btn-primary btn-flat" onclick="resetCommesse()">Reset Commessa</button>
</div>



<div class="row">
<div class="col-lg-12">
 <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th style="min-width:190px">Azioni</th>
   <th >Origine</th>
 <th >Cliente</th>
 <th style="min-width:100px">Sede</th>
 <th >Commessa</th> 
  <th >Stato lavorazione</th>
  <th>Note</th>
  <th >Note Pacco</th>
   <th >Strumenti Lavorati</th>
   <th >DDT</th>
    <th >Fornitore</th>
    <th>Data Trasporto</th>
     <th >Data Spedizione</th>
<th>Data Arrivo/Rientro</th>
 
 <th >Stato Pacco</th>
 <th>Cliente Utilizzatore</th>
 <th>Sede Utilizzatore</th>
 <th >N. Colli</th>
 <th>Porto</th>
 <th >Corriere</th> 

 <th >Data Creazione</th>

 <th>Annotazioni</th> 
 <th >Codice pacco</th>
 <th >Company</th>
 <th >Responsabile</th>

 <th >ID</th> 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_pacchi}" var="pacco" varStatus="loop">
  <c:choose>
 <c:when test="${pacco.stato_lavorazione.id==1 && utl:getRapportoLavorati(pacco)==1 && pacco.chiuso!=1}">
 <tr style="background-color:#00ff80" id="rowIndex_${loop.index }" ondblclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
 </c:when>
 <c:when test="${pacco.ritardo == 1 && pacco.chiuso!=1}">
 <tr style="background-color:#FA8989" id="rowIndex_${loop.index }" ondblclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
 </c:when>
 <c:otherwise>
 <tr id="rowIndex_${loop.index }" ondblclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
 </c:otherwise>
 </c:choose> 



<td>
<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')"><i class="fa fa-search"></i></a>
<c:if test="${pacco.stato_lavorazione.id==1 && pacco.chiuso!=1}">
	<a class="btn customTooltip  btn-success"  title="Click per creare il pacco in uscita" onClick="modalPaccoUscita('${pacco.id}')"><i class="glyphicon glyphicon-log-out"></i></a>
	<%-- <a class="btn customTooltip  btn-success"  title="Click per creare il pacco in uscita" onClick="cambiaStatoPacco('${pacco.id}', 2)"><i class="glyphicon glyphicon-log-out"></i></a> --%>
	
</c:if>

<c:if test="${(pacco.ddt.numero_ddt=='' ||pacco.ddt.numero_ddt==null) && pacco.chiuso!=1 && pacco.stato_lavorazione.id!=2}">
	<button class="btn customTooltip  btn-info" title="Click per creare il DDT" onClick="creaDDT('${pacco.ddt.id}','${utl:escapeJS(pacco.nome_cliente) }','${utl:escapeJS(pacco.nome_sede)}', '${pacco.stato_lavorazione.id }', '${pacco.commessa }', '${pacco.ddt.id_destinatario }', '${pacco.ddt.id_sede_destinatario }')"><i class="glyphicon glyphicon-duplicate"></i></button>
</c:if>
<c:if test="${pacco.stato_lavorazione.id==2 && pacco.chiuso!=1}">
	<button class="btn customTooltip  btn-danger" title="Click se il pacco &egrave; stato spedito" onClick="cambiaStatoPacco('${pacco.id}', 3)"><i class="glyphicon glyphicon-send"></i></button>
	<button class="btn customTooltip  btn-warning" title="Click se il pacco si trova presso un fornitore" onClick="modalFornitore('${pacco.id}')"><i class="fa fa-mail-forward"></i></button>
	
	
</c:if>
<c:if test="${pacco.stato_lavorazione.id==4 && pacco.chiuso!=1}">
	<button class="btn customTooltip  btn-primary" title="Click se il pacco &egrave; rientrato da un fornitore" onClick="cambiaStatoPacco('${pacco.id}', 5)"><i class="fa fa-reply"></i></button>
	
</c:if>
<c:if test="${pacco.stato_lavorazione.id==3 && pacco.chiuso!=1}">
	<a class="btn customTooltip btn-info" style="background-color:#990099;border-color:#990099"  title="Click per chiudere i pacchi" onClick="chiudiPacchiOrigine('${pacco.origine}')"><i class="glyphicon glyphicon-remove"></i></a>
</c:if>
<c:if test="${(pacco.tipo_nota_pacco.id==null || pacco.tipo_nota_pacco.id=='') && pacco.chiuso!=1}">
<a class="btn customTooltip btn-info" style="background-color:#808080;border-color:#808080"  title="Click per aggiungere una nota" onClick="modalCambiaNota(${pacco.id})"><i class="glyphicon glyphicon-refresh"></i></a>
</c:if>
<c:if test="${pacco.ddt.link_pdf!=null && pacco.ddt.link_pdf!='' && pacco.ddt.numero_ddt!=null && pacco.ddt.numero_ddt!='' && pacco.chiuso!=1}">
<c:url var="url" value="gestioneDDT.do" >
<c:param name="action" value="download" />
 <c:param name="id_ddt" value="${utl:encryptData(pacco.ddt.id) }"></c:param>
  </c:url>
<%-- <a  target="_blank" class="btn customTooltip btn-danger" style="background-color:#A11F12;border-color:#A11F12;border-width:0.11em" title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o fa-sm"></i></a> --%>
<a  target="_blank" class="btn customTooltip btn-danger" style="background-color:#A11F12;border-color:#A11F12;border-width:0.11em" title="Click per scaricare il DDT"   href="${url}"><i class="fa fa-file-pdf-o fa-sm"></i></a>

</c:if>
 <c:if test="${pacco.hasAllegato==1}">

<a class="btn btn-primary customTooltip"  title="Click per scaricare gli allegati"  style="background-color:#cc6600;border-color:#cc6600;"  onClick="apriAllegati('${pacco.id}')"><i class="fa fa-arrow-down"></i></a>
</c:if> 
<c:if test="${pacco.chiuso==1 }">
<a href="#" class="btn customTooltip btn-info" style="background-color:#9FFF33;border-color:#9FFF33;"   title="Riapri origine" onclick="riapriOrigine('${pacco.origine}')"><i class="fa fa-unlock"></i></a>
</c:if>
</td>
<td>
<c:if test="${pacco.origine!='' && pacco.origine!=null}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.origine.split('_')[1])}')">${pacco.origine}</a>
</c:if>

</td>


<td>${pacco.nome_cliente}</td>
<td>${pacco.nome_sede }</td>

 <td>
<c:if test="${pacco.commessa!=null && pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${pacco.commessa}');">${pacco.commessa}</a>
</c:if>
</td> 

<td>
<c:choose>
<c:when test="${pacco.stato_lavorazione.id == 1}">
 <span class="label label-info">${pacco.stato_lavorazione.descrizione} </span></c:when>
 <c:when test="${pacco.stato_lavorazione.id == 2}">
 <span class="label label-success">${pacco.stato_lavorazione.descrizione}</span></c:when>
  <c:when test="${pacco.stato_lavorazione.id == 3}">
 <span class="label label-danger ">${pacco.stato_lavorazione.descrizione}</span></c:when>
   <c:when test="${pacco.stato_lavorazione.id == 4}">
 <span class="label label-warning" >${pacco.stato_lavorazione.descrizione}</span></c:when>
 <c:when test="${pacco.stato_lavorazione.id == 5}">
 <span class="label label-primary">${pacco.stato_lavorazione.descrizione}</span></c:when>
 </c:choose>
</td>
<td>${pacco.note_pacco }</td>
<td>
<span class="label btn" style="background-color:#808080" onClick="modalCambiaNota(${pacco.id})">${pacco.tipo_nota_pacco.descrizione }</span>
</td>
<td>${utl:getStringaLavorazionePacco(pacco)}</td>
<c:choose>
<c:when test="${pacco.ddt.numero_ddt!='' &&pacco.ddt.numero_ddt!=null}">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${utl:encryptData(pacco.ddt.id)}')">
${pacco.ddt.numero_ddt}
</a></td></c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>
<td>${pacco.fornitore }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.ddt.data_trasporto }" /></td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_spedizione}" /></td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_arrivo}" /></td>




<c:choose>
<c:when test="${pacco.chiuso==1}">
<td><span class="label label-danger" >CHIUSO</span></td>
</c:when>
<c:otherwise>
<td><span class="label label-success" >APERTO</span></td>
</c:otherwise>
</c:choose>


<td>${pacco.nome_cliente_util }</td>
<td>${pacco.nome_sede_util }</td>
<td>${pacco.ddt.colli }</td>
<td>${pacco.ddt.tipo_porto.descrizione }</td>
<td>${pacco.ddt.spedizioniere}</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_lavorazione}" /></td>


<td>${pacco.ddt.annotazioni}</td>
<td>${pacco.codice_pacco}</td>

<td>${pacco.company.denominazione}</td>
<td>${pacco.utente.nominativo}</td>
<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
${pacco.id}
</a>
</td> 
	</tr>
	

	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>



 <form name="NuovoPaccoForm" method="post" id="NuovoPaccoForm" action="gestionePacco.do?action=new" enctype="multipart/form-data">
         <div id="myModalCreaNuovoPacco" class="modal fade" data-backdrop="static" role="dialog" aria-labelledby="myLargeModalLabel">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Pacco</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
      
           <div class="form-group">
      <div class="row">
 <div class="col-md-6"> 
                  <label>Tipologia</label>
                  
                  <select name="tipologia" id="tipologia" data-placeholder="Seleziona Tipologia" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                  <option value="1">Cliente</option>
             		<option value="2">Fornitore</option>
                  </select>
        </div>
</div>
<div class="row">
 
  <div class="col-md-6" style="display:none"> 
                  <label>Cliente</label>
                  
	                  <select name="cliente_appoggio" id="cliente_appoggio"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%" >

	                    <option value=""></option>
	                      <c:forEach items="${lista_clienti}" var="cliente">
	                           <option value="${cliente.__id}">${cliente.nome}</option> 
	                     </c:forEach>
	         
	                  </select>
                 
        </div>
        
          <div class="col-md-6"> 
                  <label>Cliente</label>

                  <input  name="select1" id="select1"  class="form-control" style="width:100%" required>
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

 <!-- <div class="row"> -->
 

<div class="col-md-6">
 <div class="form-group">
                  <label>Sede</label>
                 
                <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="true">
          			<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">             			
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
                   <input  name="cliente_utilizzatore" id="cliente_utilizzatore"  data-placeholder="Seleziona Utilizzatore..." class="form-control" style="width:100%" required>
        </div>
       
        
<!--  <div class="row">    --> 
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

</div>
<!-- </div> -->
 <div class="form-group">
 
                  <label>Commessa</label>
     <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-4">             
                  <select name="commessa" id="commessa" data-placeholder="Seleziona Commessa..."  class="form-control select2 pull-left" style="width:100%"  aria-hidden="true" data-live-search="true">
                   <option value=""></option>   
             			<c:forEach items="${lista_commesse}" var="commessa">
                          	 <option value="${commessa.ID_COMMESSA}*${commessa.ID_ANAGEN}">${commessa.ID_COMMESSA}</option>   
                     	</c:forEach>
                  </select> 
  </div>
   <div class= "col-xs-4">
                
                  <input type="text" id="commessa_text" name="commessa_text" class="form-control pull-right" style="margin-down:35px;">
   </div>
   <div class="col-xs-4">
<a class="btn btn-primary"  id="import_button" onClick="importaDaCommessa($('#commessa_text').val())">Importa Da Commessa</a>
</div>
   
 </div>
</div>

 <div class="form-group">
 
                  <label>Note Commessa</label>
   <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-12">             
		<textarea id="note_commessa" name="note_commessa" rows="6" style="width:100%" disabled></textarea>
  </div>
   
 </div> 
</div>


<div class="form-group">
 <br>  <div class="row" >                 
<div class= "col-xs-6">

            <b>Codice Pacco</b><br>
             <a class="pull-center" ><input type="text" class="pull-left form-control" id=codice_pacco name="codice_pacco" style="margin-top:6px;" value="PC_${(pacco.id)+1}" readonly ></a> 
        </div>
        <div class= "col-xs-6">
	 
         <label class="pull-center">Stato Lavorazione</label> <select name="stato_lavorazione" id="stato_lavorazione" data-placeholder="Seleziona Stato Lavorazione..." class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="false">
                   		
                   		<c:forEach items="${lista_stato_lavorazione}" var="stato">
                          	 <option value="${stato.id}">${stato.descrizione}</option>    
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
               <input type='text' class="form-control input-small" id="data_arrivo" name="data_arrivo" >
                <span class="input-group-addon" id="data_arrivo_icon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
 
   
 </div> 

 <div class= "col-xs-6"> 

                  <label>Data Spedizione</label>
            <div class='input-group date datepicker' id='datepicker_data_spedizione' >
               <input type='text' class="form-control input-small" id="data_spedizione" name="data_spedizione" disabled/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </div> 
  </div>
   
 </div> 
</div> 

	
	<div class="form-group" >
<div id="DDT"> 
 <div id="collapsed_box" class="box box-danger box-solid collapsed-box" >
<div class="box-header with-border" >
	 DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

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
<label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" id="numero_ddt" name="numero_ddt" ></a>
</div>
<div class="col-md-4">
<label>Data DDT</label>    
     
            <span class='date datepicker' id='datepicker_ddt'>
           		<span class="input-group">
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt" />
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </span>
        </span> 

</div>
<div class="col-md-4">
<label>N. Colli</label> <a class="pull-center"><input type="number" class="form-control" id="colli" name="colli"  min=0  > </a>
</div>

</div>
<div class="row">
<div class="col-md-12">

 <div  class="box box-danger box-solid" > 


 <div class="box-body"> 
 <div class="row" id="row_destinazione" style="display:none">
<div class="col-md-4">

<label>Destinazione</label> 
                  <a class="pull-center">
                                   
                 <%--  <select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select> --%>
					<input id="destinazione" name="destinazione" class="form-control" style="width:100%">
                  </a> 
</div>

<div class="col-md-4">

<label>Sede Destinazione</label> 
                  <a class="pull-center">

                  
                  <select class="form-control select2" data-placeholder="Seleziona Sede Destinazione..." id="sede_destinazione" name="sede_destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>

                  </a> 
</div>
</div>
 
 
<div class="row" id="row_destinatario">
<div class="col-md-4">
<label id="mitt_dest">Mittente</label> 
                  <a class="pull-center">
                 
                  <%-- <select class="form-control select2"  id="destinatario" name="destinatario" style="width:100%"  aria-hidden="true" data-live-search="true">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select> --%>
                  <input id="destinatario" name="destinatario" class="form-control" style="width:100%">
                  </a>

</div>
<div class="col-md-4">

<label id="sede_mitt_dest">Sede Mittente</label> 
                  <a class="pull-center">
                                    
                  <select class="form-control select2" id="sede_destinatario" name="sede_destinatario" style="width:100%"  aria-hidden="true" data-live-search="true">
                  <option value=""></option>
                  <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">
               	  <%-- <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option> --%>  
               	  <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option> 
                  </c:forEach>
                  </select>
               
                  </a> 

</div>
<!--
<div class="col-md-2">
 <a class="btn btn-primary" style="margin-top:25px" id="import_button" onClick="importaDaCommessa($('#commessa_text').val())">Importa Da Commessa</a> 

</div>-->

</div>

 </div> 
 </div>  

</div>
</div>
<div class="row">
<div class= "col-md-4">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT" class="form-control "  aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>			
		</c:forEach>
	</select>
</div>
<div class= "col-md-4">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">	
			<option value="${aspetto.id}">${aspetto.descrizione}</option>			
		</c:forEach>
	</select>

	


</div>

<div class= "col-md-4">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto"  class="form-control select2-drop " aria-hidden="true" data-live-search="true">
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
		</c:forEach>
	</select>
</div>
</div>

<div class="row">
<div class="col-md-4">
<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto" class="form-control select2-drop "  aria-hidden="true" data-live-search="true">	
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
		</c:forEach>
	</select>

</div>
<div class="col-md-4">
<label>Causale</label> 
<select name="causale" id="causale" data-placeholder="Seleziona Causale..." class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%">	
		<option value=""></option>
		<c:forEach items="${lista_causali}" var="causale">
			<option value="${causale.id}">${causale.descrizione}</option>			
		</c:forEach>
	</select>
</div>
<div class="col-md-4">
<label>Data Trasporto</label>    

 <span class="date datepicker"  id="datepicker_trasporto" > 
        <span class="input-group">
                     <input type="text" class="form-control date input-small" id="data_ora_trasporto"  name="data_ora_trasporto"/>
            
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
 <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" id="annotazioni" name="annotazioni"> </a>
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
<a class="pull-center"><input type="text" class="form-control" id="spedizioniere" name="spedizioniere"> </a>

 <div class="row">
<div class="col-md-12" >
<label>Peso (Kg)</label>
	<input type="text" id="peso" name="peso" class="form-control" >
</div>

</div> 
</div>
<div class="col-md-4">
 <div class="row">
<div class="col-md-12" >
<label>Account Spedizioniere</label>
<input type="text" id="account" name="account" class="form-control" /> 

</div>

</div> 
<label>Cortese Attenzione</label>
	<input type="text" id="cortese_attenzione" name="cortese_attenzione" class="form-control" >

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
 <input id="fileupload_pdf" type="file" name="file" class="form-control"/>
</div>
</div><br>
<div class= "row">
 <div class="col-md-12">
 <a class="pull-center">
				<textarea name="note" form="ModificaPaccoForm" id="note" class="form-control" rows=3 style="width:100%"></textarea></a> 
 
 </div>

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
		<c:forEach items="${lista_tipo_item}" var="tipo_item">
			<c:if test="${tipo_item.id==1 }">
			<option value="${tipo_item.id}" selected>${tipo_item.descrizione}</option>
			</c:if>
			<c:if test="${tipo_item.id!=1 }">
			<option value="${tipo_item.id}">${tipo_item.descrizione}</option>
			</c:if>
			
		</c:forEach>
		
	</select>

	</li>
		
	</ul>

</div>

<div class= "col-md-6">

<a  class="btn btn-primary pull-left" style="margin-top:35px" onClick="inserisciItem()"><i class="fa fa-plus"></i></a>


</div>
</div>
</div>
</div>



 <div class="form-group" id="item_gen">
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
 <td><label>Action</label></td>

 </tr></thead>
 
 <tbody>

</tbody>
 </table>
 </div>
 
 </div>
 
 
 
 
 <div class="form-group" id="item_rilievi" style="display:none">
 <label>Item Nel Pacco</label>
 <div class="table-responsive">
<table id="tabItemRil" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

  <th>Disegno</th>
 <th>Variante</th>
 <th>Pezzi in ingresso</th>
<th>Note</th>	
 <td><label>Action</label></td>

 </tr></thead>
 
 <tbody>

</tbody>
 </table>
 </div>
 
 </div>
 
 
 
 
 
 
 <div class="col-12">
  <label>Note</label></div>
 <textarea id="note_pacco" name="note_pacco" rows="5" style="width:100%"></textarea>
 

</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="json" name="json">
		<input type="hidden" class="pull-right" id="json_rilievi" name="json_rilievi">
		<input type="hidden" class="pull-right" id="configurazione" name="configurazione">
		<button class="btn btn-default pull-left" onClick="chooseSubmit()" id="button_submit"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>
		<%-- <c:choose>
		<c:when test="$('#tipo_ddt').val()==1">
		<button class="btn btn-default pull-left" onClick="inserisciPacco(0)" id><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>
		</c:when>
		<c:otherwise>
		<button class="btn btn-default pull-left" onClick="modalConfigurazione()"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>
		</c:otherwise>
		</c:choose> --%>
         
       
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

<div id="myModalFornitore" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelFornitore">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Fornitore </h4>
      </div>
       <div class="modal-body">
          <div class="row">
   			<div class="col-sm-6">
        <div class="form-group">
        <label>Destinatario/Destinazione</label>
 	                  <select name="select_fornitore" id="select_fornitore" data-placeholder="Seleziona Fornitore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
	                  <option value=""></option>
	                      <c:forEach items="${lista_fornitori}" var="fornitore">
	                           <option value="${fornitore.__id}_${fornitore.nome}">${fornitore.nome}</option> 
	                     </c:forEach>	               
	                    
	                  </select>

 </div>
 </div>
  <div class="col-sm-6">
         <div class="form-group">
         <label>Sede Destinatario/Sede Destinazione</label>
 	                  <select name="select_sede_fornitore" id="select_sede_fornitore" data-placeholder="Seleziona Sede Fornitore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
	                  <option value=""></option>
	                     <c:forEach items="${lista_sedi}" var="sedi" varStatus="loop">               	 
               	 		 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>               
	                    </c:forEach>
	                  </select>
 
 
 </div>
       </div>
       </div>
   <div class="row">
   <div class="col-sm-12">
   <div id="modFornitore"></div>
 
   </div>
   </div>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="pressoFornitore()">Salva</button> -->
	<button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="inviaItemFornitore()">Salva</button>
       <!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="cambiaStatoPacco(null, 4, $('#select_fornitore').val())">Salva</button> -->
      </div>
    </div>
  </div>
</div>


<div id="myModalUscitaPacco" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelFornitore">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Item </h4>
      </div>
       <div class="modal-body">
       <div id="modUscita"></div>
       
  
   </div>
  		
      <div class="modal-footer">
      <label class="pull-left" style="display:none" id="label_spediti">In giallo gli Item gi&agrave; spediti!</label>
		<!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="pressoFornitore()">Salva</button> -->
	<button class="btn btn-primary"  onClick="inviaItemUscita()">Salva</button>
       <!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="cambiaStatoPacco(null, 4, $('#select_fornitore').val())">Salva</button> -->
      </div>
    </div>
  </div>
</div>


<div id="modalPezziInUscita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelFornitore">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Numero Pezzi Da Inviare </h4>
      </div>
       <div class="modal-body">
       <div id="body_pezzi_uscita"></div>
       
  
   </div>
  		
      <div class="modal-footer">
     
		
	<button class="btn btn-primary"  onClick="inviaItemUscitaRilievi()">Salva</button>
       
      </div>
    </div>
  </div>
</div>





<div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati Pacco</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         <div id="tab_archivio"></div>
       </div>
     

  		 </div>
  		 </div>
<!--       <div class="modal-footer">
      </div> -->
   
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


<div id="myModalCambiaStato" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelFornitore">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Stato </h4>
      </div>
       <div class="modal-body">
       
        <div class="form-group">
 	                  <select name="select_stato_pacco" id="select_stato_pacco" data-placeholder="Seleziona Stato..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                  		<option value=""></option>
	                      <c:forEach items="${lista_stato_lavorazione}" var="stato">
	                       	<option value="${stato.id }">${stato.descrizione}</option>
	                     </c:forEach>

	                  </select>
 
 </div>
         <div class="form-group" id="form_select_fornitore" style="display:none">
 	                  <select name="select_fornitore2" id="select_fornitore2" data-placeholder="Seleziona Fornitore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
	                 
	                  <c:if test="${userObj.idCliente != 0}">
	                  
	                      <c:forEach items="${lista_fornitori}" var="fornitore">
	                       <c:if test="${userObj.idCliente == fornitore.__id}">
	                           <option value="${fornitore.nome}">${fornitore.nome}</option> 
	                        </c:if>
	                     </c:forEach>
	                  
	                  </c:if>
	                 
	                  <c:if test="${userObj.idCliente == 0}">
	                  <option value=""></option>
	                      <c:forEach items="${lista_fornitori}" var="fornitore">
	                           <option value="${fornitore.nome}">${fornitore.nome}</option> 
	                     </c:forEach>
	                  
	                  </c:if>
	                    
	                  </select>
 
 </div>

   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "cambiaStato" name="cambiaStato" onClick="cambiaStato()">Salva</button>

       
      </div>
    </div>
  </div>
</div>


<div id="myModalCambiaNota" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelFornitore">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Tipo Nota</h4>
      </div>
       <div class="modal-body">
       
        <div class="form-group">
 	                  <select name="select_nota_pacco" id="select_nota_pacco" data-placeholder="Seleziona Nota..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                  		<option value=""></option>
                  		<option value="0">Nessuna</option>
	                      <c:forEach items="${lista_tipo_note_pacco}" var="nota">
	                       	<option value="${nota.id }">${nota.descrizione}</option>
	                     </c:forEach>
	                  </select> 
	 </div>

  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "cambiaNota" name="cambiaNota" onClick="cambiaNota()">Salva</button>

       
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
		<button class="btn btn-primary"  id = "yes_button" onClick="salvaConfigurazione(1, false)">SI</button>
		<button class="btn btn-primary"  id = "no_button"  onClick="salvaConfigurazione(0, false)">NO</button>
       
      </div>
    </div>
  </div>
</div>




<form id="DDTForm" action="gestioneDDT.do?action=salva" method="POST" enctype="multipart/form-data">
  <div id="myModalDDT" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci DDT</h4>
      </div>
       <div class="modal-body" id="ddt_body">
       
       
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" id="ddt_footer">


       
      </div>
    </div>
  </div>
</div>
 </form>
 
</div>
 </div> 


</section>

  </div>
  
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script type="text/javascript">


var items_rilievo = [];

function insertRilievo(){
	
	
	
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
			
			rilievo.disegno = $('#disegno').val();
			rilievo.variante = $('#variante').val();
			rilievo.pezzi_ingresso = $('#pezzi_ingresso').val();
			rilievo.note_rilievo = $('#note_rilievo').val();
			rilievo.action = '<button class="btn btn-danger" onClick="eliminaRilievoTable(\''+ $('#disegno').val()+'\')"><i class="fa fa-trash"></i></button>';
			
			items_rilievo.push(rilievo)
			
			   var table_ril = $('#tabItemRil').DataTable();
				  
			table_ril.clear().draw();
			   
			table_ril.rows.add(items_rilievo).draw();
			    
			table_ril.columns().eq( 0 ).each( function ( colIdx ) {
			  	  $( 'input', table_ril.column( colIdx ).header() ).on( 'keyup', function () {
			  	      table
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

var previous = $('#tipo_item').val(); 


$('#tipo_item').change(function(event, clickedIndex, newValue, oldValue){
	
	$('#listaRilievi').hide();
	$('#btn_save_rilievo').hide();

	
	   var table_ril = $('#tabItemRil').DataTable();
	   
	   var table_item = $('#tabItem').DataTable();
	
		   
		var row_ril = table_ril.rows().data();
		var row_item = table_item.rows().data();
	
	
	if($(this).val()==4){
		
		if(row_item.length>0){			
	
    				
    				  $('#modalContent').html("Attenzione! Non &egrave; possibile aggiungere un rilievo al pacco contenente altri item!<br>Vuoi eliminare gli item e inserire rilievi?");    				 
    	        
          			 $("#myModalRilItem").modal();
          			 $('#ril_item').val(previous);
			
		}else{
			$('#item_gen').hide();
			$('#item_rilievi').show();	
		}		
		
		
	}else{
		
		if(row_ril.length>0){
	
				  $('#modalContent').html("Attenzione! Non &egrave; possibile aggiungere un item al pacco contenente rilievi dimensionali!<br>Vuoi eliminare i rilievi e inserire altri item?");
				 
      			 $("#myModalRilItem").modal();
      			$('#ril_item').val(previous);
		}else{
			$('#item_gen').show();
			$('#item_rilievi').hide();
		}
		
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
		$('#item_gen').hide();
		$('#item_rilievi').show();	
		
		
	}else{
		  var tab = $('#tabItemRil').DataTable();
		  items_rilievo = [];
		  tab.clear().draw();
		$('#item_gen').show();
		$('#item_rilievi').hide();
	}
	
}


function eliminaRilievoTable(disegno){
	
	new_items_rilievo=[];
	
	items_rilievo.forEach( function (item){
			if(item.disegno == disegno){
				
			}else{
				new_items_rilievo.push(item);
			}
			
		});
		

	items_rilievo = new_items_rilievo;
	
	   var table_ril = $('#tabItemRil').DataTable();
		  
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


/* const editableCell = function(cell) {
	
	
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
	   	      const row = table_item_ril.row(e.target.parentElement)
	   	      table_item_ril.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
	   	      var x = tableModRil.rows().data();
	   	      
	   	   items_rilievo[row.index()].pezzi_ingresso = e.target.textContent;
	   	      	//salvaModificaQuestionario();
	   	      console.log('Row changed: ', row.data())
	   	    }
	   	  })
	   	  
	  
	
} */


function pacchiEsterno(){
	
	dataString = "?action=pacchi_esterno";

pleaseWaitDiv = $('#pleaseWaitDialog');
pleaseWaitDiv.modal();

callAction("listaPacchi.do"+ dataString, false,true);
}


function pacchiInMagazzino(){
	
	dataString = "?action=pacchi_magazzino";

pleaseWaitDiv = $('#pleaseWaitDialog');
pleaseWaitDiv.modal();

callAction("listaPacchi.do"+ dataString, false,true);
}

var nuovo=true;

$('#commessa').on('change', function(){
	
	if($("#commessa").val()!=null && $("#commessa").val()!=''){
		$("#commessa_text").val($("#commessa").val().split("*")[0]);	
		id_commessa = $('#commessa').val().split("*")[0];
		showNoteCommessa(id_commessa);
	}
});


	
$("#filtro_commessa").on('change', function(){
	

	var comm = $('#filtro_commessa').val();
	
	$('#inputsearchtable_4').val(comm);
	
	table
    .columns( 4 )
    .search( comm )
    .draw();
});
	



function filtraPacchiPerData(){
	
	var tipo_data = $('#tipo_data').val();
	var comm = $('#filtra_commesse').val();
	if(tipo_data==""){
		$('#myModalErrorContent').html("Attenzione! Nessun Tipo Di Data Selezioneato!");
		$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");
		$('#myModalError').modal('show');
	}else{
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "?action=filtraDate&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_data="+tipo_data + "&commessa="+ comm;
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	callAction("listaPacchi.do"+ dataString, false,true);
	 	
		
	}
}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("listaPacchi.do");

}

function resetCommesse(){
	
	$('#inputsearchtable_4').val("");
	
	table
    .columns( 4 )
    .search( "" )
    .draw();
	
	$("#filtro_commessa").append('<option value=""></option>');
	$('#filtro_commessa option[value=""]').attr('selected', true);

}
	var flag = 0;
function creaDDT(id_ddt, stato_pacco, commessa, id_destinatario, id_sede_destinatario){
flag=1;

	$('#collapsed_box').removeClass("collapsed-box");
	$("#numero_ddt").attr("required", "true");

	$('#commessa_text').val(commessa);
	$('#mitt_dest').html("Mittente");	
	
	$('#destinatario').select2("destroy");
	//$('#destinatario').remove();
	$('#sede_destinatario').select2("destroy");
	//$('#sede_destinatario').remove();
	$('#destinazione').select2("destroy");
	//$('#destinazione').remove();
	$('#sede_destinazione').select2("destroy");
	//$('#sede_destinazione').remove();
	$('#tipo_note_ddt').select2("destroy");
	//$('#tipo_note_ddt').remove();
	$('#causale').select2("destroy");
	//$('#causale').remove();
	$('#DDT').clone().appendTo($('#ddt_body'));
	
 	$('#ddt_body').find('#datepicker_ddt').each(function(){
		this.id = 'date_ddt';
	});	
 	
 	$('#ddt_body').find('#data_ddt').each(function(){
		this.id = 'data_ddt_ddt';
	});	
 	
  	$('#ddt_body').find('#destinatario').each(function(){
		this.id = 'destinatario_ddt';
		this.name = 'destinatario_ddt';
	});	 
	$('#ddt_body').find('#sede_destinatario').each(function(){
		this.id = 'sede_destinatario_ddt';
		this.name = 'sede_destinatario_ddt';
	});	 

	$('#ddt_body').find('#destinazione').each(function(){
		this.id = 'destinazione_ddt';
		this.name = 'destinazione_ddt';
	});	 
	$('#ddt_body').find('#sede_destinazione').each(function(){
		this.id = 'sede_destinazione_ddt';
		this.name = 'sede_destinazione_ddt';
	});	

	$('#ddt_body').find('#colli').each(function(){
		this.id = 'colli_ddt';
	});	
	$('#ddt_body').find('#tipo_trasporto').each(function(){
		this.id = 'tipo_trasporto_ddt';
	});
	$('#ddt_body').find('#numero_ddt').each(function(){
		this.id = 'numero_ddt_ddt';
	});
	$('#ddt_body').find('#operatore_section').each(function(){
		this.id = 'operatore_section_ddt';
	});
	$('#ddt_body').find('#datepicker_arrivo').each(function(){
		this.id = 'date_arrivo';
	});	
	$('#ddt_body').find('#datetimepicker').each(function(){
		this.id = 'date_time_transport';
	});	
	$('#ddt_body').find('#tipo_ddt').each(function(){
		this.id = 'tipo_ddt_ddt';
	});	
	$('#ddt_body').find('#fileupload').each(function(){
		this.id = 'fileupload_create_ddt';
	});	

	$('#ddt_body').find('#addNotaButton').each(function(){
		this.id = 'addNotaButton_ddt';
	}); 
	$('#ddt_body').find('#note').each(function(){
		this.id = 'note_ddt';
		this.name = 'note_ddt';
	}); 
	$('#ddt_body').find('#tipo_note_ddt').each(function(){
		this.id = 'tipo_nota_ddt';
	});
	$('#ddt_body').find('#causale').each(function(){
		this.id = 'causale_ddt';
	});
	
	$('#ddt_body').find('#spedizioniere').each(function(){
		this.id = 'spedizioniere_ddt';
	});
	$('#ddt_body').find('#account').each(function(){
		this.id = 'account_ddt';
	});
	$('#ddt_body').find('#cortese_attenzione').each(function(){
		this.id = 'cortese_attenzione_ddt';
	});
	$('#ddt_body').find('#tipo_porto').each(function(){
		this.id = 'tipo_porto_ddt';
	});
	$('#ddt_body').find('#row_destinatario').each(function(){
		this.id = 'row_destinatario_ddt';
	});
	$('#ddt_body').find('#aspetto').each(function(){
		this.id = 'aspetto_ddt';
	});
	
	$('#row_destinatario_ddt').append('<div class="col-md-2"><a class="btn btn-primary" style="margin-top:25px" onClick="importaDaCommessa(\''+commessa+'\')">Importa Da Commessa</a></div>');
	$('#ddt_body').append('<input type="hidden" class="pull-right" id="configurazione_ddt" name="configurazione_ddt">')	
	
	$('#note_ddt').attr('form', 'DDTForm');
	
	$('#colli_ddt').val(0);
	$('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
		
	$('#tipo_note_ddt').select2();
	$('#causale').select2();
	/* $('#destinatario').select2({
		placeholder:"Seleziona Mittente..."
	}); */
	initSelect2('#destinatario', "Seleziona Mittente...");
	
	$('#sede_destinatario').select2({
		placeholder:"Seleziona Sede Mittente..."
	});
	initSelect2('#destinazione');
	$('#sede_destinazione').select2();
/* 	$('#select1').select2({
		placeholder:"Seleziona Cliente..."
	}); */
	
	/* $('#destinatario_ddt').select2({
		placeholder:"Seleziona Mittente..."
	}); */
	initSelect2('#destinatario_ddt', "Seleziona Mittente...");
	$('#sede_destinatario_ddt').select2({
		placeholder:"Seleziona Sede Mittente..."
	});
	$('#causale_ddt').select2();
	
	$('#addNotaButton_ddt').on('click', function(){

	var nota = $('#tipo_nota_ddt').val();
		
		$('#note_ddt').append(nota);
	});

	$('#tipo_nota_ddt').select2();
	$('#tipo_trasporto_ddt').change(function(){
		
		 var sel =  $('#tipo_trasporto_ddt').val();
		 if(sel==2){
			 $('#operatore_section_ddt').show();
		 }else{
			 $('#operatore_trasporto').val("");
			 $('#operatore_section_ddt').hide();
		 }
		 
		
	});
	
	$('#destinatario_ddt').change(function(){         
   	  if ($(this).data('options') == undefined) 
   	  {
   	   
   	    $(this).data('options', $('#sede_destinatario_ddt option').clone());
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
   	 $("#sede_destinatario_ddt").prop("disabled", false);   	 
   	  $('#sede_destinatario_ddt').html(opt);   	  
   	  $("#sede_destinatario_ddt").trigger("chosen:updated");   	  
   		//$("#sede_destinatario_ddt").change();  
   	});
  
  $("#destinazione_ddt").change(function() {    
	   
	   
  	  if ($(this).data('options') == undefined) 
  	  {
  	    
  	    $(this).data('options', $('#sede_destinazione_ddt option').clone());
  	  }
  	var id2 = $(this).val();
  	var id = null;
  	if($(this).val()!=""){
  		id = $(this).val().split("_");
  	}else{
  		id=$(this).val();
  	}
  	
  	  var options = $(this).data('options');
  	  //var id_sede = ${pacco.id_sede };      	  
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
  	 $("#sede_destinazione_ddt").prop("disabled", false);   	 
  	  $('#sede_destinazione_ddt').html(opt);   	  
  	  $("#sede_destinazione_ddt").trigger("chosen:updated");   	  
  		$("#sede_destinazione_ddt").change();  
  	});  

  
   $("#sede_destinatario_ddt").change(function() {    
	  if($('#tipo_ddt_ddt').val()!=1){
	  var id_cliente = $('#destinatario_ddt').val().split("_")[0];
	  var id_sede = $('#sede_destinatario_ddt').val().split("_")[0];
	  var lista_save_stato = '${lista_save_stato_json}';
	  var found = 0
	  var save_stato_json = JSON.parse(lista_save_stato);
	  save_stato_json.forEach(function(item){
	  	
		  if(id_cliente==item.id_cliente && id_sede ==item.id_sede){
			  $('#spedizioniere_ddt').val(item.spedizioniere);
			  $('#account_ddt').val(item.account);
			  $('#cortese_attenzione_ddt').val(item.ca);
			  $('#tipo_porto_ddt').val(item.tipo_porto);
			  $('#aspetto_ddt').val(item.aspetto);				
			  found = 1
		  }	  
	  });
	  
	  if(found==0){
		  $('#spedizioniere_ddt').val("");
		  $('#cortese_attenzione_ddt').val("");
		  $('#account_ddt').val("");
		  $('#tipo_porto_ddt').val(1);
		  $('#aspetto_ddt').val(1);		
	  }
	  }else{
		  $('#spedizioniere_ddt').val("");
		  $('#account_ddt').val("");
		  $('#cortese_attenzione_ddt').val("");
		  $('#tipo_porto_ddt').val(1);
		  $('#aspetto_ddt').val(1);		
	  }
	  
  }); 

   $('#tipo_ddt_ddt').change(function(){
	   $("#sede_destinatario_ddt").change();
   });

	$("#fileupload_create_ddt").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabel').html("Attenzione!");
        	$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }
		
	});
	
	$('#ddt_body').append("<input type='hidden' id='id_ddt' name='id_ddt' value="+id_ddt+">");	
	$('#ddt_footer').html("<p align='center'><a class='btn btn-default' onClick='modalConfigurazione(true)'>Salva</a></p>");	
	$('#myModalDDT').modal();
	
	if(stato_pacco==5){
		
		$('#destinatario_ddt').val(id_destinatario);
		$('#destinatario_ddt').change();
		//$('#destinatario_ddt').change();
		initSelect2('#destinatario_ddt', "Seleziona Mittente...");
		if(id_sede_destinatario==0){
			//$('#sede_destinatario_ddt').prepend("<option value=0>Non Assegnate</option>");
			$('#sede_destinatario_ddt').val(id_sede_destinatario);
		}else{
			$('#sede_destinatario_ddt').val(id_sede_destinatario+"_"+id_destinatario);
		}
		
		$('#sede_destinatario_ddt').change();
	}	
	
	
}


$("#myModalDDT").on("hidden.bs.modal", function () {
	$('#via').val("");
	$('#destinatario').val("");
	$("#numero_ddt").attr("required", "false");
    $('#ddt_body').empty();
    $('#collapsed_box').addClass("collapsed-box");

});

var modale_ddt = false;

$("#myModalDDT").on("shown.bs.modal", function () {
modale_ddt = true;


});

function DDTFormSumbit(conf){
	var esito = true;
	$('#data_ddt_ddt').css('border', '1px solid #d2d6de');
	
	if($('#numero_ddt_ddt').val()==""){
		esito = false;
		$('#report_button').hide();
		$('#visualizza_report').hide();
        $('#myModalErrorContent').html("Attenzione! Inserisci un numero per il DDT!");
        $('#myModalError').removeClass();
      	$('#myModalError').addClass("modal modal-danger");      		  
      	$('#myModalError').modal('show');      		  
	}
	
	else if($('#data_ddt_ddt').val()!='' && !isDate($('#data_ddt_ddt').val())){
		esito = false;
		$('#data_ddt_ddt').css('border', '1px solid #f00');
		$('#myModalError').removeClass();
		$("#myModalErrorContent").html("Attenzione! Formato data errato!");
		$('#myModalError').addClass("modal modal-danger");   
		$('#myModalError').modal('show');
	}
	
	if(esito){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		$('#configurazione_ddt').val(conf);
		$("#DDTForm").submit();
	}
	

	
}

function importaDaCommessa(comm){
	
	importaInfoDaCommessa(comm,flag);
	flag=0;
}
function paccoInUscita(id_pacco){
	
	var codice = "PC_"+${(pacco.id)+1};

	dataString = "?action=cambia_stato_pacco&id_pacco="+id_pacco+"&codice="+codice+"&stato=2";
	callAction("gestionePacco.do"+dataString, false, true);
	
}


function dettaglioPaccoFromOrigine(origine){
	
	var id = origine.split("_")
	dettaglioPacco(id[1]);
	
}







$('#tipo_trasporto').change(function(){
	
	 var sel =  $('#tipo_trasporto').val();
	 if(sel==2){
		 $('#operatore_section').show();
	 }else{
		 $('#operatore_trasporto').val("");
		 $('#operatore_section').hide();
	 }
	 
});

function chooseSubmit(ddt_form){
	if($('#tipo_ddt').val()==1){
		inserisciPacco(0);
	}else{
		modalConfigurazione(ddt_form);
	}
}

function modalConfigurazione(ddt_form){
	if(ddt_form){
		if($('#numero_ddt_ddt').val()!=null && $('#numero_ddt_ddt').val()!="" && $('#tipo_ddt_ddt').val()!=1){
			//var esito = validateForm();
			//if(esito){
				$('#myModalSaveStato').css('z-index', '1080');
				$('#myModalSaveStato').modal();
			//}
		}else{
			DDTFormSumbit();
		}
	}else{
		if($('#numero_ddt').val()!=null && $('#numero_ddt').val()!=""){
			var esito = validateForm();
			if(esito){
				$('#myModalSaveStato').modal();
			}
		}else{
			inserisciPacco(0);
		}
	}
	
}

function inserisciItem(){
		
	
	$('#listaItemTop').html('');
	$('#codice_pacco').removeAttr('required');
	//var id_cliente = document.getElementById("select1").value;
	//var id_sede = document.getElementById("select2").value;
	var id_cliente = $('#cliente_utilizzatore').val();
	var id_sede = $('#sede_utilizzatore').val()
	var tipo_item = document.getElementById("tipo_item").value;
	
	if(id_cliente==""){
		
	}else{
	
	inserisciItemModal(tipo_item,id_cliente,id_sede);
	}
	};

	
	function inserisciPacco(configurazione){
		
		
		items_json.forEach(function(item){
			if($('#note_item_'+item.id_proprio).val()!=null){
				item.note=$('#note_item_'+item.id_proprio).val();
			}else{
				item.note="";
			}			
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
		var json_ril = JSON.stringify(items_rilievo);
		$('#configurazione').val(configurazione);
		$('#json').val(json_data);
		$('#json_rilievi').val(json_ril);
		$('#codice_pacco').attr('required', 'true');
		var esito = validateForm();

		if(esito==true){
			 pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();
			  $('#data_arrivo').attr('required', false);
				$('#data_spedizione').attr('required', false);
		document.getElementById("NuovoPaccoForm").submit();
		
		}
		else{};
	}
	
	

	
	function validateForm() {
	   // var codice_pacco = document.forms["NuovoPaccoForm"]["codice_pacco"].value;
	    var numero_ddt = document.forms["NuovoPaccoForm"]["numero_ddt"].value;
	    var cliente = document.forms["NuovoPaccoForm"]["select1"].value;
	    var data_arrivo = $('#data_arrivo').val();
	    var data_spedizione = $('#data_spedizione').val();
	    var data_ddt = $('#data_ddt').val();
	    $('#data_arrivo').css('border', '1px solid #d2d6de');
	    $('#data_spedizione').css('border', '1px solid #d2d6de');
	    $('#data_ddt').css('border', '1px solid #d2d6de');
	    
	    if(!$('#data_arrivo').prop('disabled')){
	    	if(data_arrivo!=''){	    	
	    		if(!isDate(data_arrivo)){
	    			$('#data_arrivo').css('border', '1px solid #f00');
	    			$('#myModalError').removeClass();
       				$("#myModalErrorContent").html("Attenzione! Formato data errato!");
       				$('#myModalError').addClass("modal modal-danger");  
					$('#myModalError').modal('show');
					return false;
				}
	    	}else{
	    		$('#data_arrivo').attr('required', true);
				return false;
	    	}
	    }	    
	    
	    if(!$('#data_spedizione').prop('disabled')){
	    	if(data_spedizione!=''){
	    		if(!isDate(data_spedizione)){
	    			$('#data_spedizione').css('border', '1px solid #f00');
	    			$('#myModalError').removeClass();
       				$("#myModalErrorContent").html("Attenzione! Formato data errato!");
       				$('#myModalError').addClass("modal modal-danger");  
					$('#myModalError').modal('show');
					return false;
				}
	    	}else{
	    		$('#data_spedizione').attr('required', true);
	    		$('#myModalError').removeClass();
  				$("#myModalErrorContent").html("Attenzione! Formato data errato!");
  				$('#myModalError').addClass("modal modal-danger");       				
				$('#myModalError').modal('show');
				return false;
	    	}
	    }
	    	   
	    if(data_ddt!=''){
	    	if(!isDate(data_ddt)){
	    		$('#data_ddt').css('border', '1px solid #f00');
	    		$('#myModalError').removeClass();
  				$("#myModalErrorContent").html("Attenzione! Formato data errato!");
  				$('#myModalError').addClass("modal modal-danger");       				
				$('#myModalError').modal('show');
				return false;
			}
	    }
	    
		if (cliente =="") {
			return false;
	    }
		 return true;
	}
	
	var pacco_selected;

	function modalFornitore(id_pacco){
		
		
		dataString ="id_pacco="+ id_pacco
        exploreModal("gestionePacco.do?action=item_uscita",dataString,"#modFornitore",function(datab,textStatusb){


          });
		

		$('#myModalFornitore').modal();

  		$('#myModalFornitore').on('shown.bs.modal', function (){
 	    	table = $('#tabUscita').DataTable();
      		 table.columns().eq( 0 ).each( function ( colIdx ) {
    			 $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
    				 table
    			      .column( colIdx )
    			      .search( this.value )
    			      .draw();
    			 } );
    			 } );     
    		table.columns.adjust().draw();
		 
		});  
		
    	 
		pacco_selected=id_pacco;
	}
	
	

	 	function modalPaccoUscita(id_pacco){
			
		
			dataString ="id_pacco="+ id_pacco
	        exploreModal("gestionePacco.do?action=item_uscita",dataString,"#modUscita",function(datab,textStatusb){
	        	$('#myModalUscitaPacco').modal();
	        	
	        	 $('#myModalUscitaPacco').on('shown.bs.modal', function (){
	 	 	    	table = $('#tabUscita').DataTable();
	 	     		 table.columns().eq( 0 ).each( function ( colIdx ) {
	 	    			 $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	 	    				 table
	 	    			      .column( colIdx )
	 	    			      .search( this.value )
	 	    			      .draw();
	 	    			 } );
	 	    			 } );    
	 	    		table.columns.adjust().draw(); 
	          });
					
			 
			});  
			
	    	 
			pacco_selected=id_pacco;
		} 
	
	 	
	 	var isRilievi;
	 	
	 	
	 	
	 	function limitaValoreMax(id) {
	 	
	 		  var inputElement = document.getElementById("pezzi_uscita_"+id); // Sostituisci 'pezzi_uscita' con l'id del tuo input
	 		  var valoreMassimo = parseInt(inputElement.getAttribute('max')); // Sostituisci con il tuo valore massimo

	 		  // Aggiungi un evento di input all'elemento input
	 		  inputElement.addEventListener('input', function() {
	 		    // Controlla se il valore supera il massimo consentito
	 		    if (parseInt(inputElement.value) > valoreMassimo) {
	 		      // Se supera, imposta il valore al massimo consentito
	 		      inputElement.value = valoreMassimo;
	 		    }
	 		  });
	 		}
	 	
	function inviaItemUscita(){
		
		 var tabella = $('#tabUscita').DataTable();
		   var data = tabella
		     .rows()
		     .data();
		   
			
		
		if(isRilievi=="1") {
			
			var str_html = "";
			
			
			for(var i=0; i<data.length; i++){
				 if($('#checkbox_'+data[i][0]).is( ':checked' )){					 
					 var match = data[i][3].match(/Spediti (\d+)/);
					 var totale = data[i][3];
					 if(match){
						 totale = parseInt(totale) - parseInt(match[1], 10);
					 }
					str_html+= "<div class='row'><div class='col-xs-6' style='white-space: nowrap;'><label>ID: "+data[i][0]+" - Disegno: "+data[i][1]+" - Variante: "+data[i][2]+"</label></div><div class='col-xs-6'><input id='pezzi_uscita_"+data[i][0]+"' class='form-control' onchange='limitaValoreMax("+data[i][0]+")' style='width:30%; display: inline-block; text-align: right;' step='1' type='number' max='"+data[i][3]+"' min='1' value='"+totale+"'><label style='display: inline-block;'>/"+totale+"</label></div></div><br>"				
				 }
			}		
			$('#body_pezzi_uscita').html(str_html);
		//  limitaValoreMax();
			$('#modalPezziInUscita').modal()
			
		}else{
			var strumenti=[];	
			
		
			   
				for(var i=0; i<data.length; i++){
					 if($('#checkbox_'+data[i][0]).is( ':checked' )){					 
						 strumenti.push(data[i][0]);
						
					 }
				}			
				
				if(strumenti.length==0){
					$('#myModalErrorContent').html("Attenzione! Nessuno Strumento selezionato!");
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");	  
					$('#myModalError').modal('show');
					
				}else{
				
					var strumenti_json = "";
					for(var i = 0; i<strumenti.length;i++){
						strumenti_json = strumenti_json+strumenti[i]+";";
					}
					
				//var strumenti_json = JSON.stringify(strumenti);
				
				cambiaStatoPacco(pacco_selected,2, null, strumenti_json);
				}
		}
		

		}
	
	
	
	
	
	function inviaItemUscitaRilievi(){
		
		
		
		 var tabella = $('#tabUscita').DataTable();
		   var data = tabella
		     .rows()
		     .data();
		   
			
	
			var strumenti=[];	
			var pezzi = [];
		
			   
				for(var i=0; i<data.length; i++){
					 if($('#checkbox_'+data[i][0]).is( ':checked' )){					 
						 strumenti.push(data[i][0]);
						 pezzi.push($('#pezzi_uscita_'+data[i][0]).val());
					 }
				}			
				
				if(strumenti.length==0){
					$('#myModalErrorContent').html("Attenzione! Nessuno Strumento selezionato!");
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");	  
					$('#myModalError').modal('show');
					
				}else{
				
					var strumenti_json = "";
					var pezzi_json = "";
					for(var i = 0; i<strumenti.length;i++){
						strumenti_json = strumenti_json+strumenti[i]+";";
						pezzi_json = pezzi_json+pezzi[i]+";";
					}
					
				//var strumenti_json = JSON.stringify(strumenti);
				
				cambiaStatoPacco(pacco_selected,2, null, strumenti_json, pezzi_json);
				}
		
		
	}
	
	
	function salvaConfigurazione(conf, ddt_form){
		if(modale_ddt){
			if(conf==1){
				DDTFormSumbit(1)
			}else{
				DDTFormSumbit(0);
			}
		}else{
			if(conf==1){
				inserisciPacco(1);
			}else{
				inserisciPacco(0);
			}
		}
		
		
	}
	
	function inviaItemFornitore(){
		
	var strumenti=[];	
		
	   var tabella = $('#tabUscita').DataTable();
	   var data = tabella
	     .rows()
	     .data();
	   
		for(var i=0; i<data.length; i++){
			 if($('#checkbox_'+data[i][0]).is( ':checked' )){					 
				 strumenti.push(data[i][0]);				
			 }
		}			
		
		if(strumenti.length==0){
			$('#myModalErrorContent').html("Attenzione! Nessuno Strumento selezionato!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#myModalError').modal('show');
			
		}else{
		
		var strumenti_json = "";
		for(var i = 0; i<strumenti.length;i++){
			strumenti_json = strumenti_json+strumenti[i]+";";
		}
		
		cambiaStatoPacco(pacco_selected,4, $('#select_fornitore').val(), strumenti_json);
		}
	}
	
	
	function cambiaStatoPacco(id_pacco,stato, fornitore, strumenti_json, pezzi_json){
		var codice = "PC_"+${(pacco.id)+1};
		var ddt = ${(pacco.id)+1};
		var sede_fornitore = $('#select_sede_fornitore').val();
		if(fornitore!=null && fornitore != "undefined"){
			id_pacco=pacco_selected
		}else{
			fornitore="";
		}
		if(stato==4 && fornitore==""){
			$('#myModalErrorContent').html("Attenzione! Nessun Fornitore selezionato!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#myModalError').modal('show');
		}else{
			dataString = "?action=cambia_stato_pacco&id_pacco="+id_pacco+"&codice="+codice+"&fornitore="+fornitore+"&stato="+stato+"&ddt="+
					+ddt+"&strumenti_json="+strumenti_json+"&sede_fornitore="+sede_fornitore+"&pezzi_json="+pezzi_json;
			callAction("gestionePacco.do"+dataString, false, true);
		}
	}

	
	var pacco_selected3;
	function modalCambiaNota(id_pacco){
		$('#myModalCambiaNota').modal();
		pacco_selected3=id_pacco;
	}
	
function cambiaNota(){
		
		var nota = $('#select_nota_pacco').val();
		$('#myModalCambiaNota').modal();
		if(nota!=null && nota!=""){
			$('#myModalCambiaNota').modal('hide');			
				cambiaNotaPacco(pacco_selected3, nota);				
			}			
	}

	
	$("#fileupload").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        	$('#myModalLabel').html("Attenzione!");
        	$('#myModalErrorContent').html("Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }
		
	});
	

	

	var columsDatatables = [];
	 
  	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    } 
   	    $('#tabPM thead th').each( function () {
	    	  $('#inputsearchtable_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);
	    	 
	    	}); 
	     

	} ); 
 

	var selection1={};
	
	
	function aggiungiNotaDDT(nota){
		if(nota!=""){
			$('#note').append(nota + " ");
		}	
	}
	
	$(".select2").select2();
	
	
	
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
			// destinazioneOptions(selection);
			$('#tipo_ddt').val(2);
			 $('#tipo_ddt').change();
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
 		else if(selection==3){
 			$('#select_fornitore').attr("disabled", true);
 			$("#select_fornitore").prepend("<option value='' selected='selected'></option>");
 			$('#data_arrivo').attr("disabled", true);
 			$('#data_arrivo').val('');
 			$('#data_spedizione').attr("disabled", false);
 			 $('#mitt_dest').html("Destinatario");
 			$('#sede_mitt_dest').html("Sede Destinatario");
			 $('#row_destinazione').show();
			/*  $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
			 }); */
				initSelect2('#destinatario', "Seleziona Destinatario...");
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Destinatario..."
		 	});
			// destinazioneOptions(selection);
		 	$('#tipo_ddt').val(2);
		 	 $('#tipo_ddt').change();
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
			 //destinazioneOptions(selection);
 		}else{
 		
 			$('#select_fornitore').attr("disabled", true);
 			$("#select_fornitore").prepend("<option value='' selected='selected'></option>");
 			$('#data_arrivo').attr("disabled", false);
 			$('#data_spedizione').val('');
 			$('#data_spedizione').attr("disabled", true);
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
 		
 		
 	});
	
function tornaMagazzino(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  callAction('listaPacchi.do');
}


function apriAllegati(id_pacco){
	 
	 $('#tab_archivio').html("");
	 dataString ="action=lista_allegati&id_pacco="+ id_pacco;
    exploreModal("gestionePacco.do",dataString,"#tab_archivio",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}



function modalYesOrNo(id_allegato, id_pacco){
	$('#id_allegato_elimina').val(id_allegato);
	$('#id_pacco_elimina').val(id_pacco);
	
	$('#myModalYesOrNo').modal();
}

var commessa_options;

$(document).ready(function() {

	 commessa_options = $('#commessa option').clone();
	$('.dropdown-toggle').dropdown();
	
	initSelect2('#select1');
	initSelect2('#cliente_utilizzatore');
	initSelect2('#destinatario', 'Seleziona Mittente...');
	initSelect2('#destinazione', 'Seleziona Destinazione...');
	
	var columsDatatables2 = [];
	
    $('#tabItem thead th').each( function () {
     	
    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
    	
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" id="search_item_'+$(this).index()+'" type="text"  value=""/></div>');
    	
    	});
    

	

	
     $('#tabPM thead th').each( function () {
 	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	  var title = $('#tabPM thead th').eq( $(this).index() ).text();
	
	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	
	});
     
     
     
     
	var columsDatatables3 = [];
	
    $('#tabItemRil thead th').each( function () {
     	
    	var title = $('#tabItemRil thead th').eq( $(this).index() ).text();
    	
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" id="search_item_ril_'+$(this).index()+'" type="text"  value=""/></div>');
    	
    	});
	
	


    
     
     var stato="${stato}";
     
      if(stato=='chiusi'){
		$('#btnFiltri_CHIUSO').attr('disabled', true);
	}
	else if(stato=='tutti'){
		
		$('#btnTutti').attr('disabled', true);
	}
	else{
		$('#btnFiltri_APERTO').attr('disabled', true);
		
	}
  
     
     

	$('#select3').parent().hide();
	
	//selection1= $('#select1').html();
	selection1= $('#cliente_appoggio').html();
	
/*  	$('#select1').select2({
		placeholder : "Seleziona Cliente..."
	}); 
 	 */
 	
 	
	 /* $('#destinatario').select2({
			placeholder : "Seleziona Mittente..."
	 }); */
	$('#sede_destinatario').select2({
	  placeholder : "Seleziona Sede Mittente..."
	});
	
	
	$('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
	
 	$('.datetimepicker').datetimepicker({
		format : "dd/mm/yyyy hh:ii"
	}); 

 	var start = "${dateFrom}";
 	var end = "${dateTo}";

 	$('input[name="datarange"]').daterangepicker({
	    locale: {
	      format: 'DD/MM/YYYY'
	    
	    }
	}, 
	function(start, end, label) {

	});
 	
 	if(start!=null && start!=""){
	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
	
	 	$("#tipo_data option[value='']").remove();
	 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true);
	 }
 	
 	var pacchi_esterno = ${pacchi_esterno};
 	if(pacchi_esterno){
 		$('#tornaMagazzino').show();
 	}else{
 		$('#tornaMagazzino').hide();
 	}
 	
	
	table = $('#tabPM').DataTable({
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
        "order": [[ 25, "desc" ]],
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: false,
	      scrollX: true,
	      scrollY: "450px",
	      stateSave: true,
	      columnDefs: [
	    	    /*  { responsivePriority: 1, targets: 7 },
	                  { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 0 }, 
	                   { responsivePriority: 4, targets: 8 }, */
	                  // { responsivePriority: 5, targets: 16 }
	    //	  { responsivePriority: 1, targets: 9 },
	    //	  { responsivePriority: 2, targets: 8 }
	               ], 	        
  	      buttons: [   
  	    	,{
                extend: 'excel',
                text: 'Esporta Excel',
                 exportOptions: {
                    modifier: {
                        page: 'current'
                    }
                } 
            },
  	    	  {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
		
	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
// DataTable
//table = $('#tabPM').DataTable();
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
	

$('#tabPM').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});
	coloraRighe(table);

var val = $('#inputsearchtable_4').val();
if(val!=""){
	$('#filtro_commessa option[value=""]').remove();
	$('#filtro_commessa option[value="'+val+'"]').attr('selected', true);
}

table_item = $('#tabItem').DataTable({
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
      responsive: false,
      scrollX: true,
      stateSave: false,
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
     	 {"data" : "priorita"},
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

table_item.buttons().container().appendTo( '#tabItem_wrapper .col-sm-6:eq(1)');


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 


$('#tabItem').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})


});





table_item_ril = $('#tabItemRil').DataTable({
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
      stateSave: false,
     columns : [
     	 
     	{"data" : "disegno"},
     	{"data" : "variante"},
     	//{"data" : "pezzi_ingresso", createdCell: editableCell},
     
     	{"data" : "note_rilievo"},
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

table_item_ril.buttons().container().appendTo( '#tabItemRil_wrapper .col-sm-6:eq(1)');


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 


$('#tabItemRil').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})


});



	if($('#destinatario').val()==""){
		$('#sede_destinatario').prop("disabled", true);
	}
	if($('#destinazione').val()==""){
		$('#sede_destinazione').prop("disabled", true);
	}

}); 

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

	 var place
	 
$('#tipologia').on('change', function(){
	
	selection= $(this).val();

	if(selection=="1"){
	
		initSelect2('#select1', "Seleziona Cliente...");
		/* $('#select1').select2({
			placeholder : "Seleziona Cliente..."
		}); */
		//$('#select1').html(selection1);	
		
	}else{

 		/* $('#select1').select2({
			placeholder : "Seleziona Fornitore..."
		});  */

		initSelect2('#select1', "Seleziona Fornitore...");
		//$('#select1').html($('#select3 option').clone());
	} 

});
	


var idCliente = ${userObj.idCliente}
var idSede = ${userObj.idSede}

 $body = $("body");


  $("#select1").change(function() {
  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#select2 option').clone());
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
	 $("#select2").prop("disabled", false);
	 
	  $('#select2').html(opt);


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
		$('#cliente_utilizzatore').val(id);
		$('#cliente_utilizzatore').change();
		initSelect2('#cliente_utilizzatore');
	});

  
  $('#select2').change(function(){
	   
	   if($('#tipo_ddt').val() == 1){
		  
		   $('#spedizioniere').val("");
		   $('#account').val("");
		   $('#cortese_attenzione').val("");
		   $('#tipo_porto').val(1);
		   $('#aspetto').val(1);
	   }
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
}else{
   $('#spedizioniere').val("");
   $('#account').val("");
   $('#cortese_attenzione').val("");
   $('#tipo_porto').val(1);
   $('#aspetto').val(1);
}
  
}); 
  
  
  $('#tipo_ddt').change(function(){
	 $('#select2').change();
  });
  
  

	 $('#NuovoPaccoForm').on('submit',function(e){
	 	    e.preventDefault();

	 	});    
  
	 $("#myModalCommessa").on("hidden.bs.modal", function(){
			
			$(document.body).css('padding-right', '0px');
			
		});

		$("#myModalError").on("hidden.bs.modal", function(){
			
			$(document.body).css('padding-right', '0px');
			
		});
		
	$("#myModalArchivio").on("hidden.bs.modal", function(){
			
			$(document.body).css('padding-right', '0px');
			
		});
		
		
		function formatDate(data){
			
			   var mydate = new Date(data);
			   
			   if(!isNaN(mydate.getTime())){
			   
				   str = mydate.toString("dd/MM/yyyy");
			   }			   
			   return str;	 		
		}
		
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
      	  $("#sede_destinatario").trigger("chosen:updated");   	  
      		$("#sede_destinatario").change();  
      	});
     
     $("#destinazione").change(function() {    
  	     	   
     	  if ($(this).data('options') == undefined) 
     	  {
     	    
     	    $(this).data('options', $('#sede_destinazione option').clone());
     	  }
     	var id2 = $(this).val();
     	var id = null;
     	if($(this).val()!=""){
     		id = $(this).val().split("_");
     	}else{
     		id=$(this).val();
     	}
     	
     	  var options = $(this).data('options');
     	//  var id_sede = ${pacco.id_sede };      	  
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
     	  $("#sede_destinazione").trigger("chosen:updated");   	  
     		$("#sede_destinazione").change();  
     	}); 
		
     
     
     $("#select_fornitore").change(function() {         
     	  if ($(this).data('options') == undefined) 
     	  {
     	   
     	    $(this).data('options', $('#select_sede_fornitore option').clone());
     	  }
     	  
     	  var id = $(this).val().split("_");
     	  var options = $(this).data('options');
     	//  var id_sede = ${pacco.ddt.id_sede_destinazione };      	  
     	  var opt=[];      	
     	  opt.push("<option value = 0 >Non associate</option>");
     	   for(var  i=0; i<options.length;i++)
     	   {
     		   
     		var str=options[i].value.split("_");       		
     		if(str[1]==id[0])
     		{
     			opt.push(options[i]);      			
     		}   
     	   }
     	 $("#select_sede_fornitore").prop("disabled", false);   	 
     	  $('#select_sede_fornitore').html(opt);   	  
     	  $("#select_sede_fornitore").trigger("chosen:updated");   	  
     		$("#select_sede_fornitore").change();  
     	});
    
     


		$('#myModalFornitore').on('hidden.bs.modal', function(){
		
			$(document.body).css('padding-right', '0px');
			$('#tabUscita').remove();
			
		});
		
		$('#myModalUscitaPacco').on('hidden.bs.modal', function(){
			
			$(document.body).css('padding-right', '0px');
			$('#tabUscita').remove();
			
		});
		


   	function coloraRighe(tabella){
  	 
	   var data = tabella
	     .rows()
	     .data();
   		
 		for(var i=0;i<data.length;i++){	
 	 	    var node = $(tabella.row(i).node());  	 	   
 	 	    var color = node.css('backgroundColor');
 	 	    
 	 	 	 if(rgb2hex(color)=="#00ff80"){
				 var data_row = $(tabella.row(i).data());		
				 var origine = stripHtml(data_row[1]);			
				for(var j = 0; j<data.length;j++){			
					
					var data_row2 = $(tabella.row(j).data());		
					 var origine2 = stripHtml(data_row2[1]);
			
					if(origine2==origine){
						var node2 = $(tabella.row(j).node());  
						node2.css('backgroundColor',"#00ff80");
					}							
				 }		 		
 			 }
 	 	 }	
	}   
 		
   	function isDate(ExpiryDate) { 
   	    var objDate,  // date object initialized from the ExpiryDate string 
   	        mSeconds, // ExpiryDate in milliseconds 
   	        day,      // day 
   	        month,    // month 
   	        year;     // year    	    
    	    if (ExpiryDate.length !== 10) { 
   	        return false; 
   	    }  
   	    
   	    if (ExpiryDate.substring(2, 3) !== '/' || ExpiryDate.substring(5, 6) !== '/') { 
   	        return false; 
   	    } 
   	  
   		day = ExpiryDate.substring(0, 2) - 0; 
   	    month = ExpiryDate.substring(3, 5) - 1; 
   	    year = ExpiryDate.substring(6, 10) - 0; 
   	    
   	    if (year < 1000 || year > 3000) { 
   	        return false; 
   	    } 
   	    mSeconds = (new Date(year, month, day)).getTime(); 
   	  
   	    objDate = new Date(); 
   	    objDate.setTime(mSeconds); 
   	    
   	    if (objDate.getFullYear() !== year || 
   	        objDate.getMonth() !== month || 
   	        objDate.getDate() !== day) { 
   	        return false; 
   	    } 
   	  
   	    return true; 
   	}

 		
 		
 	function rgb2hex(rgb){
 		 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 		 return (rgb && rgb.length === 4) ? "#" +
 		  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
 		  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
 		  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
 		}

 		function hex(x) {
 		  return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
 		 }
 		
 		
 		
  function filtraPacchi(filtro){
	  
	  	dataString="";
	  	if(filtro!=null && filtro!=''){
	  		dataString = "?stato="+filtro;	
	  	}		

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();

		callAction("listaPacchi.do"+ dataString, false,true);
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
		
</script>


</jsp:attribute> 
</t:layout>
  
 
