<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%-- 	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");

	
	%> --%>
	

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Pacchi
        <small></small>
      </h1>
    </section>

    <!-- Main content -->
     <section class="content">

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
<div class="row" style="margin-top:20px;">
<div class="col-sm-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Data Lavorazione</th>
 <th>Stato</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Codice pacco</th>
 <th>Origine</th>
 <th>Commessa</th>
 <th>Azioni</th>
 <th>Strumenti Lavorati</th>
 <th>DDT</th>
 <th>Company</th>
 <th>Responsabile</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_pacchi}" var="pacco" varStatus="loop">
<tr>
<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${pacco.id}')">
${pacco.id}
</a>
</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_lavorazione}" /></td>
<td>
<c:if test="${pacco.stato_lavorazione.id == 1}">
 <span class="label label-info">${pacco.stato_lavorazione.descrizione} </span></c:if>
 <c:if test="${pacco.stato_lavorazione.id == 2}">
 <span class="label label-success" >${pacco.stato_lavorazione.descrizione}</span></c:if>
  <c:if test="${pacco.stato_lavorazione.id == 3}">
 <span class="label label-danger" >${pacco.stato_lavorazione.descrizione}</span></c:if>
</td>
<td>${pacco.nome_cliente}</td>
<td>${pacco.nome_sede }</td>
<td>${pacco.codice_pacco}</td>
<td>
<c:if test="${pacco.stato_lavorazione.id!=1 && pacco.origine!='' && pacco.origine!=null}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPaccoFromOrigine('${pacco.origine}')">${pacco.origine}</a>

</c:if>
</td>

<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${pacco.commessa}');">${pacco.commessa}</a>
<%-- <a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="callAction('gestionePacco.do?action=dettaglio_commessa&id_commessa=${pacco.commessa}');">${pacco.commessa}</a> --%>
<td>

<c:if test="${pacco.stato_lavorazione.id==1}">
<a class="btn customTooltip  btn-warning"  title="Click per creare il pacco in uscita" onClick="paccoInUscita('${pacco.id}')"><i class="glyphicon glyphicon-log-out"></i></a>
</c:if>
<c:if test="${pacco.ddt.numero_ddt=='' ||pacco.ddt.numero_ddt==null  }">
<button class="btn customTooltip  btn-info" title="Click per creare il DDT" onClick="creaDDT('${pacco.ddt.id}','${pacco.nome_cliente }','${pacco.nome_sede}')"><i class="glyphicon glyphicon-duplicate"></i></button>
</c:if>
<c:if test="${pacco.stato_lavorazione.id==2 }">
<button class="btn customTooltip  btn-danger" title="Click se il pacco è stato spedito" onClick="paccoSpedito('${pacco.ddt.id}')"><i class="glyphicon glyphicon-send"></i></button>
</c:if>
</td>
<td>${utl:getStringaLavorazionePacco(pacco)}</td>
<c:choose>
<c:when test="${pacco.ddt.numero_ddt!='' &&pacco.ddt.numero_ddt!=null }">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${pacco.ddt.id}')">
${pacco.ddt.numero_ddt}
</a></td></c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>
<td>${pacco.company.denominazione}</td>
<td>${pacco.utente.nominativo}</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>
</div>



  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index:1070">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>
 
 
 
 <form name="NuovoPaccoForm" method="post" id="NuovoPaccoForm" action="gestionePacco.do?action=new" enctype="multipart/form-data">
         <div id="myModalCreaNuovoPacco" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
          
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Pacco</h4>
      </div>
 
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
       
       

     <div class="form-group">
      <div class="row">
 <div class="col-md-12"> 
                  <label>Cliente</label>
                  
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                  <option value=""></option>
                  <c:if test="${userObj.idCliente != 0}">
                  
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
                  <label>Sede</label>
                 
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede..."  disabled class="form-control select2" style="width:100%" aria-hidden="true" data-live-search="true">
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
                  </select> 
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
 <br>  <div class="row" >                 
<div class= "col-xs-6">

            <b>Codice Pacco</b><br>
             <a class="pull-center" ><input type="text" class="pull-left form-control" id=codice_pacco name="codice_pacco" style="margin-top:6px;" value="PC_${(pacco.id)+1}" readonly ></a> 
        </div>
        <div class= "col-xs-6">
	 
         <label class="pull-center">Stato Lavorazione</label> <select name="stato_lavorazione" id="stato_lavorazione" data-placeholder="Seleziona Stato Lavorazione..." class="form-control select2-drop" style="width:100%" aria-hidden="true" data-live-search="false">
                   		
                   		<c:forEach items="${lista_stato_lavorazione}" var="stato">
                          	 <option value="${stato.id}">${stato.descrizione}</option>    
                     	</c:forEach>
                  </select>
                  
        </div>
</div >
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
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Numero DDT</label> <a class="pull-center"><input type="text" class="form-control" id="numero_ddt" name="numero_ddt" ></a>
				
				<li class="list-group-item">
	<label>Tipo Trasporto</label><select name="tipo_trasporto" id="tipo_trasporto" data-placeholder="Seleziona Tipo Trasporto..." class="form-control select2-drop" style="width:100%"  aria-hidden="true" data-live-search="false">
		
		<c:forEach items="${lista_tipo_trasporto}" var="tipo_trasporto">
			<option value="${tipo_trasporto.id}">${tipo_trasporto.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo Porto</label><select name="tipo_porto" id="tipo_porto" data-placeholder="Seleziona Tipo Porto..."  class="form-control select2-drop" style="width:100%" aria-hidden="true" data-live-search="true">
		
		<c:forEach items="${lista_tipo_porto}" var="tipo_porto">
			<option value="${tipo_porto.id}">${tipo_porto.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	<li class="list-group-item">
	<label>Tipo DDT</label><select name="tipo_ddt" id="tipo_ddt" data-placeholder="Seleziona Tipo DDT..." class="form-control select2-drop"  style="width:100%" aria-hidden="true" data-live-search="true">

		<c:forEach items="${lista_tipo_ddt}" var="tipo_ddt">
			<option value="${tipo_ddt.id}">${tipo_ddt.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	
			<li class="list-group-item">
          <label>Data DDT</label>    
      
            <div class='input-group date' id='datepicker_ddt'>
               <input type='text' class="form-control input-small" id="data_ddt" name="data_ddt"/>
                <span class="input-group-addon">
                    <span class="fa fa-calendar">
                    </span>
                </span>
        </div> 

		</li>
	<li class="list-group-item">
	<label>Aspetto</label><select name="aspetto" id="aspetto" data-placeholder="Seleziona Tipo Aspetto..."  class="form-control select2-drop" style="width:100%" aria-hidden="true" data-live-search="true">
		
		<c:forEach items="${lista_tipo_aspetto}" var="aspetto">
			<option value="${aspetto.id}">${aspetto.descrizione}</option>
		</c:forEach>
	</select>
	</li>
	</ul>
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <label>Causale</label> <a class="pull-center"><input type="text" class="form-control" id="causale" name="causale" ></a>
                
				</li>
				<li class="list-group-item">
                  <label>Destinatario</label> <a class="pull-center"><input type="text" class="form-control" id="destinatario" name="destinatario"></a>
				
	</li>
	<li class="list-group-item">
                  <label>Via</label> <a class="pull-center"><input type="text" class="form-control" id="via" name="via"></a>
				
			
	</li>
	<li class="list-group-item">
                  <label>Città</label> <a class="pull-center"><input type="text" class="form-control" id="citta" name="citta"></a>
				
				
	</li>
	<li class="list-group-item">
                  <label>CAP</label> <a class="pull-center"><input type="text" class="form-control" id="cap" name="cap"></a>
				
			
	</li>
	
	<li class="list-group-item">
                  <label>Provincia</label> <a class="pull-center"><input type="text" class="form-control" id="provincia" name="provincia"> </a>
				
				
	</li>
	<li class="list-group-item">
                  <label>Paese</label> <a class="pull-center"><input type="text" class="form-control" id="paese" name="paese"></a>
				
				
	</li>

	</ul>
	
	
	
	</div>
	
	<div class= "col-md-4">
	<ul class="list-group list-group-unbordered">
		<li class="list-group-item">
          <label>Data e Ora Trasporto</label>    

        <div class="input-group date"  id="datetimepicker">
            <input type="text" class="form-control input-small" id="data_ora_trasporto" name="data_ora_trasporto"/>
            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
        </div>

		</li>
	

		<li class="list-group-item">
                  <label>Spedizioniere</label> <!-- <a class="pull-center"><input type="text" class="pull-right" id="spedizioniere" name="spedizioniere"> </a> -->
				<select name="spedizioniere" id="spedizioniere" data-placeholder="Seleziona Spedizioniere..."  class="form-control select2-drop" style="width:100%" aria-hidden="true" data-live-search="true">
		
		<c:forEach items="${lista_spedizionieri}" var="spedizioniere">
			<option value="${spedizioniere.id}">${spedizioniere.denominazione}</option>
		</c:forEach>
	</select>
				
				
				
	</li>
	<li class="list-group-item">
                  <label>Annotazioni</label> <a class="pull-center"><input type="text" class="form-control" id="annotazioni" name="annotazioni"> </a>
				
				<li class="list-group-item">
	</li>
	
	<li class="list-group-item">
                  <label>Note</label> <a class="pull-center">
				<textarea name="note" form="NuovoPaccoForm" class="form-control"></textarea></a>
				<li class="list-group-item">
	</li>
	
		
	</ul>

		        <input id="fileupload" type="file" name="file" class="form-control"/>
	
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
	<select name="tipo_item" id="tipo_item" data-placeholder="Seleziona Tipo item" class="-control select2-drop form-control"  aria-hidden="true" data-live-search="true">
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
<table id="tabItem" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Tipo</th>
 <th>Denominazione</th>
 <th>Quantità</th>
 <th>Stato</th>
 <th>Note</th>
 <th>Action</th>


 </tr></thead>
 
 <tbody>

</tbody>
 </table>
 
 
 </div>

</div>


    
     <div class="modal-footer">

		<input type="hidden" class="pull-right" id="json" name="json">
	
       <button class="btn btn-default pull-left" onClick="inserisciPacco()"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>  
       
    </div>
    </div>
      </div>
    
      </div>

 </form>  



  <div id="myModalItem" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
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
 
 
 
 
   <div id="myModalCommessa" class="modal fade " role="dialog" aria-labelledby="myLargeModalLabel">
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

<script type="text/javascript">


function creaDDT(id_ddt,nome_cliente, nome_sede){


	$('#collapsed_box').removeClass("collapsed-box");
	$("#numero_ddt").attr("required", "true");
	
	var str = nome_sede.split("-");
	$('#destinatario').val(nome_cliente);
	
	if(nome_sede!= "Non associate"){
		value=str[str.length-2] + str[str.length-1]
		value = value.replace("undefined", "");
		$('#via').val(value);
	}
	$('#DDT').clone().appendTo($('#ddt_body'));
	
	$('#ddt_body').find('#datepicker_ddt').each(function(){
		this.id = 'date_ddt';
	});	
	$('#ddt_body').find('#datetimepicker').each(function(){
		this.id = 'date_time_transport';
	});	
	$('#ddt_body').find('#fileupload').each(function(){
		this.id = 'fileupload_create_ddt';
	});	
	$('#date_ddt').datepicker({
		format : "dd/mm/yyyy"
	});
	$('#date_time_transport').datetimepicker({
		format : "dd/mm/yyyy hh:ii"
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
	$('#ddt_body').append("<p align='center'><button type='submit' class='btn btn-default'>Salva</button></p>");	
	$('#myModalDDT').modal();

}

$("#myModalDDT").on("hidden.bs.modal", function () {
	$('#via').val("");
	$('#destinatario').val("");
	$("#numero_ddt").attr("required", "false");
    $('#ddt_body').empty();
    $('#collapsed_box').addClass("collapsed-box");

});


function paccoInUscita(id_pacco){
	
	var codice = "PC_"+${(pacco.id)+1};

	generaPaccoUscita(id_pacco, codice);
	
}



function dettaglioPaccoFromOrigine(origine){
	
	var id = origine.split("_")
	dettaglioPacco(id[1]);
	
}

$("#commessa").change(function(){
	
	$("#commessa_text").val($("#commessa").val());
	
	
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
		
		var json_data = JSON.stringify(items_json);
		
		$('#json').val(json_data);
		$('#codice_pacco').attr('required', 'true');
		var esito = validateForm();
		
		if(esito==true){
		document.getElementById("NuovoPaccoForm").submit();
		
		
		}
		else{};
	}
	
	

	
	function validateForm() {
	    var codice_pacco = document.forms["NuovoPaccoForm"]["codice_pacco"].value;
	    var numero_ddt = document.forms["NuovoPaccoForm"]["numero_ddt"].value;
	    var cliente = document.forms["NuovoPaccoForm"]["select1"].value;
	   
	    if (codice_pacco=="" ||  cliente =="") {
	    	
	    	/* $('#collapsed_box').toggleBox(); */
	      
	        return false;
	    }else{
	    	return true;
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
	    	  $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );

/* 	var columsDatatables2 = [];
	 
 	$("#tabItem").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	    }
	    $('#tabItem thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} );

	} );  */
 

$(document).ready(function() {
	
 	$('#datetimepicker').datetimepicker({
		format : "dd/mm/yyyy hh:ii"
	}); 

	
	$('#datepicker_ddt').datepicker({
		format : "dd/mm/yyyy"
	});

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
				   { responsivePriority: 1, targets: 7 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 0 }
	               ],

	    	
	    });
	


 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
// DataTable
table = $('#tabPM').DataTable();
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
      responsive: true,
      scrollX: false,
      stateSave: true,
     columns : [
    	 {"data" : "id"},
    	 {"data" : "tipo"},
    	 {"data" : "denominazione"},
    	 {"data" : "quantita"},
    	 {"data" : "stato"},
    	 {"data" : "note"},
    	 {"data" : "action"}
     ],	
      columnDefs: [
			   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 2, targets: 1 },
                   { responsivePriority: 3, targets: 2 }
               ],

    	
    });



/*  $('#tabItem thead th').each( function () {
var title = $('#tabPM thead th').eq( $(this).index() ).text();
$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} ); */
/* =======

>>>>>>> branch 'master' of https://github.com/raffan83/AccPoint_Repo.git */
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






$(".select2").select2();
	
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





}); 

$("#select2").change(function(){
	
	var cliente = $('#select1').val();
	var sede = $('#select2').val();
	
	var str = cliente.split("_");
	
	$('#destinatario').val(str[1]);
	
	var str2 = sede.split("_");
	$('#via').val(str2[5]);
	
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
  
  

</script>





</jsp:attribute> 
</t:layout>
  
 
