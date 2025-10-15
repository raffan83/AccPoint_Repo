<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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
        Lista Pianificazioni
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
               <div class="box">
          <div class="box-header">
   	 <%-- <c:if test="${userObj.checkPermesso('CAMPIONI_COMPANY_METROLOGIA')}"> 	 
          <button class="btn btn-info" onclick="callAction('listaCampioni.do?p=mCMP');">I miei Campioni</button>
                  </c:if>
          <button class="btn btn-info" onclick="callAction('listaCampioni.do');">Tutti i Campioni</button> --%>
         
          </div>
            <div class="box-body">

     <div class="row">

	<div class="col-xs-5">
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
	


</div><br>
     
<div class="row">



      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	Lista Pianificazioni
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-sm-12">
<div class="legend">
    <div class="legend-item">
        <div class="legend-color" style="background-color:#DCDCDC;"></div>
        <div class="legend-label">NON CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #FFFFE0;"></div>
        <div class="legend-label">CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #90EE90;"></div>
        <div class="legend-label">EROGATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #ADD8E6;"></div>
        <div class="legend-label">FATTURATO SENZA ATTESTATI</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #F7BEF6;"></div>
        <div class="legend-label">COMPLETATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #fa9d58;"></div>
        <div class="legend-label">ATTESTATI SENZA FATTURA</div>
    </div>
</div>

<!-- <a class="btn btn-primary pull-right" onClick="modalPianificazione()"><i class="fa fa-plus"></i> Nuova Pianificazione</a> -->
</div>

</div><br>
<div class="row">
<div class="col-sm-12">

 <table id="tabForPianificazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th>ID</th>

<th>Commessa</th>
<th>Data</th>
<th>Stato</th>
<th>Descrizione</th>
<th>Tipo</th>
<th>Docenti</th>
<th>Computo ore</th>
<th>Fattura/Attestati</th>
<th>Ore fatturate</th>
<th>Corso</th>
<th style="min-width:250px">Azioni</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_pianificazioni }" var="pianificazione" varStatus="loop">
 	<c:if test="${pianificazione.attestati_presenti == null ||pianificazione.attestati_presenti == 1 }">
	<tr id="row_${pianificazione.id}" >

</c:if>
 	<c:if test="${pianificazione.id_corso!=null && pianificazione.attestati_presenti == 0 }">
	<tr id="row_${pianificazione.id}" style="background-color:#D8796F">

</c:if>
	<td>${pianificazione.id }</td>	
	
	<td>${pianificazione.id_commessa }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pianificazione.data}" /></td>
	<td id="${pianificazione.id }">${pianificazione.stato.descrizione }</td>
	<td>${pianificazione.descrizione }</td>
	

	<td>${pianificazione.tipo.descrizione }</td>


	<td>
	<c:forEach items="${pianificazione.getListaDocenti() }" var="docente">
	${docente.nome} ${docente.cognome }<br>
	</c:forEach>
	</td>
<td>
    <c:set var="oraInizio" value="${pianificazione.ora_inizio}" />
    <c:set var="oraFine" value="${pianificazione.ora_fine}" />
    <c:set var="pausa" value="${pianificazione.pausa_pranzo}" />

    <!-- Estrarre ore e minuti dall'orario di inizio e fine -->
    <c:set var="oreInizio" value="${oraInizio.split(':')[0]}"/>
    <c:set var="minutiInizio" value="${oraInizio.split(':')[1]}"/>
    <c:set var="oreFine" value="${oraFine.split(':')[0]}"/>
    <c:set var="minutiFine" value="${oraFine.split(':')[1]}"/>

    <!-- Convertire ore e minuti in numeri interi -->
    <fmt:parseNumber var="oreInizioInt" value="${oreInizio}" integerOnly="true"/>
    <fmt:parseNumber var="minutiInizioInt" value="${minutiInizio}" integerOnly="true"/>
    <fmt:parseNumber var="oreFineInt" value="${oreFine}" integerOnly="true"/>
    <fmt:parseNumber var="minutiFineInt" value="${minutiFine}" integerOnly="true"/>

    <!-- Calcolo totale minuti lavorati -->
    <c:set var="minutiInizioTotale" value="${(oreInizioInt * 60) + minutiInizioInt}"/>
    <c:set var="minutiFineTotale" value="${(oreFineInt * 60) + minutiFineInt}"/>
    <c:set var="totMinuti" value="${minutiFineTotale - minutiInizioTotale}"/>

    <!-- Sottrazione pausa pranzo se presente -->
         <c:if test="${pausa == 'SI'}">
        
        <c:choose>
            <c:when test="${not empty pianificazione.durata_pausa_pranzo}">
             
                <c:set var="totMinuti" value="${totMinuti - pianificazione.durata_pausa_pranzo}"/>
            </c:when>
            <c:otherwise>
             
                <c:set var="totMinuti" value="${totMinuti - 60}"/>
            </c:otherwise>
        </c:choose>
    </c:if>

     
     <%-- <fmt:formatNumber var="oreFinaliInt" value="${totMinuti div 60}" type="number" maxFractionDigits="0"/> --%>
<%--      <c:set var="oreFinaliInt" value="${fn:substringBefore(totMinuti / 60, '.')}"/>
      --%>
    <fmt:formatNumber var="oreDecimali" value="${totMinuti / 60.0}" type="number" maxFractionDigits="1" groupingUsed="false" pattern="#0.0"/>


     
<%--     <c:set var="minutiFinali" value="${totMinuti % 60}"/>
    <c:set var="totOre" value="${oreFinali}"/> --%>

	<c:if test="${pianificazione.tipo.id !=3 }">
	${oreDecimali.replace(',','.')}
</c:if>
     
</td>
<td id="check_${pianificazione.id }">
<c:if test="${pianificazione.stato.id == 4  || pianificazione.stato.id == 5}">
<input type="checkbox" disabled checked > <label>Fattura</label>
</c:if>

<c:if test="${pianificazione.stato.id == 5  || pianificazione.stato.id == 6}">
<br><input type="checkbox" disabled checked ><label>Attestato</label>
</c:if>
</td>
<c:if test="${pianificazione.ore_fatturate==0 }">
	<td>
	<input type="checkbox" id="checkPianificazione_${pianificazione.id }" name="checkPianificazione_${pianificazione.id }"  class="icheckbox">
	</td>
	</c:if>
	<c:if test="${pianificazione.ore_fatturate==1 }">
	<td>
	<input type="checkbox" id="checkPianificazione_${pianificazione.id }" name="checkPianificazione_${pianificazione.id }" checked   class="icheckbox">
	</td>
	</c:if>
	
	<td>
	<c:if test="${pianificazione.id_corso!=null }">
	<a class="btn customTooltip customlink" title="Vai al corso" onclick="callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso=${utl:encryptData(pianificazione.id_corso)}')">${pianificazione.id_corso }</a>
	</c:if>
	</td>
	
		<td>


 	<a class="btn btn-default customTooltip" title="NON CONFERMATO"  style="background-color:#DCDCDC;" onClick="cambiaStato('${pianificazione.id}', 1)"><i class="glyphicon glyphicon-refresh"></i></a> 
 	<a class="btn btn-default customTooltip" title="CONFERMATO"  style="background-color:#FFFFE0;" onClick="cambiaStato('${pianificazione.id}', 2)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="EROGATO"  style="background-color:#90EE90;" onClick="cambiaStato('${pianificazione.id}', 3)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="FATTURATO SENZA ATTESTATO"  style="background-color:#ADD8E6;" onClick="cambiaStato('${pianificazione.id}', 4)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="COMPLETATO"  style="background-color:#F7BEF6;" onClick="cambiaStato('${pianificazione.id}', 5)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="ATTESTATI SENZA FATTURA"  style="background-color:#fa9d58;" onClick="cambiaStato('${pianificazione.id}', 6)"><i class="glyphicon glyphicon-refresh"></i></a>

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

<form id="formNuovaPianificazione" name="formaNuovaPianificazione">
       <div id="modalPianificazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="title_pianificazione"></h4>
      </div>
       <div class="modal-body"> 
       
        <div class="row">
        <div class="col-xs-12">
        <label>Commessa</label>
          <select class="form-control select2" id="commessa" name="commessa" style="width:100%" data-placeholder="Seleziona Commessa..." required>
       <option value=""></option>
       <c:forEach items="${lista_commesse }" var="commessa">
      
       <option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
       </c:forEach>
       </select>
        </div>

        </div><br>
       
             <div class="row">
        <div class="col-xs-12">
        <label>Tipo</label>
          <select class="form-control select2" id="tipo" name="tipo" style="width:100%" data-placeholder="Seleziona Tipo Commessa..." required>
       <option value=""></option>
       <c:forEach items="${lista_tipi }" var="tipo">
   <option value="${tipo.id }">${tipo.descrizione }</option>
       </c:forEach>
       </select>
        </div>

        </div><br>
        
        <div class="row" >
        <div class="col-xs-12">
        <label>Descrizione</label>

         <textarea rows="4" style="width:100%" id="descrizione" name="descrizione" class="form-control" required></textarea>
        </div>

        </div><br>
        
        
        <div class="row" style="display:none" id="n_utenti_content">
        <div class="col-xs-12">
        <label>N. Utenti</label>
         <input type="number" min="0" step="1" id="n_utenti" name="n_utenti" class="form-control" >
        </div>

        </div><br>
            
       <div class="row">
       <div class="col-xs-12">
       <label>Docenti</label>
       <select class="form-control select2" id="docente" name="docente" style="width:100%" multiple  data-placeholder="Seleziona Docenti...">
       <option value=""></option>
       <c:forEach items="${lista_docenti }" var="docente">
       <option value="${docente.id }">${docente.nome } ${docente.cognome }</option>
       </c:forEach>
       </select>
       </div>
        </div><br>
          <div class="row">
        <div class="col-xs-6">
           <label>Stato</label>
          <select class="form-control select2" id="stato" name="stato" style="width:100%" data-placeholder="Seleziona Stato Pianificazione..." required>
       <option value=""></option>
       <c:forEach items="${lista_stati }" var="stato">
       <option value="${stato.id }">${stato.descrizione }</option>
       </c:forEach>
       </select>
        </div>
                <div class="col-xs-6" style="margin-top:25px">
        <label>Invia Email</label>
          <input class="form-control"  type="checkbox" id="email" name="email" style="width:100%">
               <label id="label_email" class="pull-right" style="font-size: 70%;display:none">Email inviata</label>
       </div>
 
        </div><br>
              <div class="row">
              <div class="col-xs-3 ">
              
              
              
              </div>
           <div class="col-xs-6 "  id = "content_agenda">
        <label >Aggiungi evento ad agenda Milestone</label>
          <input class="form-control "   type="checkbox" id="agenda" name="agenda" style="width:100%">
      
       </div>
       <div class="col-xs-3 pull-right" style="margin-top:25px;display:none" id = "label_agenda" >
        <label class="pull-right" style="font-size: 70%"  > Evento aggiunto agenda docente</label>
       </div>
         </div><br>
         <div class="row">
          <div class="col-xs-12 ">
                <div id="content_fasi" style="display:none">
              
              
      
              </div>
          </div>
         </div><br>
   <div class="row">
        <div class="col-xs-6">
        <label>Data</label>
          <div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data" name="data" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div>
</div>
        </div><br>
        
		<div class="row">
		<div class='col-xs-3'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio' name='ora_inizio'  class='form-control timepicker' style='width:100%'><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

<div class='col-xs-3'><label>Ora fine</label><div class='input-group'>
					<input type='text' id='ora_fine' name='ora_fine'   class='form-control timepicker' style='width:100%'><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

		<div class='col-xs-3' ><label>Pausa pranzo</label><br>
					<input type='checkbox' id='pausa_pranzo' name='pausa_pranzo' class='form-control' style='width:100%'>
					</div>
			<div class='col-xs-3'> 	
					 <label>Durata (min.)</label> 
					<select id="durata_pausa_pranzo" name="durata_pausa_pranzo" disabled class='form-control select2' data-placeholder="Durata pausa pranzo...">
					<option value=""></option>
					<option value="15">15</option>
					<option value="30">30</option>
					<option value="45">45</option>
					<option value="60">60</option>
					</select>
					</div>
		
		</div><br>
        
        <div class="row">
        <div class="col-xs-12">
        <label>Testo Note</label>
          <textarea rows="5" style="width:100%" id="nota" name="nota" class="form-control"></textarea>
        </div>
        </div><br>
       
      
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_pianificazione" name="id_pianificazione">
      <input type="hidden" id="day" name="day">
      <input type="hidden" id="commessa" name="commessa">
      <input type="hidden" id="id_docenti" name="id_docenti">
      <input type="hidden" id="id_docenti_dissocia" name="id_docenti_dissocia">
      <input type="hidden" id="check_mail" name="check_mail">
      <input type="hidden" id="check_agenda" name="check_agenda">
      <input type="hidden" id="check_pausa_pranzo" name="check_pausa_pranzo">
      <input type="hidden" id="anno_data" name="anno_data">
      <input type="hidden" id="is_lista" name="is_lista" value="1">
      
      
      
      <a class="btn btn-danger pull-left" onclick="$('#myModalYesOrNo').modal()"  id="btn_elimina" style="display:none">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

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
<style>


.table th {
    background-color: #3c8dbc !important;
  }
  
  
   .legend {
  display: flex;
}

.legend-item {
  display: flex;
  align-items: center;
  margin-right: 10px;
}

.legend-color {
  width: 20px;
  height: 20px;
}

.legend-label {
  margin-left: 5px;
}
  
  
  </style>




</jsp:attribute>

  
<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function cambiaStato(id_pianificazione, stato){
	
	$.ajax({
		  url: 'gestioneFormazione.do?action=cambia_stato_pianificazione&id='+id_pianificazione+"&stato="+stato, // Specifica l'URL della tua servlet
		  method: 'POST',
		  dataType: 'json',
		  success: function(response) {
		    // Recupera il JSONElement dalla risposta
		    
		    if(response.success){
		    	
		    	var pianificazione = response.pianificazione;
			    
			    var array = [];
			    var day = [];
			    var map = {};
			    
			
			    var t = document.getElementById("tabForPianificazione");
			    var rows = t.rows;
			   
			  //  for (var i = 0; i < lista_pianificazioni.length; i++) {
				  
				  table = $('#tabForPianificazione').DataTable();
			    	
					var cell = $("#"+id_pianificazione);
					cell.text(pianificazione.stato.descrizione);
					
					
				var cell_check= $('#check_'+id_pianificazione)
					
					var html = "";
					if(pianificazione.stato.id == 4 || pianificazione.stato.id == 5){
						html += '<input type="checkbox" class="iCheck" disabled checked > <label>Fattura</label>';
					}
					if(pianificazione.stato.id == 5 || pianificazione.stato.id ==6){
						html += '<br><input type="checkbox" class="iCheck" disabled checked ><label>Attestato</label>';
					}
					
					cell_check.html(html);
					
					$('.iCheck').iCheck({
					      checkboxClass: 'icheckbox_square-blue',
					      radioClass: 'iradio_square-blue',
					      increaseArea: '20%' // optional
					    }); 
					
					
					if(pianificazione.stato.id == 5 && pianificazione.attestati_presenti == 0){
						
						$('#row_'+id_pianificazione).css("background-color", "#D8796F")
					}else{
						$('#row_'+id_pianificazione).css("background-color", "")
					}
			  
		    	
		    }else{
		    	
		    	
		    	$('#myModalErrorContent').html(response.messaggio);
    		  	$('#myModalError').removeClass();
    			$('#myModalError').addClass("modal modal-danger");	  
    			$('#report_button').hide();
    			$('#visualizza_report').hide();
    			$('#myModalError').modal('show');			
		    }
		    
		    }
	
	});
	
}







var columsDatatables = [];

$("#tabForPianificazione").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForPianificazione thead th').each( function () {
    	
    	//$(this).css('background-color','#3c8dbc');  	
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForPianificazione thead th').eq( $(this).index() ).text();
    	
    	
    			  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
    	
    	} );
    
    

} );







	
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

	
	




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


function filtraDate(){
	
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
 	dataString = "action=lista_pianificazioni&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
 			endDatePicker.format('YYYY-MM-DD');
 	
 	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

 	callAction("gestioneFormazione.do?"+ dataString, false,true);

 	//exploreModal("gestioneFormazione.do", dataString, '#content_consuntivo');
}




function resetDate(){
pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
callAction("gestioneFormazione.do?action=lista_pianificazioni");

}


function modalPianificazione(data, commessa, id){
	
	
		//$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
		//$('#day').val(day);
		//$('#commessa').val(commessa);
		$('#btn_elimina').hide()
		$('#modalPianificazione').modal()
	

	
}


$('input:checkbox').on('ifToggled', function() {
	
	//var id =$(this)[0].id;
	
	var id ="#"+$(this)[0].id;
	

	if(id.startsWith("#checkPianificazione")){
		

	
	
 	
	
		$(id).on('ifChecked', function(event){
			  
			  
			 
			checkPianificazione(id.split("_")[1], 1)


		
	});
		
		
		$(id).on('ifUnchecked', function(event) {
			
			checkPianificazione(id.split("_")[1], 0)
			  
			
		});
	
		
		    	
		    	
					  
		
		
}
	
	});
	
	
	function checkPianificazione(id, value){
		
		 var dataObj = {};
		 	dataObj.id_pianificazione = id;
		 	dataObj.value = value;
	
		 $.ajax({
		    	type: "POST",
		    	url: "gestioneFormazione.do?action=ore_fatturate",
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
	


$(document).ready(function() {
 

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
     
     
     
     table = $('#tabForPianificazione').DataTable({
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
		    	  { responsivePriority: 2, targets: 11 },
	
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, {
	 				 extend: 'excel',
		  	            text: 'Esporta Excel'  
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabForPianificazione_wrapper .col-sm-6:eq(1)');
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
	
	
	

});


$('#formNuovaPianificazione').on("submit", function(e){
	e.preventDefault();
	nuovaPianificazione();
})



function nuovaPianificazione(){
	
	 var values = $('#docente').val();
	 var ids = "";
	 if(values!=null){
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
	 }


	 $('#id_docenti').val(ids);
	
	
	callAjaxForm('#formNuovaPianificazione', 'gestioneFormazione.do?action=nuova_pianificazione', function(datab){
		
		
		$(document.body).css('padding-right', '0px');
		if(datab.success){
			//fillTable("${anno}", "${filtro_tipo_pianificazioni}", 1);
		//	controllaColoreCella(table, "#F7BEF6");
			
			$('#modalPianificazione').modal("hide");
			
			 $('.modal-backdrop').hide();
		}else{
			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');
		}
		
	});
	$(document.body).css('padding-right', '0px');
}


$('input:checkbox').on('ifToggled', function() {
	
	$('#email').on('ifChecked', function(event){
		$('#check_mail').val(1);
	
	});
	
	$('#email').on('ifUnchecked', function(event) {
		
		$('#check_mail').val(0);
	
	});
	
	
	
	

	$('#agenda').off("ifChecked").on('ifChecked', function(event){
	    console.log("Check attivato");

	    $('#check_agenda').val(1);

	    // Distruggi select2 PRIMA di rimuovere gli elementi
	    $(".fasiClass").each(function() {
	        if ($.fn.select2) {
	            $(this).select2('destroy');
	        }
	    });

	    // Ora rimuovi completamente gli elementi
	    $(".fasiClass").remove();
	    $('#content_fasi').html("");

	    var values = $('#docente').val();
	    var ids = "";
	    if (values != null) {
	        for (var i = 0; i < values.length; i++) {
	            ids += values[i] + ";";
	        }
	    }

	   getListaFasi(ids);

	        $('#content_fasi').show();
	   
	});

	$('#agenda').off("ifUnchecked").on('ifUnchecked', function(event) {
	    console.log("Check disattivato");

	    $('#check_agenda').val(0);

	    // Distruggi select2 PRIMA di rimuovere gli elementi
	    $(".fasiClass").each(function() {
	        if ($.fn.select2) {
	            $(this).select2('destroy');
	        }
	    });

	    // Ora rimuovi completamente gli elementi
	    $(".fasiClass").remove();
	    $('#content_fasi').html("");
	    $('#content_fasi').hide();
	});

	
	$('#email_elimina').on('ifChecked', function(event){
		$('#check_email_eliminazione').val(1);
	
	});
	
	$('#email_elimina').on('ifUnchecked', function(event) {
		
		$('#check_email_eliminazione').val(0);
	
	});
	
	$('#pausa_pranzo').on('ifChecked', function(event){
		$('#check_pausa_pranzo').val("SI");
		$('#durata_pausa_pranzo').attr("disabled", false);
		$('#durata_pausa_pranzo').attr("required", true);
	});
	
	$('#pausa_pranzo').on('ifUnchecked', function(event) {
		
		$('#check_pausa_pranzo').val("NO");
		$('#durata_pausa_pranzo').val("")
		$('#durata_pausa_pranzo').change()
		$('#durata_pausa_pranzo').attr("disabled", true);
		$('#durata_pausa_pranzo').attr("required", false);
	});
	
})

 
 
  </script>
  
</jsp:attribute> 
</t:layout>

