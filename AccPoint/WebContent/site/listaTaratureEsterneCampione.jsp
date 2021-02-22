<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
    <% 

/* JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");
Gson gson = new Gson();
CampioneDTO campione=(CampioneDTO)gson.fromJson(jsonElem,CampioneDTO.class); 

ArrayList<TipoCampioneDTO> listaTipoCampione = (ArrayList)session.getAttribute("listaTipoCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy"); */
%>
<div class="row">
<div class="col-xs-3">

<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalNuovaTaraturaEsterna')">Nuova Taratura Esterna</button><br><br>
<!-- <iframe src="https://docs.google.com/viewer?srcid=11pVOOpUUGO22h0zaflYEmvg-eqpksfOg&pid=explorer&efh=false&a=v&chrome=false&embedded=true" style="width:600px; height:500px;" frameborder="0"></iframe> -->
  <!-- <iframe src="https://docs.google.com/spreadsheets/d/18G21r3k88J5-vYWtZ_owWpO9BlghqtOFe_T1pDVXhN0/edit#gid=1350706040"  width="580px" height="480px"></iframe> -->
   <!-- <iframe src="https://docs.google.com/spreadsheets/d/18G21r3k88J5-vYWtZ_owWpO9BlghqtOFe_T1pDVXhN0/edit?usp=sharing/pubhtml?gid=0"  width="780px" height="480px"></iframe> --> 
  <!-- https://docs.google.com/spreadsheets/d/18G21r3k88J5-vYWtZ_owWpO9BlghqtOFe_T1pDVXhN0/edit?usp=sharing
  https://docs.google.com/spreadsheets/d/18G21r3k88J5-vYWtZ_owWpO9BlghqtOFe_T1pDVXhN0/pubhtml?gid=0 -->
  <!--  
  <iframe src="https://docs.google.com/spreadsheets/d/2PACX-1vRJq0YkhuulUyw1Gi8zpPCmyZk38E5TwpKaW9mk79l88EiM4MLhGIhJ89ACgFJMdwec0wMDYThRmfCE/pubhtml?gid=0" width="580px" height="480px"></iframe> -->
 <!-- https://docs.google.com/spreadsheets/d/e/2PACX-1vRJq0YkhuulUyw1Gi8zpPCmyZk38E5TwpKaW9mk79l88EiM4MLhGIhJ89ACgFJMdwec0wMDYThRmfCE/pubhtml -->
 <!-- https://docs.google.com/spreadsheets/d/2PACX-1vRJq0YkhuulUyw1Gi8zpPCmyZk38E5TwpKaW9mk79l88EiM4MLhGIhJ89ACgFJMdwec0wMDYThRmfCE/pubhtml?gid=0 -->
 <!--<iframe src="https://docs.google.com/viewer?srcid=[put your file id here]&pid=explorer&efh=false&a=v&chrome=false&embedded=true" width="580px" height="480px"></iframe>    -->
 
 <!-- <iframe src="https://docs.google.com/viewer?url=http://demo.calver.it/AccPoint/src/test.xlsx&embedded=true" style="width:600px; height:500px;"></iframe> --> 
<!-- <iframe src="https://docs.google.com/viewer?url=https://go.microsoft.com/fwlink/?LinkID=521962&embedded=true" style="width:600px; height:500px;"></iframe> -->


<div id="demo2"></div>
 
</div>
<div class="col-xs-9">

</div>
</div>

 <table id="tabTaratureEsterne" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Verifica Intermedia</th>
 <th>Data</th> 
 <th>Stato</th>
 <th>Commessa</th>
 <th>Oggetto della Taratura</th>
 <th>Committente</th>
 <th>Controllo</th>
 <th>Operatore</th>
 <th>Note</th>
 <th>Azioni</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_tarature_esterne}" var="taratura" varStatus="loop">
<tr>
<td>${taratura.id }</td>
<td>${taratura.verifica_intermedia.id}</td>
<td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${taratura.data}" /></td>
<td>
<c:choose>
<c:when test="${taratura.stato == 0 }">
Entrata
</c:when>
<c:otherwise>
Uscita
</c:otherwise>
</c:choose>
</td>
<td>${taratura.commessa }</td>
<td>${taratura.oggetto }</td>
<td>${taratura.committente }</td>
<td>${taratura.controllo }</td>
<td>${taratura.operatore.nominativo }</td>
<td>${taratura.note }</td>
<td>
<a class="btn btn-warning" onClick="modificaTaraturaEsterna('${taratura.id}','${taratura.verifica_intermedia.id }','${taratura.data }','${taratura.stato }','${taratura.commessa }','${utl:escapeJS(taratura.oggetto) }','${utl:escapeJS(taratura.committente) }','${taratura.controllo }','${taratura.operatore.id }','${utl:escapeJS(taratura.note) }')"><i class="fa fa-edit"></i></a>
<c:if test="${taratura.verifica_intermedia.certificato.misura.file_xls_ext!=null &&  taratura.verifica_intermedia.certificato.misura.file_xls_ext!=''}">
	<a href="#" class="btn btn-success" title="Click per scaricare il file" onClick="scaricaPacchettoUploaded('${taratura.verifica_intermedia.certificato.misura.interventoDati.nomePack}','','${taratura.verifica_intermedia.certificato.misura.intervento.nomePack}')"><i class="fa fa-file-excel-o"></i></a>
</c:if>
</td>

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 

 <form class="form-horizontal" id="formNuovaTaraturaEsterna">
<div id="modalNuovaTaraturaEsterna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_nuova_tar" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova taratura esterna</h4>
      </div>
       <div class="modal-body" id="modalTaraturaEsternaContent" >
       
       <!--  <div class="form-group"> -->
  	 <div class="row">
  	 
  	  <div class="col-sm-2 ">
			<label class="pull-right">Rif. Verifica intermedia:</label>
		</div>
        <div class="col-sm-2">
            <input class="form-control" id="rif_verifica" type="text" name="rif_verifica" readonly required/> 
        </div>
        <div class="col-sm-2 ">
              <a class="btn btn-primary" onClick="caricaVerifica()">Carica Verifica</a>
        </div>
  	 
      
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data:</label>
		</div>
        <div class="col-sm-4">
             
             <div class="input-group date datepicker"  id="datetimepicker_tar">
            <input class="form-control  required" id="data" type="text" name="data" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
        </div>
        <div class="row">
        <div class="col-sm-2">
			<label >Committente:</label>
		</div>
		
		<div class="col-sm-4">
              <input type=text id="committente" name="committente" class="form-control">
        </div>
        
         <div class="col-sm-2">
			<label class="pull-right">Oggetto:</label>
		</div>
		
		<div class="col-sm-4">
              <input type=text id="oggetto" name="oggetto" class="form-control">
        </div>
        
        </div>
        
        <div class="row">
        <div class="col-sm-2">
			<label>Stato:</label>
		</div>
        <div class="col-sm-4">
             <input id="check_entrata" name="check_entrata" type="checkbox" checked/>
             <label >Entrata</label><br>
             <input  id="check_uscita" name="check_uscita" type="checkbox"/>
             <label >Uscita</label>
        </div>
        
        <div class="col-sm-2">
			<label class="pull-right">Controllo:</label>
		</div>
        <div class="col-sm-4">
               <input id="check_ok" name="check_ok" type="checkbox" checked/>
             <label >OK</label><br>
             <input  id="check_not_ok" name="check_not_ok" type="checkbox"/>
             <label >NOK</label>
        </div>
        </div>
        
         <div class="row">
     
       <div class="col-sm-2">
			<label >Commessa:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="commessa" id="commessa" data-placeholder="Seleziona Commessa..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_commesse}" var="commessa">	  
	                     <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option> 	                        
	            </c:forEach>
              </select>
        </div>
               <div class="col-sm-2">
			<label class="pull-right">Operatore:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="operatore" id="operatore" data-placeholder="Seleziona Operatore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_utenti}" var="operatore">	  
	                     <option value="${operatore.id}">${operatore.nominativo}</option> 	                        
	            </c:forEach>
              </select>
        </div><br><br>
        
             <div class="col-sm-2">
			<label >Note:</label>
		</div>
		
		<div class="col-sm-10">
              <textarea rows="3" id=note name="note" style="width:100%"></textarea>
        </div>
      
        </div>
        </div>
        
       	  <!-- </div>  -->
      <div class="modal-footer">
      <input type="hidden" id="stato" name="stato" value="0"/>
      <input type="hidden" id="controllo" name="controllo" value="OK"/>
      
      
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
</div>    

</div>
   
</div>

   </form>
   
   
   
   
   <form class="form-horizontal" id="formModificaTaraturaEsterna">
<div id="modalModificaTaraturaEsterna" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close"id="close_btn_modifica_tar" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica taratura esterna</h4>
      </div>
       <div class="modal-body" id="modalTaraturaEsternaContent" >
       
       <!--  <div class="form-group"> -->
  	 <div class="row">
  	 
  	  <div class="col-sm-2 ">
			<label class="pull-right">Rif. Verifica intermedia:</label>
		</div>
        <div class="col-sm-2">
            <input class="form-control" id="rif_verifica_mod" type="text" name="rif_verifica_mod" readonly required/> 
        </div>
        <div class="col-sm-2 ">
              <a class="btn btn-primary" onClick="caricaVerifica()">Carica Verifica</a>
        </div>
  	 
      
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data:</label>
		</div>
        <div class="col-sm-4">
             
             <div class="input-group date datepicker"  id="datetimepicker_mod">
            <input class="form-control  required" id="data_mod" type="text" name="data_mod" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
        </div>
        <div class="row">
        <div class="col-sm-2">
			<label >Committente:</label>
		</div>
		
		<div class="col-sm-4">
              <input type=text id="committente_mod" name="committente_mod" class="form-control">
        </div>
        
         <div class="col-sm-2">
			<label class="pull-right">Oggetto:</label>
		</div>
		
		<div class="col-sm-4">
              <input type=text id="oggetto_mod" name="oggetto_mod" class="form-control">
        </div>
        
        </div>
        
        <div class="row">
        <div class="col-sm-2">
			<label>Stato:</label>
		</div>
        <div class="col-sm-4">
             <input id="check_entrata_mod" name="check_entrata_mod" type="checkbox" />
             <label >Entrata</label><br>
             <input  id="check_uscita_mod" name="check_uscita_mod" type="checkbox"/>
             <label >Uscita</label>
        </div>
        
        <div class="col-sm-2">
			<label class="pull-right">Controllo:</label>
		</div>
        <div class="col-sm-4">
               <input id="check_ok_mod" name="check_ok_mod" type="checkbox" />
             <label >OK</label><br>
             <input  id="check_not_ok_mod" name="check_not_ok_mod" type="checkbox"/>
             <label >NOK</label>
        </div>
        </div>
        
         <div class="row">
     
       <div class="col-sm-2">
			<label >Commessa:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="commessa_mod" id="commessa_mod" data-placeholder="Seleziona Commessa..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_commesse}" var="commessa">	  
	                     <option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option> 	                        
	            </c:forEach>
              </select>
        </div>
               <div class="col-sm-2">
			<label class="pull-right">Operatore:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="operatore_mod" id="operatore_mod" data-placeholder="Seleziona Operatore..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_utenti}" var="operatore">	  
	                     <option value="${operatore.id}">${operatore.nominativo}</option> 	                        
	            </c:forEach>
              </select>
        </div><br><br>
        
             <div class="col-sm-2">
			<label >Note:</label>
		</div>
		
		<div class="col-sm-10">
              <textarea rows="3" id=note_mod name="note_mod" style="width:100%"></textarea>
        </div>
        
        </div>
        </div>
        
       	  <!-- </div>  -->
      <div class="modal-footer">
      <input type="hidden" id="stato_tar_mod" name="stato_tar_mod"/>
      <input type="hidden" id="controllo_mod" name="controllo_mod"/>
      <input type="hidden" id="id_taratura" name="id_taratura"/>
      
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
</div>    

</div>
   
</div>

   </form>
   
   

   

   <div id="modalVerificheIntermedie" class="modal fade " role="dialog"  aria-labelledby="myModalLabel" >

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn_lista_ver" aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" >Seleziona Verifica Intermedia</h4>
      </div>
       <div class="modal-body" >
     	<div id="content_verifiche">
 
       </div>
	
       </div>      
  		 
      <div class="modal-footer">
       <a  class="btn btn-primary" onClick="selezionaVerificaIntermedia()">Seleziona</a>
      </div>
      </div>
    </div>
  </div>


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>


 <script type="text/javascript">
 
  
 
function caricaVerifica(){
	
	exploreModal("gestioneAttivitaCampioni.do","action=lista_verifiche_intermedie&idCamp="+datax[0],"#content_verifiche");
	$('#modalVerificheIntermedie').modal();
	
	 $('#modalVerificheIntermedie').on('shown.bs.modal', function (){
	    	table2 = $('#tabVerificheIntermedie').DataTable();
   		 table2.columns().eq( 0 ).each( function ( colIdx ) {
  			 $( 'input', table2.column( colIdx ).header() ).on( 'keyup', function () {
  				 table2
  			      .column( colIdx )
  			      .search( this.value )
  			      .draw();
  			 } );
  			 } );    
  		table2.columns.adjust().draw(); 
   });
} 


 function modificaTaraturaEsterna(id, verifica_intermedia, data, stato, commessa, oggetto, committente, controllo, operatore, note){
	
	 $('#id_taratura').val(id)
	 $('#rif_verifica_mod').val(verifica_intermedia);
	 $('#data_mod').val(formatDate(data));	 
	 $('#commessa_mod').val(commessa);
	 $('#commessa_mod').change();
	 $('#oggetto_mod').val(oggetto);
	 $('#committente_mod').val(committente);	
	 $('#operatore_mod').val(operatore);
	 $('#operatore_mod').change();
	 $('#note_mod').html(note);
	 
	 $('#check_entrata_mod').prop("checked", false); 
	 $('#check_uscita_mod').prop("checked", false);
	 $('#check_entrata_mod').prop("checked", false);
	 $('#check_entrata_mod').prop("checked", false);
	 
	 if(stato==0){
		 $('#check_entrata_mod').prop("checked", true); 
		 $('#stato_tar_mod').val("0");
	 }else{
		 $('#check_uscita_mod').prop("checked", true); 
		 $('#stato_tar_mod').val("1");
	 }
	 if(controllo=='OK'){
		 $('#check_ok_mod').prop("checked", true);
		 $('#controllo_mod').val("OK");
	 }else{
		 $('#check_not_ok_mod').prop("checked", true);
		 $('#controllo_mod').val("NOK");
	 }
	 
	 $('#datetimepicker_mod').bootstrapDP({
			format: "yyyy-mm-dd"
	});

	$('#modalModificaTaraturaEsterna').modal(); 
 }
 
 function selezionaVerificaIntermedia(modifica){	 
		 
		 $('#rif_verifica').val($('#verifica_selected').val());
		 $('#data').val($('#data_selected').val());	
		 $('#rif_verifica_mod').val($('#verifica_selected').val());
		 $('#data_mod').val($('#data_selected').val());
	
	 $('#modalVerificheIntermedie').modal('hide');
	 
 }
 
 
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("yyyy-MM-dd");
		   }			   
		   return str;	 		
	}
 
	var columsDatatables = [];
	 
	$("#tabTaratureEsterne").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabTaratureEsterne thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabTaratureEsterne thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );

	
	
  $(document).ready(function() {
	

 	console.log("test");
	  $(".select2").select2();
	  $('#datetimepicker_tar').bootstrapDP({
			format: "yyyy-mm-dd"
		});

	  
	 	 	
	  $('#modalVerificheIntermedie').css("overflow", "hidden");
	 
	  $('#modalNuovaTaraturaEsterna').css("overflow", "hidden");
	  
	  $('#modalModificaTaraturaEsterna').css("overflow", "hidden");
	 
 tab = $('#tabTaratureEsterne').DataTable({
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
	      "order": [[ 0, "desc" ]],
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 10 }
	               ], 

	    	
	    });
	


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
tab = $('#tabTaratureEsterne').DataTable();
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
	

$('#tabTaratureEsterne').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 
  
 
  $('#formNuovaTaraturaEsterna').on('submit',function(e){		
		e.preventDefault();		
		/* if($('#rif_verifica').val()==""){
			$('#myModalErrorContent').html("Attenzione! Selezionare una scheda di verifica!");
  			$('#myModalError').removeClass();
  			$('#myModalError').addClass("modal modal-danger");
  			$('#myModalError').modal('show');
		}else{ */
			nuovaTaraturaEsterna(datax[0]);
		//}
	});
  
  $('#formModificaTaraturaEsterna').on('submit',function(e){		
		e.preventDefault();		
		modificaTaraturaEsternaSubmit();	  
		 
	});

  $('#close_btn_nuova_tar').on('click', function(){
	  $('#modalNuovaTaraturaEsterna').modal('hide');
  });
  
  $('#close_btn_modifica_tar').on('click', function(){
	  $('#modalModificaTaraturaEsterna').modal('hide');
  });
	
	  $('#close_btn_lista_ver').on('click', function(){
		  $('#modalVerificheIntermedie').modal('hide');
	  });

	  $('#modalNuovaTaraturaEsterna').on('hidden.bs.modal', function(){
		 
		  $('#commessa').val("");
		  $('#operatore').change();
		  contentID == "registro_attivitaTab";
		  
	  }); 

	  $('#modalVerificheIntermedie').on('hidden.bs.modal', function(){
		  contentID == "registro_attivitaTab";
		  
	 }); 
	  
	  $('#modalModificaTaraturaEsterna').on('hidden.bs.modal', function(){
		  $('#rif_verifica').val("");
		  $('#data').val("");	
		  contentID == "registro_attivitaTab";
		  
	 }); 
	  
	  
	  $('#check_entrata').click(function(){
			$('#check_uscita').prop("checked", false); 
			$('#stato').val("0");
		 });
		 
		 $('#check_uscita').click(function(){
			$('#check_entrata').prop("checked", false);
			$('#stato').val("1");
		 });
		 
		 $('#check_ok').click(function(){
			 $('#check_not_ok').prop("checked", false);
			 $('#controllo').val("OK");
		 });
		 
		 $('#check_not_ok').click(function(){
			 $('#check_ok').prop("checked", false);
			 $('#controllo').val("NOK");
		 })

		$('#check_entrata_mod').click(function(){
			$('#check_uscita_mod').prop("checked", false); 
			$('#stato_tar_mod').val("0");
		 });
		 
		 $('#check_uscita_mod').click(function(){
			$('#check_entrata_mod').prop("checked", false);
			$('#stato_tar_mod').val("1");
		 });
		 
		 $('#check_ok_mod').click(function(){
			 $('#check_not_ok_mod').prop("checked", false);
			 $('#controllo_mod').val("OK");
		 });
		 
		 $('#check_not_ok_mod').click(function(){
			 $('#check_ok_mod').prop("checked", false);
			 $('#controllo_mod').val("NOK");
		 })
	  
	
</script>