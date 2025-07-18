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
        Gestione Prenotazione Veicoli

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


              
            <div class="col-xs-3"> 
            <label>Anno</label>
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
             <a class="btn btn-primary" style="margin-top:25px" onclick="vaiAOggi('${currentYear}')">Vai a Oggi</a>
             </div>
             
             <div class="col-xs-6">
                           <!-- Zoom In -->

<!-- Reset -->
<a href="#" class="btn btn-primary zoom_reset pull-right">Reset Zoom</a>
<a href="#" class="btn btn-primary zoom_out pull-right" style="margin-right:5px">Zoom Out</a>
<a href="#" class="btn btn-primary zoom_in pull-right"  style="margin-right:5px">Zoom In</a>
             </div>
            </div><br>
            



<br><br>
               <div class="row">
				 <div class="col-xs-12">
				 <a class="btn btn-primary pull-left" onclick="subTrimestre('${start_date }', '${anno}')" ><i class="fa fa-arrow-left"></i></a>
				 
				 <a class="btn btn-primary pull-right" onclick="addTrimestre('${end_date }', '${anno}')" ><i class="fa fa-arrow-right"></i></a>
				 </div>
               
               
               
               </div>
            
            <br>
            <div class="row">
            <div class="col-xs-12">
          
            <jsp:include page="gestionePrenotazioneVeicoliTabella.jsp" ></jsp:include> 
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
       <div id="modalPrenotazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="title_prenotazione">Prenotazione Veicolo</h4>
      </div>
       <div class="modal-body"> 
             <div class="row">
        <div class="col-xs-9">
        <label>Utente</label>
          <select class="form-control select2" id="utente" name="utente" style="width:100%" data-placeholder="Seleziona Utente..." required>
       <option value=""></option>

       <c:forEach items="${lista_utenti }" var="utente">
       <option value="${utente.id }">${utente.nominativo }</option>
       </c:forEach>
       </select>
        </div>
		 <div class="col-xs-3">
		   <label>Manutenzione</label><br>
          <input class="form-control"  type="checkbox" id="manutenzione" name="manutenzione" style="width:100%">
		 
		 </div>
        </div><br>
        
        
            <div class="row" id="content_stato" style="display:none">
        <div class="col-xs-9">
        <label>Stato</label>
          <select class="form-control select2" id="stato" name="stato" style="width:100%" data-placeholder="Seleziona Stato..." >
       <option value=""></option>
     
       <option value="1">IN PRENOTAZIONE</option>
       <option value="2">PRENOTATO</option>
       <option value="3">RIENTRATO</option>

       </select>
        </div>
 		<div class="col-xs-3" id="rifornimento_content" style="display:none">
		   <label>Rif. effettuato</label><br>
          <input class="form-control"  type="checkbox" id="rifornimento" name="rifornimento" style="width:100%">
		 
		 </div>
        </div><br>
        
        <div class="row" >
        <div class="col-xs-5">
        <label>Data inizio prenotazione</label>

           <input id="data_inizio" name="data_inizio" class="form-control datepicker" type="text" style="width:100%" required>
        </div>
        
       
        
        		<div class='col-xs-4'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio' name='ora_inizio'  class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>
          <div id="content_giornaliero">
		             		<div class='col-xs-3' ><label>A/R giornaliero</label><br>
					<input type='checkbox' id='giornaliero' name='giornaliero' class='form-control' style='width:100%'>
					
					</div></div>
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
      <input type="hidden" id="id_veicolo" name="id_veicolo">
    <input type="hidden" id="check_giornaliero" name="check_giornaliero">
      
      <a class="btn btn-danger pull-left" onclick="$('#myModalYesOrNo').modal()"  id="btn_elimina" style="display:none">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

      </div>
    </div>
  </div>

</div>
</form>
	
	
	
	<form id="formNuovaSegnalazione" name="formNuovaSegnalazione" >
		  <div id="modalSegnalazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Aggiungi segalazione</h4>
      </div>
       <div class="modal-body">       

       
       <div class="row"> 
       <div class="col-xs-12">
       <label>Tipo segnalazione</label>
       <select class="form-control select2" id="tipo_segnalazione" name="tipo_segnalazione" multiple data-placeholder="Seleziona tipo segnalazione" style="width:100%" >
       <option value=""></option>
       <c:forEach items="${lista_tipi_segnalazione }" var="tipo">
       <option value="${tipo.id}">${tipo.descrizione }</option>
       </c:forEach>
       </select>
        
      </div> 
      </div> <br>
       <div class="row"> 
       <div class="col-xs-12">
       <label>Note</label>
       <textarea rows="3" style="width:100%" id="note_segnalazione" name="note_segnalazione"  class="form-control"></textarea>
       </div>
       </div>
	      </div>
      <div class="modal-footer">
      <input type="hidden" id="id_prenotazione_segnalazione" name="id_prenotazione_segnalazione">
      <input type="hidden" id="cella_segnalazione" name="cella_segnalazione">
      <input type="hidden" id="tipo_segnalazione_precedente" name="tipo_segnalazione_precedente" value="">
      <input type="hidden" id="tipo_segnalazione_str" name="tipo_segnalazione_str">
      <input type="hidden" id="tipo_segnalazione_da_rimuovere" name="tipo_segnalazione_da_rimuovere" value="">
      
      


   <button type="submit" class="btn btn-primary">Salva</button>
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


  </style>
</jsp:attribute>



<jsp:attribute name="extra_js_footer">



<script src="plugins/zoom-in-out-entire-page/jquery.page_zoom.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

	
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"></script> 

<script type="text/javascript">  

$('#tipo_segnazione').change(function(){

	var val = $(this).val();
	
	if(val == 4){
		$("note_segnalazione").attr("required", true);
	}else{
		$("note_segnalazione").attr("required", false);
	}
	
})


$('input:checkbox').on('ifToggled', function() {
	
	$('#manutenzione').on('ifChecked', function(event){
		
		$('#utente').attr("disabled", true);
	});
	
	$('#manutenzione').on('ifUnchecked', function(event) {
		
		$('#utente').attr("disabled", false);
	
	});
	

	
})


 $('#giornaliero').on('ifChecked', function(event){
		$('#check_giornaliero').val("SI");
		
	});

	$('#giornaliero').on('ifUnchecked', function(event) {
		
		$('#check_giornaliero').val("NO");

	});
 

function subTrimestre(data_inizio, anno){
	
	if(data_inizio==1){
		$('#anno').val(parseInt(anno)-1);
		$('#anno').change()
		data_inizio = 366	
	}
	
	callAction('gestioneParcoAuto.do?action=gestione_prenotazioni&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val());
}

function addTrimestre(data_fine, anno){
	
	if(data_fine>=365|| data_fine>=366){
		$('#anno').val(parseInt(anno)+1);
		$('#anno').change()
		data_fine = 1;
	}
	
	callAction('gestioneParcoAuto.do?action=gestione_prenotazioni&move=forward&data_inizio='+data_fine+'&anno='+$('#anno').val());
}

function vaiAOggi(anno){
	

	$('#anno').val(parseInt(anno));
	$('#anno').change()


callAction('gestioneParcoAuto.do?action=gestione_prenotazioni&anno='+$('#anno').val());


	
}

$('#anno').change(function(){
	var value = $('#anno').val();
	var commesse = $('#commesse').val();
	
	callAction('gestioneParcoAuto.do?action=gestione_prenotazioni&anno='+value,null,true)
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



$('#tipo').change(function(){
	
	var value = $('#tipo').val();
	
	if(value==3){
		$('#docente').prop('selectedIndex', -1);
		$('#docente').change();
		$('#id_docenti').val("");
		$('#docente').attr("disabled", true);
		//$('#docente').attr("required", false);
		$('#content_agenda').hide();
		$('#check_agenda').val("0");
		$('#n_utenti_content').show();
	}	
	else{
	
		$('#n_utenti_content').hide();
		$('#content_agenda').show();
		$('#docente').attr("disabled", false);
		//$('#docente').attr("required", true);
	}
	
});

$('#formNuovaPrenotazione').on("submit", function(e){
	e.preventDefault();
	nuovaPrenotazione();
})

/* $('#formNuovaSegnalazione').on("submit", function(e){
	e.preventDefault();
	
	   var selectedValues = $('#tipo_segnalazione').val(); // array dei valori selezionati
	    var tipoSegnalazioneStr = selectedValues ? selectedValues.join(';') : "";

	    // Inserisci la stringa in un campo nascosto o inviala via AJAX
	    $('#tipo_segnalazione_str').val(tipoSegnalazioneStr);
	
	callAjaxForm('#formNuovaSegnalazione', 'gestioneParcoAuto.do?action=nuova_segnalazione');
}) */

$('#formNuovaSegnalazione').on("submit", function(e){
	e.preventDefault();

	var selectedValues = $('#tipo_segnalazione').val() || [];
	var tipoSegnalazioneStr = selectedValues.join(';');

	// valori precedenti
	var valoriPrecedenti = $('#tipo_segnalazione_precedente').val().split(';').filter(e => e !== "");

	// calcola differenza: cosa è stato rimosso?
	var rimossi = valoriPrecedenti.filter(id => !selectedValues.includes(id));
	var rimossiStr = rimossi.join(';');

	// aggiorna i campi nascosti
	$('#tipo_segnalazione_str').val(tipoSegnalazioneStr);
	$('#tipo_segnalazione_da_rimuovere').val(rimossiStr);

	callAjaxForm('#formNuovaSegnalazione', 'gestioneParcoAuto.do?action=nuova_segnalazione');
});


$('#docente').on('change', function() {
	  
	var selected = $(this).val();
	var selected_before = $('#id_docenti').val().split(";");
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
		deselected = $('#id_docenti').val();
	}
	 
	
	$('#id_docenti_dissocia').val(deselected)
	
  });


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
	
		callAjaxForm('#formNuovaPrenotazione', 'gestioneParcoAuto.do?action=nuova_prenotazione', function(datab){
			
			
			$(document.body).css('padding-right', '0px');
			if(datab.success){
				location.reload()
				//fillTable("${anno}", "${filtro_tipo_pianificazioni}");
			//	controllaColoreCella(table, "#F7BEF6");
				
				$('#modalPrenotazione').modal("hide");
				
				 $('.modal-backdrop').hide();
			}else{
				$('#myModalErrorContent').html(data.messaggio);
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


$('input:checkbox').on('ifToggled', function() {
	
	$('#email').on('ifChecked', function(event){
		$('#check_mail').val(1);
	
	});
	
	$('#email').on('ifUnchecked', function(event) {
		
		$('#check_mail').val(0);
	
	});
	

	$('#agenda').on('ifChecked', function(event){
		$('#check_agenda').val(1);
	
	});
	
	$('#agenda').on('ifUnchecked', function(event) {
		
		$('#check_agenda').val(0);
	
	});
	
	$('#email_elimina').on('ifChecked', function(event){
		$('#check_email_eliminazione').val(1);
	
	});
	
	$('#email_elimina').on('ifUnchecked', function(event) {
		
		$('#check_email_eliminazione').val(0);
	
	});
	
	$('#pausa_pranzo').on('ifChecked', function(event){
		$('#check_pausa_pranzo').val("SI");
	
	});
	
	$('#pausa_pranzo').on('ifUnchecked', function(event) {
		
		$('#check_pausa_pranzo').val("NO");
	
	});
	
})


function eliminaPrenotazione(){
	
	dataObj = {};
	dataObj.id_prenotazione = $('#id_prenotazione').val();
	
	 	callAjax(dataObj, 'gestioneParcoAuto.do?action=elimina_prenotazione')

}

$('#stato').change(function(){
	
	if($('#stato').val()== 3){
		$('#rifornimento_content').show();
	}else{
		$('#rifornimento_content').hide();
		$('#rifornimento').iCheck("uncheck")
	}
	
	
});


var zoom_level;
$(document).ready(function($) { 


    $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
    
    $('.dropdown-toggle').dropdown();
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	
	$('#pleaseWaitDialog').css("z-index","9999");
	  pleaseWaitDiv.modal();
	
	$('.select2').select2()
	 $.page_zoom();
	
	
	 /* var t = $('#tabSegnalazioni').DataTable({
		  language: {
		    emptyTable: "Nessun dato presente nella tabella",
		    info: "Vista da _START_ a _END_ di _TOTAL_ elementi",
		    infoEmpty: "Vista da 0 a 0 di 0 elementi",
		    infoFiltered: "(filtrati da _MAX_ elementi totali)",
		    lengthMenu: "Visualizza _MENU_ elementi",
		    loadingRecords: "Caricamento...",
		    processing: "Elaborazione...",
		    search: "Cerca:",
		    zeroRecords: "La ricerca non ha portato alcun risultato.",
		    paginate: {
		      first: "Inizio",
		      previous: "Precedente",
		      next: "Successivo",
		      last: "Fine"
		    },
		    aria: {
		      sortAscending: ": attiva per ordinare la colonna in ordine crescente",
		      sortDescending: ": attiva per ordinare la colonna in ordine decrescente"
		    }
		  },
		  pageLength: 25,
		  order: [[1, "desc"]],
		  paging: false,
		  ordering: true,
		  info: false,
		  searchable: true,
			searching: false,
		  responsive: true,
		  scrollX: false,
		  stateSave: false,

		 

		  columns: [
		    { data: null }, // <- questo va così se non c'è "check" nel JSON
		    { data: "id" },
		    { data: "tipo" },
		    { data: "note" },

		    { data: "azioni" }
		  ],

		

		  buttons: [{
		    extend: 'colvis',
		    text: 'Nascondi Colonne'
		  }]
		}); */
	
	
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
function initContextMenu(){
	
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


function getSegnalazioni(id_prenotazione){
	
	dataObj = {}
	dataObj.id_prenotazione = id_prenotazione;
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=get_segnalazioni", function(data){
		
		
		if(data.success){
			
			var lista_segnalazioni = data.lista_segnalazioni;
			var table_data = [];
			let valoriCorrenti = $('#tipo_segnalazione').val() || [];
			
			for(var i = 0; i<lista_segnalazioni.length;i++){
				
			$('#note_segnalazione').val(lista_segnalazioni[i].note);

				// Aggiungi un nuovo valore (es. "2"), se non è già presente
				if (!valoriCorrenti.includes(lista_segnalazioni[i].tipo.id)) {
				  valoriCorrenti.push(lista_segnalazioni[i].tipo.id);
				}


	    }
			$('#tipo_segnalazione_precedente').val(valoriCorrenti);
			$('#tipo_segnalazione').val(valoriCorrenti).trigger('change');
			 

			
			$('#modalSegnalazione').modal();
		}
		
	}, "GET");
	
}

var orariDisabilitati = [];
  
  
	

$('#modalPrenotazione').on("hidden.bs.modal", function(){
	
	
	$('#utente').val("");
	$('#utente').change();
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


		
});


$('#myModalYesOrNo').on("hidden.bs.modal", function(){
	

	 $('#email_elimina').iCheck('uncheck');

	 
		
});

$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>