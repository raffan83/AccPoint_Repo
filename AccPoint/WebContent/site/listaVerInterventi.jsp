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
        Lista interventi
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
	 Lista Interventi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="callAction('gestioneVerComunicazionePreventiva.do',null,true)"><i class="fa fa-plus"></i> Nuovo Intervento</a> 
<a class="btn btn-primary pull-right" onClick="comunicazionePreventiva()" style="margin-right:5px"><i class="fa fa-plus"></i> Comunicazione Preventiva</a>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabVerInterventi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 	 <th></th>
  <th style="max-width:65px" class="text-center"></th>
<th>ID</th>
<th>Cliente</th>
<th>Sede</th>
<th>Provincia</th>
<th>Commessa</th>
<th>Stato</th>
<th>Data Prevista</th>
<th>Data Creazione</th>
<th>Data Chiusura</th>
<th>Responsabile</th>
<th>Verificatore</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_interventi }" var="intervento" varStatus="loop">
	<tr id="row_${loop.index}" >
	 <td></td>
 	<td class="select-checkbox"></td>
	<td>${intervento.id }</td>	
	<td>${intervento.nome_cliente }</td>
	<td>${intervento.nome_sede }</td>
	<td>${intervento.provincia}</td>
	<td>${intervento.commessa }</td>
	<td>
	<c:choose>
		<c:when test="${intervento.id_stato_intervento == 0}">
		<span class="label label-success">APERTO</span>
	</c:when>
	<c:otherwise>
		<span class="label label-warning">CHIUSO</span>
	</c:otherwise>
	</c:choose>
	</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.data_prevista }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.data_creazione }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${intervento.data_chiusura }" /></td>
	<td>${intervento.user_creation.nominativo }</td>
	<td>${intervento.user_verificazione.nominativo }</td>	
	<td>
	<a class="btn btn-info" onClicK="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')" title="Click per aprire il dettaglio dell'intervento"><i class="fa fa-arrow-right"></i></a>
	<a class="btn btn-warning" onClicK="modificaInterventoModal('${intervento.id}','${intervento.id_cliente }','${intervento.id_sede }','${intervento.commessa }','${intervento.user_verificazione.id }','${intervento.in_sede_cliente }','${intervento.data_prevista }')" title="Click per modificare l'intervento"><i class="fa fa-edit"></i></a>
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





<form id="modificaInterventoForm" name="modificaInterventoForm">
<div id="myModalModificaIntervento" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
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
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
                
        </div>  	
        <input id="cliente_mod" name="cliente_mod" class="form-control" style="width:100%">
       		<%-- <select class="form-control select2" data-placeholder="Seleziona Cliente..." id="cliente_mod" name="cliente_mod" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_clienti }" var="cliente" varStatus="loop">
       				<option value="${cliente.__id}">${cliente.nome }</option>
       			</c:forEach>
       		</select>    --%>    	
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
       </div>       
       
       </div>
  		 
      <div class="modal-footer">
      <!-- <label id="label" style="color:red" class="pull-left">Attenzione! Compila correttamente tutti i campi!</label> -->

		 <!-- <a class="btn btn-primary"  onClick="inserisciRilievo()">Salva</a>  -->
		<!--  <a class="btn btn-primary"  type="submit">Salva</a>  -->
		<input type="hidden" id="id_intervento" name="id_intervento">
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
      	Sei sicuro di voler eliminare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary" onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
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


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovoIntervento(){
	
	$('#multipla').hide();
	$('#myModalNuovoIntervento').modal();
	
}



function modificaInterventoModal(id_intervento, id_cliente, id_sede, commessa, tecnico_verificatore, sede_cliente, data_prevista){
	
	$('#id_intervento').val(id_intervento);
	$('#cliente_mod').val(id_cliente);
	$('#cliente_mod').change();
	if(id_sede!='0'){
		$('#sede_mod').val(id_sede+"_"+id_cliente);	
	}else{
		$('#sede_mod').val(0);
	}
	$('#sede_mod').change();
	
	
	$('#tecnico_verificatore_mod').val(tecnico_verificatore);
	$('#tecnico_verificatore_mod').change();
/* 	$('#tecnico_riparatore_mod').val(tecnico_riparatore);
	$('#tecnico_riparatore_mod').change(); */
	$('#luogo_mod').val(sede_cliente);
	$('#luogo_mod').change();
	if(data_prevista!=null && data_prevista!=""){
		  $('#data_prevista_mod').val(Date.parse(data_prevista).toString("dd/MM/yyyy"));
	  }
	

	$('#myModalModificaIntervento').modal();
}

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
    	
    	  if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
	    	else if($(this).index() ==1){
	    	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
	      }
	    	 $('#checkAll').iCheck({
	             checkboxClass: 'icheckbox_square-blue',
	             radioClass: 'iradio_square-blue',
	             increaseArea: '20%' // optional
	           }); 
    	  
    	//  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );


function comunicazionePreventiva(){
	
 var table = $("#tabVerInterventi").DataTable();
	 
	 var str = "";
	 
	 
	 $('#tabVerInterventi tbody tr').each(function(){
		 if($(this).hasClass("selected")){
			 var td = $(this).find('td').eq(2);
			 str = str+td[0].innerText+";"
		 }
		
	 });
	 
	if(str == ''){
		$('#myModalErrorContent').html("Nessun intervento selezionato!")
	  	$('#myModalError').removeClass();
		$('#myModalError').addClass("modal modal-danger");	  
		$('#myModalError').modal('show');		
	}else{
		creaComunicazioneFromInterventi(str);
		//callAction('gestioneVerComunicazionePreventiva.do?action=crea_comunicazione_da_interventi&ids='+str)	
	}
}

var commessa_options;
$(document).ready(function() {
 
	commessa_options = $('#commessa_mod option').clone();
	initSelect2('#cliente_mod');
	$('#cliente_mod').change();
	$('#sede_mod').select2();
	$('#commessa_mod').select2();
	$('#tecnico_verificatore_mod').select2();
	$('#luogo_mod').select2();
	$('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
     $('.dropdown-toggle').dropdown();
     
     

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
		    	  { className: "select-checkbox", targets: 1,  orderable: false },
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 13 }
		    	  
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

	table.columns().eq( 0 ).each( function ( colIdx ) {
	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	      table
	          .column( colIdx )
	          .search( this.value )
	          .draw();
	  } );
	} ); 
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
	 modificaVerIntervento();
});
 

 
 $('#nuovoInterventoForm').on('submit', function(e){
	 e.preventDefault();
	 inserisciVerIntervento();
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

 
 
 var options =  $('#cliente_appoggio option').clone();
 function mockData() {
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
 
  </script>
  
</jsp:attribute> 
</t:layout>

