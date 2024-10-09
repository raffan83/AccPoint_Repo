<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%
UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");

%>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
      Lista Richieste di Prenotazione auto
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Richieste di Prenotazione auto
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalnuovaIntervento()"><i class="fa fa-plus"></i> nuova Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovaRichiesta()"><i class="fa fa-plus"></i> Nuova Richiesta</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabRichieste" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Utente</th>
<th>Data inizio</th>
<th>Data fine</th>
<th>Luogo</th>
<th>Note</th>
<th>Stato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_richieste }" var="richiesta" varStatus="loop">
 	<%-- <c:if test="${ richiesta.utente.id == userObj.id  || userObj.checkPermesso('GESTIONE_PARCO_AUTO_ADMIN')}"> --%>
	
	
	 <c:choose>
  <c:when test="${richiesta.stato == '1'}">
   <tr id="row_${loop.index}"  style="background-color:#eef578">
  </c:when>
  <c:when test="${richiesta.stato == '2'}">
    <tr id="row_${loop.index}"  style="background-color:#90EE90">
  </c:when>
</c:choose>
	<td>${richiesta.id }</td>	
	<td>${richiesta.utente.nominativo }</td>
	<td>   <fmt:formatDate pattern="dd/MM/yyyy HH:mm"   value="${richiesta.data_inizio}" /></td>
	<td>   <fmt:formatDate pattern="dd/MM/yyyy HH:mm"   value="${richiesta.data_fine}" /></td>
	<td>${richiesta.luogo }</td>
	<td>${richiesta.note }</td>	
			<td class="centered">

 <c:choose>
  <c:when test="${richiesta.stato == '1'}">
    <span class="label label-warning">IN CORSO</span>
  </c:when>
  <c:when test="${richiesta.stato == '2'}">
    <span class="label label-success">EVASA</span>
  </c:when>
    <c:when test="${richiesta.stato == '3'}">
    <span class="label label-danger">ANNULLATA</span>
  </c:when>
</c:choose> 
</td>
	<td>
	<c:if test="${userObj.checkPermesso('GESTIONE_PARCO_AUTO_ADMIN') && richiesta.stato == '1' }">
	<a class="btn btn-info customTooltip" onClicK="modificaRichiesta('${richiesta.id}', '${richiesta.data_inizio }', '${richiesta.data_fine }','${utl:escapeJS(richiesta.note) }','1','${utl:escapeJS(richiesta.luogo) }')" title="Gestisci richiesta"><i class="fa fa-edit"></i></a>
	</c:if>

	<c:if test="${richiesta.stato == 1 && richiesta.utente.id == userObj.id }">
 	<a class="btn btn-warning customTooltip" onClicK="modificaRichiesta('${richiesta.id}', '${richiesta.data_inizio }', '${richiesta.data_fine }','${utl:escapeJS(richiesta.note) }','0', '${utl:escapeJS(richiesta.luogo) }')" title="Click per modificare la richiesta"><i class="fa fa-edit"></i></a>
 	<a class="btn btn-danger customTooltip" onClicK="modalEliminaRichiesta('${richiesta.id }')" title="Click per eliminare la richiesta"><i class="fa fa-trash"></i></a>
 	</c:if>
	  
 	</td>
	</tr>
<%-- 	</c:if> --%>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>


</section>

  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare la richiesta di prenotazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_richiesta_elimina">
      <a class="btn btn-primary" onclick="eliminaRichiesta($('#id_richiesta_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="NuovaRichiestaForm" name="NuovaRichiestaForm">
<div id="myModalNuovaRichiesta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Richiesta</h4>
      </div>
       <div class="modal-body">
       
       
        <div class="row" >
        <div class="col-xs-6">
        <label>Data inizio prenotazione</label>

           <input id="data_inizio" name="data_inizio" class="form-control datepicker" type="text" style="width:100%" required>
        </div>
        
       
        
        		<div class='col-xs-3'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio' name='ora_inizio'  class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

        </div><br>
        
        
        <div class="row">
        <div class="col-xs-6">
        <label>Data fine prenotazione</label>
           <input id="data_fine" name="data_fine" class="form-control datepicker" type="text" style="width:100%" required>
        </div>


			<div class='col-xs-3'><label>Ora fine</label><div class='input-group'>
					<input type='text' id='ora_fine' name='ora_fine'   class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

        </div><br>
        
                        <div class="row">
       <div class="col-sm-12">  
       		<label>Luogo</label>
      
       	    
       	  	
        <input id="luogo" name="luogo" class="form-control" style="width:100%" required>
       			
       	</div>       	
       </div><br>
        

        <div class="row">
       <div class="col-sm-12">  
       		<label>Note</label>
      
       	    
       	  	
        <textarea id="note" name="note" class="form-control" rows="3" style="width:100%" ></textarea>
       			
       	</div>       	
       </div>
       
       
       
       </div>
  		 
      <div class="modal-footer">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaRichiestaForm" name="modificaRichiestaForm">
<div id="myModalModificaRichiesta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Richiesta</h4>
      </div>
       <div class="modal-body">

        <div class="row" >
        <div class="col-xs-6">
        <label>Data inizio prenotazione</label>

           <input id="data_inizio_mod" name="data_inizio_mod" class="form-control datepicker" type="text" style="width:100%" required>
        </div>
        
       
        
        		<div class='col-xs-3'><label>Ora inzio</label><div class='input-group'>
					<input type='text' id='ora_inizio_mod' name='ora_inizio_mod'  class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>
		            <div id="content_giornaliero" style="display:none">
		             		<div class='col-xs-3' ><label>A/R giornaliero</label><br>
					<input type='checkbox' id='giornaliero_mod' name='giornaliero_mod' class='form-control' style='width:100%'>
					
					</div></div>
   
        </div><br>
        
        
        <div class="row">
        <div class="col-xs-6">
        <label>Data fine prenotazione</label>
           <input id="data_fine_mod" name="data_fine_mod" class="form-control datepicker" type="text" style="width:100%" required>
        </div>


			<div class='col-xs-3'><label>Ora fine</label><div class='input-group'>
					<input type='text' id='ora_fine_mod' name='ora_fine_mod'   class='form-control timepicker' style='width:100%' required><span class='input-group-addon'>
		            <span class='fa fa-clock-o'></span></span></div></div>

        </div><br>
        
                <div class="row">
       <div class="col-sm-12">  
       		<label>Luogo</label>
      
       	    
       	  	
        <input id="luogo_mod" name="luogo_mod" class="form-control"  style="width:100%" required>
       			
       	</div>       	
       </div><br>

        <div class="row">
       <div class="col-sm-12">  
       		<label>Note</label>
      
       	    
       	  	
        <textarea id="note_mod" name="note_mod" class="form-control" rows="3" style="width:100%" ></textarea>
       			
       	</div>       	
       </div>
       
        <div class="row" style="display:none" id="content_veicoli">
      <br> <div class="col-sm-12">  
       		<label>Assegna veicolo</label>
      
     <select class="form-control select2" id="veicoli" name="veicoli" style="width:100%" data-placeholder="Seleziona Veicolo..." >
       <option value=""></option>
     <c:forEach items="${lista_veicoli }" var="veicolo">
     <option value="${veicolo.id }">${veicolo.modello } - ${veicolo.targa }</option>
     </c:forEach>
   

       </select>
       			
       	</div>       	
       </div>
       
       
       </div>
  		 
      <div class="modal-footer">
		
		
		<input type="hidden" id="check_giornaliero_mod" name="check_giornaliero_mod">
		<input type="hidden" id="id_richiesta" name="id_richiesta">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>






</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css">

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovaRichiesta(){
	
	$('#myModalNuovaRichiesta').modal();
	
}


function modificaRichiesta(id_richiesta, data_inizio, data_fine, note, is_admin, luogo){
	
	$("#content_veicoli").hide();

	$('#data_inizio_mod').attr("readonly", false);
	$('#data_fine_mod').attr("readonly", false);		
	$('#ora_inizio_mod').attr("readonly", false);
	$('#ora_fine_mod').attr("readonly", false);
	
	
	$('#data_inizio_mod').bind('focus');
	$('#data_fine_mod').bind('focus');	
	$('#ora_inizio_mod').bind('focus');
	$('#ora_fine_mod').bind('focus');
	$('#veicoli').attr("required", false)
	
	$('#id_richiesta').val(id_richiesta);
	$('#note_mod').val(note);
	$('#luogo_mod').val(luogo);
	
	$('#data_inizio_mod').val(Date.parse(data_inizio.split(" ")[0]).toString("dd/MM/yyyy"));
	
	
	$('#data_fine_mod').val(Date.parse(data_fine.split(" ")[0]).toString("dd/MM/yyyy"));
	

	
	$('#ora_inizio_mod').val(data_inizio.split(" ")[1]);
	$('#ora_fine_mod').val(data_fine.split(" ")[1]);
	
	initializeTimepicker(data_inizio.split(" ")[1], data_fine.split(" ")[1], "_mod");
	
	
	$('#content_giornaliero').hide();
	if(is_admin== "1"){
		
		if(data_inizio.split(" ")[0] != data_fine.split(" ")[0]){
			$('#content_giornaliero').show();			
		}else{
			$('#giornaliero_mod').iCheck("uncheck");
			$('#content_giornaliero').hide();	
		}


		
		$("#content_veicoli").show();
		$('#veicoli').attr("required", true)
	
		$('#data_inizio_mod').attr("readonly", true);
		$('#data_fine_mod').attr("readonly", true);		
		$('#ora_inizio_mod').attr("readonly", true);
		$('#ora_fine_mod').attr("readonly", true);

		
		$('#data_inizio_mod').unbind('focus');
		$('#data_fine_mod').unbind('focus');	
		$('#ora_inizio_mod').css("cursor", "pointer");
		$('#ora_fine_mod').css("cursor", "pointer");
		
/* 		$('#ora_inizio_mod').timepicker("option", "disabled", true);
		$('#ora_fine_mod').timepicker("option", "disabled", true); */
		
		dataObj = {};
		dataObj.data_inizio = $('#data_inizio_mod').val();
		dataObj.data_fine = $('#data_fine_mod').val();
		dataObj.ora_inizio = $('#ora_inizio_mod').val();
		dataObj.ora_fine = $('#ora_fine_mod').val();
		callAjax(dataObj,"gestioneParcoAuto.do?action=veicoli_disponibili",function(data){
			
			if(data.success){
				
				var veicoli = data.lista_veicoli;

				$('#veicoli').find("option").each(function(){
				
					var option = $(this);
					 var optionValue = option.val();
					 option.prop('disabled', true);
				        for (var i = 0; i < veicoli.length; i++) {
				        	
				            if (optionValue == veicoli[i].id) {
				                option.prop('disabled', false);
				               
				            }
				        }
					
				})
				
				
				
			}
			
			$('#myModalModificaRichiesta').modal();
		});
	}else{
		
		$('#myModalModificaRichiesta').modal();
	}
	
	

	
}



function modalEliminaRichiesta(id_richiesta){
	
	
	$('#id_richiesta_elimina').val(id_richiesta);
	$('#myModalYesOrNo').modal()
	
}



function eliminaRichiesta(){
	
	dataObj = {};
	
	dataObj.id_richiesta_elimina = $('#id_richiesta_elimina').val();
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=elimina_richiesta");
}


var columsDatatables = [];

$("#tabRichieste").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabRichieste thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabRichieste thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$('#data_inizio').change(function(){
	
	  var data_fine_str = $('#data_fine').val();
	    var data_inizio_str = $('#data_inizio').val();

	    // Converti le stringhe in oggetti Date
	    var data_fine = toDate(data_fine_str);
	    var data_inizio = toDate(data_inizio_str);

	    // Verifica se entrambe le date sono valide
	    if(data_fine && data_inizio){
	        // Confronta le date solo se entrambe sono valide
	        if(data_fine.getTime() < data_inizio.getTime()){
	            // Se la data di fine è precedente alla data di inizio, imposta la data di fine uguale alla data di inizio
	            $('#data_fine').val(data_inizio_str);
	        }
	    }
});


$('#data_fine').change(function(){
	
	  var data_fine_str = $('#data_fine').val();
	    var data_inizio_str = $('#data_inizio').val();

	    // Converti le stringhe in oggetti Date
	    var data_fine = toDate(data_fine_str);
	    var data_inizio = toDate(data_inizio_str);

	    // Verifica se entrambe le date sono valide
	    if(data_fine && data_inizio){
	        // Confronta le date solo se entrambe sono valide
	        if(data_fine.getTime() < data_inizio.getTime()){
	            // Se la data di fine è precedente alla data di inizio, imposta la data di fine uguale alla data di inizio
	            $('#data_fine').val(data_inizio_str);
	        }
	    }
	
});


function toDate(dateStr) {
  var parts = dateStr.split("/");
  if (parts.length === 3) {
      var day = parseInt(parts[0], 10);
      var month = parseInt(parts[1], 10) - 1; // I mesi in JavaScript sono 0-based, quindi sottraiamo 1
      var year = parseInt(parts[2], 10);
      return new Date(year, month, day);
  }
  return null; // Se la stringa di data non è nel formato corretto, restituisci null
}



function initializeTimepicker(start, end, mod) {
    $('#ora_inizio'+mod).timepicker({
        minuteStep: 5,
        disableTextInput: true,
        showMeridian: false,
        defaultTime: start, // Imposta l'orario di inizio predefinito
        // Callback per disabilitare gli orari sovrapposti
     
    
    }).on('changeTime.timepicker', function(e) {
        var inizio = moment($('#ora_inizio'+mod).val(), "HH:mm");
        var fine = moment($('#ora_fine'+mod).val(), "HH:mm");
    });

    $('#ora_fine'+mod).timepicker({
        minuteStep: 5,
        disableTextInput: true,
        showMeridian: false,
        defaultTime: end, 
 
    }).on('changeTime.timepicker', function(e) {
        var inizio = moment($('#ora_inizio'+mod).val(), "HH:mm");
        var fine = moment($('#ora_fine'+mod).val(), "HH:mm");
    });
}


$('#giornaliero').on('ifChecked', function(event){
	$('#check_giornaliero').val("SI");
	
});

$('#giornaliero').on('ifUnchecked', function(event) {
	
	$('#check_giornaliero').val("NO");

});

$('#giornaliero_mod').on('ifChecked', function(event){
	$('#check_giornaliero_mod').val("SI");
	
});

$('#giornaliero_mod').on('ifUnchecked', function(event) {
	
	$('#check_giornaliero_mod').val("NO");

});


$(document).ready(function() {
	
    $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
    
    $(".select2").select2()
   
	initializeTimepicker("08:00", "17:00","");

     $('.dropdown-toggle').dropdown();
     
     
  

     table = $('#tabRichieste').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabRichieste_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabRichieste').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaRichiestaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm('#modificaRichiestaForm','gestioneParcoAuto.do?action=modifica_richiesta');
});
 

 
 $('#NuovaRichiestaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#NuovaRichiestaForm','gestioneParcoAuto.do?action=nuova_richiesta');
	
});
 
 
 


 
  </script>
  
</jsp:attribute> 
</t:layout>

