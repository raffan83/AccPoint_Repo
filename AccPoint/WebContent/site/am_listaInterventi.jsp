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
        Lista interventi
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
	 Lista Interventi A.M. Engineering
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">

 	<div class="col-xs-5">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data Creazione:</label>
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

<div class="col-xs-12">
<button class="btn btn-primary pull-right" onClick="nuovoInterventoFromModal()" style="margin-right:5px"><i class="fa fa-plus"></i> Nuovo Intervento</button> 
</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabVerInterventi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Cliente</th>
<th>Cliente Utilizzatore</th>
<th>Sede</th>
<th>Sede Utilizzatore</th>
<th>Commessa</th>
<th>Data Intervento</th>
<th>Responsabile</th>
<th>Stato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_interventi }" var="intervento" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${intervento.id }</td>	
	<td>${intervento.nomeCliente }</td>
	<td>${intervento.nomeClienteUtilizzatore }</td>
	<td>${intervento.nomeSede }</td>
	<td>${intervento.nomeSedeUtilizzatore }</td>
	<td>${intervento.idCommessa }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.dataIntervento }" /></td>
	<td>${intervento.operatore.nomeOperatore }</td>
	<td>

	
	<c:if test="${intervento.stato== 0}">
						
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiInterventoAM('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-success">APERTO</span></a>
						
					</c:if>
					
					<c:if test="${intervento.stato == 1}">
						<a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="apriVerIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-warning">CHIUSO</span></a>
						
					</c:if>
	
	</td>
	<td align="center">
	<a class="btn btn-info" onClicK="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')" title="Click per aprire il dettaglio dell'intervento"><i class="fa fa-arrow-right"></i></a>

	<a class="btn btn-warning" title="Click per modificare l'intervento"><i class="fa fa-edit"></i></a>
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





<form id="modificaInterventoForm" name="modificaInterventoForm">
<div id="myModalModificaIntervento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Intervento</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">      
       	  <div class="col-md-6" style="display:none">  
                  <label>Cliente</label>
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control " aria-hidden="true" data-live-search="true" style="width:100%" required>
                        <%-- <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>    --%>

                  </select> 
                
        </div>  	
        <input id="cliente_mod" name="cliente_mod" type ="text" class="form-control" style="width:100%">
       <%-- 		  <select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_mod" name="cliente_mod" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach> 
       		</select>  --%>        	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="sede_mod" name="sede_mod" style="width:100%" disabled required>
       		<option value=""></option>
       		 	<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
       				<option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo }</option>
       			</c:forEach> 
       		</select>
       	</div>
       </div><br>
        <div class="row">
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="commessa_mod" name="commessa_mod" style="width:100%" >
       		<option value=""></option>
       			 <c:forEach items="${lista_commesse}" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}*${commessa.ID_ANAGEN}*${commessa.ID_ANAGEN_UTIL}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data prevista</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_prevista'>
               <input type='text' class="form-control input-small" id="data_prevista_mod" name="data_prevista_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tecnico Verificatore</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tecnico verificatore..." id="tecnico_verificatore_mod" name="tecnico_verificatore_mod" style="width:100%" required>
       		<option value=""></option>
        			<c:forEach items="${lista_tecnici}" var="tecnico" varStatus="loop">
       				<option value="${tecnico.id}">${tecnico.nominativo}</option>
       			</c:forEach> 
       		</select>
       	</div>
       </div><br>
       
<%--         <div class="row">
       	<div class="col-sm-3">
       		<label>Tecnico Riparatore</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tecnico Riparatore..." id="tecnico_riparatore_mod" name="tecnico_riparatore_mod" style="width:100%" >
       		<option value=""></option>
       		<option value="0">Nessuno</option>
       			<c:forEach items="${lista_tecnici}" var="tecnico" varStatus="loop">
       				<option value="${tecnico.id}">${tecnico.nominativo}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br> --%>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Luogo</label>
       	</div>
       	<div class="col-sm-9">
       		<select id="luogo_mod" name="luogo_mod" class="form-control select2" style="width:100%">
				  <option value=0>In Sede</option>
				  <option value=1>Presso il Cliente</option>
				  <option value=2>Altro Luogo</option>				  
				</select>
       	</div>
       </div>      <br>
       
         <div class="row">
       	<div class="col-sm-3">
       	<h4>STRUMENTI</h4>
       	
       	</div></div> 
       <div id="tab_luogo">

       	</div>

      
       
       </div>
  		 
      <div class="modal-footer">
      <!-- <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label> -->

		 <!-- <a class="btn btn-primary"  onClick="inserisciRilievo()">Salva</a>  -->
		<!--  <a class="btn btn-primary"  type="submit">Salva</a>  -->
		<input type="hidden" id="id_intervento" name="id_intervento">
		<input type="hidden" id="ids_strumenti" name="ids_strumenti">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Intervento</h4>
      </div>
       <div class="modal-body">

		<div class="row">
       	<div class="col-sm-3">
       		<label>Commessa</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="comm" name="comm" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">

				<c:forEach items="${lista_commesse }" var="comm">
				
				<option value="${comm.ID_COMMESSA }@${comm.ID_ANAGEN_NOME}@${comm.INDIRIZZO_PRINCIPALE}@${comm.NOME_UTILIZZATORE}@${comm.INDIRIZZO_UTILIZZATORE}" >${comm.ID_COMMESSA }</option>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="nomeCliente" name="nomeCliente" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Cliente Utilizzatore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="nomeClienteUtilizzatore" name="nomeClienteUtilizzatore" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="nomeSede" name="nomeSede" style="width:100%" required>       	
       	</div>
       </div><br>
           <div class="row">
       	<div class="col-sm-3">
       		<label>Sede Utilizzatore</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="nomeSedeUtilizzatore" name="nomeSedeUtilizzatore" style="width:100%" required>       	
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Data Intervento</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_intervento" name="data_intervento" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       		<div class="row">
       	<div class="col-sm-3">
       		<label>Responsabile</label>
       	</div>
       	<div class="col-sm-9">
				<select  id="operatore" name="operatore" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">

				<c:forEach items="${lista_operatori }" var="opr">
				
				<option value="${opr.id }" >${opr.nomeOperatore }</option>
					
				</c:forEach>
				</select>
       	</div>
       </div><br>
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-danger"onclick="saveInterventoFromModal('${commessa.ID_COMMESSA}')"  >Salva</button>
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


function filtraDate(){
	
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
 	dataString = "action=lista&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
 			endDatePicker.format('YYYY-MM-DD');
 	
 	 pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();

 	callAction("gestioneVerIntervento.do?"+ dataString, false,true);

 	//exploreModal("gestioneFormazione.do", dataString, '#content_consuntivo');
}

function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("gestioneVerIntervento.do?action=lista");

	}



function modificaInterventoModal(id_intervento, id_cliente, id_sede, commessa, tecnico_verificatore, sede_cliente, data_prevista, company){

	
	//initSelect2('#cliente_mod');
	
	updateSelectClienti(company, id_cliente, id_sede)
	
	$('#luogo_mod').val(sede_cliente);
	$('#luogo_mod').change();
	
	
	$('#id_intervento').val(id_intervento);
/* 	$('#cliente_mod').val(id_cliente);
	$('#cliente_mod').change();
	
	// $("#cliente_mod").trigger("chosen:updated");

	if(id_sede!='0'){
		$('#sede_mod').val(id_sede+"_"+id_cliente);	
	}else{
		$('#sede_mod').val(0);
	}
	$('#sede_mod').change(); */
	
	if(data_prevista!=null && data_prevista!=""){
		  $('#data_prevista_mod').val(Date.parse(data_prevista).toString("dd/MM/yyyy"));
	  }
	getStrumentiIntervento(id_intervento, tecnico_verificatore);

}

$('#myModalModificaIntervento').on('hidden.bs.modal',function(){
	
	$('#cliente_mod').val("");
	$('#cliente_mod').change();
	
	$(document.body).css('padding-right', '0px');
});


$('#comm').on('change', function(){
	
	if($("#comm").val()!=null && $("#comm").val()!=''){		
		id_commessa = $('#comm').val();
		
		var nomeCli=$('#comm').val().split("@")[1];
		
		var sedeCli=$('#comm').val().split("@")[2];	
		
		var nomeCliUtil=$('#comm').val().split("@")[3];
		
		var sedeCliUtil=$('#comm').val().split("@")[4];
		
		
		$("#nomeCliente").val(nomeCli);
		$("#nomeSede").val(sedeCli);
		$("#nomeClienteUtilizzatore").val(nomeCliUtil);
		$("#nomeSedeUtilizzatore").val(sedeCliUtil);
		
	}
});


var columsDatatables = [];

$("#tabVerInterventi").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabVerInterventi thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabVerInterventi thead th').eq( $(this).index() ).text();
    	
    	  
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	
	
	    	/* $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
    	  */
    	//  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );




function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
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
	$('.datepicker').datepicker('setDate', new Date());
    $('.dropdown-toggle').dropdown();
     


     
    
     
     
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
      
     
     

     table = $('#tabVerInterventi').DataTable({
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
		    	  
		    	  { responsivePriority: 0, targets: 6 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabVerInterventi_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });


		table.columns.adjust().draw();
		

	$('#tabVerInterventi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
	
   	$('#checkAll').on('ifChecked', function (ev) {

		$("#checkAll").prop('checked', true);
		table.rows().deselect();
		var allData = table.rows({filter: 'applied'});
		table.rows().deselect();
		i = 0;
		table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
		    //if(i	<maxSelect){
				 this.select();
		   /*  }else{
		    		tableLoop.exit;
		    }
		    i++; */
		    
		} );

  	});
	$('#checkAll').on('ifUnchecked', function (ev) {

		
			$("#checkAll").prop('checked', false);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();

	  	});
	
	
});


 $('#modificaInterventoForm').on('submit', function(e){
	 e.preventDefault();
	 var row =  document.getElementById('tab_luogo').children;
	  var string = '';
	  for(var i = 0;i<row.length;i++){
		  if(row[i].id!=null && row[i].id!=''){
   		var id = row[i].id.split("_")[1];			
			var ora = $('#ora_'+id).val();
			
			if(ora!='' && ora.length<5){
				ora = "0"+ora;
			}
			if($('#luogo_mod').val()!="2"){
				string = string + $('#id_'+id).val() + "_" +ora+";"	;
			}else{
				string = string + $('#id_'+id).val() + "_" + ora + "_" + $('#via_'+id).val() + "_" + $('#civico_'+id).val() + "_" + $('#comune_'+id).val() +";";
			}
		  }
	  }
	 
	  $('#ids_strumenti').val(string);
	 $('#luogo_mod').attr('disabled',false);
	 modificaVerIntervento();
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
			
			if(str.split("*")[1] == id_cliente || str.split("*")[2] == id_cliente)	
			{
				opt.push(options[i]);
			}   
	    
		   } 
		$('#commessa').html(opt);
		$('#commessa').val("");
		$("#commessa").change();  	
	});
 
 
 $("#cliente_mod").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_mod option').clone());
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
	 $("#sede_mod").prop("disabled", false);
	 
	  $('#sede_mod').html(opt);
	  
	  $("#sede_mod").trigger("chosen:updated");

		$("#sede_mod").change();  

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
		$('#commessa_mod').html(opt);
		$('#commessa_mod').val("");
		$("#commessa_mod").change();  	
	});

 
 
 
 function mockData() {
	 var options =  $('#cliente_appoggio option').clone();
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
 
 
 
 
 
 
 
 
 function updateSelectClienti(companyId, id_cliente, id_sede){
		var dataObj = {};
	
			pleaseWaitDiv = $('#pleaseWaitDialog');
			pleaseWaitDiv.modal();
	
		dataObj.company = companyId;
		dataObj.tipo = "";
		$.ajax({
	    	  type: "POST",
	    	  url: "gestioneUtenti.do?action=clientisedi",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		 
	    		  
	    		  if(data.success)
	    		  { 
	    			  $('#report_button').hide();
	    				$('#visualizza_report').hide();
	    			  /* 	if(tipo=="new"){
	    			  		idclienteitem="#cliente";
	    			  		idsedeitem="#sede";
	    			  		
	    			  	}else{
	    			  		idclienteitem="#modcliente";
	    			  		idsedeitem="#modsede";
	    			  		utente =  JSON.parse(data.utente);
	    			  	} */
	    			  	
	    			  	optionsClienti = JSON.parse(data.clienti);
	    			  	var opt=[];
	    			  	
	    			  	  opt.push("<option value = 0>Seleziona Cliente</option>");
	    		
	    			  	$.each(optionsClienti,function(index, value){

	    			  	      opt.push("<option value='"+value.__id+"'>"+value.nome+"</option>");
	    			  	});
	    			  	  
	    			  	
	    			   
	    			  	 $("#cliente_appoggio").html(opt);
	    			   			  	    			  	      
	    			  	 initSelect2("#cliente_mod");
	    			  	  
	    			  	optionsSedi = JSON.parse(data.sedi);
	    			  	var optsedi=[];
	    			  	
	    			  	//optsedi.push("<option value = 0>Non Associato</option>");
	    			  	$.each(optionsSedi,function(index, value){

	    			  			optsedi.push("<option value='"+value.__id+"_"+value.id__cliente_+"'>"+value.descrizione+" - "+value.indirizzo+"</option>");
	      			  	});
	    			  	
	    			  	$("#sede_mod").html(optsedi);  
	    			
	     			 /*    $("#cliente_mod").trigger("chosen:updated");	  	 
	  			  	$("#cliente_mod").change();  */  
	    			    
	    			/* 	 if(tipo=="mod"){
	    					if(utente.idSede!=0){
	    						$(idsedeitem).val(utente.idSede+"_"+utente.idCliente);
	    					}else{
	    						$(idsedeitem).val(utente.idSede);
	    					}
	    			  	  } */
	    				
	  			  	/*  $(idsedeitem).trigger("chosen:updated");
	  			  	 $(idsedeitem).change();  */  
	  			  	 
	  			  	 
	  			  	 
	  				$('#cliente_mod').val(id_cliente);
	  				$('#cliente_mod').change();
	  				
	  				// $("#cliente_mod").trigger("chosen:updated");

	  				if(id_sede!='0'){
	  					$('#sede_mod').val(id_sede+"_"+id_cliente);	
	  				}else{
	  					$('#sede_mod').val(0);
	  				}
	  				$('#sede_mod').change();
	  				
	  				 pleaseWaitDiv.modal('hide');
	    		
	    		  }else{
	    			  $('#myModalErrorContent').html(data.messaggio);
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	      				$('#visualizza_report').show();
						$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },

	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');

	    		  $('#myModalErrorContent').html(textStatus);
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#report_button').show();
	  				$('#visualizza_report').show();
					$('#myModalError').modal('show');
					
	    
	    	  }
	      });
	}
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

