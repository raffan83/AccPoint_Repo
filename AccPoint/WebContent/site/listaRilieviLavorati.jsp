<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>



<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
<div class="row">
<div class="col-sm-12" >

 <!-- <button class="btn btn-info pull-right" title="Click per aprire la lista delle schede di consegna"  onClick="modalListaSchedeConsegna()"><i class="fa fa-list-ul"></i></button> -->
<!-- <button class="btn btn-primary pull-left" style="margin-right:5px" onClick="modalSchedaConsegna()"><i class="fa fa-plus"></i> Crea Scheda Consegna</button> -->

<button class="btn btn-info pull-left" title="Click per aprire la lista delle schede di consegna"  onClick="callAction('showSchedeConsegna.do?action=rilievi')"><i class="fa fa-list-ul"></i> Lista Schede di Consegna</button> 
	</div>
</div><br>
</c:if>

<c:if test="${userObj.checkRuolo('RL') }">
<div class="row">
<div class="col-sm-12" >

<button class="btn btn-info pull-left" title="Click per aprire la lista delle schede di consegna"  onClick="callAction('showSchedeConsegna.do?action=rilievi')"><i class="fa fa-list-ul"></i> Lista Schede di Consegna</button> 
	</div>
</div><br>

</c:if>

    <div class="row">

  
<div class="col-sm-3">
    
    <label>Anno di riferimento:</label>
<select id="anno" name="anno" class="form-control select2">

<option value="2019">2019</option>
<option value="2020">2020</option>
<option value="2021">2021</option>
<option value="2022">2022</option>
<option value="2023">2023</option>
<option value="2024">2024</option>
<option value="2025">2025</option>


</select>

</div>
<div class="col-sm-3">
    
<label class="pull-left">Totale Quote: </label><br>

<input type="text" id="importo_assegnato" class="form-control pull-left" readonly style="width:100%;text-align:right;">

</div>
<div class="col-sm-6">
    
    
     	<c:choose>
	<c:when test="${userObj.checkRuolo('AM') && lista_rilievi.size()>0 && lista_rilievi.get(0).controfirmato == 0}">
	<c:set var="tab_da_approvare" value="${1 }"></c:set>
	</c:when>
	<c:otherwise>
	<c:set var="tab_da_approvare" value="${0 }"></c:set>
	</c:otherwise>
	</c:choose>
<c:if test="${tab_da_approvare == 1 }">
<a id="approva_tutti" style="margin-top:25px" onClick="approvaSelezionati()"class="btn btn-success pull-right">Approva selezionati</a>
</c:if>
</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 


<c:if test="${tab_da_approvare == 1}">
<th></th>
<th style="max-width:20px"><input id="selectAlltabPM" type="checkbox" /></th>
</c:if>
<th>Numero Scheda</th>

<th>Disegno</th>
<th>Variante</th>
<th>Tipo Rilievo</th>
<th>Quote Totali</th>
<th>Pezzi Totali</th>
<th>Data Consegna</th>
<th>Cliente</th>
<th>Sede</th>
<th>Apparecchio</th>
<th>Fornitore</th>
<th>Stato Rilievo</th>

<th>Commessa</th>
<th>Data Inizio Rilievo</th>
<th>Tempo scansione</th>

<th>Denominazione</th>
<th>Materiale</th>
<th>Classe di tolleranza</th>
<th>Utente</th>
<th>Mese di riferimento</th>
<c:if test="${!userObj.checkRuolo('RL') }">
<th>ID Intervento</th>
<th>Pacco</th>
</c:if>
<th style="min-width:190px">Azioni</th>
<th>Allegati Scheda</th>
<th>Archivio</th>
<th>Scheda Consegna</th>
<th>ID</th>
<th>Note</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">
	<tr id="row_${loop.index}" >

	
<c:if test="${tab_da_approvare == 1}"><td></td><td></td></c:if>
		<td>${rilievo.numero_scheda }</td>

		<td>${rilievo.disegno }</td>
		<td>${rilievo.variante }</td>
		<td>${rilievo.tipo_rilievo.descrizione }</td>
		<td>${rilievo.n_quote }</td>
		<td>${rilievo.n_pezzi_tot }</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_consegna }" /></td>	
		
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.apparecchio }</td>	
		<td>${rilievo.fornitore }</td>
		<td>${rilievo.stato_rilievo.descrizione }</td>		
		<td>${rilievo.commessa}</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>	
		<td>${rilievo.tempo_scansione }</td>
		<td>${rilievo.denominazione }</td>
		<td>${rilievo.materiale }</td>
		<td>${rilievo.classe_tolleranza }</td>
		<td>${rilievo.utente.nominativo }</td>
		<td>${rilievo.mese_riferimento }</td>
				<c:if test="${!userObj.checkRuolo('RL') }">
	<td>
		<c:if test="${rilievo.intervento.id !=0}">
		
		<a target="_blank" class=" btn customTooltip customlink" href="listaRilieviDimensionali.do?action=lista_rilievi_intervento&id_intervento=${rilievo.intervento.id}">${rilievo.intervento.id}</a>
		</c:if>
		</td>
		<td>
		<c:if test="${rilievo.intervento.id_pacco !=0}">
		<a target="_blank" class=" btn customTooltip customlink" href="gestionePacco.do?action=dettaglio&id_pacco=${utl:encryptData(rilievo.intervento.id_pacco)}">
		<c:if test="${rilievo.intervento.id_pacco!=null && rilievo.intervento.id_pacco!=0}">
			PC_${rilievo.intervento.id_pacco }
			</c:if>
		</a>
		</c:if>
		</td>
		</c:if>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') || (userObj.checkPermesso('VISUALIZZA_RILIEVI_DIMENSIONALI') && rilievo.stato_rilievo.id==2)}">
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${utl:encryptData(rilievo.id)}')"><i class="fa fa-search"></i></a>
		</c:if>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<%-- <a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievo('${rilievo.id}')"><i class="fa fa-clone"></i></a> --%>
		<a href="#" class="btn btn-primary customTooltip" title="Click per clonare il rilievo" onClick="clonaRilievoModal('${rilievo.id}')"><i class="fa fa-clone"></i></a>
		<a href="#" class="btn btn-success customTooltip" title="Click per riaprire il rilievo" onClick="chiudiApriRilievo('${rilievo.id}',1)"><i class="fa fa-unlock"></i></a>
		</c:if>
		<%-- <a href="#" class="btn btn-success customTooltip" title="Click per creare la scheda excel del rilievo" onclick="callAction('gestioneRilievi.do?action=crea_scheda_rilievo_excel&id_rilievo=${utl:encryptData(rilievo.id)}')"><i class="fa fa-file-excel-o"></i></a> --%>
		<%-- <a  target="_blank" class="btn btn-danger customTooltip" title="Click per creare la scheda del rilievo" href="gestioneRilievi.do?action=crea_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a> --%>
		 <%-- <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda del rilievo" href="gestioneRilievi.do?action=download_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a> --%>
		 <c:if test="${userObj.checkRuolo('AM') && rilievo.controfirmato==0}">
		 <a  class="btn btn-success customTooltip" title="Click per approvare la scheda rilievo" onClick="modalApprovaRilievo('${rilievo.id}')"><i class="fa fa-check"></i></a>
		 </c:if> 
		 <c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') || (userObj.checkRuolo('RL') && rilievo.controfirmato==1)}">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda del rilievo" href="gestioneRilievi.do?action=download_scheda_rilievo&id_rilievo=${utl:encryptData(rilievo.id)}"><i class="fa fa-file-pdf-o"></i></a>
		</c:if>
		</td>
		<td>
		<c:if test="${userObj.checkPermesso('RILIEVI_DIMENSIONALI') }">
		<a href="#" class="btn btn-primary customTooltip" title="Click per allegare un file" onclick="modalAllegati('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>
		<c:if test="${rilievo.allegato!= null && rilievo.allegato !='' }">
			<%-- <a class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" onClick="callAction('gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(rilievo.id)}')" ><i class="fa fa-file-pdf-o"></i></a> --%>
			<a target ="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="gestioneRilievi.do?action=download_allegato&id_rilievo=${utl:encryptData(rilievo.id)}" ><i class="fa fa-file-pdf-o"></i></a>
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
		</c:choose></td>		
		<td>${rilievo.id }</td>
		
		<td>${rilievo.note }</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>

 <script type="text/javascript">
 
 
 
 function approvaSelezionati(){
	 

		  
			var dataSelected = table.rows( { selected: true } ).data();
			
			if(dataSelected.length>0){
				
				pleaseWaitDiv = $('#pleaseWaitDialog');
			 	pleaseWaitDiv.modal();
				
				var ids = "";
		  		for(i=0; i< dataSelected.length; i++){
		  			dataSelected[i];
		  			ids += dataSelected[i][28]+";";
		  		}
		  		
		  	dataObj = {};
		  	dataObj.ids = ids;
		  		
				callAjax(dataObj, "gestioneRilievi.do?action=approva_selezionati")
				
				
			}else{

		 		$('#myModalErrorContent').html("Selezionare almeno un rilievo!");
	 			$('#myModalError').removeClass();
	 			$('#myModalError').addClass("modal modal-default");
	 			$('#myModalError').modal('show');
			}
			
	  		
	 
	 
 }
 
 $('#selectAlltabPM').iCheck({
     checkboxClass: 'icheckbox_square-blue',
     radioClass: 'iradio_square-blue',
     increaseArea: '20%' // optional
   });

 
	$('input').on('ifChecked', function(event){  		
  		
		   //table.rows().select();
		   table.rows({ filter : 'applied'}).select();
		      	  
});
$('input').on('ifUnchecked', function(event){
	
		 table.rows().deselect();
	  
});
 
 
 function approvaRilievo(id_rilievo){
	 dataObj={};
	 dataObj.id_rilievo = id_rilievo;
	 
	 callAjax(dataObj,"gestioneRilievi.do?action=approva_rilievo");
	 
 }
 
 
 function modalApprovaRilievo(id_rilievo){
	
	 $('#approva_rilievo_id').val(id_rilievo);
     
    $('#myModalApprovaRilievo').modal();
 }
 
 function modalAllegati(id_rilievo){
	 
	 $('#id_rilievo').val(id_rilievo);
	 $('#myModalAllegati').modal();
}
 function clonaRilievoModal(id_rilievo){
	 
	 $('#clona_rilievo_id').val(id_rilievo);
	 $('#myModalClonaRilievo').modal();
 }
 
 function modalNuovoRilievo(){
	 $('#myModalNuovoRilievo').modal();
 }
 
 function modalSchedaConsegna(){
	 

	 if($('#cliente_filtro').val()!="0" && $('#cliente_filtro').val()!=""){
			
			var opt = $('#cliente_filtro option[value="'+$('#cliente_filtro').val()+'"]').clone();
		 	$('#cliente_appoggio').html(opt);
		 	initSelect2('#cliente_scn');
		 //	$('#cliente_scn').change();
		 	//$('#cliente_scn').select2();
		 	$('#sede_scn').val("0");
		 	$('#sede_scn').select2();
	 	} else{
	 		$('#cliente_appoggio').html(options_cliente);
	 		initSelect2('#cliente_scn');
	 		//$('#cliente_scn').val(""); 		
	 		//$('#cliente_scn').select2();
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
		     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx|dxf|dwg|stp|igs|iges|catpart|eml|rar|msg|zip)$/i;
		     
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

/*  function dettaglioRilievo(id_rilievo) {

 	 dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+$('#cliente_filtro').val()+"&filtro_rilievi=" +$('#filtro_rilievi').val();
	  
	  callAction("gestioneRilievi.do"+dataString, false, false);
 }
  */
 
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
	    	
	    	  if(${tab_da_approvare == 1}){
	    		  if($(this).index() !=0 && $(this).index()!=1){
		    		  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');  
		    	  }
	    	  }else{
	    		  
		    		 $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');  
		    	  
	    	  }
	    	 
	    	  
	    	
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
 
 
 
     var commessa_options;
$(document).ready(function() {
	 $('#label').hide();
	// $('.select2').select2();
		  	$('#commessa_scn').select2();
	  	
	  	$('#sede_scn').select2();
	  	$('#tipo_rilievo_scn').select2();
	  	$('#mese_scn').select2();
	  	$('#anno_scn').select2();
	
	 
	 $('#mod_label').hide();
	 $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	 
 var anno_riferimento = "${anno_riferimento}";
     
     $('#anno').val(anno_riferimento);
     $('#anno').change();
     
     
     var col_def = [];
     
     col_def =  [

   	  { responsivePriority: 1, targets: 1 },
   	  { responsivePriority: 2, targets: 20 }
              ] 
     
     sel ={};
     
     if(${tab_da_approvare==1}){
    
    	 col_def = [{ className: "select-checkbox", targets: 1,  orderable: false },
    		 { targets: 0,  orderable: false},
    		 { responsivePriority: 1, targets: 1 },
    	   	  { responsivePriority: 2, targets: 24 }];
    	 
    	 sel ={
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	}
     }
     
     
     
     commessa_options = $('#commessa option').clone();
	 
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
		      columnDefs: col_def,      
		      select: sel,
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
	
	contaImportoTotale(table);

	table.on( 'search.dt', function () {
		contaImportoTotale(table);
	} );
	
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
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{
			

			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  

		$("#sede").change();  

	});


$("#sede").change(function(){
	
	
	var id_cliente = $('#cliente').val().split("_")[0];
	  var id_sede = $(this).val().split("_")[0];	 
	
	  var options = commessa_options;
	  var opt=[];
		opt.push("");
	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 		
		
		if((str.split("*")[1] == id_cliente||str.split("*")[2]==id_cliente) && (str.split("@")[1] == id_sede || str.split("@")[2] == id_sede))	
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
			
			//if(opt.length == 0){
		 
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#mod_sede").prop("disabled", false);
	 
	  $('#mod_sede').html(opt);
	  
	  $("#mod_sede").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#mod_sede").change();  
	  //}
	  
	
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


/* 		  var id_cliente = selection.split("_")[0];
		  
			
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
		$("#commessa_scn").change();  	 */
	});
	
	
$("#sede_scn").change(function(){
	
	
	var id_cliente = $('#cliente_scn').val().split("_")[0];
	  var id_sede = $(this).val().split("_")[0];	 
	
	  var options = commessa_options;
	  var opt=[];
		opt.push("");
	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 		
		
		var id_util;
		if(str.split("*").length>2){
			id_util = str.split("*")[2].split("@")[0];
		}else{
			id_util = str.split("*")[1];
		}
		
		if((str.split("*")[1] == id_cliente||id_util==id_cliente) && (str.split("@")[1] == id_sede || str.split("@")[2] == id_sede))	
		{

			opt.push(options[i]);
		}     
  
	   } 
	$('#commessa_scn').html(opt);
	$('#commessa_scn').val("");
	$("#commessa_scn").change();  
});


$("#mod_sede").change(function(){
	
	
	var id_cliente = $('#mod_cliente').val().split("_")[0];
	  var id_sede = $(this).val().split("_")[0];	 
	
	  var options = commessa_options;
	  var opt=[];
		opt.push("");
	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 		
		
		if((str.split("*")[1] == id_cliente||str.split("*")[2]==id_cliente) && (str.split("@")[1] == id_sede || str.split("@")[2] == id_sede))	
		{

			opt.push(options[i]);
		}   
  
	   } 
	$('#mod_commessa').html(opt);
	$('#mod_commessa').val("");
	$("#mod_commessa").change();  
});


$('#nuovoRilievoForm').on('submit', function(e){
	 e.preventDefault();

});
/* $('#modificaRilievoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaRilievo()
}); */

$('#myModalArchivio').on('hidden.bs.modal', function(){
	$(document.body).css('padding-right', '0px');	
});

$('#myModalError').on('hidden.bs.modal', function(){
	$(document.body).css('padding-right', '0px');	
});

function contaImportoTotale(table){
	
	//var table = $("#tabPM").DataTable();
	

	
	var col = 5;
	
	
	if(${tab_da_approvare==1}){
		col = 7;
	}
	
	var data = table
     .rows({ search: 'applied' })
     .data();
	var somma = 0.0;
	for(var i=0;i<data.length;i++){	
		var num = parseFloat(stripHtml(data[i][col]));
		somma = somma + num;
	}
	$('#importo_assegnato').val(somma);
}

$('#anno').change(function(){
	
	 var stato_lavorazione = $('#filtro_rilievi').val();	 
	 var cliente_filtro = $('#cliente_filtro').val();
	 var anno = $('#anno').val();
	
		 dataString ="action=filtra&id_stato_lavorazione="+ stato_lavorazione+"&cliente_filtro="+cliente_filtro+"&anno="+anno;
	       exploreModal("listaRilieviDimensionali.do",dataString,"#lista_rilievi",function(datab,textStatusb){
	       });
	
});


	</script>