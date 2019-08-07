<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Dettaglio Intervento
        <small></small>
      </h1>
        <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>

    <!-- Main content -->
    <section class="content">



<div class="row">
        <div class="col-xs-12">
        
        
        
          <div class="box">
            <div class="box-body">

            <div class="row">
<div class="col-xs-12">

<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Intervento
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${interventover.id}</a>
                </li>
                <li class="list-group-item">
                <b>Luogo</b><c:choose>
					  <c:when test="${interventover.in_sede_cliente == 0}">
							<span class="label label-success pull-right">IN SEDE</span>
					  </c:when>
					  <c:otherwise>
							<span class="label label-info pull-right">PRESSO CLIENTE</span>
					  </c:otherwise>
					</c:choose> 
					</li>
                <li class="list-group-item">
                  <b>ID Commessa</b> <a class="pull-right">${interventover.commessa}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Cliente</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${interventover.nome_cliente } </a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> 
                  <a id="nome_sede" class="pull-right" style="padding-right:7px">${interventover.nome_sede } </a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_creazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_creazione}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Data Prevista</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_prevista}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_prevista}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  
					<c:if test="${interventover.id_stato_intervento == 0}">
						<%-- <a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-info">${intervento.statoIntervento.descrizione}</span></a> --%>
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"   id="statoa_${interventover.id}"> <span class="label label-success">APERTO</span></a>
						
					</c:if>
					
					<c:if test="${interventover.id_stato_intervento == 1}">
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${interventover.id}"> <span class="label label-waring">CHIUSO</span></a>
						
					</c:if>
					
					    
				</div>
                </li>
                <li class="list-group-item">
                  <b>Data Chiusura</b> <a class="pull-right">
	
			<c:if test="${not empty interventover.data_chiusura}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${interventover.data_chiusura}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventover.user_creation.nominativo}</a>
                </li>
                <li class="list-group-item">
                  <b>Verificatore</b> <a class="pull-right">${interventover.user_verificazione.nominativo}</a>
                </li>
<%--                 <li class="list-group-item">
                  <b>Riparatore</b> <a class="pull-right">${interventover.user_riparatore.nominativo}</a>
                </li> --%>
        </ul>
        
   
</div>
</div>
</div>
</div>
      
     
      
      <div class="row">
<div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Pacchetto
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               
                <li class="list-group-item">
                  <b>Nome pack</b>  

    <a class="pull-right">${interventover.nome_pack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Genenerati</b> <a class="pull-right">${interventover.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">
						<%-- <a href="#" onClick="callAction('strumentiMisurati.do?action=lt&id=${utl:encryptData(intervento.id)}')" class="pull-right customTooltip customlink" title="Click per aprire la lista delle Misure dell'Intervento ${interventover.id}"> ${interventover.nStrumentiMisurati}</a> --%>
					${interventover.nStrumentiMisurati}
				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${interventover.nStrumentiNuovi}</a>
                </li>
               
        <li class="list-group-item">
        <div class="row" id="boxPacchetti">
        <c:if test="${interventover.id_stato_intervento != 2}">
				 <div class="col-xs-12">
 				 <h4>Gestione Pack</h4>
 				 </div>
	        <div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="callAction('scaricaPacchettoVerificazione.do')"><i class="glyphicon glyphicon-download"></i> Download Pacchetto</button>&nbsp;
			   
			</div>
			<div class="col-xs-4">
			    <span class="btn btn-primary fileinput-button pull-right">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input accept="application/x-sqlite3,.db"  id="fileupload" type="file" name="files">
		   	 </span>
		    </div>
		    <div class="col-xs-4">
		        <div id="progress" class="progress">
		        	<div class="progress-bar progress-bar-success"></div>
		    	</div>
		    <!-- The container for the uploaded files -->
		    <div id="files" class="files"></div>
	    </div>
   		</c:if>
    </div>
     
        </li>
<%--         <c:if test="${interventover.nStrumentiMisurati > 0 || interventover.nStrumentiNuovi > 0}">
 				   <li class="list-group-item">
 				   <h4>Download Schede</h4>
 				<button class="btn btn-default " onClick="scaricaSchedaConsegnaModal()"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
 				<button class="btn btn-info customTooltip " title="Click per aprire le schede di consegna" onClick="showSchedeConsegna('${utl:encryptData(intervento.id)}')"><i class="fa fa-file-text-o"></i> </button>
   				</li>
 				   <li class="list-group-item">
 				<button class="btn btn-default " onClick="scaricaListaCampioni('${intervento.id}')"><i class="glyphicon glyphicon-download"></i> Download Lista Campioni</button>
 				

       </li>
       				
 				 
       
           
       
       
       
      </c:if> --%>
     </ul>
    </div>
	</div>
</div>
</div>
      
            
            
            
 <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Misure
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="row">
        <div class="col-xs-12">
<a class="btn btn-primary pull-right" onClick="creaComunicazione()">Crea comunicazione</a>
</div>
</div><br>
 <div class="row">
        <div class="col-xs-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  
 <thead><tr class="active">
 <th></th>
  <th style="max-width:65px" class="text-center"></th>
  <th>ID</th>   
 <th>Strumento</th>
 <th>Data Verificazione</th>
 <th>Tecnico Verificatore</th>	
 <th>Data Scadenza</th>
 <th>Data Riparazione</th>
<%--  <th>Registro</th> --%>
 <th>Numero Rapporto</th>
 <th>Numero Attestato</th>
 <td style="min-width:150px">Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_misure}" var="misura">
 
 	<tr role="row" id="${misura.id}">
 	<td></td>
 	<td class="select-checkbox"></td>
<td>${misura.id}</td>

<td>${misura.verStrumento.denominazione}</td>
<td> <fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataVerificazione}" />	</td>
<td>${misura.tecnicoVerificatore.nominativo }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataScadenza}" /></td>
<td><fmt:formatDate pattern="dd/MM/yyyy"  value="${misura.dataRiparazione}" /></td>
<%-- <td>${misura.registro }</td> --%>
<td>${misura.numeroRapporto }</td>
<td>${misura.numeroAttestato }</td>
<td>
<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della misura" onClick="callAction('gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-search"></i></a>
<a class="btn btn-danger customTooltip" title="Click per generare il certificato" onClick="callAction('gestioneVerMisura.do?action=crea_certificato&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-file-pdf-o"></i></a>
<c:if test="${misura.nomeFile_inizio_prova!=null && misura.nomeFile_inizio_prova!=''}">
<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di inizio prova" onClick="callAction('gestioneVerMisura.do?action=download_immagine&id_misura=${utl:encryptData(misura.id)}&filename=${misura.nomeFile_inizio_prova}&nome_pack=${misura.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if>
<c:if test="${misura.nomeFile_fine_prova!=null && misura.nomeFile_fine_prova!='' }">

<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di fine prova" onClick="callAction('gestioneVerMisura.do?action=download_immagine&id_misura=${utl:encryptData(misura.id)}&filename=${misura.nomeFile_fine_prova}&nome_pack=${misura.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if>
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
		</div>
		
          </div>







  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		 </div>
      <div class="modal-footer" id="myModalFooter">
 
       
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

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> -->
	 <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"></script> -->
	<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">


<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<!--    <script src="plugins/iCheck/icheck.js"></script>
  <script src="plugins/iCheck/icheck.min.js"></script>  -->

 <script type="text/javascript">
 
 function creaComunicazione(){
	 
	 var table = $("#tabPM").DataTable();
	 
	 var str = "";
	 
	 
	 $('#tabPM tbody tr').each(function(){
		 if($(this).hasClass("selected")){
			 var td = $(this).find('td').eq(2);
			 str = str+td[0].innerText+";"
		 }
		
	 });
	 
	if(str == ''){
		$('#myModalErrorContent').html("Nessuna misura selezionata!")
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");	  
		$('#myModalError').modal('show');		
	}else{
		callAction('gestioneVerComunicazionePreventiva.do?action=crea_comunicazione&ids='+str)	
	}
	 
 }

 

 var columsDatatables1 = [];
 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables1 = state.columns;
	    }
	    
	    $('#tabPM thead th').each( function () {
	    	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
	    	var title = $('#tabPM thead th').eq( $(this).index() ).text();
	    	if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
	    	else if($(this).index() ==1){
	    	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
	      }
	    	 $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
	       	
	    	} );
	    
	    
	} );
 	
	
    $(document).ready(function() { 
    	
    	
    	$('.select2').select2();
    	
	    	$('#fileupload').fileupload({
	            url: "caricaPacchettoVerificazione.do?id_intervento=${interventover.id}",
	            dataType: 'json',
	            maxNumberOfFiles : 10,
	            singleFileUploads: false,
	            getNumberOfFiles: function () {
	                return this.filesContainer.children()
	                    .not('.processing').length;
	            },
	            start: function(e){
	            	pleaseWaitDiv = $('#pleaseWaitDialog');
	    			pleaseWaitDiv.modal();
	            },
	            add: function(e, data) {
	                var uploadErrors = [];
	                var acceptFileTypes = /(\.|\/)(db)$/i;
	                if(data.originalFiles[0]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
	                    uploadErrors.push('Tipo File non accettato. ');
	                }
	                if(data.originalFiles[0]['size'] > 10000000) {
	                    uploadErrors.push('File troppo grande, dimensione massima 10mb');
	                }
	                if(uploadErrors.length > 0) {
	                	
	                	$('#myModalErrorContent').html(uploadErrors.join("\n"));
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#myModalError').modal('show');
	                } else {
	                    data.submit();
	                }
	        	},
	            done: function (e, data) {
					
	            	pleaseWaitDiv.modal('hide');
	            	
	            	if(data.result.success)
					{
						
	            		$('#myModalErrorContent').html(data.result.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-success");						
						$('#myModalError').modal('show');
						
						$('#myModalError').on('hidden.bs.modal', function(){
							location.reload();
						});
					
					}else{
						
						$('#myModalErrorContent').html(data.result.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-danger");
						$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');						
						
						
						$('#progress .progress-bar').css(
			                    'width',
			                    '0%'
			                );
		               // $('#files').html("ERRORE SALVATAGGIO");
					}
	
	
	            },
	            fail: function (e, data) {
	            	pleaseWaitDiv.modal('hide');
	            	$('#files').html("");
	            	var errorMsg = "";
	                $.each(data.messages, function (index, error) {
	
	                	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
	           
	
	                });

	                $('#myModalErrorContent').html(errorMsg);
	                
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
      				$('#visualizza_report').show();
					$('#myModalError').modal('show');

					$('#progress .progress-bar').css(
		                    'width',
		                    '0%'
		                );
	            },
	            progressall: function (e, data) {
	                var progress = parseInt(data.loaded / data.total * 100, 10);
	                $('#progress .progress-bar').css(
	                    'width',
	                    progress + '%'
	                );
	
	            }
	        }).prop('disabled', !$.support.fileInput)
	            .parent().addClass($.support.fileInput ? undefined : 'disabled');
	    	
	    	
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
  	      pageLength: 25,
	    	      paging: true, 
	    	      ordering: true,
	    	      info: true, 
	    	      searchable: false, 
	    	      targets: 0,
	    	      responsive: true,
	    	      scrollX: false,
	    	      stateSave: true,
	    	      order:[[0,'desc']],
	    	      select: {		
	    	    	  
			        	style:    'multi+shift',
			        	selector: 'td:nth-child(2)'
			    	}, 
	    	      columnDefs: [
	    	    	  { className: "select-checkbox", targets: 1,  orderable: false },
					  { responsivePriority: 1, targets: 0 },
	    	          { responsivePriority: 2, targets: 10 }
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
	    	                         
	    	                          ]
	    	    	
	    	    });
			table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	       	 
 
    });  
	
	
	
   	$('#checkAll').on('ifChecked', function (ev) {

		$("#checkAll").prop('checked', true);
		table.rows().deselect();
		var allData = table.rows({filter: 'applied'});
		table.rows().deselect();
		i = 0;
		table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
		    //if(i	<maxSelect){
				 this.select();
		   /*  }else{
		    		tableLoop.exit;
		    }
		    i++; */
		    
		} );

  	});
	$('#checkAll').on('ifUnchecked', function (ev) {

		
			$("#checkAll").prop('checked', false);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();

	  	});
	
	
	
	
    });  
	       	 $('#myModalError').on('hidden.bs.modal', function (e) {
	       		if($('#myModalError').hasClass('modal-success')){
	     			callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(intervento.id)}');
	     		 }
	        	});

	       	 

	   

  </script>
</jsp:attribute> 
</t:layout>







