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
      Configurazioni Invio Email 
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	Lista Configurazioni
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">



<a class="btn btn-primary pull-right" onClick="modalnuovaConfigurazione()"><i class="fa fa-plus"></i> Nuova Configurazione</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabForConf" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Corso</th>
<th>Gruppo</th>
<th>Data inizio invio</th>
<th>Frequenza (Giorni)</th>
<th>Data prossimo invio</th>
<th>Data scadenza</th>
<th>Stato invio</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_configurazioni }" var="configurazione" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${configurazione.id }</td>	
	<td>${configurazione.descrizione_corso }</td>
	<td>${configurazione.descrizione_gruppo }</td>

		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_inizio_invio }"></fmt:formatDate></td>
	<td>${configurazione.frequenza_invio}</td>	
		
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_prossimo_invio }"></fmt:formatDate></td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${configurazione.data_scadenza }"></fmt:formatDate></td>
		<td>
		<c:if test="${configurazione.stato_invio == 0}">In corso</c:if>
		<c:if test="${configurazione.stato_invio == 1 }">Comunicazione inviata</c:if>
		<c:if test="${configurazione.stato_invio == 2}">Scaduta</c:if>
		</td>
	<td>
 	
	<a  class="btn btn-warning" onClicK="modificaConfigurazioneModal('${configurazione.id}','${configurazione.id_corso}','${configurazione.id_gruppo}','${configurazione.data_inizio_invio}','${configurazione.frequenza_invio }','${configurazione.data_prossimo_invio}','${configurazione.stato_invio }')" title="Click per modificare la Configurazione"><i class="fa fa-edit"></i></a>
	<a  class="btn btn-danger" onClicK="eliminaConfigurazioneModal('${configurazione.id}')" title="Click per eliminare la configurazione"><i class="fa fa-trash"></i></a>

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





<form id="nuovaConfigurazioneForm" name="nuovoDocenteForm">
<div id="myModalnuovaConfigurazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Configurazione Invio Email</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi" name="corsi" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." onchange="getGruppiFromCorso()">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}">${corso.descrizione }</option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi" name="gruppi" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." disabled onchange="getMembriGruppo()">

       </select>
       			
       	</div>       	
       </div><br>
       
       
      <div class="row" style="display:none" id="content_membri">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody id="body_membri">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>
       

       		

       
       		
       		
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Giorni)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza" name="frequenza" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
   
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio_invio" name="data_inizio_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_prossimo_invio" name="data_prossimo_invio" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_scadenza" name="data_scadenza">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaConfigurazioneForm" name="modificaConfigurazioneForm">
<div id="myModalModificaConfigurazione" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Tipologia Corso</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Corsi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="corsi_mod" name="corsi_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona corso..." onchange="getGruppiFromCorso('mod')">
       <option value=""></option>
       <c:forEach items="${lista_corsi_moodle}" var="corso">
       <option value="${corso.id}">${corso.descrizione }</option>
       </c:forEach>
       </select>
       			
       	</div>       	
       </div><br>
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Gruppi</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
       <select id="gruppi_mod" name="gruppi_mod" class="form-control select2" style="width:100%" data-placeholder="Seleziona gruppo..." onchange="getMembriGruppo('mod')">

       </select>
       			
       	</div>       	
       </div><br>
       
       
      <div class="row" style="display:none" id="content_membri_mod">
       
       	<div class="col-sm-12">
       		<label>Utenti nel gruppo</label>
       	</div>
       	<div class="col-sm-12">      
		<table class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
    		<thead>
        <tr>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody id="body_membri_mod">
    </tbody>
</table>
       			
       	</div>       	
       </div><br>
       

       		

       
       		
       		
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza (Giorni)</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_mod" name="frequenza_mod" class="form-control" type="number" step="1" min="0" style="width:100%" required>
       			
       	</div>       	
       </div><br>
   
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data inizio invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_inizio'>
               <input type='text' class="form-control input-small" id="data_inizio_invio_mod" name="data_inizio_invio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>

   <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo invio</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_prossimo_invio_mod" name="data_prossimo_invio_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
               	  	
         <div class='input-group date datepicker' id='datepicker_data_prossimo'>
               <input type='text' class="form-control input-small" id="data_scadenza_mod" name="data_scadenza_mod">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 	
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_configurazione" name="id_configurazione"> 
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>





  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare la configurazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_configurazione_id">
      <a class="btn btn-primary" onclick="eliminaConfigurazione($('#elimina_configurazione_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
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


function modalnuovaConfigurazione(){
	
	$('#myModalnuovaConfigurazione').modal();
	
}

function eliminaConfigurazioneModal(id_conf){
	
	$('#elimina_configurazione_id').val(id_conf)
	
	$('#myModalYesOrNo').modal();
	
}

function eliminaConfigurazione(){
	
	dataObj = {};
	dataObj.id_configurazione_elimina = $('#elimina_configurazione_id').val();
	
	callAjax(dataObj, "gestioneFormazione.do?action=elimina_configurazione");
	
}

function modificaConfigurazioneModal(id_configurazione, id_corso, id_gruppo, data_inizio, frequenza, data_prossimo_invio, stato, data_scadenza){
	
	$('#id_configurazione').val(id_configurazione);
	$('#corsi_mod').val(id_corso);
	$('#corsi_mod').change();
	
	
	

	$('#frequenza_mod').val(frequenza);
	$('#data_inizio_invio_mod').val(Date.parse(data_inizio).toString("dd/MM/yyyy"));
	$('#data_prossimo_invio_mod').val(Date.parse(data_prossimo_invio).toString("dd/MM/yyyy"));
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));
	}
	
	if(id_gruppo!=null && id_gruppo!=0){
		getGruppiFromCorso("mod", id_gruppo)	
		
		
	}else{
	
		
		$('#myModalModificaConfigurazione').modal();
	}
}

var columsDatatables = [];

$("#tabForConf").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForConf thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForConf thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function getGruppiFromCorso(mod, id_gruppo){
	
	if(mod!=null){
		var corso = $('#corsi_mod').val();
	}else{
		var corso = $('#corsi').val();	
	}
	
	
	dataObj={};
	dataObj.corso = corso;
	
	callAjax(dataObj, "gestioneFormazione.do?action=gruppi_corso",function(data, textStatus){
		
		if(data.success){
			
			var gruppi = data.gruppi;
				
				var html = '<option value=""></option>';
				html = html+'<option value="0">Nessun gruppo</option>';
				for (var i = 0; i < gruppi.length; i++) {
					html = html+'<option value="'+gruppi[i].id+'">'+gruppi[i].descrizione+'</option>';
				}
				
				if(mod!=null){	
					$('#gruppi_mod').html(html);
					$('#gruppi_mod').val(id_gruppo)
					$('#gruppi_mod').attr("disabled", false);
					getMembriGruppo('mod');
					
					
					
					
				}else{
					$('#gruppi').html(html);
					$('#gruppi').attr("disabled", false);
				}
			
		}
		
		
	});
	
}


function getMembriGruppo(mod){
	
	if(mod!=null){
		var gruppo = $('#gruppi_mod').val();
		var corso = $('#corsi_mod').val();
	}else{
		var gruppo = $('#gruppi').val();
		var corso = $('#corsi').val();
	}


if(gruppo!=null && gruppo!=''){
	dataObj={};
	dataObj.gruppo = gruppo;
	dataObj.corso = corso;
	
	callAjax(dataObj, "gestioneFormazione.do?action=membri_gruppo",function(data, textStatus){
		
		if(data.success){
			
			var membri = data.membri;
			var membri_nc = data.membri_nc	
				
			if(membri.length==0){
				if(mod!=null){
					$("#body_membri_mod").html("Nessun utente nel gruppo selezionato");
					$('#content_membri_mod').show();
					$('#myModalModificaConfigurazione').modal();
				}else{
					$("#body_membri").html("Nessun utente nel gruppo selezionato");
					$('#content_membri').show();
				}
			}else{
				
				var array_email =[]; 
				 $.each(membri_nc, function(index, item) {
					 array_email.push(item.email);
				 });
				
				 var row = "";
				    $.each(membri, function(index, item) {
				    	
				    	if(array_email.includes(item.email)){
				    		row += "<tr style='background-color:#FA8989'>";
					        row += "<td>" + item.nome + "</td>";
					        row += "<td>" + item.cognome + "</td>";
					        row += "<td>" + item.email + "</td>";
					        row += "</tr>";
				    	}else{
				    		row += "<tr>";
					        row += "<td>" + item.nome + "</td>";
					        row += "<td>" + item.cognome + "</td>";
					        row += "<td>" + item.email + "</td>";
					        row += "</tr>";
				    	}
				        
				       
				    });
						
				    if(mod!=null){
				    	$("#body_membri_mod").html(row);
				    	$('#content_membri_mod').show();
				    	$('#myModalModificaConfigurazione').modal();
				    }else{
				    	$("#body_membri").html(row);
				    	$('#content_membri').show();
				    }
			}
			
			
		}
		
		
	});
}
	

	
}


$('#data_inizio_invio').change(function(){
	
	  var frequenza = $('#frequenza').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  var data =  Date.parse(formatDate($('#data_inizio_invio').val()));	
		  var data_scadenza = data.addDays(parseInt(frequenza));
		  $('#data_prossimo_invio').val(formatDate(data_scadenza));
	  }
	 
});


$('#frequenza').change(function(){
	
	  var frequenza = $('#frequenza').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  if($('#data_inizio_invio').val()!=null && $('#data_inizio_invio').val()!=''){
			  var data =  Date.parse(formatDate($('#data_inizio_invio').val()));	
			  var data_scadenza = data.addDays(parseInt(frequenza));
			  $('#data_prossimo_invio').val(formatDate(data_scadenza));
		  }
		
	  }
	 
});



$('#data_inizio_invio_mod').change(function(){
	
	  var frequenza = $('#frequenza_mod').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  var data =  Date.parse(formatDate($('#data_inizio_invio_mod').val()));	
		  var data_scadenza = data.addDays(parseInt(frequenza));
		  $('#data_prossimo_invio_mod').val(formatDate(data_scadenza));
	  }
	 
});


$('#frequenza_mod').change(function(){
	
	  var frequenza = $('#frequenza_mod').val();
	  
	  if(frequenza!=null && frequenza!=''){
	
		  if($('#data_inizio_invio_mod').val()!=null && $('#data_inizio_invio_mod').val()!=''){
			  var data =  Date.parse(formatDate($('#data_inizio_invio_mod').val()));	
			  var data_scadenza = data.addDays(parseInt(frequenza));
			  $('#data_prossimo_invio_mod').val(formatDate(data_scadenza));
		  }
		
	  }
	 
});


function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}



$(document).ready(function() {
 
    var oggi = new Date();
    var giorno = oggi.getDate();
    var mese = oggi.getMonth() + 1; 
    var anno = oggi.getFullYear();


    var dataOggi = (giorno < 10 ? '0' : '') + giorno + '/' + (mese < 10 ? '0' : '') + mese + '/' + anno;


	$('#data_inizio_invio').val(dataOggi);

     $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });   

     table = $('#tabForConf').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 7 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabForConf_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabForConf').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});


$('#modificaConfigurazioneForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm("#modificaConfigurazioneForm", "gestioneFormazione.do?action=modifica_configurazione_invio")
	 
});
 

 
 $('#nuovaConfigurazioneForm').on('submit', function(e){
	 e.preventDefault();

	 callAjaxForm("#nuovaConfigurazioneForm", "gestioneFormazione.do?action=nuova_configurazione_invio")
	 
	})
 
 
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

