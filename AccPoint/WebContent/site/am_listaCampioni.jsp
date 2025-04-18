<%@page import="java.util.ArrayList"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="it.portaleSTI.DTO.AMOperatoreDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


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
        Lista Campioni AM
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
	 Lista Campioni A.M. Engineering
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">



<div class="col-xs-12">
<button class="btn btn-primary pull-right" onClick="$('#modalNuovoCampione').modal()" style="margin-right:5px"><i class="fa fa-plus"></i> Nuovo Campione</button> 
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAMCampioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Tipo Campione</th>
<th>Codice Interno</th>
<th>Denominazione</th>
<th>Matricola</th>
<th>Modello</th>
<th>Costruttore</th>
<th>Numero di Certificato</th>
<th>Data Taratura</th>
<th>Frequenza</th>
<th>Data Scadenza Certificato</th>

<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_campioni }" var="campione" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${campione.id }</td>	
	<td>${campione.tipoCampione.denominazione }</td>
	<td>${campione.codiceInterno}</td>
	<td>${campione.denominazione}</td>
	<td>${campione.matricola}</td>
	<td>${campione.modello}</td>
	<td>${campione.costruttore}</td>
	<td>${campione.nCertificato}</td>

	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${campione.dataTaratura }" /></td>
	<td>${campione.frequenza}</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${campione.dataScadenzaCertifica }" /></td>

	

	<td align="center">
	<%-- <a class="btn btn-info" onClicK="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')" title="Click per aprire il dettaglio dell'intervento"><i class="fa fa-arrow-right"></i></a>

	--%>
	
	<a class="btn btn-warning" title="Click per modificare il campione" onClick="modificaCampione('${campione.id}')"><i class="fa fa-edit"></i></a>
 
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





<form id="nuovoCampioneForm">

  <div id="modalNuovoCampione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Campione</h4>
      </div>
       <div class="modal-body">

		<div class="row">
	<div class="col-sm-3">
		<label>Tipo Campione</label>
	</div>
	<div class="col-sm-9">
	<select  id="tipoCampione" name="tipoCampione" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" data-placeholder="Seleziona Tipo Campione...">
	<option value=""></option>
				<c:forEach items="${lista_tipi_campione }" var="tipo">
				
				<option value="${tipo.id }">${tipo.denominazione }</option>
					
				</c:forEach>
				</select>

	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Codice Interno</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="codiceInterno" name="codiceInterno" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Denominazione</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="denominazione" name="denominazione" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Matricola</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="matricola" name="matricola" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Modello</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="modello" name="modello" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Costruttore</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="costruttore" name="costruttore" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Numero di Certificato</label>
	</div>
	<div class="col-sm-9">
		<input class="form-control" id="nCertificato" name="nCertificato" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Data Taratura</label>
	</div>
	<div class="col-sm-9">
		<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_taratura" name="data_taratura" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
	</div>
</div>
</div><br>
<div class="row">
	<div class="col-sm-3">
		<label>Frequenza</label>
	</div>
	<div class="col-sm-9">
		<input type="number" class="form-control" id="frequenza" name="frequenza" style="width:100%" >
	</div>
</div><br>

<div class="row">
	<div class="col-sm-3">
		<label>Data Scadenza Certificato</label>
	</div>
	<div class="col-sm-9">
		<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_scadenza_certificato" name="data_scadenza_certificato" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
	</div>
	</div>
</div><br>

    
      
       
       
       <div id="content_tipoCampione" style="display:none">
       
       
</div>       


  		
  		 </div>
      <div class="modal-footer">

        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


<form id="modificaCampioneForm">

  <div id="modalModificaCampione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Campione</h4>
      </div>
      <div class="modal-body">

	<div class="row">
		<div class="col-sm-3">
			<label>Tipo Campione</label>
		</div>
		<div class="col-sm-9">
			<select id="tipoCampione_mod" name="tipoCampione_mod" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" data-placeholder="Seleziona Tipo Campione...">
				<option value=""></option>
				<c:forEach items="${lista_tipi_campione }" var="tipo">
					<option value="${tipo.id }">${tipo.denominazione }</option>
				</c:forEach>
			</select>
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Codice Interno</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="codiceInterno_mod" name="codiceInterno_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Denominazione</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="denominazione_mod" name="denominazione_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Matricola</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Modello</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="modello_mod" name="modello_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Costruttore</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Numero di Certificato</label>
		</div>
		<div class="col-sm-9">
			<input class="form-control" id="nCertificato_mod" name="nCertificato_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Data Taratura</label>
		</div>
		<div class="col-sm-9">
			<div class='input-group date datepicker' id='datepicker_data_taratura_mod'>
				<input type='text' class="form-control input-small" id="data_taratura_mod" name="data_taratura_mod">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Frequenza</label>
		</div>
		<div class="col-sm-9">
			<input type="number" class="form-control" id="frequenza_mod" name="frequenza_mod" style="width:100%">
		</div>
	</div><br>

	<div class="row">
		<div class="col-sm-3">
			<label>Data Scadenza Certificato</label>
		</div>
		<div class="col-sm-9">
			<div class='input-group date datepicker' id='datepicker_data_scadenza_certificato_mod'>
				<input type='text' class="form-control input-small" id="data_scadenza_certificato_mod" name="data_scadenza_certificato_mod">
				<span class="input-group-addon">
					<span class="fa fa-calendar"></span>
				</span>
			</div>
		</div>
	</div><br>

	<div id="content_tipoCampione_mod" style="display:none"></div>

</div>

      <div class="modal-footer">
		<input type="hidden" id="id_campione" name="id_campione">
        <button type="submit" class="btn btn-danger"  >Salva</button>
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
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
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







$('#modalNuovoCampione').on('hidden.bs.modal',function(){

	$('#tipoCampione').val("");
	$('#tipoCampione').change();
	$('#codiceInterno').val("");
	$('#denominazione').val("");
	$('#matricola').val("");
	$('#modello').val("");
	$('#costruttore').val("");
	$('#nCertificato').val("");
	$('#data_taratura').val("");
	$('#frequenza').val("");
	$('#data_scadenza_taratura').val("");
	$('#content_tipoCampione').hide()
	
	
	$(document.body).css('padding-right', '0px');
});


$('#modalModificaCampione').on('hidden.bs.modal',function(){

	$('#tipoCampione_mod').val("");
	$('#tipoCampione_mod').change();
	$('#codiceInterno_mod').val("");
	$('#denominazione_mod').val("");
	$('#matricola_mod').val("");
	$('#modello_mod').val("");
	$('#costruttore_mod').val("");
	$('#nCertificato_mod').val("");
	$('#data_taratura_mod').val("");
	$('#frequenza_mod').val("");
	$('#data_scadenza_taratura_mod').val("");
	$('#content_tipoCampione_mod').hide()
	campioneCorrente = null;
	
	
	$(document.body).css('padding-right', '0px');
});



var columsDatatables = [];

$("#tabAMCampioni").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAMCampioni thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAMCampioni thead th').eq( $(this).index() ).text();
    	
    	  
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



function aggiornaDataProssima(mod) {
    var frequenza = parseInt($('#frequenza'+mod).val(), 10);
    var dataVerificaStr = $('#data_verifica'+mod).val(); // formato: dd/MM/yyyy

    if (!isNaN(frequenza) && dataVerificaStr) {
        var parts = dataVerificaStr.split('/');
        var giorno = parseInt(parts[0], 10);
        var mese = parseInt(parts[1], 10) - 1; // JavaScript usa 0-based per i mesi
        var anno = parseInt(parts[2], 10);

        var data = new Date(anno, mese, giorno);
        data.setMonth(data.getMonth() + frequenza);

        var nuovoGiorno = ('0' + data.getDate()).slice(-2);
        var nuovoMese = ('0' + (data.getMonth() + 1)).slice(-2);
        var nuovoAnno = data.getFullYear();

        $('#data_prossima_verifica'+mod).val(nuovoGiorno + '/' + nuovoMese + '/' + nuovoAnno);
    } else {
        $('#data_prossima_verifica'+mod).val('');
    }
}

$('#frequenza_mod, #data_verifica_mod').on('change input', function() {
    aggiornaDataProssima("_mod");
});


$('#frequenza, #data_verifica').on('change input', function() {
    aggiornaDataProssima("");
});

function camelCaseToLabel(str) {
    return str
      .replace(/([A-Z])/g, ' $1') // Spazio prima delle maiuscole
      .replace(/^./, function(s) { return s.toUpperCase(); }); // Prima lettera maiuscola
  }



$('#tipoCampione, #tipoCampione_mod' ).change(function(){
	
	var value =$(this).val();
	
	if(value!=null && value!=''){
		
		dataObj={};
		dataObj.id_tipo = value;
		
		var container = $('#content_'+$(this)[0].id)
		
		callAjax(dataObj, "amGestioneCampioni.do?action=get_tipo", function(data, textStatus){
			
			
			container.html("");
			container.hide()
				
				var tipo_campione = data.tipo_campione;
			var promises = [];
			
			var keys = tipo_campione.visibilitaColonne.split(";")
			
				keys.forEach(function (key) {
					
					if(container[0].id.includes("_mod")){
						key = key+"_mod";	
						var campione = campioneCorrente;
					}
					
					
				      const label = camelCaseToLabel(key).replace("_mod","");
				      const input = '<div class="row"><div class="col-sm-3"><label for="' + key + '">' + label + '</label></div><div class="col-sm-9"><input class="form-control" id="' + key + '" name="' + key + '" style="width:100%"></div></div><br>';
										      
				      container.append(input);
				      if(container[0].id.includes("_mod")){
				      	$('#' + key).val(campione[key.replace("_mod","")]);
				      }
				})
				

					container.show();

			
		}, "GET");
	}
	
	
	
});

var campioneCorrente

function modificaCampione(id_campione){
	
	dataObj = {}
	dataObj.id_campione = id_campione;

	callAjax(dataObj, "amGestioneCampioni.do?action=get_campione", function(data, textStatus){
		
		
			var campione = data.campione;
			campioneCorrente = campione;
				
			$('#tipoCampione_mod').val(campione.tipoCampione.id);
			$('#tipoCampione_mod').change()

			$('#codiceInterno_mod').val(campione.codiceInterno);
			$('#denominazione_mod').val(campione.denominazione);
			$('#matricola_mod').val(campione.matricola);
			$('#modello_mod').val(campione.modello);
			$('#costruttore_mod').val(campione.costruttore);
			$('#nCertificato_mod').val(campione.nCertificato);
			$('#data_taratura_mod').val(campione.dataTaratura);
			$('#frequenza_mod').val(campione.frequenza);
			$('#data_scadenza_certificato_mod').val(campione.dataScadenzaCertifica);
			
			$('#id_campione').val(id_campione)


			$('#modalModificaCampione').modal()
			

	}, "GET");

	
}

var commessa_options;
$(document).ready(function() {
 
	
	
	
	commessa_options = $('#commessa_mod option').clone();
	
	$(".select2").select2();

	
	//initSelect2('#cliente_mod');
	//$('#cliente_mod').change();
	$('#sede_mod').select2();
	$('#commessa_mod').select2();
	$('#tecnico_verificatore_mod').select2();
	$('#luogo_mod').select2();
	$('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	//$('.datepicker').datepicker('setDate', new Date());
    $('.dropdown-toggle').dropdown();
     



     table = $('#tabAMCampioni').DataTable({
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
	        "order": [[ 2, "desc" ]],
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
		    	  
		    	  { responsivePriority: 0, targets: 11 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAMCampioni_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAMCampioni').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});



 
 
 $('#modificaCampioneForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#modificaCampioneForm','amGestioneCampioni.do?action=modifica');
	 
 });
 
 $('#nuovoCampioneForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#nuovoCampioneForm','amGestioneCampioni.do?action=nuovo');
	 
 });
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

