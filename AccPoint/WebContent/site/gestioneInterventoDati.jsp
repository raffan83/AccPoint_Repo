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
                  <b>Stato</b> <a class="pull-right">

    <span class="label label-info">${intervento.statoIntervento.descrizione}</span>


				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nome}</a>
                </li>
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

    <a class="pull-right">${intervento.nomePack}</a>
		 
                </li>
               <li class="list-group-item">
                  <b>N° Strumenti Genenerati</b> <a class="pull-right">${intervento.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">

  					 ${intervento.nStrumentiMisurati}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${intervento.nStrumentiNuovi}</a>
                </li>
               
        </ul>
        <div class="row">
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
		<td><a href="#" onClick="callAction('strumentiMisurati.do?action=li&id=${pack.id}')">${pack.numStrMis}</a></td>
		<td>${pack.utente.nome}</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
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


 <script type="text/javascript">
   
 
    $(document).ready(function() { 
    	
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
        $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
    } );
 
    // DataTable
  	table = $('#tabPM').DataTable();
    // Apply the search
    table.columns().eq( 0 ).each( function ( colIdx ) {
        $( 'input', table.column( colIdx ).header() ).on( 'keyup change', function () {
            table
                .column( colIdx )
                .search( this.value )
                .draw();
        } );
    } ); 
    	table.columns.adjust().draw();
    
    });
  </script>
</jsp:attribute> 
</t:layout>







