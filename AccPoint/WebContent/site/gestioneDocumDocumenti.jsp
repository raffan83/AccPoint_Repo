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
<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
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
<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="modalSchedaConsegna()"><i class="fa fa-plus"></i> Invia Comunicazione Consegna</a> 
</div>
</div><br>
</c:if>
<div class="row">
<div class="col-sm-12">

 <table id="tabDocumDocumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<c:if test="${userObj.checkRuolo('D2') == false && userObj.checkRuolo('D3') == false }">
<th style="min-width:25px"><input id="checkAll" type="checkbox" /></th>
</c:if>
<th>Committente</th>
<th>Fornitore</th>
<th>Codice</th>
<th>Dipendenti</th>
<th>Nome Documento</th>
<th>Numero Documento</th>
<th>Tipo Documento</th>
<th>Data caricamento</th>
<th>Data rilascio</th>
<th>Data scadenza</th>
<th>Frequenza (mesi)</th>
<th>Revisione</th>
<th>Stato</th>
<th>Rilasciato</th>
<c:if test="${userObj.checkRuolo('D2') == false && userObj.checkRuolo('D3') == false }">
<th>Comunicata consegna</th>
</c:if>
<th style="min-width:230px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_documenti}" var="documento" varStatus="loop">
 	<c:if test="${documento.stato.id==1 }">
 	<%-- <tr id="row_${loop.index}" style="background-color:#00ff80" > --%>
 	<tr id="row_${loop.index}" style="background-color:#ccffcc" >
 	</c:if>
 	<c:if test="${documento.stato.id==2 }">
	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
	</c:if>
	 	<c:if test="${documento.stato.id==3 }">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:if>
	<td>${documento.id }</td>
	<c:if test="${userObj.checkRuolo('D2') == false && userObj.checkRuolo('D3') == false }">
	<td></td>	
	</c:if>
	<td>${documento.committente.nome_cliente } - ${documento.committente.indirizzo_cliente }</td>
	<td><a href="#" class="btn customTooltip customlink" onClick="callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore=${utl:encryptData(documento.fornitore.id)}')">${documento.fornitore.ragione_sociale }</a></td>
	<td>${documento.codice }</td>
	<td>
	<c:forEach items="${documento.getListaDipendenti() }" var="dipendente">
	${dipendente.nome} ${dipendente.cognome }<br>
	</c:forEach>
	</td>
	<td>${documento.nome_documento }</td>
	<td>${documento.numero_documento }</td>
	<td>${documento.tipo_documento.descrizione }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_caricamento}" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_rilascio}" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_scadenza}" /></td>
	<td>${documento.frequenza_rinnovo_mesi }</td>
	<td>${documento.revisione }</td>
	<td>${documento.getStato().getNome() }</td>
	<td>${documento.rilasciato }</td>
	<c:if test="${userObj.checkRuolo('D2') == false && userObj.checkRuolo('D3') == false }">
	<td>
	<c:if test="${documento.comunicata_consegna == 1 }">SI</c:if>
	<c:if test="${documento.comunicata_consegna == 0 }">NO</c:if>
	</td>	
	</c:if>
	<td>	
	<a class="btn btn-danger customTooltip" title="Download documento"  href="gestioneDocumentale.do?action=download_documento&id_documento=${utl:encryptData(documento.id)}" ><i class="fa fa-file-pdf-o"></i></a>
	 <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
	  <a class="btn btn-warning customTooltip" title="Modifica documento"  onClicK="modificaDocumentoModal('${documento.committente.id }','${documento.id}','${documento.fornitore.id}','${utl:escapeJS(documento.nome_documento)}','${documento.data_rilascio}','${documento.frequenza_rinnovo_mesi }',
	   '${documento.data_scadenza}','${utl:escapeJS(documento.nome_file) }','${utl:escapeJS(documento.rilasciato) }','${documento.numero_documento }','${documento.tipo_documento.id }','${documento.aggiornabile_cl }','${documento.tipo_documento.aggiornabile_cl_default }','${documento.codice }','${documento.revisione }')" title="Click per modificare il Documento"><i class="fa fa-edit"></i></a>
	   
	      <a class="btn btn-danger customTooltip" onClick="modalEliminaDocumento('${documento.id}')" title="Elimina documento" ><i class="fa fa-trash"></i></a>    
	      <c:if test="${documento.stato.id==3 && documento.email_inviata==0 }"> 
	      <a class="btn btn-primary customTooltip" onclick="modalEmail('${documento.id }','${documento.fornitore.id}','${documento.committente.id }')" title="Invia comunicazione documento scaduto"><i class="fa fa-paper-plane-o"></i></a>
	      </c:if>
	     </c:if>
	      <a class="btn btn-info customTooltip" title="Vai allo storico"  onclick="modalStorico('${documento.id}')"><i class="fa fa-history"></i></a>
	      
	      <c:set var="ruolo" value="false"></c:set>
	      <c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1')  }">
	      <c:set var="ruolo" value="true"></c:set>
	      </c:if>
	      
		<c:if test="${documento.aggiornabile_cl == 1 || (documento.stato.id==3 && ruolo)}">
		<a class="btn btn-success customTooltip" title="Aggiorna documento" onClick="modalAggiornaDocumento('${documento.id}','${documento.nome_documento }','${documento.frequenza_rinnovo_mesi }')"><i class="fa fa-arrow-up"></i></a>
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
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice" name="codice" class="form-control" type="text" style="width:100%" >
       			
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
       		<label>Tipo Documento</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="tipo_documento" id="tipo_documento" class="form-control select2" data-placeholder="Seleziona tipo documento..." aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_documento}" var="tipo">
                     
                           <option value="${tipo.id}_${tipo.aggiornabile_cl_default}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Rilascio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_rilascio'>
               <input type='text' class="form-control input-small" id="data_rilascio" name="data_rilascio" >
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
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza" >
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
       		<label>Revisione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="revisione" name="revisione" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
       		<div class="row">
       <div class="col-sm-3">
       <label>Aggiornabile dal cliente</label>
		</div>
		
		<div class="col-sm-9">
       <input type="checkbox" class="form-control" id="aggiornabile_cl" name="aggiornabile_cl">
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
	<input type="hidden" id="aggiornabile_cliente" name="aggiornabile_cliente">
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
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_mod" name="codice_mod" class="form-control" type="text" style="width:100%" >
       			
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
       		<label>Tipo Documento</label>
       	</div>
       	<div class="col-sm-9"> 
           <select name="tipo_documento_mod" id="tipo_documento_mod" class="form-control select2" data-placeholder="Seleziona tipo documento..." aria-hidden="true" data-live-search="true" style="width:100%"  >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_documento}" var="tipo">
                     
                           <option value="${tipo.id}_${tipo.aggiornabile_cl_default}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br> 
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Rilascio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_rilascio_mod'>
               <input type='text' class="form-control input-small" id="data_rilascio_mod" name="data_rilascio_mod" >
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
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza_mod'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod" >
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
       		<label>Revisione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="revisione_mod" name="revisione_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       
              		<div class="row">
       <div class="col-sm-3">
       <label>Aggiornabile dal cliente</label>
		</div>
		
		<div class="col-sm-9">
       <input type="checkbox" class="form-control" id="aggiornabile_cl_mod" name="aggiornabile_cl_mod">
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
		<input type="hidden" id="aggiornabile_cliente_mod" name="aggiornabile_cliente_mod">

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
      	<label>A (Referente fornitore):</label><input type="text" class="form-control" id="destinatario" name="destinatario"/>
      	<label>CC (committente):</label><input type="text" class="form-control" id="copia" name="copia"/>
      	</div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_docum" name="id_docum">
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
<th>Tipo documento</th>
<th>Data caricamento</th>
<th>Data rilascio</th>
<th>Data scadenza</th>
<th>Frequenza</th>
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

<form id="formAggiornaDocumento" name="formAggiornaDocumento">
  <div id="myModalAggiornaDocumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Carica il documento aggiornato</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_documento_agg" name="nome_documento_agg" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Numero Documento</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="numero_documento_agg" name="numero_documento_agg" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Rilascio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_rilascio_agg'>
               <input type='text' class="form-control input-small" id="data_rilascio_agg" name="data_rilascio_agg" >
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
       	  	
        <input id="frequenza_agg" name="frequenza_agg" class="form-control" type="number" min="0" step="1" style="width:100%" required>
       			
       	</div>       	
       </div><br>
              
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza_agg'>
               <input type='text' class="form-control input-small" id="data_scadenza_agg" name="data_scadenza_agg" required>
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
       	  	
        <input id="rilasciato_agg" name="rilasciato_agg" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
                    
                    
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>File</label>
       	</div>
       	<div class="col-sm-9">      
			<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF,.xls,.xlsx,.XLS,.XLSX,.p7m,.doc,.docX,.DOCX,.DOC,.P7M"  id="fileupload_agg" name="fileupload_agg" type="file"  required></span><label id="label_file_agg"></label>
       	</div>       	
       </div><br> 
     
     
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="aggiorna_documento_id"  name="aggiorna_documento_id">
      <button type="submit" class="btn btn-primary" >Salva</button>
      </div>
    </div>
  </div>

</div>
</form>





<div id="modalSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Invia comunicazione di cosegna documenti</h4>
      </div>
       <div class="modal-body">       
       <div class="row">       
       	<div class="col-sm-12">
       	<table id="tab_scheda_consegna" class="table table-bordered table-hover dataTable table-striped">
       	<thead>
       	<tr>
       	<th>ID</th>
       	<th>Committente</th>
       	<th>Fornitore</th>
       	<th>Codice</th>
       	<th>Nome documento</th>
       	<th>Tipo documento</th>
       	<%-- <th>Tipo consegna</th> --%>
       	</tr>
       	</thead>
       	<tbody></tbody>
       	</table>	
       	</div>
      
       </div>
        <div class="row">       
       	<div class="col-sm-6">
       	<label>Tipo consegna</label>
       	</div>
       	</div><br>
         <div class="row">       
       	<div class="col-sm-3">
       	<input id="check_parziale" name="check_parziale" type="radio" class="form-control"><label style="margin-left:5px">Parziale</label>
       	</div>
       	<div class="col-sm-3">
       	<input id="check_totale" name="check_totale"type="radio" class="form-control" checked ><label style="margin-left:5px">Totale</label>
       	</div>
       	</div>
       </div>
      <div class="modal-footer">
      
      <button class="btn btn-primary" onClick="$('#myModalEmailConsegna').modal()">Salva</button>
      </div>
    </div>
  </div>

</div>


 <div id="myModalEmailConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Invia Comunicazione Consegna</h4>
      </div>
       <div class="modal-body">       
      	<label>Indirizzo:</label><input type="text" class="form-control" id="destinatario_consegna" value="antonio.dicivita@ncsnetwork.it" name="destinatario_consegna"/>
      	
      	</div>
      <div class="modal-footer">
      
      
      <a class="btn btn-primary" onclick="inviaEmailConsegna()" >Invia</a>
		
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


function modalAggiornaDocumento(id_documento, nome_documento, frequenza){
	
	$('#aggiorna_documento_id').val(id_documento);
	$('#nome_documento_agg').val(nome_documento);
	$('#frequenza_agg').val(frequenza);
	
	$('#myModalAggiornaDocumento').modal();
}

function modalStorico(id_documento){
	
	  dataString ="action=storico_documento&id_documento="+ id_documento;
      exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
    	  	
    	  var result =datab;
    	  
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
    			  if(lista_documenti[i].tipo_documento==null){
    				  dati.tipo_documento = ''; 
    			  }else{
    				  dati.tipo_documento = lista_documenti[i].tipo_documento.descrizione;
    			  } 
    			  //dati.data_caricamento = formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
    			 // dati.data_rilascio =  formatDate(moment(lista_documenti[i].data_rilascio, "DD, MMM YY"));
    			 
    			 if(lista_documenti[i].data_caricamento == null){
    				 dati.data_caricamento = '';
    			 }else{
    				 dati.data_caricamento = lista_documenti[i].data_caricamento;	 
    			 }
    			 
    			 if(lista_documenti[i].data_rilascio == null){
    				 dati.data_rilascio = '';
    			 }else{
    				 dati.data_rilascio = lista_documenti[i].data_rilascio;	 
    			 }
    			 
    			
    			 dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
    			 
    			 if(lista_documenti[i].data_scadenza == null){
    				 dati.data_scadenza = '';
    			 }else{
    				 dati.data_scadenza = lista_documenti[i].data_scadenza;	 
    			 }
    			 
    			 
    			  
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
	  
	  if($('#destinatario').val()==''){
		  pleaseWaitDiv.modal('hide');
		  $('#myModalErrorContent').html("Nessun destinatario inserito!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').hide();
			$('#visualizza_report').hide();
				$('#myModalError').modal('show');	
	  }else{
		  
		  
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
					  $('#myModalErrorContent').html("Errore nell'invio dell'email!");
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').hide();
						$('#visualizza_report').hide();
							$('#myModalError').modal('show');	      			 
				  }
			  },

			  error: function(jqXHR, textStatus, errorThrown){
				  pleaseWaitDiv.modal('hide');

				  $('#myModalErrorContent').html("Errore nell'invio dell'email!");
					  	$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
						$('#visualizza_report').show();
						$('#myModalError').modal('show');
						

			  }
		  });
		  
	  }
	
}



function modalEmail(id_documento, id_fornitore, id_committente){
	
	
	$('#id_docum').val(id_documento);
	
	 pleaseWaitDiv = $('#pleaseWaitDialog');
	   pleaseWaitDiv.modal();
	  
	  dataObj = {}
  $.ajax({
	  type: "POST",
	  url: "gestioneDocumentale.do?action=email_forn_comm&id_fornitore="+id_fornitore+"&id_committente="+id_committente,
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


$('#check_parziale').on('ifClicked', function(){
	
	if($('#check_parziale').is( ':checked' )){
		$('#check_parziale').iCheck('check');
	}else{
		$('#check_totale').iCheck('uncheck');
		
	}
	
});

$('#check_totale').on('ifClicked', function(){
	
	if($('#check_totale').is( ':checked' )){
		$('#check_totale').iCheck('check');
	}else{
		$('#check_parziale').iCheck('uncheck');
		
	}
	
});


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

function modificaDocumentoModal(id_committente, id_documento, fornitore, nome_documento, data_rilascio, frequenza,  data_scadenza, nome_file, rilasciato, numero_documento, tipo_documento, aggiornabile, aggiornabile_default, codice, revisione){

	$('#id_documento').val(id_documento);
		
	
	$('#fornitore_temp').val(fornitore);	

	
	$('#committente_docum_mod').val(id_committente);
	$('#committente_docum_mod').change();
	
	if(tipo_documento!=null){
		$('#tipo_documento_mod').val(tipo_documento+"_"+aggiornabile_default);
		$('#tipo_documento_mod').change();
	}
	
	if(aggiornabile!=null && aggiornabile==1){
		$('#aggiornabile_cl_mod').iCheck("check");
		$('#aggiornabile_cliente_mod').val(1);
		
	}else{
		$('#aggiornabile_cl_mod').iCheck("uncheck");
		$('#aggiornabile_cliente_mod').val(0);
	}

	$('#nome_documento_mod').val(nome_documento);
	$('#frequenza_mod').val(frequenza);	
	
	$('#numero_documento_mod').val(numero_documento);
	
	if(data_rilascio!=null && data_rilascio!=''){
		$('#data_rilascio_mod').val(Date.parse(data_rilascio).toString("dd/MM/yyyy"));
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
	$('#rilasciato_mod').val(rilasciato);
	$('#label_file_mod').html(nome_file.split("\\")[1]);
	
	$("#codice_mod").val(codice);
	$("#revisione_mod").val(revisione);
	
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
    	
    	  if((${userObj.checkRuolo('D1') == true} || ${userObj.checkRuolo('AM') == true}) && $(this).index()!=1){
    		  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');
		    		
	    	}
    	  else if(${userObj.checkRuolo('D2') == true|| userObj.checkRuolo('D3') == true}  ){
    		  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');
    	  }

    	} );
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$('#fileupload_agg').change(function(){
	$('#label_file_agg').html($(this).val().split("\\")[2]);
	 
 });

$('#data_rilascio').change(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			    $('#datepicker_data_scadenza').datepicker("setDate", c );
			
		}
		
	}
	
});

$('#data_rilascio_mod').change(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza_mod').val(formatDate(c));
			    $('#datepicker_data_scadenza_mod').datepicker("setDate", c );
			
		}
		
	}
	
});


$('#data_rilascio_agg').change(function(){
	
	var frequenza = $('#frequenza_agg').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_rilascio_agg').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza_agg').val(formatDate(c));
			    $('#datepicker_data_scadenza_agg').datepicker("setDate", c );
			
		}
		
	}
	
});



$('#frequenza').change(function(){
	
	var date = $('#data_rilascio').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_scadenza').val(formatDate(c));
			    $('#datepicker_data_scadenza').datepicker("setDate", c );
				
		}
	}
	
});

	$('#frequenza_mod').change(function(){
		
		var date = $('#data_rilascio_mod').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_mod').val(formatDate(c));
				    $('#datepicker_data_scadenza_mod').datepicker("setDate", c );
			}
		}
	});

	
	$('#frequenza_agg').change(function(){
		
		var date = $('#data_rilascio_agg').val();
		var frequenza = $(this).val();
		if(date!=null && date!='' && frequenza!=''){
			
			var d = moment(date, "DD-MM-YYYY");
			if(date!='' && d._isValid){
				
				   var year = d._pf.parsedDateParts[0];
				   var month = d._pf.parsedDateParts[1];
				   var day = d._pf.parsedDateParts[2];
				   var c = new Date(year, month + parseInt(frequenza), day);
				    $('#data_scadenza_agg').val(formatDate(c));
				    $('#datepicker_data_scadenza_agg').datepicker("setDate", c );
				
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
  
  $('#tipo_documento').change(function(){
	 
	  var value = $(this).val();
	  
	  if(value.split("_")[1] == 1){
		
		  $('#aggiornabile_cl').iCheck("check");
		  $('#aggiornabile_cliente').val(1);
	  }else{
		  $('#aggiornabile_cl').iCheck("uncheck");
		  $('#aggiornabile_cliente').val(0);
	  }
	  
  });
  
  $('#tipo_documento_mod').change(function(){
		 
	  var value = $(this).val();
	  
	  if(value!=null && value.split("_")[1] == 1){
		
		  $('#aggiornabile_cl_mod').iCheck("check");
		  $('#aggiornabile_cliente_mod').val(1);
	  }else{
		  $('#aggiornabile_cl_mod').iCheck("uncheck");
		  $('#aggiornabile_cliente_mod').val(0);
	  }
	  
  });

  
  $('#aggiornabile_cl').on('ifClicked',function(e){
		if($('#aggiornabile_cl').is( ':checked' )){
			$('#aggiornabile_cl').iCheck('uncheck');
			$('#aggiornabile_cliente').val(0);
		}else{
			$('#aggiornabile_cl').iCheck('check');
			$('#aggiornabile_cliente').val(1);
		}
	});

	$('#aggiornabile_cl_mod').on('ifClicked',function(e){
		if($('#aggiornabile_cl_mod').is( ':checked' )){
			$('#aggiornabile_cl_mod').iCheck('uncheck');
			$('#aggiornabile_cliente_mod').val(0);
		}else{
			$('#aggiornabile_cl_mod').iCheck('check');
			$('#aggiornabile_cliente_mod').val(1);
		}
	});
  

	function modalSchedaConsegna(){
	//	 table = $('#tabDocumDocumento').DataTable()
		 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	  		var dataSelected = table.rows( { selected: true } ).data();
	  		var selezionati = {
	  			    ids: []
	  			};
	  		var table_data = [];
	  		if(dataSelected.length>0){
	  			
	  			for(var i = 0;i<dataSelected.length;i++){
	  				var row = [];
	  				row.id = dataSelected[i][0];
	  				row.committente = dataSelected[i][2];
	  				row.fornitore = dataSelected[i][3];
	  				row.codice = dataSelected[i][4];
	  				row.nome_documento = dataSelected[i][5];
	  				row.tipo_documento = dataSelected[i][7];
					/* row.check_box = '<input type="checkbox" id="checkParziale_'+dataSelected[i][0]+'" name="checkParziale_'+dataSelected[i][0]+'" class="check_consegna">'+
					'<label>Parziale</label><br>'+
					'<input type="checkbox" checked id="checkTotale_'+dataSelected[i][0]+'" name="checkTotale_'+dataSelected[i][0]+'" class="check_consegna">'+
					'<label>Totale</label>' */
	  				table_data.push(row);
	  				
	  			}
	  			
	  			var t = $('#tab_scheda_consegna').DataTable();
	    		  
	     		   t.clear().draw();
	     		   
	     			t.rows.add(table_data).draw();
	     			t.columns.adjust().draw();
	   			
	   		  $('#modalSchedaConsegna').modal();
	   			
	    	  
	    	  
	    	  $('#modalSchedaConsegna').on('shown.bs.modal', function () {
	    		  var t = $('#tab_scheda_consegna').DataTable();
	    		  
	    			t.columns.adjust().draw();
	  			
	    		})
	  			
	  			// $('#modalSchedaConsegna').modal('show');
	  		}else{
	  			$('#myModalErrorContent').html("Nessun documento selezionato!");
				  $('#myModalError').removeClass();
				  $('#myModalError').addClass("modal modal-default");
				  $('#myModalError').modal('show');
	  		}
	  		
	  		 pleaseWaitDiv.modal('hide');
	  		 
	  		 $('.check_consegna').on('click',function(){
	  			
	  			 var value = this.id;
	  			 
	  			 var id = value.split("_")[1];
	  			 var tipo = value.split("_")[0];	  			 
	  			 
	  			 if(tipo == 'checkParziale'){
	  				 $('#checkTotale_'+id).prop('checked', false);
	  			 }else{
	  				$('#checkParziale_'+id).prop('checked', false);
	  			 }
	  			 
	  		 });
	  		 
	}
	
	
function inviaEmailConsegna(){
	
	var t = $('#tab_scheda_consegna').DataTable();
	
	var data = t.columns(0).data();
	var ids = "";
	
/* 	for(var i = 0; i<ids[0].length;i++){
		if($('#checkParziale_'+ids[0][i]).prop('checked')== true){
			check = check+ids[0][i]+"_"+0+";";
		}else{
			check = check+ids[0][i]+"_"+1+";";
		}
		
	}
	 */
	 
	 for(var i = 0; i<data[0].length;i++){
		 ids = ids+data[0][i]+";"
	 }
	 
	 if($('#check_parziale').is( ':checked' )){
		 var parziale = 1;
	 }else{
		 var parziale = 0;
	 }
	 if($('#check_totale').is( ':checked' )){
		 var totale = 1;
	 }else{
		 var totale = 0;
	 }
	 
	dataObj = {};
	dataObj.ids = ids;
	dataObj.parziale = parziale;
	dataObj.totale = totale;
	dataObj.destinatario_consegna = $('#destinatario_consegna').val();
	
	 $.ajax({
		 type: "POST",
		 url: "gestioneDocumentale.do?action=scheda_consegna",
		 data: dataObj,
		 dataType: "json",
		 //if received a response from the server
		 success: function( data, textStatus) {
		 	pleaseWaitDiv.modal('hide');
		 	  if(data.success)
		 		  {  
		 		 
		 			$('#myModalErrorContent').html(data.messaggio);
		 		  	$('#myModalError').removeClass();
		 			$('#myModalError').addClass("modal modal-success");	  
		 			$('#report_button').hide();
		 			$('#visualizza_report').hide();
		 			$('#myModalError').modal('show');	
		 			 $('#myModalError').on('hidden.bs.modal', function () {
		 				 location.reload();
		 			 });
		 			
		 		  }else{
		 			
		 				$('#myModalErrorContent').html("Errore nell'associazione dei documenti!");
		 			  	$('#myModalError').removeClass();
		 				$('#myModalError').addClass("modal modal-danger");	  
		 				$('#report_button').show();
		 				$('#visualizza_report').show();
		 				$('#myModalError').modal('show');			
		 		
		 		  }
		 },
		 error: function( data, textStatus) {
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
	
	
$(document).ready(function() {
 
$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });   
     
     var columnDef = [];
     var ruolo = ${userObj.checkRuolo('D2') || userObj.checkRuolo('D3')};
     
     if(!ruolo){
    	 columnDef =	 [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { responsivePriority: 2, targets: 17 },
	    	  { className: "select-checkbox", targets: 1,  orderable: false }
	               ]
    	 
    	 selectOpt = {
		        	style:    'multi+shift',
		        	selector: 'td:nth-child(2)'
		    	}
     }else{
    	 columnDef =	 [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { responsivePriority: 2, targets: 15 },
	               ] 
    	 
    	 selectOpt = {}
     }
     
     
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
		      select: selectOpt,
		      columnDefs: columnDef, 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDocumDocumento_wrapper .col-sm-6:eq(1)');
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
		      	{"data" : "tipo_documento"},
		      	{"data" : "data_caricamento"},
		      	{"data" : "data_rilascio"},
		      	{"data" : "frequenza"},
		      	{"data" : "data_scadenza"},
		      	{"data" : "rilasciato"},
		      	{"data" : "azioni"},
		       ],	
		           
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
	 	     
	 	     
	 	     
	 	     
	 	     
	 	    tabSchedaConsegna = $('#tab_scheda_consegna').DataTable({
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
			      stateSave: false,	
			      columns : [
			      	{"data" : "id"},
			      	{"data" : "committente"},
			      	{"data" : "fornitore"},
			    	{"data" : "codice"},
			      	{"data" : "nome_documento"},
			      	{"data" : "tipo_documento"}
			      	/* {"data" : "check_box"} */
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
 
	$('#checkAll').on('ifChecked', function(event){  		
  		
		   //table.rows().select();
		   table.rows({ filter : 'applied'}).select();
		      	  
	});
	$('#checkAll').on('ifUnchecked', function(event){
		
		 table.rows().deselect();
	  
	});

 
 
 $('#formAggiornaDocumento').on('submit', function(e){

	 e.preventDefault();
	 aggiornaDocumento();
});
 
 $('#myModalStorico').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
 $('#myModalEmail').on('hidden.bs.modal', function(){
	 $(document.body).css('padding-right', '0px'); 
 });
 
 

 
 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

