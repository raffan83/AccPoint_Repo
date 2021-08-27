<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");


	%>
 	<div class="row padding-bottom-30" >
	     <div class="col-xs-12" id="apporvaSelectedButtonGroup">
            <button id="approvaSelected" class="btn btn-success" onClick="generaSelezionati()">Genera Selezionati</button>
            
         </div>
	  </div> 
	<div class="row" >
	     <div class="col-xs-12" >
	     
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
  <th><input id="selectAlltabPM" type="checkbox" /></th>
   <th>ID Certificato</th>
  <th>Commessa</th>
  <th>Strumento</th>
  <th>Matricola</th>
 <%-- <th>Cliente</th> --%>
 <th>Presso</th>
 <th>Data Misura</th>   
    <th>Operatore</th>
    <%-- <th>Numero certificato</th> --%>
 <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	<td></td>
		<td></td>
	<td>${certificato.id}</td>
	
 		<td>${certificato.misura.verIntervento.commessa}</td>
		<td>${certificato.misura.verStrumento.denominazione}</td>
		<td>${certificato.misura.verStrumento.matricola} </td>
		<%-- <td>${certificato.misura.verIntervento.nome_cliente} - ${certificato.misura.verIntervento.nome_sede}</td> --%>
		<td> 
		
		<c:choose>
  <c:when test="${certificato.misura.verIntervento.in_sede_cliente == 0}">
		<span class="label label-success">IN SEDE</span>
  </c:when>
  <c:when test="${certificato.misura.verIntervento.in_sede_cliente == 1}">
		<span class="label label-info">PRESSO CLIENTE</span>
  </c:when>
   <c:when test="${certificato.misura.verIntervento.in_sede_cliente == 2}">
		<span class="label label-warning">ALTRO LUOGO</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
		
		</td>

		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataVerificazione}" /></td>
						

<td>${certificato.misura.tecnicoVerificatore.nominativo}</td>
<%-- <td>${certificato.misura.nCertificato}</td> --%>
		<td class="actionClass" align="center" style="min-width:200px">
		 <a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della Misura"  href="gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
		 <a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'intervento"  href="gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(certificato.misura.verIntervento.id)}" ><i class="fa fa-file-text-o"></i></a>
				<%-- <a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"  onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}"   onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a> --%>
		
		 <button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaVerCertificato('${utl:encryptData(certificato.misura.id)}')"><i class="fa fa-check"></i></button>
		 
		 

		 
			<%-- <button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaVerCertificato('${utl:encryptData(certificato.misura.id)}')"><i class="fa fa-check"></i></button> --%>
			
			 
		</td>
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table>  
   </div>
	  </div>




<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">

	var listaStrumenti = '${listaCampioniJson}';

   </script>
   
   <script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>

  <script type="text/javascript">
  
  

  
  
  
  function generaSelezionati(){
	  
		var dataSelected = table.rows( { selected: true } ).data();
  		var selezionati = {
  			    ids: [],  			    
  			};
  		for(i=0; i< dataSelected.length; i++){
  			dataSelected[i];
  			selezionati.ids.push(dataSelected[i][2]);
  		}
  		
  		generaVerCertificatiMulti(selezionati);
	  
  }
  
  
  function modalRiemissione(){
	  

	  	 dataString ="action=certificati_emessi_riemissione&id_intervento="+ id_intervento;
	     exploreModal("listaCertificati.do",dataString,"#tab_riemissione",function(datab,textStatusb){
	    	 
	    	 
	    	 
	     });
	  $('#myModalAllegati').modal();
	  
  }

  
  
  function openModalLoadFile(id_certificato){
	  
	  $('#modalLoadFile').modal();
	  
	  $('#fileupload').fileupload({
			 url: "listaCertificati.do?action=livella_bolla&idCertificato="+id_certificato,
			 dataType: 'json',	 
			 getNumberOfFiles: function () {
			     return this.filesContainer.children()
			         .not('.processing').length;
			 }, 
			 start: function(e){
			 	pleaseWaitDiv = $('#pleaseWaitDialog');
			 	pleaseWaitDiv.modal();
			 	
			 },
			 singleFileUploads: false,
			  add: function(e, data) {
			     var uploadErrors = [];
			     var acceptFileTypes = /(\.|\/)(jpg|jpeg|png)$/i;
			   
			     for(var i =0; i< data.originalFiles.length; i++){
			    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
				         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
				         break;
				     }	 
			    	 if(data.originalFiles[i]['size'] > 30000000) {
				         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 30mb');
				         break;
				     }
			     }	     		     
			     if(uploadErrors.length > 0) {
			     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
			 			$('#myModalError').removeClass();
			 			$('#myModalError').addClass("modal modal-danger");
			 			$('#myModalError').modal('show');
			     } 
			     else {
			         data.submit();
			     }  
			 },
			
			 done: function (e, data) {
			 		
			 	pleaseWaitDiv.modal('hide');
			 	
			 	if(data.result.success){
			 		$('#myModalAllegatiArchivio').modal('hide');
			 		$('#myModalErrorContent').html(data.result.messaggio);
		 			$('#myModalError').removeClass();
		 			$('#myModalError').addClass("modal modal-success");
		 			$('#myModalError').modal('show');
			 	}else{		 			
			 			$('#myModalErrorContent').html(data.result.messaggio);
			 			$('#myModalError').removeClass();
			 			$('#myModalError').addClass("modal modal-danger");
			 			$('#report_button').show();
			 			$('#visualizza_report').show();
			 			$('#myModalError').modal('show');
			 		}
			 },
			 fail: function (e, data) {
			 	pleaseWaitDiv.modal('hide');

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
		 });		
	  
  }

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

	        if( $(this).index() == 2 || $(this).index() == 3 || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 8 || $(this).index() == 10 || $(this).index() == 11){
	      	      var title = $('#tabPM thead th').eq( $(this).index() ).text();
	          	$(this).append( '<div><input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	          }else if($(this).index() != 0 && $(this).index() != 1  ){
	            	$(this).append( '<div style="height:34px"><input class="inputsearchtable" type="text" disabled /></div>');
	          }
	    } );
	} );
 
    $(document).ready(function() {
    
    	
    	table = $('#tabPM').DataTable({
    		pageLength: 100,
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
   	      order: [[ 2, "desc" ]],
   	   stateSave: true,
  	    select: {
        	style:    'multi+shift',
        	selector: 'td:nth-child(2)'
    	},
  	      columnDefs: [
						  
  	                 { targets: 0,  orderable: false },
  	                 { className: "select-checkbox", targets: 1,  orderable: false },
  	               { responsivePriority: 1, targets: 0 },
  	             { responsivePriority: 2, targets: 1 },
 	                { responsivePriority: 3, targets: 7 },
	                { responsivePriority: 4, targets: 2 },
	             	{ responsivePriority: 5, targets: 9 },
	               	{ responsivePriority: 6, targets: 4 },
	               	{ responsivePriority: 7, targets: 5 },
	               	{ responsivePriority: 8, targets: 6 },
	              	{ responsivePriority: 9, targets: 8 }
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 exportOptions: {
                         rows: { selected: true }
                     }
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 exportOptions: {
                         rows: { selected: true }
                     }
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	             
  	          ],
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
  	        }
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
 
     	    
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	
     	});
     	 $('#myModalError').on('hidden.bs.modal', function (e) {
     		 if($('#myModalError').hasClass('modal-success')){
     			filtraVerCertificati();
     			
     		 }
     		
       	  	
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
  
  var column = table.column( 3 );
  
	$('<div id="selectSearchTop"> </div>').appendTo( "#tabPM_length" );
	  var select = $('<select class="select2" style="width:370px"><option value="">Seleziona una Commessa</option></select>')
	      .appendTo( "#selectSearchTop" )
	      .on( 'change', function () {
	          var val = $.fn.dataTable.util.escapeRegex(
	              $(this).val()
	          );

	       column
	              .search( val ? '^'+val+'$' : '', true, false )
	              .draw();
	      } );
	  column.data().unique().sort().each( function ( d, j ) {
	      select.append( '<option value="'+d+'">'+d+'</option>' )
	  } );
	  
	 $(".select2").select2();
	 
	 
  	table.columns.adjust().draw();
    	
    	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});
    	

  	$('input').on('ifChecked', function(event){  		
  		
    		   //table.rows().select();
    		   table.rows({ filter : 'applied'}).select();
    		      	  
  	});
  	$('input').on('ifUnchecked', function(event){
  		
    		 table.rows().deselect();
    	  
  	});
 


	
	  $('#selectAlltabPM').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	
	  
	  

	
    });

	
    $('#myModalError').on('hidden.bs.modal', function(){
    	 $('.modal-backdrop').hide();
    });
    
  </script>


 
