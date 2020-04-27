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
        Lista Misure
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
	 Lista Misure Verificazione Periodica
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-left disabled" onClick="disableButton('#btnTutte')" style="margin-right:5px" id="btnTutte"> Tutte</a> 
<a class="btn btn-primary pull-left" onClick="disableButton('#btnPreventiva')" style="margin-right:5px" id="btnPreventiva"> Comunicazione Preventiva</a>
<a class="btn btn-primary pull-left" onClick="disableButton('#btnEsito')" id="btnEsito"> Comunicazione Esito</a>


</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabVerMisure" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>ID</th>
<th>Strumento</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Matricola</th>
<th>Cliente</th>
<th>Sede</th>
<th>Provincia</th>
<th>Commessa</th>
<th>Data richiesta pervenuta</th>
<th>Termine ultimo svolgimento attività</th>
<th>N. Attestato</th>
<th>N. Rapporto</th>
<th>Data Verificazione</th>
<th>Esito</th>
<th>Data Scadenza</th>
<th>N. Sigilli Usati</th>
<th>Tecnico Verificatore</th>
<th>Comunicazione Preventiva</th>
<th>Comunicazione Esito</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 	
 	<c:forEach items="${lista_misure }" var="misura" varStatus="loop">
 	<c:if test="${misura.obsoleta == 'N' }">
 	<c:choose>
 	<c:when test="${misura.comunicazione_preventiva == 'N' &&  misura.comunicazione_esito == 'N'}">
 		<tr id="row_${loop.index}" >
 	</c:when>
 	<c:when test="${misura.comunicazione_preventiva == 'S' &&  misura.comunicazione_esito == 'N'}">
 		<tr id="row_${loop.index}" style="background-color:yellow">
 	</c:when>
 	<c:when test="${misura.comunicazione_preventiva == 'S' &&  misura.comunicazione_esito == 'S'}">
 		<tr id="row_${loop.index}" style="background-color:#00ff80">
 	</c:when>
 	</c:choose>
	

	<td>${misura.id }</td>	
	<td>${misura.verStrumento.denominazione }</td>
	
	<td>${misura.verStrumento.costruttore }</td>
	<td>${misura.verStrumento.modello }</td>
	<td>${misura.verStrumento.matricola }</td>
	
	<td>${misura.verIntervento.nome_cliente}</td>
	<td>${misura.verIntervento.nome_sede }</td>	
	<td>${misura.verIntervento.provincia}</td>
	<td>${misura.verIntervento.commessa }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${misura.verIntervento.data_richiesta }" /></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${misura.verIntervento.data_termine_attivita }" /></td>
	
	<td>${misura.numeroAttestato }</td>
	<td>${misura.numeroRapporto }</td>
	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${misura.dataVerificazione }" /></td>
	
	<td>
	<c:if test="${misura.esito==1 }"><span class="label bigLabelTable label-success">POSITIVO</span></c:if>
	<c:if test="${misura.esito==0 }"><span class="label bigLabelTable label-danger">NEGATIVO</span></c:if>
	</td>
	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${misura.dataScadenza }" /></td>
	<td>${misura.numeroSigilli }</td>
	<td>${misura.tecnicoVerificatore.nominativo }</td>	
	<td>
	<c:if test="${misura.comunicazione_preventiva=='N'}">
	NO
	</c:if>
	<c:if test="${misura.comunicazione_preventiva=='S'}">
	SI
	</c:if>
	</td>
	<td>
	<c:if test="${misura.comunicazione_esito=='N'}">
	NO
	</c:if>
	<c:if test="${misura.comunicazione_esito=='S'}">
	SI
	</c:if>
	</td>
	<td>
	<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della misura" onClick="callAction('gestioneVerMisura.do?action=dettaglio&id_misura=${utl:encryptData(misura.id)}')"><i class="fa fa-search"></i></a>
	</td>
	</tr>
	</c:if>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>


</section>






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





var columsDatatables = [];

$("#tabVerMisure").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabVerMisure thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabVerMisure thead th').eq( $(this).index() ).text();
    	
    	      	  
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );

function disableButton(id_button){
	$(id_button).addClass('disabled');
	
	if(id_button=='#btnPreventiva' || id_button == '#btnEsito'){
		$('#btnTutte').removeClass('disabled');
	}
	filtraMisure();
}

function filtraMisure(){
		
	var table = $('#tabVerMisure').DataTable();
	
	if($('#btnTutte').hasClass('disabled')){
		$('#inputsearchtable_15').val('');
		$('#inputsearchtable_16').val('');
		$('#btnPreventiva').removeClass('disabled')
		$('#btnEsito').removeClass('disabled')
		 table
	        .columns( 15 )
	        .search( "" )
	        .draw();
		 table
	        .columns( 16 )
	        .search( "" )
	        .draw();
	}
	else if($('#btnPreventiva').hasClass('disabled') && !$('#btnEsito').hasClass('disabled')){
		$('#inputsearchtable_15').val('SI');
		$('#inputsearchtable_16').val('');
		 table
	        .columns( 15 )
	        .search( "SI" )
	        .draw();
		 table
	        .columns( 16 )
	        .search( "" )
	        .draw();
	}
	else if(!$('#btnPreventiva').hasClass('disabled') && $('#btnEsito').hasClass('disabled')){
		$('#inputsearchtable_15').val('');
		$('#inputsearchtable_16').val('SI');
		 table
	        .columns( 16 )
	        .search( "SI" )
	        .draw();
	}
	else if($('#btnPreventiva').hasClass('disabled') && $('#btnEsito').hasClass('disabled')){
		$('#inputsearchtable_15').val('SI');
		$('#inputsearchtable_16').val('SI');
		 table
	        .columns( 15 )
	        .search( "SI" )
	        .draw();
		 table
	        .columns( 16 )
	        .search( "SI" )
	        .draw();
	}
	

	 

}

$(document).ready(function() {
 
	

     $('.dropdown-toggle').dropdown();
     

     table = $('#tabVerMisure').DataTable({
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
		    	 
		    	  { responsivePriority: 1, targets: 14 },
		    	  { responsivePriority: 2, targets: 20 },
		    	  { responsivePriority: 3, targets: 11 }
		    	  
		               ], 	        
	  	      buttons: [   
	  	    	{
	                extend: 'excel',
	                text: 'Esporta Excel',
	                 exportOptions: {
	                    modifier: {
	                        page: 'current'
	                    }
	                } 
	            },
	  	    	  {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  },
	 			  ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabVerMisure_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabVerMisure').on( 'page.dt', function () {
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

