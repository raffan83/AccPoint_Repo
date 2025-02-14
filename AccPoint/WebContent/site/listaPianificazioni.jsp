<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Pianificazioni
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
               <div class="box">
          <div class="box-header">
   	 <%-- <c:if test="${userObj.checkPermesso('CAMPIONI_COMPANY_METROLOGIA')}"> 	 
          <button class="btn btn-info" onclick="callAction('listaCampioni.do?p=mCMP');">I miei Campioni</button>
                  </c:if>
          <button class="btn btn-info" onclick="callAction('listaCampioni.do');">Tutti i Campioni</button> --%>
         
          </div>
            <div class="box-body">

     <div class="row">

	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDate()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	


</div><br>
     
<div class="row">



      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	Lista Pianificazioni
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-sm-12">
<div class="legend">
    <div class="legend-item">
        <div class="legend-color" style="background-color:#DCDCDC;"></div>
        <div class="legend-label">NON CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #FFFFE0;"></div>
        <div class="legend-label">CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #90EE90;"></div>
        <div class="legend-label">EROGATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #ADD8E6;"></div>
        <div class="legend-label">FATTURATO SENZA ATTESTATI</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #F7BEF6;"></div>
        <div class="legend-label">FATTURATO CON ATTESTATI</div>
    </div>
</div>

</div></div><br>
<div class="row">
<div class="col-sm-12">

 <table id="tabForPianificazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th>ID</th>

<th>Commessa</th>
<th>Data</th>
<th>Stato</th>
<th>Descrizione</th>
<th>Tipo</th>
<th>Docenti</th>
<th>Computo ore</th>
<th style="min-width:250px">Azioni</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_pianificazioni }" var="pianificazione" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${pianificazione.id }</td>	
	
	<td>${pianificazione.id_commessa }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pianificazione.data}" /></td>
	<td id="${pianificazione.id }">${pianificazione.stato.descrizione }</td>
	<td>${pianificazione.descrizione }</td>
	

	<td>${pianificazione.tipo.descrizione }</td>


	<td>
	<c:forEach items="${pianificazione.getListaDocenti() }" var="docente">
	${docente.nome} ${docente.cognome }<br>
	</c:forEach>
	</td>
<td>
    <c:set var="oraInizio" value="${pianificazione.ora_inizio}" />
    <c:set var="oraFine" value="${pianificazione.ora_fine}" />
    <c:set var="pausa" value="${pianificazione.pausa_pranzo}" />

    <!-- Estrarre ore e minuti dall'orario di inizio e fine -->
    <c:set var="oreInizio" value="${oraInizio.split(':')[0]}"/>
    <c:set var="minutiInizio" value="${oraInizio.split(':')[1]}"/>
    <c:set var="oreFine" value="${oraFine.split(':')[0]}"/>
    <c:set var="minutiFine" value="${oraFine.split(':')[1]}"/>

    <!-- Convertire ore e minuti in numeri interi -->
    <fmt:parseNumber var="oreInizioInt" value="${oreInizio}" integerOnly="true"/>
    <fmt:parseNumber var="minutiInizioInt" value="${minutiInizio}" integerOnly="true"/>
    <fmt:parseNumber var="oreFineInt" value="${oreFine}" integerOnly="true"/>
    <fmt:parseNumber var="minutiFineInt" value="${minutiFine}" integerOnly="true"/>

    <!-- Calcolo totale minuti lavorati -->
    <c:set var="minutiInizioTotale" value="${(oreInizioInt * 60) + minutiInizioInt}"/>
    <c:set var="minutiFineTotale" value="${(oreFineInt * 60) + minutiFineInt}"/>
    <c:set var="totMinuti" value="${minutiFineTotale - minutiInizioTotale}"/>

    <!-- Sottrazione pausa pranzo se presente -->
         <c:if test="${pausa == 'SI'}">
        
        <c:choose>
            <c:when test="${not empty pianificazione.durata_pausa_pranzo}">
             
                <c:set var="totMinuti" value="${totMinuti - pianificazione.durata_pausa_pranzo}"/>
            </c:when>
            <c:otherwise>
             
                <c:set var="totMinuti" value="${totMinuti - 60}"/>
            </c:otherwise>
        </c:choose>
    </c:if>

     
     <%-- <fmt:formatNumber var="oreFinaliInt" value="${totMinuti div 60}" type="number" maxFractionDigits="0"/> --%>
<%--      <c:set var="oreFinaliInt" value="${fn:substringBefore(totMinuti / 60, '.')}"/>
      --%>
    <fmt:formatNumber var="oreDecimali" value="${totMinuti / 60.0}" type="number" maxFractionDigits="1" groupingUsed="false" pattern="#0.0"/>


     
<%--     <c:set var="minutiFinali" value="${totMinuti % 60}"/>
    <c:set var="totOre" value="${oreFinali}"/> --%>

	<c:if test="${pianificazione.tipo.id !=3 }">
	${oreDecimali.replace(',','.')}
</c:if>
     
</td>


	
		<td>


 	<a class="btn btn-default customTooltip" title="NON CONFERMATO"  style="background-color:#DCDCDC;" onClick="cambiaStato('${pianificazione.id}', 1)"><i class="glyphicon glyphicon-refresh"></i></a> 
 	<a class="btn btn-default customTooltip" title="CONFERMATO"  style="background-color:#FFFFE0;" onClick="cambiaStato('${pianificazione.id}', 2)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="EROGATO"  style="background-color:#90EE90;" onClick="cambiaStato('${pianificazione.id}', 3)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="FATTURATO SENZA ATTESTATO"  style="background-color:#ADD8E6;" onClick="cambiaStato('${pianificazione.id}', 4)"><i class="glyphicon glyphicon-refresh"></i></a>
 	<a class="btn btn-default customTooltip" title="FATTURATO CON ATTESTATO"  style="background-color:#F7BEF6;" onClick="cambiaStato('${pianificazione.id}', 5)"><i class="glyphicon glyphicon-refresh"></i></a>

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
<style>


.table th {
    background-color: #3c8dbc !important;
  }
  
  
   .legend {
  display: flex;
}

.legend-item {
  display: flex;
  align-items: center;
  margin-right: 10px;
}

.legend-color {
  width: 20px;
  height: 20px;
}

.legend-label {
  margin-left: 5px;
}
  
  
  </style>




</jsp:attribute>

  
<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function cambiaStato(id_pianificazione, stato){
	
	$.ajax({
		  url: 'gestioneFormazione.do?action=cambia_stato_pianificazione&id='+id_pianificazione+"&stato="+stato, // Specifica l'URL della tua servlet
		  method: 'POST',
		  dataType: 'json',
		  success: function(response) {
		    // Recupera il JSONElement dalla risposta
		    var pianificazione = response.pianificazione;
		    
		    var array = [];
		    var day = [];
		    var map = {};
		    
		
		    var t = document.getElementById("tabForPianificazione");
		    var rows = t.rows;
		   
		  //  for (var i = 0; i < lista_pianificazioni.length; i++) {
			  
			  table = $('#tabForPianificazione').DataTable();
		    	
				var cell = $("#"+id_pianificazione);
				cell.text(pianificazione.stato.descrizione);
			
	
		  }
	
	});
	
}







var columsDatatables = [];

$("#tabForPianificazione").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForPianificazione thead th').each( function () {
    	
    	//$(this).css('background-color','#3c8dbc');  	
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForPianificazione thead th').eq( $(this).index() ).text();
    	
    	
    			  $(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
    	
    	} );
    
    

} );







	
function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

function changeSkin(){
	
	 //var skinName = $(this).data('skin')
	    $('body').removeClass('skin-red-light')
	    $('body').addClass('skin-blue')
	    //currentSkin = skinName
	
}

	
	




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


function filtraDate(){
	
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
 	dataString = "action=lista_pianificazioni&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
 			endDatePicker.format('YYYY-MM-DD');
 	
 	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

 	callAction("gestioneFormazione.do?"+ dataString, false,true);

 	//exploreModal("gestioneFormazione.do", dataString, '#content_consuntivo');
}




function resetDate(){
pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
callAction("gestioneFormazione.do?action=lista_pianificazioni");

}




$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();

     
     
     var start = "${dateFrom}";
   	var end = "${dateTo}";

   	$('input[name="datarange"]').daterangepicker({
  	    locale: {
  	      format: 'DD/MM/YYYY'
  	    
  	    }
  	}, 
  	function(start, end, label) {

  	});
   	
   	if(start!=null && start!=""){
  	 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
  	 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
  	
  	 }
     
     
     
     table = $('#tabForPianificazione').DataTable({
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
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 8 },
	
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, {
	 				 extend: 'excel',
		  	            text: 'Esporta Excel'  
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabForPianificazione_wrapper .col-sm-6:eq(1)');
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
	
	
	

});





 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

