<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        Dettaglio Intervento Rilievi
        <small></small>
      </h1>
        <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>

    <!-- Main content -->
    <section class="content">




            
            <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${intervento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>ID Commessa</b> <a class="pull-right">${intervento.commessa}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Cliente</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nome_cliente } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="btn btn-warning pull-right btn-xs" title="Click per modificare la sede" onClick="inserisciSede('${intervento.id}')"><i class="fa fa-edit"></i></a>
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${intervento.nome_sede } </a>
                </li>
                <li class="list-group-item">
                  <b>Data Apertura</b> <a class="pull-right">
	
			<c:if test="${not empty intervento.data_apertura}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.data_apertura}" />
			</c:if>
			
		</a>
                </li>
                 <li class="list-group-item">
                  <b>Data Chiusura</b> 
                 <a class="pull-right">
                 
                 <c:if test="${not empty intervento.data_chiusura}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.data_chiusura}" />
			</c:if>
                 
                 </a>
                 
                 </li>
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  

    
 			<c:if test="${intervento.stato_intervento == 1}">
					<div id="statoa_${intervento.id}">	<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="openModalComunicazione('${utl:encryptData(intervento.id)}','chiusura')" id="statoa_${intervento.id}"> <span class="label label-success">APERTO</span></a></div>
						
					</c:if>

					<c:if test="${intervento.stato_intervento == 2}">
					<div id="statoa_${intervento.id}">
					 <a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="openModalComunicazione('${utl:encryptData(intervento.id)}','apertura')" > <span class="label label-warning">CHIUSO</span></a></div> 
					
					</c:if> 
				</div>
                </li>
               <li class="list-group-item">
                <b>ID Pacco</b> 
                
                <a target="_blank" class=" btn customTooltip customlink pull-right" href="gestionePacco.do?action=dettaglio&id_pacco=${utl:encryptData(intervento.id_pacco)}">
	
			<c:if test="${intervento.id_pacco!=null && intervento.id_pacco!=0}">
			PC_${intervento.id_pacco }
			</c:if>
			
		</a>
               </li>
        </ul>
        
   
</div>
</div>
</div>
</div>




      
    
      
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Rilievi
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">


<div class="row">

  


<div class="col-sm-3">
    
<label class="pull-left">Totale Quote: </label><br>

<input type="text" id="importo_assegnato" class="form-control pull-left" readonly style="width:100%;text-align:right;">

</div>
</div><br>



 <div class="row">
<div class="col-sm-12">

 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Numero Scheda</th>

<th>Stato Rilievo</th>
<th>Disegno</th>
<th>Variante</th>
<th>Tipo Rilievo</th>
<th>Quote Totali</th>
<th>Pezzi Totali</th>
<th>Tempo scansione (Ore)</th>
<th>Cliente</th>
<th>Sede</th>
<th>Apparecchio</th>
<th>Fornitore</th>
<th>Mese di riferimento</th>
<th>Commessa</th>
<th>Data Inizio Rilievo</th>
<th>Data Consegna</th>
<th>Denominazione</th>
<th>Materiale</th>
<th>Classe di tolleranza</th>
<th>Utente</th>
<th style="min-width:230px">Azioni</th>
<th>Allegati Scheda</th>
<th>Archivio</th>
<th>Scheda Consegna</th>

<th>ID</th>
<th>Note</th>

 </tr></thead>
 
 <tbody>

 
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">

 	

	<tr id="row_${loop.index}" >
		
		<td>${rilievo.numero_scheda }</td>
		<td>
		<c:if test="${rilievo.stato_rilievo.id==1 }">
		<span class="label label-danger">${rilievo.stato_rilievo.descrizione }</span>
		
		</c:if>
		<c:if test="${rilievo.stato_rilievo.id==2  && rilievo.controfirmato == 0 && rilievo.non_lavorato == 0}">
		<span class="label label-warning">${rilievo.stato_rilievo.descrizione }</span>
		</c:if>
		<c:if test="${rilievo.stato_rilievo.id==2  && rilievo.controfirmato == 1 }">
		<span class="label label-success">APPROVATO</span>
		
		</c:if>
		<c:if test="${rilievo.stato_rilievo.id==2  && rilievo.non_lavorato == 1 }">
		<span class="label label-danger">NON LAVORATO</span>
		
		</c:if>
		</td>
		<td>${rilievo.disegno }</td>
		<td>${rilievo.variante }</td>
		<td>${rilievo.tipo_rilievo.descrizione }</td>
		<td>${rilievo.n_quote }</td>
		<td>${rilievo.n_pezzi_tot }</td>
		<td>${rilievo.tempo_scansione }</td>
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.apparecchio }</td>	
		<td>${rilievo.fornitore }</td>
		
			<td>${rilievo.mese_riferimento }</td>
		<td>${rilievo.commessa}</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>	
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_consegna }" /></td>	
		<td>${rilievo.denominazione }</td>
		<td>${rilievo.materiale }</td>
		<td>${rilievo.classe_tolleranza }</td>
		<td>${rilievo.utente.nominativo }</td>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') || (userObj.checkPermesso('VISUALIZZA_RILIEVI_DIMENSIONALI') && rilievo.stato_rilievo.id==2)}">
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${utl:encryptData(rilievo.id)}')"><i class="fa fa-search"></i></a>
		</c:if>
		<c:if test="${ userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<c:choose>
		<c:when test="${rilievo.scheda_consegna == 0 && rilievo.stato_rilievo.id == 1}">
			
			<a href="#" class="btn btn-warning customTooltip" title="Click per modificare il rilievo" onclick="modalModificaRilievoIntervento('${rilievo.id }','${rilievo.data_inizio_rilievo }','${rilievo.tipo_rilievo.id }','${rilievo.id_cliente_util }','${rilievo.id_sede_util }','${rilievo.commessa}',
			'${rilievo.disegno }', '${rilievo.variante }', '${rilievo.fornitore }', '${rilievo.apparecchio }', '${rilievo.data_inizio_rilievo }','${rilievo.mese_riferimento }','${rilievo.cifre_decimali }','${rilievo.classe_tolleranza }','${utl:escapeJS(rilievo.denominazione)}','${rilievo.materiale }','${utl:escapeJS(rilievo.note)}')">		
			<i class="fa fa-edit"></i></a>
			<%-- <a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievo('${rilievo.id}')"><i class="fa fa-clone"></i></a> --%>
			<a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievoModal('${rilievo.id}')"><i class="fa fa-clone"></i></a>
			<%-- <a href="#" class="btn btn-danger customTooltip" title="Click per chiudere il rilievo" onclick="chiudiApriRilievo('${rilievo.id}',2)"><i class="glyphicon glyphicon-remove"></i></a> --%>
			<a href="#" class="btn btn-danger customTooltip" title="Click per chiudere il rilievo" onclick="modalFirmaRilievo('${rilievo.id}',2)"><i class="glyphicon glyphicon-remove"></i></a> 
			<a href="#" class="btn btn-danger customTooltip" title="Click per eliminare il rilievo" onclick="eliminaRilievoModal('${rilievo.id}')"><i class="fa fa-trash"></i></a>
			<a target="_blank" class="btn btn-danger customTooltip" title="Click per creare la scheda del rilievo" href="gestioneRilievi.do?action=crea_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>
		</c:when>
		<c:otherwise>
		<a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievoModal('${rilievo.id}')"><i class="fa fa-clone"></i></a>
		<c:if test="${rilievo.scheda_consegna == 0 }">
		<a href="#" class="btn btn-success customTooltip" title="Click per riaprire il rilievo" onClick="chiudiApriRilievo('${rilievo.id}',1)"><i class="fa fa-unlock"></i></a>
		</c:if>
		</c:otherwise>
		</c:choose>
		</c:if>
		<%-- <a href="#" class="btn btn-success customTooltip" title="Click per creare la scheda excel del rilievo" onclick="callAction('gestioneRilievi.do?action=crea_scheda_rilievo_excel&id_rilievo=${utl:encryptData(rilievo.id)}')"><i class="fa fa-file-excel-o"></i></a> --%>
		<c:if test="${ userObj.checkPermesso('RILIEVI_DIMENSIONALI') && rilievo.stato_rilievo.id==2}">
			<%-- <a  target="_blank" class="btn btn-danger customTooltip" title="Click per creare la scheda del rilievo" href="gestioneRilievi.do?action=crea_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a> --%>
		 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda del rilievo" href="gestioneRilievi.do?action=download_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>
		 <c:if test="${userObj.checkRuolo('AM')  && rilievo.controfirmato==0}">
		 <a  class="btn btn-success customTooltip" title="Click per approvare la scheda rilievo" onClick="modalApprovaRilievo('${rilievo.id}')"><i class="fa fa-check"></i></a>
		 </c:if> 		
		</c:if>
		<c:if test="${ userObj.checkRuolo('RL') && rilievo.controfirmato==1}">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda del rilievo" href="gestioneRilievi.do?action=download_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>
		</c:if>
		
		</td>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<a href="#" class="btn btn-primary customTooltip" title="Click allegare un file" onclick="modalAllegati('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>
		<a href="#" class="btn btn-primary customTooltip" title="Click allegare un certificato campione" onclick="modalCertificatiCampione('${rilievo.id }')"><i class="fa fa-file"></i></a>
		<a href="#" class="btn btn-primary customTooltip" title="Click per inserire un'immagine per il frontespizio" onclick="modalAllegatiImg('${rilievo.id }')"><i class="fa fa-image"></i></a>
		
			<c:if test="${rilievo.allegato!= null && rilievo.allegato !='' }">
				<a target ="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(rilievo.id)}" ><i class="fa fa-file-pdf-o"></i></a>
			</c:if>
			<c:if test="${rilievo.immagine_frontespizio != null && rilievo.immagine_frontespizio != '' }">
				<a class="btn btn-danger customTooltip" title="Click per scaricare l'immagine del frontespizio" onClick="callAction('gestioneRilievi.do?action=download_immagine&id_rilievo=${utl:encryptData(rilievo.id)}')" ><i class="fa fa-arrow-down"></i></a>
			</c:if>
		</c:if>
		</td>
		
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<a href="#" class="btn btn-info customTooltip" title="Click per inserire un file in archivio" onclick="modalAllegatiArchivio('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>		
		<a href="#" class="btn btn-info customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${rilievo.id }')"><i class="fa fa-archive"></i></a>
		</c:if>
		</td>
		<td>
		<c:choose>
		<c:when test="${rilievo.scheda_consegna==1 }">
		SI
		</c:when>
		<c:otherwise>
		NO
		</c:otherwise>
		</c:choose>
		</td>
		<td>${rilievo.id }</td>
		
		<td>${rilievo.note }</td>
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
      
            
            


 







  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 
        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>





  <div id="modalComunicazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">
			<label id="label_chiusura">Vuoi inviare la comunicazione di avvenuta chiusura intervento?</label>
   <label id="label_apertura">Vuoi inviare la comunicazione di avvenuta apertura intervento?</label>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 	<input id="id_int" type="hidden">
 	<input id="apertura_chiusura" type="hidden">
 	
 
 		<button type="button" class="btn btn-primary" onClick="cambiaStatoIntervento($('#id_int').val(), 1)">SI</button>
        <button type="button" class="btn btn-primary"  onClick="cambiaStatoIntervento($('#id_int').val(), 0)">NO</button>
      </div>
    </div>
  </div>
</div>



   <div id="modalStrumenti" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Strumento</h4>
      </div>
       <div class="modal-body">
       <div id="strumenti_content">
       </div>
       
        

  </div>
  		
  		
      <div class="modal-footer">
	<a  class="btn btn-primary" onClick="selezionaStrumento()">Seleziona</a>
       
      </div>
    </div>
  </div>
 </div>

 





<form id="modificaRilievoForm" name="modificaRilievoForm">
<div id="myModalModificaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalModificaRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Rilievo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">     
       	<select class="form-control select2" data-placeholder="Seleziona Cliente..."  aria-hidden="true" data-live-search="true" style="width:100%; display:none" id="cliente_appoggio" name="cliente_appoggio">
	       		<option value=""></option>
	     
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       			       				   			
       				<option value="${cliente.__id}">${cliente.nome }</option>       				
       			
       			</c:forEach>
</select>
       	<input id="mod_cliente" name="mod_cliente" type ="text" class="form-control" style="width:100%">  	
<%--        		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="mod_cliente" name="mod_cliente" style="width:100%" required>
       		<option value=""></option>
       			 <c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach> 
       		</select>     --%>   	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="mod_sede" name="mod_sede" style="width:100%" disabled required>
       		<option value=""></option>
       			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
       				<option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo }</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="mod_commessa" name="mod_commessa" style="width:100%">
       		<option value=""></option>
       			<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       			<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       				<%-- <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option --%>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Disegno</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_disegno" name="mod_disegno" style="width:100%" value=""required>       	
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_denominazione" name="mod_denominazione" style="width:100%">       	
       	</div>
       </div><br>
       
        <div class="row">
        <div class="col-sm-3">
       		<label>Variante</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_variante" name="mod_variante" style="width:100%">       	
       	</div>
       </div><br>
       
       <div class="row">
        <div class="col-sm-3">
       		<label>Materiale</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_materiale" name="mod_materiale" style="width:100%">       	
       	</div>
       </div><br>
       
       
       <div class="row">
       <div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_fornitore" name="mod_fornitore" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       <div class="col-sm-3">
       		<label>Apparecchio</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="mod_apparecchio" name="mod_apparecchio" style="width:100%">       	
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo Rilievo..." id="mod_tipo_rilievo" name="mod_tipo_rilievo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_rilievo }" var="tipo_rilievo" varStatus="loop">
       				<option value="${tipo_rilievo.id}">${tipo_rilievo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Inizio Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' >
               <input type='text' class="form-control input-small" id="mod_data_inizio_rilievo" name="mod_data_inizio_rilievo">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Mese di Riferimento</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group'  id='mese_riferimento'>
       		<select class="form-control select2" data-placeholder="Seleziona Mese Di Riferimento..." id="mod_mese_riferimento" name="mod_mese_riferimento" style="width:100%" >
			  <option value=""></option>
              <option value="Gennaio">Gennaio</option>
              <option value="Febbraio">Febbraio</option>
              <option value="Marzo">Marzo</option>
              <option value="Aprile">Aprile</option>
              <option value="Maggio">Maggio</option>
              <option value="Giugno">Giugno</option>
              <option value="Luglio">Luglio</option>
              <option value="Agosto">Agosto</option>
              <option value="Settembre">Settembre</option>
              <option value="Ottobre">Ottobre</option>
              <option value="Novembre">Novembre</option>
              <option value="Dicembre">Dicembre</option>
                
                </select>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Classe di tolleranza</label>
       	</div>
       	<div class="col-sm-9">
       	      <select class="form-control select2" data-placeholder="Seleziona classe di tolleranza..." id="mod_classe_tolleranza" name="mod_classe_tolleranza" style="width:100%" required>
       		  <option value=""></option>
              <option value="f">f</option>
              <option value="m">m</option>
              <option value="c">c</option>
              <option value="v">v</option>        
              <option value="ISO 130 DIN 16901 A">ISO 130 DIN 16901 A</option>                
              <option value="ISO 130 DIN 16901 B">ISO 130 DIN 16901 B</option>        
             	</select>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Cifre Decimali</label>
       	</div>
       	<div class="col-sm-9">
       		<input type="number" class="form-control" min="0" max="10" id="mod_cifre_decimali" name="mod_cifre_decimali">
       	</div>
       </div><br>    
         <div class="row">
      	<div class="col-xs-3">
      	<label>Note</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<textarea rows="3" style="width:100%" id="mod_note_rilievo" name="mod_note_rilievo"></textarea>
      	</div> 
      	</div>
       
       
       </div>
		<input type="hidden" id="id_rilievo" name= "id_rilievo">
  		 
      <div class="modal-footer">
      <label id="mod_label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <button class="btn btn-primary" type="submit">Modifica</button> 
		
       
      </div>
    </div>
  </div>

</div>
</form>



<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" accept=".pdf,.PDF"  type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 
		   	 <br>
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

<form id="formAllegatiImg" name="formAllegatiImg">
  <div id="myModalAllegatiImg" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Immagine Frontespizio</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_img" accept=".jpg,.gif,.jpeg,.tiff,.png" type="file" name="fileupload_pimg" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label_img"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

      <a class="btn btn-primary" onClick="validateAllegatiImg()">Salva</a>
      </div>
   
  </div>
  </div>
</div>
</form>





  <div id="myModalAllegatiArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Archivio Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.tiff,.png,.doc,.docx,.xls,.xlsx,.dxf,.dwg,.stp,.igs,.iges,.catpart,.eml,.msg,.rar,.zip"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <input type="hidden" id="id_rilievo" name="id_rilievo">
		   	 
		   	 <br>
       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">

     
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Archivio Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div id="tab_archivio"></div>

  		 </div>
  		 </div>
      <div class="modal-footer">
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
      	Sei sicuro di voler eliminare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalClonaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Cerca rilievo da clonare</h4>
      </div>
       <div class="modal-body">       
      	<div class="row" >
      	
      	
      	<div class="col-xs-5">
      	<label>Disegno</label>
      	<input id="disegno_clona" name="disegno_clona" type="text" class="form-control">
      	</div>
      	
      		<div class="col-xs-5">
      		  	<label>Variante</label>
      		<input id="variante_clona" name="variante_clona" type="text" class="form-control">
      	</div> 
      	<div class="col-xs-2">
      		 
      		<a class="btn btn-primary" style="margin-top:25px" onclick="cercaRilievi()" >Cerca</a>
      	</div> 
      	</div><br>
      	<div class="row" id="content_clona" style="display:none">
      	<div class="col-xs-12">
      	<table id="table_rilievi_clona" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
      	 <thead><tr class="active">

		<td></td>
		<th>ID Rilievo</th>
		<th>ID Intervento</th>
		<th>Disegno</th>
		<th>Variante</th>
		<th>Commessa</th>
		<th>Data consegna</th>
		
		
		 </tr></thead>
		 
		 <tbody>
		</tbody>
      	</table>
      	 </div>
      	
      	
      	</div>
      	
      	
      	</div>
      <div class="modal-footer">

<input type="hidden" id="clona_rilievo_id" name="clona_rilievo_id">
	<a class="btn btn-primary" onclick="clonaRilievoTable()" id="btn_clona" style="display:none">Clona Rilievo</a>
      </div>
    </div>
  </div>

</div>

  <div id="myModalCertificatiCampione" class="modal fade" role="dialog" aria-labelledby="myModalCertificatiCampione">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scegli un campione</h4>
      </div>
       <div class="modal-body" id="body_certificati_campione">       
      
      	</div>
      <div class="modal-footer">
     <a class="btn btn-primary" id="aggiungiCertCampione">Salva</a>

      </div>
    </div>
  </div>

</div>


  <div id="myModalFirmaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Sei sicuro di voler chiudere e firmare il rilievo?</h4>
      </div>
       <div class="modal-body">       
      	<div class="row">
      	<div class="col-xs-5"><label>Scegli il tipo chiusura</label></div>
      
      		<div class="col-xs-7">
      		<input type="radio" id="radio_riconsegna" name="radio_riconsegna" checked> <label> Riconsegna<br>al cliente</label><br><br>

      		<input type="radio" id="radio_smaltimento" name="radio_smaltimento" > <label> Smaltimento</label>
      		
      		</div>
      			</div><br>
      			   	<div class="row">
      
      		<div class="col-xs-12">
      		<input type="checkbox" id="check_non_lavorato" name="check_non_lavorato"> <label> Reso non lavorato</label>

      		
      		</div>
      			</div>
      
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="firma_rilievo_id">
      <input type="hidden" id="smaltimento">
      <input type="hidden" id="non_lavorato">
      <a class="btn btn-primary" onclick="chiudiApriRilievo($('#firma_rilievo_id').val(),2, $('#smaltimento').val(),$('#non_lavorato').val())" >Chiudi e Firma</a>
		<a class="btn btn-primary" onclick="$('#myModalFirmaRilievo').modal('hide')" >Annulla</a>
      </div>
    </div>
  </div>

</div>

  <div id="myModalApprovaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler approvare e firmare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="approva_rilievo_id">
      <a class="btn btn-primary" onclick="approvaRilievo($('#approva_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalApprovaRilievo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>





 
     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div> 
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

</jsp:attribute>

<jsp:attribute name="extra_js_footer">


<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

 

 <script type="text/javascript">
 
 
	

	
	
	function openModalComunicazione(id_intervento, apertura_chiusura){
		
		$('#id_int').val(id_intervento);
		
		if(apertura_chiusura == 'apertura'){
			
			$('#apertura_chiusura').val("apertura");
			$('#label_chiusura').hide();
			$('#label_apertura').show();
		}else{
			$('#apertura_chiusura').val("chiusura");
			$('#label_apertura').hide();
			$('#label_chiusura').show();
		}
		
		
		$('#modalComunicazione').modal()
	}
	
	
	function cambiaStatoIntervento(id_intervento, comunicazione){
		
		var x = $('#apertura_chiusura').val();
		
		if($('#apertura_chiusura').val() == 'apertura'){
			apriIntervento('${utl:encryptData(intervento.id)}',0,0, comunicazione, 1)
		}else{
			chiudiIntervento('${utl:encryptData(intervento.id)}',0,0, comunicazione, 1)
		}
		
		
	}
	
	 function formatDate(data){
			
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}
	
	 
	 

    
    
    function approvaRilievo(id_rilievo){
   	 dataObj={};
   	 dataObj.id_rilievo = id_rilievo;
   	pleaseWaitDiv = $('#pleaseWaitDialog');
	 	pleaseWaitDiv.modal();
   	 
   	 callAjax(dataObj,"gestioneRilievi.do?action=approva_rilievo", true);
   	 
    }
    
    
    function modalApprovaRilievo(id_rilievo){
   	
   	 $('#approva_rilievo_id').val(id_rilievo);
        
       $('#myModalApprovaRilievo').modal();
    }
    
    
    
    $('#radio_smaltimento').on('ifClicked', function() {
    	
    	$('#radio_smaltimento').iCheck('check');
    	$('#radio_riconsegna').iCheck('uncheck');
    	$('#smaltimento').val(1);
    	$('#check_non_lavorato')
    	
    });
    
	$('#radio_riconsegna').on('ifClicked', function() {
		$('#radio_riconsegna').iCheck('check');
    	$('#radio_smaltimento').iCheck('uncheck');
    	$('#smaltimento').val(0);
    });	
    
    

/* 	$('#check_non_lavorato').on('ifClicked', function() {
		
		$('#radio_riconsegna').iCheck('check');
    	$('#radio_smaltimento').iCheck('uncheck');
    	$('#smaltimento').val(0);
    });	 */
    
	
	$('#check_non_lavorato').on('ifToggled', function() {
		
		$('#check_non_lavorato').on('ifChecked', function(event){
			$('#non_lavorato').val(1);
		
		});
		
		$('#check_non_lavorato').on('ifUnchecked', function(event) {
			
			$('#non_lavorato').val(0);
		
		});
	})
    
    function modalCertificatiCampione(id_rilievo){
   	 dataString ="rilievi=true&id_rilievo="+id_rilievo;
        exploreModal("listaCampioni.do",dataString,"#body_certificati_campione",function(datab,textStatusb){});
        
       $('#myModalCertificatiCampione').modal();
    }
    
    function clonaRilievoModal(id_rilievo){
   	 
   	 $('#clona_rilievo_id').val(id_rilievo);
   	 $('#myModalClonaRilievo').modal();
    }
    

   	$('#myModalCertificatiCampione').on('hidden.bs.modal', function(){
   		
   		$(document.body).css('padding-right', '0px');
   		$('#tabCampioni').remove();
   		$('#body_certificati_campione').html("");
   		
   		
   	});
    
    function eliminaRilievoModal(id_rilievo){
   	 $('#elimina_rilievo_id').val(id_rilievo);
   	 $('#myModalYesOrNo').modal();
    }
    
    
    function modalFirmaRilievo(id_rilievo){
   	 
   	 $('#firma_rilievo_id').val(id_rilievo);
   	 $('#myModalFirmaRilievo').modal();
   	 
    }
    
    $('#myModalFirmaRilievo').on("hidden.bs.modal", function(){
    	
    	$('#radio_riconsegna').iCheck('check');
    	$('#radio_smaltimento').iCheck('uncheck');
    	$('#smaltimento').val(0);
		$('#check_non_lavorato').iCheck('uncheck');
			
		$('#non_lavorato').val(0);
		
    	
    });
    
    function modalAllegati(id_rilievo){
   	 
   	 $('#id_rilievo').val(id_rilievo);
   	 $('#myModalAllegati').modal();
   }
    
    function modalAllegatiImg(id_rilievo){
   	 
   	 $('#id_rilievo').val(id_rilievo);
   	 $('#myModalAllegatiImg').modal();
   }
    

    function modalSchedaConsegna(){
   	 
   	 if($('#cliente_filtro').val()!="0" && $('#cliente_filtro').val()!=""){
   			
   			var opt = $('#cliente_filtro option[value="'+$('#cliente_filtro').val()+'"]').clone();
   		 	$('#cliente_appoggio').html(opt);
   		 	initSelect2('#cliente_scn');
   		 //	$('#cliente_scn').change();
   		 	//$('#cliente_scn').select2();
   		 	$('#sede_scn').val("0");
   		 	$('#sede_scn').select2();
   	 	} else{
   	 		$('#cliente_appoggio').html(options_cliente);
   	 		initSelect2('#cliente_scn');
   	 		//$('#cliente_scn').val(""); 		
   	 		//$('#cliente_scn').select2();
   	 		$('#sede_scn').html(options_sede);
   	 		$('#sede_scn').val("");
   	 		$('#sede_scn').select2();

   	 	} 
   	 
   	 $('#myModalSchedaConsegna').modal();
    }
    function modalArchivio(id_rilievo){
   	 
   	 $('#tab_archivio').html("");
   	 dataString ="action=lista_file_archivio&id_rilievo="+ id_rilievo;
        exploreModal("gestioneRilievi.do",dataString,"#tab_archivio",function(datab,textStatusb){
        });
   $('#myModalArchivio').modal();
    }
    
    function modalAllegatiArchivio(id_rilievo){
   	 
   	 $('#fileupload').fileupload({
   		 url: "gestioneRilievi.do?action=allegati_archivio&id_rilievo="+id_rilievo,
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
   		     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx|dxf|dwg|stp|igs|iges|catpart|eml|msg|rar|zip)$/i;
   		     
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
   	 $('#myModalAllegatiArchivio').modal();
   }
    
    
    
    

	$("#fileupload_pdf").change(function(event){		
		
        if ($(this).val().split('.').pop()!= 'pdf' && $(this).val().split('.').pop()!= 'PDF') {
        	        
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
	
	$("#fileupload_img").change(function(event){
		
		var fileExtension = 'jpg';
		var fileExtension2 = 'JPG';
        if ($(this).val().split('.').pop()!= fileExtension && $(this).val().split('.').pop()!= fileExtension2) {        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci un'immagine .jpg!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_img')[0].files[0].name;
       	 $('#filename_label_img').html(file );
        }
        		
	});
	
	
	 function validateAllegati(){
		var filename = $('#fileupload_pdf').val();
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegatiRilievi($('#filtro_rilievi').val(), $('#cliente_filtro').val());
		}
	} 

	
	function validateAllegatiImg(){
		var filename = $('#fileupload_img').val();
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegatiRilieviImg($('#filtro_rilievi').val(), $('#cliente_filtro').val());
		}
	}
	
    
    
    
    
    
    
    
    
    
    
    
    function modalNuovoRilievo(){
   	// $('#cliente').select2();
   	
   	 if($('#cliente_filtro').val()!="0" && $('#cliente_filtro').val()!=""){
   			
   			var opt = $('#cliente_filtro option[value="'+$('#cliente_filtro').val()+'"]').clone();
   			
   		 	$('#cliente_appoggio').html(opt);
   		 //	$('#cliente').change();
   			initSelect2('#cliente');

   		 	//$('#cliente').select2();
   		 	$('#sede').val("0");
   		 	$('#sede').select2();
   	 	} else{
   	 		$('#cliente_appoggio').html(options_cliente);
   	 		$('#cliente').val("");
   	 		initSelect2('#cliente');

   	 		//$('#cliente').select2();
   	 		$('#sede').html(options_sede);
   	 		$('#sede').val("");
   	 		$('#sede').select2();

   	 	} 
   	 $('#commessa').val('');
   	 $('#commessa').change();
   	 $('#disegno').val('');
   	 $('#denominazione').val('');
   	 $('#variante').val('');
   	 $('#materiale').val('');
   	 $('#fornitore').val('');
   	 $('#apparecchio').val('');
   	 $('#tipo_rilievo').val('');
   	 $('#tipo_rilievo').change();
   	 $('#data_inizio_rilievo').val('');
   	 $('#mese_riferimento').val('');
   	 $('#mese_riferimento').change();
   	 $('#note_rilievo').val('');
   	 
   	 $('#myModalNuovoRilievo').modal();
    }
    
    function dettaglioRilievo(id_rilievo) {
   	
   	 var cliente = '${utl:encryptData(cliente_filtro)}';
   	  var filtro = '${utl:encryptData(filtro_rilievi)}';

    	 //dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+$('#cliente_filtro').val()+"&filtro_rilievi=" +$('#filtro_rilievi').val();
   	 dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+cliente+"&filtro_rilievi="+filtro; 
    	 
   	  callAction("gestioneRilievi.do"+dataString, false, false);
    }

   	var columsDatatables = [];
   	 
   	$("#tabRilievi").on( 'init.dt', function ( e, settings ) {
   	    var api = new $.fn.dataTable.Api( settings );
   	    var state = api.state.loaded();
   	 
   	    if(state != null && state.columns!=null){
   	    		console.log(state.columns);
   	    
   	    columsDatatables = state.columns;
   	    }
   	    $('#tabRilievi thead th').each( function () {
   	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
   	    	  var title = $('#tabRilievi thead th').eq( $(this).index() ).text();
   	    	
   	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
   	    	
   	    	} );
   	    
   	    

   	} );
   	

   	
       
    var ril;
    var commessa_options;
    
   $(document).ready(function() {
   	

	   commessa_options = $('#mod_commessa option').clone();
    var anno_riferimento = "${anno_riferimento}";

   	initSelect2('#mod_cliente');
    // 	initSelect2('#cliente_scn');
     	
     	
     	$('#mod_sede').select2();
     	$('#mod_commessa').select2();
     	$('#mod_tipo_rilievo').select2();
     	$('#mod_mese_riferimento').select2();
     	$('#mod_classe_tolleranza').select2();  	

     	
        $('#anno').val(anno_riferimento);
        $('#anno').change();
   	
   	 commessa_options = $('#commessa option').clone();
   	//$('#body_certificati_campione').html("");
   	 $('#label').hide();
   	// $('.select2').select2();
   /* 	 $('#cliente').select2({
   		 dropdownParent: $('#myModalNuovoRilievo'),
   		 }); */

   	 $('#cliente').css("text-align", "left");
   	 $('#sede').select2({
   		dropdownParent: $('#myModalNuovoRilievo')
   	 	});
   /* 	 $('#mod_cliente').select2({
   		dropdownParent: $('#myModalModificaRilievo')
   	 	}); */
   	 $('#mod_sede').select2({
   	  	dropdownParent: $('#myModalModificaRilievo')
   		 }); 
   		 
   	 $('#mod_label').hide();
   	 $('.datepicker').datepicker({
   		 format: "dd/mm/yyyy"
   	 });
   	 
   	 $('.dropdown-toggle').dropdown();
   	 

   	 table = $('#tabRilievi').DataTable({
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

   		    	  { responsivePriority: 1, targets: 1 },
   		    	  { responsivePriority: 2, targets: 20 }
   		               ], 	        
   	  	      buttons: [   
   	  	          {
   	  	            extend: 'colvis',
   	  	            text: 'Nascondi Colonne'  	                   
   	 			  } ]
   		               
   		    });
   		
   		table.buttons().container().appendTo( '#tabRilievi_wrapper .col-sm-6:eq(1)');
   	 	    $('.inputsearchtable').on('click', function(e){
   	 	       e.stopPropagation();    
   	 	    });

   	table.columns().eq( 0 ).each( function ( colIdx ) {
   	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
   	      table
   	          .column( colIdx )
   	          .search( this.value )
   	          .draw();
   	  } );
   	} ); 
   		table.columns.adjust().draw();
   		

   	$('#tabRilievi').on( 'page.dt', function () {
   		$('.customTooltip').tooltipster({
   	        theme: 'tooltipster-light'
   	    });
   		
   		$('.removeDefault').each(function() {
   		   $(this).removeClass('btn-default');
   		})

   	});
   	
   	$('#tabRilievi').DataTable().order([23, "desc"]).draw();
   	
   	contaImportoTotale(table);

   	table.on( 'search.dt', function () {
   		contaImportoTotale(table);
   	} );
   	
   	
   	
   	
   	
    table_rilievi_clona = $('#table_rilievi_clona').DataTable({
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
	        "order": [[ 1, "desc" ]],
		      paging: false, 
		      ordering: false,
		      info: false, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: false,	
		      "searching": false,
		      select: {
		        	style:    'single',
		        	selector: 'td:nth-child(1)'
		    	},
		      columns : [


				{"data" : "select"},	
		      	{"data" : "id"},	
		      	{"data" : "id_intervento"},
		      	{"data" : "disegno"},
		      	{"data" : "variante"},
		      	{"data" : "commessa"},
		      	{"data" : "data_consegna"}
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { className: "select-checkbox", targets: 0,  orderable: false }
		    	  ],
		    	  
		     	          
	  	 
		               
		    });

   	
	$('#table_rilievi_clona thead th').each( function () {
		var title = $('#table_rilievi_clona thead th').eq( $(this).index() ).text();
		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	} );
	
	
	table_rilievi_clona.buttons().container().appendTo( '#table_rilievi_clona_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	   table_rilievi_clona.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', table_rilievi_clona.column( colIdx ).header() ).on( 'keyup', function () {
	  table_rilievi_clona
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} ); 
   	
   });





   $("#cliente").change(function() {
   	  
   	  if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#sede option').clone());
   	  }
   	  
   	  var selection = $(this).val()	 
   	  var id = selection
   	  var options = $(this).data('options');

   	  var opt=[];
   	
   	  opt.push("<option value = 0>Non Associate</option>");

   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 

   		if(str.substring(str.indexOf("_")+1, str.length)==id)
   		{

   			opt.push(options[i]);
   		}   
   	   }
   	 $("#sede").prop("disabled", false);
   	 
   	  $('#sede').html(opt);
   	  
   	  $("#sede").trigger("chosen:updated");	  
   	
   		$("#sede").change();  

   /* 		var id_cliente = selection.split("_")[0];
   		  
   		
   		  var options = commessa_options;
   		  var opt=[];
   			opt.push("");
   		   for(var  i=0; i<options.length;i++)
   		   {
   			var str=options[i].value; 		
   			
   			if(str.split("*")[1] == id_cliente||str.split("*")[2]==id_cliente)	
   			{

   				opt.push(options[i]);
   			}   
   	    
   		   } 
   		$('#commessa').html(opt);
   		$('#commessa').val("");
   		$("#commessa").change();   */	  
   	
   	});
   	
   	
   	
   $("#sede").change(function(){
   	
   	
   	var id_cliente = $('#cliente').val().split("_")[0];
   	  var id_sede = $(this).val().split("_")[0];	 
   	
   	  var options = commessa_options;
   	  var opt=[];
   		opt.push("");
   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 		
   		
   		var id_util;
   		if(str.split("*").length>2){
   			id_util = str.split("*")[2].split("@")[0];
   		}else{
   			id_util = str.split("*")[1];
   		}
   		
   		if((str.split("*")[1] == id_cliente||id_util==id_cliente) && (str.split("@")[1] == id_sede || str.split("@")[2] == id_sede))	
   		{

   			opt.push(options[i]);
   		}   
     
   	   } 
   	$('#commessa').html(opt);
   	$('#commessa').val("");
   	$("#commessa").change();  
   });  
   	

   $("#mod_cliente").change(function() {
   	  
   	  if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#mod_sede option').clone());
   	  }
   	  
   	  var selection = $(this).val()	 
   	  var id = selection
   	  var options = $(this).data('options');

   	  var opt=[];
   	
   	  opt.push("<option value = 0>Non Associate</option>");

   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 
   	
   		//if(str.substring(str.indexOf("_")+1,str.length)==id)
   		if(str.substring(str.indexOf("_")+1, str.length)==id)
   		{

   			opt.push(options[i]);
   		}   
   	   }
   	 $("#mod_sede").prop("disabled", false);
   	 
   	  $('#mod_sede').html(opt);
   	  
   	  $("#mod_sede").trigger("chosen:updated");

   		$("#mod_sede").change();  

   		
   	
   	});
   	

   $("#mod_sede").change(function(){
   	
   	
   	var id_cliente = $('#mod_cliente').val().split("_")[0];
   	  var id_sede = $(this).val().split("_")[0];	 
   	
   	  var options = commessa_options;
   	  var opt=[];
   		opt.push("");
   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 		
   		
   		var id_util;
   		if(str.split("*").length>2){
   			id_util = str.split("*")[2].split("@")[0];
   		}else{
   			id_util = str.split("*")[1];
   		}
   		
   		if((str.split("*")[1] == id_cliente||id_util==id_cliente) && (str.split("@")[1] == id_sede || str.split("@")[2] == id_sede))	
   		{

   			opt.push(options[i]);
   		}   
     
   	   } 

   });
   	
 

   $('#myModalArchivio').on('hidden.bs.modal', function(){
   	$(document.body).css('padding-right', '0px');	
   });

   $('#myModalError').on('hidden.bs.modal', function(){
   	$(document.body).css('padding-right', '0px');	
   });


   function contaImportoTotale(table){
   	
   	//var table = $("#tabPM").DataTable();
   	
   	var data = table
        .rows({ search: 'applied' })
        .data();
   	var somma = 0.0;
   	for(var i=0;i<data.length;i++){	
   		var num = parseFloat(stripHtml(data[i][5]));
   		somma = somma + num;
   	}
   	$('#importo_assegnato').val(somma);
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
   
   
   
   
   
   
   
   
   
   
   function modalModificaRilievoIntervento(id_rilievo, data_rilievo, tipo_rilievo, id_cliente, id_sede, commessa, disegno, variante, fornitore, apparecchio, data_inizio_rilievo, mese_riferimento,cifre_decimali, classe_tolleranza, denominazione, materiale, note){
		  

	  			$('#mod_cliente').val(id_cliente);   
	  	 
			  $('#mod_cliente').change();
			  
			  if(id_sede!='0'){
				  $('#mod_sede').val(id_sede+"_"+id_cliente);
			  }else{
				  $('#mod_sede').val(id_sede);
			  }
			  
			  $('#mod_sede').change();
			  $('#mod_tipo_rilievo').val(tipo_rilievo);
			  $('#mod_tipo_rilievo').change();
			  $('#mod_commessa').val(commessa);
			  $('#mod_commessa').change();		  
			  $('#mod_disegno').val(disegno);
			  $('#mod_variante').val(variante);
			  $('#mod_fornitore').val(fornitore);
			  $('#mod_apparecchio').val(apparecchio);
			  $('#mod_cifre_decimali').val(cifre_decimali);
			  $('#mod_materiale').val(materiale);
			  $('#mod_denominazione').val(denominazione);
			  if(data_inizio_rilievo!=null && data_inizio_rilievo!=""){
				  $('#mod_data_inizio_rilievo').val(Date.parse(data_inizio_rilievo).toString("dd/MM/yyyy"));
			  }
			  $('#mod_mese_riferimento').val(mese_riferimento);
			  $('#mod_mese_riferimento').change();
			  $('#mod_classe_tolleranza').val(classe_tolleranza);
			  $('#mod_classe_tolleranza').change();
			  $('#mod_note_rilievo').val(note)
			  
			  $('#id_rilievo').val(id_rilievo);
			  initSelect2('#mod_cliente');
			  
			  $('#myModalModificaRilievo').modal();
			  
		  }
   
   $('#modificaRilievoForm').on('submit', function(e){
		 e.preventDefault();
		 modificaRilievo();
	});
   
   var validator2 = $("#modificaRilievoForm").validate({

    	showErrors: function(errorMap, errorList) {
    	  	
    	    this.defaultShowErrors();
    	    if($('#mod_cliente').hasClass('has-error')){
				$('#mod_cliente').css('background-color', '1px solid #f00');
			}
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#mod_label").show();
    		 },
    		 
    		    highlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
    		    	}else{
    		    		$(element).css('border', '1px solid #f00');    		        
    		    	}    		        
    		    	$('#mod_label').show();
    		    },
    		    unhighlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
    		    	}else{
    		    		$(element).css('border', '1px solid #d2d6de');
    		    	}
    		    	
    		    }
    }); 
   
   
   
   
   function cercaRilievi(){
	   $('#content_clona').hide();
	   $('#btn_clona').hide();
	   var obj = {};
	   obj.disegno_clona = $('#disegno_clona').val();
	   obj.variante_clona = $('#variante_clona').val();
	   
	   callAjax(obj, "gestioneRilievi.do?action=cerca_rilievi", function(data){
		  
		   if(data.success){
			   var table_data = [];
			   var result = data.lista_rilievi   
			
		 		  for(var i = 0; i<result.length;i++){
		  			  var dati = {};
		  			  
		  			  
		  			  dati.select = '<td></td>';		  		
		  			  dati.id = result[i].id;
		  			  if(result[i].intervento!=null){
		  				dati.id_intervento = result[i].intervento.id;  
		  			  }else{
		  				dati.id_intervento = "";
		  			  }
		  			  
		  			dati.disegno = result[i].disegno;
		  			dati.variante = result[i].variante;
		  			dati.commessa = result[i].commessa;
		  			if(result[i].data_consegna!=null){
		  				dati.data_consegna = result[i].data_consegna;	
		  			}else{
		  				dati.data_consegna = "";
		  			}
		  			
		  			  
		  			  table_data.push(dati);
		  			
		  		  }
			   
			   
			   var table = $('#table_rilievi_clona').DataTable();
		  		  
	   		   table.clear().draw();
	   		   
	   			table.rows.add(table_data).draw();
	   			
	   			table.columns.adjust().draw();
	 			
	   			$('#table_rilievi_clona tr').each(function(){
	   				var val  = $(this).find('td:eq(1)').text();
	   				$(this).attr("id", val)
	   			});
	   			
	   			$('#content_clona').show();
	   			$('#btn_clona').show();
		   }
		   
		   
		   
	   });
	   
   }

   
   
   function clonaRilievoTable(){

		  
		  var table = $('#table_rilievi_clona').DataTable();
			var dataSelected = table.rows( { selected: true } ).data();

	var id_rilievo = dataSelected[0].id;
			console.log(dataSelected);
			var id_rilievo_new = $('#clona_rilievo_id').val()
			
		
			if(id_rilievo != null && id_rilievo==""){
				
					$('#myModalErrorContent').html("Seleziona un rilievo da clonare!");
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");	  
		
					$('#myModalError').modal('show')
			}else{
				clonaRilievo(id_rilievo,id_rilievo_new, "${intervento.id}")	;		
			}
			table.rows().deselect();
			
		}
   
  </script>
</jsp:attribute> 
</t:layout>







