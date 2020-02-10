<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th>Id Certificato</th>
   <th>Commessa</th>
     <th>Strumento</th>
  <th>Matricola</th>
 <th>Cliente</th>
 <th> Presso</th>
<th>Obsoleta</th>
 <th>Data Misura</th>

 <th>Data Creazione Certificato</th> 
  <th>Stato</th>
   <th>Operatore</th>
   <!-- <th>Numero certificato</th> -->
 	<th style="min-width:160px">Azioni</th> 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	
	<td>${certificato.id}</td>


		<td>${certificato.misura.verIntervento.commessa}</td>
		<td>${certificato.misura.verStrumento.denominazione}</td>
		<td>${certificato.misura.verStrumento.matricola}</td>
		
		<td>${certificato.misura.verIntervento.nome_cliente} - ${certificato.misura.verIntervento.nome_sede}</td>
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
		<td><span class="label bigLabelTable <c:if test="${certificato.misura.obsoleta == 'S'}">label-danger</c:if><c:if test="${certificato.misura.obsoleta == 'N'}">label-success </c:if>">${certificato.misura.obsoleta}</span> </td>
	
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataVerificazione}" /></td>
		
		<td>
			<c:if test="${certificato.stato.id == 2}">
				<fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.dataCreazione}" />
			</c:if>
		
		</td>
		
			
	<td align="center"> 
			<span class="label <c:if test="${certificato.stato.id == 1}">label-warning</c:if><c:if test="${certificato.stato.id == '3'}">label-danger </c:if><c:if test="${certificato.stato.id == '2'}">label-success </c:if>">${certificato.stato.descrizione}</span> </td>
		

	<td>${certificato.misura.tecnicoVerificatore.nominativo}</td>
	<%-- <td>${certificato.misura.nCertificato}</td> --%>
	<td class="actionClass"  style="min-width:160px" align="center">
			<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della Misura"  href="gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
			<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'intervento"  href="gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(certificato.misura.verIntervento.id)}" ><i class="fa fa-file-text-o"></i></a>
			<c:if test="${certificato.stato.id==1 && certificato.misura.obsoleta=='N'}">
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaVerCertificato('${utl:encryptData(certificato.misura.id)}')"><i class="fa fa-check"></i></button>
			</c:if>
			<c:if test="${certificato.stato.id==2 && certificato.misura.obsoleta=='N'}">
			 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="gestioneVerCertificati.do?action=download&&cert_rap=0&id_certificato=${utl:encryptData(certificato.id)}" ><i class="fa fa-file-pdf-o"></i></a>
			</c:if>
<%-- 				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio delle Misure"  href="dettaglioMisura.do?idMisura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"  onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}"  onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a>
			<c:if test="${certificato.stato.id == 2}">	
				<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(certificato.misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
			</c:if>
 			
 --%>
		</td>
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table>  
 
 
 
	
	
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


<script type="text/javascript">
	var listaStrumenti = '${listaCampioniJson}';

   </script>

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
	  	  if( $(this).index() == 0 || $(this).index() == 1 || $(this).index() == 2 || $(this).index() == 3  || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 8 || $(this).index() == 9 || $(this).index() == 10 || $(this).index() == 11){
	  		      var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	  	  }else{
	  		  
	  		  $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" disabled/></div>');
	  	  }
	  	  
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
  	      order: [[ 0, "desc" ]],

  	      columnDefs: [
  
  	                 { responsivePriority: 1, targets: 0 },
  	                	{ responsivePriority: 2, targets: 11 },
  	                { responsivePriority: 3, targets: 1 },
  	                { responsivePriority: 4, targets: 10 },
  	               	{ responsivePriority: 5, targets: 7},
  	              	{ responsivePriority: 6, targets: 9 }
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
 
  	                         
  	          ]
  	    	
  	      
  	    });
    	

    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
	    
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
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
  
	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
  	
  
  var column = table.column( 1 );
  
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


 
    });


  </script>
 