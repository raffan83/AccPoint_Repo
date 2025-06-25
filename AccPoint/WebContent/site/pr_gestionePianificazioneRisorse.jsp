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
        Gestione Pianificazione Risorse

      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">


          <div class="box">

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
          
            <jsp:include page="pr_gestionePianificazioneRisorseTabella.jsp" ></jsp:include> 
 
             
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

<form id="formNuovaAssociazione" name="formNuovaAssociazione" >
       <div id="modalAssociazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="title_pianificazione">Associa Intervento</h4>
      </div>
       <div class="modal-body"> 
             <div class="row">
        <div class="col-xs-12">
        <table id="tabInterventi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
        <thead>
        <tr>
      	<th></th>
        <th>ID</th>
        <th>Commessa</th>
        <th>Presso</th>
        <th>Cliente</th>
        <th style="min-width:100px">Sede</th>
        <th>Responsabile</th>
        <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        
        </tbody>
        
        </table>

        </div>
	
      	</div>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_intervento" name="id_intervento">
      <input type="hidden" id="id_risorsa" name="id_risorsa">
      <input type="hidden" id="cella" name="cella">
      <input type="hidden" id="data_pianificazione" name="data_pianificazione">
      <input type="hidden" id="calendario" name=calendario>
      
      <a class="btn btn-danger pull-left" onclick="$('#myModalYesOrNo').modal()"  id="btn_elimina" style="display:none">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

      </div>
    </div>
  </div>

</div>
</form>


 <div id="modalRequisiti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Requisiti Intervento</h4>
      </div>
       <div class="modal-body">      
       <div class="row">
       <div class="col-xs-12">
       <label>REQUISITI DOCUMENTALI</label>
       <div id="content_requisiti_doc"></div>
       
       </div>
       
       </div> 
       
        <div class="row">
       <div class="col-xs-12">
       <label>REQUISITI SANITARI</label>
       <div id="content_requisiti_san"></div>
       
       </div>
       
       </div> 
   
      	</div>
      <div class="modal-footer">
  

		<a class="btn btn-primary" onclick="$('#modalRequisiti').modal('hide')" >Chiudi</a>
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
		<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />
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




  </style>
</jsp:attribute>



<jsp:attribute name="extra_js_footer">



<script src="plugins/zoom-in-out-entire-page/jquery.page_zoom.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"></script> 

<script type="text/javascript">  


 

function subTrimestre(data_inizio, anno){
	
	if(data_inizio==1){
		$('#anno').val(parseInt(anno)-1);
		$('#anno').change()
		data_inizio = 366	
	}
	
	callAction('gestioneRisorse.do?action=gestione_prenotazioni&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val());
}

function addTrimestre(data_fine, anno){
	
	if(data_fine>=365|| data_fine>=366){
		$('#anno').val(parseInt(anno)+1);
		$('#anno').change()
		data_fine = 1;
	}
	
	callAction('gestioneRisorse.do?action=pianificazione_risorse&move=forward&data_inizio='+data_fine+'&anno='+$('#anno').val());
}

function vaiAOggi(anno){
	

	$('#anno').val(parseInt(anno));
	$('#anno').change()


callAction('gestioneParcoAuto.do?action=pianificazione_risorse&anno='+$('#anno').val());


	
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





/* 


function nuovaPrenotazione(){
	
	
	var inizio = moment($('#data_inizio').val()+" "+ $('#ora_inizio').val(), "DD/MM/YYYY HH:mm");
    var fine = moment($('#data_fine').val()+" "+ $('#ora_fine').val(), "DD/MM/YYYY HH:mm");


    var sovrapposizione = orariDisabilitati.some(function(prenotazione) {
    	console.log(prenotazione.id)
    	
    	if(($('#id_prenotazione').val()!="" && $('#id_prenotazione').val()!=prenotazione.id && prenotazione.id_veicolo == $('#id_veicolo').val())){
    		 var inizioPrenotazione = moment(prenotazione.inizio, "DD/MM/YYYY HH:mm");
    	        var finePrenotazione = moment(prenotazione.fine, "DD/MM/YYYY HH:mm");
    	        



    	                 
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
	
				
				$('#modalAssociaIntervento').modal("hide");
				
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
		
	
	
} */

/* 
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

 */
function eliminaPrenotazione(){
	
	dataObj = {};
	dataObj.id_prenotazione = $('#id_prenotazione').val();
	
	 	callAjax(dataObj, 'gestioneParcoAuto.do?action=elimina_prenotazione')

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
	
	$('.select2').select2()
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
		 
		 
		 
		 
		 var table = $('#tabInterventi').DataTable({
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
			  paging: true,
			  ordering: true,
			  info: true,
			  searchable: true,

			  responsive: true,
			  scrollX: false,
			  stateSave: true,

			  select: {
			    style: 'multi-shift',
			    selector: 'td:first-child' // attenzione: meglio usare 'first-child' che 'nth-child(1)'
			  },

			  columns: [
			    { data: null }, // <- questo va così se non c'è "check" nel JSON
			    { data: "id" },
			    { data: "commessa" },
			    { data: "presso" },
			    { data: "cliente"},
			    { data: "sede" },
			    { data: "responsabile" },
			    { data: "azioni" }
			  ],

			  columnDefs: [
			    {
			      targets: 0,
			      className: 'select-checkbox',
			      orderable: false,
			      defaultContent: ''
			    },
			    { responsivePriority: 1, targets: 1 }
			  ],

			  buttons: [{
			    extend: 'colvis',
			    text: 'Nascondi Colonne'
			  }]
			});

		//	table.columns.adjust().draw();
		 
			
});


/* $('#tabPianificazioneRisorse tbody td').on('contextmenu', 'div',  function(e) {
	if($(this).hasClass("riquadro")){
	    selectedDiv = $(this);
	    e.preventDefault(); // Prevent default context menu
	}

	});  */


$('#modalAssociaIntervento').on("hidden.bs.modal", function(){
	
	
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


$('#formNuovaAssociazione').on("submit", function(e){
	
	 e.preventDefault();
	 
	  var t1 = $('#tabInterventi').DataTable();
	    t1.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
	        $('#id_intervento').val(id);
	    });
	
	 callAjaxForm('#formNuovaAssociazione','gestioneRisorse.do?action=associa_intervnto_risorsa');
	
});

$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>