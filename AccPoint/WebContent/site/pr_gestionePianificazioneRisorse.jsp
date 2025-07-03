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
            <a class="btn btn-primary pull-right" onclick="$('#modalAssegnazioneDiretta').modal()"><i class="fa fa-plus"></i>Assegna Intervento</a>
            </div></div><br>
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
        <div class="col-xs-6">
         <label>Data inizio assegnazione</label>

           <input id="data_inizio" name="data_inizio" class="form-control datepicker" type="text" style="width:100%" required>
        
        </div>
        
        <div class="col-xs-6">
         <label>Data fine assegnazione</label>

           <input id="data_fine" name="data_fine" class="form-control datepicker" type="text" style="width:100%" required>
        
        </div>
        </div><br>
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

        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

      </div>
    </div>
  </div>

</div>
</form>



<form id="formModificaAssociazione" name="formModificaAssociazione" >
       <div id="modalModificaAssociazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="title_pianificazione">Modifica Associazione Intervento</h4>
      </div>
       <div class="modal-body"> 
        <div class="row">
        <div class="col-xs-12">
        <label id="label_intervento"></label>
        </div>
        </div><br>
       <div class="row">
        <div class="col-xs-6">
         <label>Data inizio assegnazione</label>

           <input id="data_inizio_mod" name="data_inizio_mod" class="form-control datepicker" type="text" style="width:100%" required>
        
        </div>
        
        <div class="col-xs-6">
         <label>Data fine assegnazione</label>

           <input id="data_fine_mod" name="data_fine_mod" class="form-control datepicker" type="text" style="width:100%" required>
        
        </div>
        </div>
      	</div>
      <div class="modal-footer">
     <input id="id_associazione" name="id_associazione"  type="hidden" style="width:100%" >
<a class="btn btn-danger pull-left"  onclick="$('#myModalYesOrNo').modal()">Elimina</a>
        
	               <button class="btn btn-primary" type="submit"  >Salva</button>
	                
	   
      
      

      </div>
    </div>
  </div>

</div>
</form>

<form id="formAssegnazioneDiretta" name="formAssegnazioneDiretta" >
<div id="modalAssegnazioneDiretta" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Assegna intervento</h4>
      </div>
       <div class="modal-body">      
       <div class="row">
       <div class="col-xs-12">
      <select class="form-control select2" id="intervento_select" style="width:100%" data-placeholder="Seleziona intervento...">
      <option value=""></option>
      <c:forEach items="${lista_interventi }" var="intervento" >
      <option value="${intervento.id }">ID: ${intervento.id } - COMM: ${intervento.idCommessa} - ${intervento.nome_cliente } - ${intervento.nome_sede }</option>
      </c:forEach>
      </select>
       
       </div>
       
       </div> <br>
       
        <div class="row">
       <div class="col-xs-12">
      <div class="row">
        <div class="col-xs-12">
        <table id="tabRisorse" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
        <thead>
        <tr>
      	<th></th>
        <th>ID</th>
        <th>Nominativo</th>
 		<th>Data</th>
        <th>Azioni</th>
        </tr>
        </thead>
        <tbody>
        
        </tbody>
        
        </table>

        </div>
	
      	</div>
       
       </div>
       
       </div> 
   
      	</div>
      <div class="modal-footer">
    <input type="hidden"" id="id_intervento_ris" name="id_intervento_ris">
  <input type="hidden" id="id_risorsa_direct" name="id_risorsa"> 
<button class="btn btn-primary" type="submit" >Salva</button>
		<a class="btn btn-primary" onclick="$('#modalAssegnazioneDiretta').modal('hide')" >Chiudi</a>
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
        <h4 class="modal-title" id="myModalLabel">Requisiti </h4>
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
	</div>
	
	
	  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
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


      <a class="btn btn-primary" onclick="eliminaAssociazione()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>
  <t:dash-footer />
  

  <t:control-sidebar />
   


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
	
	callAction('gestioneRisorse.do?action=pianificazione_risorse&move=back&data_inizio='+data_inizio+'&anno='+$('#anno').val());
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


callAction('gestioneRisorse.do?action=pianificazione_risorse&anno='+$('#anno').val());


	
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






function eliminaAssociazione(){
	
	dataObj = {};
	dataObj.id_associazione = $('#id_associazione').val();
	
	 	callAjax(dataObj, 'gestioneRisorse.do?action=elimina_associazione')

}


$('#intervento_select').on('change', function () {
    
	
	
	var val = $('#intervento_select').val()
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
    	dataObj ={};
    	dataObj.id_intervento = val;
    	

    	
    	
    	callAjax(dataObj, "gestioneRisorse.do?action=get_risorse_disponibili", function(data){
    		
    		if(data.success){
    			
    			var risorse_intervento = data.risorse_intervento_json;
    			
    			var lista_risorse = data.lista_risorse_disponibili;
    			var lista_risorse_all = data.lista_risorse_all;
    			lista_requisiti_doc_risorse = data.lista_req_doc_json;
    			lista_risorse_json = data.lista_risorse_all;
    			
    			 var id_risorse_disponibili = lista_risorse.map(function(r) { return r.id; });
    			 table_data = []
    			 
    			 for(var i = 0; i<lista_risorse.length;i++){
					  var dati = {};
				/* 	  dati.check ="<td></td>"; */
				  dati.check = null; 
					  dati.id = lista_risorse[i].id;
					  dati.nominativo = lista_risorse[i].utente.nominativo;
			
					  var risorsa_intervento = risorse_intervento.find(function(r) {
						    return r.risorsa.id === lista_risorse[i].id;
						});
					  if(risorsa_intervento){
						  dati.data = '<input type="text" style="width:100%" class="form-control daterange" id="daterange_'+lista_risorse[i].id+'" autocomplete="off" required value="'+risorsa_intervento.data_inizio+' - '+risorsa_intervento.data_fine+'"/>';  
					  }else{
						  dati.data = '<input type="text" style="width:100%" class="form-control daterange" id="daterange_'+lista_risorse[i].id+'" autocomplete="off" required />';
					  }
					  

	
					  dati.azioni = "<a class='btn btn-primary' onClick='mostraRequisitiRisorsa("+lista_risorse[i].id+")'>Requisiti</a>";
					  
					  
					  dati.DT_RowId = "riga_risorse_"+dati.id;
					  table_data.push(dati);
					  
					  
					
			
		    }

				   
				   var t = $('#tabRisorse').DataTable()
				t.clear().draw();
				   
				t.rows.add(table_data).draw();
					
				t.columns.adjust().draw();

		
				
				$('.daterange').daterangepicker({
				    locale: {
				        format: 'DD/MM/YYYY',
				        applyLabel: 'Applica',
				        cancelLabel: 'Annulla',
				        daysOfWeek: ['Do', 'Lu', 'Ma', 'Me', 'Gi', 'Ve', 'Sa'],
				        monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
				            'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
				        firstDay: 1
				    },
				    autoUpdateInput: false
				});

				$('.daterange').on('apply.daterangepicker', function(ev, picker) {
				    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
				});

				$('.daterange').on('cancel.daterangepicker', function(ev, picker) {
				    $(this).val('');
				});
    			
    	
    			if(risorse_intervento !=null){
    				for (var i = 0; i < risorse_intervento.length; i++) {
    					
    					t.row( "#riga_risorse_"+risorse_intervento[i].risorsa.id ).select();
    				
    				}
    		
    			}
    			$("#modalRisorse").modal();
    			
    		}
    		pleaseWaitDiv.modal('hide');
    	}, "GET")
	
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


function modalEliminaShow(){
	$('#modalRequisiti').modal()
}

$('#formNuovaAssociazione').on("submit", function(e){
	
	 e.preventDefault();
	 var values ="";
	  var t1 = $('#tabInterventi').DataTable();
	    t1.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
	        values +=id+";"
	    });
	    
	    $('#id_intervento').val(values);
	
	 callAjaxForm('#formNuovaAssociazione','gestioneRisorse.do?action=associa_intervnto_risorsa');
	
});


$('#formModificaAssociazione').on("submit", function(e){
	
	 e.preventDefault();

	
	 callAjaxForm('#formModificaAssociazione','gestioneRisorse.do?action=modifica_associazione');
	
});



$('#formAssegnazioneDiretta').on('submit', function(e){
	
  	 e.preventDefault();
  	// $('#id_risorsa').val($("#risorse_disponibili").val())
  	 
  	 
  	 	  var t1 = $('#tabRisorse').DataTable();
  	 var valori = "";
	    t1.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	        var id = $row.find('td').eq(1).text().trim(); 
	        
	       
	        var date = $row.find('td').eq(3).find('input').val(); // Colonna ID
	        
	        $row.find('td').eq(3).find('input').attr("required", true);
	        valori += id+","+date + ";";
	    });
	    
	    $('#id_risorsa_direct').val(valori.slice(0, -1));
	    $('#id_intervento_ris').val($('#intervento_select').val())

callAjaxForm('#formAssegnazioneDiretta','gestioneRisorse.do?action=associa_intervnto_risorsa');

   })

$(document.body).css('padding-right', '0px');
</script>

</jsp:attribute> 
</t:layout>