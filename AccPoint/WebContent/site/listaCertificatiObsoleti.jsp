<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");


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
      <h1>
        Lista Certificati in lavorazione
        <small></small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          <div class="col-xs-12">
          <button class="btn btn-info <c:if test="${action == 'tutti'}">active</c:if>" onclick="callAction('listaCertificati.do?action=tutti');">Tutti</button>
          <button class="btn btn-info <c:if test="${action == 'lavorazione'}">active</c:if>" onclick="callAction('listaCertificati.do?action=lavorazione');">In lavorazione</button>
          <button class="btn btn-info <c:if test="${action == 'chiusi'}">active</c:if>" onclick="callAction('listaCertificati.do?action=chiusi');">Chiusi</button>
          <button class="btn btn-info <c:if test="${action == 'annullati'}">active</c:if>" onclick="callAction('listaCertificati.do?action=annullati');">Annullati</button>
           <button class="btn btn-info <c:if test="${action == 'obsoleti'}">active</c:if>" onclick="callAction('listaCertificati.do?action=obsoleti');">Obsoleti in Misura</button>
         </div>

         <div class="col-xs-12" id="apporvaSelectedButtonGroup">
            <button id="approvaSelected" class="btn btn-success">Genera Selezionati</button>
            <button id="annullaSelected" class="btn btn-danger">Annulla Selezionati</button>
         </div>
          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
  <th><input id="selectAlltabPM" type="checkbox" /></th>
   <th>ID Certificato</th>
  <th>Commessa</th>
  <th>Strumento</th>
  <th>Matricola | Cod</th>
 <th>Cliente</th>
 <th>Presso</th>
 <th>Data Misura</th>
   <th>Obsoleta</th>
    <th>Utente</th>
 <th style="min-width:200px">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	<td></td>
		<td></td>
	<td>${certificato.id}</td>
	
 		<td>${certificato.misura.intervento.idCommessa}</td>
		<td>${certificato.misura.strumento.denominazione}</td>
		<td>${certificato.misura.strumento.matricola} | ${certificato.misura.strumento.codice_interno}</td>
		<td>${certificato.misura.intervento.nome_sede}</td>
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
 				
 		


<td>${certificato.utente.nominativo}</td>

		<td class="actionClass" align="center" style="min-width:200px">
		<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio delle Misure"  href="dettaglioMisura.do?idMisura=${certificato.misura.id}" ><i class="fa fa-tachometer"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"  href="#" onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
				<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}"  href="#" onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a>
			
			<button class="btn btn-success  customTooltip" title="Click per generare il Certificato" onClick="creaCertificato(${certificato.id})"><i class="fa fa-check"></i></button>
			<button class="btn btn-danger  customTooltip" title="Click per anullare il Certificato" onClick="annullaCertificato(${certificato.id})"><i class="fa fa-close"></i></button>
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
                  <b>N� Strumenti Genenerati</b> <a class="pull-right">${intervento.nStrumentiGenerati}</a>
                </li>

                <li class="list-group-item">
                  <b>N� Strumenti Misurati</b> <a class="pull-right">

  					 ${intervento.nStrumentiMisurati}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N� Strumenti Nuovi Inseriti</b> <a class="pull-right">${intervento.nStrumentiNuovi}</a>
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
                  <b>N� Strumenti Misurati</b> <a class="pull-right">

  					 ${interventoDati.numStrMis}


				</a>
                </li>
                <li class="list-group-item">
                  <b>N� Strumenti Nuovi Inseriti</b> <a class="pull-right">${interventoDati.numStrNuovi}</a>
                </li>
                
                
        	</ul>





  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div>
	 
	 
	</c:forEach>


  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">

	var listaStrumenti = '${listaCampioniJson}';

   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	

    	table = $('#tabPM').DataTable({
    	
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      order: [[ 2, "desc" ]],
  	    select: {
        	style:    'multi+shift',
        	selector: 'td:nth-child(2)'
    	},
  	      columnDefs: [
						  
  	                 { targets: 0,  orderable: false },
  	                 { className: "select-checkbox", targets: 1,  orderable: false },
					 { responsivePriority: 1, targets: 2 },
  	                 { responsivePriority: 3, targets: 3 },
  	                 { responsivePriority: 4, targets: 4 },
  	                	{ responsivePriority: 2, targets: 11 },
  	              	{ responsivePriority: 5, targets: 5 },
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

  
  $('#tabPM thead th').each( function () {
      

      if( $(this).index() == 2 || $(this).index() == 3 || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 9){
    	      var title = $('#tabPM thead th').eq( $(this).index() ).text();
        	$(this).append( '<div><input class="inputsearchtable" type="text" /></div>');
        }else if($(this).index() != 0 && $(this).index() != 1  ){
          	$(this).append( '<div style="height:34px"><input class="inputsearchtable" type="text" disabled /></div>');
        }
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
  
  var column = table.column( 6 );
	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );

	$('<div id="selectSearchTop"> </div>').appendTo( "#tabPM_length" );
  var select = $('<select class="select2" style="width:370px"><option value="">Seleziona un Cliente</option></select>')
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
  
  $('.select2').select2();
  	table.columns.adjust().draw();
    	
    	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});
    	

  	$('input').on('ifChecked', function(event){
  		
    		   table.rows().select();
    	  
  	});
  	$('input').on('ifUnchecked', function(event){
  		
    		 table.rows().deselect();
    	  
  	});
 
  	$("#approvaSelected").click(function(){
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
    });


  </script>
</jsp:attribute> 
</t:layout>
  
 