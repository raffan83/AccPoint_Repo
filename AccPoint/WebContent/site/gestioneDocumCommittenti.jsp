<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Committenti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Committenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoCommittente()"><i class="fa fa-plus"></i> Nuovo Committente</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabDocumCommittenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome Cliente</th>
<th>Sede</th>
<th>Referente</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_committenti}" var="committente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${committente.id }</td>	
	<td>${committente.nome_cliente }</td>
	<td>${committente.indirizzo_cliente }</td>
	<td>${committente.nominativo_referente }</td>	
	<td>	
	 <a class="btn btn-warning customTooltip" title="Modifica committente" onClicK="modificaCommittenteModal('${committente.id}','${committente.id_cliente}','${committente.id_sede }','${utl:escapeJS(committente.nominativo_referente)}')" title="Click per modificare il Committente"><i class="fa fa-edit"></i></a>
	 <a class="btn btn-info customTooltip" title="Mostra lista Fornitori" onClick="showListaFornitori('${committente.id}','${utl:escapeJS(committente.nome_cliente)}','${utl:escapeJS(committente.indirizzo_cliente) }')"><i class="fa fa-search"></i></a> 
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



<form id="nuovoCommittenteForm" name="nuovoCommittenteForm">
<div id="myModalnuovoCommittente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Committente</h4>
      </div>
       <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input class="form-control" data-placeholder="Seleziona Cliente..." id="cliente" name="cliente" style="width:100%" required>
                       <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Referente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="referente" name="referente" class="form-control" type="text" style="width:100%" required>
       			
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




<form id="modificaCommittenteForm" name="nuovoCommittenteForm">
<div id="myModalModificaCommittente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Committente</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input class="form-control" data-placeholder="Seleziona Azienda..." id="cliente_mod" name="cliente_mod" style="width:100%" required>

       	</div>       	
       </div><br>
       
       
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_mod" name="sede_mod" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Referente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="referente_mod" name="referente_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_committente" name="id_committente">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



  <div id="myModalListaFornitori" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="label_fornitori"></h4>
      </div>
       <div class="modal-body">       
      	<div id="lista_fornitori_content">
      	
      	 <table id="tabFornitori" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<%-- <th>Committente</th> --%>
<th>Ragione Sociale</th>
<th>Indirizzo</th>
<th>Partita iva</th>
<th>Codice Fiscale</th>
<th>email</th>
<th>Stato</th>

<th>Azioni</th>
 </tr></thead>
 
 <tbody id="tbody_fornitori">
 </tbody>
      	</table>
      	
      	</div>
      	</div>
      <div class="modal-footer">

		<a class="btn btn-primary" onclick="$('#myModalListaFornitori').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>



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

<style>


.table th {
   background-color: #00a65a !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovoCommittente(){
	
	$('#myModalnuovoCommittente').modal();
	
}



function modificaCommittenteModal(id_committente, id_cliente, id_sede, referente){
	
	$('#id_committente').val(id_committente);
		
	$('#cliente_mod').val(id_cliente);
	$('#cliente_mod').change();
	
	if(id_sede==0){
		$('#sede_mod').val(id_sede);	
	}else{
		$('#sede_mod').val(id_sede+"_"+id_cliente);
	}
	
	$('#sede_mod').change();	

	$('#referente_mod').val(referente);
	
	$('#myModalModificaCommittente').modal();
}


var columsDatatables = [];

$("#tabDocumCommittenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDocumCommittenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDocumCommittenti thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



var columsDatatables1 = [];

$("#tabFornitori").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    		columsDatatables1 = state.columns;
    }
     $('#tabFornitori thead th').each( function () {
     	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
    	  var title = $('#tabFornitori thead th').eq( $(this).index() ).text();
    	
    	  
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');
	    

    	} ); 
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$("#myModalListaFornitori").on("hidden.bs.modal", function(){
	
	$(document.body).css('padding-right', '0px');
	
});



function showListaFornitori(id_committente, cliente, sede){
	
	dataString ="id_committente="+ id_committente;
    exploreModal("gestioneDocumentale.do?action=fornitori_committente",dataString,null,function(datab,textStatusb){

    	var json = JSON.parse(datab);
    	
    	var items = [];
    	
    	(json.fornitori).forEach(function(item){
    		
    		var fornitore = {};
    		
    		
    		fornitore.id = item.id;
    		fornitore.ragione_sociale = item.ragione_sociale;
    		fornitore.indirizzo = item.indirizzo;
    		fornitore.p_iva = item.p_iva;
    		fornitore.cf = item.cf;
    		fornitore.email = item.email;
    		fornitore.stato = "";
    		fornitore.azioni = "<td><a class=\"btn btn-info customTooltip \" title=\"Click per visualizzare il dettaglio fornitore\" onClick=\"callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore="+item.id_encrypted+"');\"><i class=\"fa fa-search\"></i></a></td>";
    		
    		items.push(fornitore);
    		
 	
    	  });
	   var table = $('#tabFornitori').DataTable();
	   
	   
	 	  
 	   table.clear().draw();

 		table.rows.add(items).draw();
 	    
 	    table.columns().eq( 0 ).each( function ( colIdx ) {
 	  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
 	  	      table
 	  	          .column( colIdx )
 	  	          .search( this.value )
 	  	          .draw();
 	  	  } );
 	  	} ); 
 	  		table.columns.adjust().draw();
 	  		$('.customTooltip').tooltipster({
 	  		    theme: 'tooltipster-light'
 	  		});
    	
 	  	
 	  		$('#label_fornitori').html("Lista fornitori di "+cliente + " - "+sede)		
 	  		
    	 
 	  		
 	  		
 	  	 $( "#myModalListaFornitori" ).modal()
  		
    });
	

}


 $( "#myModalListaFornitori" ).on('shown.bs.modal', function(){
	var table = $('#tabFornitori').DataTable();
	
	
	table.columns.adjust().draw();
});



$(document).ready(function() {
 
	  initSelect2('#cliente');
	  initSelect2('#cliente_mod');
	  
	  $('#sede').select2();
	  $('#sede_mod').select2();
	 
     $('.dropdown-toggle').dropdown();
     

     table = $('#tabDocumCommittenti').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDocumCommittenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDocumCommittenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	

	 tabForn = $('#tabFornitori').DataTable({
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
	           
	     columns : [
	     	 {"data" : "id"},
	     	 {"data" : "ragione_sociale"},
	     	 {"data" : "indirizzo"},
	     	 {"data" : "p_iva"},
	     	 {"data" : "cf"},
	     	 {"data" : "email"},
	         {"data" : "stato"},
	     	 {"data" : "azioni"}
	     ],	
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 7 },
	    	  
	    	  
	               ], 	        
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	 tabForn.buttons().container().appendTo( '#tabFornitori_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	   tabForn.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tabForn.column( colIdx ).header() ).on( 'keyup', function () {
	  tabForn
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  



 	  tabForn.columns.adjust().draw();
	

$('#tabFornitori').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});
	

	
	
});


$('#modificaCommittenteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaCommittente();
});
 

 
 $('#nuovoCommittenteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoCommittente();
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
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_mod").prop("disabled", false);
	 
	  $('#sede_mod').html(opt);
	  
	  $("#sede_mod").trigger("chosen:updated");
	  

		$("#sede_mod").change();  
		

	});

 function initSelect2(id_input) {

 	$(id_input).select2({
 	    data: mockData(),
 	    placeholder: 'search',
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

