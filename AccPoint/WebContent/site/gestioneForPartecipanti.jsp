<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Partecipanti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-primary box-solid">
<div class="box-header with-border">
	 Lista Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<div class="row">
<div class="col-xs-12">


	<a class="btn btn-primary pull-right" onClick="modalNuovoPartecipante()"><i class="fa fa-plus"></i> Nuovo Partecipante</a>
	<a class="btn btn-primary pull-right" onClick="modalImportaPartecipanti()"  style="margin-right:5px"><i class="fa fa-plus"></i> Importa Partecipanti</a>  
	<a class="btn btn-success customTooltip pull-right" onClick="callAction('gestioneFormazione.do?action=download_template')" title="Scarica template importazione" style="margin-right:5px"><i class="fa fa-file-excel-o"></i></a>



</div>

</div><br>
</c:if>
<div class="row">
<div class="col-sm-12">

 <table id="tabForPartecipante" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Nome</th>
<th>Cognome</th>
<th>Data di nascita</th>
<th>Azienda</th>
<th>Sede</th>
<th>Luogo di nascita</th>
<th>Codice fiscale</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_partecipanti }" var="partecipante" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>${partecipante.id }</td>	
	<td>${partecipante.nome }</td>
	<td>${partecipante.cognome }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${partecipante.data_nascita}" /></td>
	<td>${partecipante.nome_azienda}</td>	
	<td><c:if test="${partecipante.id_sede!=0 }">${partecipante.nome_sede }</c:if></td>
	<td>${partecipante.luogo_nascita }</td>
	<td>${partecipante.cf }</td>
	<td>
	
	<a class="btn btn-info" title="Click per aprire il dettaglio" onClick="dettaglioPartecipante('${utl:encryptData(partecipante.id)}')"><i class="fa fa-search"></i></a>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<a class="btn btn-warning" onClicK="modificaPartecipanteModal('${partecipante.id}','${partecipante.nome }','${partecipante.cognome.replace('\'','&prime;')}','${partecipante.data_nascita }','${partecipante.id_azienda }','${partecipante.id_sede }','${partecipante.luogo_nascita.replace('\'','&prime;') }','${partecipante.cf }')" title="Click per modificare il partecipante"><i class="fa fa-edit"></i></a>
	</c:if> 
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



 <form id="ImportaForm" name="ImportaForm"> 
   <div id="myModalImporta" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Importa da Excel</h4>
      </div>
       <div class="modal-body">   

       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">

        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda_import" name="azienda_import" style="width:100%" required>

        </div>      
       </div>
       <br>
       <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_import" name="sede_import" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div>    <br>
      	<div class="row">
     
      	<div class="col-xs-12">
      		<span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica File...</span><input accept=".xls, .XLS, .xlsx, .XLSX"  id="file_excel" name="file_excel" type="file" required></span><label id="label_excel"></label>
      	
      	</div>
      	</div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary" type="submit" >Salva</button>
      </div>
    </div>
  </div>

</div>
   </form>




 <form id="nuovoPartecipanteForm" name="nuovoPartecipanteForm">  
<div id="modalNuovoPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Partecipante</h4>
      </div>
       <div class="modal-body">     
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <!-- <input type="text" id="azienda" name="azienda" class="form-control" style="width:100%" required> -->
        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda" name="azienda" style="width:100%" required>
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
        
       <select id="sede" name="sede" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" disabled required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>  
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome" name="nome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome" name="cognome" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita" name="data_nascita" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Luogo di nascita</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="luogo_nascita" name="luogo_nascita" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Codice fiscale</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cf" name="cf" class="form-control" style="width:100%" required>
        </div>      
       </div><br>

      <div class="row">
       <div class="col-xs-12">
       <label style="color:red;display:none" id="label_error">Attenzione! Il Codice Fiscale inserito è già presente nel sistema!</label>
       </div>
    
       </div>
      	</div>
      <div class="modal-footer">
      
      <button class="btn btn-primary" type="submit" id="save_btn">Salva</button>
		
      </div>
    </div>
  </div>

</div>
</form>



 <form id="modificaPartecipanteForm" name="modificaPartecipanteForm">  
<div id="modalModificaPartecipante" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Partecipante</h4>
      </div>
       <div class="modal-body">   
       <div class="row">
       <div class="col-xs-3">
       <label>Azienda</label>
       </div>
        <div class="col-xs-9">
        <input class="form-control" data-placeholder="Seleziona Azienda..." id="azienda_mod" name="azienda_mod" style="width:100%" required>
      

        </div>      
       </div><br>
              <div class="row">
       <div class="col-xs-3">
       <label>Sede</label>
       </div>
        <div class="col-xs-9">
        
       <select id="sede_mod" name="sede_mod" class="form-control select2"  data-placeholder="Seleziona Sede..." aria-hidden="true" data-live-search="true" style="width:100%" required>
       <option value=""></option>
      	<c:forEach items="${lista_sedi}" var="sd">
      	<option value="${sd.__id}_${sd.id__cliente_}">${sd.descrizione} - ${sd.indirizzo} - ${sd.comune} (${sd.siglaProvincia}) </option>
      	</c:forEach>
      
      </select>
        </div>      
       </div><br>    
       <div class="row">
       <div class="col-xs-3">
       <label>Nome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="nome_mod" name="nome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Cognome</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cognome_mod" name="cognome_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Data di nascita</label>
       </div>
        <div class="col-xs-9">
         <div class='input-group date datepicker' id='datepicker_data_scadenza'>
               <input type='text' class="form-control input-small" id="data_nascita_mod" name="data_nascita_mod" required>
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
        </div>      
       </div><br>
       
         <div class="row">
       <div class="col-xs-3">
       <label>Luogo di nascita</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="luogo_nascita_mod" name="luogo_nascita_mod" class="form-control" style="width:100%" required>
        </div>      
       </div><br>
        <div class="row">
       <div class="col-xs-3">
       <label>Codice fiscale</label>
       </div>
        <div class="col-xs-9">
        <input type="text" id="cf_mod" name="cf_mod" class="form-control" style="width:100%" required>
        </div>      
       </div>
       

      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_partecipante" name="id_partecipante">
      <button class="btn btn-primary" type="submit">Salva</button>
      <!-- <a class="btn btn-primary" onclick="modificaForPartecipante()" >Salva</a> -->
		
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

<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalNuovoPartecipante(){
	
	$('#modalNuovoPartecipante').modal();
	
}

function modalImportaPartecipanti(){
	$('#myModalImporta').modal();
}

function dettaglioPartecipante(id_partecipante){
	
	callAction('gestioneFormazione.do?action=dettaglio_partecipante&id_partecipante='+id_partecipante,null,true);
}

$('#file_excel').change(function(){
	$('#label_excel').html($(this).val().split("\\")[2]);
});

function modificaPartecipanteModal(id_partecipante, nome, cognome, data_nascita, azienda, sede, luogo_nascita, cf){
	
	$('#id_partecipante').val(id_partecipante);
	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	if(data_nascita!=null && data_nascita!=''){
		$('#data_nascita_mod').val(Date.parse(data_nascita).toString("dd/MM/yyyy"));
	}
	
	if(azienda!=null && azienda!=''){
		$('#azienda_mod').val(azienda);
		$('#azienda_mod').change();	
		
	}
	if(sede!=null && sede!='' && sede!='0'){
		$('#sede_mod').val(sede+"_"+azienda);
		$('#sede_mod').change();
	}else{
		$('#sede_mod').val(0);
		$('#sede_mod').change();
	}
	$('#luogo_nascita_mod').val(luogo_nascita);
	$('#cf_mod').val(cf);
	
	$('#modalModificaPartecipante').modal();
}

	 
$('#cf').focusout(function(){
	
	var json_cf = '${json_cf}';
	
	$('#cf').css('border', '1px solid #d2d6de');
	$('#label_error').hide();
	$('#save_btn').attr("disabled",false);
	
	if(json_cf !=''){
		var cf = JSON.parse(json_cf);
		
		if(cf.includes($(this).val())){
			$('#cf').css('border', '1px solid #f00');
			$('#label_error').show();
			$('#save_btn').attr("disabled",true);
		}
	}
	
	
});


var columsDatatables = [];

$("#tabForPartecipante").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabForPartecipante thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabForPartecipante thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );




$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
  //   $('.select2').select2();
  initSelect2('#azienda');
  initSelect2('#azienda_mod');
  initSelect2('#azienda_import');
  $('#sede').select2();
  $('#sede_mod').select2();
  $('#sede_import').select2();

     table = $('#tabForPartecipante').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 8 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabForPartecipante_wrapper .col-sm-6:eq(1)');
		
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
		

	$('#tabForPartecipante').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		});


	});
	
	
	
	

	
	
});



$('#modificaPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaForPartecipante();
});
 

 
 $('#nuovoPartecipanteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoForPartecipante();
});
 
 
 $('#ImportaForm').on('submit', function(e){
	 e.preventDefault();
	 importaPartecipantiDaExcel();
});
 
 $("#azienda").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
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
 
 $("#azienda_mod").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
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
 
 $("#azienda_import").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede_import option').clone());
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
	 $("#sede_import").prop("disabled", false);
	 
	  $('#sede_import').html(opt);
	  
	  $("#sede_import").trigger("chosen:updated");
	  

		$("#sede_import").change();  
		

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

