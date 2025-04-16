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
        Lista oggetti in prova
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
	 Lista oggetti in prova A.M. Engineering
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">



<div class="col-xs-12">
<button class="btn btn-primary pull-right" onClick="$('#modalNuovoStrumento').modal()" style="margin-right:5px"><i class="fa fa-plus"></i> Nuovo Strumento</button> 
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAMStrumenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Descrizione</th>
<th>Matricola</th>
<th>Zona Riferimento Fasciame</th>
<th>Spessore Fasciame</th>
<th>Tipo</th>
<th>Volume</th>
<th>Materiale Fasciame</th>
<th>Pressione</th>
<th>Costruttore</th>
<th>Numero di fabbrica</th>
<th>Zona Riferimento Fondo</th>
<th>Spessore Fondo</th>
<th>Data Verifica</th>
<th>Data Prossima Verifica</th>
<th>Frequenza</th>
<th>Anno</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_strumenti }" var="strumento" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${strumento.id }</td>	
	<td>${strumento.descrizione }</td>
	<td>${strumento.matricola }</td>
	<td>${strumento.zonaRifFasciame }</td>
	<td>${strumento.spessoreFasciame }</td>
	<td>${strumento.tipo }</td>
	<td>${strumento.volume }</td>
	<td>${strumento.materialeFasciame }</td>
	<td>${strumento.pressione }</td>
	<td>${strumento.costruttore }</td>
	<td>${strumento.nFabbrica }</td>
	<td>${strumento.zonaRifFondo }</td>	
	<td>${strumento.spessoreFondo }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.dataVerifica }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${strumento.dataProssimaVerifica }" /></td>
	<td>${strumento.frequenza }</td>
	<td>${strumento.anno }</td>
	

	<td align="center">
	<%-- <a class="btn btn-info" onClicK="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')" title="Click per aprire il dettaglio dell'intervento"><i class="fa fa-arrow-right"></i></a>

	--%>
	
	<a class="btn btn-warning" title="Click per modificare l'intervento" onClick="modificaStrumento('${strumento.id}','${strumento.descrizione}','${strumento.matricola}','${strumento.zonaRifFasciame}','${strumento.spessoreFasciame}','${strumento.tipo}','${strumento.volume}','${strumento.materialeFasciame}','${strumento.pressione}','${strumento.costruttore}','${strumento.nFabbrica}','${strumento.zonaRifFondo}','${strumento.spessoreFondo}','<fmt:formatDate pattern="dd/MM/yyyy" value="${strumento.dataVerifica}" />','<fmt:formatDate pattern="dd/MM/yyyy" value="${strumento.dataProssimaVerifica}" />','${strumento.frequenza}','${strumento.anno}')"><i class="fa fa-edit"></i></a>
 
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





<form id="nuovoStrumentoForm">

  <div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Oggetto Prova</h4>
      </div>
       <div class="modal-body">

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione" name="descrizione" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola" name="matricola" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="zona_rif_fasciame" name="zona_rif_fasciame" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="spessore_fasciame" name="spessore_fasciame" style="width:100%" required>       	
       	</div>
       </div><br>
           <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo" name="tipo" style="width:100%" required>       	
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume" name="volume" style="width:100%" required>
       	</div>
       </div><br>
       
       		<div class="row">
       	<div class="col-sm-3">
       		<label>Materiale Fasciame</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="materiale_fasciame" name="materiale_fasciame" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione" name="pressione" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore" name="costruttore" style="width:100%" required>
       	</div>
       </div><br>
       
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica" name="numero_fabbrica" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="zona_rif_fondo" name="zona_rif_fondo" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="spessore_fondo" name="spessore_fondo" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno" name="anno"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza" name="frequenza" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica" name="data_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


<form id="modificaStrumentoForm">

  <div id="modalModificaStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione_mod" name="descrizione_mod" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="zona_rif_fasciame_mod" name="zona_rif_fasciame_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="spessore_fasciame_mod" name="spessore_fasciame_mod" style="width:100%" required>       	
       	</div>
       </div><br>
           <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo_mod" name="tipo_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume_mod" name="volume_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       		<div class="row">
       	<div class="col-sm-3">
       		<label>Materiale Fasciame</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="materiale_fasciame_mod" name="materiale_fasciame_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione_mod" name="pressione_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica_mod" name="numero_fabbrica_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="zona_rif_fondo_mod" name="zona_rif_fondo_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="spessore_fondo_mod" name="spessore_fondo_mod" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno_mod" name="anno_mod"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza_mod" name="frequenza_mod"  type="number" step="1" min="0" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica_mod" name="data_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_mod" name="data_prossima_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<input type="hidden" id="id_strumento" name="id_strumento">
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



	function modificaStrumento(id, descrizione, matricola, zonaRifFasciame, spessoreFasciame, tipo, volume, materialeFasciame, pressione, costruttore, nFabbrica, zonaRifFondo, spessoreFondo, dataVerifica, dataProssimaVerifica, frequenza, anno) { 

	$('#id_strumento').val(id);
	

	  $('#descrizione_mod').val(descrizione);
	    $('#matricola_mod').val(matricola);
	    $('#zona_rif_fasciame_mod').val(zonaRifFasciame);
	    $('#spessore_fasciame_mod').val(spessoreFasciame);
	    $('#tipo_mod').val(tipo);
	    $('#volume_mod').val(volume);
	    $('#materiale_fasciame_mod').val(materialeFasciame);
	    $('#pressione_mod').val(pressione);
	    $('#costruttore_mod').val(costruttore);
	    $('#numero_fabbrica_mod').val(nFabbrica);
	    $('#zona_rif_fondo_mod').val(zonaRifFondo);
	    $('#spessore_fondo_mod').val(spessoreFondo);
	    $('#data_verifica_mod').val(dataVerifica);
	    $('#data_prossima_verifica_mod').val(dataProssimaVerifica);
	    $('#frequenza_mod').val(frequenza);
	    $('#anno_mod').val(anno);
	
	 $('#modalModificaStrumento').modal()
}



$('#myModalModificaStrumento').on('hidden.bs.modal',function(){

	
	$(document.body).css('padding-right', '0px');
});






var columsDatatables = [];

$("#tabAMStrumenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAMStrumenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAMStrumenti thead th').eq( $(this).index() ).text();
    	
    	  
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
     



     table = $('#tabAMStrumenti').DataTable({
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
		    	  
		    	  { responsivePriority: 0, targets: 17 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAMStrumenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAMStrumenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});



 
 
 $('#modificaStrumentoForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#modificaStrumentoForm','amGestioneStrumenti.do?action=modifica');
	 
 });
 
 $('#nuovoStrumentoForm').on("submit", function(e){

	 e.preventDefault();
	 
	 callAjaxForm('#nuovoStrumentoForm','amGestioneStrumenti.do?action=nuovo');
	 
 });
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

