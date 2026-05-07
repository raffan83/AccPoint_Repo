<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ page import="java.util.Calendar" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
String[] nomiMesi = {
	    "GENNAIO", "FEBBRAIO", "MARZO", "APRILE", "MAGGIO", "GIUGNO",
	    "LUGLIO", "AGOSTO", "SETTEMBRE", "OTTOBRE", "NOVEMBRE", "DICEMBRE"
	};
    pageContext.setAttribute("nomiMesi", nomiMesi);
    

%>
  <c:set var="currentYear" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" />
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
        Lista attività
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
	Lista attività
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-2">
 <label class="control-label">Tipo Filtro:</label>
 <select class="form-control select2" style="width:100%" id="tipo_filtro" name="tipo_filtro">
 <c:if test="${tipo_filtro == null  || tipo_filtro == 'data'}">
<option value="data" selected>Data Attività</option>
</c:if>
<c:if test="${tipo_filtro != null  && tipo_filtro != 'data'}">
<option value="data" >Data Attività</option>
</c:if>
<c:if test="${tipo_filtro!=null && tipo_filtro == 'attrezzatura'  }">
<option value="attrezzatura" selected>Impianto</option>
</c:if>
<c:if test="${tipo_filtro!=null && tipo_filtro != 'attrezzatura'  }">
<option value="attrezzatura" >Impianto</option>
</c:if>

 </select>
 
</div>
<div class="col-xs-5" id="content_data"
     style="${tipo_filtro == 'attrezzatura' ? 'display:none' : ''}">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	<div class="col-xs-5" id="content_attrezzature"  style="${tipo_filtro == 'data' ? 'display:none' : ''}">
	<label for="datarange" class="control-label">Filtra Impianto:</label>
		<select class="form-control select2" data-placeholder="Seleziona Impianto..." id="attrezzatura" name="attrezzatura" style="width:100%" >
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzatura}" var="attrezzatura" varStatus="loop">
       
       				<option value="${attrezzatura.id}" ${attrezzatura.id == id_attrezzatura ? 'selected' : ''}>${attrezzatura.descrizione }</option>
       			</c:forEach>
       		</select>      
	<br><br>
	</div>
	
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('S1') }">
	<div class="col-xs-5">
<a class="btn btn-primary pull-right" onClick="modalCreaReport()" style="margin-top:25px"><i class="fa fa-plus"></i> Crea Report Annuale</a>
</div>
</c:if>
</div><br>



<div class="row">
<div class="col-sm-12">

 <table id="tabAttivitaEffettuate" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th >ID</th>
<th >Cliente</th>
<th >Sede</th>
<th>Impianto</th>
<th>Tipo</th>
<th>Data attività</th>
<th>Frequenza (mesi)</th>
<th>Data prossima Attività</th>
<th>Esito</th>
<th>Descrizione attività</th>
<th>Note</th>
<th>Utente </th>
<th>Eseguita da </th>
<th>Allegati</th>
<th>Azioni</th>
 </tr></thead>
 
 

 
 <tbody>
 
 	<c:forEach items="${lista_attivita }" var="attivita" varStatus="loop">
 	

	<tr id="row_${loop.index}" >

<td>${attivita.id }</td>
<td>${attivita.attrezzatura.nome_cliente }</td>
<td>${attivita.attrezzatura.nome_sede }</td>
<td>${attivita.attrezzatura.descrizione }</td>
<td><c:if test="${attivita.tipo == 0 }">ORDINARIA</c:if><c:if test="${attivita.tipo == 1 }">STRAORDINARIA</c:if></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${attivita.dataAttivita}" /></td>	
		<td>${attivita.frequenza }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${attivita.dataProssimaAttivita}" /></td>

<td><c:if test="${attivita.esito == 'P' }">POSITIVO</c:if><c:if test="${attivita.esito == 'N' }">NEGATIVO</c:if></td>

	<td>${attivita.attivita.descrizione }</td>
	<td>${attivita.note }</td>
	<td>${attivita.utente.nominativo }</td>
	<td>${attivita.eseguito_da }</td>
	<td><a class="btn btn-primary customTooltip" title="click per aprire gli allegati" onclick="modalAllegati('${attivita.id}')"><i class="fa fa-archive"></i></a></td>

	    
	<td>
	<a class="btn btn-warning customTooltip btnModificaAttivita"
	   title="click per Modificare"
	   data-id="${attivita.id}"
	   data-tipo="${attivita.tipo}"
	   data-data-attivita="<fmt:formatDate pattern='dd/MM/yyyy' value='${attivita.dataAttivita}' />"
	   data-frequenza="${attivita.frequenza}"
	   data-data-prossima-attivita="<fmt:formatDate pattern='dd/MM/yyyy' value='${attivita.dataProssimaAttivita}' />"
	   data-esito="${attivita.esito}"
	   data-descrizione="${attivita.attivita.id}"
	   data-note="${fn:escapeXml(attivita.note)}"
	   data-eseguito-da="${fn:escapeXml(attivita.eseguito_da)}">
		<i class="fa fa-edit"></i>
	</a>
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


<form id="reportForm" name="reportForm">
<div id="myModalCreaReport" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Crea Report Annuale </h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Impianto</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Impianto..." id="attrezzatura_report" name="attrezzatura_report" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzatura}" var="attrezzatura" varStatus="loop">
       				<option value="${attrezzatura.id}">${attrezzatura.descrizione } </option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
        <div class="row">
      	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
       	
       	      
         <select class="form-control select2" id="anno_report" name="anno_report" style="width:100%" required>

		
			  <c:set var="startYear" value="${currentYear - 5}" />
			  <c:set var="endYear" value="${currentYear + 5}" />
			
			  <c:forEach var="year" begin="${startYear}" end="${endYear}">
			  <c:if test="${year == anno }">
			  	    <option value="${year}" selected>${year}</option>
			  </c:if>
			   <c:if test="${year != anno }">
			  	    <option value="${year}" >${year}</option>
			  </c:if>
		
			  </c:forEach>
			</select>
       	

       	</div>
       </div><br>

        
       </div>

  		 
      <div class="modal-footer">

		 
		<button class="btn btn-primary" type="submit" >Salva</button> 
       
      </div>
    </div>
  </div>

</div>
</form>

<form id="modificaAttivitaForm">

  <div id="modalModificaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Attivita</h4>
      </div>
       <div class="modal-body">
       
        <div class="row">
    

        <label  class="col-sm-3 control-label">Tipo Attività:</label>
         <div class="col-sm-9">
       <select name="tipo_attivita_mod" id="tipo_attivita_mod" data-placeholder="Seleziona Attività..."   class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value="0">ORDINARIA</option>
             			<option value="1">STRAORDINARIA</option>       

       </select>
   
        </div>

  </div><br>
  
   <div class="row">
       	<div class="col-sm-3">
       		<label>Data attività:</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_attivita'>
               <input type='text' class="form-control input-small" id="data_attivita_mod" name="data_attivita_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       <br>

		<div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza:</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza_mod" name="frequenza_mod" style="width:100%" type="number" step="1" min="0" required>  
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Data prossima attività:</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_prossima_attivita'>
               <input type='text' class="form-control input-small" id="data_prossima_attivita_mod" name="data_prossima_attivita_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       <br>
       
            <div class="row">
    

        <label class="col-sm-3 control-label">Esito:</label>
         <div class="col-sm-9">
       <select name="esito_mod" id="esito_mod" data-placeholder="Seleziona Attività..."   class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value="N">NEGATIVO</option>
             			<option value="P">POSITIVO</option>       

       </select>
   
        </div>

  </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione:</label>
       	</div>
       	<div class="col-sm-9">
		<select class="form-control select2" data-placeholder="Seleziona Impianto..." id="descrizione_mod" name="descrizione_mod" style="width:100%" required>
       			<c:forEach items="${lista_attivitaSC}" var="att" varStatus="loop">
       				<option value="${att.id}">${att.descrizione } </option>
       			</c:forEach>
       		</select>      	
       	</div>
       </div><br>
       
         <div class="row">
       	<div class="col-sm-3">
       		<label>Note:</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="note_mod" name="note_mod" style="width:100%" >
       	</div>
       </div><br>
       
       
         
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Eseguito da:</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="eseguito_mod" name="eseguito_mod" style="width:100%" >
       	</div>
       </div><br>

  
  		 </div>
      <div class="modal-footer">
	<input type="hidden" id="id_attivita" name="id_attivita">
        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


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

<!--  <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br> -->

       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_documento_allegato" name="id_documento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
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
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_allegato_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoAttivita($('#id_allegato_elimina').val())" >SI</a>
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


  
  
  
  
  </style>


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">

function modificaAttivita(attivita) { 

	
	$('#id_attivita').val(attivita.id);
	$('#tipo_attivita_mod').val(attivita.tipo).trigger('change');
	$('#data_attivita_mod').val(attivita.dataAttivita);
	$('#frequenza_mod').val(attivita.frequenza);
	$('#data_prossima_attivita_mod').val(attivita.dataProssimaAttivita);

	$('#esito_mod').val(attivita.esito).trigger('change');
	$('#descrizione_mod').val(attivita.descrizione).trigger('change');
	$('#note_mod').val(attivita.note);
	$('#eseguito_mod').val(attivita.eseguito_da);

	$('#modalModificaAttivita').modal('show');
}

$('#modificaAttivitaForm').on("submit", function(e){

	e.preventDefault();
	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  
		  var form = $('#modificaAttivitaForm')[0]; 
		  var formData = new FormData(form);
		 
		  var attivita = $('#id_attivita').val();
	
  $.ajax({
	  type: "POST",
	  url: "amScGestioneScadenzario.do?action=modifica_attivita&id_attivita="+attivita,
	  data: formData,
	  contentType: false, // NEEDED, DON'T OMIT THIS (requires jQuery 1.6+)
	  processData: false, // NEEDED, DON'T OMIT THIS
	  success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  	      		  
		  if(data.success)
		  {
			$('#report_button').hide();
				$('#visualizza_report').hide();
				$("#modalModificaDocente").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
				
   			$('#myModalError').on('hidden.bs.modal', function(){	         			
 				
   				 location.reload()
  			});
		
		  }else{
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');	      			 
		  }
	  },

	  error: function(jqXHR, textStatus, errorThrown){
		  pleaseWaitDiv.modal('hide');

		  $('#myModalErrorContent').html("Errore nella modifica!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
				$('#myModalError').modal('show');
				

	  }
  });
	
	 
});

function modalAllegati(id){
	
	var dataObj = {};
	dataObj.id = id;
	
	callAjax(dataObj, "amScGestioneScadenzario.do?action=lista_allegati", function(data){
		
		if(data.success){
			
			var lista_allegati = data.lista_allegati;
			
				
				var html = '<ul class="list-group list-group-bordered">';
	    		if(lista_allegati.length>0){
	    			for(var i= 0; i<lista_allegati.length;i++){
	    			    
		       			 var nome =  '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nome_file+'</b></div><div class="col-xs-2 pull-right">'; 	           
			             var elimina  = '<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>';
			                
			    	           var download = '<a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="amScGestioneScadenzario.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>';
			    	           
			    	            if("${userObj.checkRuolo('S2')}" == "true"){
			    	            	elimina = ""
			    	            }
			    	           html=  html +nome + elimina +download+   '</div></div></li>';
	    			}
	    		}else{
	    			 html= html + '<li class="list-group-item"> Nessun file allegato all\'attività! </li>';
	    		}
	    		
	    		$("#tab_allegati").html(html+"</ul>");
	
			
			$('#myModalArchivio').modal();
			
		}
		
		
	});
	
	
}


function eliminaAllegatoModal(id_allegato){
	
	$('#id_allegato_elimina').val(id_allegato);
	
	$('#myModalYesOrNo').modal();
}






function filtraDate(){
	
	var tipo_data = $('#tipo_data').val();
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "?action=lista_attivita&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_filtro=data";
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	callAction("amScGestioneScadenzario.do"+ dataString, false,true);

}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("amScGestioneScadenzario.do?action=lista_attivita&tipo_filtro=data");

}

$('#attrezzatura').change(function(){
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	callAction("amScGestioneScadenzario.do?action=lista_attivita&tipo_filtro=attrezzatura&id_attrezzatura="+$(this).val());
});
 




var columsDatatables = [];

$("#tabAttivitaEffettuate").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAttivitaEffettuate thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAttivitaEffettuate thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function modalCreaReport(){
	$('#myModalCreaReport').modal();
}


	
function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


var array_color = [];

$(document).ready(function() {
 
	$('.customTooltip').tooltip();
	
	
	$(document).on('click', '.btnModificaAttivita', function(){

		var attivita = {
			id: $(this).attr('data-id'),
			tipo: $(this).attr('data-tipo'),
			dataAttivita: $(this).attr('data-data-attivita'),
			frequenza: $(this).attr('data-frequenza'),
			dataProssimaAttivita: $(this).attr('data-data-prossima-attivita'),
			esito: $(this).attr('data-esito'),
			descrizione: $(this).attr('data-descrizione'),
			note: $(this).attr('data-note'),
			eseguito_da: $(this).attr('data-eseguito-da')
		};

		modificaAttivita(attivita);
	});
	
	var array_buttons = [];
	
	

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();
     
     
     
     var start = "${dateFrom}";
  	var end = "${dateTo}";

  	$('input[name="datarange"]').daterangepicker({
 	    locale: {
 	      format: 'DD/MM/YYYY'
 	    
 	    }
 	}, 
 	function(start, end, label) {

 	});
  	
  	if(start!=null && start!=""){
 	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
 	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
 	
 	 }

     table = $('#tabAttivitaEffettuate').DataTable({
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
		    	  
		    	
		    	  { responsivePriority: 2, targets: 8},
		    	  { responsivePriority: 3, targets: 11 }
		    	  
		    	  
		    	  
		               ], 	        
	  	    
		               
		    });
     
     
     
		//if(${!userObj.checkRuolo('F2')}){
			table.buttons().container().appendTo( '#tabAttivitaEffettuate_wrapper .col-sm-6:eq(1)');	
		//}
		
		
		
		
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
		

	$('#tabAttivitaEffettuate').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});



 $('#myModalAllegati').on('hidden.bs.modal',function(){
 	
 	$(document.body).css('padding-right', '0px');
 });

  
  
  
  function eliminaAllegatoAttivita(id_allegato){
 	 
 	 var dataObj = {}
 	 dataObj.id_allegato = id_allegato;
 	 
 	 callAjax(dataObj, "amScGestioneScadenzario.do?action=elimina_allegato")
 	 
  }
  
 
$('#tipo_filtro').change(function(){

	var val = $(this).val();
	
	if(val=='data'){
		$('#content_data').show();
		$('#content_attrezzature').hide()
	}else{
		$('#content_attrezzature').show();
		$('#content_data').hide()
	}
	
})



$('#reportForm').on('submit', function(e){
	 e.preventDefault();
	 var newTab = window.open('', '_blank');
	 var id_attrezzatura = $('#attrezzatura_report').val();
	 
	 callAjaxForm("#reportForm", "amScGestioneScadenzario.do?action=crea_report", function(data){
		 
		
				if (data.success) {
					var url = "amScGestioneScadenzario.do?action=download_report&id_attrezzatura=" + $('#attrezzatura_report').val();

					newTab.location.href = url;
				} else {

					newTab.close();
				}
			 });
			 
			
		
	
});

 
  </script>
  
</jsp:attribute> 
</t:layout>

