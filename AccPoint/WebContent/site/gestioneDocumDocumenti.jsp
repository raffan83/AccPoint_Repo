<meta http-equiv = "Content-type" content = "text / html; charset = utf-8" />
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
      <c:if test="${data_scadenza == null }">
        Lista Documenti
        </c:if>
       <c:if test="${data_scadenza != null }">
        Lista Documenti in scadenza il <fmt:formatDate value="${data_scadenza }" pattern="dd/MM/yyyy"/>
        </c:if>
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Documenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('F1') }">
<div class="row">
<div class="col-xs-12">


 <a class="btn btn-primary pull-left" onClick="callAction('gestioneDocumentale.do?action=staging_area')"><i class="fa fa-list"></i> Documenti da approvare<span class="badge bg-yellow">${numero_documenti_da_approvare }</span></a>


<a class="btn btn-primary pull-right" onClick="callAction('gestioneDocumentale.do?action=lista_obsoleti')"><i class="fa fa-list"></i> Documenti obsoleti</a> 


</div>

</div><br>
<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="modalNuovoDocumento()"><i class="fa fa-plus"></i> Nuovo Documento</a> 
</div>
</div><br>
</c:if>
<div class="row">
<div class="col-sm-12">

 <table id="tabDocumDocumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome Documento</th>
<th>Numero Documento</th>
<th>Data caricamento</th>
<th>Frequenza (mesi)</th>
<th>Data scadenza</th>
<th>Stato</th>
<th>Rilasciato</th>
<th style="min-width:185px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_documenti}" var="documento" varStatus="loop">
 	<c:if test="${documento.stato.id==1 }">
 	<tr id="row_${loop.index}" style="background-color:#00ff80" >
 	</c:if>
 	<c:if test="${documento.stato.id==2 }">
	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
	</c:if>
	 	<c:if test="${documento.stato.id==3 }">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:if>
	<td>${documento.id }</td>	
	<td>${documento.committente.nome_cliente } - ${documento.committente.indirizzo_cliente }</td>
	<td><a href="#" class="btn customTooltip customlink" onClick="callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore=${utl:encryptData(documento.fornitore.id)}')">${documento.fornitore.ragione_sociale }</a></td>
	<td>${documento.nome_documento }</td>
	<td>${documento.numero_documento }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_caricamento}" /></td>
	<td>${documento.frequenza_rinnovo_mesi }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_scadenza}" /></td>
	<td>${documento.getStato().getNome() }</td>
	<td>${documento.rilasciato }</td>
		
	<td>	
	<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento&id_documento=${utl:encryptData(documento.id)}" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>
	 <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('F1') }">
	  <a class="btn btn-warning" onClicK="modificaDocumentoModal('${documento.committente.id }','${documento.id}','${documento.fornitore.id}','${utl:escapeJS(documento.nome_documento)}','${documento.data_caricamento}','${documento.frequenza_rinnovo_mesi }',
	   '${documento.data_scadenza}','${utl:escapeJS(documento.nome_file) }','${utl:escapeJS(documento.rilasciato) }','${documento.numero_documento }')" title="Click per modificare il Documento"><i class="fa fa-edit"></i></a>
	   
	      <a class="btn btn-danger" onClick="modalEliminaDocumento('${documento.id}')"><i class="fa fa-trash"></i></a>    
	      <c:if test="${documento.stato.id==3 && documento.email_inviata==0 }"> 
	      <a class="btn btn-primary customTooltip" onclick="modalEmail('${documento.id}')"><i class="fa fa-paper-plane-o"></i></a>
	      </c:if>
	     </c:if>
	      <a class="btn btn-info customTooltip" onclick="modalStorico('${documento.id}')"><i class="fa fa-history"></i></a>

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



<form id="nuovoDocumentoForm" name="nuovoDipendenteForm">
<div id="myModalnuovoDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Documento</h4>
      </div>
       <div class="modal-body">
       
       
                           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_docum" id="committente_docum" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona committente..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="fornitore" id="fornitore" class="form-control select2" data-placeholder="Seleziona fornitore..." aria-hidden="true" data-live-search="true" style="width:100%" required disabled>
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="fornitore">
                     
                           <option value="${fornitore.id}">${fornitore.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Associa ai dipendenti</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="dipendenti" id="dipendenti" class="form-control select2" data-placeholder="Seleziona dipendenti" aria-hidden="true" data-live-search="true" style="width:100%" disabled multiple>
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="dipendente">
                     
                           <option value="${dipendente.id}">${dipendente.nome} ${dipendente.cognome }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento" name="nome_documento" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento" name="numero_documento" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Caricamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_caricamento'>
               <input type='text' class="form-control input-small" id="data_caricamento" name="data_caricamento" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato" name="rilasciato" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload" name="fileupload" type="file" required></span><label id="label_file"></label>
       	</div>       	
       </div><br> 


       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="ids_dipendenti" name="ids_dipendenti">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDocumentoForm" name="modificaDocumentoForm">
<div id="myModalModificaDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Documento</h4>
      </div>
            <div class="modal-body">
            
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_docum_mod" id="committente_docum_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona committente..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="fornitore_mod" id="fornitore_mod" class="form-control select2" data-placeholder="Seleziona fornitore..." aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="fornitore">
                     
                           <option value="${fornitore.id}">${fornitore.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Associa ai dipendenti</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="dipendenti_mod" id="dipendenti_mod" class="form-control select2" data-placeholder="Seleziona dipendenti" aria-hidden="true" data-live-search="true" style="width:100%" disabled multiple>
                <option value=""></option>
                      <c:forEach items="${lista_dipendenti}" var="dipendente">
                     
                           <option value="${dipendente.id}">${dipendente.nome} ${dipendente.cognome }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento_mod" name="nome_documento_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento_mod" name="numero_documento_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Caricamento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_caricamento_mod'>
               <input type='text' class="form-control input-small" id="data_caricamento_mod" name="data_caricamento_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
      
      
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Rilasciato</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="rilasciato_mod" name="rilasciato_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label>
       	</div>       	
       </div><br> 


       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="ids_dipendenti_mod" name="ids_dipendenti_mod">
		<input type="hidden" id="ids_dipendenti_dissocia" name="ids_dipendenti_dissocia">
		<input type="hidden" id="id_documento" name="id_documento">
		<input type="hidden" id="fornitore_temp" name="fornitore_temp">
		

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

  <div id="myModalEmail" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Invia Comunicazione</h4>
      </div>
       <div class="modal-body">       
      	<label>A (fornitore):</label><input type="text" class="form-control" id="destinatario" name="destinatario"/>
      	<label>CC (committente):</label><input type="text" class="form-control" id="copia" name="copia"/>
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_docum" name="id_docume">
      <a class="btn btn-primary" onclick="inviaEmail()" >Invia</a>
		
      </div>
    </div>
  </div>

</div>

 <div id="myModalStoricoEmail" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Storico email</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico_email" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>Utente</th>
<th>Data</th>
<th>Destinatario</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
  </div>
</div>
</div>



<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Storico documento</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome documento</th>
<th>Numero documento</th>
<th>Data caricamento</th>
<th>Frequenza</th>
<th>Data scadenza</th>
<th>Rilasciato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
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
      	Sei sicuro di voler eliminare il documento?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_documento_id">
      <a class="btn btn-primary" onclick="eliminaDocumento($('#elimina_documento_id').val())" >SI</a>
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
.btn-primary>.badge {
    position: relative;
    top: -20px;
    right: -25px;
    font-size: 10px;
    font-weight: 400;
}

/*  .btn .badge {
    position: relative;
    top: -1px;
}
  */

.table th {
    background-color: #00a65a !important;
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


function modalStorico(id_documento){
	
	  dataString ="action=storico_documento&id_documento="+ id_documento;
      exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
    	  	
    	  var result = JSON.parse(datab);
    	  
    	  if(result.success){
    		  
    		 
    		  var table_data = [];
    		  
    		  var lista_documenti = result.lista_documenti;
    		  
    		  for(var i = 0; i<lista_documenti.length;i++){
    			  var dati = {};
    			  if( lista_documenti[i].id!= id_documento){
    				  
    			  
    			  dati.id = lista_documenti[i].id;
    			  dati.committente = lista_documenti[i].committente.nome_cliente +" - "+lista_documenti[i].committente.indirizzo_cliente;
    			  dati.fornitore = lista_documenti[i].fornitore.ragione_sociale;
    			  dati.nome_documento = lista_documenti[i].nome_documento;
    			  if(lista_documenti[i].numero_documento==null){
    				  dati.numero_documento = ''; 
    			  }else{
    				  dati.numero_documento = lista_documenti[i].numero_documento;
    			  }    			  
    			  dati.data_caricamento =  formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
    			  dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
    			  dati.data_scadenza =  formatDate(moment(lista_documenti[i].data_scadenza, "DD, MMM YY"));
    			  dati.rilasciato = lista_documenti[i].rilasciato;
    			  dati.azioni = '<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento_table&id_documento='+lista_documenti[i].id+'" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>';
    			
    			  table_data.push(dati);
    			  }
    		  }
    		  var table = $('#table_storico').DataTable();
    		  
     		   table.clear().draw();
     		   
     			table.rows.add(table_data).draw();
     			table.columns.adjust().draw();
   			
   		  $('#myModalStorico').modal();
   			
    	  }
    	  
    	  $('#myModalStorico').on('shown.bs.modal', function () {
    		  var table = $('#table_storico').DataTable();
    		  
    			table.columns.adjust().draw();
  			
    		})
    	  
      });
	  

	
}


function inviaEmail(){
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	   pleaseWaitDiv.modal();
	  
	  dataObj = {}
	  dataObj.id_documento = $('#id_docum').val();
	  dataObj.destinatario = $('#destinatario').val();
	  dataObj.copia = $('#copia').val();
	  
  $.ajax({
	  type: "POST",
	  url: "gestioneDocumentale.do?action=invia_email",
	data: dataObj,
	dataType: "json",
	 
	  success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  	      		  
		  if(data.success)
		  { 
			$('#myModalEmail').hide();
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#report_button').hide();
				$('#visualizza_report').hide();
					$('#myModalError').modal('show');	 
					
					$('#myModalError').on('hidden.bs.modal',function(){
						location.reload();
						$(".modal-backdrop").hide();
					});
			  
		  }else{
			  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').hide();
				$('#visualizza_report').hide();
					$('#myModalError').modal('show');	      			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				

	  }
  });
	
}



function modalEmail(id_documento){
	
	
	$('#id_docum').val(id_documento);
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	   pleaseWaitDiv.modal();
	  
	  dataObj = {}
  $.ajax({
	  type: "POST",
	  url: "gestioneDocumentale.do?action=email_forn_comm&id_documento="+id_documento,
	data: dataObj,
	dataType: "json",
	 
	  success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  	      		  
		  if(data.success)
		  { 
			
			$('#destinatario').val(data.destinatario);
			$('#copia').val(data.copia);
			$('#myModalEmail').modal();
			  
		  }else{
			  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');	      			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html("Errore nel recupero dell'email!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				

	  }
  });
	
}


function modalNuovoDocumento(){
	
	$('#myModalnuovoDocumento').modal();
	
}


$('#committente_docum').change(function(){
	
	 var id_committente = $(this).val();
	 getFornitoriCommittente("", id_committente);
	 $('#fornitore').attr('disabled', false);
});



$('#committente_docum_mod').change(function(){

	 var id_committente = $(this).val();
	 getFornitoriCommittente("_mod", id_committente);
	 
});

$('#fornitore').change(function(){
	
	var id_committente = $('#committente_docum').val();
	var id_fornitore = $(this).val();
	getDipendenteFornitoreCommittente("", id_committente, id_fornitore);
	
	
});


$('#fornitore_mod').change(function(){
	
	var id_committente = $('#committente_docum_mod').val();
	var id_fornitore = $(this).val();
	var id_documento = $('#id_documento').val();
	getDipendenteFornitoreCommittente("_mod", id_committente, id_fornitore, id_documento);
	
	
});

function modificaDocumentoModal(id_committente, id_documento, fornitore, nome_documento, data_caricamento, frequenza,  data_scadenza, nome_file, rilasciato, numero_documento){

	$('#id_documento').val(id_documento);
		
	
	$('#fornitore_temp').val(fornitore);	

	
	$('#committente_docum_mod').val(id_committente);
	$('#committente_docum_mod').change();
	

	$('#nome_documento_mod').val(nome_documento);
	$('#frequenza_mod').val(frequenza);	
	
	$('#numero_documento_mod').val(numero_documento);
	
	if(data_caricamento!=null && data_caricamento!=''){
		$('#data_caricamento_mod').val(Date.parse(data_caricamento).toString("dd/MM/yyyy"));
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
	$('#rilasciato_mod').val(rilasciato);
	$('#label_file_mod').html(nome_file.split("\\")[1]);
	
	$('#myModalModificaDocumento').modal();
}


var columsDatatables = [];

$("#tabDocumDocumento").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDocumDocumento thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDocumDocumento thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });


$('#data_caricamento').change(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_caricamento').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			
		}
		
	}
	
});

$('#data_caricamento_mod').change(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_caricamento_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza_mod').val(formatDate(c));
			
		}
		
	}
	
});


$('#frequenza').change(function(){
	
	var date = $('#data_caricamento').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			
		}
	}
	
});

	$('#frequenza_mod').change(function(){
		
		var date = $('#data_caricamento_mod').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_mod').val(formatDate(c));
			}
		}
	});

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

function modalEliminaDocumento(id_documento){	
	
	 $('#elimina_documento_id').val(id_documento);
		$('#myModalYesOrNo').modal();
}


$('#dipendenti_mod').on('change', function() {
  
	var selected = $(this).val();
	var selected_before = $('#ids_dipendenti_mod').val().split(";");
	var deselected = "";
	

	if(selected!=null && selected.length>0){
		
		for(var i = 0; i<selected_before.length;i++){
			var found = false
			for(var j = 0; j<selected.length;j++){
				if(selected_before[i] == selected[j]){
					found = true;
				}
			}
			if(!found && selected_before[i]!=''){
				deselected = deselected+selected_before[i]+";";
			}
		}
	}else{
		deselected = $('#ids_dipendenti_mod').val();
	}
	 
	
	$('#ids_dipendenti_dissocia').val(deselected)
	
  });


$(document).ready(function() {
 
$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     table = $('#tabDocumDocumento').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 10 },
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDocumDipendenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDocumDocumento').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
	  tab = $('#table_storico').DataTable({
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
		      columns : [
		      	{"data" : "id"},
		      	{"data" : "committente"},
		      	{"data" : "fornitore"},
		      	{"data" : "nome_documento"},
		      	{"data" : "numero_documento"},
		      	{"data" : "data_caricamento"},
		      	{"data" : "frequenza"},
		      	{"data" : "data_scadenza"},
		      	{"data" : "rilasciato"},
		      	{"data" : "azioni"},
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 9 },
		    	  
		    	  
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
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      tab
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		table.columns.adjust().draw();
		

	$('#tabDocumDocumento').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
});


$('#modificaDocumentoForm').on('submit', function(e){
	 e.preventDefault();
	 
	 
	 if($('#dipendenti_mod').val()!=null && $('#dipendenti_mod').val()!=''){
		 
		 var values = $('#dipendenti_mod').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#ids_dipendenti_mod').val(ids);
	 }else {
		 $('#ids_dipendenti_mod').val("");
	 }
	 modificaDocumento();
});
 

 
 $('#nuovoDocumentoForm').on('submit', function(e){
	 
	 if($('#dipendenti').val()!=null && $('#dipendenti').val()!=''){
		 
		 var values = $('#dipendenti').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#ids_dipendenti').val(ids);
	 }
	 
	 e.preventDefault();
	 nuovoDocumento();
});
 
 $('#myModalStorico').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

