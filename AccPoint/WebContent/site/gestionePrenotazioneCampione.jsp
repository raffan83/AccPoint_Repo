<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.Calendar" %>
<%

%>
	  <c:set var="currentYear" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" />
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper"    >
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Gestione Prenotazione Campioni

      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<!-- <div class="row">
        <div class="col-xs-12"> -->
          <div class="box">
<!--           <div class="box-header">
          
          </div> -->
            <div class="box-body">
              <div class="row">

<div class="col-xs-1">
 <a class="btn btn-primary pull-left btn-xs customTooltip" title="vai al trimestre precedente" style="margin-top:35px" onclick="subTrimestre('${start_date }', '${anno}')" ><i class="fa fa-arrow-left"></i></a> 
</div>
              
            <div class="col-xs-3"> 
            <label>Anno</label><br>
           
         <select class="form-control select2" id="anno" name="anno" style="width:100%" >

		
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
             <div class="col-xs-3">
             <a class="btn btn-primary" onclick="vaiAOggi('${currentYear}')" style="margin-top:25px" >Vai a Oggi</a>
             
             </div>
             
             <div class="col-xs-5">
                           <!-- Zoom In -->


<!-- Reset -->

<a class="btn btn-primary pull-right btn-xs customTooltip"  title="vai al trimestre successivo"style="margin-top:35px"  onclick="addTrimestre('${end_date }', '${anno}')" ><i class="fa fa-arrow-right"></i></a>
<a href="#" class="btn btn-primary zoom_reset pull-right  btn-xs">Reset Zoom</a>
<a href="#" class="btn btn-primary zoom_out pull-right  btn-xs" style="margin-right:5px">Zoom Out</a>
<a href="#" class="btn btn-primary zoom_in pull-right  btn-xs"  style="margin-right:5px">Zoom In</a>


             </div>
            </div><br>
            

<!--                <div class="row">
				 <div class="col-xs-12">
				 
				 
				 <
				 </div>
               
               
               
               </div>
            
            <br> -->
            <div class="row">
            <div class="col-xs-12">
          
            <jsp:include page="gestionePrenotazioneCampioneTabella.jsp" ></jsp:include> 
             <%--  <jsp:include page="gestionePrenotazioneiTabellaTest.jsp" ></jsp:include> --%>
             
            </div>
            
            </div>
            


</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
<!--         </div>
        /.col
 
</div> -->




  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

<form id="formNuovaPrenotazione" name="formNuovaPrenotazione" >

		<input type="hidden" id="id_utente" name="id_utente">
       
       <div id="modalPrenotazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="title_prenotazione">Prenotazione Campioni</h4>
      </div>
       <div class="modal-body"> 
             <div class="row">

        </div><br>
        
        <div class="row" >
        <div class="col-xs-5">
        <label>Data inizio prenotazione</label>

           <input id="data_inizio" name="data_inizio" class="form-control datepicker" type="text" style="width:100%" required>
        </div>
        
       
        
        		<div class='col-xs-4'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio' name='ora_inizio'  class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

        </div><br>
        
        
        <div class="row">
        <div class="col-xs-5">
        <label>Data fine prenotazione</label>
           <input id="data_fine" name="data_fine" class="form-control datepicker" type="text" style="width:100%" required>
        </div>


			<div class='col-xs-4'><label>Ora fine</label><div class='input-group'>
					<input type='text' id='ora_fine' name='ora_fine'   class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

        </div><br>
            
  		
				<div class="row" id="boxCampioniSelezione">
				  <div class="col-xs-6">
				    <label>Campioni disponibili</label>
				
				    <select class="form-control select2"
				            id="campioni"
				            name="campioni" 
				            multiple="multiple"
				            style="width:100%"
				            data-placeholder="Premi Controlla..."
				            required>
				      <%-- vuota all'inizio, la riempi via ajax --%>
				    </select>
				
				    <small class="text-muted">Seleziona uno o più campioni.</small>
				  </div>
				
				  <div class="col-xs-3">
				    <label>&nbsp;</label>
				    <button type="button" id="btnControllaCampioni" class="btn btn-primary btn-block">
				      Controlla
				    </button>
				  </div>
				  				  <div class="col-xs-3">
				    <label>&nbsp;</label>
				    <button type="button" id="btnResetCampioni" class="btn btn-primary btn-block">
				      Reset
				    </button>
				  </div>
				</div>
				<!-- BLOCCO: lista campioni prenotati (visibile solo in consultazione) -->
					<div class="row" id="boxCampioniPrenotati" style="display:none;">
  						<div class="col-xs-12">
   					 <label>Campioni prenotati</label>

    					<div id="listaCampioniPrenotati" class="well well-sm" style="margin-bottom:0;">
     				 <!-- riempito via JS -->
   						 </div>

   				 <small class="text-muted">Elenco campioni associati alla prenotazione.</small>
  </div>
</div>
    	<br>
    	
    	
		<div class="row">
       <div class="col-sm-12">  
       		<label>Luogo</label>
      
       	    
       	  	
        <input id="luogo" name="luogo" class="form-control"  style="width:100%" >
       			
       	</div>       	
       </div><br>
        
        <div class="row">
        <div class="col-xs-12">
        <label>Testo Note</label>
          <textarea rows="5" style="width:100%" id="note" name="note" class="form-control"></textarea>
        </div>
        </div><br>
       
      
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_prenotazione" name="id_prenotazione">
      <input type="hidden" id="day" name="day">
		
		 <button class="btn btn-primary" type="submit"  id="buttonSave">Salva</button>

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
       <div id="label_elimina_richiesta" style="display:none">Eliminare questa prenotazione annullerà la relativa richiesta.<br></div>
      	Sei sicuro di voler eliminare la pianificazione selezionata?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_prenotazione_id">


      <a class="btn btn-primary" onclick="eliminaPrenotazione()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.css">
<style>


.table th {
    background-color: #3c8dbc !important;
  }
  
.table th.weekend {
  background-color: #FA8989 !important;
}

.table th.festivita {
  background-color: #FA8989 !important;
}


/*  .tooltip {
    position: fixed;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 4px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  


} */


.custom-menu {
    display: none;
    z-index: 1000;
    position: absolute;
    overflow: hidden;
    white-space: nowrap;
    font-family: sans-serif;     
    border-radius: 5px;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 4px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    
}

.custom-menu li {
    padding: 8px 12px;
    cursor: pointer;
}

.custom-menu li:hover {
    background-color: #DEF;
}

/* aspetto da campo bloccato */
.locked-field {
  background-color: #f5f5f5 !important;
  cursor: not-allowed !important;
}

/* blocca click su addon / widget (orologio) ecc. */
.locked-group {
  pointer-events: none;   /* impedisce apertura picker */
  opacity: 0.85;
}


  </style>
</jsp:attribute>



<jsp:attribute name="extra_js_footer">



<script src="plugins/zoom-in-out-entire-page/jquery.page_zoom.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

	
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"></script> 

<script type="text/javascript">  

console.log("init script")

$(function () {
	  // init select2 dentro modale
	  $('#campioni').select2({
	    dropdownParent: $('#modalPrenotazione'),
	    width: '100%'
	  });
	  
	  // stato iniziale
	  lockDateTime(false);
	  resetCampioniSelect();

	
	  $('#modalPrenotazione').on('shown.bs.modal', function () {
		  resetCampioniSelect();
		//  lockDateTime(false);
		});

	  
	  $('#btnControllaCampioni').on('click', function (e) {
	    e.preventDefault();

	    resetCampioniSelect();

	   
	    if (!hasDateTimeFilled()) {
	      $("#myModalErrorContent").html("Compila data/ora di inizio e fine prima di controllare.");
	      $("#myModalError").addClass("modal modal-warning");
	      $("#myModalError").modal();
	      return;
	    }

	    callAjaxForm(
	    		  '#formNuovaPrenotazione',
	    		  'gestionePrenotazioneCampione.do?action=lista_campioni_disponibili',
	    		  function (datab) {

	    		    $(document.body).css('padding-right', '0px');

	    		    if (datab && datab.success) {

	    		      var $sel = $('#campioni');

	    		      // atteso: datab.campioni = [{id:..., codice:..., ...}, ...]
	    		      var lista = datab.campioni || [];

	    		      for (var i = 0; i < lista.length; i++) {
	    		        var c = lista[i];

	    		        // value = id, testo visibile = codice
	    		        // (fallback: se per caso l'id nel json si chiama __id o idCampione)
	    		        var idVal = c.id || c.__id || c.idCampione;
	    		        var label = c.codice; // SOLO codice

	    		        if (idVal != null && label) {
	    		          $sel.append(new Option(label, idVal, false, false));
	    		        }
	    		      }

	    		      $sel.trigger('change');
	    		      if (lista.length > 0) {
	    		    	  lockDateTime(true);   //  BLOCCA data/ora dopo controllo OK
	    		    	} else {
	    		    	  lockDateTime(false);  // opzionale, ma coerente
	    		    	}

	    		      if (lista.length === 0) {
	    		        $("#myModalErrorContent").html("Nessun campione disponibile nel periodo selezionato.");
	    		        $("#myModalError").removeClass().addClass("modal modal-warning").modal('show');
	    		      }

	    		    } else {
	    		      var msg = (datab && datab.messaggio) ? datab.messaggio : "Errore nel controllo disponibilità campioni.";
	    		      $('#myModalErrorContent').html(msg);
	    		      $('#myModalError').removeClass().addClass("modal modal-danger");
	    		      $('#report_button').show();
	    		      $('#visualizza_report').show();
	    		      $('#myModalError').modal('show');
	    		    }
	    		  }
	    		);
	  });
	  $('#btnResetCampioni').on('click', function (e) {
		    e.preventDefault();
		    resetCampioniSelect();
		    lockDateTime(false);
		  });

		});


function resetCampioniSelect() {
    var $sel = $('#campioni');
    $sel.empty();               // svuota opzioni
    $sel.val(null).trigger('change'); // reset selezione
  }

function lockDateTime(lock) {
	  var $fields = $('#data_inizio, #data_fine, #ora_inizio, #ora_fine');

	  // readonly = non modificabile MA inviato in submit
	  $fields.prop('readonly', lock)
	         .toggleClass('locked-field', lock);

	  // blocca click sugli addon e widget
	  $('#ora_inizio, #ora_fine').closest('.input-group').toggleClass('locked-group', lock);

	  // per i datepicker basta bloccare l'input (readonly). Se vuoi impedire anche click sull'area:
	  $('#data_inizio, #data_fine').closest('.col-xs-5').toggleClass('locked-group', lock);

	  // bottoni
	  $('#btnResetCampioni').prop('disabled', !lock);
	  $('#btnControllaCampioni').prop('disabled', lock);
	}



	function hasDateTimeFilled() {
	  return $('#data_inizio').val().trim() !== '' &&
	         $('#data_fine').val().trim()   !== '' &&
	         $('#ora_inizio').val().trim()  !== '' &&
	         $('#ora_fine').val().trim()    !== '';
	}



 
	function setModalMode(mode) {
		  // mode: 'new' oppure 'view'

		  if (mode === 'new') {
		    $('#boxCampioniSelezione').show();
		    $('#boxCampioniPrenotati').hide();
		    $('#buttonSave').show();

		    // select e bottoni
		    $('#btnControllaCampioni, #btnResetCampioni').show();

		    // in new vogliamo campioni vuoti finché non controlli
		    resetCampioniSelect();
		    lockDateTime(false);

		  } else if (mode === 'view') {
		    $('#boxCampioniSelezione').hide();
		    $('#boxCampioniPrenotati').show();
		    $('#buttonSave').hide();

		    // nascondo bottoni
		    $('#btnControllaCampioni, #btnResetCampioni').hide();

		    // in view io bloccherei data/ora (se vuoi consultazione pura)
		    // se invece vuoi permettere modifica date/ora, metti false
		    lockDateTime(true);
		  }
		}

		function renderCampioniPrenotati(listaCampioni) {
		  var $box = $('#listaCampioniPrenotati');
		  $box.empty();

		  if (!listaCampioni || listaCampioni.length === 0) {
		    $box.html("<em>Nessun campione associato.</em>");
		    return;
		  }

		  var html = "<ul style='margin:0; padding-left:18px;'>";
		  for (var i = 0; i < listaCampioni.length; i++) {
		    var c = listaCampioni[i];

		    // prova campi comuni: id/codice/descrizione/costruttore ecc.
		    var codice = c.codice ? c.codice : ("ID " + (c.id || ""));
		    var descr  = c.descrizione ? c.descrizione : "";
		    var costr  = c.costruttore ? (" - " + c.costruttore) : "";

		    html += "<li><strong>" + escapeHtml(codice) + "</strong>";
		    if (descr || costr) html += " — " + escapeHtml(descr + costr);
		    html += "</li>";
		  }
		  html += "</ul>";

		  $box.html(html);
		}

		// piccola utility per evitare problemi HTML
		function escapeHtml(str) {
		  if (str == null) return '';
		  return String(str)
		    .replace(/&/g, "&amp;")
		    .replace(/</g, "&lt;")
		    .replace(/>/g, "&gt;")
		    .replace(/"/g, "&quot;")
		    .replace(/'/g, "&#039;");
		}
		

function subTrimestre(data_inizio, anno){
	
	if(data_inizio==1){
		$('#anno').val(parseInt(anno)-1);
		$('#anno').change()
		data_inizio = 366	
	}
	
	callAction('gestionePrenotazioneCampione.do?action=gestione_prenotazioni&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val());
}

function addTrimestre(data_fine, anno){
	
	if(data_fine>=365|| data_fine>=366){
		$('#anno').val(parseInt(anno)+1);
		$('#anno').change()
		data_fine = 1;
	}
	
	callAction('gestionePrenotazioneCampione.do?action=gestione_prenotazioni&move=forward&data_inizio='+data_fine+'&anno='+$('#anno').val());
}

function vaiAOggi(anno){
	

	$('#anno').val(parseInt(anno));
	$('#anno').change()


callAction('gestionePrenotazioneCampione.do?action=gestione_prenotazioni&anno='+$('#anno').val());


	
}

$('#anno').change(function(){
	var value = $('#anno').val();
	var commesse = $('#commesse').val();
	
	callAction('gestionePrenotazioneCampione.do?action=gestione_prenotazioni&anno='+value,null,true)
});



$('#data_inizio').change(function(){
	
	  var data_fine_str = $('#data_fine').val();
	    var data_inizio_str = $('#data_inizio').val();

	    // Converti le stringhe in oggetti Date
	    var data_fine = toDate(data_fine_str);
	    var data_inizio = toDate(data_inizio_str);

	    // Verifica se entrambe le date sono valide
	    if(data_fine && data_inizio){
	        // Confronta le date solo se entrambe sono valide
	        if(data_fine.getTime() < data_inizio.getTime()){
	            // Se la data di fine è precedente alla data di inizio, imposta la data di fine uguale alla data di inizio
	            $('#data_fine').val(data_inizio_str);
	        }
	    }
});


$('#data_fine').change(function(){
	
	  var data_fine_str = $('#data_fine').val();
	    var data_inizio_str = $('#data_inizio').val();

	    // Converti le stringhe in oggetti Date
	    var data_fine = toDate(data_fine_str);
	    var data_inizio = toDate(data_inizio_str);

	    // Verifica se entrambe le date sono valide
	    if(data_fine && data_inizio){
	        // Confronta le date solo se entrambe sono valide
	        if(data_fine.getTime() < data_inizio.getTime()){
	            // Se la data di fine è precedente alla data di inizio, imposta la data di fine uguale alla data di inizio
	            $('#data_fine').val(data_inizio_str);
	        }
	    }
	
});


function toDate(dateStr) {
    var parts = dateStr.split("/");
    if (parts.length === 3) {
        var day = parseInt(parts[0], 10);
        var month = parseInt(parts[1], 10) - 1; // I mesi in JavaScript sono 0-based, quindi sottraiamo 1
        var year = parseInt(parts[2], 10);
        return new Date(year, month, day);
    }
    return null; // Se la stringa di data non è nel formato corretto, restituisci null
}


$('#formNuovaPrenotazione').on("submit", function(e){
	e.preventDefault();
	nuovaPrenotazione();
})

var isPaste = false;

function nuovaPrenotazione(){
	
	
	
	var inizio = moment($('#data_inizio').val()+" "+ $('#ora_inizio').val(), "DD/MM/YYYY HH:mm");
    var fine = moment($('#data_fine').val()+" "+ $('#ora_fine').val(), "DD/MM/YYYY HH:mm");


    var sovrapposizione = orariDisabilitati.some(function(prenotazione) {
    	console.log(prenotazione.id)
    	
    	if(($('#id_prenotazione').val()!="" && $('#id_prenotazione').val()!=prenotazione.id && prenotazione.id_veicolo == $('#id_veicolo').val())){
    		 var inizioPrenotazione = moment(prenotazione.inizio, "DD/MM/YYYY HH:mm");
    	        var finePrenotazione = moment(prenotazione.fine, "DD/MM/YYYY HH:mm");
    	        


    	      /*   return (inizio.isBetween(inizioPrenotazione, finePrenotazione, undefined, '[)') ||
    	                fine.isBetween(inizioPrenotazione, finePrenotazione, undefined, '(]') ||
    	                (inizioPrenotazione.isBetween(inizio, fine, undefined, '(]') &&
    	                 finePrenotazione.isBetween(inizio, fine, undefined, '[)'))); */
    	                 
    	        /* return (
    	                inizio.isBetween(inizioPrenotazione, finePrenotazione, undefined, '[)') ||
    	                fine.isBetween(inizioPrenotazione, finePrenotazione, undefined, '(]') ||
    	                (inizioPrenotazione.isBetween(inizio, fine) && finePrenotazione.isBetween(inizio, fine))
    	            ); */
    	                 
    	        return (
    	                (inizio.isBetween(inizioPrenotazione, finePrenotazione) || fine.isBetween(inizioPrenotazione, finePrenotazione)) ||
    	                (inizioPrenotazione.isBetween(inizio, fine) && finePrenotazione.isBetween(inizio, fine)) ||
    	                (inizio.isSameOrBefore(inizioPrenotazione) && fine.isSameOrAfter(finePrenotazione))
    	            );
    	}
       
    });
	

	if(sovrapposizione){
		
		$('#myModalErrorContent').html("Attenzione! Esiste già una prenotazione per l'orario selezionato!");
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-default");
		
		$('#myModalError').modal('show');
	
		
	}else if(fine<=inizio){
		
		$('#myModalErrorContent').html("Attenzione! Ora fine precedente o uguale ad ora inizio!");
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-default");
		
		$('#myModalError').modal('show');
		
	}else {
		if($('#id_prenotazione').val()==0){
			$('#id_prenotazione').val("")
		}
	
		callAjaxForm('#formNuovaPrenotazione', 'gestionePrenotazioneCampione.do?action=nuova_prenotazione', function(datab){
			
			
			$(document.body).css('padding-right', '0px');
			if(datab.success){
				location.reload()
				//fillTable("${anno}", "${filtro_tipo_pianificazioni}");
			//	controllaColoreCella(table, "#F7BEF6");
				
				$('#modalPrenotazione').modal("hide");
				
				 $('.modal-backdrop').hide();
			}else{
				$('#myModalErrorContent').html(datab.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");
				$('#report_button').show();
				$('#visualizza_report').show();
					$('#myModalError').modal('show');
			}
			isPaste = false;
		});
		$(document.body).css('padding-right', '0px');
	}
		
	
	
}



function eliminaPrenotazione(){
	
	dataObj = {};
	dataObj.id_prenotazione = $('#id_prenotazione').val();
	
	 	callAjax(dataObj, 'gestionePrenotazioneCampione.do?action=elimina_prenotazione')

}

var zoom_level;
$(document).ready(function($) { 


    $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
    
    $('.dropdown-toggle').dropdown();
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	
	$('#pleaseWaitDialog').css("z-index","9999");
	  pleaseWaitDiv.modal();
	
	 $.page_zoom();

	
	$.page_zoom({
		  selectors: {
		    zoom_in: '.zoom_in',
		    zoom_out: '.zoom_out',
		    zoom_reset: '.zoom_reset'
		  },
	onZoomIn: function() {
			    // Azioni da eseguire quando avviene lo zoom in
			    
			    zoom_level += 0.1;
			    console.log('Zoom in eseguito');
			    fillTable("${anno}",'${filtro_tipo_pianificazioni}');
			   
			  },
			  onZoomOut: function() {
			    // Azioni da eseguire quando avviene lo zoom out
			     zoom_level -= 0.1;
			    console.log('Zoom out eseguito');
			    fillTable("${anno}",'${filtro_tipo_pianificazioni}');
			   
			  },
			  onZoomReset: function() {
			    // Azioni da eseguire quando viene eseguito il ripristino dello zoom
			     zoom_level = 1;
			    console.log('Zoom ripristinato');
			    fillTable("${anno}",'${filtro_tipo_pianificazioni}');
			    
			  }
		});
	
	
	$.page_zoom({
		  max_zoom: 1.5,
		  min_zoom: .5,
		  current_zoom: 1,
		});
 
    $.page_zoom({
    	  zoom_increment: .1,
    	});
    
	

	      
	      
	      
		
		 $('#ora_inizio').val("");
		 $('#ora_fine').val("");
		 		
});


$('#tabPrenotazione tbody td').on('contextmenu', 'div',  function(e) {
	if($(this).hasClass("riquadro")){
	    selectedDiv = $(this);
	    e.preventDefault(); // Prevent default context menu
	}

	}); 

var cellIndex;
function initContextMenu(permesso){
	
	$("#tabPrenotazione tbody td").bind("contextmenu", function (event) {
		
	     
	     // Avoid the real one
	     event.preventDefault();

	     var cell = $("#"+event.currentTarget.id).offset();
	     cellIndex = event.currentTarget.id

	 	      var x  = cell.left -210;
	 	var y  = cell.top - 210; 
	     

	     // Show contextmenu
	     $(".custom-menu").finish().toggle(). 
	     css({
	         top: y + "px",
	         left: x + "px"
	     });
	     
	     
	     //alert("X:"+(x-240) +"Y:"+ (y-280))
	 });


	 // If the document is clicked somewhere
	 $(document).bind("mousedown", function (e) {
	     
	     // If the clicked element is not the menu
	     if (!$(e.target).parents(".custom-menu").length > 0) {
	         
	         // Hide it
	         $(".custom-menu").hide(100);
	     }
	 });


	 // If the menu element is clicked
	 $(".custom-menu li").click(function(e){
	     

		 
	     // This is the triggered action name
	     switch($(this).attr("data-action")) {
	         
	         // A case for each action. Your actions here
	         
	         
	        	 
	         
	     case 'copy':
             // Implement copy functionality
              if (selectedDiv) {
             	 
             	 cellCopy = selectedDiv[0].id.split("_")[1];
             	 
             var divData = selectedDiv.text();
             console.log('Copy:', divData);
         } else {
             console.log('No div selected to copy.');
         }
             break;
         case 'paste':
             
         	if(cellCopy!=null){
         		
         		pastePrenotazione(cellIndex.split("_")[1], cellIndex.split("_")[0])
         		
         	}
         	                	
            
             break;
         case 'delete':
             // Implement delete functionality
             if (selectedDiv) {
             	 cellCopy = selectedDiv[0].id.split("_")[1];
             	 
             	 $('#id_prenotazione').val(cellCopy)
             	 $('#myModalYesOrNo').modal()
          
         } else {
             console.log('No div selected to delete.');
         }
             break;
	     
	
	     
	     case 'segnalazione':
	    	 
	    	 if (selectedDiv) {
				var prenotazione = selectedDiv[0].id.split("_")[1];
	
				$('#id_prenotazione_segnalazione').val(prenotazione);
				//$('#cella_segnalazione').val(cella);
		
				getSegnalazioni(prenotazione);
			
				selectedDiv = null;
			}
			
			 break;
	     }
	     // Hide it AFTER the action was triggered
	     $(".custom-menu").hide(100);
	   }); 
	
}

var orariDisabilitati = [];
  
  

$('#modalPrenotazione').on("hidden.bs.modal", function(){
	
	
	$('#campioni').val(null).trigger('change');
	$('#campioni').empty().trigger('change');
	$('#btn_elimina').hide()
	$('#manutenzione').iCheck("uncheck")
	$('#rifornimento').iCheck("uncheck")
	
	$('#stato').val("");
	$('#stato').change();
	$('#content_stato').hide()
	$('#data_inizio').val("");
	$('#data_fine').val("");
	$('#ora_inizio').val("");
	$('#ora_fine').val("");
	$('#note').val("");
	$('#id_prenotazione').val("");
	$('#day').val("")

	lockDateTime(false);
	$('#btnControllaCampioni').prop('disabled', false);
	$('#btnResetCampioni').prop('disabled', true);
	
	setModalMode('new');
		
});


$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>