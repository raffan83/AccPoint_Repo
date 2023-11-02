<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        Lista Firme Clienti
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
	 Lista  Firme Clienti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="$('#myModalNuovaFirma').modal()"><i class="fa fa-plus"></i> Carica Nuova Firma</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabFirme" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Cliente</th>
<th>Sede</th>
<th>Nominativo firma</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_firme}" var="firma" varStatus="loop">

 	<tr id="row_${loop.index}" >

	<td>${firma.id }</td>	
	<td>${firma.nome_cliente }</td>
	<td>${firma.nome_sede }</td>
	<td>${firma.nominativo_firma }</td>

	<td>	


<a class="btn btn-info customTooltip" onClicK="callAction('gestioneFirmaCliente.do?action=download_firma&id_firma=${firma.id }')" title="Click per scaricare la firma"><i class="fa fa-image"></i></a>
 	  <a class="btn btn-warning customTooltip" onClicK="modalModificaFirma('${firma.id }','${firma.id_cliente }','${firma.id_sede }','${utl:escapeJS(firma.nominativo_firma) }','${firma.nome_file }')" title="Click per modificare la firma"><i class="fa fa-edit"></i></a>
 	
 	  <a class="btn btn-danger customTooltip" onClicK="modalEliminaFirma('${firma.id }')" title="Click per eliminare la firma"><i class="fa fa-trash"></i></a>

 
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






 


<form id="NuovaFirmaForm" name="NuovaFirmaForm"> 
   <div id="myModalNuovaFirma" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Firma</h4>
      </div>
       <div class="modal-body">   

       <div class="row">
       <div class="col-xs-3">
       <label>Cliente</label>
       </div>
        <div class="col-xs-9">

        <input class="form-control" data-placeholder="Seleziona Cliente..." id="cliente" name="cliente" style="width:100%" >
<select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
        </div>      
       </div>
       <br>
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled >
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div>    <br>
       
       <div class="row">

       <div class="col-xs-3">
       <label>Nominativo firma</label>
       </div>
        <div class="col-xs-9">
      		<input type="text" class="form-control" id="nominativo_firma" name="nominativo_firma" style="width:100%" required>
      	
      	</div>
      	</div><br>
       
      	<div class="row">
     
      	<div class="col-xs-12">
      		<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".png,.PNG, .jpg,.JPG,.jpeg, .JPEG"  id="file_firma" name="file_firma" type="file" required></span><label id="label_nome_file"></label>
      	
      	</div>
      	</div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="flag_pdf">
		<button class="btn btn-primary" type="submit" >Salva</button>
      </div>
    </div>
  </div>

</div>
   </form>

<form id="ModificaFirmaForm" name="NuovaFirmaForm"> 
   <div id="myModalModificaFirma" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Firma</h4>
      </div>
       <div class="modal-body">   

       <div class="row">
       <div class="col-xs-3">
       <label>Cliente</label>
       </div>
        <div class="col-xs-9">

        <input class="form-control" data-placeholder="Seleziona Cliente..." id="cliente_mod" name="cliente_mod" style="width:100%" >

        </div>      
       </div>
       <br>
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_mod" name="sede_mod" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled >
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div>    <br>
       
       <div class="row">

       <div class="col-xs-3">
       <label>Nominativo firma</label>
       </div>
        <div class="col-xs-9">
      		<input type="text" class="form-control" id="nominativo_firma_mod" name="nominativo_firma_mod" style="width:100%" required>
      	
      	</div>
      	</div><br>
       
      	<div class="row">
     
      	<div class="col-xs-12">
      		<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".png,.PNG, .jpg,.JPG,.jpeg, .JPEG"  id="file_firma_mod" name="file_firma_mod" type="file" ></span><label id="label_nome_file_mod"></label>
      	
      	</div>
      	</div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_firma" name="id_firma">
		<button class="btn btn-primary" type="submit" >Salva</button>
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
      	Sei sicuro di voler eliminare il firma?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_firma">
      <a class="btn btn-primary" onclick="eliminaFirma($('#elimina_firma').val())" >SI</a>
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


function modalEliminaFirma(id_firma){
	
	
	$('#elimina_firma').val(id_firma);
	$('#myModalYesOrNo').modal()
	
}


function eliminaFirma(){
	
	dataObj = {};
	
	dataObj.id_firma = $('#elimina_firma').val();
	
	callAjax(dataObj, "gestioneFirmaCliente.do?action=elimina_firma");
}





function modalModificaFirma(id,id_cliente, id_sede,nominativo, nome_file){
	
	$('#id_firma').val(id);
	
	$('#cliente_mod').val(id_cliente);
	$('#cliente_mod').change();
	
	if(id_sede!=0){
		$('#sede_mod').val(id_sede+"_"+id_cliente);
		$('#sede_mod').change();
	}else{
		$('#sede_mod').val(0);
		$('#sede_mod').change();
	}


	$('#nominativo_firma_mod').val(nominativo);
	$('#label_nome_file_mod').html(nome_file);
	
	$('#myModalModificaFirma').modal();
}




var columsDatatables = [];

$("#tabFirme").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabFirme thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabFirme thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


$('#file_firma_mod').change(function(){
	

	$('#label_nome_file_mod').html($(this).val().split("\\")[2]);
});


$('#file_firma').change(function(){
	

	$('#label_nome_file').html($(this).val().split("\\")[2]);
});

var dataSelect2 = {};
$(document).ready(function() {
 

	dataSelect2 = mockData();
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     initSelect2("#cliente");
     initSelect2("#cliente_mod");
     $('#sede').select2();
     $('#sede_mod').select2();
     
     table = $('#tabFirme').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 4 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, 
	 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  }
	 			  ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabFirme_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabFirme').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
		
	
});


$('#ModificaFirmaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#ModificaFirmaForm','gestioneFirmaCliente.do?action=modifica');
});
 

 
 $('#NuovaFirmaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 callAjaxForm('#NuovaFirmaForm','gestioneFirmaCliente.do?action=nuovo');
});
 
/*  $('#formScheda').on('submit', function(e){
	 e.preventDefault();
	 nuovaSchedaDPI();
}); */


$('#modalScheda').on('hidden.bs.modal', function(){
	
	$('#tipo_scheda').val("");
	$('#tipo_scheda').change();
	$('#lavoratore_scheda').val("");
	$('#lavoratore_scheda').change();
	
});

 
 
$("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  
	  opt.push("<option value = 0 selected>Non Associate</option>");

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
	    
	    $(this).data('options', $('#sede_mod option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  
	  opt.push("<option value = 0 selected>Non Associate</option>");

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
 
var options =  $('#cliente_appoggio option').clone();
function mockData() {
	  return _.map(options, function(i) {		  
	    return {
	      id: i.value,
	      text: i.text,
	    };
	  });
	}
	


function initSelect2(id_input, data) {
	 
	 if(data == null){
		 data = dataSelect2;
	 }

	$(id_input).select2({
	    data: data,
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
	        results = _.filter( function(e) {
	        	
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


