<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<div class="row">
<div class="col-xs-6">

<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalNuovaAttivita')">Nuova Attività</button><br><br>
</div>
<div class="col-xs-6">
<a target="_blank" class="btn customTooltip btn-danger pull-right" onClick="generaSchedaManutenzioni()" title="Click per scaricare la scheda di manutenzione"><i class="fa fa-file-pdf-o"></i> Scheda Manutenzione</a>

</div>
</div>

 <table id="tabAttivitaCampione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data</th>
 <th>Tipo Attivita</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_attivita}" var="attivita" varStatus="loop">
<tr>
<td>${attivita.id }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${attivita.data}" /></td>
<td>${attivita.tipo_attivita.descrizione}</td>
<td>
<c:if test="${attivita.tipo_attivita.id==1 }">
<button class="btn customTooltip btn-info" onClick="dettaglioManutenzione('${attivita.descrizione_attivita}','${attivita.tipo_manutenzione }')" title="Click per visualizzare l'attività di manutenzione"><i class="fa fa-arrow-right"></i></button>
</c:if>
<c:if test="${attivita.tipo_attivita.id==2 }">
<button class="btn customTooltip btn-info" onClick="dettaglioVerificaTaratura('${attivita.tipo_attivita.descrizione }','${attivita.data}','${attivita.ente }','${attivita.data_scadenza }','${attivita.etichettatura }','${attivita.stato }','${attivita.campo_sospesi }','${attivita.sigla }')" title="Click per visualizzare l'attività di verifica intermedia"><i class="fa fa-arrow-right"></i></button>
</c:if>
<button class="btn customTooltip btn-warning" onClick="modificaAttivita('${attivita.id}','${attivita.tipo_attivita.id }','${attivita.descrizione_attivita }','${attivita.data}','${attivita.tipo_manutenzione }' )" title="Click per scaricare la scheda anagrafica apparecchiatura"><i class="fa fa-edit"></i></button>


</td>

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 <form class="form-horizontal" id="formNuovaAttivita">
<div id="modalNuovaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_nuova_man" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attività</h4>
      </div>
       <div class="modal-body" id="modalNuovaAttivitaContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_attivita" id="select_tipo_attivita" data-placeholder="Seleziona Tipo Attivita..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="attivita">	  
	                     <option value="${attivita.id}">${attivita.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker">
            <input class="form-control  required" id="data_attivita" type="text" name="data_attivita" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
       <div id="content">
       


	</div>    

  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="stato" name="stato"/>
      <input type="hidden" id="etichettatura" name="etichettatura"/>
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
</div>
   </form>
   
   
   
   <form class="form-horizontal" id="formModificaAttivita">
<div id="modalModificaAttivita" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_modifica_man" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Attività</h4>
      </div>
       <div class="modal-body" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo Attività:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_attivita_mod" id="select_tipo_attivita_mod" data-placeholder="Seleziona Tipo Attivita..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_campioni}" var="attivita">	  
	                     <option value="${attivita.id}">${attivita.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Attività:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker">
            <input class="form-control  required" id="data_attivita_mod" type="text" name="data_attivita_mod" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
       <div id="content_mod">

	</div>    

  		 </div>
      <div class="modal-footer">
       <input type="hidden" id="id_attivita" name="id_attivita">
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>

</div>
</div>
   </form>
   
   
<!--    <div id="modalAttivita" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"  aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Lista Attività Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalAttivitaContent" >
	
	
  		 </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>

</div>
 -->


   <div id="modalDettaglio" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_man" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Dettaglio Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     
	<div class="form-group">
  <div class="row">
	 <div class="col-sm-12">
		<div class="col-sm-6">
		<label >Tipo Manutenzione:</label>
			<label id="label_tipo_manutenzione"></label>
        </div>
		
        <div class="col-sm-12">
             <textarea rows="5" style="width:100%" id="dettaglio_descrizione" name="dettaglio_descrizione" readonly></textarea>

        </div>
       </div>
       </div>
       </div>      
	
  		 </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>

</div>



<div id="modalDettaglioVerificaTaratura" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_dtl" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabeldtl"></h4>
      </div>
       <div class="modal-body" id="modalDettaglioContent" >
     <div class="row">
	<div class="form-group">
  	<div class="row">
	<div class="col-sm-12">
		<div class="col-sm-6">
		<label >Tipo Attività:</label>		
			 <input id="tipo_attivita_dtl" class="form-control pull-right" readonly>
        </div>
		
        <div class="col-sm-6">
        <label >Data Attività:</label>
             <input id="data_attivita_dtl" class="form-control  pull-right" readonly>
        </div>
        
        <div class="col-sm-6">
        <label >Ente:</label>
             <input id="ente_dtl" class="form-control" readonly>
        </div>
         <div class="col-sm-6">
        <label >Data Scadenza:</label>
             <input id="data_scadenza_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Etichettatura di conferma:</label>
             <input id="etichettatura_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Stato:</label>
             <input id="stato_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Campo sospesi:</label>
             <input id="campo_sospesi_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Sigla:</label>
             <input id="sigla_dtl" class="form-control" readonly>
        </div>
        <div class="col-sm-6">
        <label >Numero Certificato:</label>
             <input id="certificato_dtl" class="form-control  pull-right" readonly>
        </div>
    </div>    
        
        </div>
       </div>
       </div>      
	
  		 </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>

</div>


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<!--  <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		 -->

 <script type="text/javascript">
 
 
 function generaSchedaManutenzioni(){
		
	 callAction("gestioneAttivitaCampioni.do?action=scheda_manutenzioni&id_campione="+datax[0]);
 }
 
 
 
 $('#select_tipo_attivita').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){		 
		 
		 str_html='<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione" id="select_tipo_manutenzione" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
		 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div>')	
		 .concat('<div class="col-sm-2"><label class="pull-right">Sigla:</label></div><div class="col-sm-4"><input type="text" class="form-control" id="sigla" name="sigla"></div></div>')
		 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione" name="descrizione" required></textarea></div></div></div>');
	 }
	 
	 else if($(this).val()==2){
			
		 str_html = '<div class="form-group"><div class="col-sm-2"><label >Ente:</label></div><div class="col-sm-4"><input class="form-control" id="ente" name="ente" type="text"/></div>'
     	 .concat('<div class="col-sm-2 "><label class="pull-right">Data Scadenza:</label></div><div class="col-sm-3"><div class="input-group date datepicker"  id="datetimepicker_taratura">')
     	 .concat('<input class="form-control  required" id="data_scadenza" type="text" name="data_scadenza" required/><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div>')
     	.concat('</div><div class="col-sm-2"><label >Etichettatura di conferma:</label></div><div class="col-sm-4"><input id="check_interna" name="check_interna" type="checkbox" checked/><label >Interna</label><br><input  id="check_esterna" name="check_esterna" type="checkbox"/>')
     	.concat('<label >Esterna</label></div><div class="col-sm-2"><label class="pull-right">Stato:</label></div><div class="col-sm-4"><input id="check_idonea" name="check_idonea" type="checkbox" checked/><label >Idonea</label><br>')
     	.concat('<input  id="check_non_idonea" name="check_non_idonea" type="checkbox"/><label >Non Ideonea</label></div>')
     	.concat('<div class="col-sm-2"><label>Campo sospesi:</label></div><div class="col-sm-4"><input class="form-control" id="campo_sospesi" name="campo_sospesi" type="text"/></div>')
     	.concat('<div class="col-sm-2"><label class="pull-right">Sigla:</label></div><div class="col-sm-4"><input class="form-control" id="sigla" name="sigla" type="text"/></div>')
     	.concat('<div class="col-sm-2"><a class="btn btn-primary" onClick="caricaMisura()"><i class="fa fa-icon-plus"></i>Carica Misura</a></div></div>');
	
		 
	 }
	 
	 
	 $('#content').html(str_html);
	 $('#select_tipo_manutenzione').select2();
  
	 $('.datepicker').bootstrapDP({
		 
			format: "dd/mm/yyyy"
		});

	 $('#check_interna').click(function(){
		$('#check_esterna').prop("checked", false); 
		$('#etichettatura').val("Interna");
	 });
	 
	 $('#check_esterna').click(function(){
		$('#check_interna').prop("checked", false);
		$('#etichettatura').val("Esterna");
	 });
	 
	 $('#check_idonea').click(function(){
		 $('#check_non_idonea').prop("checked", false);
		 $('#stato').val("Idonea");
	 });
	 
	 $('#check_non_idonea').click(function(){
		 $('#check_idonea').prop("checked", false);
		 $('#stato').val("Non Idonea");
	 })

	 
	 


 });
 
 
 $('#select_tipo_attivita_mod').change(function(){
	 
	 var str_html="";
	
	 if($(this).val()==1){
		 
		 str_html='<div class="form-group"><div class="col-sm-2"><label >Tipo Manutenzione:</label></div><div class="col-sm-4"><select name="select_tipo_manutenzione_mod" id="select_tipo_manutenzione_mod" data-placeholder="Seleziona Tipo manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>'
		 .concat(' <option value=""></option><option value="1">Preventiva</option><option value="2">Straordinaria</option></select></div></div>')	  
		 .concat('<div class="form-group"> <div class="col-sm-2"><label >Descrizione Attività:</label></div>')
		 .concat('<div class="col-sm-10"><textarea rows="5" style="width:100%" id="descrizione_mod" name="descrizione_mod" required></textarea></div></div></div>')

	 }
	 $('#content_mod').html(str_html);
	 $('#select_tipo_manutenzione_mod').select2();
  
   
 });
 
 
function caricaMisura(){
	
} 
 

function dettaglioVerificaTaratura(tipo_attivita, data_attivita, ente, data_scadenza, etichettatura, stato, campo_sospesi, sigla){
	
	$('#myModalLabeldtl').html("Dettaglio "+tipo_attivita);
	
	$('#tipo_attivita_dtl').val(tipo_attivita);
	$('#data_attivita_dtl').val(formatDate(data_attivita));
	$('#ente_dtl').val(ente);
	$('#etichettatura_dtl').val(etichettatura);
	$('#stato_dtl').val(stato);
	$('#campo_sospesi_dtl').val(campo_sospesi);
	$('#sigla_dtl').val(sigla);
	$('#data_scadenza_dtl').val(formatDate(data_scadenza));
	
	$('#modalDettaglioVerificaTaratura').modal();
}
 
 function dettaglioManutenzione(descrizione, tipo){
	 $('#dettaglio_descrizione').val(descrizione);
	 if(tipo==1){
		 $('#label_tipo_manutenzione').html("Preventiva");	 
	 }else{
		 $('#label_tipo_manutenzione').html("Straordinaria");
	 }
	 
	 $('#modalDettaglio').modal();
 };
 
 
 function modificaAttivita(id, tipo_attivita, descrizione, data, tipo_manutenzione){
	 
	 $('#select_tipo_attivita_mod').val(tipo_attivita);
	 $('#select_tipo_attivita_mod').change();
	 var date = formatDate(data);
	 $('#data_attivita_mod').val(date);
	 if(tipo_manutenzione!=null && tipo_manutenzione!=''){
		 $('#select_tipo_manutenzione_mod').val(tipo_manutenzione);
		 $('#select_tipo_manutenzione_mod').change();
	 }
	 $('#descrizione_mod').val(descrizione)
	 $('#id_attivita').val(id);
	
	 $('#modalModificaAttivita').modal();
	 
 }
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}
 
	var columsDatatables = [];
	 
	$("#tabAttivitaCampione").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabAttivitaCampione thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabAttivitaCampione thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );



	
	function generaSchedaApparecchiatura(id_evento, id_campione){
		
		var dataString =  "?action=genera_scheda&id_evento="+id_evento+"&id_campione="+id_campione;
		callAction('registroEventi.do'+dataString);
	}
	
  $(document).ready(function() {
 console.log("test");
	  $(".select2").select2();
	  $('.datepicker').datepicker({
			format: "dd/mm/yyyy"
		});
	  $('#modalAttivita').addClass('modal-fullscreen');
 tab = $('#tabAttivitaCampione').DataTable({
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
     pageLength: 10,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
tab = $('#tabAttivitaCampione').DataTable();
//Apply the search
tab.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
   tab
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	tab.columns.adjust().draw();
	

$('#tabAttivitaCampione').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 
  
 
  $('#formNuovaAttivita').on('submit',function(e){		
		e.preventDefault();
		
		nuovaAttivitaCampione(datax[0]);	  
	});
  
  $('#formModificaAttivita').on('submit',function(e){		
		e.preventDefault();
		modificaAttivitaCampione(datax[0]);	  
	});
  
  $('#close_btn_man').on('click', function(){
	  $('#modalDettaglio').modal('hide');
  });
 
  $('#close_btn_nuova_man').on('click', function(){
	  $('#modalNuovaAttivita').modal('hide');
  });
  $('#close_btn_modifica_man').on('click', function(){
	  $('#modalModificaAttivita').modal('hide');
  });
  $('#close_btn_dtl').on('click', function(){
	  $('#modalDettaglioVerificaTaratura').modal('hide');
  });
  

	  $('#modalNuovaAttivita').on('hidden.bs.modal', function(){
		  $('#content').html('');
		  $('#select_tipo_attivita').val("");
		  $('#select_tipo_attivita').change();
		  contentID == "registro_attivitaTab";
		  
	  }); 

	  $('#modalModificaAttivita').on('hidden.bs.modal', function(){
		  $('#content_mod').html('');
		  contentID == "registro_attivitaTab";
		  
	  }); 
	  $('#modalDettaglio').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 });   



	  
</script>