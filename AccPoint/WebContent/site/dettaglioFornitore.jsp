<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Fornitore
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-12">
<div class="box box-success box-solid">
<div class="box-header with-border">
	 Dettaglio Fornitore
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${fornitore.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Ragione Sociale</b> <a class="pull-right">${fornitore.ragione_sociale}</a>
                </li>
                
                  <li class="list-group-item">
                <b>Indirizzo</b> <a class="pull-right">${fornitore.indirizzo} ${fornitore.cap } ${fornitore.comune} (${fornitore.provincia })</a>
                </li>
                
                <li class="list-group-item">
                  <b>Partita Iva</b> <a class="pull-right"> ${fornitore.p_iva} </a>
                </li>
                
                <li class="list-group-item">
                  <b>Codice Fiscale</b> <a class="pull-right">${fornitore.cf} </a>
                </li>
                <li class="list-group-item">
                <b>Stato</b> <a class="pull-right">${fornitore.stato.nome }</a>
                </li>
                
                <%-- <li class="list-group-item">
                <b>Committente</b> <a class="pull-right">${fornitore.committente.nome_cliente } - ${fornitore.committente.indirizzo_cliente }</a>
                </li> --%>
                

                
               
        </ul>

</div>
</div>
</div>



       
 </div>



    
    <div class="row">
<div class="col-md-12">
<div class="box box-success box-solid">
<div class="box-header with-border">
	 Documenti Fornitore
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

 <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active" id="tab1"><a href="#documenti" data-toggle="tab" aria-expanded="true"   id="documentiTab"><strong><h3>Documenti</h3></strong></a></li> 
              <li class="" id="tab2"><a href="#referenti" data-toggle="tab" aria-expanded="false"   id="referentiTab"><strong><h3>Referenti</h3></strong></a></li>
              <li class="" id="tab3"><a href="#dipendentitab" data-toggle="tab" aria-expanded="false"   id="dipendentiTab"><strong><h3>Dipendenti</h3></strong></a></li>

              		 
              	 
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="documenti">
              
              
<div class="row">
<div class="col-sm-12">
<a class="btn btn-primary pull-left" onClick="callAction('gestioneDocumentale.do?action=scadenzario&id_fornitore=${utl:encryptData(fornitore.id)}&nome_fornitore=${fornitore.ragione_sociale }')"><i class="fa fa-plus"></i> Vai allo scadenzario</a>

<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }"> 
<a class="btn btn-primary pull-right" onClick="modalNuovoDocumento()"><i class="fa fa-plus"></i> Nuovo Documento</a> 
</c:if>
</div></div><br>
<div class="row">
<div class="col-sm-12">

 <table id="tabDocumDocumento" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome Documento</th>
<th>Numero Documento</th>
<th>Tipo Documento</th>
<th>Data caricamento</th>
<th>Data rilascio</th>
<th>Data scadenza</th>
<th>Frequenza (mesi)</th>

<th>Stato</th>
<th>Rilasciato</th>
<th style="min-width:145px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_documenti}" var="documento" varStatus="loop"> 	
 	<c:if test="${documento.stato.id==1 }">
 	<tr id="row_${loop.index}" style="background-color:#ccffcc" >
 	</c:if>
 	<c:if test="${documento.stato.id==2 }">
	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
	</c:if>
	 	<c:if test="${documento.stato.id==3 }">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:if>

	<td>${documento.id }</td>	
	<td>${documento.committente.nome_cliente} - ${documento.committente.indirizzo_cliente}</td>	
	<td>${documento.fornitore.ragione_sociale }</td>
	<td>${documento.nome_documento }</td>
	<td>${documento.numero_documento }</td>
	<td>${documento.tipo_documento.descrizione }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_caricamento}" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_rilascio}" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${documento.data_scadenza}" /></td>
	<td>${documento.frequenza_rinnovo_mesi }</td>
	<td>${documento.getStato().getNome() }</td>
	<td>${documento.rilasciato }</td>
		
	<td>	
	<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento&id_documento=${utl:encryptData(documento.id)}" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
	  <a class="btn btn-warning" onClicK="modificaDocumentoModal('${documento.id}','${documento.committente.id }','${documento.fornitore.id}','${utl:escapeJS(documento.nome_documento)}','${documento.data_caricamento}','${documento.frequenza_rinnovo_mesi }',
	   '${documento.data_scadenza}','${utl:escapeJS(documento.nome_file) }','${utl:escapeJS(documento.rilasciato) }','${documento.numero_documento }','${documento.tipo_documento.id }','${documento.aggiornabile_cl }','${documento.tipo_documento.aggiornabile_cl_default }','${documento.codice }','${documento.revisione }')" title="Click per modificare il Documento"><i class="fa fa-edit"></i></a>
	   
	   <a class="btn btn-danger" onClick="modalEliminaDocumento('${documento.id}')"><i class="fa fa-trash"></i></a>   
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
              
              
              
   
       <div class="tab-pane" id="referenti">
       
       <div class="row">
<div class="col-sm-12">

<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
<a class="btn btn-primary pull-right" onClick="modalNuovoReferente()"><i class="fa fa-plus"></i> Nuovo Referente</a> 
</c:if>
</div></div><br>
       
       
       <div class="row">
<div class="col-sm-12">

 <table id="tabDocumReferenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nominativo</th>
<th>Email</th>
<th>Mansione</th>
<th>Qualifica</th>
<th>Note</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_referenti}" var="referente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${referente.id }</td>	
	<td>${referente.committente.nome_cliente} - ${referente.committente.indirizzo_cliente}</td>	
	<td>${referente.fornitore.ragione_sociale }</td>
	<td>${referente.nome } ${referente.cognome }</td>
	<td>${referente.email }</td>
	
	<td>${referente.mansione }</td>
	<td>${referente.qualifica }</td>	
	<td>${referente.note }</td>
		
	<td>	
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
	  <a class="btn btn-warning" onClicK="modificaReferenteModal('${referente.id}','${referente.committente.id }','${referente.fornitore.id}','${utl:escapeJS(referente.nome)}','${utl:escapeJS(referente.cognome)}','${utl:escapeJS(referente.note)}',
	  '${utl:escapeJS(referente.mansione)}', '${utl:escapeJS(referente.qualifica)}','${referente.email }')" title="Click per modificare il Referente"><i class="fa fa-edit"></i></a>
	  </c:if>   
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>
       </div>
          




       <div class="tab-pane table-responsive" id="dipendentitab">
       
       <div class="row">
<div class="col-sm-12"><a>
</a>
<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }"> 
<a class="btn btn-primary pull-right" onClick="modalNuovoDipendente()"><i class="fa fa-plus"></i> Nuovo Dipendente</a> 
</c:if>
</div></div><br>

       
       <div class="row">
      
       
<div class="col-sm-12">
<table id="tabDocumDipendenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nominativo</th>
<th>Qualifica</th>

<th>Note</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_dipendenti}" var="dipendente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${dipendente.id }</td>
	<td>${dipendente.committente.nome_cliente} - ${dipendente.committente.indirizzo_cliente}</td>	
	<td>${dipendente.fornitore.ragione_sociale }</td>
	<td>${dipendente.nome } ${dipendente.cognome }</td>
	<td>${dipendente.qualifica }</td>
	
	<td>${dipendente.note }</td>
		
	<td>	
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('D1') }">
	  <a class="btn btn-warning" onClicK="modificaDipendenteModal('${dipendente.id}','${dipendente.committente.id }','${dipendente.fornitore.id}','${utl:escapeJS(dipendente.nome)}','${utl:escapeJS(dipendente.cognome)}','${utl:escapeJS(dipendente.note)}',
	   '${utl:escapeJS(dipendente.qualifica)}')" title="Click per modificare il Dipendente"><i class="fa fa-edit"></i></a>  
	   <a class="btn btn-info customTooltip" title="Associa documenti" onClick="modalAssociaDocumenti('${dipendente.committente.id }','${dipendente.fornitore.id }','${dipendente.id}')"><i class="fa fa-plus"></i></a>
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
</div>
</div>
    
    </div>
        
        
        

</div>
</div>
</div>
 </div> 
</section>
</div>




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
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn" id="forn" class="form-control select2" data-placeholder="Seleziona fornitore..." disabled aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>


                  </select> 
       			
       	</div>       	
       </div><br>
       
       
                   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_docum" id="committente_docum" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
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
                     
                           <option value="${tipo.id}">${tipo.descrizione}</option> 
                         
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
	<input type="hidden" id="fornitore" name="fornitore">
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
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_mod" id="forn_mod" class="form-control select2" data-placeholder="Seleziona fornitore..." disabled aria-hidden="true" data-live-search="true" style="width:100%" >
              <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>
                     <%--  <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach> --%>

                  </select> 
       			
       	</div>       	
       </div><br>
                                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_docum_mod" id="committente_docum_mod" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
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
           <select name="tipo_documento_mod" id="tipo_documento_mod" class="form-control select2" data-placeholder="Seleziona tipo documento..." aria-hidden="true" data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_tipo_documento}" var="tipo">
                     
                           <option value="${tipo.id}_${tipo.aggiornabile_cl_default}" >${tipo.descrizione}</option> 
                         
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
       	  	
                <div class='input-group date datepicker' id='datepicker_data_scadenza'>
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
		
		<input type="hidden" id="id_documento" name="id_documento">
		<input type="hidden" id="fornitore_mod" name="fornitore_mod">
				<input type="hidden" id="ids_dipendenti_mod" name="ids_dipendenti_mod">
		<input type="hidden" id="ids_dipendenti_dissocia" name="ids_dipendenti_dissocia">
		<input type="hidden" id="aggiornabile_cliente_mod" name="aggiornabile_cliente_mod">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="nuovoReferenteForm" name="nuovoReferenteForm">
<div id="myModalnuovoReferente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Referente</h4>
      </div>
       <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_ref" id="forn_ref" class="form-control select2" aria-hidden="true" disabled data-placeholder="Seleziona fornitore..." data-live-search="true" style="width:100%" >
               <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>
                     <%--  <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach> --%>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
                     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_ref" id="committente_ref" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
                     </c:forEach>


                  </select> 
       			
       	</div>       	
       </div><br>     
             
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome" name="nome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome" name="cognome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email" name="email" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica" name="qualifica" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Mansione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="mansione" name="mansione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note" name="note" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="fornitore_ref" name="fornitore_ref">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaReferenteForm" name="modificaReferenteForm">
<div id="myModalModificaReferente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Referente</h4>
      </div>
                  <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_ref_mod" id="forn_ref_mod" class="form-control select2" aria-hidden="true" disabled data-live-search="true" style="width:100%" >
                <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>
                  <%--  <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach> --%>


                  </select> 
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_ref_mod" id="committente_ref_mod" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
                     </c:forEach>


                  </select> 
       			
       	</div>       	
       </div><br>     
       
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_mod" name="nome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome_mod" name="cognome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_mod" name="email_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica_mod" name="qualifica_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Mansione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="mansione_mod" name="mansione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note_mod" name="note_mod" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_referente" name="id_referente">
		<input type="hidden" id="fornitore_ref_mod" name="fornitore_ref_mod">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="nuovoDipendenteForm" name="nuovoDipendenteForm">
<div id="myModalnuovoDipendente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Dipendente</h4>
      </div>
       <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_dip" id="forn_dip" class="form-control select2" data-placeholder="Seleziona fornitore..." disabled aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>
                   <%--    <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach> --%>


                  </select> 
       			
       	</div>       	
       </div><br>
             
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_dip" id="committente_dip" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
                     </c:forEach>


                  </select> 
       			
       	</div>       	
       </div><br>     
             
                                 

             
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome" name="nome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome" name="cognome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica" name="qualifica" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note" name="note" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
	<input type="hidden" id="fornitore_dip" name="fornitore_dip">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDipendenteForm" name="modificaDipendenteForm">
<div id="myModalModificaDipendente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Dipendente</h4>
      </div>
                  <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="forn_dip_mod" id="forn_dip_mod" class="form-control select2" aria-hidden="true" data-live-search="true" disabled style="width:100%" >
                <option value="${fornitore.id }">${fornitore.ragione_sociale}</option>
                 <%--      <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="forn">
                     	<c:if test="${forn.id == fornitore.id}">
                     	  <option value="${fornitore.id}" selected>${fornitore.ragione_sociale}</option>
                     	</c:if>
                          <c:if test="${forn.id != fornitore.id}">
                     	  <option value="${fornitore.id}">${fornitore.ragione_sociale}</option>
                     	</c:if>
                         
                     </c:forEach> --%>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_dip_mod" id="committente_dip_mod" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" required data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                
                     	  <option value="${committente.id}" >${committente.nome_cliente} - ${committente.indirizzo_cliente }</option>
                  
                     </c:forEach>


                  </select> 
       			
       	</div>       	
       </div><br>     
             
                    

             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_dip_mod" name="nome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome_dip_mod" name="cognome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica_dip_mod" name="qualifica_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
             
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note_dip_mod" name="note_mod" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_dipendente" name="id_dipendente">

		<input type="hidden" id="fornitore_dip_mod" name="fornitore_dip_mod">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>


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



<div id="myModalAssociaDocumenti" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Associa documenti al dipendente</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_doc" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th style="min-width:25px"></th>
<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome documento</th>
<th>Numero documento</th>
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
          
          <input type="hidden" id="id_dipendente_associazione"> 
 		
 		
        <a class = "btn btn-primary pull-right" onClick="associaDocumenti()">Salva</a> 
        <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalAssociaDocumenti').modal('hide')">Chiudi</a>
         
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


  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<link type="text/css" href="css/bootstrap.min.css" />


<style>

  .table th {
    background-color: #00a65a !important;
  }
  
  </style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
  
 <script type="text/javascript">
 
 function modalStorico(id_documento){
		
	  dataString ="action=storico_documento&id_documento="+ id_documento;
     exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
   	  	
   	  var result =datab;
   	  
   	  if(result.success){
   		  
   		 
   		  var table_data = [];
   		  
   		  var lista_documenti = result.lista_documenti;
   		  
   		  for(var i = 0; i<lista_documenti.length;i++){
   			  
   			if(lista_documenti[i].id!=id_documento){
   				var dati = {};
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
     			 
     			 if( lista_documenti[i].data_caricamento==null){
     				 dati.data_caricamento =  '';
     			 }else{
     				  dati.data_caricamento =  formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
     			 }
     			 if( lista_documenti[i].data_rilascio==null){
     				 dati.data_rilascio =  '';
     			 }else{
     				 dati.data_rilascio =  formatDate(moment(lista_documenti[i].data_rilascio, "DD, MMM YY"));
     			 }
     			if( lista_documenti[i].data_scadenza==null){
    				 dati.data_scadenza =  '';
    			 }else{
    				 dati.data_scadenza =  formatDate(moment(lista_documenti[i].data_scadenza, "DD, MMM YY"));
    			 }
     			
     			if( lista_documenti[i].frequenza_rinnovo_mesi==null){
   				 dati.frequenza =  '';
   				 }else{
   				dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
   				 }
    			  

     			 
     			  dati.rilasciato = lista_documenti[i].rilasciato;
     			  dati.azioni = '<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento_table&id_documento='+lista_documenti[i].id+'" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>';
     			
     			  table_data.push(dati);
   			}
   			  
   		  }
   		  var tab = $('#table_storico').DataTable();
   		  
   		tab.clear().draw();
    		   
   		tab.rows.add(table_data).draw();
    			tab.columns.adjust().draw();
  			
  		  $('#myModalStorico').modal();
  			
   	  }
   	  
   	  $('#myModalStorico').on('shown.bs.modal', function () {
   		  var tab = $('#table_storico').DataTable();
   		  
   		tab.columns.adjust().draw();
 			
   		})
   	  
     });
	  

	
} 


 function associaDocumenti(){
 	  pleaseWaitDiv = $('#pleaseWaitDialog');
 	  pleaseWaitDiv.modal();
 	  
 	  var table = $('#table_doc').DataTable();
 		var dataSelected = table.rows( { selected: true } ).data();
 		var selezionati = "";
 		for(i=0; i< dataSelected.length; i++){
 			dataSelected[i];
 			selezionati = selezionati +dataSelected[i].id+";";
 		}
 		console.log(selezionati);
 		table.rows().deselect();
 		associaDocumentiDipendente(selezionati, $('#id_dipendente_associazione').val());
 		
 	}


 function modalAssociaDocumenti(id_committente, id_fornitore,id_dipendente){
 	
 	$('#id_dipendente_associazione').val(id_dipendente);
 	
 	dataString ="action=documenti_dipendente&id_committente="+ id_committente+"&id_fornitore="+id_fornitore+"&id_dipendente="+id_dipendente;
     exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
   	  	
   	  var result = datab;
   	  
   	  if(result.success){  		  
   		 
   		  var table_data = [];
   		  
   		  var lista_documenti = result.lista_documenti;
   		  var lista_documenti_associati = result.lista_documenti_associati;
   		  
   		  for(var i = 0; i<lista_documenti.length;i++){
   			  
   			  var dati = {};
   			  dati.empty = '<td></td>';
   			  dati.check = '<td></td>';
   			  dati.id = lista_documenti[i].id;
   			  dati.committente = lista_documenti[i].committente.nome_cliente +" - "+lista_documenti[i].committente.indirizzo_cliente;
   			  dati.fornitore = lista_documenti[i].fornitore.ragione_sociale;
   			  dati.nome_documento = lista_documenti[i].nome_documento;
   			  if(lista_documenti[i].numero_documento==null){
   				dati.numero_documento = "";
   			  }else{
   				dati.numero_documento = lista_documenti[i].numero_documento; 
   			  }
   			  
   			 if( lista_documenti[i].data_caricamento==null){
 				 dati.data_caricamento =  '';
 			 }else{
 				  dati.data_caricamento =  formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
 			 }
 			 if( lista_documenti[i].data_rilascio==null){
 				 dati.data_rilascio =  '';
 			 }else{
 				 dati.data_rilascio =  formatDate(moment(lista_documenti[i].data_rilascio, "DD, MMM YY"));
 			 }
 			if( lista_documenti[i].data_scadenza==null){
				 dati.data_scadenza =  '';
			 }else{
				 dati.data_scadenza =  formatDate(moment(lista_documenti[i].data_scadenza, "DD, MMM YY"));
			 }
 			
 			if( lista_documenti[i].frequenza_rinnovo_mesi==null){
				 dati.frequenza =  '';
				 }else{
				dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
				 }
			  
   			  dati.rilasciato = lista_documenti[i].rilasciato;
   			  dati.azioni = '<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento_table&id_documento='+lista_documenti[i].id+'" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>';
   				
   			
   			  table_data.push(dati);
   		  }
   		  var table = $('#table_doc').DataTable();
   		  
    		   table.clear().draw();
    		   
    			table.rows.add(table_data).draw();
    			
    			table.columns.adjust().draw();
  			
    			$('#table_doc tr').each(function(){
    				var val  = $(this).find('td:eq(2)').text();
    				$(this).attr("id", val)
    			});
    			controllaAssociati(table,lista_documenti_associati );
  		  $('#myModalAssociaDocumenti').modal();
  			
   	  }
   	  
   	  $('#myModalAssociaDocumenti').on('shown.bs.modal', function () {
   		  var table = $('#table_doc').DataTable();
   			table.columns.adjust().draw();
   			
   		})
   	  
     });
 	  
 }

 function controllaAssociati(table, lista_documenti_associati){
 	
 	//var dataSelected = table.rows( { selected: true } ).data();
 	var data = table.rows().data();
 	for(var i = 0;i<lista_documenti_associati.length;i++){
 	
 		table.row( "#"+lista_documenti_associati[i].id ).select();
 			
 		}
 		
 		
 	
 }


 function formatDate(data){
 	
 	   var mydate = new Date(data);
 	   
 	   if(!isNaN(mydate.getTime())){
 	   
 		   str = mydate.toString("dd/MM/yyyy");
 	   }			   
 	   return str;	 		
 }

 

 function modalNuovoDocumento(){
 	
 	$('#myModalnuovoDocumento').modal();
 	
 }

 function modalEliminaDocumento(id_documento){
	 
	 
	 $('#elimina_documento_id').val(id_documento);
		$('#myModalYesOrNo').modal();
 }

 
 $('#committente_docum_mod').change(function(){
		
		var id_committente = $('#committente_docum_mod').val();
		var id_fornitore = $('#fornitore_mod').val();
		var id_documento = $('#id_documento').val();
		getDipendenteFornitoreCommittente("_mod", id_committente, id_fornitore, id_documento);
		
		
	});
 
 
 $('#committente_docum').change(function(){
		
		var id_committente = $('#committente_docum').val();
		var id_fornitore = $('#fornitore').val();
		
		getDipendenteFornitoreCommittente("", id_committente, id_fornitore);
		$('#dipendenti').attr('disabled', false);
		
	});
 
 
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
 
 
 function modificaDocumentoModal(id_documento, committente, fornitore, nome_documento, data_caricamento, frequenza,  data_scadenza, nome_file, rilasciato,numero_documento, tipo_documento, aggiornabile, aggiornabile_default, codice, revisione){

 	$('#id_documento').val(id_documento);
 		
 	$('#fornitore_mod').val(fornitore);
 	$('#fornitore_mod').change();
 	
 	$('#committente_docum_mod').val(committente);
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
 	if(data_caricamento!=null && data_caricamento!=''){
 		$('#data_caricamento_mod').val(Date.parse(data_caricamento).toString("dd/MM/yyyy"));
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
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
 	    	//}

     	} );
     
     

 } );
 

 var columsDatatables1 = [];

 $("#tabDocumReferenti").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables1 = state.columns;
     }
     $('#tabDocumReferenti thead th').each( function () {
      	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
     	  var title = $('#tabDocumReferenti thead th').eq( $(this).index() ).text();
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
 	    	//}

     	} );
     
     

 } );
   
 

 var columsDatatables2 = [];

 $("#tabDocumDipendenti").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables2 = state.columns;
     }
     $('#tabDocumDipendenti thead th').each( function () {
      	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
     	  var title = $('#tabDocumDipendenti thead th').eq( $(this).index() ).text();
     	
     	  //if($(this).index()!=0 && $(this).index()!=1){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables2[$(this).index()].search.search+'" type="text" /></div>');	
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
	
	
	
	
	

	function modalNuovoReferente(){
		
		$('#myModalnuovoReferente').modal();
		
	}


	function modificaReferenteModal(id_referente, committente, fornitore, nome, cognome, note, mansione, qualifica, email){
		
		
		$('#id_referente').val(id_referente);
			
		$('#fornitore_mod').val(fornitore);
		$('#fornitore_mod').change();

	 	$('#committente_ref_mod').val(committente);
	 	$('#committente_ref_mod').change();


		$('#nome_mod').val(nome);
		$('#cognome_mod').val(cognome);
		$('#note_mod').val(note);
		$('#mansione_mod').val(mansione);
		$('#qualifica_mod').val(qualifica);
		$('#email_mod').val(email);

		
		$('#myModalModificaReferente').modal();
	}

	
	
	
	

	function modalNuovoDipendente(){
		
		$('#myModalnuovoDipendente').modal();
		
	}


	function modificaDipendenteModal(id_dipendente, committente, fornitore, nome, cognome, note,  qualifica){
		
		
		$('#id_dipendente').val(id_dipendente);
			
		$('#fornitore_mod').val(fornitore);
		$('#fornitore_mod').change();
		
	 	$('#committente_dip_mod').val(committente);
	 	$('#committente_dip_mod').change();


		$('#nome_dip_mod').val(nome);
		$('#cognome_dip_mod').val(cognome);
		$('#note_dip_mod').val(note);
		
		$('#qualifica_dip_mod').val(qualifica);

		
		$('#myModalModificaDipendente').modal();
	}
	
	
    $(document).ready(function() {
    
    	$('.select2').select2();
    	  $('.datepicker').datepicker({
    			 format: "dd/mm/yyyy"
    		 });  
    	
    	  $('.dropdown-toggle').dropdown();
    	     
    	  
    	  
    	$('#fornitore_mod').val('${fornitore.id}');
    	$('#fornitore').val('${fornitore.id}');
    	
    	$('#fornitore_dip_mod').val('${fornitore.id}');
    	$('#fornitore_dip').val('${fornitore.id}');
    	
    	$('#fornitore_ref_mod').val('${fornitore.id}');
    	$('#fornitore_ref').val('${fornitore.id}');
    	
    	
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
 		    	 { responsivePriority: 2, targets: 12 },
 		    	  
 		               ], 	        
 	  	      /* buttons: [   
 	  	          {
 	  	            //extend: 'colvis',
 	  	            //text: 'Nascondi Colonne'  	                   
 	 			  } ] */
 		               
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
 	
 	
 	
 	
 	
 	
 	
 	
 	  tableRef = $('#tabDocumReferenti').DataTable({
			language: {
		        	emptytable : 	"Nessun dato presente nella tabella",
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
		    	  
		    	  
		               ], 	        
	  	    /*   buttons: [   
	  	          {
	  	           // extend: 'colvis',
	  	            //text: 'Nascondi Colonne'  	                   
	 			  } ] */
		               
		    });
		
		tableRef.buttons().container().appendTo( '#tabDocumReferenti_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tableRef.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tableRef.column( colIdx ).header() ).on( 'keyup', function () {
	      tableRef
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		tableRef.columns.adjust().draw();
		

	$('#tabDocumReferenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
 	
 	
 	
	 tableDip = $('#tabDocumDipendenti').DataTable({
			language: {
		        	emptytable : 	"Nessun dato presente nella tabella",
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
		    	  
		    	  
		               ], 	        
	/*   	      buttons: [   
	  	          {
	  	            //extend: 'colvis',
	  	            //text: 'Nascondi Colonne'  	                   
	 			  } ]
		               */ 
		    });
		
		tableDip.buttons().container().appendTo( '#tabDocumDipendenti_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     tableDip.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', tableDip.column( colIdx ).header() ).on( 'keyup', function () {
	      tableDip
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} );  
	
	
	
		tableDip.columns.adjust().draw();
		

	$('#tabDocumDipendenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
 	
	tabDoc = $('#table_doc').DataTable({
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
        "order": [[ 2, "desc" ]],
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,  
	      scrollX: false,
	      stateSave: true,	
	      select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},
	      columns : [
	    	  {"data" : "empty"},  
	    	{"data" : "check"},  
	      	{"data" : "id"},
	      	{"data" : "committente"},
	      	{"data" : "fornitore"},
	      	{"data" : "nome_documento"},
	      	{"data" : "numero_documento"},
	      	{"data" : "data_caricamento"},
	      	{"data" : "data_rilascio"},
	    	{"data" : "data_scadenza"},
	      	{"data" : "frequenza"},

	      	{"data" : "rilasciato"},
	      	{"data" : "azioni"},
	       ],	
	           
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { responsivePriority: 2, targets:11 },
	    	  
	    	  { className: "select-checkbox", targets: 1,  orderable: false }
	    	  ],
	    	  
	     	          
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	
	
	
	
	
	
	var	  tabStorico = $('#table_storico').DataTable({
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
		      	{"data" : "data_scadenza"},
		      	{"data" : "frequenza"},
		      	{"data" : "rilasciato"},
		      	{"data" : "azioni"},
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 11 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
	
	
	
	
	tabDoc.buttons().container().appendTo( '#table_doc_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	   tabDoc.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tabDoc.column( colIdx ).header() ).on( 'keyup', function () {
	  tabDoc
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  
 	
 	     
 	     
 	     
 		
 
 			
 		 /* 			tabStorico.buttons().container().appendTo( '#table_storico_wrapper .col-sm-6:eq(1)');
 		 	    $('.inputsearchtable').on('click', function(e){
 		 	       e.stopPropagation();    
 		 	    });

 		 	     tabStorico.columns().eq( 0 ).each( function ( colIdx ) {
 		  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
 		      tabStorico
 		          .column( colIdx )
 		          .search( this.value )
 		          .draw();
 		  } );
 		} );   */
 		
 	
 	
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
    

    $('#modificaReferenteForm').on('submit', function(e){
    	 e.preventDefault();
    	 modificaReferente();
    });
     

     
     $('#nuovoReferenteForm').on('submit', function(e){
    	 e.preventDefault();
    	 nuovoReferente();
    });
     
     
     $('#modificaDipendenteForm').on('submit', function(e){
    	 e.preventDefault();
    	 modificaDipendente();
    });
     

     
     $('#nuovoDipendenteForm').on('submit', function(e){
    	 e.preventDefault();
    	 nuovoDipendente();
    });
     
     $('#myModalStorico').on('hidden.bs.modal', function(){
    	 $(document.body).css('padding-right', '0px'); 
     });
     

     

  </script>
  
</jsp:attribute> 
</t:layout>

