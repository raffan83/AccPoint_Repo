<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
      Configurazioni Invio Email 
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	Lista Configurazioni
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<ul class="nav nav-tabs" role="tablist">
    <li class="active" role="presentation">
        <a href="#listaConfPeriodiche" data-toggle="tab" role="tab"
           id="tabConfPeriodiche" aria-controls="listaConfPeriodiche">Lista Conf Periodiche</a>
    </li>
    <li role="presentation">
        <a href="#listaConfEfficacia" data-toggle="tab" role="tab"
           id="tabConfEfficacia" aria-controls="listaConfEfficacia">Lista Conf Efficacia</a>
    </li>
</ul>

<div class="tab-content" style="padding-top: 15px;">
<div id="listaConfPeriodiche" class="tab-pane active" role="tabpanel" aria-labelledby="tabConfPeriodiche">
<div class="row">
<div class="col-xs-12">



<button type="button" class="btn btn-primary pull-right" onclick="modalnuovaConfigurazione()"><i class="fa fa-plus"></i> Nuova Configurazione</button> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForConf" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Corso</th>
<th>Gruppo</th>
<th>ID Corso</th>
<th>ID Gruppo</th>
<th>Data inizio invio</th>
<th>Frequenza (Giorni)</th>
<th>Data prossimo invio</th>
<th>Data scadenza</th>
<th>Stato invio</th>
<th>Report Vittoria</th>
<th>Codice corso Vittoria</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_configurazioni }" var="configurazione" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${configurazione.id }</td>	
	<td>${configurazione.descrizione_corso }</td>
	<td>${configurazione.descrizione_gruppo }</td>
	<td>${configurazione.id_corso }</td>
	<td>${configurazione.id_gruppo }</td>

		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_inizio_invio }"></fmt:formatDate></td>
	<td>${configurazione.frequenza_invio}</td>	
		
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_prossimo_invio }"></fmt:formatDate></td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_scadenza }"></fmt:formatDate></td>
		<td>
		<c:if test="${configurazione.stato_invio == 0}">In corso</c:if>
		<c:if test="${configurazione.stato_invio == 1 }">Comunicazione inviata</c:if>
		<c:if test="${configurazione.stato_invio == 2}">Scaduta</c:if>
		</td>
	<c:if test="${configurazione.report_vittoria==0 }">
	<td align="center">
	<input type="checkbox" class="icheckbox" disabled="disabled" >
	</td>
	</c:if>
	
	<c:if test="${configurazione.report_vittoria==1 }">
	<td align="center">
	<input type="checkbox" checked class="icheckbox" disabled="disabled">
	</td>
	</c:if>
	
	<td>${configurazione.codiceCorsoVittoria}</td>
		
	<td>
 	
	<a  class="btn btn-warning" onClicK="modificaConfigurazioneModal('${configurazione.id}','${configurazione.id_corso}','${configurazione.id_gruppo}','${configurazione.data_inizio_invio}','${configurazione.frequenza_invio }','${configurazione.data_prossimo_invio}','${configurazione.stato_invio }','${configurazione.data_scadenza}','${utl:escapeJS(configurazione.oggetto_email) }','${utl:escapeJS(configurazione.testo_email) }','${configurazione.report_vittoria}','${configurazione.codiceCorsoVittoria}')" title="Click per modificare la Configurazione"><i class="fa fa-edit"></i></a>
	<a  class="btn btn-danger" onClicK="eliminaConfigurazioneModal('${configurazione.id}')" title="Click per eliminare la configurazione"><i class="fa fa-trash"></i></a>

	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
</div>

<div id="listaConfEfficacia" class="tab-pane" role="tabpanel" aria-labelledby="tabConfEfficacia">
    <div class="row">
        <div class="col-xs-12">
            <a class="btn btn-primary pull-right" onClicK="modalnuovaConfigurazioneEff()"><i class="fa fa-plus"></i> Nuova Configurazione</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-sm-12">
            <table id="tabForConfEff" class="table table-bordered table-hover dataTable table-striped" width="100%">
                <thead>
                    <tr class="active">
                        <th>ID</th>
                        <th>Corso</th>
                        <th>Gruppo</th>
                        <th>ID Corso</th>
                        <th>ID Gruppo</th>
                        <th>Data inizio invio</th>
                        <th>Data scadenza</th>
                        <th class="no-column-search" style="width: 100px;">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${lista_configurazioni_eff}" var="configurazioneEff">
                        <fmt:formatDate value="${configurazioneEff.data_inizio_invio}" pattern="yyyy-MM-dd" var="inizioEffOrdine" />
                        <fmt:formatDate value="${configurazioneEff.data_scadenza}" pattern="yyyy-MM-dd" var="scadenzaEffOrdine" />
                        <tr>
                            <td>${configurazioneEff.id}</td>
                            <td><c:out value="${configurazioneEff.descrizione_corso}" /></td>
                            <td><c:out value="${configurazioneEff.descrizione_gruppo}" /></td>
                            <td>${configurazioneEff.id_corso}</td>
                            <td>${configurazioneEff.id_gruppo}</td>
                            <td data-order="${inizioEffOrdine}"><fmt:formatDate value="${configurazioneEff.data_inizio_invio}" pattern="dd/MM/yyyy" /></td>
                            <td data-order="${scadenzaEffOrdine}"><fmt:formatDate value="${configurazioneEff.data_scadenza}" pattern="dd/MM/yyyy" /></td>
                            <td>
                                <fmt:formatDate value="${configurazioneEff.data_inizio_invio}" pattern="dd/MM/yyyy" var="inizioEff" />
                                <fmt:formatDate value="${configurazioneEff.data_scadenza}" pattern="dd/MM/yyyy" var="scadenzaEff" />
                                <a class="btn btn-warning" onClicK="modificaConfigurazioneModalEff('${configurazioneEff.id}','${configurazioneEff.id_corso}','${configurazioneEff.id_gruppo}','${inizioEff}','${scadenzaEff}','${utl:escapeJS(configurazioneEff.oggetto_email)}','${utl:escapeJS(configurazioneEff.testo_email)}')" title="Click per modificare la Configurazione" aria-label="Modifica configurazione efficacia"><i class="fa fa-edit" aria-hidden="true"></i></a>
                                <a class="btn btn-danger" onClicK="eliminaConfigurazioneModalEff('${configurazioneEff.id}')" title="Click per eliminare la configurazione" aria-label="Elimina configurazione efficacia"><i class="fa fa-trash" aria-hidden="true"></i></a>
                            </td>
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
</div>
</div>
</section>





<form id="nuovaConfigurazioneForm" name="nuovoDocenteForm">
<div id="myModalnuovaConfigurazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Configurazione Invio Email</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi" name="corsi" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." onchange="getGruppiFromCorso()">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}">${corso.descrizione }</option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi" name="gruppi" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." disabled onchange="getMembriGruppo()">

       </select>
       			
       	</div>       	
       </div><br>
       
       
      <div class="row" style="display:none" id="content_membri">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody id="body_membri">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>
       

       		

       
       		
       		
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Giorni)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
   
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio_invio" name="data_inizio_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_prossimo_invio" name="data_prossimo_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Oggetto email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
     
               <input type='text' class="form-control" id="oggetto_email" name="oggetto_email" required>
     
       			
       	</div>       	
       </div><br>
       
                        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Report Vittoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
     
               <input type='checkbox' class="form-control" id="report_vittoria" name="report_vittoria" >
     
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Corso Vittoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	<input type='text' class="form-control" id="codice_corso_vittoria" name="codice_corso_vittoria" >
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Testo email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
     
               <textarea class="form-control" rows="5" style="width:100%" id="testo_email" name="testo_email" ></textarea>
    
       			
       	</div>       	
       </div><br>
       
       
       </div>
  		 
      <div class="modal-footer">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>





<form id="nuovaConfigurazioneFormEff" name="nuovaConfigurazioneFormEff">
<div id="myModalnuovaConfigurazioneEff" class="modal fade" role="dialog" aria-labelledby="myModalnuovaConfigurazioneEffLabel">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalnuovaConfigurazioneEffLabel">Nuova Configurazione Invio Email Efficacia</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi_eff" name="corsi" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." required onchange="getGruppiFromCorsoEff()">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}"><c:out value="${corso.descrizione}" /></option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi_eff" name="gruppi" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." required disabled onchange="getMembriGruppoEff()">

       </select>
       			
       	</div>       	
       </div><br>

      <div class="row" style="display:none" id="content_membri_eff">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Data completamento test</th>
            <th>Data prossimo invio</th>
        </tr>
    </thead>
    <tbody id="body_membri_eff">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>

       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      

         <div class='input-group date datepicker'>
               <input type='text' class="form-control input-small" id="data_inizio_invio_eff" name="data_inizio_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      

         <div class='input-group date datepicker'>
               <input type='text' class="form-control input-small" id="data_scadenza_eff" name="data_scadenza">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Oggetto email</label>
       	</div>
       	<div class="col-sm-9">      

               <input type='text' class="form-control" id="oggetto_email_eff" name="oggetto_email" required>

       	</div>       	
       </div><br>

         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Testo email</label>
       	</div>
       	<div class="col-sm-9">      

               <textarea class="form-control" rows="5" style="width:100%" id="testo_email_eff" name="testo_email" ></textarea>

       	</div>       	
       </div><br>

       </div>
  		 
      <div class="modal-footer">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

<form id="modificaConfigurazioneFormEff" name="modificaConfigurazioneFormEff">
<div id="myModalModificaConfigurazioneEff" class="modal fade" role="dialog" aria-labelledby="myModalModificaConfigurazioneEffLabel">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalModificaConfigurazioneEffLabel">Modifica Configurazione Invio Email Efficacia</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi_eff_mod" name="corsi" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." required onchange="getGruppiFromCorsoEff('mod')">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}"><c:out value="${corso.descrizione}" /></option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi_eff_mod" name="gruppi" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." required disabled onchange="getMembriGruppoEff('mod')">

       </select>
       			
       	</div>       	
       </div><br>

      <div class="row" style="display:none" id="content_membri_eff_mod">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Data completamento test</th>
            <th>Data prossimo invio</th>
        </tr>
    </thead>
    <tbody id="body_membri_eff_mod">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>

       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      

         <div class='input-group date datepicker'>
               <input type='text' class="form-control input-small" id="data_inizio_invio_eff_mod" name="data_inizio_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      

         <div class='input-group date datepicker'>
               <input type='text' class="form-control input-small" id="data_scadenza_eff_mod" name="data_scadenza">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Oggetto email</label>
       	</div>
       	<div class="col-sm-9">      

               <input type='text' class="form-control" id="oggetto_email_eff_mod" name="oggetto_email" required>
       			
       	</div>       	
       </div><br>

       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Testo email</label>
       	</div>
       	<div class="col-sm-9">      

               <textarea class="form-control" rows="5" style="width:100%" id="testo_email_eff_mod" name="testo_email" ></textarea>

       	</div>       	
       </div><br>

       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_configurazione_eff" name="id_configurazione"> 
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

  <div id="myModalYesOrNoEff" class="modal fade" role="dialog" aria-labelledby="titoloEliminaConfigurazioneEff">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="titoloEliminaConfigurazioneEff">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare la configurazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_configurazione_eff_id">
      <a class="btn btn-primary" onclick="eliminaConfigurazioneEff()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNoEff').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="modificaConfigurazioneForm" name="modificaConfigurazioneForm">
<div id="myModalModificaConfigurazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Tipologia Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi_mod" name="corsi_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." onchange="getGruppiFromCorso('mod')">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}">${corso.descrizione }</option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi_mod" name="gruppi_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." onchange="getMembriGruppo('mod')">

       </select>
       			
       	</div>       	
       </div><br>
       
       
      <div class="row" style="display:none" id="content_membri_mod">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody id="body_membri_mod">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>
       

       		

       
       		
       		
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Giorni)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
   
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio_invio_mod" name="data_inizio_invio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_prossimo_invio_mod" name="data_prossimo_invio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       
              
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Oggetto email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
     
               <input type='text' class="form-control" id="oggetto_email_mod" name="oggetto_email_mod" required>
     <input type='hidden' id="id_gruppo_mod">
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Report Vittoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_report_vittoria_mod" name="check_report_vittoria_mod" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Corso Vittoria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	<input type='text' class="form-control" id="codice_corso_vittoria_mod" name="codice_corso_vittoria_mod" >
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Testo email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
     
               <textarea class="form-control" rows="5" style="width:100%" id="testo_email_mod" name="testo_email_mod" ></textarea>
    
       			
       	</div>       	
       </div><br>
       
       
       
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_configurazione" name="id_configurazione"> 
		<input type="hidden" id="report_vittoria_mod" name="report_vittoria_mod">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
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
      	Sei sicuro di voler eliminare la configurazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_configurazione_id">
      <a class="btn btn-primary" onclick="eliminaConfigurazione($('#elimina_configurazione_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>






</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />
<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>

<script type="text/javascript">


function modalnuovaConfigurazione(){
	

	
	
	$('#myModalnuovaConfigurazione').modal();
	 
	
}

function eliminaConfigurazioneModal(id_conf){
	
	$('#elimina_configurazione_id').val(id_conf)
	
	$('#myModalYesOrNo').modal();
	
}

function eliminaConfigurazione(){
	
	dataObj = {};
	dataObj.id_configurazione_elimina = $('#elimina_configurazione_id').val();
	
	callAjax(dataObj, "gestioneFormazione.do?action=elimina_configurazione");
	
}


var editorInstanceMod = null;


function modificaConfigurazioneModal(id_configurazione, id_corso, id_gruppo, data_inizio, frequenza, data_prossimo_invio, stato, data_scadenza, oggetto_email, testo_email,report_vittoria,codiceCorsoVittoria) {
    
	$('#id_gruppo_mod').val(id_gruppo);
	$('#id_configurazione').val(id_configurazione);
    $('#corsi_mod').val(id_corso);
    $('#corsi_mod').change()
    //$('#gruppi_mod').val(id_gruppo);
  //  $('#gruppi_mod').change()
    $('#oggetto_email_mod').val(oggetto_email);
    $('#codice_corso_vittoria_mod').val(codiceCorsoVittoria);
    if(report_vittoria =='1'){	

		$('#check_report_vittoria_mod').iCheck('check');
		$('#report_vittoria_mod').val(1); 

	}else{
		$('#check_report_vittoria_mod').iCheck('uncheck');
		$('#report_vittoria_mod').val(0);

	}
    
    
    $('#testo_email_mod').val(testo_email);
    $('#frequenza_mod').val(frequenza);
    $('#data_inizio_invio_mod').val(Date.parse(data_inizio).toString("dd/MM/yyyy"));
    $('#data_prossimo_invio_mod').val(Date.parse(data_prossimo_invio).toString("dd/MM/yyyy"));

    if (data_scadenza != null && data_scadenza != '') {
        $('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
    }
    if (!editorInstanceMod) {
        ClassicEditor
            .create(document.querySelector('#testo_email_mod'))
            .then(editor => {
                editorInstanceMod = editor;
            })
            .catch(error => {
                console.error('Errore durante l\'inizializzazione di CKEditor:', error);
            });
    }else {
        // Se l'editor è già stato creato, aggiorna il contenuto
        editorInstanceMod.setData(testo_email);
    }

}

$('#check_report_vittoria_mod').on('ifClicked',function(e){
	if($('#check_report_vittoria_mod').is( ':checked' )){
		$('#check_report_vittoria_mod').iCheck('uncheck');
		$('#report_vittoria_mod').val(0); 
	}else{
		$('#check_report_vittoria_mod').iCheck('check');
		$('#report_vittoria_mod').val(1); 
	}
});



var editorInstanceEff = null;
var editorInstanceModEff = null;

function modalnuovaConfigurazioneEff() {
    $('#myModalnuovaConfigurazioneEff').modal();
}

function modificaConfigurazioneModalEff(id_configurazione, id_corso, id_gruppo, data_inizio,
                                        data_scadenza, oggetto_email, testo_email) {
    $('#id_configurazione_eff').val(id_configurazione);
    $('#data_inizio_invio_eff_mod').val(data_inizio);
    $('#data_scadenza_eff_mod').val(data_scadenza);
    $('#oggetto_email_eff_mod').val(oggetto_email);
    $('#testo_email_eff_mod').val(testo_email);
    if (editorInstanceModEff) {
        editorInstanceModEff.setData(testo_email);
    }
    $('#myModalModificaConfigurazioneEff').modal();
    $('#corsi_eff_mod').val(id_corso).trigger('change.select2');
    getGruppiFromCorsoEff('mod', id_gruppo);
}

function eliminaConfigurazioneModalEff(id_conf) {
    $('#elimina_configurazione_eff_id').val(id_conf);
    $('#myModalYesOrNoEff').modal();
}

function eliminaConfigurazioneEff() {
    var dataObj = {
        id_configurazione_elimina: $('#elimina_configurazione_eff_id').val()
    };
    callAjax(dataObj, 'gestioneFormazione.do?action=elimina_configurazione_eff');
}

function getGruppiFromCorsoEff(mod, id_gruppo) {
    var suffisso = mod === 'mod' ? '_eff_mod' : '_eff';
    var corso = $('#corsi' + suffisso).val();
    var $gruppi = $('#gruppi' + suffisso);
    var richiesta = ($gruppi.data('richiestaGruppi') || 0) + 1;
    $gruppi.data('richiestaGruppi', richiesta);
    $gruppi.empty().prop('disabled', true).trigger('change');

    if (!corso) {
        return;
    }

    callAjax({ corso: corso }, 'gestioneFormazione.do?action=gruppi_corso', function (data) {
        if (richiesta !== $gruppi.data('richiestaGruppi') || !data.success) {
            return;
        }

        $gruppi.append(new Option('', ''), new Option('Nessun gruppo specificato', '0'));
        $.each(data.gruppi, function (indice, gruppo) {
            $gruppi.append(new Option(gruppo.descrizione, gruppo.id));
        });
        $gruppi.val(id_gruppo == null ? '' : String(id_gruppo)).prop('disabled', false).trigger('change');
    });
}

function aggiungiFiltriConfigurazioni(api) {
    api.columns().every(function () {
        var colonna = this;
        var $intestazione = $(colonna.header());
        if ($intestazione.hasClass('no-column-search')) {
            return;
        }
        var titolo = $intestazione.text().trim();

        $('<input>', {
            type: 'text',
            'class': 'inputsearchtable',
            'aria-label': 'Cerca per ' + titolo
        }).css('width', '100%').val(colonna.search())
            .on('click keydown', function (evento) {
                evento.stopPropagation();
            })
            .on('input', function () {
                colonna.search(this.value).draw();
            })
            .appendTo($('<div>').appendTo($intestazione));
    });
}

function getGruppiFromCorso(mod, id_gruppo){
	
	

	if(mod!=null){
		var corso = $('#corsi_mod').val();
	}else{
		var corso = $('#corsi').val();	
	}
	
	if(corso!=null && corso!=''){
		dataObj={};
		dataObj.corso = corso;
		
		callAjax(dataObj, "gestioneFormazione.do?action=gruppi_corso",function(data, textStatus){
			
			if(data.success){
				
				var gruppi = data.gruppi;
					
					var html = '<option value=""></option>';
					html = html+'<option value="0">Nessun gruppo specificato</option>';
					for (var i = 0; i < gruppi.length; i++) {
						html = html+'<option value="'+gruppi[i].id+'">'+gruppi[i].descrizione+'</option>';
					}
					
					if(id_gruppo == null || id_gruppo ==''){
						id_gruppo = "0";
					}
					
					if(mod!=null){	
						$('#gruppi_mod').html(html);
						$('#gruppi_mod').attr("disabled", false);	
						if($('#id_gruppo_mod').val()!=null && $('#id_gruppo_mod').val()!=''){
					/* 	 if(id_gruppo!=null && id_gruppo!=''){ */
							$('#gruppi_mod').val($('#id_gruppo_mod').val())
							$('#gruppi_mod').change()						
						}else{
							$('#gruppi_mod').val(0)
							$('#gruppi_mod').change()	
						}
						//
						
					}else{
						$('#gruppi').html(html);
						$('#gruppi').attr("disabled", false);
					}
				
			}
			
			
		});
	}
	
	
}


function getMembriGruppo(mod){
	
	if(mod!=null){
		var gruppo = $('#gruppi_mod').val();
		var corso = $('#corsi_mod').val();
	}else{
		var gruppo = $('#gruppi').val();
		var corso = $('#corsi').val();
	}

	if(gruppo==''){
		gruppo = "0";
	}

if(gruppo!=null && gruppo!=''){
	dataObj={};
	dataObj.gruppo = gruppo;
	dataObj.corso = corso;
	
	callAjax(dataObj, "gestioneFormazione.do?action=membri_gruppo",function(data, textStatus){
		
		if(data.success){
			
			var membri = data.membri;
			var membri_nc = data.membri_nc	
				
			if(membri.length==0){
				if(mod!=null){
					$("#body_membri_mod").html("Nessun utente nel gruppo selezionato");
					$('#content_membri_mod').show();
					$('#myModalModificaConfigurazione').modal();
				}else{
					$("#body_membri").html("Nessun utente nel gruppo selezionato");
					$('#content_membri').show();
				}
			}else{
				
				var array_email =[]; 
				 $.each(membri_nc, function(index, item) {
					 array_email.push(item.email);
				 });
				
				 var row = "";
				    $.each(membri, function(index, item) {
				    	
				    	if(array_email.includes(item.email)){
				    		row += "<tr style='background-color:#FA8989'>";
					        row += "<td>" + item.nome + "</td>";
					        row += "<td>" + item.cognome + "</td>";
					        row += "<td>" + item.email + "</td>";
					        row += "</tr>";
				    	}else{
				    		row += "<tr>";
					        row += "<td>" + item.nome + "</td>";
					        row += "<td>" + item.cognome + "</td>";
					        row += "<td>" + item.email + "</td>";
					        row += "</tr>";
				    	}
				        
				       
				    });
						
				    if(mod!=null){
				    	$("#body_membri_mod").html(row);
				    	$('#content_membri_mod').show();
				    	$('#myModalModificaConfigurazione').modal();
				    }else{
				    	$("#body_membri").html(row);
				    	$('#content_membri').show();
				    }
			}
			
			
		}
		
		$('#id_gruppo_mod').val(null)
	});
}
	

	
}

function getMembriGruppoEff(mod) {
    var suffisso = mod === 'mod' ? '_eff_mod' : '_eff';
    var corso = $('#corsi' + suffisso).val();
    var $gruppi = $('#gruppi' + suffisso);
    var gruppo = $gruppi.val();
    var richiesta = ($gruppi.data('richiestaMembri') || 0) + 1;
    $gruppi.data('richiestaMembri', richiesta);
    var $contenuto = $('#content_membri' + suffisso).hide();
    var $corpo = $('#body_membri' + suffisso).empty();

    if (!corso || gruppo == null || gruppo === '' || $gruppi.prop('disabled')) {
        return;
    }

    callAjax({ corso: corso, gruppo: gruppo }, 'gestioneFormazione.do?action=membri_gruppo_eff', function (data) {
        if (richiesta !== $gruppi.data('richiestaMembri')) {
            return;
        }

        var membri = data.membri || [];
        if (!data.success || !membri.length) {
            var messaggio = data.success
                ? 'Nessun utente nel gruppo selezionato'
                : (data.messaggio || 'Impossibile caricare gli utenti del gruppo.');
            $('<tr>').append($('<td>', { colspan: 4, text: messaggio })).appendTo($corpo);
            $contenuto.show();
            return;
        }

        $.each(membri, function (indice, membro) {
            var dataCompletamentoTest = membro.dataCompletamentoTest;
            var dataProssimoInvio = membro.dataProssimoInvio;
            var $riga = $('<tr>').append(
                $('<td>').text(membro.nome || ''),
                $('<td>').text(membro.cognome || ''),
                $('<td>').text(dataCompletamentoTest || ''),
                $('<td>').text(dataProssimoInvio || '')
            );
            if (!dataCompletamentoTest) {
                $riga.css('background-color', '#FA8989');
            }
            $corpo.append($riga);
        });
        $contenuto.show();
    });
}

$('#data_inizio_invio').change(function(){
	
	  var frequenza = $('#frequenza').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  var data =  Date.parse(formatDate($('#data_inizio_invio').val()));	
		  var data_scadenza = data.addDays(parseInt(frequenza));
		  $('#data_prossimo_invio').val(formatDate(data_scadenza));
	  }
	 
});


$('#frequenza').change(function(){
	
	  var frequenza = $('#frequenza').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  if($('#data_inizio_invio').val()!=null && $('#data_inizio_invio').val()!=''){
			  var data =  Date.parse(formatDate($('#data_inizio_invio').val()));	
			  var data_scadenza = data.addDays(parseInt(frequenza));
			  $('#data_prossimo_invio').val(formatDate(data_scadenza));
		  }
		
	  }
	 
});



$('#data_inizio_invio_mod').change(function(){
	
	  var frequenza = $('#frequenza_mod').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  var data =  Date.parse(formatDate($('#data_inizio_invio_mod').val()));	
		  var data_scadenza = data.addDays(parseInt(frequenza));
		  $('#data_prossimo_invio_mod').val(formatDate(data_scadenza));
	  }
	 
});


$('#frequenza_mod').change(function(){
	
	  var frequenza = $('#frequenza_mod').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  if($('#data_inizio_invio_mod').val()!=null && $('#data_inizio_invio_mod').val()!=''){
			  var data =  Date.parse(formatDate($('#data_inizio_invio_mod').val()));	
			  var data_scadenza = data.addDays(parseInt(frequenza));
			  $('#data_prossimo_invio_mod').val(formatDate(data_scadenza));
		  }
		
	  }
	 
});


function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}



$(document).ready(function() {
 
    var oggi = new Date();
    var giorno = oggi.getDate();
    var mese = oggi.getMonth() + 1; 
    var anno = oggi.getFullYear();
    
    ClassicEditor
    .create(document.querySelector('#testo_email'))
    .then(editor => {
      editorInstance = editor;
    })
    .catch(error => {
      console.error('Errore durante l\'inizializzazione di CKEditor:', error);
    });
	
 
	


    var dataOggi = (giorno < 10 ? '0' : '') + giorno + '/' + (mese < 10 ? '0' : '') + mese + '/' + anno;


	$('#data_inizio_invio').val(dataOggi);

     $('.dropdown-toggle').dropdown();
    // $('.select2').select2();
     
     
     $("#corsi").select2({
         dropdownParent: $('#myModalnuovaConfigurazione')
     });		
     $("#corsi_mod").select2({
         dropdownParent: $('#myModalModificaConfigurazione')
     });
     $("#gruppi").select2({
         dropdownParent: $('#myModalnuovaConfigurazione')
     });
     $("#gruppi_mod").select2({
         dropdownParent: $('#myModalModificaConfigurazione')
     });
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });   

    
     

     $('#data_inizio_invio_eff').val(dataOggi);

     $('#corsi_eff, #gruppi_eff').select2({
         dropdownParent: $('#myModalnuovaConfigurazioneEff')
     });
     $('#corsi_eff_mod, #gruppi_eff_mod').select2({
         dropdownParent: $('#myModalModificaConfigurazioneEff')
     });

     ClassicEditor.create(document.querySelector('#testo_email_eff'))
         .then(function (editor) {
             editorInstanceEff = editor;
         })
         .catch(function (error) {
             console.error('Errore durante l\'inizializzazione di CKEditor:', error);
         });

     $('#myModalModificaConfigurazioneEff').one('shown.bs.modal', function () {
         ClassicEditor.create(document.querySelector('#testo_email_eff_mod'))
             .then(function (editor) {
                 editorInstanceModEff = editor;
                 editor.setData($('#testo_email_eff_mod').val());
             })
             .catch(function (error) {
                 console.error('Errore durante l\'inizializzazione di CKEditor:', error);
             });
     });

     var opzioniConfigurazioni = {
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
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    };

    function inizializzaTabellaConfigurazioni(selettore, prioritaColonne) {
        var $tabella = $(selettore);
        var configurazioni = $tabella.DataTable($.extend({}, opzioniConfigurazioni, {
            columnDefs: prioritaColonne,
            initComplete: function () {
                aggiungiFiltriConfigurazioni(this.api());
            }
        }));
        configurazioni.buttons().container().appendTo(selettore + '_wrapper .col-sm-6:eq(1)');
        return configurazioni;
    }

    table = inizializzaTabellaConfigurazioni('#tabForConf', [
        { responsivePriority: 1, targets: 7 }
    ]);
    table.columns.adjust().draw();

    var tabellaEfficacia;
    $('#tabConfEfficacia').on('shown.bs.tab', function () {
        if (!tabellaEfficacia) {
            tabellaEfficacia = inizializzaTabellaConfigurazioni('#tabForConfEff', [
                { responsivePriority: 1, targets: [1, 7] },
                { orderable: false, searchable: false, targets: 7 }
            ]);
        }
        tabellaEfficacia.columns.adjust().responsive.recalc();
    });

    $('#tabConfPeriodiche').on('shown.bs.tab', function () {
        table.columns.adjust().responsive.recalc();
    });

	$('#tabForConf').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});


$('#modificaConfigurazioneForm').on('submit', function(e){
	 e.preventDefault();
	 $('#testo_email_mod').val(editorInstanceMod.getData());
	 
	 if($('#testo_email_mod').val()==""){

		 $('.ck-rounded-corners').css('border', '2px solid red');
	 }else{
		 callAjaxForm("#modificaConfigurazioneForm", "gestioneFormazione.do?action=modifica_configurazione_invio")
	 }
	 
	 
});
 

 
 $('#nuovaConfigurazioneForm').on('submit', function(e){
	 
 
	 e.preventDefault();
	 $('#testo_email').val(editorInstance.getData());
	 
	 if($('#testo_email').val()==""){

		 $('.ck-rounded-corners').css('border', '2px solid red');
	 }else{
		 callAjaxForm("#nuovaConfigurazioneForm", "gestioneFormazione.do?action=nuova_configurazione_invio")	 
	 }
	 
	 
	 
	})
 
 
 
 

 

$('#nuovaConfigurazioneFormEff').on('submit', function (e) {
    e.preventDefault();

    if ($('#gruppi_eff').prop('disabled') || !$('#gruppi_eff').val()) {
        return;
    }
    if (editorInstanceEff) {
        $('#testo_email_eff').val(editorInstanceEff.getData());
    }
    if ($('#testo_email_eff').val().trim() === '') {
        $('#myModalnuovaConfigurazioneEff .ck-rounded-corners').css('border', '2px solid red');
    } else {
        callAjaxForm('#nuovaConfigurazioneFormEff', 'gestioneFormazione.do?action=nuova_configurazione_invio_eff');
    }
});

$('#modificaConfigurazioneFormEff').on('submit', function (e) {
    e.preventDefault();

    if ($('#gruppi_eff_mod').prop('disabled') || !$('#gruppi_eff_mod').val()) {
        return;
    }
    if (editorInstanceModEff) {
        $('#testo_email_eff_mod').val(editorInstanceModEff.getData());
    }
    if ($('#testo_email_eff_mod').val().trim() === '') {
        $('#myModalModificaConfigurazioneEff .ck-rounded-corners').css('border', '2px solid red');
    } else {
        callAjaxForm('#modificaConfigurazioneFormEff', 'gestioneFormazione.do?action=modifica_configurazione_invio_eff');
    }
});

  </script>
  
</jsp:attribute> 
</t:layout>

