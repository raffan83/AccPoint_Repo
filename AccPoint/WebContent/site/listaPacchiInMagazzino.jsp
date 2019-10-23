
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
        Lista Pacchi in Magazzino
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
       <a class="btn btn-default pull-right" href="#" id="tornaMagazzino" onClick="tornaMagazzino()" style="margin-right:5px"><i class="fa fa-dashboard"></i> Torna al Magazzino</a>
       
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista pacchi in Magazzino
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<%--  <div class="row" style="margin-top:15px">
 <div class="col-xs-2">
 <div class="row" >
 <div class="col-xs-12">
 <label for="tipo_data" class="control-label">Tipo Data:</label>
 <select class="form-control select2" data-placeholder="Seleziona Tipo di Data..."  aria-hidden="true" data-live-search="true" style="width:100%" id="tipo_data" name="tipo_data">
 <option value=""></option>
 <option value="1">Data Creazione</option>
 <option value="2">Data Arrivo/Rientro</option>
 <option value="3">Data Spedizione</option>
 </select>
 </div>
 </div> 
 </div>
	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Date:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraPacchiPerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>
	<div class="col-md-3">
<label>Commessa</label>
<select class="form-control select2" data-placeholder="Seleziona Commessa..."  aria-hidden="true" data-live-search="true" style="width:100%" id="filtro_commessa" name="filtro_commessa">
<option value=""></option>
<c:forEach items="${lista_commesseTutte }" var="commessa" varStatus="loop">
	<option value="${commessa.ID_COMMESSA }">${commessa.ID_COMMESSA }</option>
</c:forEach>
</select>

</div><button type="button" style="margin-top:25px" class="btn btn-primary btn-flat" onclick="resetCommesse()">Reset Commessa</button>
</div>

 --%>

<div class="row">
<div class="col-lg-12">
 <table id="tabMag" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Azioni</th>
   <th >Origine</th>
 <th >Cliente</th>
 <th>Sede</th>
 <th >Commessa</th> 
  <th >Stato lavorazione</th>

<th>Data Arrivo</th>
   <th >Strumenti Lavorati</th>
   <th >DDT</th>
<th>Note Pacco</th>

 <th >ID</th> 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_pacchi_magazzino}" var="pacco" varStatus="loop">
  <c:choose>
 <c:when test="${utl:getRapportoLavorati(pacco) > 0 && utl:getRapportoLavorati(pacco) <= 1}">
 <tr style="background-color:#00ff80" id="rowIndex_${loop.index }" ondblclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
 </c:when>
 <c:otherwise>
 <tr id="rowIndex_${loop.index }" ondblclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
 </c:otherwise>
 </c:choose> 



<td>
<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')"><i class="fa fa-search"></i></a>

</td>
<td>
<c:if test="${pacco.origine!='' && pacco.origine!=null}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.origine.split('_')[1])}')">${pacco.origine}</a>
</c:if>
</td>


<td>${pacco.nome_cliente}</td>
<td>${pacco.nome_sede }</td>

 <td>
<c:if test="${pacco.commessa!=null && pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${pacco.commessa}');">${pacco.commessa}</a>
</c:if>
</td> 

<td>
<c:choose>
<c:when test="${pacco.stato_lavorazione.id == 1}">
 <span class="label label-info">${pacco.stato_lavorazione.descrizione} </span></c:when>
 <c:when test="${pacco.stato_lavorazione.id == 2}">
 <span class="label label-success">${pacco.stato_lavorazione.descrizione}</span></c:when>
  <c:when test="${pacco.stato_lavorazione.id == 3}">
 <span class="label label-danger ">${pacco.stato_lavorazione.descrizione}</span></c:when>
   <c:when test="${pacco.stato_lavorazione.id == 4}">
 <span class="label label-warning" >${pacco.stato_lavorazione.descrizione}</span></c:when>
 <c:when test="${pacco.stato_lavorazione.id == 5}">
 <span class="label label-primary">${pacco.stato_lavorazione.descrizione}</span></c:when>
 </c:choose>
</td>


<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${pacco.data_arrivo}" /></td>
<td>${utl:getStringaLavorazionePacco(pacco)}</td>
<c:choose>
<c:when test="${pacco.ddt.numero_ddt!='' &&pacco.ddt.numero_ddt!=null}">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${utl:encryptData(pacco.ddt.id)}')">
${pacco.ddt.numero_ddt}
</a></td></c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>



<td>
<span class="label btn" style="background-color:#808080" >${pacco.tipo_nota_pacco.descrizione }</span>
</td>

<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(pacco.id)}')">
${pacco.id}
</a>
</td> 
	</tr>
	

	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>



 




<div id="myModalCommessa" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Attivit� </h4>
      </div>
       <div class="modal-body" id="commessa_body">
       
       
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


       
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

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="plugins/datejs/date.js"></script>

<script type="text/javascript">


$("#filtro_commessa").on('change', function(){
	

	var comm = $('#filtro_commessa').val();
	
	$('#inputsearchtable_4').val(comm);
	
	table
    .columns( 4 )
    .search( comm )
    .draw();
});
	
/* var commessa = "${commessa}";

if(commessa!=null){
	$('#filtro_commessa option[value="${commessa}"]').attr("selected", true);
	
} */


function filtraPacchiPerData(){
	
	var tipo_data = $('#tipo_data').val();
	var comm = $('#filtra_commesse').val();
	if(tipo_data==""){
		$('#myModalErrorContent').html("Attenzione! Nessun Tipo Di Data Selezioneato!");
		$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");
		$('#myModalError').modal('show');
	}else{
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "?action=filtraDate&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_data="+tipo_data + "&commessa="+ comm;
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	callAction("listaPacchi.do"+ dataString, false,true);
	 	
		
	}
}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("listaPacchi.do");

}

function resetCommesse(){
	
	$('#inputsearchtable_4').val("");
	
	table
    .columns( 4 )
    .search( "" )
    .draw();
	
	$("#filtro_commessa").append('<option value=""></option>');
	$('#filtro_commessa option[value=""]').attr('selected', true);

}
	var flag = 0;








function dettaglioPaccoFromOrigine(origine){
	
	var id = origine.split("_")
	dettaglioPacco(id[1]);
	
}



	var columsDatatables = [];
	 
  	$("#tabMag").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    } 
  	    $('#tabMag thead th').each( function () {
	    	  $('#inputsearchtable_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);
	    	 
	    	}); 

	} ); 
 
	
function tornaMagazzino(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  callAction('listaPacchi.do');
}


$(document).ready(function() {

	//$(".select2").select2();

	$('.dropdown-toggle').dropdown();
	

	
     $('#tabMag thead th').each( function () {
 	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	  var title = $('#tabMag thead th').eq( $(this).index() ).text();
	
	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	
	} ); 
    
	
	
	$('.datepicker').datepicker({
		format : "dd/mm/yyyy"
	});
	
 	$('.datetimepicker').datetimepicker({
		format : "dd/mm/yyyy hh:ii"
	}); 

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
	
	 	$("#tipo_data option[value='']").remove();
	 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true);
	 }
 	
	
	table = $('#tabMag').DataTable({
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
        "order": [[ 10, "desc" ]],
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: false,
	      scrollX: true,
	      scrollY: "450px",
	      stateSave: true,
	      columnDefs: [
	    	    /*  { responsivePriority: 1, targets: 7 },
	                  { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 0 }, 
	                   { responsivePriority: 4, targets: 8 }, */
	                  // { responsivePriority: 5, targets: 16 }
	    //	  { responsivePriority: 1, targets: 9 },
	    //	  { responsivePriority: 2, targets: 8 }
	               ], 	        
  	      buttons: [   
  	    	,{
                extend: 'excel',
                text: 'Esporta Excel',
                 exportOptions: {
                    modifier: {
                        page: 'current'
                    }
                } 
            },
  	    	  {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
		
	table.buttons().container().appendTo( '#tabMag_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
// DataTable
//table = $('#tabPM').DataTable();
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
	

$('#tabMag').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});
	//coloraRighe(table);

var val = $('#inputsearchtable_4').val();
if(val!=""){
	$('#filtro_commessa option[value=""]').remove();
	$('#filtro_commessa option[value="'+val+'"]').attr('selected', true);
}




}); 



	


var idCliente = ${userObj.idCliente}
var idSede = ${userObj.idSede}

 $body = $("body");


 		
		function formatDate(data){
			
			   var mydate = new Date(data);
			   
			   if(!isNaN(mydate.getTime())){
			   
				   str = mydate.toString("dd/MM/yyyy");
			   }			   
			   return str;	 		
		}
		
	
  



   	/* function coloraRighe(tabella){
  	 
	   var data = tabella
	     .rows()
	     .data();
   		
 		for(var i=0;i<data.length;i++){	
 	 	    var node = $(tabella.row(i).node());  	 	   
 	 	    var color = node.css('backgroundColor');
 	 	    
 	 	 	 if(rgb2hex(color)=="#00ff80"){
				 var data_row = $(tabella.row(i).data());		
				 var origine = stripHtml(data_row[1]);			
				for(var j = 0; j<data.length;j++){			
					
					var data_row2 = $(tabella.row(j).data());		
					 var origine2 = stripHtml(data_row2[1]);
			
					if(origine2==origine){
						var node2 = $(tabella.row(j).node());  
						node2.css('backgroundColor',"#00ff80");
					}							
				 }		 		
 			 }
 	 	 }	
	}    */
 		
/*    	function isDate(ExpiryDate) { 
   	    var objDate,  // date object initialized from the ExpiryDate string 
   	        mSeconds, // ExpiryDate in milliseconds 
   	        day,      // day 
   	        month,    // month 
   	        year;     // year    	    
    	    if (ExpiryDate.length !== 10) { 
   	        return false; 
   	    }  
   	    
   	    if (ExpiryDate.substring(2, 3) !== '/' || ExpiryDate.substring(5, 6) !== '/') { 
   	        return false; 
   	    } 
   	  
   		day = ExpiryDate.substring(0, 2) - 0; 
   	    month = ExpiryDate.substring(3, 5) - 1; 
   	    year = ExpiryDate.substring(6, 10) - 0; 
   	    
   	    if (year < 1000 || year > 3000) { 
   	        return false; 
   	    } 
   	    mSeconds = (new Date(year, month, day)).getTime(); 
   	  
   	    objDate = new Date(); 
   	    objDate.setTime(mSeconds); 
   	    
   	    if (objDate.getFullYear() !== year || 
   	        objDate.getMonth() !== month || 
   	        objDate.getDate() !== day) { 
   	        return false; 
   	    } 
   	  
   	    return true; 
   	}
 */
 		
 		
 	function rgb2hex(rgb){
 		 rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
 		 return (rgb && rgb.length === 4) ? "#" +
 		  ("0" + parseInt(rgb[1],10).toString(16)).slice(-2) +
 		  ("0" + parseInt(rgb[2],10).toString(16)).slice(-2) +
 		  ("0" + parseInt(rgb[3],10).toString(16)).slice(-2) : '';
 		}

 		function hex(x) {
 		  return isNaN(x) ? "00" : hexDigits[(x - x % 16) / 16] + hexDigits[x % 16];
 		 }
 		
 		
 		
  function filtraPacchi(filtro){
	  
	  	dataString="";
	  	if(filtro!=null && filtro!=''){
	  		dataString = "?stato="+filtro;	
	  	}		

		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();

		callAction("listaPacchi.do"+ dataString, false,true);
  }
  
 /*  var options =  $('#cliente_appoggio option').clone();
  function mockData() {
  	  return _.map(options, function(i) {		  
  	    return {
  	      id: i.value,
  	      text: i.text,
  	    };
  	  });
  	}
  	


  function initSelect2(id_input, placeholder) {
	  if(placeholder==null){
		  placeholder = "Seleziona Cliente...";
	  }

  	$(id_input).select2({
  	    data: mockData(),
  	    placeholder: placeholder,
  	    multiple: false,
  	    // query with pagination
  	    query: function(q) {
  	      var pageSize,
  	        results,
  	        that = this;
  	      pageSize = 20; // or whatever pagesize
  	      results = [];
  	      if (q.term && q.term !== '') {
  	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
  	        results = _.filter(x, function(e) {
  	        	
  	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
  	        });
  	      } else if (q.term === '') {
  	        results = that.data;
  	      }
  	      q.callback({
  	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
  	        more: results.length >= q.page * pageSize,
  	      });
  	    },
  	  });
  	  	
  }
		 */
</script>


</jsp:attribute> 
</t:layout>
  
 
