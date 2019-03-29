<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Lista Interventi Operatore
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
      
       
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Interventi Dati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">
<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data Creazione:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraPerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
	</div>

	<c:choose>
	<c:when test="${tasto_generate != null }">
	<a class="btn btn-primary pull-right" onClick="attivitaSospese(1)">Torna alla lista completa</a>
	</c:when>
	<c:otherwise>
	<a class="btn btn-primary pull-right" onClick="attivitaSospese(0)">Attività Generate</a>
	</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${tasto_scarico != null }">
	<a class="btn btn-primary pull-right" style="margin-right:5px" onClick="attivitaSospese(1)">Torna alla lista completa</a>
	</c:when>
	<c:otherwise>
	<a class="btn btn-primary pull-right" style="margin-right:5px" onClick="attivitaScarico()">Attività Solo Scarico</a>
	</c:otherwise>
	</c:choose>

</div>
</div><br>
<div class="row">
<div class="col-lg-12">
	<div class="col-xs-5">
	<div class="form-group" >
	<label class="control-label">Ricerca Operatore:</label>
		<select class="form-control select2" style="width:100%" data-placeholder="Seleziona Operatore..." id="operatore" name="operatore">
		<option value=""></option>
		<c:forEach items="${lista_utenti}" var="operatore">
		<c:choose>
		<c:when test="${operatore.nominativo.equals(oper)}">
			<option value="${operatore.nominativo }" selected>${operatore.nominativo }</option>
		</c:when>
		<c:otherwise>
			<option value="${operatore.nominativo }">${operatore.nominativo }</option>
		</c:otherwise>
		</c:choose>
		
		</c:forEach>
		</select>
	</div>
	</div>
	<div class="col-xs-1">
	<span class="input-group-btn">
				               
	<button type="button" style="margin-top:25px" class="btn btn-primary btn-flat" onclick="resetOperatore()">Reset Operatore</button>
	 </span>	
	 </div>
	 <div class="col-xs-3">
	 </div>
				           
	<div class="col-xs-3">
		<label class="control-label pull-right">Totale Strumenti Misurati:</label>
			<input class="form-control pull-right" id="totale" type="text" readonly/>
		</div>   

</div>
</div>
<div class="row">
<div class="col-lg-12">
 <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

  <th>ID</th>
 <th>ID Intervento</th>
 <th>Stato Intervento</th>
  <th>Commessa</th> 
 <th>Data Creazione</th>

  <th>Stato Intervento Dati</th>
  <th>Strumenti Misurati</th>
  <th>Strumenti Nuovi</th>
  <th>Utente</th>
 <th>Nome Pack</th> 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_interventi_dati}" var="intervento_dati" varStatus="loop">
 
 <tr id="rowIndex_${loop.index }">
 
	<td>${intervento_dati.id }</td>
	
	<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(intervento_dati.id_intervento)}');">${intervento_dati.id_intervento }</a></td>
	<td>
	<c:choose>
  <c:when test="${intervento_dati.stato_intervento == 1}">
		<span class="label label-success">APERTO</span>
  </c:when>
 <c:when test="${intervento_dati.stato_intervento == 2}">
		<span class="label label-danger">CHIUSO</span>
  </c:when> 
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
	</td>
	<td>
	<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della Commessa" onclick="callAction('gestioneIntervento.do?idCommessa=${utl:encryptData(intervento_dati.id_commessa)}');">
		${intervento_dati.id_commessa }
	</a>
	</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento_dati.dataCreazione }" /></td>
	
	<td>
	<c:choose>
  <c:when test="${intervento_dati.stato.id == 1}">
		<span class="label label-success">GENERATO</span>
  </c:when>
 <c:when test="${intervento_dati.stato.id == 2}">
		<span class="label label-info">DOWNLOAD PACK</span>
  </c:when>
  <c:when test="${intervento_dati.stato.id == 3}">
		<span class="label label-danger">UPLOAD PACK</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
	</td>
	<td><a href="#" class="customTooltip customlink" title="Click per aprire la lista delle Misure del pacchetto" onClick="callAction('strumentiMisurati.do?action=li&id=${utl:encryptData(intervento_dati.id)}')">${intervento_dati.numStrMis}</a></td>
	<td>${intervento_dati.numStrNuovi }</td>
	<td>${intervento_dati.utente.nominativo }</td>
	<td>
	<c:if test="${intervento_dati.stato.id == 3}">
				<a href="#" onClick="scaricaPacchettoUploaded('${intervento_dati.nomePack}')">${intervento_dati.nomePack}</a>
  			</c:if>
  			<c:if test="${intervento_dati.stato.id != 3}">
				${intervento_dati.nomePack}
  			</c:if>
  </td>


	
</tr>
	

	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>



 
</div>
 </div> 


</section>

  </div>
  
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script type="text/javascript">

function attivitaSospese(lista_completa){
	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();

	if(lista_completa==1){
		callAction('listaInterventiOperatore.do')
	}else{
		callAction('listaInterventiOperatore.do?action=attivita_sospese')
	}
}

function attivitaScarico(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();
	
	callAction('listaInterventiOperatore.do?action=attivita_scarico')
	
}

function filtraPerData(){
	
	
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	var operatore = $('#operatore').val();
	dataString = "?action=filtra_date&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD')+"&oper="+operatore;
		 	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();

		 	callAction("listaInterventiOperatore.do"+ dataString, false,true);
		 	
		}
 
 function resetDate(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		callAction("listaInterventiOperatore.do");

	}
 
 function resetOperatore(){
	
		table
		.columns( 8 )
		.search("")
		.draw();	
		
		$('#inputsearchtable_8').val("");
		 $('#operatore').val("");
		 $('#operatore').change();
 }

 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}

	function contaStrumenti(table){
		
		//var table = $("#tabPM").DataTable();
		
		var data = table
	     .rows({ search: 'applied' })
	     .data();
		var somma = 0;
		for(var i=0;i<data.length;i++){	
			var num = parseInt(stripHtml(data[i][6]));
			somma = somma + num;
		}
		$('#totale').val(somma);
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
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );


$(document).ready(function() {
	
	$('.select2').select2();
	
	 $('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YYYY'
		    
		    }
		}, 
		function(start, end, label) {

		});
	 
	 var start = "${dateFrom}";
	 var end = "${dateTo}";
	 if(start!=null && start!=""){
		 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
		 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
	 }
	
	
	 $('.dropdown-toggle').dropdown();

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
		        pageLength: 25,
		        
			      paging: true, 
			      ordering: true,
			     
			      info: true, 
			      searchable: false, 
			      targets: 0,
			      responsive: true,
			      scrollX: false,
			      stateSave: true,
			      "order": [[ 0, "desc" ]],
			      columnDefs: [

			    	  { responsivePriority: 1, targets: 1 },
			    	  { responsivePriority: 2, targets: 8 },
			    	  { responsivePriority: 3, targets: 6 },
			    	  { responsivePriority: 4, targets: 7 }
			               ], 	        
		  	      buttons: [   
		  	          {
		  	            extend: 'colvis',
		  	            text: 'Nascondi Colonne'  	                   
		 			  } ]
			               
			    });
			
			table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
		 	    $('.inputsearchtable').on('click', function(e){
		 	       e.stopPropagation();    
		 	    });

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
		
		contaStrumenti(table);

		table.on( 'search.dt', function () {
		    contaStrumenti(table);
		} );
		
		table
		.columns( 8 )
		.search( $('#operatore').val() )
		.draw();	
		
		$('#inputsearchtable_8').val($('#operatore').val() );
	
});

$('#operatore').change(function(){
	
	table
	.columns( 8 )
	.search( $(this).val() )
	.draw();	
	
	$('#inputsearchtable_8').val($(this).val());
	
});

		
</script>


</jsp:attribute> 
</t:layout>
  
 
