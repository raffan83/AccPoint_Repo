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

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Corso
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            <c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }">
                        <div class="row">
<div class="col-md-12">
<a class="btn btn-warning pull-right" onClicK="modificaCorsoModal('${corso.id}','${corso.corso_cat.id }_${corso.corso_cat.frequenza }','${utl:escapeJS(corso.getDocentiCorsoJson())}','${corso.data_corso }','${corso.data_scadenza }','${corso.documento_test }','${utl:escapeJS(corso.descrizione) }','${corso.tipologia }','${corso.commessa }','${corso.e_learning }', '${corso.durata }','${corso.efei }', '${corso.frequenza_remind }', '${corso.giorni_preavviso }')" title="Click per modificare il corso"><i class="fa fa-edit"></i> Modifica Corso</a>

</div>
</div><br>
            </c:if>
            <div class="row">
<div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Corso
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${corso.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${corso.commessa}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Corso</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_corso}" /></a>
                </li>
                
                <li class="list-group-item">
                  <b>Data Scadenza</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_scadenza}" /></a>
                </li>
                <li class="list-group-item">
               
                 <b>Docenti</b> 
                <c:forEach items="${corso.getListaDocenti() }" var="docente">
                 <div class="row">
                <div class="col-xs-12">
                <c:if test="${docente!=null }">
               <a target="_blank" class="btn btn-danger  btn-xs pull-right customTooltip" href="gestioneFormazione.do?action=download_curriculum&id_docente=${utl:encryptData(docente.id)}" title="Click per scaricare il cv"><i class="fa fa-file-pdf-o"></i></a></c:if>
                <a class="pull-right">${docente.nome } ${docente.cognome }</a>
                
            </div>
                </div>
                </c:forEach>
                </li>
                <li class="list-group-item">
              
                <b>Numero partecipanti</b> <a class="pull-right" id="n_partecipanti"></a>
                </li>
                
  				 <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Descrizione</b>
                  
                 <a class="pull-right">${corso.descrizione}</a>
                 </div>
                 </div>
                </li>
  				 
         <%--        <li class="list-group-item">
              
                <b>QR Code</b><a  target="_blank" class="btn btn-primary btn-xs pull-right customTooltip"  href="gestioneFormazione.do?action=crea_qr&id_corso='${utl:encryptData(corso.id)}'"><i class="fa fa-qrcode" aria-hidden="true"></i></a>
                </li> --%>
               
        </ul>

</div>
</div>
</div>




<div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Categoria
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               <li class="list-group-item">
                  <b>Codice</b> <a class="pull-right">${corso.corso_cat.codice}</a>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Descrizione</b> <a class="pull-right">${corso.corso_cat.descrizione}</a>
                  </div>
                  </div>
                </li>                
                
                <li class="list-group-item">
                  <b>Frequenza (mesi)</b> <a class="pull-right">${corso.corso_cat.frequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Durata (ore)</b> <a class="pull-right">${corso.durata}</a>
                </li>
               
			<li class="list-group-item">
                <b>Tipologia</b> <a class="pull-right">${corso.tipologia}</a>
                </li>
               
        </ul>

</div>
</div>




<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Referenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <a class="btn btn-primary pull-right" onClick="$('#modalReferenti').modal()"><i class="fa fa-plus"></i> Referenti corso</a>

</div>
</div>
</c:if>

</div>

       
 </div>
        <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Allegati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_allegati"></div>

</div>
</div>
</div>
    
    </div>
    
    
   	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">

<c:if test="${corso.questionario== null || corso.questionario.salvato==0 }">
<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Compila questionario</a>
</c:if>

<c:if test="${corso.questionario!= null && corso.questionario.salvato==1 }">


<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza o modifica questionario</a>

</c:if>

</div>
</div>

</div>
</div>
</div>
    
    </div>
 </c:if>   
 
 
    	<c:if test="${userObj.checkRuolo('F2') && corso.questionario!= null && corso.questionario.salvato==1 }">
    	  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">




<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza questionario</a>


</div>
</div>

</div>
</div>
</div>
    
    </div>
    	
    	</c:if>
 
 
    
    <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_partecipanti"></div>


</div>
</div>
</div>
    
    </div>
        
          <div id="modalReferenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Referenti Corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
      	<div class="col-xs-12">
      	
      	<a class="btn btn-primary pull-right" onClick="$('#modalAssociaReferenti').modal()"><i class="fa fa-plus"></i> Associa Referente</a>
      	
      	</div>
      	</div><br>
      	<div class="row">
      	<div class="col-xs-12">
      	<div id="content_referenti">
      	<c:forEach items="${corso.getListaReferenti() }" var="referente">
      	 <li class="list-group-item">
                  <div class="row">  <div class="col-xs-4"><b>${referente.nome } ${referente.cognome }</b></div><div class="col-xs-4"> <b>${referente.nome_azienda } - ${referente.nome_sede }</b></div><div class="col-xs-4"> <a class="pull-right">${referente.email }</a></div></div>
                </li>
      	
      	</c:forEach>
      	</div>
      	</div>
      	
      	</div>
      	</div>
      <div class="modal-footer">
     
    </div>
  </div>

</div>




 <div id="modalAssociaReferenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Referenti</h4>
      </div>
       <div class="modal-body">       

      	<div class="row">
      	<div class="col-xs-12">
      	<table id="tabForCorso" class="table table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th style="max-width:40px">Sel</th>
<th>Nome</th>
<th>Cognome</th>
<th>Azienda</th>
<th>Sede</th>
<th>Email</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_referenti }" var="referente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>
	<c:if test="${corso.getListaReferenti().contains(referente) }">
	<input type="checkbox" id="check_referente_${referente.id }" checked onchange="associaDissociaReferente('${referente.id}', '${corso.id }')">
	</c:if>
	<c:if test="${!corso.getListaReferenti().contains(referente) }">
	<input type="checkbox" id="check_referente_${referente.id }" onchange="associaDissociaReferente('${referente.id}', '${corso.id }')">
	</c:if>
	</td>
	<td>${referente.nome }</td>
	<td>${referente.cognome }</td>	
	<td>${referente.nome_azienda }</td>	
	<td>${referente.nome_sede }</td>	
	<td>${referente.email }</td>	
		
	
	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
      	</div>
      	
      	</div>
      	</div>
      <div class="modal-footer">
     
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
       		<label>Categoria</label>
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
       		<label>Tipologia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
      	<select id="tipologia_mod" name="tipologia_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona tipologia..." required >
      	<option value=""></option>
      	<option value="BASE">BASE</option>
      	<option value="AGGIORNAMENTO">AGGIORNAMENTO</option>
      	</select>
       			
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
       	  	
       	<select id="docente_mod" name="docente_mod" class="form-control select2" style="width:100%"  data-placeholder="Seleziona Docente..." required multiple>
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
       		<label>Durata (Ore)</label>
       	</div>
       	<div class="col-sm-9">             	  	
        
       	<input id="durata_mod" name="durata_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
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
       	
       	
       	
       	<br>
            	         
            	         
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corso Efei</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="check_efei_mod" name="check_efei_mod" class="form-control" type="checkbox" style="width:100%" >
       			
       	</div>       	
       </div><br>
       	
       	
       	
       	   	         
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza Remind Efficacia (Giorni)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_remind_mod" name="frequenza_remind_mod" class="form-control" type="number" step="1"  min = "0" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Giorni Preavviso</label>
       	</div>
       	<div class="col-sm-9">      
       	  
        <input id="giorni_preavviso_mod" name="giorni_preavviso_mod" class="form-control" type="number" step="1"  min = "0" style="width:100%" >
       			
       	</div>       	
       </div>
       	
       	</div>		
     
       
     
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_corso" name="id_corso">
		<input type="hidden" id="e_learning_mod" name="e_learning_mod">
		<input type="hidden" id="efei_mod" name="efei_mod">
		<input type="hidden" id="id_docenti_mod" name="id_docenti_mod">
		<input type="hidden" id="id_docenti_dissocia" name="id_docenti_dissocia">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>
  
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
    background-color: #3c8dbc !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
 <script type="text/javascript" src="plugins/datejs/date.js"></script>
  
 <script type="text/javascript">
 
 

 var columsDatatables1 = [];
 $("#tabForCorso").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables1 = state.columns;
     }
     $('#tabForCorso thead th').each( function () {
      	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
     	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
     	
     	  if($(this).index() >0 ){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
 	    	}

     	} );
     
     


 } );

 
function modalArchivio(id_corso){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria=0&id_corso="+ id_corso;
    exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}
   
   
   
function associaDissociaReferente(id_referente, id_corso){
	
	var azione = 'dissocia';
	
	if($('#check_referente_'+id_referente).is( ':checked' )){
		azione = 'associa'
	}
	
	var dataObj = {};
	dataObj.id_corso = id_corso;
	dataObj.id_referente = id_referente;
	dataObj.azione = azione

	  $.ajax({
	type: "POST",
	url: "gestioneFormazione.do?action=associa_dissocia_referente",
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


$('input:checkbox').on('ifToggled', function() {
	
	var id =$(this)[0].id;
			
	if(id.startsWith('check_referente')){
		
	
		id=id.split("_")[2];

		associaDissociaReferente(id, '${corso.id}');
	}
	
}) 
   
   
    $(document).ready(function() {
    

    	 dataString ="action=dettaglio_partecipanti_corso";
        exploreModal("gestioneFormazione.do",dataString,"#tab_partecipanti",function(datab,textStatusb){
        });
        
        modalArchivio('${corso.id}')
        
      var  table = $('#tabForCorso').DataTable({
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
	        pageLength: 50,
	        "order": [[ 1, "desc" ]],
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
		    	  { responsivePriority: 2, targets: 5 },
		    	   { targets: 0,  orderable: false }
		    	  
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
    });
    
    
    
    $('#modalAssociaReferenti').on('hidden.bs.modal', function(){  
    	
    	var dataObj = {};
    	dataObj.id_corso = '${corso.id}';


    	  $.ajax({
    	type: "POST",
    	url: "gestioneFormazione.do?action=referenti_corso",
    	data: dataObj,
    	dataType: "json",
    	//if received a response from the server
    	success: function( data, textStatus) {
    		pleaseWaitDiv.modal('hide');
    		  if(data.success){	  	
    			  
    			  html = '';
    			  
    			  var referenti = data.lista_referenti_corso;
    			  for (var i = 0; i < referenti.length; i++) {
					html = html +' <li class="list-group-item"> <div class="row">  <div class="col-xs-4"><b>'+referenti[i].nome +' '+ referenti[i].cognome+'</b> </div>  <div class="col-xs-4"> <b>'+referenti[i].nome_azienda+' - '+referenti[i].nome_sede+'</b> </div>  <div class="col-xs-4">  <a class="pull-right">'+referenti[i].email+'</a></div></div></li>'
				}
    			  
					$('#content_referenti').html(html)
    		    	$('#modalReferenti').modal();  
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
    	
    	
    
    	
    })
    
    
    function modificaCorsoModal(id_corso,id_categoria, docenti, data_inizio, data_scadenza, documento_test, descrizione, tipologia, commessa,e_learning, durata, efei, frequenza, giorni_preavviso){
	
	var json = JSON.parse(docenti);
	

	
	//$('#docente_mod option').attr("selected", false);
	$('#id_docenti_mod').val("")
	$('#id_docenti_dissocia').val("")
	$('#id_corso').val(id_corso);
	$('#categoria_mod').val(id_categoria);
	$('#categoria_mod').change();
	$('#frequenza_remind_mod').val(frequenza)
	$('#giorni_preavviso_mod').val(giorni_preavviso)
	var x = []
	
for (var i = 0; i < json.lista_docenti.length; i++) {
		
		//$('#docente_mod option[value="'+json.lista_docenti[i].id+'"]').attr("selected", true);
		x.push(json.lista_docenti[i].id);

		
		$('#id_docenti_mod').val($('#id_docenti_mod').val()+json.lista_docenti[i].id+";")
	}

	
	$('#docente_mod').val(x);	
$('#docente_mod').change();	
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
	$('#tipologia_mod').val(tipologia);
	$('#tipologia_mod').change();
	$('#durata_mod').val(durata);
	
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
	
	
	
	if(efei =='1'){	

		$('#check_efei_mod').iCheck('check');
		$('#efei_mod').val(1); 

	}else{
		$('#check_efei_mod').iCheck('uncheck');
		$('#efei_mod').val(0);

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


    $('#check_efei').on('ifClicked',function(e){
    	if($('#check_efei').is( ':checked' )){
    		$('#check_efei').iCheck('uncheck');
    		$('#efei').val(0); 
    	
    	}else{
    		$('#check_efei').iCheck('check');
    		$('#efei').val(1); 
    	
    	}
    });
    	 

    $('#check_efei_mod').on('ifClicked',function(e){
    	if($('#check_efei_mod').is( ':checked' )){
    		$('#check_efei_mod').iCheck('uncheck');
    		$('#efei_mod').val(0); 
    	
    	}else{
    		$('#check_efei_mod').iCheck('check');
    		$('#efei_mod').val(1); 

    	}
    });
    
    
    
    $('#myModalModificaCorso').on("hidden.bs.modal", function(){
    	$('#docente_mod option').attr("selected", false);
    });
    
    
    $('#modificaCorsoForm').on('submit', function(e){
   	 e.preventDefault();
   	 
   if($('#docente_mod').val()!=null && $('#docente_mod').val()!=''){
   		 
   		 var values = $('#docente_mod').val();
   		 var ids = "";
   		 for(var i = 0;i<values.length;i++){
   			 ids = ids + values[i]+";";
   		 }
   		 
   		 $('#id_docenti_mod').val(ids);
   	 }
   	 
   	 
   	 modificaForCorso();
   });
    
  </script>
  
</jsp:attribute> 
</t:layout>

