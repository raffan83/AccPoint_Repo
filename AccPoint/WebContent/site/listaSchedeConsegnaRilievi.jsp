 <%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>

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
        Schede di Consegna Rilievi Dimensionali
        
      </h1>
      
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
       <a class="btn btn-default pull-right" style="margin-right:5px" onClick="callAction('listaRilieviDimensionali.do?id_stato_lavorazione=${utl:encryptData(filtro_rilievi)}&cliente_filtro=${utl:encryptData(cliente_filtro) }',null,true)"><i class="fa fa-dashboard"></i> Torna alla lista rilievi</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div style="clear: both;"></div> 


<div class="row">
        <div class="col-xs-12">


 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Schede Consegna Rilievi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Mese</th>
 <th>Anno</th>
 <th>Commessa</th>
 <th>Data Creazione</th> 
 <c:if test="${!userObj.checkRuolo('RL') }">
  <th>Stato</th>
 </c:if>

 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna}" var="scheda" varStatus="loop">

<tr role="row" id="${scheda.id}-${loop.index}">
	
<td>${scheda.id}</td>
<td>${scheda.nome_cliente }</td>
<td>${scheda.nome_sede}</td>
<td>${scheda.mese}</td>
<td>${scheda.anno}</td>
<td>${scheda.commessa }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.data_creazione}" /></td>
 <c:if test="${!userObj.checkRuolo('RL') }">
<td>
<c:choose>
<c:when test="${scheda.stato==0 }">
Da Fatturare
</c:when>
<c:otherwise>
Fatturata
</c:otherwise>
</c:choose>
</td>
</c:if>
<td>
 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('','${scheda.file}', '${utl:encryptData(scheda.id)}')"><i class="fa fa-file-pdf-o"></i></a>
  <c:if test="${!userObj.checkRuolo('RL') }">
 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','1')"><i class="glyphicon glyphicon-refresh"></i></a>
 </c:if>
<%-- <a  target="_blank" class="btn btn-primary customTooltip  pull-center" title="Click per eliminare la scheda di consegna"   onClick="eliminaSchedaConsegna(${scheda.id})"><i class="fa fa-remove" style="color:black"></i></a> --%>	
</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>


            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        
        
   <%--      <div id="myModalDownloadSchedaConsegna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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

</div> --%>
        
        
        
        
        
        
 



<!-- 
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
</div> -->


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
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>

 

  <script type="text/javascript">

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
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} );

  
    $(document).ready(function() {
   
    	
    	
    	

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
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	  "order": [[0, "desc" ]],
  	      columnDefs: [
					   { responsivePriority: 1, targets: 0 },
  	                   /* { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 8 },
  	                   { responsivePriority: 4, targets: 7 } */
  	               ],

  	    	
  	    });
    	
  

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
	
	
	/* 
	
	$('#fileupload').fileupload({
        url: "CaricaSchedaConsegna.do",
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
            var acceptFileTypes = /(\.|\/)(pdf)$/i;
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
        		
				location.reload();
				
			}else{
				
				$('#modalErrorDiv').html(data.result.messaggio);
				$('#myModal').removeClass();
				$('#myModal').addClass("modal modal-danger");
				$('#myModal').find('.modal-footer').append('<button type="button" class="btn btn-outline" id="report_button" onClick="sendReport($(this).parents(\'.modal\'))">Invia Report</button>');
				$('#myModal').modal('show');
				
				$('#myModal').on('hidden.bs.modal', function(){
					$('#myModal').find('#report_button').remove();
				});
				$('#progress .progress-bar').css(
	                    'width',
	                    '0%'
	                ); 
                //$('#files').html("ERRORE SALVATAGGIO");
			}


        },
        fail: function (e, data) {
        	pleaseWaitDiv.modal('hide');
        	//$('#files').html("");
        	var errorMsg = "";
            $.each(data.messages, function (index, error) {

            	errorMsg = errorMsg + '<p>ERRORE UPLOAD FILE: ' + error + '</p>';
       
            });
            $('#myModalError').html(errorMsg);
			$('#myModal').removeClass();
			$('#myModal').addClass("modal modal-danger");
			$('#myModal').find('.modal-footer').append('<button type="button" class="btn btn-outline" id="report_button" onClick="sendReport($(this).parents(\'.modal\'))">Invia Report</button>');
			$('#modalErrorDiv').modal('show');
			
			$('#myModal').on('hidden.bs.modal', function(){
				$('#myModal').find('#report_button').remove();
			});
			
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
	
	
	 */
	


});
    	
  </script>
 </jsp:attribute> 
</t:layout>
  
 
