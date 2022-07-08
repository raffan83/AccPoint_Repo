<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
	%>
	
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
     <h1 class="pull-left">
        Lista Misure
      <!--   <small>Fai doppio click per entrare nel dettaglio</small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">


          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
	<div class="col-xs-12">
	<button class="btn btn-primary pull-right" id="lat_btn" onClick="filtraMisure('')" disabled>Tutte</button>
	<button class="btn btn-primary pull-right" style="margin-right:5px" id="tutte_btn" onClick="filtraMisure('S')">LAT</button>
	
	</div>
	</div>

<div class="row">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data Misura:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				                <button type="button" class="btn btn-info btn-flat" onclick="cercaMisure()">Cerca</button> 
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetData()">Reset Data</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	<c:if test="${userObj.checkPermesso('CREA_REPORT_ACCREDIA') }">
	<div class="col-xs-6">
	<a type="button" href="#" class="btn btn-danger pull-right" style="margin-top:26px" onclick="creaReportAccredia()"><i class="fa fa-file-pdf-o"></i> Crea Report Accredia</a>
	</div>
	</c:if>
</div><br>

<div class="row">
	<div class="col-xs-12">

  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>ID Certificato</th>
 <th>N° Certificato</th>
 <th>Data Emissione</th>
 <th>Data Misura</th> 
  <th>Strumento</th>
  <th>Matricola | Codice Interno</th>
  <th>Modello</th>
  <th>Costruttore</th>
  <th>Strumento Lat</th>
  <th>Intervento</th>
  <th>Commessa</th>
  <th>Cliente</th>
  <th>Sede</th>
  <th >Lat</th>
  <th>Misura obsoleta</th>
  <th>Riemissione</th>
  <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_misure}" var="misura" varStatus="loop">


		 <tr role="row" id="${misura.split(';;')[0]}-${loop.index}">
<td></td>
	<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della Misura"  onClick="callAction('dettaglioMisura.do?idMisura=${utl:encryptData(misura.split(';;')[0])}')" onClick="">${misura.split(';;')[0]}</a></td>
	
<td>${misura.split(';;')[12] }</td>
<td><c:if test="${misura.split(';;')[11].equals('null')}"></c:if>
<c:if test="${!misura.split(';;')[11].equals('null')}">
${misura.split(';;')[11] }
</c:if>
</td>
<td>${misura.split(';;')[17] }</td>
<td>${misura.split(';;')[5]}</td>
<td>${misura.split(';;')[2]}</td>
<td>${misura.split(';;')[3]} | ${misura.split(';;')[4]}</td>
<td><c:if test="${misura.split(';;')[15].equals('null')}"></c:if>
<c:if test="${!misura.split(';;')[15].equals('null')}">
${misura.split(';;')[15] }
</c:if></td>
<td><c:if test="${misura.split(';;')[16].equals('null')}"></c:if>
<c:if test="${!misura.split(';;')[16].equals('null')}">
${misura.split(';;')[16] }
</c:if></td>
<td><c:if test="${misura.split(';;')[9].equals('null')}"></c:if>
<c:if test="${!misura.split(';;')[9].equals('null')}">
${misura.split(';;')[9] }
</c:if>
</td>
<td><a class="btn customTooltip customlink"onClicK="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(misura.split(';;')[1])}')" title="Click per aprire il dettaglio dell'intervento">${misura.split(';;')[1]}</a></td>
<td>${misura.split(';;')[6] }</td>
<td>${misura.split(';;')[7] }</td>
<td>${misura.split(';;')[8] }</td>
<td>
<c:if test="${misura.split(';;')[10] == 'S'}">
SI
</c:if>
<c:if test="${misura.split(';;')[10] == 'N' }">
NO
</c:if>

</td>
<td>
<c:if test="${misura.split(';;')[13] == 'S'}">
SI
</c:if>
<c:if test="${misura.split(';;')[13] == 'N' }">
NO
</c:if>
</td>
<td>
<c:if test="${misura.split(';;')[13] == 'S' &&  !misura.split(';;')[11].equals('null')}">
<i class="fa fa-check"></i>
</c:if>
<c:if test="${misura.split(';;')[13] == 'N' }">

</c:if>
</td>
<td>
<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
<a class="btn btn-warning customTooltip" title="Click per modificare lo strumento" onClick="modalModificaStrumento('${misura.split(';;')[14]}')"><i class="fa fa-edit"></i></a>
</c:if>
<c:if test="${userObj.checkPermesso('MODIFICA_CERTIFICATO')}">
<a class="btn btn-info customTooltip" title="Click per modificare il certificato" onClick="modalModificaCertificato('${misura.split(';;')[12]}','${misura.split(';;')[11] }','${misura.split(';;')[17]}')"><i class="fa fa-file"></i></a>
</c:if>
<a  target="_blank" class="btn btn-primary customTooltip" title="Click per scaricare il PDF dell'etichetta"  href="scaricaEtichetta.do?action=stampaEtichetta&idMisura=${utl:encryptData(misura.split(';;')[0])}" ><i class="fa fa-print"></i></a>
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
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        </div>
        </div>
        <!-- /.col -->
 
 
  <div id="myModalModificaStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">


<div class="tab-pane" id="modifica">
        
            <!-- /.tab-content -->
          </div>
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div> 


<form id="modificaCertificatoForm" name="modificaCertificatoForm">
  <div id="myModalModificaCertificato" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Certificato</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-4">
       <label>Numero Certificato</label>
       
       </div>
       <div class="col-xs-8">
       <input id="numero_certificato" name="numero_certificato" type="text" class="form-control" required>
       </div>
       
       </div>

       <div class="row">
       <div class="col-xs-4">
       <label>Data Emissione</label>
       
       </div>
       <div class="col-xs-8">
               <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_emissione" name="data_emissione" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       </div>
       
       </div>
       
       
       <div class="row">
       <div class="col-xs-4">
       <label>Note</label>
       
       </div>
       <div class="col-xs-8">
		<textarea rows="3" style="width:100%" class="form-control" required id="note" name="note"></textarea>
       </div>
       
       </div>

            <!-- /.tab-content -->
          </div>
        
  		
      <div class="modal-footer">
		<input type="hidden" id="id_certificato" name="id_certificato">
		
		<button class="btn btn-primary" type="submit">Salva</button>
      </div>
       </div>
    </div>
  </div>
  </form>
<!-- </div>  -->

 
 
 <form id="formCertificato" name="formCertificato">
  <div id="myModalCertificato" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Certificato</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_certificato" type="file" accept=".pdf,.PDF" name="fileupload_certificato" class="form-control"/>
		   	 </span>
		   	 <label id="certificato_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="id_cert" name="id_cert">
        <input type="hidden" id="pack_cert" name="pack_cert">

  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateCertificato()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>
 

<form id="formAllegati" name="formAllegati">
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
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="pack" name=pack>
        <input type="hidden" id="id_misura" name=id_misura>
        <div class="row">
       <div class="col-xs-12">
        <label>Note Allegato</label>
        <textarea rows="5" style="width:100%" id="note_allegato" name="note_allegato"></textarea>        
       </div>
       
       </div>
       <div class="row">
       <div class="col-xs-12">
       <label>Attenzione! L'upload potrebbe sovrascrivere un altro file precedentemente caricato!</label>
       </div>
       </div>
  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateAllegati()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>



  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">


  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>




</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript">



   </script>

  <script type="text/javascript">

  
  function modalModificaCertificato(id_certificato, numero_certificato, data_emissione){
	  
	  $('#id_certificato').val(id_certificato);
	  $('#numero_certificato').val(numero_certificato);
	  $('#data_emissione').val(data_emissione);
	  
	  $('#myModalModificaCertificato').modal();
	  
  }
  
  
  $('#myModalModificaCertificato').on('hidden.bs.modal', function(){
	 
	  $('#note').val("");
	  
  });
  
  
	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        if($(this).index()!= 0){
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	    } );
	} );

	
	
	$('input[name="datarange"]').on('apply.daterangepicker', function(ev, picker) {
	    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
	    $('#date_from').val(picker.startDate.format('DD/MM/YYYY'));
	    $('#date_to').val(picker.endDate.format('DD/MM/YYYY'));
	    //$('#cerca_btn').attr('disabled', false);
	});

	$('input[name="datarange"]').on('cancel.daterangepicker', function(ev, picker) {
	    $(this).val('');
	    $('#date_from').val("");
	    $('#date_to').val("");
	     if($('#utente').val()==''){
	   		$('#cerca_btn').attr('disabled', true);	
	   	}  
	    
	});
	
	function resetData(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		callAction("gestioneMisura.do?action=lista");
	}
	
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}

	
	  function cercaMisure(){
			
			
			var startDatePicker = $("#datarange").data('daterangepicker').startDate;
			var endDatePicker = $("#datarange").data('daterangepicker').endDate;
			
			dataString = "?action=lista&date_from=" + startDatePicker.format('YYYY-MM-DD') + "&date_to=" + endDatePicker.format('YYYY-MM-DD');
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("gestioneMisura.do"+ dataString, false,true);
				 	
					
	}
	  
	  function creaReportAccredia(){
		
		  var startDatePicker = $("#datarange").data('daterangepicker').startDate;
		  var endDatePicker = $("#datarange").data('daterangepicker').endDate;
			
			dataString = "?action=crea_report_accredia&date_from=" + startDatePicker.format('YYYY-MM-DD') + "&date_to=" + endDatePicker.format('YYYY-MM-DD');
				 	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();

			callAction("gestioneMisura.do"+ dataString, false,true);
			
			pleaseWaitDiv.modal('hide');
		  
	  }
	
	  function filtraMisure(filtro){
		  table
	        .columns( 13 )
	        .search( filtro )
	        .draw();
		  if(filtro==''){
			  $("#tutte_btn").prop("disabled",false);
			  $("#lat_btn").prop("disabled",true);
		  }else{
			  $("#tutte_btn").prop("disabled",true);
			  $("#lat_btn").prop("disabled",false);  
		  }
		  
		 
	  }
	  
	  
	  function modalModificaStrumento(id_strumento){
		  
		  exploreModal("modificaStrumento.do?action=modifica&id="+id_strumento,"","#modifica")
		  
		  $('#myModalModificaStrumento').modal();
	  }
	 
	     $("#myModalError").on("hidden.bs.modal", function () {
	      	  
	      	  if($('#myModalError').hasClass("modal-success")){
	      		if(!$('#myModalModificaPacco').hasClass('in')){
	      	  		location.reload();
	      		}
	        }
	      	    
	      	}); 
	
    $(document).ready(function() {
    
    	 var date_from = "${date_from}";
     	 var date_to = "${date_to}";

         $('.datepicker').datepicker({
    		 format: "dd/mm/yyyy"
    	 });    
     	 
   	 $('input[name="datarange"]').daterangepicker({
		   
		     locale: {
		      format: 'DD/MM/YYYY',
		    	  
		    } 
		});

   	 
 	$('#datarange').data('daterangepicker').setStartDate(date_from);
	 	$('#datarange').data('daterangepicker').setEndDate(date_to);
   	 
    	table = $('#tabPM').DataTable({
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
  	      paging: true, 
  	      ordering: true,
  	    		order: [[ 1, "desc" ]],
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      stateSave: true,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 1 },
						   { responsivePriority: 2, targets: 13 },
						   /* { responsivePriority: 3, targets: 14 }, */
  	                  
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
    				
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');

     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	resetCalendar("#prenotazione");
     	})


     	    $('.inputsearchtable').on('click', function(e){
     	       e.stopPropagation();    
     	    });
  // DataTable
	table = $('#tabPM').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	
	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });
	
	
	
	
	filtraMisure('');
});
    
    
    
    $('#modificaCertificatoForm').on('submit', function(e){
    	
    	e.preventDefault()
    	modificaCertificato();
    });
  </script>
</jsp:attribute> 
</t:layout>
  
 

 