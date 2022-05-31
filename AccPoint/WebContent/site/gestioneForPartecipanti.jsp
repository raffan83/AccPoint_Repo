<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        Lista Partecipanti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	 Lista Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<div class="row">
<div class="col-xs-12">

<!-- <a class="btn btn-primary pull-left" onClick="callAction('gestioneFormazione.do?action=report_partecipanti')">Crea report partecipanti</a> -->
<a class="btn btn-primary pull-left" onClick="modalReportPartecipanti()">Crea report partecipanti</a>
	<a class="btn btn-primary pull-right" onClick="modalNuovoPartecipante()"><i class="fa fa-plus"></i> Nuovo Partecipante</a>
	<a class="btn btn-primary pull-right" onClick="modalImportaPartecipanti()"  style="margin-right:5px"><i class="fa fa-plus"></i> Importa Partecipanti</a>  
	<a class="btn btn-success customTooltip pull-right" onClick="callAction('gestioneFormazione.do?action=download_template')" title="Scarica template importazione" style="margin-right:5px"><i class="fa fa-file-excel-o"></i></a>
    


</div>

</div><br>
</c:if>
<div class="row">
<div class="col-sm-12">

 <table id="tabForPartecipante" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Data di nascita</th>
<th>Azienda</th>
<th>Sede</th>
<th>Luogo di nascita</th>
<th>Codice fiscale</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_partecipanti }" var="partecipante" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${partecipante.id }</td>	
	<td>${partecipante.nome }</td>
	<td>${partecipante.cognome }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${partecipante.data_nascita}" /></td>
	<td>${partecipante.nome_azienda}</td>	
	<td><c:if test="${partecipante.id_sede!=0 }">${partecipante.nome_sede }</c:if></td>
	<td>${partecipante.luogo_nascita }</td>
	<td>${partecipante.cf }</td>
	<td>
	
	<a class="btn btn-info" title="Click per aprire il dettaglio" onClick="dettaglioPartecipante('${utl:encryptData(partecipante.id)}')"><i class="fa fa-search"></i></a>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<a class="btn btn-warning" onClicK="modificaPartecipanteModal('${partecipante.id}','${partecipante.nome }','${partecipante.cognome.replace('\'','&prime;')}','${partecipante.data_nascita }','${partecipante.id_azienda }','${partecipante.id_sede }','${partecipante.luogo_nascita.replace('\'','&prime;') }','${partecipante.cf }')" title="Click per modificare il partecipante"><i class="fa fa-edit"></i></a>

	 <a class="btn btn-danger" title="Click per eliminare il partecipante" onClick="modalEliminaPartecipante('${partecipante.id}')"><i class="fa fa-times"></i></a>
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
</div>
</div>

</section>



 <form id="ImportaForm" name="ImportaForm"> 
   <div id="myModalImporta" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Importa da File</h4>
      </div>
       <div class="modal-body">   

       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">

        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda_import" name="azienda_import" style="width:100%" >

        </div>      
       </div>
       <br>
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_import" name="sede_import" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled >
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div>    <br>
      	<div class="row">
     
      	<div class="col-xs-12">
      		<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".xls, .XLS, .xlsx, .XLSX, .pdf, .PDF"  id="file_excel" name="file_excel" type="file" required></span><label id="label_excel"></label>
      	
      	</div>
      	</div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="flag_pdf">
		<button class="btn btn-primary" type="submit" >Salva</button>
      </div>
    </div>
  </div>

</div>
   </form>




 <form id="nuovoPartecipanteForm" name="nuovoPartecipanteForm">  
<div id="modalNuovoPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Partecipante</h4>
      </div>
       <div class="modal-body">     
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <!-- <input type="text" id="azienda" name="azienda" class="form-control" style="width:100%" required> -->
        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda" name="azienda" style="width:100%" required>
                       <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
        </div>      
       </div>
       <br>
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>  
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome" name="nome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome" name="cognome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita" name="data_nascita" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Luogo di nascita</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="luogo_nascita" name="luogo_nascita" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Codice fiscale</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cf" name="cf" class="form-control" style="width:100%" required>
        </div>      
       </div><br>

      <div class="row">
       <div class="col-xs-12">
       <label style="color:red;display:none" id="label_error">Attenzione! Il Codice Fiscale inserito è già presente nel sistema!</label>
       </div>
    
       </div>
      	</div>
      <div class="modal-footer">
      
      <button class="btn btn-primary" type="submit" id="save_btn">Salva</button>
		
      </div>
    </div>
  </div>

</div>
</form>



 <form id="modificaPartecipanteForm" name="modificaPartecipanteForm">  
<div id="modalModificaPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Partecipante</h4>
      </div>
       <div class="modal-body">   
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda_mod" name="azienda_mod" style="width:100%" required>
      

        </div>      
       </div><br>
              <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_mod" name="sede_mod" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>    
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome_mod" name="nome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome_mod" name="cognome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita_mod" name="data_nascita_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
       
         <div class="row">
       <div class="col-xs-3">
       <label>Luogo di nascita</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="luogo_nascita_mod" name="luogo_nascita_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Codice fiscale</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cf_mod" name="cf_mod" class="form-control" style="width:100%" required>
        </div>      
       </div>
       

      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_partecipante" name="id_partecipante">
      <button class="btn btn-primary" type="submit">Salva</button>
      <!-- <a class="btn btn-primary" onclick="modificaForPartecipante()" >Salva</a> -->
		
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
      	Sei sicuro di voler eliminare il partecipante?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_partecipante_id">
      <a class="btn btn-primary" onclick="eliminaPartecipante($('#elimina_partecipante_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="formReport" name="formReport">
  <div id="myModalReportPartecipanti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Azienda</h4>
      </div>
       <div class="modal-body">      
       
        <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        
         <select id="azienda_report" name="azienda_report" class="form-control select2"  data-placeholder="Seleziona Azienda..." aria-hidden="true" data-live-search="true" style="width:100%" required  >
         <option value=""></option>
       <option value="0">TUTTE</option>
      	<c:forEach items="${listaAziendePartecipanti}" var="azienda" >
      	<option value="${azienda.split('!')[0]}">${azienda.split('!')[1]}</option>
      	</c:forEach>
      
      </select>

        </div>      
       </div><br>
              <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_report" name="sede_report" class="form-control select2"  data-placeholder="Seleziona Sede..." disabled aria-hidden="true" data-live-search="true" style="width:100%" required >
       <option value=""></option>
       <c:forEach items="${listaAziendePartecipanti}" var="azienda">
      	<option value="${azienda.split('!')[2]}_${azienda.split('!')[0]}">${azienda.split('!')[3]}</option>
      	</c:forEach>
      	<%-- <c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach> --%>
      
      </select>
        </div>      
       </div> 
      	
      	</div>
      <div class="modal-footer">
      
      <button class="btn btn-primary" type="submit" >Crea report</button>
		<a class="btn btn-primary" onclick="$('#myModalReportPartecipanti').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>
</form>


<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }">
<div id="myModalAssociaUtenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato"  style="z-index:9998">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button >
        <h4 class="modal-title" id="myModalLabel">Associa partecipante al corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-12">
       
       <select name="corsi" id="corsi" data-placeholder="Seleziona Corsi..."  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  required>
                    
                    <option value=""></option> 
                        <c:forEach items="${lista_corsi}" var="corso">
                       		
                      	<option value="${corso.id }" >ID: ${corso.id} - ${corso.descrizione}</option> 
                    			 
                     	</c:forEach>
                    
                  </select>
                  </div>
       </div><br>
       
         <div class="row">
       <div class="col-xs-12">
       
       <select name="ruoli" id="ruoli" data-placeholder="Seleziona Ruolo..."  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  >
                    
                    <option value=""></option>  
                      <c:forEach items="${lista_ruoli}" var="ruolo">
                           <option value="${ruolo.id }">${ruolo.descrizione}</option> 
                     </c:forEach>
                  </select>
                  </div>
       </div><br>
       
        <div class="row">
       <div class="col-xs-4">
       <label>Ore Partecipate</label>
       </div>
       <div class="col-xs-8">
       <input id="ore_partecipate" name="ore_partecipate" type="number" min="0"  step="0.1" class="form-control" >
       </div>
       </div><br>
       
        <div class="row">
       <div class="col-xs-4">
       <label>Firma Responsabile</label>
       </div>
       <div class="col-xs-8">
       <select id="firma_responsabile" name="firma_responsabile" class="form-control select2">
       <option value="0">Default</option>
       <option value="1">Alessandro Di Vito</option>
       <option value="2">Antonio Accettola</option>
       <option value="3">Gabriella Mammone</option>
       </select>
       </div>
       </div><br>
       
      	 <div class="row">
       <div class="col-xs-4">
       <label>Firma Legale Rappresentante</label>
       </div>
       <div class="col-xs-8">
       <select id="firma_legale_rappresentante" name="firma_legale_rappresentante"  class="form-control select2">
       <option value="0">Default</option>       
       <option value="1">Antonio Accettola</option>
       <option value="2">Gabriella Mammone</option>
       </select>
       </div>
       </div><br>
       
       	 <div class="row">
       <div class="col-xs-4">
       <label>Firma Centro di Formazione Autorizzato</label>
       </div>
       <div class="col-xs-8">
       <select id="firma_centro_formazione" name="firma_centro_formazione"  class="form-control select2">
       <option value="0">Default</option>       
       <option value="1">Antonio Accettola</option>
       <option value="2">Gabriella Mammone</option>
       </select>
       </div>
       </div>
       
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="cf_corso" name="cf_corso">
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <a class="btn btn-primary" onClick='associaPartecipanteCorsi()'>Associa</a> 
      </div>
    </div>
  </div>

</div>
</c:if>


<div id="modalConfermaImportazione" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Seleziona Azienda</h4>
      </div>
       <div class="modal-body">      
       
         <div class="row">
       <div class="col-xs-5">
       <label>Azienda</label>
       <input class="form-control"  data-placeholder="Seleziona Azienda..." id="azienda_import_general" name="azienda_import_general"  style="width:100%">
        
        <!-- < select id="azienda_import_general" name="azienda_import_general" class="form-control select2"  data-placeholder="Seleziona Azienda..." aria-hidden="true" data-live-search="true" style="width:100%" required  > 
         <option value=""></option>
       <option value="0">TUTTE</option>
      	<c:forEach items="${listaAziendePartecipanti}" var="azienda" >
      	<option value="${azienda.split('!')[0]}">${azienda.split('!')[1]}</option>
      	</c:forEach>
      
      </select>
-->
        </div>    
        
        <div class="col-xs-5">
       <label>Sede</label>
       
        
       <select id="sede_import_general" name="sede_import_general" class="form-control select2"  data-placeholder="Seleziona Sede..." disabled aria-hidden="true" data-live-search="true" style="width:100%" required >
       <option value=""></option>
       <c:forEach items="${listaAziendePartecipanti}" var="azienda">
      	<option value="${azienda.split('!')[2]}_${azienda.split('!')[0]}">${azienda.split('!')[3]}</option>
      	</c:forEach>
      </select>
        </div>
         <div class="col-xs-2">
         
         <a class="btn btn-primary" onClick="modalAssocia()" style="margin-top:25px">Associa al corso</a>
         </div>
        
        
         </div> 
        

          <br> 


<a class="btn btn-primary" onClick="invertiNomeCognome()">Inverti Nome e Cognome</a>

 <table id="tabImportPartecipante" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Nome</th>
<th>Cognome</th>
<th>Codice fiscale</th>
<th>Data di nascita</th>
<th>Luogo di nascita</th>
<th>Azienda</th>
<th >Sede</th>
<th>Corsi</th>

<th>Azioni</th>
 </tr></thead>
 
<%--  <tbody>
 
 	<c:forEach items="${lista_partecipanti }" var="partecipante" varStatus="loop">
	<tr id="row_${loop.index}" >
	<td>${partecipante.nome }</td>
	<td>${partecipante.cognome }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${partecipante.data_nascita}" /></td>
	<td>${partecipante.nome_azienda}</td>	
	<td><c:if test="${partecipante.id_sede!=0 }">${partecipante.nome_sede }</c:if></td>
	<td>${partecipante.luogo_nascita }</td>
	<td>${partecipante.cf }</td>
	<td>
	
	<a class="btn btn-info" title="Click per aprire il dettaglio" onClick="dettaglioPartecipante('${utl:encryptData(partecipante.id)}')"><i class="fa fa-search"></i></a>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<a class="btn btn-warning" onClicK="modificaPartecipanteModal('${partecipante.id}','${partecipante.nome }','${partecipante.cognome.replace('\'','&prime;')}','${partecipante.data_nascita }','${partecipante.id_azienda }','${partecipante.id_sede }','${partecipante.luogo_nascita.replace('\'','&prime;') }','${partecipante.cf }')" title="Click per modificare il partecipante"><i class="fa fa-edit"></i></a>

	 <a class="btn btn-danger" title="Click per eliminare il partecipante" onClick="modalEliminaPartecipante('${partecipante.id}')"><i class="fa fa-times"></i></a>
	 	</c:if>
	</td>
	</tr>
	</c:forEach>
	 

 </tbody> --%>
 </table>  


      <div class="modal-footer">
      
      <button class="btn btn-primary" onClick="confermaImportazione()" >Salva</button>
		<!-- <a class="btn btn-primary" onclick="$('#myModalReportPartecipanti').modal('hide')" >Chiudi</a> -->
      </div>
    </div>
  </div>

</div>


</div>



  <div id="modalProgress" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Importazione dei partecipanti in corso...</h4>
      </div>
       <div class="modal-body">       
      <div id="myProgress">
  <div class="progress" id="myBar"></div>
</div>
      	</div>
<!--       <div class="modal-footer">
      <input type="hidden" id="elimina_partecipante_id">
      <a class="btn btn-primary" onclick="eliminaPartecipante($('#elimina_partecipante_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div> -->
    </div>
  </div>

</div>




</div>

</div>
<!-- ./wrapper -->


   <t:dash-footer />
   
  <t:control-sidebar />

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>

.progress {
    display: block;
    text-align: center;
    width: 0;
    height: 3px;
    background: red;
    transition: width .3s;
}
.progress.hide {
    opacity: 0;
    transition: opacity 1.3s;
}


#myProgress {
  width: 100%;
  background-color: grey;
}

#myBar {
  width: 1%;
  height: 30px;
  background-color: green;
}


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

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>

<script type="text/javascript">

$('#formReport').on('submit', function(e){
	e.preventDefault();
	
	creaReportPartecipanti();
});

function creaReportPartecipanti(){
	
	var id_azienda = $('#azienda_report').val();
	var id_sede = $('#sede_report').val();
	
	callAction('gestioneFormazione.do?action=report_partecipanti&id_azienda='+id_azienda+'&id_sede='+id_sede,null,true);
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal('hide');
}

function modalNuovoPartecipante(){
	
	$('#modalNuovoPartecipante').modal();
	
}

function modalImportaPartecipanti(){
	$('#myModalImporta').modal();
}

function dettaglioPartecipante(id_partecipante){
	
	callAction('gestioneFormazione.do?action=dettaglio_partecipante&id_partecipante='+id_partecipante,null,true);
}

$('#file_excel').change(function(){
	
	if($(this).val().includes(".pdf")){
		$("#azienda_import").prop("required", false);
		$("#sede_import").prop("required", false);
		$('#flag_pdf').val(1);
	}else{
		$("#azienda_import").prop("required", true);
		$("#sede_import").attr("required", true);
		$('#flag_pdf').val(0);
	}
	
	$('#label_excel').html($(this).val().split("\\")[2]);
});

function modificaPartecipanteModal(id_partecipante, nome, cognome, data_nascita, azienda, sede, luogo_nascita, cf){
	
	$('#id_partecipante').val(id_partecipante);
	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	if(data_nascita!=null && data_nascita!=''){
		$('#data_nascita_mod').val(Date.parse(data_nascita).toString("dd/MM/yyyy"));
	}
	
	if(azienda!=null && azienda!=''){
		$('#azienda_mod').val(azienda);
		$('#azienda_mod').change();	
		
	}
	if(sede!=null && sede!='' && sede!='0'){
		$('#sede_mod').val(sede+"_"+azienda);
		$('#sede_mod').change();
	}else{
		$('#sede_mod').val(0);
		$('#sede_mod').change();
	}
	$('#luogo_nascita_mod').val(luogo_nascita);
	$('#cf_mod').val(cf);
	
	$('#modalModificaPartecipante').modal();
}

	 
$('#cf').focusout(function(){
	
	var json_cf = '${json_cf}';
	
	$('#cf').css('border', '1px solid #d2d6de');
	$('#label_error').hide();
	$('#save_btn').attr("disabled",false);
	
	if(json_cf !=''){
		var cf = JSON.parse(json_cf);
		
		if(cf.includes($(this).val())){
			$('#cf').css('border', '1px solid #f00');
			$('#label_error').show();
			$('#save_btn').attr("disabled",true);
		}
	}
	
	
});


var columsDatatables = [];

$("#tabForPartecipante").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForPartecipante thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForPartecipante thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );





function modalEliminaPartecipante(id_partecipante){
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	 
	  dataObj={};
	  
	  $('#elimina_partecipante_id').val(id_partecipante);
 $.ajax({
	  type: "POST",
	  url: "gestioneFormazione.do?action=corsi_partecipante&id_partecipante="+id_partecipante,
	  data: dataObj,
	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
 	  processData: false, // NEEDED, DON'T OMIT THIS
	  success: function( data, textStatus) {
		  
		  var data = JSON.parse(data);
		  
		  pleaseWaitDiv.modal('hide');
		  
		  if(data.success && data.corsi=="")
		  { 
			  $('#myModalYesOrNo').modal();
			  
		
		  }else{
			  
			  			  
			  $('#myModalErrorContent').html("Attenzione! il partecipante è associato ai corsi:<br>"+data.corsi);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').hide();
 				$('#visualizza_report').hide();
				$('#myModalError').modal('show');
			 
				
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html(textStatus);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
				$('#visualizza_report').show();
			$('#myModalError').modal('show');

	  }
 });
	
}


function modalReportPartecipanti(){
	
	//$('#azienda_report').change();
	
		var usedNames = {};
	$("select[name='azienda_report'] > option").each(function () {
	    if(usedNames[this.text]) {
	        $(this).remove();
	    } else {
	        usedNames[this.text] = this.value;
	    }
	});
	
	$('#myModalReportPartecipanti').modal();
	
}

$('#myModalReportPartecipanti').on('hidden.bs.modal', function(){
	
	$('#azienda_report').val("");
	$('#azienda_report').change()
	$('#sede_report').val("");
	$("#sede_report").prop("disabled", true);
});

var dataSelect2 = {};

$(document).ready(function() {

	
	dataSelect2 = mockData();
	
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
  //   $('.select2').select2();
  initSelect2('#azienda');
  initSelect2('#azienda_mod');
  initSelect2('#azienda_import');
  initSelect2('#azienda_import_general');
  
  $('#sede').select2();
  $('#sede_mod').select2();
  $('#sede_import').select2();
  $('#sede_report').select2();
  $('#azienda_report').select2();
  $('#sede_import_general').select2();
  $('#corsi').select2();
  $('#ruoli').select2();

	$('#ruoli').select2({
	    dropdownParent: $('#myModalAssociaUtenti')
	});
	$('#corsi').select2({
	    dropdownParent: $('#myModalAssociaUtenti')
	});
	
	$('#firma_responsabile').select2({
	    dropdownParent: $('#myModalAssociaUtenti')
	});
	$('#firma_legale_rappresentante').select2({
	    dropdownParent: $('#myModalAssociaUtenti')
	});
	$('#firma_centro_formazione').select2({
	    dropdownParent: $('#myModalAssociaUtenti')
	});

   var  tablePartecipante = $('#tabForPartecipante').DataTable({
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
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 8 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, 
	 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  }]
		               
		    });
		
   tablePartecipante.buttons().container().appendTo( '#tabForPartecipante_wrapper .col-sm-6:eq(1)');
		
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	   tablePartecipante.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tablePartecipante.column( colIdx ).header() ).on( 'keyup', function () {
		  tablePartecipante
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
	 	  tablePartecipante.columns.adjust().draw();
		

	$('#tabForPartecipante').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		});


	});
	
	
	const editableCell = function(cell) {
		
		
		//if(!cliente){
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
		      const row = tab.row(e.target.parentElement)
		      tab.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
		      var x = tab.rows().data();
		      	//salvaModificaQuestionario();
		      console.log('Row changed: ', row.data())
		    }
		  })
		  
		//}
		};
		
		
	
	
	 tab = $('#tabImportPartecipante').DataTable({
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
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: false,	
		     fixedColumns : true,
		      columns : [
		      	{"data" : "nome", createdCell: editableCell},
		      	{"data" : "cognome", createdCell: editableCell},
		      	{"data" : "cf"},
		      	{"data" : "data_nascita", createdCell: editableCell},
		      	{"data" : "luogo_nascita", createdCell: editableCell},
		      	{"data" : "azienda"},
		      	{"data" : "sede", width: 200},
		      	{"data" : "corsi"},
		      	{"data" : "azioni"},
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		tab.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tab.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
	      tab
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  

	
	
});



$('#modificaPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForPartecipante();
});
 

 
 $('#nuovoPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForPartecipante();
});
 
 
 $('#ImportaForm').on('submit', function(e){
	 e.preventDefault();
	 if($('#flag_pdf').val()==1){
		 importaPartecipantiDaExcel(1);
	 }else{
		 importaPartecipantiDaExcel(0);	 
	 }
	 
});
 
 
 function invertiNomeCognome(){
	 
	 var table = $('#tabImportPartecipante').DataTable();
	  
	 var data_table = table.rows().data(); 
	 
	 for (var i = 0; i < data_table.length; i++) {
		 var x = data_table[i].nome;
		 
		 data_table[i].nome = data_table[i].cognome;
		 data_table[i].cognome = x;
	}
	 

	 
	  table.clear().draw();
	   
		table.rows.add(data_table).draw();
	 
	 
 }
 
 
 function confermaImportazione(){
	 
	 var table = $('#tabImportPartecipante').DataTable();
	  
	 var data_table = table.rows().data(); 
	 
	 var data = [];
	 
	 var checkForm = 1;
	 var checkAzienda = 1;
	 
	 for (var i = 0; i < data_table.length; i++) {
		 var partecipante ={};
		 
		 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
			$(x).css("background-color","#F9F9F9")
		 
		 partecipante.nome = data_table[i].nome;
		 partecipante.cognome = data_table[i].cognome;
		 partecipante.cf = data_table[i].cf;
		 partecipante.data_nascita = data_table[i].data_nascita;
		 partecipante.luogo_nascita = data_table[i].luogo_nascita;
		 partecipante.azienda = $('#azienda_table_'+data_table[i].cf).val();
		 partecipante.sede =  $('#sede_table_'+data_table[i].cf).val();
		 partecipante.id_corso =  $('#corso_table_'+data_table[i].cf).val();
		 partecipante.id_ruolo = $('#ruolo_table_'+data_table[i].cf).val();
		 partecipante.ore =  $('#ore_table_'+data_table[i].cf).val();
		 partecipante.firma_responsabile = $('#firma_responsabile_'+data_table[i].cf).val();
		 partecipante.firma_legale_rappresentante = $('#firma_legale_rappresentante_'+data_table[i].cf).val();
		 partecipante.firma_centro_formazione = $('#firma_centro_formazione_'+data_table[i].cf).val();
		 
		 if(data_table[i].nome == ''){
			 checkForm = 0;
			 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
				$(x).css("background-color","#F8F26D")
		 }
		 if(data_table[i].cognome == ''){
			 checkForm = 0;
			 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
				$(x).css("background-color","#F8F26D")
		 }
		 if(data_table[i].data_nascita == ''){
			 checkForm = 0;
			 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
				$(x).css("background-color","#F8F26D")
		 }
		 if(data_table[i].luogo_nascita == ''){
			 checkForm = 0;
			 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
				$(x).css("background-color","#F8F26D")
		 }
		 

		 
 		 if($('#azienda_table_'+data_table[i].cf).val() == null || $('#azienda_table_'+data_table[i].cf).val() == ''){
 			checkAzienda = 0;
			 //var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
			//	$(x).css("background-color","#F8F26D")
		 }
		 /* if($('#sede_table_'+data_table[i].cf).val() == null || $('#sede_table_'+data_table[i].cf).val() == ''){
			 checkForm = 0;
			 var x = $('#content_corsi_'+data_table[i].cf)[0].parentNode.parentNode;
				$(x).css("background-color","#F8F26D")
		 }  */
		 
		 data.push(partecipante);
	}
	 
	 
	 if((checkForm == 0) || ($('#azienda_import_general').val()=='' && checkAzienda == 0)){
		 $('#myModalErrorContent').html("Attenzione! Dati non inseriti correttamente!");
	 	  	$('#myModalError').removeClass();
	 		$('#myModalError').addClass("modal modal-danger");	  
	 		$('#report_button').hide();
	 		$('#visualizza_report').hide();
	 		$('#myModalError').modal('show');
	 }else{
		 
		
		 
		 confermaImportazionePdf(data);	 
	 }
	 
	 
 }
 
 function startProgressBar(data_size){
	 
	 
	 var i = 0;
	 
	   if (i == 0) {
	     i = 1;
	     var elem = document.getElementById("myBar");
	     var width = 1;
	     var id = setInterval(frame, (data_size * 4.6));
	     function frame() {
	       if (width >= 100) {
	         clearInterval(id);
	         i = 0;
	       } else {
	         width++;
	         elem.style.width = width + "%";
	       }
	     }
	   }
	 
	 
	 
 }
 

 
 function confermaImportazionePdf(dataTable, id_){
		

	  $('#modalProgress').modal(); 
	  startProgressBar(dataTable.length)
	 
  
	  var id_azienda = $('#azienda_import_general').val();
		 var id_sede = $('#sede_import_general').val();
	  
		 var data = JSON.stringify(dataTable);
	 dataObj={};
	 dataObj.data = data
	 dataObj.id_azienda_general = id_azienda 
	 dataObj.id_sede_general = id_sede 
	 $.ajax({
		 type: "POST",
		 url: "gestioneFormazione.do?action=conferma_importazione",
		 data: dataObj,
		 dataType: "json",
		 //if received a response from the server
		 success: function( data, textStatus) {
		 	pleaseWaitDiv.modal('hide');
		 	  if(data.success){	  
		 		  
		 		 var elem = document.getElementById("myBar");
		 		  elem.style.width = 100 + "%";
		 		  $('#modalProgress').modal('hide');
		 	  
		 			$('#report_button').hide();
		 			$('#visualizza_report').hide();
		 			$('#myModalErrorContent').html(data.messaggio);
		 			  	$('#myModalError').removeClass();
		 				$('#myModalError').addClass("modal modal-success");
		 				$('#myModalError').modal('show');      				
		    				  
		 				$('#myModalError').on("hidden.bs.modal", function(){
		 					location.reload();
		 				})
		 	  }else{
		 		 pleaseWaitDiv.modal('hide');
		 		 var elem = document.getElementById("myBar");
		 		  elem.style.width = 0 + "%";
		 		  $('#modalProgress').modal('hide');
		 		  
		 		$('#myModalErrorContent').html("Errore nell'importazione dei partecipanti!");
		 	  	$('#myModalError').removeClass();
		 		$('#myModalError').addClass("modal modal-danger");	  
		 		$('#report_button').hide();
		 		$('#visualizza_report').hide();
		 		$('#myModalError').modal('show');			
		 	
		 	  }
		 },
		
		 error: function( data, textStatus) {
			 pleaseWaitDiv.modal('hide');
			 
			 var elem = document.getElementById("myBar");
	 		  elem.style.width = 0 + "%";
	 		  $('#modalProgress').modal('hide');
		 	  $('#myModalYesOrNo').modal('hide');
		 	  $('#myModalErrorContent').html(data.messaggio);
		 	  	$('#myModalError').removeClass();
		 		$('#myModalError').addClass("modal modal-danger");	  
		 		$('#report_button').show();
		 		$('#visualizza_report').show();
		 			$('#myModalError').modal('show');

		 }
		 });
	
}
 
 
 function associaPartecipanteCorsi(){
	 
	 var cf = $('#cf_corso').val();
	 var corso = $('#corsi').val();
	 var ruolo = $('#ruoli').val();
	 var ore = $('#ore_partecipate').val();
	 var firma_responsabile = $('#firma_responsabile').val();
	 var firma_legale_rappresentante = $('#firma_legale_rappresentante').val();
	 var firma_centro_formazione= $('#firma_centro_formazione').val();
	 
	 if(corso == null || corso == '' || ruolo == null || ruolo == '' || ore == ''){
		 
		 $('#myModalError').css("z-index", "9999")
			$('#myModalErrorContent').html("Attenzione! inserisci tutti i campi!");
	 	  	$('#myModalError').removeClass();
	 		$('#myModalError').addClass("modal modal-danger");	  
	 		$('#report_button').hide();
	 		$('#visualizza_report').hide();
	 		$('#myModalError').modal('show');		
		 
	 }else{
		 if(cf!=0){	
			 
			 $('#corso_table_'+cf).val(corso);
			 $('#ruolo_table_'+cf).val(ruolo);
			 $('#ore_table_'+cf).val(ore);
			 $('#firma_legale_rappresentante_'+cf).val(firma_legale_rappresentante);
			 $('#firma_responsabile_'+cf).val(firma_responsabile);
			 $('#firma_centro_formazione_'+cf).val(firma_centro_formazione);
			 
			 var html = '<label>ID: '+corso+'</label><br><label>Ruolo: '+ruolo+'</label><br><label>Ore: '+ore+'</label>';
			 
			 $('#content_corsi_'+cf).html(html);
		 }else{
			 
				var tableImport = $('#tabImportPartecipante').DataTable();
				var cf_array = tableImport.column(2).data();
				
				for(var i = 0; i<cf_array.length;i++){
					 $('#corso_table_'+cf_array[i]).val(corso);
					 $('#ruolo_table_'+cf_array[i]).val(ruolo);
					 $('#ore_table_'+cf_array[i]).val(ore);
					 $('#firma_legale_rappresentante_'+cf_array[i]).val(firma_legale_rappresentante);
					 $('#firma_responsabile_'+cf_array[i]).val(firma_responsabile);
					 $('#firma_centro_formazione_'+cf_array[i]).val(firma_centro_formazione);
					 
					 var html = '<label>ID: '+corso+'</label><br><label>Ruolo: '+ruolo+'</label><br><label>Ore: '+ore+'</label>';
					 
					 $('#content_corsi_'+cf_array[i]).html(html);
				}
			 
		 }
		 
		 $('#myModalAssociaUtenti').modal('hide')
		 
		 $('#corsi').val('');
		 $('#corsi').change();
		 $('#ruoli').val('');
		 $('#ruoli').change();
		$('#ore_partecipate').val('');
	 }
	 
	 
	 
 }
 
 function modalAssocia(cf){

	 $('#cf_corso').val(cf)
	 $('#myModalAssociaUtenti').modal()
 }
 
  
 function creaSelect(cf){
	 

	 initSelect2('#azienda_table_'+cf);
	   
 }
 
 function createTableImport(lista_partecipanti_import, lista_corsi){
	 
	 var table_data = [];
	 
	 var nomi_irregolari = [];
	  var col_cf = [];
	  
	  if(lista_partecipanti_import!=null){
		  for(var i = 0; i<lista_partecipanti_import.length;i++){
			  var dati = {};
			  		
			  dati.nome = lista_partecipanti_import[i].nome;
			  dati.cognome = lista_partecipanti_import[i].cognome;
			  dati.cf = lista_partecipanti_import[i].cf;
			  
			  dati.data_nascita = formatDate(moment(lista_partecipanti_import[i].data_nascita, "MMM DD, YYYY"));
			  dati.luogo_nascita = lista_partecipanti_import[i].luogo_nascita;
			  dati.azienda = '<input class="form-control typeahead" onClick="creaSelect(\''+lista_partecipanti_import[i].cf+'\')" onChange="changeSedeTab(\''+lista_partecipanti_import[i].cf+'\')" data-placeholder="Seleziona Azienda..." id="azienda_table_'+lista_partecipanti_import[i].cf+'" name="azienda_table_'+lista_partecipanti_import[i].cf+'"  style="width:100%">'
			  
			  dati.sede = '<select class="form-control select2" id="sede_table_'+lista_partecipanti_import[i].cf+'" style="width:100%" name="sede_table_'+lista_partecipanti_import[i].cf+'" disabled></select>';
			  dati.corsi = '<div id="content_corsi_'+lista_partecipanti_import[i].cf+'"></div> <input type="hidden" id="corso_table_'+lista_partecipanti_import[i].cf+'"> <input type="hidden" id="ruolo_table_'+lista_partecipanti_import[i].cf+'"> <input type="hidden" id="ore_table_'+lista_partecipanti_import[i].cf+'"> <input type="hidden" id="firma_responsabile_'+lista_partecipanti_import[i].cf+'"> <input type="hidden" id="firma_legale_rappresentante_'+lista_partecipanti_import[i].cf+'"> <input type="hidden" id="firma_centro_formazione_'+lista_partecipanti_import[i].cf+'">';
			  dati.azioni = '<a class="btn btn-primary" onClick="modalAssocia(\''+lista_partecipanti_import[i].cf+'\')">Associa al corso</a>';
			  
			  if(lista_partecipanti_import[i].nominativo_irregolare == 1){
				  nomi_irregolari.push(lista_partecipanti_import[i].cf);
			  }
			   col_cf.push(lista_partecipanti_import[i].cf);
			  table_data.push(dati);
			  }
		  
		  var table = $('#tabImportPartecipante').DataTable();
		  
		   table.clear().draw();
		   
			table.rows.add(table_data).draw();

			for(var i = 0;i<nomi_irregolari.length;i++){
				for(var j = 0; j<col_cf.length;j++){
					if(col_cf[j] == nomi_irregolari[i]){
						var x = $('#content_corsi_'+col_cf[j])[0].parentNode.parentNode;
						$(x).css("background-color","#F8F26D")
					}
				}
			}
			
	 		table.columns.adjust().draw();
	 		for(var i = 0; i<lista_partecipanti_import.length;i++){
				//initSelect2('#azienda_table_'+lista_partecipanti_import[i].cf);
				$('#sede_table_'+lista_partecipanti_import[i].cf).select2();
				
			}  
			
	 		var azienda_val = $('#azienda_import').val();
			var sede_val = $('#sede_import').val();
			
			 if(azienda_val!=null && azienda_val!=''){
					
					$('#azienda_import_general').val(azienda_val);
					$('#azienda_import_general').change();
				}
				if(sede_val!=null && sede_val!=''){
					if(sede_val == 0){
						$('#sede_import_general').val(0);
					}else{
						$('#sede_import_general').val(sede_val);	
					}
					
					$('#sede_import_general').change();
				}  
			
			
		  $('#modalConfermaImportazione').modal();
			
	 
	 
	 $('#modalConfermaImportazione').on('shown.bs.modal', function () {
		  var table = $('#tabImportPartecipante').DataTable();
		  
			table.columns.adjust().draw();
			
		})
		  
	  }else{
		  location.reload();
	  }
	 
	 
 }
 
 function formatDate(data){
		
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}
 
 
 
function changeSedeTab(cf, value){
	 
	
/* 	 if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1
	    $(this).data('options', );
	  }
	   */
	   

	   
	   if(value!=null){
		  var id = value;
	  }else{ 
		  var id =  $("#azienda_table_"+cf).val();	
	  }
	   
	   //var options = $(this).data('options');
	  var options =   $('#sede option').clone()
	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");
	  
	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			//opt.push(options[i]);
			opt.push("<option value = "+options[i].value+">"+options[i].innerText+"</option>");
		}   
	   }	
	 
	  $("#sede_table_"+cf).html(opt);

	  $("#sede_table_"+cf).prop("disabled", false);
	  
		$("#sede_table_"+cf).change();
		 
 }
 
 
 
 
 
 $("#azienda").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  

		$("#sede").change();  
		

	});
 
 $("#azienda_mod").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_mod option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_mod").prop("disabled", false);
	 
	  $('#sede_mod').html(opt);
	  
	  $("#sede_mod").trigger("chosen:updated");
	  

		$("#sede_mod").change();  
		

	});
 
 
 $("#azienda_report").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_report option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	  
	  if(id!=0){
	  

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_report").prop("disabled", false);
	 
	  $('#sede_report').html(opt);
	  
	  $("#sede_report").trigger("chosen:updated");
	  

		$("#sede_report").change();  
		
	  }else{
		  $('#sede_report').html(opt);
		  $("#sede_report").change(); 
		  $("#sede_report").prop("disabled", true);
	  }
	});
 
 $("#azienda_import").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_import option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_import").prop("disabled", false);
	 
	  $('#sede_import').html(opt);
	  
	  $("#sede_import").trigger("chosen:updated");
	  

		$("#sede_import").change();  
		
		  
	});
 
  
 $("#azienda_import_general").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  
	  opt.push("<option value = 0 selected>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_import_general").prop("disabled", false);
	 
	  $('#sede_import_general').html(opt);
	  
	  $("#sede_import_general").trigger("chosen:updated");
	  

		$("#sede_import_general").change();  
		
/* 		var tableImport = $('#tabImportPartecipante').DataTable();
		var cf = tableImport.column(2).data();
		
		for(var i = 0; i<cf.length;i++){
			//changeSedeTab(cf[i], id);
			
			$("#azienda_table_"+cf[i]).val(id).trigger("change");
			
			var data = {};
			
			data.id = id;
			data.text = "Azienda test"
			
			var dataSel = []
			dataSel.push(data)
			initSelect2("#azienda_table_"+cf[i], dataSel);
		}
		 */
	  
	}); 
 
 
/*  
 $("#sede_import_general").change(function() {
	  
	  var selection = $(this).val()	 
	  
	  
	  	var tableImport = $('#tabImportPartecipante').DataTable();
		var cf = tableImport.column(2).data();
	  
		
 		for(var i = 0; i<cf.length;i++){
			
			$("#sede_table_"+cf[i]).val(selection).trigger("change");
			
		} 
	  
		
		
		//tableImport.columns.adjust().draw();
	
	});  */
 
 

	
 var options =  $('#cliente_appoggio option').clone();
 function mockData() {
 	  return _.map(options, function(i) {		  
 	    return {
 	      id: i.value,
 	      text: i.text,
 	    };
 	  });
 	}
 	


 function initSelect2(id_input, data) {
	 
	 if(data == null){
		 data = dataSelect2;
	 }

 	$(id_input).select2({
 	    data: data,
 	    placeholder: 'search',
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
 	        results = _.filter( function(e) {
 	        	
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

 
 $('#myModalErrorContent').on('hidden.bs.modal', function(){
	$(document).css("padding-right", "0px"); 
 });
 
  </script>
  
</jsp:attribute> 
</t:layout>

