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
	


  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
  <%-- <th><input id="selectAlltabPM" type="checkbox" /></th> --%>
   <th>ID Certificato</th>
  <th>Commessa</th>
  <th>Strumento</th>
  <th>Matricola | Cod</th>
 <th>Cliente</th>
 <th>Presso</th>
 <th>Data Misura</th>
   <th>Obsoleta</th>
    <th>Operatore</th>
    <th>Numero certificato</th>
 <th style="min-width:200px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	<td></td>
		<%-- <td></td> --%>
	<td>${certificato.id}</td>
	
 		<td>${certificato.misura.intervento.idCommessa}</td>
		<td>${certificato.misura.strumento.denominazione}</td>
		<td>${certificato.misura.strumento.matricola} | ${certificato.misura.strumento.codice_interno}</td>
		<td>${certificato.misura.intervento.nome_cliente} - ${certificato.misura.intervento.nome_sede}</td>
		<td> 
		
		<c:choose>
  <c:when test="${certificato.misura.intervento.pressoDestinatario == 0}">
		<span class="label label-success">IN SEDE</span>
  </c:when>
  <c:when test="${certificato.misura.intervento.pressoDestinatario == 1}">
		<span class="label label-info">PRESSO CLIENTE</span>
  </c:when>
   <c:when test="${certificato.misura.intervento.pressoDestinatario == 2}">
		<span class="label label-warning">MISTO CLIENTE - SEDE</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
		
		</td>

		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataMisura}" /></td>
						<td align="center"> 
			<span class="label bigLabelTable <c:if test="${certificato.misura.obsoleto == 'S'}">label-danger</c:if><c:if test="${certificato.misura.obsoleto == 'N'}">label-success </c:if>">${certificato.misura.obsoleto}</span> </td>
 				
 		


<td>${certificato.misura.interventoDati.utente.nominativo}</td>
<td>${certificato.misura.nCertificato}</td>
		<td class="actionClass" align="center" style="min-width:200px">
		<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio delle Misure"  href="dettaglioMisura.do?idMisura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"   onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}"   onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a>
			
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaCertificato(${certificato.id})"><i class="fa fa-check"></i></button>
			<button class="btn btn-danger  customTooltip" title="Click per anullare il Certificato" onClick="annullaCertificato(${certificato.id})"><i class="fa fa-close"></i></button>
		</td>
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table>  


<c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">
	      
	    <c:set var = "intervento" scope = "session" value = "${certificato.misura.intervento}"/>
	 	<c:set var = "interventoDati" scope = "session" value = "${certificato.misura.interventoDati}"/>
	 
	 <div id="interventiModal${loop.index}" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="interventoModalTitle">Dettaglio Intervento</h4>
      </div>
       <div class="modal-body" id="interventoModalLabelContent">


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
                  <b>Responsabile</b> <a class="pull-right">${intervento.user.nominativo}</a>
                </li>
                
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





  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
	 
<div id="interventiDatiModal${loop.index}" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="interventoModalTitle">Dettaglio Intervento Dati</h4>
      </div>
       <div class="modal-body" id="interventoModalLabelContent">


			<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>Data Caricamento</b> <a class="pull-right">
                  <c:if test="${not empty interventoDati.dataCreazione}">
   					<fmt:formatDate pattern="dd/MM/yyyy" value="${interventoDati.dataCreazione}" />
					</c:if></a>
                </li>
               
                <li class="list-group-item">
                  <b>Nome Pasck</b> <a class="pull-right">${interventoDati.nomePack}</a>
                </li>
               

                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">

   						 <span class="label label-info">${interventoDati.stato.descrizione}</span>


				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right">${interventoDati.utente.nominativo}</a>
                </li>
                
            
                <li class="list-group-item">
                  <b>N° Strumenti Misurati</b> <a class="pull-right">

  					 ${interventoDati.numStrMis}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N° Strumenti Nuovi Inseriti</b> <a class="pull-right">${interventoDati.numStrNuovi}</a>
                </li>
                
                
        	</ul>





  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
	 
	 
	</c:forEach>





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
	        if($(this).index() == 1 || $(this).index() == 2 || $(this).index() == 3 || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 8 || $(this).index() == 9 || $(this).index() == 10){
	      	      var title = $('#tabPM thead th').eq( $(this).index() ).text();
	          	$(this).append( '<div><input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	          }else if($(this).index() != 0   ){
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
  	    stateSave: true,
  	      order: [[ 1, "desc" ]],
  	    select: {
        	style:    'multi+shift',
        	selector: 'td:nth-child(2)'
    	},
  	      columnDefs: [
						  

	                 { targets: 0,  orderable: false },
  	                 //{ className: "select-checkbox", targets: 1,  orderable: false },
					 { responsivePriority: 1, targets: 1 },
					{ responsivePriority: 2, targets: 11 },
  	                 { responsivePriority: 3, targets: 2 },
  	                 { responsivePriority: 4, targets: 3 },
  	              	{ responsivePriority: 5, targets: 4},
  	              { responsivePriority: 6, targets: 7 },
  	            { responsivePriority: 7, targets: 9 }
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
     			callAction('listaCertificati.do?action=lavorazione');
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
    	


 
  	/* $("#approvaSelected").click(function(){
  	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
  		var dataSelected = table.rows( { selected: true } ).data();
  		var selezionati = {
  			    ids: []
  			};
  		for(i=0; i< dataSelected.length; i++){
  			dataSelected[i];
  			selezionati.ids.push(dataSelected[i][2]);
  		}
  		
  		approvaCertificatiMulti(selezionati);
  		
  	});
	$("#annullaSelected").click(function(){
		  pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
		var dataSelected = table.rows( { selected: true } ).data();
		var selezionati = {
  			    ids: []
  			};
  		for(i=0; i< dataSelected.length; i++){
  			dataSelected[i];
  			selezionati.ids.push(dataSelected[i][2]);
  		}
  		
  		annullaCertificatiMulti(selezionati);
  	});
    
 */
    });
  </script>


 
