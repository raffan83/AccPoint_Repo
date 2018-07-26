<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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

<button class="btn btn-primary pull-left" onClick="creaNuovoPacco()">Nuovo Pacco</button>


</div>
</div>

<div class="row" style="margin-bottom:20px; margin-top:20px">
<div class="col-lg-12">
 
 
<button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraPacchi('tutti')">TUTTI</button>
 <button class="btn btn-primary btnFiltri" id="btnFiltri_CHIUSO" onClick="filtraPacchi('CHIUSO')" >CHIUSI</button>
 <button class="btn btn-primary btnFiltri" id="btnFiltri_APERTO" onClick="filtraPacchi('APERTO')" >APERTI</button>
 </div>
 </div>
 
 <div class="row">
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
	<div class="col-xs-10">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Date:</label>
					<div class="col-md-4 input-group" >
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

	
	</div>
	
<div class="row">
<div class="col-md-5">
<label>Commessa</label>
<select class="form-control select2" data-placeholder="Seleziona Commessa..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_commessa" name="filtro_commessa">
<option value=""></option>
<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
	<option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
</c:forEach>
</select>

</div>
<button type="button" style="margin-top:25px" class="btn btn-primary btn-flat" onclick="resetCommesse()">Reset Commessa</button>
</div><br>


     <div class="row">
     <div class = col-sm-6>
     	<button class="btn btn-primary customTooltip" onClick="pacchiEsterno()" title="Click per visualizzare i pacchi fuori dal magazzino" >Pacchi all'esterno</button>
     
     </div>
     </div>

<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
 <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


  <th >ID</th> 
 <th >Data Creazione</th>
 <th >Origine</th>
 <th >Stato Pacco</th>
  <th >Strumenti Lavorati</th>
 <th >Note Pacco</th>
 <th >Cliente</th>
 <th >Fornitore</th>
 <th >DDT</th>
 <th style="min-width:150px">Azioni</th>
  <th >Stato lavorazione</th>
   <th >N. Colli</th>
   <th >Corriere</th> 
    <th>Data Arrivo/Rientro</th>
 <th >Data Spedizione</th>
 <th>Annotazioni</th> 
 <th >Codice pacco</th>
 <th>Sede</th>
 <th >Company</th>
 <th >Responsabile</th>
 <th >Commessa</th> 

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_pacchi}" var="pacco" varStatus="loop">
  <c:choose>
 <c:when test="${pacco.stato_lavorazione.id==1 && utl:getRapportoLavorati(pacco)==1 && pacco.chiuso!=1}">
 <tr style="background-color:#00ff80">
 </c:when>
 <c:otherwise>
 <tr>
 </c:otherwise>
 </c:choose> 


<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${pacco.id}')">
${pacco.id}
</a>
</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_lavorazione}" /></td>
<td>
<c:if test="${pacco.origine!='' && pacco.origine!=null}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPaccoFromOrigine('${pacco.origine}')">${pacco.origine}</a>
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
<td>${utl:getStringaLavorazionePacco(pacco)}</td>
<td>
<span class="label btn" style="background-color:#808080" onClick="modalCambiaNota(${pacco.id})">${pacco.tipo_nota_pacco.descrizione }</span>
</td>
<td>${pacco.nome_cliente}</td>
<td>${pacco.fornitore }</td>
<c:choose>
<c:when test="${pacco.ddt.numero_ddt!='' &&pacco.ddt.numero_ddt!=null}">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${pacco.ddt.id}')">
${pacco.ddt.numero_ddt}
</a></td></c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>


<td>
<c:if test="${pacco.stato_lavorazione.id==1 && pacco.chiuso!=1}">
	<a class="btn customTooltip  btn-success"  title="Click per creare il pacco in uscita" onClick="modalPaccoUscita('${pacco.id}')"><i class="glyphicon glyphicon-log-out"></i></a>
	<%-- <a class="btn customTooltip  btn-success"  title="Click per creare il pacco in uscita" onClick="cambiaStatoPacco('${pacco.id}', 2)"><i class="glyphicon glyphicon-log-out"></i></a> --%>
	
</c:if>

<c:if test="${(pacco.ddt.numero_ddt=='' ||pacco.ddt.numero_ddt==null) && pacco.chiuso!=1 && pacco.stato_lavorazione.id!=2}">
	<button class="btn customTooltip  btn-info" title="Click per creare il DDT" onClick="creaDDT('${pacco.ddt.id}','${pacco.nome_cliente }','${pacco.nome_sede}', '${pacco.stato_lavorazione.id }', '${pacco.commessa }', '${pacco.ddt.id_destinatario }', '${pacco.ddt.id_sede_destinatario }')"><i class="glyphicon glyphicon-duplicate"></i></button>
</c:if>
<c:if test="${pacco.stato_lavorazione.id==2 && pacco.chiuso!=1}">
	<button class="btn customTooltip  btn-danger" title="Click se il pacco è stato spedito" onClick="cambiaStatoPacco('${pacco.id}', 3)"><i class="glyphicon glyphicon-send"></i></button>
	<button class="btn customTooltip  btn-warning" title="Click se il pacco si trova presso un fornitore" onClick="modalFornitore('${pacco.id}')"><i class="fa fa-mail-forward"></i></button>
	
	
</c:if>
<c:if test="${pacco.stato_lavorazione.id==4 && pacco.chiuso!=1}">
	<button class="btn customTooltip  btn-primary" title="Click se il pacco è rientrato da un fornitore" onClick="cambiaStatoPacco('${pacco.id}', 5)"><i class="fa fa-reply"></i></button>
	
</c:if>
<c:if test="${pacco.stato_lavorazione.id==3 && pacco.chiuso!=1}">
	<a class="btn customTooltip btn-info" style="background-color:#990099;border-color:#990099"  title="Click per chiudere i pacchi" onClick="chiudiPacchiOrigine('${pacco.origine}')"><i class="glyphicon glyphicon-remove"></i></a>
</c:if>
<c:if test="${(pacco.tipo_nota_pacco.id==null || pacco.tipo_nota_pacco.id=='') && pacco.chiuso!=1}">
<a class="btn customTooltip btn-info" style="background-color:#808080;border-color:#808080"  title="Click per aggiungere una nota" onClick="modalCambiaNota(${pacco.id})"><i class="glyphicon glyphicon-refresh"></i></a>
</c:if>
<c:if test="${pacco.ddt.link_pdf!=null && pacco.ddt.link_pdf!='' && pacco.ddt.numero_ddt!=null && pacco.ddt.numero_ddt!='' && pacco.chiuso!=1}">
<c:url var="url" value="gestioneDDT.do">
<c:param name="filename"  value="${pacco.codice_pacco}" />
<c:param name="action" value="download" />
 <c:param name="link_pdf" value="${pacco.ddt.link_pdf }"></c:param>
  </c:url>
<button   class="btn customTooltip btn-danger" style="background-color:#A11F12;border-color:#A11F12;border-width:0.11em" title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o fa-sm"></i></button>
</c:if>
</td>
<c:choose>
<c:when test="${pacco.chiuso==1}">
<td><span class="label label-danger" >CHIUSO</span></td>
</c:when>
<c:otherwise>
<td><span class="label label-success" >APERTO</span></td>
</c:otherwise>
</c:choose>
<td>${pacco.ddt.colli }</td>
<td>${pacco.ddt.spedizioniere}</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_arrivo}" /></td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_spedizione}" /></td>
<td>${pacco.ddt.annotazioni}</td>
<td>${pacco.codice_pacco}</td>
<td>${pacco.nome_sede }</td>
<td>${pacco.company.denominazione}</td>
<td>${pacco.utente.nominativo}</td>
 <td>
<c:if test="${pacco.commessa!=null && pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${pacco.commessa}');">${pacco.commessa}</a>
</c:if>
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

 <div class="col-md-6"> 
                  <label>Cliente</label>
                  
	                  <select name="select1" id="select1"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%" required>
	                
	                  <c:if test="${userObj.idCliente != 0}">
	                    <option value=""></option>
	                      <c:forEach items="${lista_clienti}" var="cliente">
	                       <c:if test="${userObj.idCliente == cliente.__id}">
	                           <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option> 
	                        </c:if>
	                     </c:forEach>
	                  
	                  </c:if>
	                 
	                  <c:if test="${userObj.idCliente == 0}">
	                  <option value=""></option>
	                      <c:forEach items="${lista_clienti}" var="cliente">
	                           <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option> 
	                     </c:forEach>
	                  
	                  </c:if>
	                    
	                  </select>
                  

        </div>
 
 </div> 
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

 <div class="row">
 <div class="col-md-6">
 <div class="form-group">
                  <label>Sede</label>
                 
<%--                   <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="true">
                   <c:if test="${userObj.idSede != 0}">
             			<c:forEach items="${lista_sedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>     
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}__${sedi.indirizzo}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                           	</c:if>                  
                     	</c:forEach>
                     </c:if>
                  </select>  --%>
                <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="true">
                   <c:if test="${userObj.idSede != 0}">
             			<c:forEach items="${lista_sedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}">${sedi.descrizione} - ${sedi.indirizzo}</option>     
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${sedi.__id}_${sedi.id__cliente_}__${sedi.descrizione}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                           	</c:if>                  
                     	</c:forEach>
                     </c:if>
                  </select> 
        </div>
</div>
<div class="col-md-6">
<a class="btn btn-primary" style="margin-top:25px" id="import_button" onClick="importaDaCommessa($('#commessa_text').val())">Importa Da Commessa</a>
</div>
</div>
 <div class="form-group">
 
                  <label>Commessa</label>
     <div class="row" style="margin-down:35px;">    
 <div class= "col-xs-6">             
                  <select name="commessa" id="commessa" data-placeholder="Seleziona Commessa..."  class="form-control select2 pull-left" style="width:100%"  aria-hidden="true" data-live-search="true">
                   <option value=""></option>   
             			<c:forEach items="${lista_commesse}" var="commessa">
                          	 <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>   
                     	</c:forEach>
                  </select> 
  </div>
   <div class= "col-xs-6">
                
                  <input type="text" id="commessa_text" name="commessa_text" class="form-control pull-right" style="margin-down:35px;">
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
                                   
                  <select class="form-control select2" data-placeholder="Seleziona Destinazione..." id="destinazione" name="destinazione" style="width:100%">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>

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
                 
                  <select class="form-control select2"  id="destinatario" name="destinatario" style="width:100%"  aria-hidden="true" data-live-search="true">
                  <option value=""></option>
                  <c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
                  <option value="${cliente.__id}">${cliente.nome}</option>
                  </c:forEach> 
                  </select>
                  
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
<label>Cortese Attenzione</label>
	<input type="text" id="cortese_attenzione" name="cortese_attenzione" class="form-control" >
</div>

</div> 
<label>Allega File</label>
 <input id="fileupload_pdf" type="file" name="file" class="form-control"/>
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
<div class="col-md-6">
<a class="btn btn-primary" id="addNotaButton" onClick="aggiungiNotaDDT($('#tipo_note_ddt').val())" style="margin-top:25px"><i class="fa fa-plus"></i></a>
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
			<option value="${tipo_item.id}">${tipo_item.descrizione}</option>
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



 <div class="form-group">
 <label>Item Nel Pacco</label>
 <div class="table-responsive">
<table id="tabItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantità</th>
 <th>Stato</th>
 <th>Attività</th>
 <th>Destinazione</th>
 <th>Priorità</th>
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
		
       <button class="btn btn-default pull-left" onClick="inserisciPacco()"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>  
       
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
			 
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

       
      </div>
    </div>
  </div>
</div>


<div id="myModalCommessa" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Attività </h4>
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
		<!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="pressoFornitore()">Salva</button> -->
	<button class="btn btn-primary"  onClick="inviaItemUscita()">Salva</button>
       <!-- <button class="btn btn-primary" id = "saveFornitore" name="saveFornitore" onClick="cambiaStatoPacco(null, 4, $('#select_fornitore').val())">Salva</button> -->
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
      <div class="modal-footer">


       
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
		<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>

<script type="text/javascript">


function pacchiEsterno(){
	
	dataString = "?action=pacchi_esterno";

pleaseWaitDiv = $('#pleaseWaitDialog');
pleaseWaitDiv.modal();

callAction("listaPacchi.do"+ dataString, false,true);
}

var nuovo=true;

$('#commessa').on('change', function(){
	
	id_commessa = $('#commessa').val();
	showNoteCommessa(id_commessa);
	
});


	
$("#filtro_commessa").on('change', function(){
	
	/* dataString ="?action=filtraCommesse&commessa=" + $('#filtro_commessa').val(); 
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

	callAction("listaPacchi.do"+ dataString, false,true); */
	var comm = $('#filtro_commessa').val();
	
	$('#inputsearchtable_20').val(comm);
	
	table
    .columns( 20 )
    .search( comm )
    .draw();
});
	
/* var commessa = "${commessa}";

if(commessa!=null){
	$('#filtro_commessa option[value="${commessa}"]').attr("selected", true);
	
} */


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
	
	$('#inputsearchtable_20').val("");
	
	table
    .columns( 20 )
    .search( "" )
    .draw();
	
	$("#filtro_commessa").append('<option value=""></option>');
	$('#filtro_commessa option[value=""]').attr('selected', true);

}
	var flag = 0;
function creaDDT(id_ddt,nome_cliente, nome_sede, stato_pacco, commessa, id_destinatario, id_sede_destinatario){
flag=1;

	$('#collapsed_box').removeClass("collapsed-box");
	$("#numero_ddt").attr("required", "true");

	$('#commessa_text').val(commessa);
	$('#mitt_dest').html("Mittente");	
	
	$('#destinatario').select2("destroy");
	$('#sede_destinatario').select2("destroy");
	$('#destinazione').select2("destroy");
	$('#sede_destinazione').select2("destroy");
	$('#tipo_note_ddt').select2("destroy");
	$('#causale').select2("destroy");
	$('#DDT').clone().appendTo($('#ddt_body'));
	
 	$('#ddt_body').find('#datepicker_ddt').each(function(){
		this.id = 'date_ddt';
	});	
  	$('#ddt_body').find('#destinatario').each(function(){
		this.id = 'destinatario_ddt';
		this.name = 'destinatario_ddt';
	});	 
	$('#ddt_body').find('#sede_destinatario').each(function(){
		this.id = 'sede_destinatario_ddt';
		this.name = 'sede_destinatario_ddt';
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
	$('#ddt_body').find('#fileupload').each(function(){
		this.id = 'fileupload_create_ddt';
	});	

	$('#ddt_body').find('#addNotaButton').each(function(){
		this.id = 'addNotaButton_ddt';
	}); 
	$('#ddt_body').find('#note').each(function(){
		this.id = 'note_ddt';
		this.name = 'note_ddt';
		//this.form = 'DDTForm';
	}); 
	$('#ddt_body').find('#tipo_note_ddt').each(function(){
		this.id = 'tipo_nota_ddt';
	});
	$('#ddt_body').find('#causale').each(function(){
		this.id = 'causale_ddt';
	});
	
	$('#ddt_body').find('#row_destinatario').each(function(){
		this.id = 'row_destinatario_ddt';
	});
	
	$('#row_destinatario_ddt').append('<div class="col-md-2"><a class="btn btn-primary" style="margin-top:25px" onClick="importaDaCommessa(\''+commessa+'\')">Importa Da Commessa</a></div>');
	
	$('#note_ddt').attr('form', 'DDTForm');
	
	$('#colli_ddt').val(0);
	$('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
		
	$('.select2').select2();
	$('#destinatario').select2({
		placeholder:"Seleziona Mittente..."
	});
	$('#sede_destinatario').select2({
		placeholder:"Seleziona Sede Mittente..."
	});
	$('#select1').select2({
		placeholder:"Seleziona Cliente..."
	});
	
	$('#destinatario_ddt').select2({
		placeholder:"Seleziona Mittente..."
	});
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
   		$("#sede_destinatario_ddt").change();  
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
  	 $("#sede_destinazione_ddt").prop("disabled", false);   	 
  	  $('#sede_destinazione_ddt').html(opt);   	  
  	  $("#sede_destinazione_ddt").trigger("chosen:updated");   	  
  		$("#sede_destinazione_ddt").change();  
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
	
	$('#ddt_body').append("<input type='hidden' id='id_pacco' name='id_ddt' value="+id_ddt+">");	
	$('#ddt_body').append("<p align='center'><a class='btn btn-default' onClick='DDTFormSumbit()'>Salva</a></p>");	
	$('#myModalDDT').modal();
	
	if(stato_pacco==5){
		
		$('#destinatario_ddt').val(id_destinatario);
		$('#destinatario_ddt').change();
		//$('#destinatario_ddt').change();
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


function DDTFormSumbit(){
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  $("#DDTForm").submit();
	
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

$("#commessa").change(function(){
	
	$("#commessa_text").val($("#commessa").val());
	
	
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
	var id_cliente = document.getElementById("select1").value;
	var id_sede = document.getElementById("select2").value;
	var tipo_item = document.getElementById("tipo_item").value;
	
	if(id_cliente==""){
		
	}else{
	
	inserisciItemModal(tipo_item,id_cliente,id_sede);
	}
	};

	
	function inserisciPacco(){
		
		
		items_json.forEach(function(item){
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
					item.desitnazione= "";
				}

		}); 
		
		var json_data = JSON.stringify(items_json);
		
		$('#json').val(json_data);
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
	   
	    if($('#data_arrivo').val()=='' && !$('#data_arrivo').prop('disabled')){
			$('#data_arrivo').attr('required', true);
			return false;
		}
		if($('#data_spedizione').val()=='' && !$('#data_spedizione').prop('disabled')){
			$('#data_spedizione').attr('required', true);
			return false;
		}
	    
	 //   if (codice_pacco=="" ||  cliente =="") {
		 if (cliente =="") {
	    	/* $('#collapsed_box').toggleBox(); */
	      
	        return false;
	    }else{
	    	return true;
	    }
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

          });
				
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
		
    	 
		pacco_selected=id_pacco;
	}
	
	
	
	function inviaItemUscita(){
		
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
			
			var strumenti_json = JSON.stringify(strumenti);
			
			cambiaStatoPacco(pacco_selected,2, null, strumenti_json);
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
		
		var strumenti_json = JSON.stringify(strumenti);
		
		cambiaStatoPacco(pacco_selected,4, $('#select_fornitore').val(), strumenti_json);
		}
	}
	
	
	function cambiaStatoPacco(id_pacco,stato, fornitore, strumenti_json){
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
					+ddt+"&strumenti_json="+strumenti_json+"&sede_fornitore="+sede_fornitore;
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
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    
	    
		if($('#inputsearchtable_10').val()=='CHIUSO'){
	 		$('#btnFiltri_CHIUSO').attr('disabled', true);
	 	}
	 	else if($('#inputsearchtable_10').val()=='APERTO'){
	 		$('#btnFiltri_APERTO').attr('disabled', true);
	 	}
	 	else{
	 		$('#btnTutti').attr('disabled', true);
	 	}
	    

	} );

//  	var columsDatatables2 = [];
	 
 	$("#tabItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	    }
/* 	    $('#tabItem thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} ); */

	} );   

	var selection1={};
	
	
	function aggiungiNotaDDT(nota){
		if(nota!=""){
			$('#note').append(nota);
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
 			
 			$('#destinatario').select2({
			placeholder : "Seleziona Destinatario..."
			});
 			$('#sede_destinatario').select2({
 				placeholder : "Seleziona Sede Destinatario..."
 			});

			 $('#row_destinazione').show();
			// destinazioneOptions(selection);
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
 			 $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
			 });
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Mittente..."
		 	});
			 $('#row_destinazione').hide();
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
			 $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
			 });
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Destinatario..."
		 	});
			// destinazioneOptions(selection);
 		}
 		
 		else if(selection==2){
 			$('#data_arrivo').attr("disabled", true);
 			$('#data_spedizione').attr("disabled", true);
 			$('#data_arrivo').val('');
 			$('#data_spedizione').val('');
 			 $('#mitt_dest').html("Destinatario");
 			$('#sede_mitt_dest').html("Sede Destinatario");
 			 $('#destinatario').select2({
					placeholder : "Seleziona Destinatario..."
			 });
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Destinatario..."
		 	});
			 $('#row_destinazione').show();
			 //destinazioneOptions(selection);
 		}else{
 		
 			$('#select_fornitore').attr("disabled", true);
 			$("#select_fornitore").prepend("<option value='' selected='selected'></option>");
 			$('#data_arrivo').attr("disabled", false);
 			$('#data_spedizione').val('');
 			$('#data_spedizione').attr("disabled", true);
 			 $('#mitt_dest').html("Mittente");
 			$('#sede_mitt_dest').html("Sede Mittente");
 			 $('#destinatario').select2({
					placeholder : "Seleziona Mittente..."
			 });
		 	$('#sede_destinatario').select2({
		 	  placeholder : "Seleziona Sede Mittente..."
		 	});
			 $('#row_destinazione').hide();
 		}
 		
 		
 	});
	
function tornaMagazzino(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  callAction('listaPacchi.do');
}
	
$(document).ready(function() {

	$('.dropdown-toggle').dropdown();
	var columsDatatables2 = [];
	
    $('#tabItem thead th').each( function () {
     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
    	var title = $('#tabItem thead th').eq( $(this).index() ).text();
    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
    	} );
    
    
    
	$('#select3').parent().hide();
	
	selection1= $('#select1').html();
	
 	$('#select1').select2({
		placeholder : "Seleziona Cliente..."
	}); 
	 $('#destinatario').select2({
			placeholder : "Seleziona Mittente..."
	 });
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
        pageLength: 25,
        "order": [[ 0, "desc" ]],
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      columnDefs: [
	    	    /*  { responsivePriority: 1, targets: 7 },
	                  { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 0 }, 
	                   { responsivePriority: 4, targets: 8 }, */
	                  // { responsivePriority: 5, targets: 16 }
	    	  { responsivePriority: 1, targets: 9 },
	    	  { responsivePriority: 2, targets: 8 }
	               ], 	        
  	      buttons: [   
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

var val = $('#inputsearchtable_20').val();
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
      searchable: true, 
      targets: 0,
      responsive: false,
      scrollX: true,
      stateSave: true,
     columns : [
     	 {"data" : "id_proprio"},
     	 {"data" : "tipo"},
     	 {"data" : "denominazione"},
     	 {"data" : "quantita"},
     	 {"data" : "stato"},
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
//DataTable
table_item = $('#tabPM').DataTable();
//Apply the search
table_item.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
  table_item
      .column( colIdx )
      .search( this.value )
      .draw();
} );
} ); 
table.columns.adjust().draw();


$('#tabItem').on( 'page.dt', function () {
$('.customTooltip').tooltipster({
    theme: 'tooltipster-light'
});

$('.removeDefault').each(function() {
   $(this).removeClass('btn-default');
})


});


	if(idCliente != 0 && idSede != 0){
		 $("#select1").prop("disabled", true);
		$("#select2").change();
	}else if(idCliente != 0 && idSede == 0){
		 $("#select1").prop("disabled", true);
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


	if($('#destinatario').val()==""){
		$('#sede_destinatario').prop("disabled", true);
	}
	if($('#destinazione').val()==""){
		$('#sede_destinazione').prop("disabled", true);
	}

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
	
/* $("#select2").change(function(){
	
	var cliente = $('#select1').val();
	var sede = $('#select2').val();
	
	var str = cliente.split("_");
	
	//$('#destinatario').val(str[1]);
	
	//var str2 = sede.split("_");
	//$('#via').val(str2[5]);
	

}); */



var idCliente = ${userObj.idCliente}
var idSede = ${userObj.idSede}

 $body = $("body");


  $("#select1").change(function() {
  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#select2 option').clone());
	  }
	  
	  var selection = $(this).val()
	 
	  var id = selection.substring(0,selection.indexOf("_"));
	  
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1,str.indexOf("__"))==id)
		{
			
			//if(opt.length == 0){
		 
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#select2").prop("disabled", false);
	 
	  $('#select2').html(opt);
	  
	  $("#select2").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#select2").change();  
	  //}
	  
	
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
				 var origine = stripHtml(data_row[2]);			
				for(var j = 0; j<data.length;j++){			
					
					var data_row2 = $(tabella.row(j).data());		
					 var origine2 = stripHtml(data_row2[2]);
			
					if(origine2==origine){
						var node2 = $(tabella.row(j).node());  
						node2.css('backgroundColor',"#00ff80");
					}		
					
					
				 }		
 		
 				}
 	 	 	 }	
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
		
</script>


</jsp:attribute> 
</t:layout>
  
 
