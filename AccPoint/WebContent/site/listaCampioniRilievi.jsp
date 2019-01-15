<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- <%@taglib prefix="t" tagdir="/WEB-INF/tags"%> --%>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	ArrayList<CampioneDTO> listaCampioniarr =(ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");



	Gson gson = new Gson();
	JsonArray listaCampioniJson = gson.toJsonTree(listaCampioniarr).getAsJsonArray();
	request.setAttribute("listaCampioniJson", listaCampioniJson);
	request.setAttribute("utente", utente);
	
	%>
	
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
<!-- <form id="certCampioniMulti" method="POST"><input type='hidden' id="dataInExport" name='dataIn' value=''></form> -->
  <table id="tabCampioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th style="max-width:65px"></th>
 <th>ID</th>
 <th>Proprietario</th>
 <th>Codice</th>
 <th>Nome</th>
 <th>Tipo Campione</th>
  <th>Utilizzatore</th>
 <th>Costruttore</th>
 <th>Descrizione</th>
 <th>Data Verifica</th>
 <th>Data Scadenza</th>
 <th>Stato</th>
 <th>Distributore</th>
 <th>Data Acquisto</th>
 <th>Campo di Accettabilità</th>
 <th>Attività Di Taratura</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCampioni}" var="campione" varStatus="loop">

	 <tr role="row" id="${campione.codice}-${loop.index}">
	 <td></td>
	<%-- <td><input type="checkbox" id="campione_${loop.index}"/></td> --%>
	<td></td>
	<td>${campione.id}</td>
	<td>${campione.company.denominazione}</td>
	<td>${campione.codice}</td>
	<td>${campione.nome}</td>
	<td>${campione.tipo_campione.nome}</td>
	<td>${campione.company_utilizzatore.denominazione}</td>	
	<td>${campione.costruttore}</td>
	<td>${campione.descrizione}</td>

<td>
<c:if test="${not empty campione.dataVerifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataVerifica}" />
</c:if></td>
<td>
<c:if test="${not empty campione.dataScadenza}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataScadenza}" />
</c:if></td>
<td align="center"> 
			<c:if test="${campione.statoCampione == 'N'}">
				<span class="label  label-danger">FUORI SERVIZIO</span> 
			</c:if>
			<c:if test="${campione.statoCampione == 'S'}">
				<span class="label  label-success">IN SERVIZIO</span>  
			</c:if>
</td>
<td>${campione.distributore }</td>
<td><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.data_acquisto }" /></td>
<td>${campione.campo_accettabilita }</td>
<td>${campione.attivita_di_taratura }</td>
<!-- <td><a class="btn btn-primary" title="Click per aggiungere il certificato campione" onClick="aggingiCertificato()"><i class="fa fa-plus"></i></a></td> -->
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>


<!--   <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myModal">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Scegli Certificato</h4>
      </div>
       <div class="modal-body">       
      <div id="certificati"></div>
      	</div>
      <div class="modal-footer">
     

      </div>
    </div>
  </div>

</div> -->



<!-- 	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script> -->
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript">

var listaStrumenti = ${listaCampioniJson};

   </script>

  <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabCampioni").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabCampioni thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	      
	        if($(this).index()!=0 && $(this).index()!=1){	
	        	  var title = $('#tabCampioni thead th').eq( $(this).index() -1 ).text();	
      	  /* 	$(this).append( '<input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/>'); */
      	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
        }
        else if($(this).index() == 1){
          	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
            }
	    });

	});
	
/* 	$('#attivita_di_taratura').change(function(){
		var selection = $('#attivita_di_taratura').val();
		
		if(selection==1){
			$('#attivita_di_taratura_text').val("INTERNA");
			$('#attivita_di_taratura_text').attr("readonly", true);
		}else{
			$('#attivita_di_taratura_text').val("");
			$('#attivita_di_taratura_text').attr("readonly", false);
		}
		
	}); */
  
    $(document).ready(function() {    
    	
    	
    console.log("test")
    	var today = new Date();
    	var dd = today.getDate();
    	var mm = today.getMonth()+1; //January is 0!
    	var yyyy = today.getFullYear();

    	if(dd<10) {
    	    dd = '0'+dd;
    	} 

    	if(mm<10) {
    	    mm = '0'+mm;
    	} 

    	today = dd + '/' + mm + '/' + yyyy;
    	$('input[name="datarangecalendar"]').daterangepicker({
    	    locale: {
    	      format: 'DD/MM/YYYY'
    	    },
    	    "minDate": today
    	}, 
    	function(start, end, label) {
    	      /* startDatePicker = start;
    	      endDatePicker = end; */
    	});
    	

    	tabCampioni = $('#tabCampioni').DataTable({
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
	        pageLength: 10,
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
  	      columnDefs: [
  	    	 { className: "select-checkbox", targets: 1,  orderable: false },
  	    	{ responsivePriority: 1, targets: 0 },
  	    	 { responsivePriority: 2, targets: 1 },
			   { responsivePriority: 3, targets: 2 },
                 { responsivePriority: 4, targets: 3 },
                 { responsivePriority: 5, targets: 4 },
                 { responsivePriority: 6, targets: 8 },
               { responsivePriority: 7, targets: 12 }

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
    
    });
	tabCampioni.columns().eq( 0 ).each( function ( colIdx ) {
		  $( 'input', tabCampioni.column( colIdx ).header() ).on( 'keyup', function () {
			  tabCampioni
		          .column( colIdx )
		          .search( this.value )
		          .draw();
		  } );
		} ); 
	tabCampioni.columns.adjust().draw();
	
	maxSelect = 100;
$('#checkAll').on('ifChecked', function (ev) {

	
		
		$('#myModalErrorContent').html("Verranno selezionati solo i primi "+maxSelect+" elementi");
 	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-warning");
		$('#myModalError').modal('show'); 
		
		
			$("#checkAll").prop('checked', true);
			tabCampioni.rows().deselect();
			var allData = tabCampioni.rows({filter: 'applied'});
			table.rows().deselect();
			i = 0;
			tabCampioni.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
			    if(i	<maxSelect){
					 this.select();
			    }else{
			    		tableLoop.exit;
			    }
			    i++;
			    
			} );

	  	});
		$('#checkAll').on('ifUnchecked', function (ev) {

			
				$("#checkAll").prop('checked', false);
				tabCampioni.rows().deselect();
				var allData = table.rows({filter: 'applied'});
				tabCampioni.rows().deselect();

		  	});
			
		
	  $('#checkAll').iCheck({
	      checkboxClass: 'icheckbox_square-blue',
	      radioClass: 'iradio_square-blue',
	      increaseArea: '20%' // optional
	    });
	
	  
	  
		$("#aggiungiCertCampione").unbind().click(function(){
		  	  pleaseWaitDiv = $('#pleaseWaitDialog');
			  pleaseWaitDiv.modal();
		  		var dataSelected = tabCampioni.rows( { selected: true } ).data();
		  		var selezionati = {
		  			    ids: []
		  			};
		  		for(i=0; i< dataSelected.length; i++){
		  			dataSelected[i];
		  			selezionati.ids.push(dataSelected[i][2]);
		  		}
		  		console.log(selezionati);
		  		tabCampioni.rows().deselect();
		  		aggiungiCertCampioneRilievo(selezionati, '${id_rilievo}');
		  		
		  	});
	

	
		tabCampioni.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
  	var indexCampione;
  	
  	
	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

  </script>

