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

	     		 <input style="display:none" type="password" name="fakepasswordremembered"/>
<!-- 	<div class="row padding-bottom-30" >
	     <div class="col-xs-12" id="apporvaSelectedButtonGroup">
            <button id="generaSelected" class="btn btn-success">Genera Selezionati</button>
            <form id="certificatiMulti" method="POST"><input type='hidden' id="dataInExport" name='dataIn' value=''></form>
          </div>
	  </div> -->
	<div class="row" >
	     <div class="col-xs-12" id="apporvaSelectedButtonGroup">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <%-- <th></th> --%>
 <th>Id Cetificato</th>
   <th>Commessa</th>
  <th>Strumento</th>
  <th>Matricola</th>
 <th>Cliente</th>
 <th>Presso</th>
  <th>Data Creazione Certificato</th>

 <th>Data Misura</th>
   
    <th>Operatore</th>
    <%-- <th>Numero certificato</th> --%>
 <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCertificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	<td></td>
		<%-- <td></td> --%>
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
			<td>
				<fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.dataCreazione}" />
		
		</td>	
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataVerificazione}" /></td>
				
				

	
 		
 		
	<td>${certificato.misura.tecnicoVerificatore.nominativo}</td>
	<%-- <td>${certificato.misura.nCertificato}</td> --%>
		<td class="actionClass" align="center" style="min-width:250px">
			 <a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della Misura"  href="gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(certificato.misura.id)}" ><i class="fa fa-tachometer"></i></a>
			 <a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'intervento"  href="gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(certificato.misura.verIntervento.id)}" ><i class="fa fa-file-text-o"></i></a>
			 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="gestioneVerCertificati.do?action=download&&cert_rap=0&id_certificato=${utl:encryptData(certificato.id)}" ><i class="fa fa-file-pdf-o"></i></a>
			<%--<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento Dati"   onClick="openDettaglioInterventoModal('interventoDati',${loop.index})"><i class="fa fa-search"></i></a>
			<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio dell'Intervento ${certificato.misura.intervento.nomePack}" onClick="openDettaglioInterventoModal('intervento',${loop.index})"><i class="fa fa-file-text-o"></i>  </a>
			
			<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(certificato.misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
			<c:if test="${certificato.firmato}">
			<a  target="_blank" class="btn btn-success customTooltip" title="Click per scaricare il p7m del Certificato"  href="scaricaCertificato.do?action=certificatoStrumentoFirmato&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(certificato.misura.intervento.nomePack)}" ><i class="fa fa-file-zip-o"></i></a>
			</c:if>
			
			<a class="btn btn-danger customTooltip" title="Click per ristampare l'etichetta" href="stampaEtichetta.do?idCertificato=${certificato.id}"><i class="fa fa-print"></i></a>
			
			<a class="btn btn-info customTooltip" title="Click per inviare il certificato per e-mail"onClick="inviaEmailCertificato(${certificato.id})"><i class="fa fa-paper-plane-o"></i></a>

			<c:if test="${userObj.idFirma != null && userObj.idFirma != ''}">
			<c:if test="${abilitato_firma==true && !certificato.firmato}">
				<a class="btn btn-warning customTooltip" title="Click per firmare il certificato con firma digitale" href="#" onClick="firmaCertificato(${certificato.id})"><i class="fa fa-pencil"></i></a>
				<a class="btn btn-warning customTooltip" title="Click per firmare il certificato con firma digitale" href="#" onClick="openModalPin(${certificato.id})"><i class="fa fa-pencil"></i></a>
			</c:if> --%>
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

  <script type="text/javascript">
  var pin0;
  var id_certificato;
  function openModalPin(id){	
		$('#result_label').hide();
		$('#pin').css('border', '1px solid #d2d6de');
		$('#pin').val("");
	  id_certificato = id;
	  if(pin0!="0000"){
		  $('#modalPin').modal();
	  }else{
		  $('#modalModificaPin').modal();
	  }
	}
  
  
  function checkNuovoPIN(){
		$('#result_label_nuovo').hide();
		var nuovo_pin = $('#nuovo_pin').val();
		var confPin = $('#conferma_pin').val();

		$('#nuovo_pin').css('border', '1px solid #d2d6de');
		$('#conferma_pin').css('border', '1px solid #d2d6de');


		if(isNaN(nuovo_pin)){
			$('#result_label_nuovo').html("Attenzione! Il PIN deve essere un numero!");
			$('#nuovo_pin').css('border', '1px solid #f00');
			$('#result_label_nuovo').css("color", "red");
			$('#result_label_nuovo').show();
		}	
		else if(nuovo_pin.length!=4){
			$('#result_label_nuovo').html("Attenzione! Il PIN deve essere di 4 caratteri!");
			$('#result_label_nuovo').css("color", "red");
			$('#nuovo_pin').css('border', '1px solid #f00');
			$('#result_label_nuovo').show();
		}
		
		else if(nuovo_pin!=confPin){
			$('#result_label_nuovo').html("Attenzione! Conferma PIN fallita!");
			$('#result_label_nuovo').css("color", "red");
			$('#conferma_pin').css('border', '1px solid #f00');
			$('#result_label_nuovo').show();
		}
		else if(nuovo_pin =="0000"){
			$('#result_label_nuovo').html("Attenzione! Il PIN non pu� essere 0000");
			$('#nuovo_pin').css('border', '1px solid #f00');
			$('#result_label_nuovo').css("color", "red");
			$('#result_label_nuovo').show();
		}
		else{
			modificaPinFirma(nuovo_pin, null);
			
		}
	}


	function checkPIN(){
		$('#result_label').hide();
		var pin = $('#pin').val();
		$('#pin').css('border', '1px solid #d2d6de');
		
		if(isNaN(pin)){
			$('#result_label').html("Attenzione! Il PIN deve essere un numero!");
			$('#result_label').css("color", "red");
			$('#pin').css('border', '1px solid #f00');
			$('#result_label').show();
		}
		else if(pin.length!=4){
			$('#result_label').html("Attenzione! Il PIN deve essere di 4 cifre!");
			$('#result_label').css("color", "red");
			$('#pin').css('border', '1px solid #f00');
			$('#result_label').show();
		}	
		else{
			$('#modalPin').modal('toggle');
			firmaCertificato(pin, id_certificato);
			$('#pin').val("");
		}
		
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
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        
	        if( $(this).index() != 0){
	        	$(this).append( '<div><input class="inputsearchtable" type="text" value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	     	
	     	/*  if( $(this).index() == 2 || $(this).index() == 3 || $(this).index() == 4 || $(this).index() == 5 || $(this).index() == 6 || $(this).index() == 7 || $(this).index() == 8 || $(this).index() == 9 || $(this).index() == 11 || $(this).index() == 12){
	            var title = $('#tabPM thead th').eq( $(this).index() ).text();
	      	  	 
	      	   	$(this).append( '<div><input class="inputsearchtable" type="text" value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	       
	        }else if( $(this).index() != 0 && $(this).index() != 1){
	      	  	$(this).append( '<div><input class="inputsearchtable" type="text" disabled /></div>');
	        }else	if($(this).index() == 1){
	          	  	$(this).append( '<div><input class="" id="checkAll" type="checkbox" /></div>');
	            } */
	        
	    } );

	} );

  
    $(document).ready(function() {
    
    
    	var maxSelect = 100;

    	pin0 = "${userObj.getPin_firma()}";

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
  	    select: {
        	style:    'multi+shift',
        	selector: 'td:nth-child(2)'
    	},
  	      order: [[ 1, "desc" ]],
   	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
						  /*   { className: "select-checkbox", targets: 1,  orderable: false }, */
  	                   { responsivePriority: 3, targets: 7 },
  	                   { responsivePriority: 4, targets: 2 },
  	                 { responsivePriority: 5, targets: 1 },
  	                 { responsivePriority: 2, targets: 10 },
  	               { responsivePriority: 6, targets: 4 },
  	             { responsivePriority: 7, targets: 5 },
  	           { responsivePriority: 8, targets: 3 },
  	         { responsivePriority: 9, targets: 9 }
  	       
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

     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	});
     	 $('#myModalError').on('hidden.bs.modal', function (e) {
     		 if($('#myModalError').hasClass('modal-success')){
     			//callAction('listaCertificati.do?action=lavorazione');
     			filtraCertificati();
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

	
 	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
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
    	
  	table.columns.adjust().draw();

  	table.on( 'select', function ( e, dt, type, ix ) {
  	   var selected = dt.rows({selected: true});
  	   if ( selected.count() > maxSelect ) {
  	      dt.rows(ix).deselect();
  		$('#myModalErrorContent').html("Non � consentito selezionare pi� di "+maxSelect+" elementi");
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");
		$('#myModalError').modal('show');

  	   }
  	} );
  	
	$("#generaSelected").click(function(){
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
	  		console.log(selezionati);
	  		table.rows().deselect();
	  		generaCertificatiMulti(selezionati);
	  		
	  	});
	//$("#checkAll").click(function(){
		$('#checkAll').on('ifClicked', function (ev) {
		
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();
	
			
		if(!$("#checkAll").is( ':checked' )){
			var count = table.rows()[0].length;
			var realCount = 0;
			table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ){
    			realCount++;
			}, true);
			
			if (realCount == count) {
				
			
				$('#myModalErrorContent').html("Verranno selezionati solo i primi "+maxSelect+" elementi");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-warning");
				$('#myModalError').modal('show');
				
			}
			
			 table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect(); 
			i = 0;
			table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
			    if(i	<maxSelect){
					 this.select();
			    }else{
			    		//exit();
			    		
			    }
			    i++;
			    
			} );
			$("#checkAll").iCheck('check')
		}else{
			table.rows().deselect();
			$("#checkAll").iCheck('uncheck')
		}
		
		
	  	});
	  $('#checkAll').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	
    });
	
	
    


  </script>


 