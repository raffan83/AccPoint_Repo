<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Calendar" %>

<%
String[] nomiMesi = {
	    "GENNAIO", "FEBBRAIO", "MARZO", "APRILE", "MAGGIO", "GIUGNO",
	    "LUGLIO", "AGOSTO", "SETTEMBRE", "OTTOBRE", "NOVEMBRE", "DICEMBRE"
	};
    pageContext.setAttribute("nomiMesi", nomiMesi);
    

%>
  <c:set var="currentYear" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" />
<div class="row">
<div class="col-sm-9">
<c:if test="${userObj.checkRuolo('AM') || userObj.checkRuolo('S1') }">
<a class="btn btn-primary" onclick="modalNuovaAttrezzatura()"><i class="fa fa-plus"></i>Nuovo Impianto</a>
<a class="btn btn-primary" onClick="modalNuovaScadenza()"><i class="fa fa-plus"></i> Nuova Scadenza</a>
<a class="btn btn-primary" onClick="modalCreaReport()"><i class="fa fa-plus"></i> Crea Report Annuale</a>
</c:if>

</div>

            <div class="col-xs-3"> 
            <label>Anno</label>
         <select class="form-control select2" id="anno" name="anno" style="width:100%" onchange="cambiaAnno()">

		
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

<!-- 
       	<div class="col-sm-9">       	
       		<input class="form-control" data-placeholder="Seleziona Cliente..." id="test" name="test" style="width:100%" >
       		 <input id="test" style="width:100%;" placeholder="type a number, scroll for more results" /> 	
       	</div>  -->

<div class="row">
<div class="col-sm-12">
<div style="overflow-x: auto; width: 100%;">
 <table id="tabScadenzario" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  <thead>
    <tr class="active">
      <th></th>
      <th></th>
      <c:forEach items="${lista_attrezzature}" var="attrezzatura">
      <c:if test="${attrezzatura.tipo_attrezzatura.id!=0 }">
        <th  class="customTooltip" title="${attrezzatura.tipo_attrezzatura.descrizione}">${attrezzatura.descrizione}</th>
        </c:if>
              <c:if test="${attrezzatura.tipo_attrezzatura.id==0 }">
         <th>${attrezzatura.descrizione}</th>
         </c:if>
      </c:forEach>
    </tr>
  </thead>

  <tbody>
  <%--   <c:set var="anno" value="${anno }" /> --%>
    <c:forEach var="mese" begin="0" end="11" varStatus="status">
      <tr>
        <c:if test="${status.first}">
          <td rowspan="12" class="vertical-text" style="width:20px; max-width:20px; min-width:20px;">${anno}</td>
        </c:if>

        <!-- Nome del mese -->
        <td>${nomiMesi[status.index]}</td>

        <!-- Celle per ogni attrezzatura -->
        <c:forEach items="${lista_attrezzature}" var="attrezzatura">
          <td style="text-align:center;">
            <c:choose>
              <c:when test="${attrezzatura.mapScadenze[nomiMesi[status.index]] != null}">
                <a class="btn customTooltip customlink" target="_blank" href="amScGestioneScadenzario.do?action=lista_scadenze_mese&id_attrezzatura=${attrezzatura.id }&mese=${mese}&anno=${anno}">${attrezzatura.mapScadenze[nomiMesi[status.index]]}</a>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </c:forEach>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>




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
       			<c:forEach items="${lista_attrezzature}" var="attrezzatura" varStatus="loop">
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

<form id="nuovaScadenzaForm" name="nuovaScadenzaForm">
<div id="myModalNuovaScadenza" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività </h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Impianto</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Impianto..." id="attrezzatura" name="attrezzatura" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzature}" var="attrezzatura" varStatus="loop">
       				<option value="${attrezzatura.id}">${attrezzatura.descrizione } </option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
        <div class="row">
      	<div class="col-sm-3">
       		<label>Attività </label>
       	</div>
       	<div class="col-sm-9">
       	
       	<button type="button" class="btn btn-primary"id="btn_attivita" disabled onclick="modalAggiungiAttivita()"><i class="fa fa-plus"></i></button>
       	

       	</div>
       </div><br>

        
       </div>

  		 
      <div class="modal-footer">
    
		<input type="hidden" id="id_attivita" name="id_attivita" >


		 
		<button class="btn btn-primary" type="submit" >Salva</button> 
       
      </div>
    </div>
  </div>

</div>






<div id="myModalNuovaAttivita" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività </h4>
      </div>
       <div class="modal-body">

        <div class="row">
        <div class="col-xs-12">
        
         <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:100%">
  <thead>
    <tr class="active">
      <th></th>
      <th style="max-width:20px">ID</th>
      <th style="max-width:40px">Tipo Attività</th>
      <th style="min-width:80px">Data Attività </th>
      <th style="min-width:60px">Esito</th>
      <th style="max-width:60px">Frequenza</th>
      <th style="min-width:80px">Data Scadenza</th>
      <th style="max-width:120px">Note</th>
      <th style="min-width:120px">Descrizione attività </th>
      <th style="max-width:30px">Allegati</th>
      <th></th>
     
    </tr>
  </thead>

  <tbody>
  
<%--     <c:forEach items="${lista_attivita }" var="attivita" varStatus="status">
      <tr>
     
     <td></td>
        <td>${attivita.id }</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        
        <td>${attivita.descrizione }</td>
        <td ></td>
   <td></td>
      </tr>
    </c:forEach> --%>
  </tbody>
</table>
        <a class="btn btn-primary btn-xs pull-right" onclick="addRow()"><i class="fa fa-plus"></i> Aggiungi Attivit&agrave;</a>
       </div>
       </div>
        
        
       </div>

  		 
      <div class="modal-footer">

		 
		<a class="btn btn-primary" type="submit" onclick="assegnaIdAttivita()">Salva</a> 
       
      </div>
    </div>
  </div>

</div>

</form>









<form id="nuovaAttrezzaturaForm" name="nuovaAttrezzaturaForm">
<div id="myModalNuovaAttrezzatura" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Impianto </h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       <div class="col-xs-9">
       <input id="cliente_attrezzatura" name="cliente_attrezzatura" class="form-control" style="width:100%">
       
      </div>
      </div><br>
      <div class="row">
      <div class="col-sm-3">
       		<label>Sede</label>
       	</div>
      <div class="col-xs-9">
       <select id="sede_attrezzatura" name="sede_attrezzatura" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
      </div>
</div><br>

   <div class="row">
      <div class="col-sm-3">
       		<label>Tipo Impianto</label>
       	</div>
      <div class="col-xs-9">
       <select id="tipo_attrezzatura" name="tipo_attrezzatura" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" >
       <option value=""></option>
      	<c:forEach items="${lista_tipi}" var="tipo">
      	<option value="${tipo.id}">${tipo.descrizione} </option>
      	</c:forEach>
      
      </select>
      </div>
</div><br>

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione Impianto</label>
       	</div>
       	<div class="col-sm-9">       	
       		<input id="descrizione_attrezzatura" name="descrizione_attrezzatura" class="form-control">      	
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


  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      
      </div>
   
  </div>
  </div>
</div>


 <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 9900;">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati provvedimento legalizzazione bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

 

       <div id="tab_allegati_provvedimento"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_provvedimento_allegato" name="id_provvedimento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index: 9999;">
   
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
      <a class="btn btn-primary" onclick="eliminaAllegatoLegalizzazione($('#id_allegato_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalAssociaLegalizzazione" class="modal modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associazione Legalizzazione Bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
      <table id="table_legalizzazione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th style="max-width:15px"></th>
<th>ID</th>
<th>Descrizione Strumento</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Classe</th>
<th>Tipo approvazione</th>
<th>Tipo provvedimento</th>
<th>Numero provvedimento</th>
<th>Data provvedimento</th>
<th>Rev.</th>
<th>Azioni</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      
      <input type="hidden" id="id_strumento_legalizzazione" name="id_strumento_legalizzazione">
      <a class="btn btn-primary" onClick="associaStrumentoLegalizzazione(false)" id="button_salva">Salva</a>
      <a class="btn btn-primary" style="display:none" onClick="associaStrumentoLegalizzazione(true)" id="button_associa">Salva</a>
       <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalAssociaLegalizzazione').modal('hide')">Chiudi</a>
      </div>
   
  </div>
  </div>
</div>



 <style>
 input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}




.vertical-text {
  border-right: 1px solid #ddd !important;
  writing-mode: vertical-rl;
  transform: rotate(180deg);
  text-align: center;
  vertical-align: middle;
  padding: 5px;
  font-weight: bold;
  white-space: nowrap;
  font-size: 20px;
}
</style>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>



<script type="text/javascript">

function addRow(){
	var table = $('#tabAttivita').DataTable();
	//var id = table.rows()[0].length +1;
	//var id = getMaxIdAttivita(table) + 1;
	var id = parseInt(max_id) + 1;
	
	
	
/* 	var newRow = table.row.add([
        '<td class="select-checkbox"></td>',
        '<td >'+id+'</td>',
        '<td ><select required class="form-control select2" id="tipo_' + id + '" style="width:100%" onchange="valueProssima(' + id + ')"> <option value="0">ORDINARIA</option> <option value="1">STRAORDINARIA</option>  </select></td>',
        '<td ><div class="input-group date datepicker"><input type="text" required onchange="aggiornaDataScadenza(' + id + ')" class="datepicker  form-control" id="data_attivita_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div> </td>',
        '<td ><select required class="form-control select2" id="esito_' + id + '" style="width:100%"> <option value="P">POSITIVO</option> <option value="N">NEGATIVO</option>  </select></td>',
        '<td ><input type="number" step="1" min="0"  class="form-control" onchange="aggiornaDataScadenza(' + id + ')" id="frequenza_' + id + '"  /></td>',
        '<td ><div class="input-group date datepicker"><input type="text" readonly required class="form-control" id="data_scadenza_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div></td>',
        '<td ><textarea id="note_' + id + '" class="form-control" style="width:100%"/></textarea></td>',
        '<td ><textarea id="descrizione_attivita_' + id + '" class="form-control" style="width:100%"/></textarea></td>',
        '<td><span class="btn btn-primary btn-xs fileinput-button" title="click per caricare gli allegati"> <i class="fa fa-arrow-up"></i><input accept=".jpg,.png,.pdf" onchange="changeLabelAllegati('+id+')" id="allegati_attivita_'+id+'" name="allegati_attivita" type="file" multiple></span> <label id="filename_allegati_'+id+'"></label></td>',
         '<td><a class="btn btn-danger btn-xs remove-btn"><i class="fa fa-minus"></a></td>' 
    ]).draw(false); */
	
	table.row.add({
	    id: id,
	    tipo_attivita: '',
	    data_attivita: '',
	    esito: '',
	    frequenza: '',
	    data_scadenza: '',
	    note: '',
	    descrizione_attivita: ''
	}).draw(false).select();
    
    $('#descrizione_attivita_'+id).attr("readonly", false);
    
    $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
    
    $('#esito_' + id).select2();
    
    /* var addedRowNode = newRow.node(); 
    table.row(addedRowNode).select(); */
    
}

$('#tabAttivita  tbody').on('click', '.remove-btn', function() {
	var t = $('#tabAttivita').DataTable();
    t.row($(this).parents('tr')).remove().draw();
})


function getMaxIdAttivita() {
    var table = $('#tabAttivita').DataTable();
    var max = 0;

    table.rows().every(function () {
        var rowNode = this.node();
        var cellText = $('td:eq(1)', rowNode).text().trim(); // colonna 1

        var value = parseInt(cellText);
        if (!isNaN(value) && value > max) {
            max = value;
        }
    });

    return max;
}

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}






function modalNuovaScadenza(){
	

	$('#myModalNuovaScadenza').modal();
	
}

function modalCreaReport(){
	$('#myModalCreaReport').modal();
}

$('#attrezzatura').change(function(){
	
	$("#btn_attivita").attr("disabled", false);
	
	
})


var max_id;
function modalAggiungiAttivita(){
	
	
	dataObj={};
	dataObj.id_attrezzatura = $('#attrezzatura').val()
	
	callAjax(dataObj, "amScGestioneScadenzario.do?action=get_lista_attivita", function(data){
		
		if(data.success){
			
			var lista_attivita = data.lista_attivita
			max_id = data.max_id;
	     	
		  	 var table_data = [];
				  
		    if(lista_attivita!=null){
				  for(var i = 0; i<lista_attivita.length;i++){
					  var dati = {
							    id: lista_attivita[i].id,
							    tipo_attivita: '',
							    data_attivita: '',
							    esito: '',
							    frequenza: '',
							    data_scadenza: '',
							    note: '',
							    descrizione_attivita: lista_attivita[i].descrizione
							};

					  table_data.push(dati);
					
				  }
		
		    }
		    
			  var tabAttivita = $('#tabAttivita').DataTable();
			  
			  tabAttivita.clear().draw();
				   
			  tabAttivita.rows.add(table_data).draw();
					
			  tabAttivita.columns.adjust().draw();
			  
			  $('#myModalNuovaAttivita').modal();

		}
		
		
	}, "GET")
	

	

}

$("#cliente_attrezzatura").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_attrezzatura option').clone());
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
	 $("#sede_attrezzatura").prop("disabled", false);
	 
	  $('#sede_attrezzatura').html(opt);
	  


	});





var columsDatatables = [];


function modalNuovaAttrezzatura(){
	
	
	
	if($("#cliente").val() != 0 ){
		
		$('#cliente_attrezzatura').val($("#cliente").val())
		$('#cliente_attrezzatura').change()
		$('#sede_attrezzatura').val($("#sede").val())
		$('#sede_attrezzatura').change()
	}
	
	
	$('#myModalNuovaAttrezzatura').modal()
	
	$('#cliente_attrezzatura option[value="0"]').remove();
}

function modalAllegati(id){
	
	$('#myModalAllegati').modal()
	
	
}


$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
   
   $("#attrezzatura").select2()
    $("#attrezzatura_report").select2()
     $("#anno").select2()
      $("#anno_report").select2()

     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

	$('#sede_attrezzatura').select2();
	initSelect2('#cliente_attrezzatura', null, true);
     
	
    
   var table = $('#tabAttivita').DataTable({
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
	        order: [[1, "desc"]],
	        paging: false,
	        ordering: true,
	        info: true,
	        searchable: false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: true,
	 
	        select: {
	            style: 'multi+shift',
	            selector: 'td:nth-child(1)'
	        },
	        /* columns : [
	        	{
	        	    data: null,
	        	    defaultContent: '',
	        	    className: 'select-checkbox',
	        	    orderable: false
	        	  },
		    	{"data" : "id"},  
		    	{"data" : "tipo_attivita"},  
		    	{"data" : "data_attivita"},
		      	{"data" : "esito"},
		      	{"data" : "frequenza"},
		      	{"data" : "data_scadenza"},
		      	{"data" : "note"},
		      	{"data" : "descrizione_attivita"},
		      	{
		            data: null,
		            orderable: false,
		            render: function () {
		                return '';
		            }
		        },

		        // AZIONI (-)
		        {
		            data: null,
		            orderable: false,
		            render: function () {
		                return '<a class="btn btn-danger btn-xs remove-btn"><i class="fa fa-minus"></i></a>';
		            }
		        }
		       ],	 */
		       columns: [
		    	    // CHECKBOX
		    	    {
		    	        data: null,
		    	        className: 'select-checkbox',
		    	        orderable: false,
		    	        defaultContent: ''
		    	    },

		    	    // ID
		    	    { data: 'id' },

		    	    // TIPO ATTIVITÀ
		    	    {
		    	        data: 'tipo_attivita',
		    	        render: function (data, type, row) {
		    	            return '  <select  class="form-control select2" id="tipo_'+row.id+'" style="width:100%" name="tipo_'+row.id+'"  onchange="valueProssima('+row.id+')">     <option value="0">ORDINARIA</option>		    	                    <option value="1">STRAORDINARIA</option>		    	                </select>		    	            ';
		    	        }
		    	    },

		    	    // DATA ATTIVITÀ
		    	    {
		    	        data: 'data_attivita',
		    	        render: function (data, type, row) {
		    	            return '   <div class="input-group date datepicker">   <input type="text"   class="datepicker form-control"  name="data_attivita_'+row.id+'"     id="data_attivita_'+row.id+'"   onchange="aggiornaDataScadenza('+row.id+')"/> <span class="input-group-addon"> <span class="fa fa-calendar"></span> </span>  </div>';
		    	        }
		    	    },

		    	    // ESITO
		    	    {
		    	        data: 'esito',
		    	        render: function (data, type, row) {
		    	            return ' <select  class="form-control select2"  id="esito_'+row.id+'"  style="width:100%"  name="esito_'+row.id+'" > <option value="P">POSITIVO</option>  <option value="N">NEGATIVO</option>  </select> ';
		    	        }
		    	    },

		    	    // FREQUENZA
		    	    {
		    	        data: 'frequenza',
		    	        render: function (data, type, row) {
		    	            return ' <input type="number" min="0" step="1"    class="form-control" id="frequenza_'+row.id+'" name="frequenza_'+row.id+'"  onchange="aggiornaDataScadenza('+row.id+')"/>';
		    	        }
		    	    },

		    	    // DATA SCADENZA
		    	    {
		    	        data: 'data_scadenza',
		    	        render: function (data, type, row) {
		    	            return '  <div class="input-group date datepicker">   <input type="text" readonly       class="form-control"     id="data_scadenza_'+row.id+'"   name="data_scadenza_'+row.id+'"  />     <span class="input-group-addon">  <span class="fa fa-calendar"></span> </span>  </div>';
		    	        }
		    	    },

		    	    // NOTE
		    	    {
		    	        data: 'note',
		    	        render: function (data, type, row) {
		    	            return '   <textarea class="form-control" id="note_'+row.id+'" name="note_'+row.id+'"   style="width:100%"></textarea>';
		    	        }
		    	    },

		    	    // DESCRIZIONE
		    	    {
		    	        data: 'descrizione_attivita',
		    	       
		    	    render: function (data, type, row) {
		    	        return '<textarea class="form-control" ' +
		    	               'id="descrizione_attivita_'+row.id+'" ' +
		    	               'name="descrizione_attivita_'+row.id+'" ' +
		    	               'style="width:100%" rows="5" readonly>' +
		    	               (data ?? '') +
		    	               '</textarea>';
		    	    }

		    	    },

		    	    // ALLEGATI
		    	    {
		    	        data: null,
		    	        orderable: false,
		    	        render: function (data, type, row) {
		    	            return '<span class="btn btn-primary btn-xs fileinput-button" title="click per caricare gli allegati"><i class="fa fa-arrow-up"></i> <input accept=".jpg,.png,.pdf"onchange="changeLabelAllegati('+row.id+')"id="allegati_attivita_'+row.id+'" name="allegati_attivita_'+row.id+'" type="file" multiple> </span><label id="filename_allegati_'+row.id+'"></label>';
		    	        }
		    	    },

		    	    // AZIONI
		    	    {
		    	        data: null,
		    	        orderable: false,
		    	        render: function () {
		    	            return '<a class="btn btn-danger btn-xs remove-btn"><i class="fa fa-minus"></i></a>';
		    	        }
		    	    }
		    	],

	        columnDefs: [
	            { responsivePriority: 1, targets: 1 },
	            { className: "select-checkbox", targets: 0, orderable: false },
	            { targets: 1, width: "40px" },    // ID
	            { targets: 2, width: "120px" },   // Data Attività
	            { targets: 3, width: "80px" },   // Esito
	            { targets: 4, width: "60px" },    // Frequenza
	            { targets: 5, width: "120px" },   // Data Scadenza
	            { targets: 6, width: "150px" },   // Note
	            { targets: 7, width: "200px" } ,  
	            { targets: 8, width: "200px" } 
	        ]	     
			        
	  	    
		               
		    });
		
 		table.buttons().container().appendTo( '#tabScadenzario_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});  
	
	
	
});


$('#modificaVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaVerStrumento();
});



$('#nuovaScadenzaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm("#nuovaScadenzaForm", "amScGestioneScadenzario.do?action=nuova_scadenza", function(data){
		 
		 if(data.success){
			 
			 
			 $('#report_button').hide();
				$('#visualizza_report').hide();
			  $("#modalNuovoReferente").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
			 
			 $('#myModalError').on("hidden.bs.modal", function(){
				
				 if($(this).hasClass("modal-success")){
					 
					 

					  dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val();
					   exploreModal('amScGestioneScadenzario.do',dataString,'#posTab');
					   
					   $('.modal-backdrop').hide()
					 }				 
			 });
			 
		 }
		 
	 })
});


$('#nuovaAttrezzaturaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm("#nuovaAttrezzaturaForm", "amScGestioneScadenzario.do?action=nuova_attrezzatura", function(data){
		 
		 if(data.success){
			 $('#report_button').hide();
				$('#visualizza_report').hide();
			  $("#myModalNuovaAttrezzatura").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
			 
			 $('#myModalError').on("hidden.bs.modal", function(){
					
				 if($(this).hasClass("modal-success")){
					 
					 

					  dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val();
					   exploreModal('amScGestioneScadenzario.do',dataString,'#posTab');
					   
					   $('.modal-backdrop').hide()
					 }				 
			 });
			 
			
		 }
		
	 })
	
});




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


function cambiaAnno(){
	  dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val()+"&anno="+$('#anno').val();
	   exploreModal('amScGestioneScadenzario.do',dataString,'#posTab');
	   
}



function assegnaIdAttivita() {
    var id_attivita_selected = "";
    var t = $('#tabAttivita').DataTable();
    var tuttoValido = true;

    t.rows({ selected: true }).every(function () {
        var $row = $(this.node());
        var valori = "";
        var straordinaria = false;
        $row.find('td').each(function(i, cell) {
            let testo = "";
			
            if (i === 0 || i===2) return; // Salta checkbox

            if (i === 1) {
                // ID (solo testo, quindi ammesso anche vuoto)
                testo = $(cell).text().trim();
                var value = $('#tipo_'+testo).val();
                if(value==1){
                	straordinaria = true;
                }
            } 
   
            else if (i === 4) {
                // SELECT obbligatoria
                let select = $(cell).find("select");
                if (select.length) {
                    testo = select.val();
                    if (!testo) {
                        alert("Seleziona un valore nella colonna " + (i+1));
                        tuttoValido = false;
                        return false;
                    }
                }
            } 
            else if (i === 7) {
                // TEXTAREA facoltativa
                let textarea = $(cell).find("textarea");
                testo = textarea.length ? textarea.val() || "" : "";
            } 
            else if (i === 8) {
                // TEXTAREA obbligatoria solo se presente
                let textarea = $(cell).find("textarea");
                if (textarea.length) {
                    testo = textarea.val();
                    if (!testo || testo.trim() === "") {
                        alert("Compila il campo nella colonna DESCRIZIONE ATTIVITÀ");
                        tuttoValido = false;
                        return false;
                    }
                } else {
                    testo = "";
                }
            }
            else if (i === 9) {
           
            }
            

            else {
                // INPUT obbligatorio (es. datepicker)
                let input = $(cell).find("input");
                if (input.length) {
                    testo = input.val();
                    if (!testo || testo.trim() === "") {
                    	
                    	if(i == 3){
                    		var col = "DATA ATTIVITA'"
                    	}
                    	if(i == 5){
                    		var col = "FREQUENZA"
                    	}
                    	if(i == 6){
                    		var col = "DATA SCADENZA"
                    	}
                    	
                    	if(straordinaria == false || (straordinaria == true && (i!=5 && i!=6))){
                    		alert("Compila il campo nella colonna " +col);
                            tuttoValido = false;
                            return false;
                    	}
                        
                    }
                }
            }

            valori += testo + "~";
        });

        if (!tuttoValido) return false; // blocca ciclo .every se un campo non va

        id_attivita_selected += valori.slice(0, -1) + "§";
    });

    if (!tuttoValido) return;

 $('#id_attivita').val(id_attivita_selected)
    
    $('#myModalNuovaAttivita').modal("hide");
}


function changeLabelAllegati(id){
	
	  const files =  $("#allegati_attivita_"+id)[0].files;
	    let fileNames = [];
	  

	    for (let i = 0; i < files.length; i++) {
	        fileNames.push(files[i].name);
	    }


	
	$('#filename_allegati_'+id).html(fileNames.join('<br>'));
	
}


$('#tabAttivita').on('draw.dt', function () {
    $('.select2').select2({ width: '100%' });
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        autoclose: true
    });
});
$('#tabAttivita').on('select.dt', function (e, dt, type, indexes) {
    if (type === 'row') {
        indexes.forEach(function(index) {
            var row = dt.row(index).node();
            var id = "";

            $(row).find('td').each(function(i, cell) {
                const $cell = $(cell);

                // Leggi ID dalla cella 1 ma NON applicare bordi o altro
                if (i === 1) {
                    id = $cell.text().trim();
                }

                // Salta checkbox (0), ID (1) e ultima colonna (7) per stile/modifica
                if (i === 0 ||i === 1||   i===8 ||  i===10) return;

                // Salva bordo originale (per eventuale ripristino)
                if (!$cell.data('original-border')) {
                    $cell.data('original-border', $cell.css('border'));
                }

                // Applica bordo rosso
                $cell.css('border', '1px solid red');

                // Inserisci input/select/datepicker a seconda della colonna
                if (i === 5) {
                    const input = '<input type="number" step="1" min="0"  class="form-control" onchange="aggiornaDataScadenza(' + id + ')" id="frequenza_' + id + '"/>';
                    $cell.html(input);
                }
                else if (i === 4) {
                    const options = '<select required class="form-control select2" id="esito_' + id + '" style="width:100%"> <option value="P">POSITIVO</option> <option value="N">NEGATIVO</option>  </select>';
                    $cell.html(options);
                    $('#esito_' + id).select2();
                }
                else if (i === 2) {
                    const options = '<select required class="form-control select2" id="tipo_' + id + '" style="width:100%" onchange="valueProssima(' + id + ')"> <option value="0">ORDINARIA</option> <option value="1">STRAORDINARIA</option>  </select>';
                    $cell.html(options);
                    $('#tipo_' + id).select2();
                }
                else if (i === 3) {
                    const input = $('<div class="input-group date datepicker"><input type="text" required onchange="aggiornaDataScadenza(' + id + ')" class="datepicker  form-control" id="data_attivita_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>');
                    $cell.html(input);
                    $('.datepicker').datepicker({
                        format: "dd/mm/yyyy"
                    });
                }
                else if (i === 6) {
                    const input = $('<div class="input-group date datepicker"><input type="text" readonly required class="form-control" id="data_scadenza_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>');
                    $cell.html(input);
                }
                else if (i === 7) {
                    const input = $('<textarea id="note_' + id + '" class="form-control" style="width:100%"/></textarea>');
                    $cell.html(input);
                }
                else if(i=== 9){
                	
                	const input = $('<span class="btn btn-primary btn-xs fileinput-button" title="click per caricare gli allegati"> <i class="fa fa-arrow-up"></i><input accept=".jpg,.png,.pdf" onchange="changeLabelAllegati('+id+')" id="allegati_attivita_'+id+'" name="allegati_attivita_'+id+'" type="file" multiple></span> <label id="filename_allegati_'+id+'"></label>')

                	 $cell.html(input);
                	
                }
            });
        });
    }
});


// Deselect row
$('#tabAttivita').on('deselect.dt', function (e, dt, type, indexes) {
    if (type === 'row') {
        indexes.forEach(function(index) {
            var row = dt.row(index).node();
            $(row).find('td').each(function(i, cell) {
                const $cell = $(cell);
                if (i === 0 || i === 1 || i === 7) return;

                const originalBorder = $cell.data('original-border');
                if (originalBorder !== undefined) {
                    $cell.css('border', originalBorder);
                    $cell.removeData('original-border');
                }

                $cell.text('');
            });
        });
    }
});

function aggiornaDataScadenza(id) {
	
	if($('#tipo_'+id).val() =="0" ){
		 var frequenza = parseInt($('#frequenza_' + id).val());
		    var data_attivita_str = $('#data_attivita_' + id).val(); // es: "20/11/1991"

		    if (!data_attivita_str || isNaN(frequenza)) {
		        console.warn("Data attivita o frequenza non valida per id:", id);
		        return;
		    }

		    // Converte "DD/MM/YYYY" in oggetto Date
		    var [giorno, mese, anno] = data_attivita_str.split('/').map(Number);
		    var data_attivita = new Date(anno, mese - 1, giorno); // mese parte da 0

		    // Calcola la nuova data aggiungendo i mesi
		    var nuovaData = new Date(data_attivita);
		    nuovaData.setMonth(nuovaData.getMonth() + frequenza);

		    // Corregge l'eventuale overflow di giorni (es. 31 gennaio + 1 mese â†’ 3 marzo)
		    if (nuovaData.getDate() !== giorno) {
		        nuovaData.setDate(0); // imposta all'ultimo giorno del mese precedente
		    }

		    // Formatta in "DD/MM/YYYY"
		    var giornoN = String(nuovaData.getDate()).padStart(2, '0');
		    var meseN = String(nuovaData.getMonth() + 1).padStart(2, '0');
		    var annoN = nuovaData.getFullYear();

		    var dataFormattata = giornoN+"/"+meseN+"/"+annoN;

		    // Aggiorna il campo data_scadenza
		    $('#data_scadenza_' + id).val(dataFormattata);
	}
	
	
   
}


function valueProssima(id){
	
	if($('#tipo_'+id).val() =="1" ){
		 $('#data_scadenza_' + id).val("");
	}
	
}

</script>