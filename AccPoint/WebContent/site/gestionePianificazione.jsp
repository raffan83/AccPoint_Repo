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
              <div class="col-xs-3 "></div>
           <div class="col-xs-6 " style="margin-top:25px" id = "content_agenda">
        <label >Aggiungi evento ad agenda docente</label>
          <input class="form-control "   type="checkbox" id="agenda" name="agenda" style="width:100%">
      
       </div>
       <div class="col-xs-3 pull-right" style="margin-top:25px;display:none" id = "label_agenda" >
        <label class="pull-right" style="font-size: 70%"  > Evento aggiunto agenda docente</label>
       </div>
         </div><br>
        
		<div class="row">
		<div class='col-xs-4'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio' name='ora_inizio'  class='form-control timepicker' style='width:100%'><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

<div class='col-xs-4'><label>Ora fine</label><div class='input-group'>
					<input type='text' id='ora_fine' name='ora_fine'   class='form-control timepicker' style='width:100%'><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

		<div class='col-xs-3'><label>Pausa pranzo</label><br>
					<input type='checkbox' id='pausa_pranzo' name='pausa_pranzo' class='form-control' style='width:100%'></div>
		
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
      
      
      
      
      <a class="btn btn-danger pull-left" onclick="$('#myModalYesOrNo').modal()"  id="btn_elimina" style="display:none">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

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
	
	callAction('gestioneFormazione.do?action=gestione_pianificazione&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val());
}

function addTrimestre(data_fine, anno){
	
	if(data_fine>=365|| data_fine>=366){
		$('#anno').val(parseInt(anno)+1);
		$('#anno').change()
		data_fine = 1;
	}
	
	callAction('gestioneFormazione.do?action=gestione_pianificazione&move=forward&data_inizio='+data_fine+'&anno='+$('#anno').val());
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
			fillTable("${anno}", "${filtro_tipo_pianificazioni}");
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


function eliminaPianificazione(){
	
	dataObj = {};
	dataObj.id_pianificazione = $('#id_pianificazione').val();
	dataObj.check_email_eliminazione = $('#check_email_eliminazione').val();
	
	 	callAjax(dataObj, 'gestioneFormazione.do?action=elimina_pianificazione')

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
		
});


$('#myModalYesOrNo').on("hidden.bs.modal", function(){
	

	 $('#email_elimina').iCheck('uncheck');

	 
		
});

$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>