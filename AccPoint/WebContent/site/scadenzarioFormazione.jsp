<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


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
        Scadenzario Corsi
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	Scadenzario Corsi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-3">
 <label class="control-label">Tipo Data:</label>
 <select class="form-control select2" style="width:100%" id="tipo_data" name="tipo_data">
 <c:if test="${tipo_data == 'data_corso' || tipo_data == null }">
<option value="data_corso" selected>Data Corso</option>
</c:if>
<c:if test="${tipo_data != 'data_corso' && tipo_data!=null}">
<option value="data_corso">Data Corso</option>
</c:if>
<c:if test="${tipo_data == 'data_scadenza' }">
<option value="data_scadenza" selected>Data Scadenza</option>
</c:if>
<c:if test="${tipo_data != 'data_scadenza' }">
<option value="data_scadenza">Data Scadenza</option>
</c:if> 

 </select>
 
</div>
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
	
	<div class="col-xs-4">
	<a class="btn btn-primary pull-right" style="margin-top:30px" onClick="callAction('gestioneFormazione.do?action=consuntivo')">Vai al consuntivo</a>
	</div>


</div>

<div class="row">
<div class="col-xs-12">



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForCorso" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th >ID Corso</th>
<th>Commessa</th>

<th>Partecipante</th>
<th>Ruolo</th>
<th>Categoria</th>
<th>Descrizione</th>
<th>Data Corso</th>
<th>Data Scadenza</th>
<th>Frequenza (mesi)</th>
<th>Azienda</th>
<th>Sede</th>

<th>Tipologia</th>
<th>Note</th>
<th>Azioni</th>
 </tr></thead>
 
 

 
 <tbody>
 
 	<c:forEach items="${lista_corsi }" var="corso_part" varStatus="loop">
 	
 	<c:if test="${corso_part.corso_aggiornato == 1 }">
 	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
 	</c:if>
	<c:if test="${corso_part.corso_aggiornato == 0 }">
	<c:choose>
	<c:when test="${corso_part.corso.in_scadenza == 1 }">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:when>
	
	<c:otherwise>
	<tr id="row_${loop.index}" >
	</c:otherwise>
 	</c:choose>
 	</c:if>
<td>${corso_part.corso.id }</td>
<td>${corso_part.corso.commessa }</td>

	<td>
	<a class="btn customTooltip customlink" title="Vai al partecipante" onclick="callAction('gestioneFormazione.do?action=dettaglio_partecipante&id_partecipante=${utl:encryptData(corso_part.partecipante.id)}')">${corso_part.partecipante.nome } ${corso_part.partecipante.cognome }</a>
	</td>
	
	
	<td>${corso_part.ruolo.descrizione }</td>
	<td>${corso_part.corso.corso_cat.descrizione }</td>
	<td>${corso_part.corso.descrizione }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso_part.corso.data_corso}" /></td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso_part.corso.data_scadenza}" /></td>
	<td>${corso_part.corso.corso_cat.frequenza }</td>
	<td>${corso_part.partecipante.nome_azienda}</td>
	<td><c:if test="${corso_part.partecipante.id_sede!=0}">${corso_part.partecipante.nome_sede}</c:if></td>

	<td>${corso_part.corso.tipologia }</td>
		<td>${corso_part.partecipante.note }</td>
	<td>
	 	
	<a class="btn btn-info customTooltip" onClick="dettaglioCorso('${utl:encryptData(corso_part.corso.id)}')" title="Vai al corso"><i class="fa fa-search"></i></a>
	
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


</section>



  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>




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
  }</style>


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalnuovoCorso(){
	
	$('#myModalNuovoCorso').modal();
	
}


function modificaCorsoModal(id_corso,id_categoria, id_docente, data_inizio, data_scadenza, documento_test, descrizione, tipologia){
	
	$('#id_corso').val(id_corso);
	$('#categoria_mod').val(id_categoria);
	$('#categoria_mod').change();
	$('#docente_mod').val(id_docente);
	$('#docente_mod').change();
	if(data_inizio!=null && data_inizio!=''){
		$('#data_corso_mod').val(Date.parse(data_inizio).toString("dd/MM/yyyy"));
	}
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
		
	$('#label_file_mod').html(documento_test);
	$('#descrizione_mod').val(descrizione);
	$('#tipologia_mod').val(tipologia);
	
	$('#myModalModificaCorso').modal();
}


function filtraDate(){
	
	var tipo_data = $('#tipo_data').val();
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "?action=scadenzario&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_data="+tipo_data;
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	callAction("gestioneFormazione.do"+ dataString, false,true);

}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("gestioneFormazione.do?action=scadenzario");

}


 




var columsDatatables = [];

$("#tabForCorso").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForCorso thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );

function dettaglioCorso(id_corso){
	
	callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso='+id_corso);
}




	
function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


var array_color = [];

$(document).ready(function() {
 
	
	var array_buttons = [];
	
	if(${userObj.checkRuolo("F2")}){
		

		
		array_buttons.push( {
	            extend: 'excel',
	            text: 'Esporta Excel'  	                   
			  });
		
	}else{
		array_buttons.push(	{
	            extend: 'colvis',
	            text: 'Nascondi Colonne'  	                   
			  },
			 {
  	            extend: 'excelHtml5',
  	            text: 'Esporta Excel',
  	          customize: function(xlsx) {
  	        	  
  	        	table.rows().nodes().each( function ( index ) {
  	        	    var row = index;	  	        	 
  	        	    
  	        	    var color = $(index).css("background-color");
  	        	    
  	        	    var text = {};
  	        	    
  	        	    if(color == "rgb(250, 137, 137)" || color == "rgb(248, 242, 109)"){
  	        	    	text.corso = table.cell(index, 0).data();
  	        	    	
  	        	    	
  	        	    	text.partecipante = stripHtml(table.cell(index, 2).data()).trim();
  	        	    	text.color = color;
  	        	    	array_color.push(text);
  	        	    }
  	        	  	
  	        	   
  	        	} );
  	        	  
                  var sheet = xlsx.xl.worksheets['sheet1.xml'];
                  
                  
                  $('row', sheet).each( function (row) {
                	  
                	  if($('v', this)[0]!=null){
                		  
                		  var id_corso = $('c[r^="A"]', this).text();
                		  var partecipante = $('c[r^="C"]', this).text();
                	  
                	  for(var i = 0; i<array_color.length; i++){
                		 
                		  
                		  
	                		
	                			if(id_corso == array_color[i].corso && partecipante == array_color[i].partecipante){
	                			
	                			  
	                			  if(array_color[i].color == "rgb(250, 137, 137)"){
	                				  $('c', this).attr('s', '35');
	                			  }else if(array_color[i].color == "rgb(248, 242, 109)"){
	                				  $('c', this).attr('s', '45');
	                			  }
		                				 
		                			
		               
		                		  }
	                		  
                		  
                				                		 
                	  }
	                		  }
   
    
                        });
  
 			  }
			 });
	}
	
	
	

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

     table = $('#tabForCorso').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 13 },
		    	  { responsivePriority: 2, targets: 9},
		    	  { responsivePriority: 3, targets: 10 }
		    	  
		    	  
		    	  
		               ], 	        
	  	      buttons: array_buttons
		               
		    });
     
     
     
		//if(${!userObj.checkRuolo('F2')}){
			table.buttons().container().appendTo( '#tabForCorso_wrapper .col-sm-6:eq(1)');	
		//}
		
		
		
		
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
		

	$('#tabForCorso').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});


$('#modificaCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForCorso();
});
 

 
 $('#nuovoCorsoForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForCorso();
});
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

