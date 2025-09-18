<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page import="java.util.Calendar" %>
<%

%>
	  <c:set var="currentYear" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" />
<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper"    >
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Gestione Pianificazione

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
            <label>Commesse</label>
         <select class="form-control select2" id="commesse" name="commesse" style="width:100%" >
			
						
			  <option value="0" ${commesse == 0  ? "selected" : ""}>APERTE</option>
			  <option value="1" ${commesse == 1  ? "selected" : ""}>CHIUSE</option>
			  <option value="2" ${commesse == 2  ? "selected" : ""}>TUTTE</option>
			
			</select>
             </div>
              
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
             
             <div class="col-xs-3">
                           <!-- Zoom In -->

<!-- Reset -->
<a href="#" class="btn btn-primary zoom_reset pull-right">Reset Zoom</a>
<a href="#" class="btn btn-primary zoom_out pull-right" style="margin-right:5px">Zoom Out</a>
<a href="#" class="btn btn-primary zoom_in pull-right"  style="margin-right:5px">Zoom In</a>
             </div>
            </div><br>
            
<div class="row">
<div class="col-xs-12">
<button class="btn btn-primary" ${filtro_tipo_pianificazioni == 0  ? "disabled" : ""} onclick='fillTable("${anno}",0)' id="btn_tutte">Tutte le classi</button>
<button class="btn btn-primary" ${filtro_tipo_pianificazioni == 3  ? "disabled" : ""} onclick='fillTable("${anno}",3)' id="btn_elearning">E-Learning</button>
<button class="btn btn-primary pull-right"  onclick='rimuoviFiltri()'>Rimuovi Filtri</button>
<!-- <button class="btn btn-primary"  onclick='filterTable()' id="">Filtra</button> -->

</div>
</div>



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
           <%--  <jsp:include page="gestionePianificazioneTabella.jsp" ></jsp:include> --%>
            <jsp:include page="gestionePianificazioneTabellaBimestre.jsp" ></jsp:include>
            
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
           <div class="col-xs-6 " style="margin-top:25px" id = "content_agenda">
        <label >Aggiungi evento ad agenda docente</label>
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
        <div class="col-xs-3"><label>Crea nuovo corso</label> <br>
          <input type='checkbox' id='nuovo_corso' name='nuovo_corso' class='form-control' style='width:100%'>
          </div>
          <div class="col-xs-3">
         <label>Corso esistente</label><br>
        <input type='checkbox' id='corso_esistente' name='corso_esistente' class='form-control' style='width:100%'>
        </div>
        <div class="col-xs-6">
         <label>Corsi esistenti</label> 
					<select id="id_corso_esistente" name="id_corso_esistente" disabled class='form-control select2' style="width:100%" data-placeholder="Seleziona corso esistente...">
					<option value=""></option>
					<c:forEach items="${lista_corsi }" var="corso">
					<option value="${corso.id }">${corso.descrizione }</option>
					</c:forEach>
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
      <input type="hidden" id="check_nuovo_corso" name="check_nuovo_corso">
      <input type="hidden" id="check_corso_esistente" name="check_corso_esistente">
      
      
      
      
      
      <a class="btn btn-danger pull-left" onclick="$('#myModalYesOrNo').modal()"  id="btn_elimina" style="display:none">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

      </div>
    </div>
  </div>

</div>
</form>
	

       <input type="hidden" id="cellCopy" name="cellCopy" value="${cellCopy }">

	
	  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare la pianificazione selezionata?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_partecipante_id">
      <input type="hidden" id="check_email_eliminazione">
      <div class="pull-left">
        <label>Invia Email Eliminazione</label>
          <input class="form-control "  type="checkbox" id="email_elimina" name="email_elimina" style="width:100%">
          
          </div>
      <a class="btn btn-primary" onclick="eliminaPianificazione()" >SI</a>
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


<script type="text/javascript">  




function subTrimestre(data_inizio, anno){
	
	if(data_inizio==1){
		$('#anno').val(parseInt(anno)-1);
		$('#anno').change()
		data_inizio = 366	
	}
	
	
	
	callAction('gestioneFormazione.do?action=gestione_pianificazione&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val()+'&cellCopy='+$('#cellCopy').val());
}

function addTrimestre(data_fine, anno){
	
	if(data_fine>=365|| data_fine>=366){
		$('#anno').val(parseInt(anno)+1);
		$('#anno').change()
		data_fine = 1;
	}
	
	callAction('gestioneFormazione.do?action=gestione_pianificazione&move=forward&data_inizio='+data_fine+'&anno='+$('#anno').val()+'&cellCopy='+$('#cellCopy').val());
}

function vaiAOggi(anno){
	

	$('#anno').val(parseInt(anno));
	$('#anno').change()


callAction('gestioneFormazione.do?action=gestione_pianificazione&anno='+$('#anno').val());


	
}

$('#anno').change(function(){
	var value = $('#anno').val();
	var commesse = $('#commesse').val();
	
	callAction('gestioneFormazione.do?action=gestione_pianificazione&anno='+value+"&commesse="+commesse,null,true)
});


$('#commesse').change(function(){
	var value = $('#anno').val();
	var commesse = $('#commesse').val();
	callAction('gestioneFormazione.do?action=gestione_pianificazione&anno='+value+"&commesse="+commesse,null,true)
});

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

$('#formNuovaPianificazione').on("submit", function(e){
	e.preventDefault();
	nuovaPianificazione();
})



function getListaFasi(ids){
		 dataObj = {};
		    dataObj.id_docenti = ids;

		    console.log("Invio richiesta AJAX...");
		    callAjax(dataObj, "gestioneFormazione.do?action=lista_fasi", function(data){
		        console.log("Risposta AJAX ricevuta", data);

		        // Controllo se ci sono ancora elementi prima di crearne di nuovi
		        if ($(".fasiClass").length > 0) {
		            console.warn("Esistono ancora select! Qualcosa non sta funzionando...");
		        }

		        var fasi = Object.entries(data.lista_fasi).map(([key, values]) => ({
		            key: key,
		            values: values
		        }));

		        var str = "";
		        for (var i = 0; i < fasi.length; i++) {
		            str += "<div class='row' id='content_select_fasi_"+fasi[i].key+"'><div class='col-xs-3'><label id='label_fase_"+fasi[i].key+"'></label></div><div class='col-xs-9'><select id='select_fasi_" + fasi[i].key + "' name='select_fasi_" + fasi[i].key + "' class='form-control select2 fasiClass' data-placeholder='Seleziona fase...' style='width:100%'></select></div></div><br>";
		        }

		        $('#content_fasi').append(str);

		        for (var i = 0; i < fasi.length; i++) {
		            var opt = [];
		            opt.push("<option value=''></option>");
		            for (var j = 0; j < fasi[i].values.length; j++) {
		                if (fasi[i].values[j].split(";;")[1] != "") {
		                    opt.push("<option value='" + fasi[i].values[j].split(";;")[0] + "' >Docenza - " + fasi[i].values[j].split(";;")[1] + "</option>");
		                } else {
		                    opt.push("<option value='" + fasi[i].values[j].split(";;")[0] + "' >Docenza</option>");
		                }
		            }

		            $('#select_fasi_' + fasi[i].key).html(opt);
		            $('#select_fasi_' + fasi[i].key).select2();
		            var docente = $("#docente option[value='" + fasi[i].key + "']").text();
		            $('#label_fase_'+fasi[i].key).text(docente);
		        }
		        
		    });
	}
	

let previousValues = [];
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
	
	
	
	if ($('#agenda').prop('checked')) {
		let currentValues = $(this).val() || [];		
	
		if(currentValues!=null){
			var lastAdded = currentValues.filter(value => !previousValues.includes(value)).pop();	
		}
		if(previousValues!=null && selected!=null){
			var lastRemoved = previousValues.filter(value => !selected.includes(value)).pop();	
		}
		
		
		if(lastAdded !=null ){
			getListaFasi(lastAdded);	
		}
		if(lastRemoved!=null){
			$('#content_select_fasi_'+lastRemoved).remove()
		}
		
	}
	if(selected!=null){
		previousValues = [...selected];	
	}
	
  });

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
			fillTable("${anno}", "${filtro_tipo_pianificazioni}", 1);
		//	controllaColoreCella(table, "#F7BEF6");
		
		
			if(datab.corso_aggiunto!=null){
				$("#id_corso_esistente").append('<option value="'+datab.corso_aggiunto.id+'">'+datab.corso_aggiunto.descrizione+'</option>');

			}
			
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
	

	$('#nuovo_corso').one('ifChecked', function(event){
		$('#check_nuovo_corso').val("1");
		$('#corso_esistente').iCheck("uncheck")
		$('#id_corso_esistente').val("");
		$('#id_corso_esistente').change();
	});
	
	$('#nuovo_corso').one('ifUnchecked', function(event){
		$('#check_nuovo_corso').val("0");		
	});
	
	
	$('#corso_esistente').one('ifChecked', function(event){
		$('#check_corso_esistente').val("1");
		$('#nuovo_corso').iCheck("uncheck")
		$('#id_corso_esistente').attr("disabled", false);
		$('#id_corso_esistente').attr("required", true);
	});
	
	$('#corso_esistente').one('ifUnchecked', function(event){
		$('#check_corso_esistente').val("0");		
		$('#id_corso_esistente').attr("disabled", true);
		$('#id_corso_esistente').attr("required", false);
	});
	
	
})




function eliminaPianificazione(){
	
	dataObj = {};
	dataObj.id_pianificazione = $('#id_pianificazione').val();
	dataObj.check_email_eliminazione = $('#check_email_eliminazione').val();
	
	 	callAjax(dataObj, 'gestioneFormazione.do?action=elimina_pianificazione')

}


$('#tabForPianificazione tbody td').on('contextmenu', 'div',  function(e) {
	if($(this).hasClass("riquadro")){
	    selectedDiv = $(this);
	    e.preventDefault(); // Prevent default context menu
	}

	}); 


var cellIndex;
function initContextMenu(){
	
	$("#tabForPianificazione tbody td").bind("contextmenu", function (event) {
		
	     
	     // Avoid the real one
	     event.preventDefault();

	     var cell = $("#"+event.currentTarget.id).offset();
	     cellIndex = event.currentTarget.id

	 	      var x  = cell.left -210;
	  
	 	var y  = cell.top - 330;
	     

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
             	 
             	$('#cellCopy').val(cellCopy);
             	 
             var divData = selectedDiv.text()
             console.log('Copy:', divData);
         } else {
             console.log('No div selected to copy.');
         }
             break;
         case 'paste':
             
         	if(cellCopy!=null || $('#cellCopy').val()!=null)  {   		
         		var cell_comm = cellIndex.replace("_"+cellIndex.split("_")[3], "")
         		
         		var comm = cell_comm.substring(0,cell_comm.length-2)+"/"+cell_comm.substring(cell_comm.length-2,cell_comm.length);
         		
         		pastePianificazione(cellIndex.split("_")[3], comm)
         		
         	} 
         	                	
            
             break;
         case 'delete':
             // Implement delete functionality
             if (selectedDiv) {
             	 cellCopy = selectedDiv[0].id.split("_")[1];
             	 
             	 $('#id_pianificazione').val(cellCopy)
             	 $('#myModalYesOrNo').modal()
          
         } else {
             console.log('No div selected to delete.');
         }
             break;
	     }
	   
	     // Hide it AFTER the action was triggered
	     $(".custom-menu").hide(100);
	   });




	  
	
}


$(document).ready(function($) { 

	pleaseWaitDiv = $('#pleaseWaitDialog');
	
	$('#pleaseWaitDialog').css("z-index","9999");
	  pleaseWaitDiv.modal();
	
	$('.select2').select2()
	 $.page_zoom();
	$.page_zoom({
		  selectors: {
		    zoom_in: '.zoom_in',
		    zoom_out: '.zoom_out',
		    zoom_reset: '.zoom_reset'
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
    
	

	 
	   $('.timepicker').timepicker({	    	
	     	 showMeridian:false,	   
	     	 minuteStep: 1
	      }); 
		
		 $('#ora_inizio').val("");
		 $('#ora_fine').val("");
		  
	   
});


$('#ora_inizio, #ora_fine').change(function() {
    var inizio = $('#ora_inizio').val();
    var fine = $('#ora_fine').val();
    

    if (moment(fine, "HH:mm") <  moment(inizio, "HH:mm")) {
      
    	$('#myModalErrorContent').html("L'ora di fine corso non può essere inferiore all'ora di inizio");

		$('#myModalError').addClass("modal modal-danger");
		$('#myModalError').modal()
		 $('#ora_fine').val(inizio)
    } 
  });


$('#modalPianificazione').on("hidden.bs.modal", function(){
	
	
	
	$('#docente').prop('selectedIndex', -1);
	$('#docente').change();	

	$('#stato').prop('selectedIndex', -1);
	$('#stato').change();	
	$('#tipo').prop('selectedIndex', -1);
	$('#tipo').change();	
	$('#nota').val("");
	$('#id_pianificazione').val("");
	$('#commessa').val("");
	$('#day').val("")
	$('#n_cella').val("")
	 $('#ora_inizio').val("");
	 $('#ora_fine').val("");
	 $('#n_utenti').val("");
	 $('#descrizione').val("");
	 $('#email').iCheck('uncheck');
	 $('#agenda').iCheck('uncheck');
	 $('#pausa_pranzo').iCheck('uncheck');
	 $('#label_email').hide();
	 $('#label_agenda').hide();
	 $('#content_fasi').hide()
	 $('#nuovo_corso').iCheck('uncheck');
	 $('#corso_esistente').iCheck('uncheck');
	 $('#id_corso_esistente').prop('selectedIndex', -1);
		$('#id_corso_esistente').change();	
});


$('#myModalYesOrNo').on("hidden.bs.modal", function(){
	

	 $('#email_elimina').iCheck('uncheck');

	 
		
});





$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>