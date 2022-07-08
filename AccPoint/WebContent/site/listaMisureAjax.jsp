<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
	%>
	



<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">


          </div>
            <div class="box-body">
            
            <c:if test="${listaMisure.size()>1}">
                                    <div class="row">
        <div class="col-xs-12">
        <a class="btn btn-primary pull-right" target="_blank" href="dettaglioMisura.do?action=andamento_temporale&id_strumento=${id_strumento}">Vedi andamento temporale </a>
        </div>
        </div><br>
            </c:if>
            
              <div class="row">
        <div class="col-xs-12">


  <table id="tabMisure" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>Data Misura</th>
  <th>Strumento</th>
       <th>Codice Interno</th>
   <th>Stato Ricezione</th>
    <th>Obsoleta</th>
     <th>Certificato</th>
     <th>Allegati</th>
     <th>Note Allegati</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaMisure}" var="misura" varStatus="loop">

	 <tr role="row" id="${misura.id}-${loop.index}">
	<td></td>
	<td><a href="dettaglioMisura.do?idMisura=${utl:encryptData(misura.id)}" target="_blank">${misura.id}</a></td>

<td>
<c:if test="${not empty misura.dataMisura}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${misura.dataMisura}" />
</c:if></td>
<td>${misura.strumento.denominazione}</td>
<td>${misura.strumento.codice_interno}</td>
<td>${misura.statoRicezione.nome}</td>
<td align="center">			
	<span class="label bigLabelTable <c:if test="${misura.obsoleto == 'S'}">label-danger</c:if><c:if test="${misura.obsoleto == 'N'}">label-success </c:if>">${misura.obsoleto}</span> </td>
</td>
<td align="center">			
 <c:set var = "certificato" value = '${arrCartificati[""+misura.id]}'/>

<c:forEach var="entry" items="${arrCartificati}">
<c:if test="${entry.key eq misura.id}">

  	<c:set var="certificato" value="${entry.value}"/>
  	<c:if test="${certificato.stato.id == 2}">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
		<a  target="_blank" class="btn btn-primary customTooltip" title="Click per scaricare il PDF dell'etichetta"  href="scaricaEtichetta.do?action=stampaEtichetta&idMisura=${utl:encryptData(misura.id)}" ><i class="fa fa-print"></i></a>
	</c:if>
</c:if>
</c:forEach>

</td>
<td>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="scaricaCertificato.do?action=download_allegato&id_misura=${utl:encryptData(misura.id)}" ><i class="fa fa-file-pdf-o"></i></a>
</c:if>
<a class="btn btn-primary customTooltip" title="Click per allegare un Pdf" onClick="modalAllegati('${misura.intervento.nomePack}','${misura.id }','${misura.note_allegato}')" ><i class="fa fa-arrow-up"></i></a>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a class="btn btn-danger customTooltip" title="Click per eliminare l'allegato" onClick="eliminaAllegato('${misura.id}','${misura.strumento.__id }','fromModal')" ><i class="fa fa-trash"></i></a>
</c:if>
</td>
<td>${misura.note_allegato }</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  

</div>
</div>
           
<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onClick="closeModal()"aria-label="Close"><span aria-hidden="true">&times;</span></button>
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

<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>



  <script type="text/javascript">
  
  
  function modalAllegati(pack,id_misura, note){
	  $('#myModalAllegati').modal();
	  $('#id_misura').val(id_misura);
	  $('#pack').val(pack);
	  $('#note_allegato').html(note);
  }
  
  
	$("#fileupload_pdf").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_pdf')[0].files[0].name;
       	 $('#filename_label').html(file );
        }
        
		
	});

	var columsDatatables = [];
	 
	$("#tabMisure").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabMisure thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabMisure thead th').eq( $(this).index() ).text();
	        if($(this).index()!= 0){
	        	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	    } );

	} );

	
	function validateAllegati(){
		var filename = $('#fileupload_pdf').val();
		//var filename = $('#fileupload_pdf')[0].files[0].name;
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegati("fromModal");
		}
	}
  
    $(document).ready(function() {
    

    	console.log("test");

    	tableMisure = $('#tabMisure').DataTable({
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
  	    stateSave: false,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 1 },
  	                   { responsivePriority: 2, targets: 2 },
  	                 	{ responsivePriority: 3, targets: 7 },
  	                   { responsivePriority: 4, targets: 3 }
  	                
  	                  
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
    	
    	tableMisure.buttons().container().appendTo( '#tabMisure_wrapper .col-sm-6:eq(1)');
 
     	    
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
	tableMisure = $('#tabMisure').DataTable();
  // Apply the search
   tableMisure.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableMisure.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableMisure
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } );  
  tableMisure.columns.adjust().draw();
    	
	
	$('#tabMisure').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });

    function closeModal(){
    	$('#myModalAllegati').modal('hide');
    }
    
  </script>


  
 
