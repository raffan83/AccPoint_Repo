<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
                  <b>ID</b> <a class="pull-right">${intervento.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Presso</b> <a class="pull-right">
<c:choose>
  <c:when test="${intervento.pressoDestinatario == 0}">
		<span class="label label-info">IN SEDE</span>
  </c:when>
  <c:when test="${intervento.pressoDestinatario == 1}">
		<span class="label label-warning">PRESSO CLIENTE</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
   
		</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${intervento.nome_sede}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right">
	
			<c:if test="${not empty intervento.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy" value="${intervento.dataCreazione}" />
			</c:if>
		</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <div class="pull-right">
                  
					<c:if test="${intervento.statoIntervento.id == 0}">
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento(${intervento.id},false)" id="stato_${intervento.id}"> <span class="label label-info">${intervento.statoIntervento.descrizione}</span></a>
					</c:if>
					
					<c:if test="${intervento.statoIntervento.id == 1}">
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento(${intervento.id},false)" id="stato_${intervento.id}"> <span class="label label-success">${intervento.statoIntervento.descrizione}</span></a>
					</c:if>
					
					<c:if test="${intervento.statoIntervento.id == 2}">
						<a href="#" id="stato_${intervento.id}"> <span class="label label-warning">${intervento.statoIntervento.descrizione}</span></a>
					</c:if>
    
				</div>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nominativo}</a>
                </li>
        </ul>
        
   
</div>
</div>
</div>
</div>
      
      <c:if test="${userCliente == '0'}">
      
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

    <a class="pull-right">${intervento.nomePack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Genenerati</b> <a class="pull-right">${intervento.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">
						<a href="#" onClick="callAction('strumentiMisurati.do?action=lt&id=${intervento.id}')" class="pull-right customTooltip" title="Click per aprire la lista delle Misure dell'Intervento ${intervento.id}"> ${intervento.nStrumentiMisurati}</a>

				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${intervento.nStrumentiNuovi}</a>
                </li>
               
        <li class="list-group-item">
        <div class="row" id="boxPacchetti">
        <c:if test="${intervento.statoIntervento.id != 2}">
				 <div class="col-xs-12">
 				 <h4>Gestione Pack</h4>
 				 </div>
	        <div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="scaricaPacchetto('${intervento.nomePack}')"><i class="glyphicon glyphicon-download"></i> Download Pacchetto</button>
			</div>
			<div class="col-xs-4">
			    <span class="btn btn-primary fileinput-button pull-right">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>
		        <!-- The file input field used as target for the file upload widget -->
		        		<input id="fileupload" type="file" name="files">
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
         <li class="list-group-item">
         
     <div class="row" id="boxDownloadSchede">
 				 <div class="col-xs-12">
 				 <h4>Download Schede</h4>
 				 </div>
	        <div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="scaricaSchedaConsegnaModal()"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
			</div>
			<div class="col-xs-4">
				<button class="btn btn-default pull-left" onClick="scaricaListaCampioni('${intervento.id}')"><i class="glyphicon glyphicon-download"></i> Download Lista Campioni</button>
			</div>

    </div>
      </li>
     </ul>
    </div>
	</div>
</div>
</div>
</div>      
            
            
            
              <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Log Update Pacchetto
	<div class="box-tools pull-right">

		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
  <th>ID</th>
 <th>Data Caricamento</th>
 <th>Nome Pack</th>
 <th>Stato</th>
 <th>N° Strumenti Nuovi</th>
 <th>N° Strumenti Misurati</th>
 <td>Responsabile</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${intervento.listaInterventoDatiDTO}" var="pack">
 
 	<tr role="row" id="${pack.id}">
<td>${pack.id}</td>
		<td>
			<c:if test="${not empty pack.dataCreazione}">
   				<fmt:formatDate pattern="dd/MM/yyyy"  value="${pack.dataCreazione}" />
			</c:if>
		</td>
		<td>${pack.nomePack}</td>
		<td class="">
			 <span class="label label-info">${pack.stato.descrizione}</span>
		</td>
		<td>${pack.numStrNuovi}</td>
		<td><a href="#" class="customTooltip" title="Click per aprire la lista delle Misure del pacchetto" onClick="callAction('strumentiMisurati.do?action=li&id=${pack.id}')">${pack.numStrMis}</a></td>
		<td>${pack.utente.nominativo}</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
 </div>
</div>  
</div>
</div>
</c:if>

  <div class="row">
        <div class="col-xs-12">
        <c:if test="${userCliente != '0'}">
		 <div class="box box-danger box-solid">
		<div class="box-header with-border">
			 Grafici
			<div class="box-tools pull-right">
		
				<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
		</c:if>
		
		<c:if test="${userCliente == '0'}">
		 <div class="box box-danger box-solid collapsed-box">
		<div class="box-header with-border">
			 Grafici
			<div class="box-tools pull-right">
				<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>
		</c:if>
			</div>
		</div>
		<div class="box-body">
			<div id="grafici">
			<div class="row">
				<div class="col-xs-12">
					<canvas id="grafico1"></canvas>
				</div>
				<div class="col-xs-12">
					<canvas id="grafico2"></canvas>
				</div>
				<div class="col-xs-12">
					<canvas id="grafico3"></canvas>
				</div>
				<div class="col-xs-12">
					<canvas id="grafico4"></canvas>
				</div>
				<div class="col-xs-12">
					<canvas id="grafico5"></canvas>
				</div>
				<div class="col-xs-12">
					<canvas id="grafico6"></canvas>
				</div>
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
        <!-- /.col -->
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
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>

  <div id="modalListaDuplicati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-keyboard="false" data-backdrop="static" >
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">

        <h4 class="modal-title" id="myModalLabel">Lista Duplicati</h4>
      </div>
       <div class="modal-body">
			<div id="listaDuplicati">
			<table id="tabLD" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">

	
			 </table>  
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


        <button type="button" class="btn btn-danger"onclick="saveDuplicatiFromModal()"  >Salva</button>
      </div>
    </div>
  </div>
</div>

 <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
        
  		 </div>
      
    </div>
     <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
    </div>
  </div>
    </div>

</div>
   <div id="myModalDownloadSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scheda Consegna</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 <form name="scaricaSchedaConsegnaForm" method="post" id="scaricaSchedaConsegnaForm" action="#">
        <div class="form-group">
		  <label for="notaConsegna">Consegna di:</label>
		  <textarea class="form-control" rows="5" name="notaConsegna" id="notaConsegna"></textarea>
		</div>
		
		<div class="form-group">
		  <label for="notaConsegna">Cortese Attenzione di:</label>
		  <input class="form-control" id="corteseAttenzione" name="corteseAttenzione" />
		</div>
		
      <fieldset class="form-group">
		  <label for="gridRadios">Stato Intervento:</label>
         <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="0" checked="checked">
            CONSEGNA DEFINITIVA
           </label>
        </div>
        <div class="form-check">
          <label class="form-check-label">
            <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="1">
            STATO AVANZAMENTO
          </label>

      </div>
    </fieldset>	     
</form>   
  		 </div>
      
    </div>
     <div class="modal-footer">

     <button class="btn btn-default pull-left" onClick="scaricaSchedaConsegna('${intervento.id}')"><i class="glyphicon glyphicon-download"></i> Download Scheda Consegna</button>
   
    	
    </div>
  </div>
    </div>

</div>
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

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


<script src="plugins/jQueryFileUpload/js/jquery.fileupload.js"></script>
<script src="plugins/jQueryFileUpload/js/jquery.fileupload-process.js"></script>
<script src="plugins/jQueryFileUpload/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jQueryFileUpload/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>

 <script type="text/javascript">
	var statoStrumentiJson = ${statoStrumentiJson};
	var tipoStrumentiJson = ${tipoStrumentiJson};
	var denominazioneStrumentiJson = ${denominazioneStrumentiJson};
	var freqStrumentiJson = ${freqStrumentiJson};
	var repartoStrumentiJson = ${repartoStrumentiJson};
	var utilizzatoreStrumentiJson = ${utilizzatoreStrumentiJson};
 
	var userCliente = ${userCliente};
	
    $(document).ready(function() { 
    	
    	
    	if(userCliente == "0"){
	    	$('#fileupload').fileupload({
	            url: "caricaPacchetto.do",
	            dataType: 'json',
	            maxNumberOfFiles : 1,
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
	                	//$('#files').html(uploadErrors.join("\n"));
	                	$('#modalErrorDiv').html(uploadErrors.join("\n"));
						$('#myModal').removeClass();
						$('#myModal').addClass("modal modal-danger");
						$('#myModal').modal('show');
	                } else {
	                    data.submit();
	                }
	        	},
	            done: function (e, data) {
					
	            	pleaseWaitDiv.modal('hide');
	            	
	            	if(data.result.success)
					{
						createLDTable(data);
	
						//$('#files').html("SALVATAGGIO EFFETTUATO");
					
					}else{
						
						$('#modalErrorDiv').html(data.result.messaggio);
						$('#myModal').removeClass();
						$('#myModal').addClass("modal modal-danger");
						$('#myModal').modal('show');
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
	                $('#modalErrorDiv').html(errorMsg);
					$('#myModal').removeClass();
					$('#myModal').addClass("modal modal-danger");
					$('#myModal').modal('show');
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
	    	      paging: true, 
	    	      ordering: true,
	    	      info: true, 
	    	      searchable: false, 
	    	      targets: 0,
	    	      responsive: true,
	    	      scrollX: false,
	    	      order:[[0,'desc']],
	    	      columnDefs: [
							   { responsivePriority: 1, targets: 0 },
	    	                   { responsivePriority: 3, targets: 2 },
	    	                   { width: "50px", targets: 0 },
	    	                   { width: "100px", targets: 1 },
	    	                   { width: "90px", targets: 3 },
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
	    	table.buttons().container()
	        .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
	     	   
	 			/* $('#tabPM').on( 'dblclick','tr', function () {
	
	       		var id = $(this).attr('id');
	       		
	       		var row = table.row('#'+id);
	       		data = row.data();
	           
	     	    if(data){
	     	    	 row.child.hide();
	             	$( "#myModal" ).modal();
	     	    }
	       	}); */
	       	    
	       	    
	       	 $('#myModal').on('hidden.bs.modal', function (e) {
	
	       	});
	       	 $('#modalListaDuplicati').on('hidden.bs.modal', function (e) {
	       	  	
	       	});
	       	 $('#myModal').on('hidden.bs.modal', function (e) {
	       		if($('#myModal').hasClass('modal-success')){
	     			callAction('gestioneInterventoDati.do?idIntervento=${intervento.id}');
	     		 }
	        	});
	       	
	    
	    $('#tabPM thead th').each( function () {
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	    } );
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
			  } );
	 	    
    	}
    	 
    	//Grafici



    	/* GRAFICO 1*/

    	numberBack1 = Math.ceil(Object.keys(statoStrumentiJson).length/6);
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# Strumenti in Servizio";
    		
    		
    		
    		
    		
    			dataset1.backgroundColor = [];
    			dataset1.borderColor = [];
    		for (i = 0; i < numberBack1; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArr);
    			dataset1.borderColor = dataset1.borderColor.concat(newArrB);
    		}
    		dataset1.borderWidth = 1;
    		$.each(statoStrumentiJson, function(i,val){
    			grafico1.labels.push(i);
    			dataset1.data.push(val);
    		});
    		
    		 grafico1.datasets = [dataset1];
    		 
    		 var ctx1 = document.getElementById("grafico1");
    	
    		
    	
    		  myChart1 = new Chart(ctx1, {
    		     type: 'bar',
    		     data: grafico1,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	} 
    	
    	 /* GRAFICO 2*/
    	 
    	 numberBack2 = Math.ceil(Object.keys(tipoStrumentiJson).length/6);
    	 if(numberBack2>0){
    		 
    	 
    		grafico2 = {};
    		grafico2.labels = [];
    		 
    		dataset2 = {};
    		dataset2.data = [];
    		dataset2.label = "# Strumenti per Tipologia";
    		
    		
     		dataset2.backgroundColor = [ ];
    		dataset2.borderColor = [ ];
    		for (i = 0; i < numberBack2; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset2.backgroundColor = dataset2.backgroundColor.concat(newArr);
    			dataset2.borderColor = dataset2.borderColor.concat(newArrB);
    		}
    		

    		dataset2.borderWidth = 1;
    		$.each(tipoStrumentiJson, function(i,val){
    			grafico2.labels.push(i);
    			dataset2.data.push(val);
    		});
    		
    		 grafico2.datasets = [dataset2];
    		 
    		 var ctx2 = document.getElementById("grafico2");
    		 
    		
    		  myChart2 = new Chart(ctx2, {
    		     type: 'bar',
    		     data: grafico2,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	 }

    	 
     	/* GRAFICO 3*/
    	 
    	 numberBack3 = Math.ceil(Object.keys(denominazioneStrumentiJson).length/6);
    	 if(numberBack3>0){
    		 
    	 
    		grafico3 = {};
    		grafico3.labels = [];
    		 
    		dataset3 = {};
    		dataset3.data = [];
    		dataset3.label = "# Strumenti per Denominazione";
    		
    		
     		dataset3.backgroundColor = [ ];
    		dataset3.borderColor = [ ];
    		for (i = 0; i < numberBack3; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset3.backgroundColor = dataset3.backgroundColor.concat(newArr);
    			dataset3.borderColor = dataset3.borderColor.concat(newArrB);
    		}
    		

    		dataset3.borderWidth = 1;
    		$.each(denominazioneStrumentiJson, function(i,val){
    			grafico3.labels.push(i);
    			dataset3.data.push(val);
    		});
    		
    		 grafico3.datasets = [dataset3];
    		 
    		 var ctx3 = document.getElementById("grafico3");
    		

    		 
    		  myChart3 = new Chart(ctx3, {
    		     type: 'bar',
    		     data: grafico3,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	 } 
    	 
     /* GRAFICO 4*/
    	 
    	 numberBack4 = Math.ceil(Object.keys(freqStrumentiJson).length/6);
    	 if(numberBack4>0){
    		 
    	 
    		grafico4 = {};
    		grafico4.labels = [];
    		 
    		dataset4 = {};
    		dataset4.data = [];
    		dataset4.label = "# Strumenti per Frequenza";
    		
    		
     		dataset4.backgroundColor = [ ];
    		dataset4.borderColor = [ ];
    		for (i = 0; i < numberBack4; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset4.backgroundColor = dataset4.backgroundColor.concat(newArr);
    			dataset4.borderColor = dataset4.borderColor.concat(newArrB);
    		}
    		

    		dataset4.borderWidth = 1;
    		$.each(freqStrumentiJson, function(i,val){
    			grafico4.labels.push(i);
    			dataset4.data.push(val);
    		});
    		
    		 grafico4.datasets = [dataset4];
    		 
    		 var ctx4 = document.getElementById("grafico4");
    		 
    		
    		 
    		  myChart4 = new Chart(ctx4, {
    		     type: 'bar',
    		     data: grafico4,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	 } 
    	 
     /* GRAFICO 5*/
    	 
    	 numberBack5 = Math.ceil(Object.keys(repartoStrumentiJson).length/6);
    	 if(numberBack5>0){
    		 
    	 
    		grafico5 = {};
    		grafico5.labels = [];
    		 
    		dataset5 = {};
    		dataset5.data = [];
    		dataset5.label = "# Strumenti per Reparto";
    		
    		
     		dataset5.backgroundColor = [ ];
    		dataset5.borderColor = [ ];
    		for (i = 0; i < numberBack5; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset5.backgroundColor = dataset5.backgroundColor.concat(newArr);
    			dataset5.borderColor = dataset5.borderColor.concat(newArrB);
    		}
    		

    		dataset5.borderWidth = 1;
    		$.each(repartoStrumentiJson, function(i,val){
    			grafico5.labels.push(i);
    			dataset5.data.push(val);
    		});
    		
    		 grafico5.datasets = [dataset5];
    		 
    		 var ctx5 = document.getElementById("grafico5");
    		 
    		
    		 
    		  myChart5 = new Chart(ctx5, {
    		     type: 'bar',
    		     data: grafico5,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	 } 
    	 
     /* GRAFICO 6*/
    	 
    	 numberBack6 = Math.ceil(Object.keys(utilizzatoreStrumentiJson).length/6);
    	 if(numberBack6>0){
    		 
    	 
    		grafico6 = {};
    		grafico6.labels = [];
    		 
    		dataset6 = {};
    		dataset6.data = [];
    		dataset6.label = "# Strumenti Utilizzatore";
    		
    		
     		dataset6.backgroundColor = [ ];
    		dataset6.borderColor = [ ];
    		for (i = 0; i < numberBack6; i++) {
    			newArr = [
    		         'rgba(255, 99, 132, 0.2)',
    		         'rgba(54, 162, 235, 0.2)',
    		         'rgba(255, 206, 86, 0.2)',
    		         'rgba(75, 192, 192, 0.2)',
    		         'rgba(153, 102, 255, 0.2)',
    		         'rgba(255, 159, 64, 0.2)'
    		     ];
    			
    			newArrB = [
    		         'rgba(255,99,132,1)',
    		         'rgba(54, 162, 235, 1)',
    		         'rgba(255, 206, 86, 1)',
    		         'rgba(75, 192, 192, 1)',
    		         'rgba(153, 102, 255, 1)',
    		         'rgba(255, 159, 64, 1)'
    		     ];
    			
    			dataset6.backgroundColor = dataset6.backgroundColor.concat(newArr);
    			dataset6.borderColor = dataset6.borderColor.concat(newArrB);
    		}
    		

    		dataset6.borderWidth = 1;
    		$.each(utilizzatoreStrumentiJson, function(i,val){
    			grafico6.labels.push(i);
    			dataset6.data.push(val);
    		});
    		
    		 grafico6.datasets = [dataset6];
    		 
    		 var ctx6 = document.getElementById("grafico6");
    		 
    		
    		 
    		  myChart6 = new Chart(ctx6, {
    		     type: 'bar',
    		     data: grafico6,
    		     options: {
    		         scales: {
    		             yAxes: [{
    		                 ticks: {
    		                     beginAtZero:true,
    		                     autoSkip: false
    		                 }
    		             }],
    		             xAxes: [{
    		                 ticks: {
    		                     autoSkip: false
    		                 }
    		             }]
    		         }
    		     }
    		 });
    	 
    	 } 
    
    });
  </script>
</jsp:attribute> 
</t:layout>







