<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Device Archiviati
        <!-- <small></small> -->
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
	 Lista Device Archiviati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-left" onClick="callAction('gestioneDevice.do?action=lista_device')">Lista Device</a> 

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 




</div>

</div><br>

<div class="row">
       
       	<div class="col-sm-4">
       		<label>Filtra Company</label>
         
       	  	
        <select id="filtro_company" name="filtro_company" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" >
        <c:if test="${id_company == '0' }">
        <option value="${utl:encryptData(id_company) }"selected>TUTTE LE COMPANY</option>
        </c:if>
         <c:if test="${id_company != '0' }">
         <c:set var="zero_opt" value="0"></c:set>
        <option value="${utl:encryptData(zero_opt) }" >TUTTE LE COMPANY</option>
        </c:if>
        <c:forEach items="${lista_company }" var="cmp">
        <c:if test="${id_company == cmp.id}">
        
        <option value="${utl:encryptData(cmp.id) }" selected>${cmp.ragione_sociale }</option>
        </c:if>
        
        <c:if test="${id_company != cmp.id }">
        
        <option value="${utl:encryptData(cmp.id) }">${cmp.ragione_sociale }</option>
        </c:if>
        </c:forEach>
        
        </select>
      
       	</div>       	
       </div><br>

<div class="row">
<div class="col-sm-12">


 <table id="tabDevice" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID</th>
<th>Codice Interno</th>
<th>Tipo Device</th>
<th>Company</th>
<th>Dipendente</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Distributore</th>
<th>Data Creazione</th>
<th>Data Acquisto</th>
<th>Ubicazione</th>
<th>Denominazione</th>
<th>Rif. fattura</th>

<th style="min-width:150px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_device }" var="device" varStatus="loop">
	<tr id="row_${device.id }" >

	<td>${device.id }</td>	
	<td>${device.codice_interno }</td>
	<td>${device.tipo_device.descrizione }</td>
	<td>${device.company_util.ragione_sociale }</td>
	<td>${device.dipendente.nome } ${device.dipendente.cognome }</td>
	<td>${device.costruttore }</td>
	<td>${device.modello }</td>
	<td>${device.distributore }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${device.data_creazione }"></fmt:formatDate></td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${device.data_acquisto }"></fmt:formatDate></td>
	<td>${device.ubicazione }</td>
	<td>${device.denominazione }</td>
	<td>${device.rif_fattura }</td>
	<td>

	<a class="btn btn-info customTooltip" onClicK="$(this).dblclick()" title="Click per aprire il dettaglio device"><i class="fa fa-search"></i></a>
	 <a class="btn btn-warning customTooltip" onClicK="modificaDevice('${device.id}', '${device.codice_interno }','${device.tipo_device.id }','${device.company_util.id }','${utl:escapeJS(device.denominazione) }','${utl:escapeJS(device.costruttore) }','${utl:escapeJS(device.modello) }','${utl:escapeJS(device.distributore) }','${device.data_acquisto }','${utl:escapeJS(device.ubicazione) }','${device.dipendente.id }', '${utl:escapeJS(device.configurazione) }','${device.data_creazione }','${device.company_proprietaria.id }', '${device.rif_fattura }')" title="Click per modificare il tipo device"><i class="fa fa-edit"></i></a> 
	 <a class="btn btn-info customTooltip" onClicK="modalSoftware('${device.id}')" title="Click per associare un software al device"><i class="fa fa-file-code-o"></i></a>
	 <a class="btn btn-success customTooltip"onClicK="modalYesOrNo('${device.id}')" title="Click per rimettere in servizio il device"><i class="fa fa-check"></i></a>
	 
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



<form id="nuovoDeviceForm" name="nuovoDeviceForm">
<div id="myModalNuovoDevice" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Device</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice interno</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_interno" name="codice_interno" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo device</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_device" name="tipo_device" data-placeholder="Seleziona tipo device..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_device }" var="tipo_device">
        <option value="${tipo_device.id }">${tipo_device.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="denominazione" name="denominazione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Proprietaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_proprietaria" name="company_proprietaria" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
       

       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Operatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="dipendente" name="dipendente" data-placeholder="Seleziona operatore..." class="form-control select2" style="width:100%" >
        <option value=""></option>
                  <option value="0">Nessun Operatore</option>
        <c:forEach items="${lista_dipendenti }" var="dipendente">
        <option value="${dipendente.id }_${dipendente.committente.id}">${dipendente.cognome } ${dipendente.nome } </option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Utilizzatrice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company" disabled name="company" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
       
      
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="costruttore" name="costruttore" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Distributore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="distributore" name="distributore" class="form-control" type="text" style="width:100%" >
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto" name="data_acquisto" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data creazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_creazione" name="data_creazione" class="form-control datepicker" type="text" style="width:100%">
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ubicazione" name="ubicazione" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Label configurazione predefinite</label>
       	</div>
       	<div class="col-sm-8">      
       	  	
        <select id="label_config" data-placeholder="Seleziona configurazione..." class="form-control select2" multiple style="width:100%" >
        <option value=""></option>
        <c:forEach items="${lista_configurazioni}" var="config">
        <option value="${config.id }">${config.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>     
       		<div class="col-sm-1">  
		<a class="btn btn-primary customTooltip pull-right" title="Crea nuova label" onClick="modalNuovaLabel('')"><i class="fa fa-plus"></i></a>
	
	  </div>    	
       </div><br>
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea id="configurazione" name="configurazione" class="form-control " rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rif. fattura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rif_fattura" name="rif_fattura" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
<input type="hidden" id="nuova_label_configurazione" name="nuova_label_configurazione">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDeviceForm" name="modificaDeviceForm">
<div id="myModalModificaDevice" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Device</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice interno</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_interno_mod" name="codice_interno_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo device</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_device_mod" name="tipo_device_mod" data-placeholder="Seleziona tipo device..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_device }" var="tipo_device">
        <option value="${tipo_device.id }">${tipo_device.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="denominazione_mod" name="denominazione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Proprietaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_proprietaria_mod" name="company_proprietaria_mod" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
       

       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Operatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="dipendente_mod" name="dipendente_mod" data-placeholder="Seleziona operatore..." class="form-control select2" style="width:100%" >
        
          <option value="">Nessun Operatore</option>
          <option value="0">Nessun Operatore</option>
        <c:forEach items="${lista_dipendenti }" var="dipendente">
        <option value="${dipendente.id }_${dipendente.committente.id}">${dipendente.cognome } ${dipendente.nome }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_mod" name="company_mod" disabled data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
          <option value="0">NESSUNA COMPANY</option>
        </select>
       			
       	</div>       	
       </div><br>
      
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="costruttore_mod" name="costruttore_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Distributore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="distributore_mod" name="distributore_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto_mod" name="data_acquisto_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data creazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_creazione_mod" name="data_creazione_mod" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ubicazione_mod" name="ubicazione_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Label configurazioni predefinite</label>
       	</div>
       	<div class="col-sm-8">      
       	  	
        <select id="label_config_mod" data-placeholder="Seleziona label configurazione..." class="form-control select2" multiple style="width:100%" >
        <option value=""></option>
        <c:forEach items="${lista_configurazioni}" var="config">
        <option value="${config.id }">${config.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>   

	<div class="col-sm-1">  
	<a class="btn btn-primary customTooltip pull-right" title="Crea nuova label" onClick="modalNuovaLabel('_mod')"><i class="fa fa-plus"></i></a>
	
	  </div>  	
       </div><br>
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <textarea id="configurazione_mod" name="configurazione_mod" class="form-control " rows="5" style="width:100%" ></textarea>
       			
       	</div>       	
       </div><br>
       
       
                    <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rif. fattura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rif_fattura_mod" name="rif_fattura_mod" class="form-control " type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
		<input type="hidden" id="nuova_label_configurazione_mod" name="nuova_label_configurazione_mod">
		<input type="hidden" id="id_device" name="id_device">
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
      	Sei sicuro di voler rimettere in servizio il device?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_device">
      <a class="btn btn-primary" onclick="eliminaDevice($('#id_elimina_device').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

  <div id="modalNuovaLabel" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova label configurazione</h4>
      </div>
       <div class="modal-body">       
     	<input type="text" id="descrizione_label" name="descrizione_label" class="form-control">
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id="isMod">
      
      
		<a class="btn btn-primary" onclick="assegnaValoreOpzione($('#isMod').val())" >Salva</a>
      </div>
    </div>
  </div>

</div>


<div id="modalSoftwareTot" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista software</h4>
      </div>
       <div class="modal-body">
       		
        <table id="tabSoftwareTot" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th></th>
<th>ID</th>
<th>Nome</th>
<th>Produttore</th>
<th>Stato validazione</th>
<th>Data validazione</th>
<th>Product key</th>
<th>Autorizzato</th>
<th>Versione</th>
<th></th>
 </tr></thead>
 
 <tbody> 

 </tbody>
 </table>  
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_device_software" >
      	
      	<a class="btn btn-primary" onClick="associaSoftware()">Associa software selezionati</a>
      	
      	
     
      </div>
    </div>
  </div>
</div>



  <div id="modalValidazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Validazione</h4>
      </div>
       <div class="modal-body">       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Stato validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="stato_validazione" name="stato_validazione" data-placeholder="Seleziona stato validazione..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_stati_validazione }" var="stato">
        <option value="${stato.id }">${stato.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
               
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data validazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_validazione" name="data_validazione" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Autorizzato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="autorizzazioni" name="autorizzazioni" data-placeholder="Seleziona autorizzazione..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        
        <option value="SI">SI</option>
        <option value="NO">NO</option>
        
        
        
        </select>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Product-key</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <input type="text" id="product_key" name="product_key" class="form-control">
       			
       	</div>       	
       </div><br>
       
       
     	
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id = "id_software_validazione" name="id_software_validazione">
      
		<a class="btn btn-primary" onclick="salvaValidazione()" >Salva validazione</a>
      </div>
    </div>
  </div>

</div>




 <div id="myModal" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Registro Attività</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
            <li class="active" id="li_dettaglio"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="detttaglioTab">Dettaglio</a></li>
              <li class="" id="li_registro_attivita"><a href="#registro_attivita" data-toggle="tab" aria-expanded="true"   id="registroAttivitaTab">Registro attività</a></li>
              <li class="" id="li_gestione_procedure"><a href="#gestione_procedure" data-toggle="tab" aria-expanded="true"   id="gestioneProcedureTab">Gestione procedure</a></li>
              <li class="" id="li_lista_allegati"><a href="#lista_allegati" data-toggle="tab" aria-expanded="true"   id="listaAllegatiTab">Lista allegati</a></li>
            </ul>
            
            <div class="tab-content">
            
            <div class="tab-pane active" id="dettaglio">
            
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice interno</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_interno_dtl" name="codice_interno_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo device</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_device_dtl" name="tipo_device_dtl" data-placeholder="Seleziona tipo device..." class="form-control select2" style="width:100%" disabled>
        <option value=""></option>
        <c:forEach items="${lista_tipi_device }" var="tipo_device">
        <option value="${tipo_device.id }">${tipo_device.descrizione }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Denominazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="denominazione_dtl" name="denominazione_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company Proprietaria</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_proprietaria_dtl" name="company_proprietaria_dtl" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" disabled>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Company</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="company_dtl" name="company_dtl" data-placeholder="Seleziona company..." class="form-control select2" style="width:100%" disabled>
        <option value=""></option>
        <c:forEach items="${lista_company }" var="cmp">
        <option value="${cmp.id }">${cmp.ragione_sociale }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Operatore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="dipendente_dtl" name="dipendente_dtl" data-placeholder="Seleziona operatore..." class="form-control select2" style="width:100%" disabled >
        <option value=""></option>
        <c:forEach items="${lista_dipendenti }" var="dipendente">
        <option value="${dipendente.id }">${dipendente.nome } ${dipendente.cognome }</option>
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>
       
      
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="costruttore_dtl" name="costruttore_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_dtl" name="modello_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Distributore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="distributore_dtl" name="distributore_dtl" class="form-control" type="text" style="width:100%" readonly>
       			
       	</div>          	
       	
       	   	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data acquisto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_acquisto_dtl" name="data_acquisto_dtl" class="form-control datepicker" type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data creazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_creazione_dtl" name="data_creazione_dtl" class="form-control datepicker" type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ubicazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ubicazione_dtl" name="ubicazione_dtl" class="form-control " type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
       
             
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Configurazione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <textarea id="configurazione_dtl" name="configurazione_dtl" class="form-control " rows="5" style="width:100%" readonly></textarea>
       			
       	</div>       	
       </div><br>
       
       
                      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rif. fattura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <input id="rif_fattura_dtl" name="rif_fattura_dtl" class="form-control " type="text" style="width:100%" readonly>
       			
       	</div>       	
       </div><br>
       
      <div class="row">
       
       	<div class="col-sm-3">
       	<label>Software Associati</label>
       	</div>
       	</div><br>
       
		       
		     <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
		 <thead><tr class="active">
		
		
		<th>ID</th>
		<th>Nome</th>
		<th>Produttore</th>
		<th>Stato validazione</th>
		<th>Data validazione</th>
		<th>Product key</th>
		<th>Autorizzato</th>
		<th>Versione</th>
		 </tr></thead>
		 
		 <tbody> 
		
		 </tbody>
		 </table>  
       
       
       
            
            </div>
            
              <div class="tab-pane" id="registro_attivita">


    			</div> 

	<div class="tab-pane" id="gestione_procedure">


    			</div> 


<div class="tab-pane" id="lista_allegati">


    			</div> 

              <!-- /.tab-pane -->


              
              
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="device_dettaglio">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>





<form id="formNuovaAttivita" name="formNuovaAttivita" >
<div id="modalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaAttivita').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attivita</h4>
      </div>
       <div class="modal-body">     
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo evento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_evento" name="tipo_evento" data-placeholder="Seleziona tipo evento..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_evento }" var="tipo">
        <c:if test="${tipo.id == 2}">
        <option value="${tipo.id }" selected>${tipo.descrizione }</option>
        </c:if>
         <c:if test="${tipo.id != 2}">
        <option value="${tipo.id }">${tipo.descrizione }</option>
        </c:if>
        
        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione" name="descrizione" required>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Label tipo intervento</label>
       	</div>
       	<div class="col-sm-8">      
       	  	
        <select id="label_tipo" name="label_tipo" data-placeholder="Seleziona label..." class="form-control select2" style="width:100%" multiple>
        <option value=""></option>
        <c:forEach items="${lista_label_tipo_intervento }" var="tipo">
        
        <option value="${tipo.id }">${tipo.descrizione }</option>
      
        </c:forEach>
        
        </select>
       			
       	</div>       
       	<div class="col-sm-1">  
		<a class="btn btn-primary customTooltip pull-right" title="Crea nuova label" onClick="modalNuovaLabelTipo('')"><i class="fa fa-plus"></i></a>
	
	  </div>  	
       </div><br> 
        <div class="row">
         	<div class="col-sm-3">
       		<label>Tipo intervento</label>
       	</div>
       <div class="col-xs-9">
       

       <textarea id="tipo_intervento" name="tipo_intervento" rows="3" class="form-control" ></textarea>
       </div>
       </div><br>
       
              
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="number" step="1" min="0" class="form-control " id="frequenza" name="frequenza" >
       			
       	</div>       	
       </div><br> 
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data" name="data" required>
       			
       	</div>       	
       </div><br> 
       

       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossima</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="data_prossima" name="data_prossima">
       			
       	</div>       	
       </div><br> 
      
        <div class="row">
       <div class="col-xs-12">
       <label>Note evento</label>

       <textarea id="note_evento" name="note_evento" rows="3" class="form-control" ></textarea>
       </div>
       </div>
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_device" name="id_device" value="${id_device }">
      <input type="hidden" id="nuova_label_tipo" name="nuova_label_tipo">
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>




</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />



</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovoDevice(){
	
	var data = new Date()
	
	$('#data_creazione').val(data.toLocaleDateString("it-IT"));
	$('#myModalNuovoDevice').modal();
	
}

function modalNuovaLabel(isMod){
	
	$('#isMod').val(isMod);
	
	$('#modalNuovaLabel').modal();
}


var id_new_label = 0;
function assegnaValoreOpzione(mod){
	
	var data = {
		    id: "new_"+id_new_label,
		    text: $('#descrizione_label').val().toUpperCase()
		};

		var newOption = new Option(data.text, data.id, false, false);
		
		var opt = $('#label_config'+mod).val();
			
			$('#label_config'+mod).append(newOption);
			
		
			if(opt==null){
				opt= [];
			}
			opt.push("new_"+id_new_label);
			
			$('#label_config'+mod).val(opt).trigger('change');
				
			
			if($('#nuova_label_configurazione'+mod).val()==''){
				$('#nuova_label_configurazione'+mod).val($('#descrizione_label').val().toUpperCase());
			}else{
				$('#nuova_label_configurazione'+mod).val($('#nuova_label_configurazione'+mod).val()+";"+$('#descrizione_label').val().toUpperCase());	
			}

			$('#modalNuovaLabel').modal('hide');
			id_new_label++;
	
}


$('#modalNuovaLabel').on('hidden.bs.modal',function(){
	
	$('#descrizione_label').val("");
});


function createTableAssociati(){
	
	var id_device = $('#device_dettaglio').val()

	
	dataString ="action=software_associati&id_device="+ id_device;
    exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
    	
    	  var result = JSON.parse(datab);
    	  
    	  var table_data = [];
    	  
    	  var lista_software_associati = result.lista_software_associati;
      	  
      	  if(result.success){ 

				var table_data = [];
				
				  for(var i = 0; i<lista_software_associati.length;i++){
					  var dati = {};
					  
					  dati.id = lista_software_associati[i].software.id; 
					  dati.nome = lista_software_associati[i].software.nome;
					  dati.produttore = lista_software_associati[i].software.produttore;
					 
					  if(lista_software_associati[i].stato_validazione!=null){
				  			dati.stato = lista_software_associati[i].stato_validazione.descrizione;  
				  		  }else{
				  			dati.stato = '' 
				  		  }
					  if(lista_software_associati[i].data_validazione!=null){
				  			dati.data_validazione = lista_software_associati[i].data_validazione;  
				  		  }else{
				  			dati.data_validazione = '' 
				  		  }
					  if(lista_software_associati[i].product_key!=null){
				  			dati.product_key = lista_software_associati[i].product_key;  
				  		  }else{
				  			dati.product_key = '' 
				  		  }
					  if(lista_software_associati[i].autorizzato!=null){
						  dati.autorizzazioni = lista_software_associati[i].autorizzato;
					  }else{
						  dati.autorizzazioni = '';
					  }
					  if(lista_software_associati[i].software!=null){
						  dati.versione =  lista_software_associati[i].software.versione;
					  }else{
						  dati.versione =  '';
					  }
					  
					 
					  table_data.push(dati);
				  }
				  			
				var table = $('#tabSoftware').DataTable();
				
				table.clear().draw();
				
				table.rows.add(table_data).draw();
				
				
				
				table.columns.adjust().draw();
				
				 $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll');
				
		       	 pleaseWaitDiv = $('#pleaseWaitDialog');
		   	  pleaseWaitDiv.modal('hide');
				
			
      	  }
	});
}


function associaSoftware(){
	
	
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var table = $('#tabSoftwareTot').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();
		var selezionati ="";
		var validazioni ="";
		var date_validazioni = "";
		var product_key = "";
		var autorizzazioni = "";
 		 for(i=0; i< dataSelected.length; i++){
			dataSelected[i];
			
			selezionati = selezionati +dataSelected[i].id+";;";
			
			if(dataSelected[i].stato=='VALIDATO'){
				validazioni = validazioni +1+";;";	
			}else if(dataSelected[i].stato == 'IN CORSO DI VALIDAZIONE'){
				validazioni = validazioni +2+";;";	
			}else{
				validazioni = validazioni +3+";;";	
			}
							
		
			date_validazioni = date_validazioni +dataSelected[i].data_validazione+";;";			
			
			product_key = product_key +dataSelected[i].product_key+";;";
						
			autorizzazioni = autorizzazioni +dataSelected[i].autorizzazioni+";;";
			
			
		}  
		
		console.log(selezionati);		
		
		dataObj = {},
		dataObj.selezionati = selezionati;
		dataObj.stati_validazioni = validazioni;
		dataObj.date_validazioni = date_validazioni;
		dataObj.product_key = product_key;
		dataObj.autorizzazioni = autorizzazioni;
		dataObj.id_device = $('#id_device_software').val();
		
		callAjax(dataObj, "gestioneDevice.do?action=salva_associazione");
		table.rows().deselect();
}

function controllaAssociati(table, lista_software_associati){
	
	//var dataSelected = table.rows( { selected: true } ).data();
	
	var oTable = $('#tabSoftwareTot').dataTable();
	var data = table.rows().data();
	for(var i = 0;i<lista_software_associati.length;i++){
	
		var val = lista_software_associati[i].software.id;
		
	 	
		var index = table.row("#row_sw_"+ val, { page: 'all' });
	 	
	 	
	 	if(lista_software_associati[i].stato_validazione!=null){
	 	    oTable.fnUpdate(lista_software_associati[i].stato_validazione.descrizione, index, 5 );
	 	}
	 	
	 	if(lista_software_associati[i].data_validazione!=null){
	 		oTable.fnUpdate(lista_software_associati[i].data_validazione , index, 6 );
	 	}
	 	
	 	if(lista_software_associati[i].product_key!=null){
	 		oTable.fnUpdate(lista_software_associati[i].product_key , index, 7 );
	 	}
	 	
	 	if(lista_software_associati[i].autorizzato!=null){
	 		oTable.fnUpdate(lista_software_associati[i].autorizzato , index, 8 );
	 	} 
	 	
	 	table.row( "#row_sw_"+ val, { page:   'all'}).select();

	}

	
}


function modalSoftware(id_device){
	
	$('#id_device_software').val(id_device)
	
	dataString ="action=associa_software&id_device="+ id_device;
    exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
  	  	
  	  var result = JSON.parse(datab);
  	  
  	  if(result.success){  		  
  		 
  		var t_data = [];
  		
  		var lista_software = result.lista_software;
  		var lista_software_associati = result.lista_software_associati;
  		
  	  for(var i = 0; i<lista_software.length;i++){
  		  var dati = {};
  		  
  		  dati.empty = '<td></td>';
  		  dati.check='<td></td>';
  		  dati.id = lista_software[i].id; 
  		  dati.nome = lista_software[i].nome;
  		  dati.produttore = lista_software[i].produttore;
  		 dati.stato = '';
  		 dati.data_validazione ='';
  		 dati.product_key = '';
  		 dati.autorizzazioni = '';
  		 dati.versione = lista_software[i].versione;
  		  dati.validazione = '<td><a class="btn btn-primary customTooltip" title="Aggiungi validazione" onClick="modalValidazione('+lista_software[i].id+')"><i class="fa fa-plus">Validazione</i></a></td>'
  		t_data.push(dati);
  	  }
  	  
  	
  	  



  	var table = $('#tabSoftwareTot').DataTable();
  	
  	table.clear().draw();
  	
  	table.rows.add(t_data).draw();
  	
  	table.columns.adjust().draw();
  	

  	var p = table.rows({ page: 'all' }).nodes();
  	 
  	 for (var i = 0; i < p.length; i++) {
  		p[i].id = "row_sw_"+ p[i].childNodes[2].innerText
	}
  	
  	controllaAssociati(table, lista_software_associati);
  	$('#modalSoftwareTot').modal();
  	
  	
  	
  	$('#modalSoftwareTot').on('shown.bs.modal', function () {
  	var table = $('#tabSoftwareTot').DataTable();
  	table.columns.adjust().draw();
  	
  	});
  	  
  
    }
    });
}

function modalValidazione(id){
	
	$('#id_software_validazione').val(id);
	
	var table = $('#tabSoftwareTot').DataTable();
	
	var stato = table.cell("#row_sw_"+id, 5).data();
	var data = table.cell("#row_sw_"+id, 6).data();
	var pk = table.cell("#row_sw_"+id, 7).data();
	var aut = table.cell("#row_sw_"+id, 8).data();
	
	
	if(stato!=null && stato == "VALIDATO"){
		$('#stato_validazione').val("1");
	}else if(stato!=null && stato == "IN CORSO DI VALIDAZIONE"){
		$('#stato_validazione').val("2");
	}else if(stato!=null && stato == "NON VALIDATO"){
		$('#stato_validazione').val("3");
	}else{
		$('#stato_validazione').val("");
	}
	
	$('#stato_validazione').change();
	
	if(data==''){
		data = new Date();
		data = data.toLocaleDateString("it-IT")
	}
	
	$('#data_validazione').val(data);
	$('#product_key').val(pk);
	$('#autorizzazioni').val(aut);
	$('#autorizzazioni').change();
	
	$('#modalValidazione').modal();
	
}


$('#stato_validazione').change(function(){
	
	if($(this).val()==1){
		$('#autorizzazioni').val("SI");
	}else if($(this).val()==''){
		$('#autorizzazioni').val("");
	}else{
		$('#autorizzazioni').val("NO");
	}
        $('#autorizzazioni').change();
});

function salvaValidazione(){
	

	var val = $('#id_software_validazione').val();
	 var opt = $('#stato_validazione').val();
	
	var stato = $('#stato_validazione option[value="'+opt+'"]').text();
	var data_val = $('#data_validazione').val();
	var pk = $('#product_key').val();
	var aut = $('#autorizzazioni').val();
	
	
	
	var oTable = $('#tabSoftwareTot').dataTable();
	var table =  $('#tabSoftwareTot').DataTable();
	
	//var data = table.rows().data();
/*  	for(var i = 0;i<lista_software_associati.length;i++){
	
		var val = lista_software_associati[i].software.id; */
		var index = $('#row_sw_'+val)[0]._DT_RowIndex;	
		table.row( "#row_sw_"+ val, { page:   'all'}).select();
	 	
	 	//oTable.fnUpdate(lista_software_associati[i].stato_validazione.id , index, 5 );
	 	
	 	
	 	if(data_val!=null){
	 		oTable.fnUpdate(data_val , index, 6 , false);
	 	}
	 	
	 	if(stato!=null){
	 	    oTable.fnUpdate(stato , index, 5, false );
	 	}
	 	if(pk!=null){
	 	    oTable.fnUpdate(pk , index, 7, false  );
	 	}
	 	if(aut!=null){
	 	    oTable.fnUpdate(aut , index, 8, false  );
	 	}
	 	
	 	
	//}	 	
	
	
	
/* 	 var opt = $('#stato_validazione').val();
	
	$("#label_stato_val_"+val).html("<label>"+$('#stato_validazione option[value="'+opt+'"]').text()+"</label>");
	$("#label_data_val_"+val).html("<label>"+$('#data_validazione').val()+"</label>");
	$("#label_product_key_"+val).html("<label>"+$('#product_key').val()+"</label>");
	$("#label_autorizzazione_"+val).html("<label>"+$('#autorizzazioni').val()+"</label>");
	
	
	$("#stato_val_"+val).val(opt);
	$("#data_val_"+val).val($('#data_validazione').val());
	$("#product_key_"+val).val($('#product_key').val());
	$("#autorizzazione_"+val).val($('#autorizzazioni').val()); */
	
	$('#modalValidazione').modal('hide');
}

$('#modalValidazione').on('hidden.bs.modal', function(){
	
	$('#stato_validazione').val("");
	$('#stato_validazione').change();
	$('#data_validazione').val("")
	$('#product_key').val("")
	$('#autorizzazioni').val("");
	$('#autorizzazioni').change();
});

function modificaDevice(id_device, codice_interno, id_tipo_device, id_company, denominazione, costruttore, modello, distributore, data_acquisto, ubicazione, id_dipendente, configurazione, data_creazione, id_company_prop, rif_fattura){
	
	$('#id_device').val(id_device);
	$('#codice_interno_mod').val(codice_interno);
	$('#tipo_device_mod').val(id_tipo_device);
	$('#tipo_device_mod').change();
	
	if(id_company==null){
		$('#company_mod').val(0);
	}else{
		$('#company_mod').val(id_company);	
	}
	
	if(id_company_prop==null){
		$('#company_proprietaria_mod').val(0);
	}else{
		$('#company_proprietaria_mod').val(id_company_prop);	
	}
	
	$('#company_mod').change();
	$('#company_proprietaria_mod').change();
	$('#denominazione_mod').val(denominazione);
	$('#costruttore_mod').val(costruttore);
	$('#modello_mod').val(modello);
	$('#distributore_mod').val(distributore);
	$('#ubicazione_mod').val(ubicazione);
	$('#rif_fattura_mod').val(rif_fattura);
	if(data_acquisto!=null && data_acquisto!=''){
		$('#data_acquisto_mod').val(Date.parse(data_acquisto).toString("dd/MM/yyyy"));	
	}
	if(data_creazione!=null && data_creazione!=''){
		$('#data_creazione_mod').val(Date.parse(data_creazione).toString("dd/MM/yyyy"));	
	}
	if(id_dipendente==0|| id_dipendente == null){
		$('#dipendente_mod').val(0);	
	}else{
		$('#dipendente_mod').val(id_dipendente+"_"+id_company);
	}
	
	$('#dipendente_mod').change();
	
	$('#configurazione_mod').val(configurazione);

	$('#myModalModificaDevice').modal();
}


var columsDatatables = [];

$("#tabDevice").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDevice thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDevice thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$("#tabSoftwareTot").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    $('#tabSoftwareTot thead th').each( function () {
     	
    	  var title = $('#tabSoftwareTot thead th').eq( $(this).index() ).text();
    	
    	  if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="" type="text" /></div>');	
	    	}

    	} );
    
    

} );


function modalYesOrNo(id_device){
	
	
	$('#id_elimina_device').val(id_device);
	$('#myModalYesOrNo').modal();
	
}

function eliminaDevice(id_device){
	
	var dataObj = {};
	dataObj.id_device = id_device;
	dataObj.stato = 0;
	
	callAjax(dataObj, "gestioneDevice.do?action=elimina_device");
	
}

var content_id = 0;

$('#dipendente').change(function(){
	
	var value = $(this).val().split("_")[1];
	if($(this).val()=="0"){
		value = "0";
	}
	
	if(value!=null && value!=''){
		$('#company').val(value);
		$('#company').change();
	}
	
});

$('#dipendente_mod').change(function(){
	
	var value = $(this).val().split("_")[1];
	if($(this).val()=="0"){
		value = "0";
	}
	
	if(value!=null && value!=''){
		$('#company_mod').val(value);
		$('#company_mod').change();
	}
	
});





$(document).ready(function() {
 
	
    $('#tabDevice').on( 'dblclick','tr', function () {   
    	
    	pleaseWaitDiv = $('#pleaseWaitDialog');
	   	  pleaseWaitDiv.modal('hide');
    	var id = $(this).attr('id').split("_")[1];
    	
    	$('#device_dettaglio').val(id);
    	
      	if(content_id == 0){
      		
      	$('#dettaglio').addClass("active");
      	$('#li_dettaglio').addClass("active");
      	$('#li_registro_attivita').removeClass("active");
      	$('#li_gestione_procedure').removeClass("active");
      	$('#li_lista_allegati').removeClass("active");
      	

      	 exploreModal("gestioneDevice.do","action=dettaglio_device&id_device="+id, null, function(datab,textStatusb){
      		 
      		 var result = JSON.parse(datab);
      		 
      		 if(result.success){
      			 
				var device = result.device;
				
				$('#id_device_dtl').val(device.id);
				$('#codice_interno_dtl').val(device.codice_interno);
				$('#tipo_device_dtl').val(device.tipo_device.id);
				$('#tipo_device_dtl').change();
				if(device.company_util!=null){
					$('#company_dtl').val(device.company_util.id);	
				}
				
				$('#company_dtl').change();
				$('#denominazione_dtl').val(device.denominazione);
				$('#costruttore_dtl').val(device.costruttore);
				$('#modello_dtl').val(device.modello);
				$('#distributore_dtl').val(device.distributore);
				$('#ubicazione_dtl').val(device.ubicazione);
				$('#rif_fattura_dtl').val(device.rif_fattura);
				$('#company_proprietaria_dtl').val(device.company_proprietaria);
				if(device.data_acquisto!=null && device.data_acquisto!=''){
					$('#data_acquisto_dtl').val(Date.parse(device.data_acquisto).toString("dd/MM/yyyy"));	
				}
				if(device.data_creazione!=null && device.data_creazione!=''){
					$('#data_creazione_dtl').val(Date.parse(device.data_creazione).toString("dd/MM/yyyy"));	
				}
				if(device.dipendente!=null){
					$('#dipendente_dtl').val(device.dipendente.id);
					$('#dipendente_dtl').change();
				}
								
				
				$('#configurazione_dtl').val(device.configurazione);
				
				createTableAssociati()
      			 
      		 }
      		 
      		
      	 });
      	   
      		
      	}	 
      	
      	if(content_id == 1){
      		
    		
     	   exploreModal("gestioneDevice.do","action=registro_attivita&id_device="+id+"&id_company=${id_company}","#registro_attivita");
     	    $( "#myModal" ).modal();
     	    $('body').addClass('noScroll');
      	}
      	
      	if(content_id == 2){
      		
    		
      	   exploreModal("gestioneDevice.do","action=lista_procedure_device&id_device="+id,"#gestione_procedure");
      	    $( "#myModal" ).modal();
      	    $('body').addClass('noScroll');
       	}
      	
    	if(content_id == 3){
      		
    		
       	   exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device="+id,"#lista_allegati");
       	  
        	}
		
	});
    
    
    
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {


    	var  contentID = e.target.id;

    	var id = $('#device_dettaglio').val();
    	
    	if(contentID == "dettaglioTab"){
    		
    		 exploreModal("gestioneDevice.do","action=dettaglio_device&id_device="+id,null, function(datab,textStatusb){
          		 
          		 var result = JSON.parse(datab);
          		 
          		 if(result.success){
          			 
    				var device = result.device;
    				
    				$('#id_device_dtl').val(device.id);
    				$('#codice_interno_dtl').val(device.codice_interno);
    				$('#tipo_device_dtl').val(device.tipo_device.id);
    				$('#tipo_device_dtl').change();
    				if(device.company!=null){
    					$('#company_dtl').val(device.company.id);
    				}   					
    				$('#company_dtl').change();
    				$('#denominazione_dtl').val(device.denominazione);
    				$('#costruttore_dtl').val(device.costruttore);
    				$('#modello_dtl').val(device.modello);
    				$('#distributore_dtl').val(device.distributore);
    				$('#ubicazione_dtl').val(device.ubicazione);
    				if(device.data_acquisto!=null && device.data_acquisto!=''){
    					$('#data_acquisto_dtl').val(Date.parse(device.data_acquisto).toString("dd/MM/yyyy"));	
    				}
    				
    				if(device.dipendente!=null){
    					$('#dipendente_dtl').val(device.dipendente.id);
    					$('#dipendente_dtl').change();
    				}
    				$('#dipendente_dtl').change();
    				
    				$('#configurazione_dtl').val(device.configurazione);
          			 
          		 }
          		 
          		 
          		 
          		 
          	 });
          	    $( "#myModal" ).modal();
          	    $('body').addClass('noScroll');
    	}
    	if(contentID == "registroAttivitaTab"){
    		$("#myModal").addClass("modal-fullscreen");
    		exploreModal("gestioneDevice.do","action=registro_attivita&id_device="+id+"&id_company=${id_company}","#registro_attivita");
    	}
    	
    	if(contentID == "gestioneProcedureTab"){
    		
       	   exploreModal("gestioneDevice.do","action=lista_procedure_device&id_device="+id,"#gestione_procedure");
       	    $( "#myModal" ).modal();
       	    $('body').addClass('noScroll');
        }
    	
    	if(contentID == "listaAllegatiTab"){
      		
    		
    		  exploreModal("gestioneDevice.do","action=lista_allegati_device&id_device="+id,"#lista_allegati");
        	   
         }
	});
    
	

     $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabDevice').DataTable({
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
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 13 },		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDevice_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDevice').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	

	
	  tabSW = $('#tabSoftware').DataTable({
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
	  ordering: false,
		  columns : [
			  {"data" : "id"},
	    	  {"data" : "nome"},
	    	  {"data" : "produttore"},
	    	  {"data" : "stato"},
	    	  {"data" : "data_validazione"},
	    	  {"data" : "product_key"},
	    	  {"data" : "autorizzazioni"},
	    	  {"data" : "versione"}
	    	  
	    	  
	  ]
	
	
});
	  
	  
	  
	  
	  tabSWTot = $('#tabSoftwareTot').DataTable({
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
      select: {
      	style:    'multi-shift',
      	selector: 'td:nth-child(2)'
  	},
	  ordering: false,
		  columns : [
			  {"data" : "empty"},  
		    	{"data" : "check"},  
			  {"data" : "id"},
	    	  {"data" : "nome"},
	    	  {"data" : "produttore"},
	    	  {"data" : "stato"},
	    	  {"data" : "data_validazione"},
	    	  {"data" : "product_key"},
	    	  {"data" : "autorizzazioni"},
	    	  {"data" : "versione"},
	    	  {"data" : "validazione"}
	    	  
	    	  
	  ],
	  columnDefs: [
{ className: "select-checkbox", targets: 1,  orderable: false }
	]
});
	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });
	  
	  tabSWTot.columns().eq( 0 ).each( function ( colIdx ) {
	   	  $( 'input', tabSWTot.column( colIdx ).header() ).on( 'keyup', function () {
	   		tabSWTot
	   	          .column( colIdx )
	   	          .search( this.value )
	   	          .draw();
	   	  } );
	   	} );  
	  
	  
    });

previouslySelected = []
    $('#label_config').on('change', function(e, params){
    	
    	var value = $(this).val();
    	
    	if(value!=null){
    		var x = value.filter(function (element) {
                return previouslySelected.indexOf(element) == -1;
            });
        	
        	previouslySelected = value;
        	
        	var text = $('#label_config option[value="'+x+'"]').text()
        	if($('#configurazione').val()==''){
        		if(text!= null && text!=''){
        			$('#configurazione').val($('#configurazione').val()+text+":");       	
        		}
        		
        	}else{
        		if(text!= null && text!=''){
        			$('#configurazione').val($('#configurazione').val()+"\n"+text+":");
        		}
        			
        	}
    	
    	
    	
    	}
    	
    	
    });
    
    
    
previouslySelectedMod = []
$('#label_config_mod').on('change', function(e, params){
	
	var value = $(this).val();
	
	if(value!=null){
		var x = value.filter(function (element) {
            return previouslySelectedMod.indexOf(element) == -1;
        });
    	
    	previouslySelectedMod = value;
    	
    	var text = $('#label_config_mod option[value="'+x+'"]').text()
    	if($('#configurazione_mod').val()==''){
    		if(text!= null && text!=''){
    			$('#configurazione_mod').val($('#configurazione_mod').val()+text+":");       	
    		}
    		
    	}else{
    		if(text!= null && text!=''){
    			$('#configurazione_mod').val($('#configurazione_mod').val()+"\n"+text+":");
    		}    			
    	}	
	}	
});

$('#modificaDeviceForm').on('submit', function(e){
	 e.preventDefault();
	 $('#company_mod').removeAttr("disabled");
	 callAjaxForm('#modificaDeviceForm','gestioneDevice.do?action=modifica_device');
});
 

 
 $('#nuovoDeviceForm').on('submit', function(e){
	 e.preventDefault();
	 $('#company').removeAttr("disabled");
	 callAjaxForm('#nuovoDeviceForm','gestioneDevice.do?action=nuovo_device');
	
});
 
 
 

$('#myModal').on("hidden.bs.modal", function(){
	$(document.body).css('padding-right', '0px');
$('.modal-backdrop').hide();
$('body').removeClass('noScroll')
	
})
 
 
 $('#filtro_company').change(function(){
	
	 var id_company = $(this).val()
	 
	 callAction('gestioneDevice.do?action=lista_archiviati&id_company='+id_company);
	 
	 
 });
 
 
  </script>
  
</jsp:attribute> 
</t:layout>


