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
        Lista Corsi
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
	Lista Corsi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<c:set var="admin" value="1"></c:set>
<a class="btn btn-primary pull-right" onClick="modalnuovoCorso()"><i class="fa fa-plus"></i> Nuovo Corso</a> 
</c:if>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForCorso" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th>ID</th>
<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<th>Visibile al cliente</th>
</c:if>
<th>Tipologia</th>
<th>Descrizione</th>
<th>Commessa</th>
<th>Docente</th>
<th>E-Learning</th>
<th>Data Inizio</th>
<th>Data Scadenza</th>
<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<th style="min-width:235px">Azioni</th>
</c:if>
<c:if test="${!userObj.checkRuolo('AM') && !userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<th style="min-width:150px">Azioni</th>
</c:if>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_corsi }" var="corso" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${corso.id }</td>	
	
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<c:if test="${corso.visibile==0 }">
	<td>
	<input type="checkbox" id="check_${corso.id }" name="check_${corso.id }" onClick="checkCorso('${corso.id}')" class="icheckbox">
	</td>
	</c:if>
	<c:if test="${corso.visibile==1 }">
	<td>
	<input type="checkbox" id="check_${corso.id }" name="check_${corso.id }" checked  onclick="checkCorso('${corso.id}')" class="icheckbox">
	</td>
	</c:if>
	
	</c:if>
	
	<td>${corso.corso_cat.descrizione }</td>
	<td>${corso.descrizione }</td>
	<td>${corso.commessa }</td>
	<td>${corso.docente.nome } ${corso.docente.cognome }</td>
	<td>
	<c:if test="${corso.e_learning == 0 }">
	NO
	</c:if>
	<c:if test="${corso.e_learning == 1 }">
	SI
	</c:if>
	</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso.data_corso}" /></td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso.data_scadenza}" /></td>
	<td>

	<a class="btn btn-info" onClick="dettaglioCorso('${utl:encryptData(corso.id)}')"><i class="fa fa-search"></i></a>
		 	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<%-- 	 	<c:if test="${corso.e_learning == 0}"> --%>
				<a class="btn btn-warning" onClicK="modificaCorsoModal('${corso.id}','${corso.corso_cat.id }_${corso.corso_cat.frequenza }','${corso.docente.id}','${corso.data_corso }','${corso.data_scadenza }','${corso.documento_test }','${utl:escapeJS(corso.descrizione) }','${corso.edizione }','${corso.commessa }','${corso.e_learning }')" title="Click per modificare il corso"><i class="fa fa-edit"></i></a>	 	
	<%-- 	 	</c:if>
	<c:if test="${corso.e_learning == 1}">
				<a class="btn btn-warning" onClicK="modificaCorsoModal('${corso.id}','${corso.corso_cat.id }_${corso.corso_cat.frequenza }',0,'${corso.data_corso }','${corso.data_scadenza }','${corso.documento_test }','${corso.descrizione }','${corso.edizione }','${corso.commessa }','${corso.e_learning }')" title="Click per modificare il corso"><i class="fa fa-edit"></i></a>	 	
		 	</c:if> --%>
	</c:if>
	<c:if test="${corso.documento_test!=null }">
	<a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_documento_test&id_corso=${utl:encryptData(corso.id)}" title="Click per scaricare il documento del test"><i class="fa fa-file-pdf-o"></i></a>
	</c:if>
	<a href="#" class="btn btn-primary customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${corso.id }')"><i class="fa fa-archive"></i></a>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<a class="btn btn-danger customTooltip" title="Click per eliminare il corso" onClick="eliminaCorsoModal('${corso.id}')"><i class="fa fa-trash"></i></a>
	<c:if test="${corso.scheda_consegna_inviata == 1 }">
	<a class="btn btn-primary customTooltip" title="Vai allo storico email" onClick="modalStorico('${corso.id}')"><i class="fa fa-envelope"></i></a>
	</c:if>
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


</section>



  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>

<form id="nuovoCorsoForm" name="nuovoCorsoForm">
<div id="myModalNuovoCorso" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="categoria" name="categoria" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Tipologia Corso..." required>
        <option value=""></option>
        <c:forEach items="${lista_corsi_cat }" var="categoria">
        <option value="${categoria.id }_${categoria.frequenza }">${categoria.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="commessa" name="commessa" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Commessa..." >
        <option value=""></option>
        <c:forEach items="${lista_commesse }" var="commessa">
        <option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<textarea class="form-control" rows="3" style="width:100%" id="descrizione" name="descrizione"></textarea>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Edizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="edizione" name="edizione" class="form-control">
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corso E-Learning</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_e_learning" name="check_e_learning" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Docente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         	<select id="docente" name="docente" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Docente..." required>
        <option value=""></option>
        <c:forEach items="${lista_docenti }" var="docente">
        <option value="${docente.id }">${docente.nome } ${docente.cognome }</option>
        </c:forEach>
        </select>	
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Corso</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_corso" name="data_corso" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
        
       			
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
       	</div>			<br>	
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Documento Test</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload" name="fileupload" type="file" required></span><label id="label_file"></label>
       	    </div>
        
       	</div>
            	
       
       
       </div>
  		 
      <div class="modal-footer">
		<input type="hidden" id="e_learning" name="e_learning">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaCorsoForm" name="modificaCorsoForm">
<div id="myModalModificaCorso" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="categoria_mod" name="categoria_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Tipologia Corso..." required>
        <option value=""></option>
        <c:forEach items="${lista_corsi_cat }" var="categoria">
        <option value="${categoria.id }_${categoria.frequenza}">${categoria.descrizione }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="commessa_mod" name="commessa_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Commessa..." >
        <option value=""></option>
        <c:forEach items="${lista_commesse }" var="commessa">
        <option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
        </c:forEach>
        </select>
       			
       	</div>       	
       </div><br>
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<textarea class="form-control" rows="3" style="width:100%" id="descrizione_mod" name="descrizione_mod"></textarea>
       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Edizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<input type="text" id="edizione_mod" name="edizione_mod" class="form-control">
       			
       	</div>       	
       </div><br>
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corso E-Learning</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_e_learning_mod" name="check_e_learning_mod" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Docente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       	<select id="docente_mod" name="docente_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Docente..." required>
        <option value=""></option>
        <c:forEach items="${lista_docenti }" var="docente">
        <option value="${docente.id }">${docente.nome } ${docente.cognome }</option>
        </c:forEach>
        </select>	
       	  	
       	  

       			
       	</div>       	
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data Inizio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_corso_mod" name="data_corso_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
        
       			
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
       	</div>	<br>	
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Documento Test</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	    <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".pdf,.PDF"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_file_mod"></label>
       	    </div>
        
       	</div>
       	</div>		
     
       
     
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_corso" name="id_corso">
		<input type="hidden" id="e_learning_mod" name="e_learning_mod">
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
      	Sei sicuro di voler eliminare il corso?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_corso_elimina">
      <a class="btn btn-primary" onclick="eliminaForCorso($('#id_corso_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalEmailReferente" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Vuoi inviare la scheda di consegna ai referenti?</h4>
      </div>
       <div class="modal-body">       
      	<input type="text" class="form-control" id="referenti" name="referenti">
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_corso_referente">
      <a class="btn btn-primary" onclick="inviaComunicazioneReferente($('#id_corso_referente').val(), $('#referenti').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#modalEmailReferente').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalStorico" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Storico</h4>
      </div>
       <div class="modal-body">       
      	<div id="content_storico"></div>
      	</div>
      <div class="modal-footer">

      
		<a class="btn btn-primary" onclick="$('#myModalStorico').modal('hide')" >Chiudi</a>
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
<script type="text/javascript">


function modalnuovoCorso(){
	
	$('#myModalNuovoCorso').modal();
	
}

function eliminaCorsoModal(id_corso){
	
	$('#id_corso_elimina').val(id_corso);
	
	$('#myModalYesOrNo').modal();
}


function modificaCorsoModal(id_corso,id_categoria, id_docente, data_inizio, data_scadenza, documento_test, descrizione, edizione, commessa,e_learning){
	
	$('#id_corso').val(id_corso);
	$('#categoria_mod').val(id_categoria);
	$('#categoria_mod').change();
	if(id_docente!=null && id_docente!='0'){
		$('#docente_mod').val(id_docente);
		$('#docente_mod').change();
	}	
	$('#commessa_mod').val(commessa);
	$('#commessa_mod').change();
	if(data_inizio!=null && data_inizio!=''){
		$('#data_corso_mod').val(Date.parse(data_inizio).toString("dd/MM/yyyy"));
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
		
	$('#label_file_mod').html(documento_test);
	$('#descrizione_mod').val(descrizione);
	$('#edizione_mod').val(edizione);
	
	if(e_learning =='1'){	

		$('#check_e_learning_mod').iCheck('check');
		$('#e_learning_mod').val(1); 
		$('#docente_mod').attr('disabled', true);
		$('#docente_mod').attr('required', false);
	}else{
		$('#check_e_learning_mod').iCheck('uncheck');
		$('#e_learning_mod').val(0);
		$('#docente_mod').attr('disabled', false);
		$('#docente_mod').attr('required', true);
	}
	
	$('#myModalModificaCorso').modal();
}



$('#check_e_learning').on('ifClicked',function(e){
	if($('#check_e_learning').is( ':checked' )){
		$('#check_e_learning').iCheck('uncheck');
		$('#e_learning').val(0); 
		$('#docente').attr('disabled', false);
	}else{
		$('#check_e_learning').iCheck('check');
		$('#e_learning').val(1);
		$('#docente').attr('disabled', true);
	}
});
	 

$('#check_e_learning_mod').on('ifClicked',function(e){
	if($('#check_e_learning_mod').is( ':checked' )){
		$('#check_e_learning_mod').iCheck('uncheck');
		$('#e_learning_mod').val(0); 
		$('#docente_mod').attr('disabled', false);
	}else{
		$('#check_e_learning_mod').iCheck('check');
		$('#e_learning_mod').val(1); 
		$('#docente_mod').attr('disabled', true);
	}
});



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });


var columsDatatables = [];

$("#tabForCorso").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForCorso thead th').each( function () {
    	
    	//$(this).css('background-color','#3c8dbc');  	
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
    		  
    		  if(admin=='1' && $(this).index()==1){
    			 // $(this).append( '<div><input  style="width:100%"  type="checkbox" id="checkall" name="checkall"/></div>');
    			  
    			 
    		  }else{
    			  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
    		  }
		    		
	    	//}

    	} );
    
    

} );


function modalArchivio(id_corso){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria=0&id_corso="+ id_corso;
    exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}

function dettaglioCorso(id_corso){
	
	callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso='+id_corso);
}


$('#data_corso').change(function(){
	
		  var tipologia = $('#categoria').val();
		  
		  if(tipologia!=null && tipologia!=''){
			  var frequenza = tipologia.split("_")[1];
			  var data =  Date.parse(formatDate($('#data_corso').val()));	
			  var data_scadenza = data.addMonths(parseInt(frequenza));
			  $('#data_scadenza').val(formatDate(data_scadenza));
		  }
		 
});
	
	
	
$('#categoria').change(function(){
	
	  var tipologia = $('#categoria').val();
	  
	  
	  if($('#data_corso').val()!=null && $('#data_corso').val()!=''){
		  var frequenza = tipologia.split("_")[1];
		  var x = formatDate($('#data_corso').val());
		  var data =  Date.parse(x);	
		  var data_scadenza = data.addMonths(parseInt(frequenza));
		  $('#data_scadenza').val(formatDate(data_scadenza));
	  }
	 
});


$('#data_corso_mod').change(function(){
	
	  var tipologia = $('#categoria_mod').val();
	  
	  if(tipologia!=null && tipologia!=''){
		  var frequenza = tipologia.split("_")[1];
		  var data =  Date.parse(formatDate($('#data_corso_mod').val()));	
		  var data_scadenza = data.addMonths(parseInt(frequenza));
		  $('#data_scadenza_mod').val(formatDate(data_scadenza));
	  }
	 
});



$('#categoria_mod').change(function(){

var tipologia = $('#categoria_mod').val();


if($('#data_corso_mod').val()!=null && $('#data_corso_mod').val()!=''){
	  var frequenza = tipologia.split("_")[1];
	  var x = formatDate($('#data_corso_mod').val());
	  var data =  Date.parse(x);	
	  var data_scadenza = data.addMonths(parseInt(frequenza));
	  $('#data_scadenza_mod').val(formatDate(data_scadenza));
}

});
	
function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

function changeSkin(){
	
	 //var skinName = $(this).data('skin')
	    $('body').removeClass('skin-red-light')
	    $('body').addClass('skin-blue')
	    //currentSkin = skinName
	
}

	
	
$('input:checkbox').on('ifToggled', function() {
	
	//var id =$(this)[0].id;
	
	var id ="#"+$(this)[0].id;
	
	if(id!='#checkall' && id!='#check_e_learning' && id!='#check_e_learning_mod'){
		$(id).on('ifChecked', function(event){
			  setVisibilita(id, 1);
			  
			  var dataObj = {};
    	dataObj.id_corso = id.split("_")[1];

    	$('#id_corso_referente').val(id.split("_")[1]);
    	
    	  $.ajax({
    	type: "POST",
    	url: "gestioneFormazione.do?action=referenti_corso",
    	data: dataObj,
    	dataType: "json",
    	//if received a response from the server
    	success: function( data, textStatus) {
    		pleaseWaitDiv.modal('hide');
    		  if(data.success){	  	
    			  
    			var email = ""; 
    			  
    			  var referenti = data.lista_referenti_corso;
    			  for (var i = 0; i < referenti.length; i++) {
					
    				  email = email + referenti[i].email+";";
				}
    			  
					$('#referenti').val(email)
					  $('#modalEmailReferente').modal();
    		  }else{
    			
    			$('#myModalErrorContent').html(data.messaggio);
    		  	$('#myModalError').removeClass();
    			$('#myModalError').addClass("modal modal-danger");	  
    			$('#report_button').hide();
    			$('#visualizza_report').hide();
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
    	
    	
			  
			
		});


		$(id).on('ifUnchecked', function(event) {
			
			  setVisibilita(id, 0);
			  
			
		});
	}
	

	
	});
	
	

function setVisibilita(id_corso, visibile){
	
	var dataObj = {};
	dataObj.id_corso = id_corso.split("_")[1];
	dataObj.visibile = visibile;	

	  $.ajax({
	type: "POST",
	url: "gestioneFormazione.do?action=visibilita",
	data: dataObj,
	dataType: "json",
	//if received a response from the server
	success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  if(data.success){	  			
	   				  
		  }else{
			
			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').hide();
			$('#visualizza_report').hide();
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


var admin = "";
$(document).ready(function() {
 
	//changeSkin();
	admin="${admin}";
	
	var col_azioni = 8;
	
	if(admin == "1"){
		col_azioni++;
	}
	
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();

     table = $('#tabForCorso').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: col_azioni },
		    	   { targets: 1,  orderable: false }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabForCorso_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabForCorso').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
    $('#checkall').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
      }); 
	
    
	
    $("#checkall").on('ifChecked', function(event){
    	 
    	$('input:checkbox').each(function(){
    		
    		var id =$(this)[0].id;
    		console.log($(this)[0].id);
    		if(id!=''&& id!='checkall' && id!='check_e_learning' && id!='check_e_learning_mod'){
    			console.log(id);
    			id="#"+id;
    			if($(id).prop('checked')== false){
    				
    			$(id).iCheck('check');        			    			
        		
    				  setVisibilita(id, 1);
    			}

    		}
    	
    	
    		
    	})
    });


    $("#checkall").on('ifUnchecked', function(event){
     
    	$('input:checkbox').each(function(){
    		
    		var id =$(this)[0].id;
    		
    		if(id!=''&& id!='checkall' && id!='check_e_learning' && id!='check_e_learning_mod'){
    				
    			id="#"+id;
    			if($(id).prop('checked')== true){
    			$(id).iCheck('uncheck');        			    			
     		
    			  setVisibilita(id, 0);   
    			}

    		}
    	
    	
    		
    	})
    });

	
	
});


$('#modificaCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForCorso();
});
 

 
 $('#nuovoCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForCorso();
});
 
 
 
 function inviaComunicazioneReferente(id_corso, indirizzi){
		
		
		
		var dataObj = {};
		dataObj.id_corso = id_corso;
		dataObj.indirizzi = indirizzi;


		  $.ajax({
		type: "POST",
		url: "gestioneFormazione.do?action=invia_comunicazione",
		data: dataObj,
		dataType: "json",
		//if received a response from the server
		success: function( data, textStatus) {
			pleaseWaitDiv.modal('hide');
			  if(data.success){	  	
				 
				  pleaseWaitDiv.modal('hide');
					$('#myModalErrorContent').html(data.messaggio);
					$('#myModalError').removeClass();	
					$('#myModalError').addClass("modal modal-success");	  
					$('#report_button').hide();
					$('#visualizza_report').hide();		
					$('#myModalError').modal('show');
					
					$('#myModalError').on('hidden.bs.modal',function(){
						location.reload();
					});
			  }else{
				
				$('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");	  
				$('#report_button').hide();
				$('#visualizza_report').hide();
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

 
 
 function modalStorico(id_corso){
	  
	  dataString ="action=storico_email&id_corso="+ id_corso;
     exploreModal("gestioneFormazione.do",dataString,"#content_storico",function(datab,textStatusb){
     });
	  
	  $('#myModalStorico').modal()
 }
 
  </script>
  
</jsp:attribute> 
</t:layout>

