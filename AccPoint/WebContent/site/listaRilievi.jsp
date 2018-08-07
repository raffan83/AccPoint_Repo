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
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Rilievi Dimensionali
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Rilievi Dimensionali
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-sm-12">
<button class="btn btn-primary" onClick="modalNuovoRilievo()"><i class="fa fa-plus"></i> Nuovo Rilievo</button>

</div>
</div><br>


<div class="row">
<div class="col-sm-12">


 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Data Inizio Rilievo</th>
<th>Tipo Rilievo</th>
<%-- <th>Pezzo</th> --%>
<th>Cliente</th>
<th>Sede</th>
<th>Commessa</th>
<%-- <th>N. Quote</th> --%>
<th>Utente</th>
<th>Azioni</th>


 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">
	<tr id="row_${loop.index}" >
		<td>${rilievo.id }</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>		
		<td>${rilievo.tipo_rilievo.descrizione }</td>
<%-- 		<td>${rilievo.pezzo.denominazione }</td>	 --%>	
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.commessa}</td>
	<%-- 	<td>${rilievo.n_quote }</td> --%>
		<td>${rilievo.utente.nominativo }</td>
		<td>
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${rilievo.id}')"><i class="fa fa-search"></i></a>
		<a href="#" class="btn btn-warning customTooltip" title="Click per modificare il rilievo" onclick="modalModificaRilievo('${rilievo.id }','${rilievo.data_inizio_rilievo }','${rilievo.tipo_rilievo.id }','${rilievo.id_cliente_util }','${rilievo.id_sede_util }','${rilievo.commessa}')">		
		<i class="fa fa-edit"></i></a>
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
<form id="nuovoRilievoForm" name="nuovoRilievoForm">
<div id="myModalNuovoRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Rilievo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente" name="cliente" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="sede" name="sede" style="width:100%" disabled required>
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
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="commessa" name="commessa" style="width:100%">
       		<option value=""></option>
       			<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo Rilievo..." id="tipo_rilievo" name="tipo_rilievo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_rilievo }" var="tipo_rilievo" varStatus="loop">
       				<option value="${tipo_rilievo.id}">${tipo_rilievo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
<%--        <div class="row">
       	<div class="col-sm-3">
       		<label>Pezzo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Pezzo..." id="pezzo" name="pezzo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_pezzi }" var="pezzo" varStatus="loop">
       				<option value="${pezzo.id}">${pezzo.denominazione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br> --%>
	 <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Quote</label>
       	</div>
       	<div class="col-sm-9">       		
               <input type='number' min="0" class="form-control" id="n_quote" name="n_quote" style="width:100%" required>               
        </div> 
       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' id='datepicker_data_rilievo'>
               <input type='text' class="form-control input-small" id="data_rilievo" name="data_rilievo">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       </div>

  		 
      <div class="modal-footer">
      <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <a class="btn btn-primary"  onClick="inserisciRilievo()">Salva</a> 
		
       
      </div>
    </div>
  </div>

</div>
</form>




<form id="modificaRilievoForm" name="modificaRilievoForm">
<div id="myModalModificaRilievo" class="modal fade" role="dialog" aria-labelledby="myLargeModalModificaRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Rilievo</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Cliente..." id="mod_cliente" name="mod_cliente" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Sede..." id="mod_sede" name="mod_sede" style="width:100%" disabled required>
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
       		<select class="form-control select2" data-placeholder="Seleziona Commessa..." id="mod_commessa" name="mod_commessa" style="width:100%">
       		<option value=""></option>
       			<c:forEach items="${lista_commesse }" var="commessa" varStatus="loop">
       				<option value="${commessa.ID_COMMESSA}">${commessa.ID_COMMESSA}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<select class="form-control select2" data-placeholder="Seleziona Tipo Rilievo..." id="mod_tipo_rilievo" name="mod_tipo_rilievo" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_tipo_rilievo }" var="tipo_rilievo" varStatus="loop">
       				<option value="${tipo_rilievo.id}">${tipo_rilievo.descrizione}</option>
       			</c:forEach>
       		</select>
       	</div>
       </div><br>
	 <div class="row">
       	<div class="col-sm-3">
       		<label>Numero Quote</label>
       	</div>
       	<div class="col-sm-9">       		
               <input type='number' min="0" class="form-control" id="mod_n_quote" name="mod_n_quote" style="width:100%" required>               
        </div> 
       	
       </div><br>
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Rilievo</label>
       	</div>
       	<div class="col-sm-9">
       		<div class='input-group date datepicker' >
               <input type='text' class="form-control input-small" id="mod_data_rilievo" name="mod_data_rilievo">
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div>
       </div>
		<input type="hidden" id="id_rilievo" name= "id_rilievo">
  		 
      <div class="modal-footer">
      <label id="mod_label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label>

		 <button class="btn btn-primary" type="submit">Modifica</button> 
		
       
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

 <script type="text/javascript">
 
 function modalNuovoRilievo(){
	 $('#myModalNuovoRilievo').modal();
 }
 
 function dettaglioRilievo(id_rilievo) {

 	 dataString = "?action=dettaglio&id_rilievo="+id_rilievo;
	  
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
     

	
 $(document).ready(function() {
	 $('#label').hide();
	 $('.select2').select2();
	 
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
	        "order": [[ 0, "desc" ]],
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
		    	  { responsivePriority: 2, targets: 7 }
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
			
			//if(opt.length == 0){
		 
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#sede").change();  
	  //}
	  
	
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
 
 $('#nuovoRilievoForm').on('submit', function(e){
	 e.preventDefault();
 
 });
 $('#modificaRilievoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaRilievo()
 });
 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






