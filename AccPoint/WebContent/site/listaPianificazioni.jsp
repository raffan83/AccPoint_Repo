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
        Lista Pianificazioni
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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
        <div class="legend-label">FATTURATO CON ATTESTATI</div>
    </div>
</div>

</div></div><br>
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

<th style="min-width:250px">Azioni</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_pianificazioni }" var="pianificazione" varStatus="loop">
	<tr id="row_${loop.index}" >

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


 	<a class="btn btn-default customTooltip" title="NON CONFERMATO"  style="background-color:#DCDCDC;" onClick="cambiaStato('${pianificazione.id}', 1)"><i class="glyphicon glyphicon-refresh"></i></a> 
 	<a class="btn btn-default customTooltip" title="CONFERMATO"  style="background-color:#FFFFE0;" onClick="cambiaStato('${pianificazione.id}', 2)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="EROGATO"  style="background-color:#90EE90;" onClick="cambiaStato('${pianificazione.id}', 3)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="FATTURATO SENZA ATTESTATO"  style="background-color:#ADD8E6;" onClick="cambiaStato('${pianificazione.id}', 4)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="FATTURATO CON ATTESTATO"  style="background-color:#F7BEF6;" onClick="cambiaStato('${pianificazione.id}', 5)"><i class="glyphicon glyphicon-refresh"></i></a>

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
       	</div>		
     
       
     
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_corso" name="id_corso">
		<input type="hidden" id="e_learning_mod" name="e_learning_mod">
		<input type="hidden" id="id_docenti_mod" name="id_docenti_mod">
		<input type="hidden" id="id_docenti_dissocia" name="id_docenti_dissocia">
		
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
			
	
		  }
	
	});
	
}




function modificaCorsoModal(id_corso,id_categoria, docenti, data_inizio, data_scadenza, documento_test, descrizione, tipologia, commessa,e_learning, durata){
	
	var json = JSON.parse(docenti);
	

	
	//$('#docente_mod option').attr("selected", false);
	$('#id_docenti_mod').val("")
	$('#id_docenti_dissocia').val("")
	$('#id_corso').val(id_corso);
	$('#categoria_mod').val(id_categoria);
	$('#categoria_mod').change();
	
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
	
	$('#myModalModificaCorso').modal();
}


$('#myModalModificaCorso').on("hidden.bs.modal", function(){
	$('#docente_mod option').attr("selected", false);
});



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
 
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });


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
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
    		  
    		  if(admin=='1' && $(this).index()==1){
    			 // $(this).append( '<div><input  style="width:100%"  type="checkbox" id="checkall" name="checkall"/></div>');
    			  
    			 
    		  }else{
    			  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
    		  }
		    		
	    	//}

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




var admin = "";
$(document).ready(function() {
 
	//changeSkin();
	admin="${admin}";
	
	
	
	
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
		    	  { responsivePriority: 2, targets: 7 },
	
		    	  
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





 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

