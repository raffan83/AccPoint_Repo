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
        Lista Offerte
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
	 Lista Offerte
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovaIntervento()"><i class="fa fa-plus"></i> Nuova Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovaOfferta()"><i class="fa fa-plus"></i> Nuova Offerta</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabOfferte" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th style="max-width:40px">ID</th>

<th>Cliente</th>
<th>Sede</th>
<th>Data</th>
<th>Importo</th>
<th>Utente</th>
<th style="">Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_offerte }" var="offerta" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${offerta.id }</td>	
	
	<td>${offerta.nome_cliente }</td>

	<td>${offerta.nome_sede }</td>
	<td> <fmt:formatDate value="${offerta.data_offerta }" pattern="dd/MM/yyyy" /></td>
	<td>${offerta.importo }</td>
	<td>${offerta.utente }</td>
	<td>
<a class="btn btn-info customTooltip" onClicK="dettaglioOfferta('${offerta.id }', '${utl:encryptData(offerta.id_cliente) }','${utl:encryptData(offerta.id_sede) }')" title="Dettaglio offerta"><i class="fa fa-search"></i></a>

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

  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'offerta?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_offerta_elimina">
      <a class="btn btn-primary" onclick="eliminaOfferta($('#id_offerta_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>

<form id="nuovaOffertaForm" name="nuovaOffertaForm">
<div id="myModalNuovaOfferta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Offerta</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>
       	 <div class="col-md-6" style="display:none">  
                  <label>Cliente</label>
               <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${utl:encryptData(cliente.__id)}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
                
        </div> 
       	
       	<div class="col-sm-9">      
       	  	
      <input id="cliente" name="cliente" class="form-control" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
              <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${utl:encryptData(sd.__id)}_${utl:encryptData(sd.id__cliente_)}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
       			
       	</div>       	
       </div><br>
       
     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lista Articoli</label>
       	</div></div><br>
       	 <div class="row">
       	<div class="col-sm-12">      
       	  	
        
   <table id="tabArticoli" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th><input id="selectAlltabPM" type="checkbox" /></th>
 <th>ID Articolo</th>
 <th>Descrizione</th>
  <th>Importo</th>
  <th>Quantit&agrave;</th>
   </tr></thead>
 
 <tbody>
 

 
 <c:forEach items="${lista_articoli}" var="articolo" varStatus="loop">
 

	 <tr role="row" id="${articolo.ID_ANAART}">

<td></td>
	<td>${articolo.ID_ANAART}</td>


<td>${articolo.DESCR}</td>
<td>${articolo.importo}</td>
<td></td>


	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       

       	<div class="col-xs-4">
			<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Carica Immagini ...</span>
				<input accept=".jpg,.png"  id="fileupload_img" name="fileupload_img" type="file" multiple required>
		       
		   	 </span>
		   	</div>
		 <div class="col-xs-8">
		 <label id="label_img"></label>
		 </div> 
       	
       	</div>
   </div>
  		 
      <div class="modal-footer">
      <input type="hidden" id="id_articoli" name="id_articoli">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>


<div id="myModalDettaglioOfferta" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Offerta</h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cliente</label>
       	</div>

       	
       	<div class="col-sm-9">      
       	  	
      <input id="cliente_dtl" name="cliente_dtl" class="form-control" style="width:100%" disabled >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Sede</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
              <select id="sede_dtl" name="sede_dtl" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${utl:encryptData(sd.__id)}_${utl:encryptData(sd.id__cliente_)}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
       			
       	</div>       	
       </div><br>
       
     <div class="row">
       
       	<div class="col-sm-3">
       		<label>Lista Articoli</label>
       	</div></div><br>
       	 <div class="row">
       	<div class="col-sm-12">      
       	  	
        
   <table id="tabDettaglio" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID Articolo</th>
 <th>Descrizione</th>
  <th>Importo</th>
  <th>Quantit&agrave;</th>
   </tr></thead>
 
 <tbody>
 


	
 </tbody>
 </table>  
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       

       	<div class="col-xs-12">
			<label>Immagini offerta</label><br>
			<div id="content_immagini"></div>

<!-- Popup di anteprima -->
<div id="preview_popup" style="display:none; position:absolute; z-index:1000;">
    <img id="preview_img" src="" style="max-width:300px; max-height:300px; border:2px solid #444; border-radius:6px; background:#fff; box-shadow:0 2px 10px rgba(0,0,0,0.3);" />
</div>
		   	</div>
		 
       	
       	</div>
   </div>
  		 
      <div class="modal-footer">
      <input type="hidden" id="id_articoli" name="id_articoli">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
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
      .img-container {
            max-width: 200px;
            max-height: 200px;
            overflow: hidden;
        }
        .img-container img {
            width: 100%;
            height: auto;
        }
        
        .table th input {
    min-width: 45px !important;
}


 #image-popup{
  position: fixed;
  display: none;
  top: 20px;
  right: 20px;
  width: 400px;
   max-height: calc(100vh - 40px);
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 6px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  z-index: 9999;
}

#image-popup img{
  width: 100%;
  height: auto;
  display: block;
  border-radius: 6px;
}
</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovaOfferta(){
	
	$('#myModalNuovaOfferta').modal();
	
}


function modificaOfferta(id_offerta, targa, modello, id_company, km_percorsi, carta_circolazione, portata_max_offerta, immagine_offerta, dispositivo_pedaggio,note, autorizzazione){
	
	$('#id_offerta').val(id_offerta);
	$('#targa_mod').val(targa);
	$('#modello_mod').val(modello);
	$('#company_mod').val(id_company);
	$('#company_mod').change();
	$('#km_percorsi_mod').val(km_percorsi);
	$('#label_carta_circolazione_mod').html(carta_circolazione);
	$('#portata_max_mod').val(portata_max_offerta);
	$('#label_immagine_offerta_mod').html(immagine_offerta);
	$('#dispositivo_pedaggio_mod').val(dispositivo_pedaggio);
	$('#note_mod').val(note)
	$('#autorizzazione_mod').val(autorizzazione)

	$('#myModalModificaOfferta').modal();
}



function modalEliminaOfferta(id_offerta){
	
	
	$('#id_offerta_elimina').val(id_offerta);
	$('#myModalYesOrNo').modal()
	
}


$('#fileupload_immagine_offerta').change(function(){
	$('#label_immagine_offerta').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione').change(function(){
	$('#label_carta_circolazione').html($(this).val().split("\\")[2]);
	 
 });
 
 
$('#fileupload_immagine_offerta_mod').change(function(){
	$('#label_immagine_offerta_mod').html($(this).val().split("\\")[2]);
	 
 });


$('#fileupload_carta_circolazione_mod').change(function(){
	$('#label_carta_circolazione_mod').html($(this).val().split("\\")[2]);
	 
 });

function eliminaOfferta(){
	
	dataObj = {};
	
	dataObj.id_offerta_elimina = $('#id_offerta_elimina').val();
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=elimina_offerta");
}


var columsDatatables = [];

 $("#tabOfferte").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabOfferte thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabOfferte thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    //	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

		    	if($(this).index() == 0){
	 				$(this).append( '<div><input class="inputsearchtable"  style="width:15px !important" type="text" /></div>');
	 			}else{
	 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
	 			}
    	  
    	} );
    
    

} );
 
 
 $("#tabArticoli").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	   

	    $('#tabArticoli thead th').each( function () {
	 
	    	  var title = $('#tabArticoli thead th').eq( $(this).index() ).text();
	    	


			    	if($(this).index() > 0){
		 				
		 				$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');	
		 			}
	    	  
	    	} );
	    
	    

	} );
 


$(document).ready(function() {
 

  $('#sede').select2();
  $('#sede_dtl').select2();
    	initSelect2('#cliente',null, '#myModalNuovaOfferta');
    	initSelect2('#cliente_dtl', null, '#myModalDettaglioOfferta');
        $('.dropdown-toggle').dropdown();


 		
 		

 	     table = $('#tabOfferte').DataTable({
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
 		        "order": [[ 3, "asc" ]],
 			      paging: true, 
 			      ordering: true,
 			      info: true, 
 			      searchable: true, 
 			      targets: 0,
 			      responsive: true,
 			      scrollX: false,
 			      stateSave: true,	
 			           
 			      columnDefs: [
 			    	  
 			    	  { responsivePriority: 1, targets: 5 },
 			    	  
 			    	  
 			               ], 	        
 		  	      buttons: [   
 		  	          {
 		  	            extend: 'colvis',
 		  	            text: 'Nascondi Colonne'  	                   
 		 			  } ]
 			               
 			    });
 		
 		
 	     
  
  		
     
		table.buttons().container().appendTo( '#tabOfferte_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabOfferte').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	tabArticoli = $('#tabArticoli').DataTable({
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
        pageLength: 100,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	    stateSave: false,
	    select: {
	      	style:    'multi+shift',
	      	selector: 'td:nth-child(1)'
	  	},
	      columnDefs: [
	    	  { targets: 0,  orderable: false },
              { className: "select-checkbox", targets: 0,  orderable: false }  
	               ]
	     
	               
	    	
	      
	    });
	



	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });

	    tabArticoli.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tabArticoli.column( colIdx ).header() ).on( 'keyup', function () {
	  tabArticoli
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  
	    tabArticoli.columns.adjust().draw();
	
	
	    tabDettaglio = $("#tabDettaglio").DataTable({
	        language: {
	            emptyTable: "Nessun dato presente nella tabella",
	            info: "Vista da _START_ a _END_ di _TOTAL_ elementi",
	            infoEmpty: "Vista da 0 a 0 di 0 elementi",
	            infoFiltered: "(filtrati da _MAX_ elementi totali)",
	            infoThousands: ".",
	            lengthMenu: "Visualizza _MENU_ elementi",
	            loadingRecords: "Caricamento...",
	            processing: "Elaborazione...",
	            search: "Cerca:",
	            zeroRecords: "La ricerca non ha portato alcun risultato.",
	            paginate: {
	                first: "Inizio",
	                previous: "Precedente",
	                next: "Successivo",
	                last: "Fine"
	            },
	            aria: {
	                srtAscending: ": attiva per ordinare la colonna in ordine crescente",
	                sortDescending: ": attiva per ordinare la colonna in ordine decrescente"
	            }
	        },
	        pageLength: 25,
	        order: [[0, "desc"]],
	        paging: false,
	        ordering: true,
	        info: true,
	        searchable: false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: true,
	        columns : [
		    	{"data" : "id_articolo"},  
		    	{"data" : "descrizione"},  
		    	{"data" : "importo"},
		      	{"data" : "quantita"}
		      
		       ],	
	        columnDefs: [
	            { responsivePriority: 1, targets: 1 }
	            
	        ],
	        buttons: [{
	            extend: 'colvis',
	            text: 'Nascondi Colonne'
	        }]
	    });
	
	
});


$('#selectAlltabPM').on('ifChecked', function (ev) {

	
	
	$("#selectAlltabPM").prop('checked', true);
	tabArticoli.rows().deselect();
	var allData = tabArticoli.rows({filter: 'applied'});
	tabArticoli.rows().deselect();
	i = 0;
	tabArticoli.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
	 
			 this.select();
	   
	    
	} );

	});
$('#selectAlltabPM').on('ifUnchecked', function (ev) {

	

	
		$("#selectAlltabPM").prop('checked', false);
		tabArticoli.rows().deselect();
		var allData = tabArticoli.rows({filter: 'applied'});
		tabArticoli.rows().deselect();

  	});


$('#modificaOffertaForm').on('submit', function(e){
	 e.preventDefault();
	 
	 
	 callAjaxForm('#modificaOffertaForm','gestioneParcoAuto.do?action=modifica_offerta');
});
 

 
 $('#nuovaOffertaForm').on('submit', function(e){
	 e.preventDefault();
	 var id_articoli = "";
	 tabArticoli.rows({ selected: true }).every(function () {
 	        var $row = $(this.node());
 	        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
 	       var quantita = $('#quantita_'+id).val();
 	     	   
 	       id_articoli += id +","+quantita+ ";";
 	    });
    	
    	$('#id_articoli').val(id_articoli)
	 callAjaxForm('#nuovaOffertaForm','gestioneVerOfferte.do?action=nuova_offerta');
	
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
	
	  opt.push("<option value = '${non_associate_encrypt}'>Non Associate</option>");

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
	  
	  //$("#sede").trigger("chosen:updated");
	  

		//$("#sede").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 
		   
		  

	});
 
 
 $("#cliente_dtl").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_dtl option').clone());
	  }
	  
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = '${non_associate_encrypt}'>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{

			opt.push(options[i]);
		}   
	   }
	 $("#sede_dtl").prop("disabled", false);
	 
	  $('#sede_dtl').html(opt);
	  
	  //$("#sede").trigger("chosen:updated");
	  

		//$("#sede").change();  
		
		  var id_cliente = selection.split("_")[0];
		  

		  var opt=[];
			opt.push("");
		   for(var  i=0; i<options.length;i++)
		   {
			   if(str!='' && str.split("_")[1]==id)
				{
					opt.push(options[i]);
				}   
		   } 
		   
		  

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
 	


 function initSelect2(id_input, placeholder, dropDownParent) {

	 if(placeholder==null){
		  placeholder = "Seleziona Cliente...";
	  }
 	$(id_input).select2({
 	    data: mockData(),
 	   dropdownParent: $(dropDownParent),
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

 $('#fileupload_img').change(function(){
		
	  const files = this.files; // elenco di File oggetti
	    let fileNames = [];

	    for (let i = 0; i < files.length; i++) {
	        fileNames.push(files[i].name);
	    }

	    // Mostra tutti i nomi separati da virgola (o su più righe)
	    $('#label_img').html(fileNames.join(', '));
	});
 
 
 
 
 $("#tabArticoli").on('select.dt', function (e, dt, type, indexes) {
     if (type === 'row') {
         indexes.forEach(function(index) {
             var row = dt.row(index).node();
             $(row).find('td').each(function(i, cell) {
                 const $cell = $(cell);
                 if (i === 0 || i === 1 || i === 2 || i === 3) return;

                 if (!$cell.data('original-border')) {
                     $cell.data('original-border', $cell.css('border'));
                 }

                 $cell.css('border', '1px solid red');

             
                  if(i === 4){
                 	var id = $(row)[0].id;
                 	 const input = $('<input id="quantita_'+id+'" class="form-control" style="width:100%" type="number" min="0" step="1"/>');
	                        $cell.html(input);	
                 }
         
             });
         });
     }
     
 
 });

 // Deselect row
 $("#tabArticoli").on('deselect.dt', function (e, dt, type, indexes) {
     if (type === 'row') {
         indexes.forEach(function(index) {
             var row = dt.row(index).node();
             $(row).find('td').each(function(i, cell) {
                 const $cell = $(cell);
                 if (i === 0 || i === 1 || i === 2 || i === 3) return;

                 const originalBorder = $cell.data('original-border');
                 if (originalBorder !== undefined) {
                     $cell.css('border', originalBorder);
                     $cell.removeData('original-border');
                 }

                 $cell.text('');
             });
         });
     }
     
 });

 
	$(document).on('mousemove', '.list-group-item', function (e) {
		 
		
		  const popupId ='#image-popup';
		  const imgId =  '#popup-img';

		  const thumbSpan = $(this).find('.option-with-thumb');
		  if (thumbSpan.length > 0) {
		    const largeSrc = thumbSpan.data('large');
		    $(imgId).attr('src', largeSrc);

		    // Coordinate dell'opzione attiva
		    const optionOffset = $(this).offset();
		    const optionHeight = $(this).outerHeight();
		    const popupHeight = 250; // altezza stimata del popup
		    const spaceBelow = $(window).height() - (optionOffset.top + optionHeight);
		    const topPosition = spaceBelow > popupHeight
		      ? optionOffset.top + optionHeight + 5   // sotto
		      : optionOffset.top - popupHeight - 5;   // sopra

		    // Posizione laterale: a destra della select
		    const leftPosition = optionOffset.left + $(this).outerWidth() + 10;

		    $(popupId).css({
		      top: topPosition,
		      left: leftPosition,
		      display: 'block'
		    });
		  }
		});

		$(document).on('mouseleave', '.list-group-item', function () {
		  $('#image-popup_mod, #image-popup').fadeOut(150);
		});
 
 function dettaglioOfferta(id, id_cliente, id_sede){
	 
	 dataObj = {};
	 dataObj.id = id;
	 
	 callAjax(dataObj, "gestioneVerOfferte.do?action=dettaglio_offerta",function(data){
		 
		 if(data.success){
			 
			 var offerta = data.offerta
			 var lista_articoli = data.lista_articoli
			 var lista_immagini = data.lista_immagini
			 $('#cliente_dtl').val(id_cliente);
			 $('#cliente_dtl').change();
			 
			 if(offerta.id_sede !=0){
				 $('#sede_dtl').val(id_sede+'_'+id_cliente);
			 }else{
				 $('#sede_dtl').val(id_sede);
			 }
			 
			 $('#sede_dtl').change();
			 $('#sede_dtl').attr("disabled", true);
			 
		  	 var table_data = [];
			  
		     if(lista_articoli!=null){
		 		  for(var i = 0; i<lista_articoli.length;i++){
		 			  var dati = {};
		 			 
		 			  dati.id_articolo = lista_articoli[i].articoloObj.ID_ANAART;
		 			  dati.descrizione = lista_articoli[i].articoloObj.DESCR;
		 			  dati.importo = lista_articoli[i].articoloObj.importo;		
		 			 dati.quantita = lista_articoli[i].quantita;	
		 			  table_data.push(dati);
		 			
		 		  }
		     }
		 		  var tabDettaglio = $('#tabDettaglio').DataTable();
		 		  
		 		 tabDettaglio.clear().draw();
		 		   
		 		tabDettaglio.rows.add(table_data).draw();
		 			
		 		tabDettaglio.columns.adjust().draw();
		 		
		 		 const container = document.getElementById("content_immagini");
		 	    const popup = document.getElementById("preview_popup");
		 	    const popupImg = document.getElementById("preview_img");

		 	   lista_immagini.forEach(img => {
		 	        const thumb = document.createElement("img");
		 	        thumb.src = img.url;
		 	        thumb.alt = img.nome_file;
		 	        thumb.style.width = "100px";
		 	        thumb.style.height = "100px";
		 	        thumb.style.objectFit = "cover";
		 	        thumb.style.margin = "8px";
		 	        thumb.style.cursor = "pointer";
		 	        thumb.style.borderRadius = "6px";
		 	        thumb.style.transition = "transform 0.2s";
		 	        thumb.onmouseenter = (e) => {
		 	            popupImg.src = img.url;
		 	            popup.style.display = "block";
		 	        };
		 	        thumb.onmousemove = (e) => {
		 	            popup.style.left = e.pageX + 15 + "px";
		 	            popup.style.top = e.pageY + 15 + "px";
		 	        };
		 	        thumb.onmouseleave = () => {
		 	            popup.style.display = "none";
		 	        };
		 	        container.appendChild(thumb);
		 	    });
		 		
		 		$('#myModalDettaglioOfferta').modal()
		 }
		 
	 })
	 
 }

 
  </script>
  
</jsp:attribute> 
</t:layout>

