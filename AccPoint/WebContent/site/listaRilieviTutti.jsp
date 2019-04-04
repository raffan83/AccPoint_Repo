<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

    <div class="row">
<div class="col-sm-12">

<c:choose>
<c:when test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
<button class="btn btn-primary" onClick="modalNuovoRilievo()"><i class="fa fa-plus"></i> Nuovo Rilievo</button>
<button class="btn btn-info pull-right" title="Click per aprire la lista delle schede di consegna"  onClick="callAction('showSchedeConsegna.do?action=rilievi')"><i class="fa fa-list-ul"></i></button> 
 <!-- <button class="btn btn-info pull-right" title="Click per aprire la lista delle schede di consegna"  onClick="modalListaSchedeConsegna()"><i class="fa fa-list-ul"></i></button> -->

<button class="btn btn-primary pull-right" style="margin-right:5px" onClick="modalSchedaConsegna()"><i class="fa fa-plus"></i> Crea Scheda Consegna</button>
</c:when>
<c:otherwise>
<!-- <button class="btn btn-primary" onClick="modalNuovoRilievo()" disabled><i class="fa fa-plus"></i> Nuovo Rilievo</button> -->
</c:otherwise>
</c:choose>

</div>
</div><br>
    <div class="row">
<div class="col-sm-12">

 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Numero Scheda</th>
<th>Mese di riferimento</th>
<th>Disegno</th>
<th>Variante</th>
<th>Tipo Rilievo</th>
<th>Quote Totali</th>
<th>Pezzi Totali</th>
<th>Cliente</th>
<th>Sede</th>
<th>Apparecchio</th>
<th>Fornitore</th>
<th>Stato Rilievo</th>
<th>Commessa</th>
<th>Data Inizio Rilievo</th>
<th>Data Consegna</th>
<th>Denominazione</th>
<th>Materiale</th>
<th>Classe di tolleranza</th>
<th>Utente</th>
<th style="min-width:230px">Azioni</th>
<th>Allegati Scheda</th>
<th>Archivio</th>
<th>Scheda Consegna</th>

<th>ID</th>
<th>Note</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">
	<tr id="row_${loop.index}" >
		
		<td>${rilievo.numero_scheda }</td>
		<td>${rilievo.mese_riferimento }</td>
		<td>${rilievo.disegno }</td>
		<td>${rilievo.variante }</td>
		<td>${rilievo.tipo_rilievo.descrizione }</td>
		<td>${rilievo.n_quote }</td>
		<td>${rilievo.n_pezzi_tot }</td>
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.apparecchio }</td>	
		<td>${rilievo.fornitore }</td>
		<td>${rilievo.stato_rilievo.descrizione }</td>
		
		<td>${rilievo.commessa}</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>	
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_consegna }" /></td>	
		<td>${rilievo.denominazione }</td>
		<td>${rilievo.materiale }</td>
		<td>${rilievo.classe_tolleranza }</td>
		<td>${rilievo.utente.nominativo }</td>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') || (userObj.checkPermesso('VISUALIZZA_RILIEVI_DIMENSIONALI') && rilievo.stato_rilievo.id==2)}">
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${utl:encryptData(rilievo.id)}')"><i class="fa fa-search"></i></a>
		</c:if>
		<c:if test="${ userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<c:choose>
		<c:when test="${rilievo.stato_rilievo.id==1 }">
			
			<a href="#" class="btn btn-warning customTooltip" title="Click per modificare il rilievo" onclick="modalModificaRilievo('${rilievo.id }','${rilievo.data_inizio_rilievo }','${rilievo.tipo_rilievo.id }','${rilievo.id_cliente_util }','${rilievo.id_sede_util }','${rilievo.commessa}',
			'${rilievo.disegno }', '${rilievo.variante }', '${rilievo.fornitore }', '${rilievo.apparecchio }', '${rilievo.data_inizio_rilievo }','${rilievo.mese_riferimento }','${rilievo.cifre_decimali }','${rilievo.classe_tolleranza }','${rilievo.denominazione }','${rilievo.materiale }','${rilievo.note}')">		
			<i class="fa fa-edit"></i></a>
			<a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievo('${rilievo.id}')"><i class="fa fa-clone"></i></a>
			<a href="#" class="btn btn-danger customTooltip" title="Click per chiudere il rilievo" onclick="chiudiRilievo('${rilievo.id}')"><i class="glyphicon glyphicon-remove"></i></a>
			<a href="#" class="btn btn-danger customTooltip" title="Click per eliminare il rilievo" onclick="eliminaRilievoModal('${rilievo.id}')"><i class="fa fa-trash"></i></a>
			<a target="_blank" class="btn btn-danger customTooltip" title="Click per creare la scheda del rilievo" href="gestioneRilievi.do?action=crea_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>
		</c:when>
		<c:otherwise>
		<a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievo('${rilievo.id}')"><i class="fa fa-clone"></i></a>
		</c:otherwise>
		</c:choose>
		</c:if>
		<%-- <a href="#" class="btn btn-success customTooltip" title="Click per creare la scheda excel del rilievo" onclick="callAction('gestioneRilievi.do?action=crea_scheda_rilievo_excel&id_rilievo=${utl:encryptData(rilievo.id)}')"><i class="fa fa-file-excel-o"></i></a> --%>
		<c:if test="${ userObj.checkPermesso('VISUALIZZA_RILIEVI_DIMENSIONALI') && rilievo.stato_rilievo.id==2}">
			<a  target="_blank" class="btn btn-danger customTooltip" title="Click per creare la scheda del rilievo" href="gestioneRilievi.do?action=crea_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>		
		</c:if>
		</td>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<a href="#" class="btn btn-primary customTooltip" title="Click allegare un file" onclick="modalAllegati('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>
		<a href="#" class="btn btn-primary customTooltip" title="Click allegare un certificato campione" onclick="modalCertificatiCampione('${rilievo.id }')"><i class="fa fa-file"></i></a>
		<a href="#" class="btn btn-primary customTooltip" title="Click per inserire un'immagine per il frontespizio" onclick="modalAllegatiImg('${rilievo.id }')"><i class="fa fa-image"></i></a>
		
			<c:if test="${rilievo.allegato!= null && rilievo.allegato !='' }">
				<a target ="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(rilievo.id)}" ><i class="fa fa-file-pdf-o"></i></a>
			</c:if>
			<c:if test="${rilievo.immagine_frontespizio != null && rilievo.immagine_frontespizio != '' }">
				<a class="btn btn-danger customTooltip" title="Click per scaricare l'immagine del frontespizio" onClick="callAction('gestioneRilievi.do?action=download_immagine&id_rilievo=${utl:encryptData(rilievo.id)}')" ><i class="fa fa-arrow-down"></i></a>
			</c:if>
		</c:if>
		</td>
		
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<a href="#" class="btn btn-info customTooltip" title="Click per inserire un file in archivio" onclick="modalAllegatiArchivio('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>		
		<a href="#" class="btn btn-info customTooltip" title="Click per visualizzare l'archivio" onclick="modalArchivio('${rilievo.id }')"><i class="fa fa-archive"></i></a>
		</c:if>
		</td>
		<td>
		<c:choose>
		<c:when test="${rilievo.scheda_consegna==1 }">
		SI
		</c:when>
		<c:otherwise>
		NO
		</c:otherwise>
		</c:choose>
		</td>
		<td>${rilievo.id }</td>
		
		<td>${rilievo.note }</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>




 <script type="text/javascript">
 
 function modalCertificatiCampione(id_rilievo){
	 dataString ="rilievi=true&id_rilievo="+id_rilievo;
     exploreModal("listaCampioni.do",dataString,"#body_certificati_campione",function(datab,textStatusb){});
     
    $('#myModalCertificatiCampione').modal();
 }
 

	$('#myModalCertificatiCampione').on('hidden.bs.modal', function(){
		
		$(document.body).css('padding-right', '0px');
		$('#tabCampioni').remove();
		$('#body_certificati_campione').html("");
		
		
	});
 
 function eliminaRilievoModal(id_rilievo){
	 $('#elimina_rilievo_id').val(id_rilievo);
	 $('#myModalYesOrNo').modal();
 }
 
 function modalAllegati(id_rilievo){
	 
	 $('#id_rilievo').val(id_rilievo);
	 $('#myModalAllegati').modal();
}
 
 function modalAllegatiImg(id_rilievo){
	 
	 $('#id_rilievo').val(id_rilievo);
	 $('#myModalAllegatiImg').modal();
}
 
/*  function modalListaSchedeConsegna(){
	 exploreModal('showSchedeConsegna.do','action=rilievi','#content_schede_consegna');
	 $('#myModalListaSchedeConsegna').modal();
	 $('#myModalListaSchedeConsegna').on('shown.bs.modal', function (){
	    	table = $('#tabPM').DataTable();
   		 table.columns().eq( 0 ).each( function ( colIdx ) {
  			 $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
  				 table
  			      .column( colIdx )
  			      .search( this.value )
  			      .draw();
  			 } );
  			 } );    
  		table.columns.adjust().draw(); 
   });
 } */
 
 function modalSchedaConsegna(){
	 
	 if($('#cliente_filtro').val()!="0" && $('#cliente_filtro').val()!=""){
			
			var opt = $('#cliente_filtro option[value="'+$('#cliente_filtro').val()+'"]').clone();
		 	$('#cliente_scn').html(opt);
		 	$('#cliente_scn').change();
		 	$('#cliente_scn').select2();
		 	$('#sede_scn').val("0");
		 	$('#sede_scn').select2();
	 	} else{
	 		$('#cliente_scn').html(options_cliente);
	 		$('#cliente_scn').val(""); 		
	 		$('#cliente_scn').select2();
	 		$('#sede_scn').html(options_sede);
	 		$('#sede_scn').val("");
	 		$('#sede_scn').select2();

	 	} 
	 
	 $('#myModalSchedaConsegna').modal();
 }
 function modalArchivio(id_rilievo){
	 
	 $('#tab_archivio').html("");
	 dataString ="action=lista_file_archivio&id_rilievo="+ id_rilievo;
     exploreModal("gestioneRilievi.do",dataString,"#tab_archivio",function(datab,textStatusb){
     });
$('#myModalArchivio').modal();
 }
 
 function modalAllegatiArchivio(id_rilievo){
	 
	 $('#fileupload').fileupload({
		 url: "gestioneRilievi.do?action=allegati_archivio&id_rilievo="+id_rilievo,
		 dataType: 'json',	 
		 getNumberOfFiles: function () {
		     return this.filesContainer.children()
		         .not('.processing').length;
		 }, 
		 start: function(e){
		 	pleaseWaitDiv = $('#pleaseWaitDialog');
		 	pleaseWaitDiv.modal();
		 	
		 },
		 singleFileUploads: false,
		  add: function(e, data) {
		     var uploadErrors = [];
		     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx|dxf|dwg|stp|igs|iges|catpart|eml|msg|rar|zip)$/i;
		     
		     for(var i =0; i< data.originalFiles.length; i++){
		    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
			         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
			         break;
			     }	 
		    	 if(data.originalFiles[i]['size'] > 30000000) {
			         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 30mb');
			         break;
			     }
		     }	     		     
		     if(uploadErrors.length > 0) {
		     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
		 			$('#myModalError').removeClass();
		 			$('#myModalError').addClass("modal modal-danger");
		 			$('#myModalError').modal('show');
		     } 
 		     else {
		         data.submit();
		     }  
		 },
		
		 done: function (e, data) {
		 		
		 	pleaseWaitDiv.modal('hide');
		 	
		 	if(data.result.success){
		 		$('#myModalAllegatiArchivio').modal('hide');
		 		$('#myModalErrorContent').html(data.result.messaggio);
	 			$('#myModalError').removeClass();
	 			$('#myModalError').addClass("modal modal-success");
	 			$('#myModalError').modal('show');
		 	}else{		 			
		 			$('#myModalErrorContent').html(data.result.messaggio);
		 			$('#myModalError').removeClass();
		 			$('#myModalError').addClass("modal modal-danger");
		 			$('#report_button').show();
		 			$('#visualizza_report').show();
		 			$('#myModalError').modal('show');
		 		}
		 },
		 fail: function (e, data) {
		 	pleaseWaitDiv.modal('hide');

		     $('#myModalErrorContent').html(errorMsg);
		     
		 		$('#myModalError').removeClass();
		 		$('#myModalError').addClass("modal modal-danger");
		 		$('#report_button').show();
		 		$('#visualizza_report').show();
		 		$('#myModalError').modal('show');

		 		$('#progress .progress-bar').css(
		                'width',
		                '0%'
		            );
		 },
		 progressall: function (e, data) {
		     var progress = parseInt(data.loaded / data.total * 100, 10);
		     $('#progress .progress-bar').css(
		         'width',
		         progress + '%'
		     );

		 }
	 });		
	 $('#myModalAllegatiArchivio').modal();
}
 
 function modalNuovoRilievo(){
	// $('#cliente').select2();
	
	 if($('#cliente_filtro').val()!="0" && $('#cliente_filtro').val()!=""){
			
			var opt = $('#cliente_filtro option[value="'+$('#cliente_filtro').val()+'"]').clone();
		 	$('#cliente').html(opt);
		 	$('#cliente').change();
		 	$('#cliente').select2();
		 	$('#sede').val("0");
		 	$('#sede').select2();
	 	} else{
	 		$('#cliente').html(options_cliente);
	 		$('#cliente').val(""); 		
	 		$('#cliente').select2();
	 		$('#sede').html(options_sede);
	 		$('#sede').val("");
	 		$('#sede').select2();

	 	} 
	 $('#commessa').val('');
	 $('#commessa').change();
	 $('#disegno').val('');
	 $('#denominazione').val('');
	 $('#variante').val('');
	 $('#materiale').val('');
	 $('#fornitore').val('');
	 $('#apparecchio').val('');
	 $('#tipo_rilievo').val('');
	 $('#tipo_rilievo').change();
	 $('#data_inizio_rilievo').val('');
	 $('#mese_riferimento').val('');
	 $('#mese_riferimento').change();
	 $('#note_rilievo').val('');
	 
	 $('#myModalNuovoRilievo').modal();
 }
 
 function dettaglioRilievo(id_rilievo) {
	
	 var cliente = '${utl:encryptData(cliente_filtro)}';
	  var filtro = '${utl:encryptData(filtro_rilievi)}';

 	 //dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+$('#cliente_filtro').val()+"&filtro_rilievi=" +$('#filtro_rilievi').val();
	 dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+cliente+"&filtro_rilievi="+filtro; 
 	 
	  callAction("gestioneRilievi.do"+dataString, false, false);
 }

	var columsDatatables = [];
	 
	$("#tabRilievi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabRilievi thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabRilievi thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	
	    	} );
	    
	    

	} );
	

	
     var validator = $("#nuovoRilievoForm").validate({

    	showErrors: function(errorMap, errorList) {
    	  	
    	    this.defaultShowErrors();
    	    if($('#cliente').hasClass('has-error')){
				$('#cliente').css('background-color', '1px solid #f00');
			}
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#label").show();
    		 },
    		 
    		    highlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
    		    	}else{
    		    		$(element).css('border', '1px solid #f00');    		        
    		    	}    		        
    		    	$('#label').show();
    		    },
    		    unhighlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
    		    	}else{
    		    		$(element).css('border', '1px solid #d2d6de');
    		    	}
    		    	
    		    }
    }); 
	
     var validator2 = $("#modificaRilievoForm").validate({

     	showErrors: function(errorMap, errorList) {
     	  	
     	    this.defaultShowErrors();
     	    if($('#mod_cliente').hasClass('has-error')){
 				$('#mod_cliente').css('background-color', '1px solid #f00');
 			}
     	  },
     	  errorPlacement: function(error, element) {
     		  $("#mod_label").show();
     		 },
     		 
     		    highlight: function(element) {
     		    	if($(element).hasClass('select2')){
     		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
     		    	}else{
     		    		$(element).css('border', '1px solid #f00');    		        
     		    	}    		        
     		    	$('#mod_label').show();
     		    },
     		    unhighlight: function(element) {
     		    	if($(element).hasClass('select2')){
     		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
     		    	}else{
     		    		$(element).css('border', '1px solid #d2d6de');
     		    	}
     		    	
     		    }
     }); 
 
 
 var ril;
 var commessa_options;
 
$(document).ready(function() {
	
	 commessa_options = $('#commessa option').clone();
	//$('#body_certificati_campione').html("");
	 $('#label').hide();
	 $('.select2').select2();
	 $('#cliente').select2({
		 dropdownParent: $('#myModalNuovoRilievo'),
		 });

	 $('#cliente').css("text-align", "left");
	 $('#sede').select2({
		dropdownParent: $('#myModalNuovoRilievo')
	 	});
	 $('#mod_cliente').select2({
		dropdownParent: $('#myModalModificaRilievo')
	 	});
	 $('#mod_sede').select2({
	  	dropdownParent: $('#myModalModificaRilievo')
		 }); 
		 
	 $('#mod_label').hide();
	 $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	 
	 $('.dropdown-toggle').dropdown();
	 

	 table = $('#tabRilievi').DataTable({
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
		      columnDefs: [

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 19 }
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabRilievi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabRilievi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})

	});
	
	$('#tabRilievi').DataTable().order([23, "desc"]).draw();
	
});





$("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 

		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");	  
	
		$("#sede").change();  

		  var id_cliente = selection.split("_")[0];
		  
			
		  var options = commessa_options;
		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			var str=options[i].value; 		
			
			if(str.split("*")[1] == id_cliente||str.split("*")[2]==id_cliente)	
			{

				opt.push(options[i]);
			}   
	    
		   } 
		$('#commessa').html(opt);
		$('#commessa').val("");
		$("#commessa").change();  	  
	
	});

$("#mod_cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#mod_sede option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#mod_sede").prop("disabled", false);
	 
	  $('#mod_sede').html(opt);
	  
	  $("#mod_sede").trigger("chosen:updated");

		$("#mod_sede").change();  

		
		  var id_cliente = selection.split("_")[0];
		  
			
		  var options = commessa_options;
		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			var str=options[i].value; 		
			
			if(str.split("*")[1] == id_cliente || str.split("*")[2] == id_cliente)	
			{
				opt.push(options[i]);
			}   
	    
		   } 
		$('#mod_commessa').html(opt);
		$('#mod_commessa').val("");
		$("#mod_commessa").change();  	  
		
	
	});
	
	
	
$("#cliente_scn").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_scn option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 

		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{
			opt.push(options[i]);
		}   
	   }
	 $("#sede_scn").prop("disabled", false);
	 
	  $('#sede_scn').html(opt);
	  
	  $("#sede_scn").trigger("chosen:updated");

		$("#sede_scn").change();  
		
		
		  var id_cliente = selection.split("_")[0];
		  
			
		  var options = commessa_options;
		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			var str=options[i].value; 		
			
			if(str.split("*")[1] == id_cliente || str.split("*")[2] == id_cliente)	
			{
				opt.push(options[i]);
			}   
	    
		   } 
		$('#commessa_scn').html(opt);
		$('#commessa_scn').val("");
		$("#commessa_scn").change();  	  

	
	});


$('#myModalArchivio').on('hidden.bs.modal', function(){
	$(document.body).css('padding-right', '0px');	
});

$('#myModalError').on('hidden.bs.modal', function(){
	$(document.body).css('padding-right', '0px');	
});

/* $('#myModalListaSchedeConsegna').on('hidden.bs.modal', function(){
	
	$(document.body).css('padding-right', '0px');
//	$('#tabUscita').remove();
	
}); */
	</script>
	
