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
        Lista Fornitori
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
	 Lista Fornitori
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoFornitore()"><i class="fa fa-plus"></i> Nuovo Fornitore</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabDocumFornitori" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
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
 
 <tbody>
 
 	<c:forEach items="${lista_fornitori}" var="fornitore" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>
	<a href="#" class="btn customTooltip customlink" onClick="callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore=${utl:encryptData(fornitore.id)}')">${fornitore.id }</a>
	</td>	
	<%-- <td>${fornitore.committente.nome_cliente }</td> --%>
	<td>${fornitore.ragione_sociale }</td>
	<td>${fornitore.indirizzo }</td>
	<td>${fornitore.p_iva }</td>	
	<td>${fornitore.cf }</td>
	<td>${fornitore.email }</td>
	<td>${fornitore.stato.nome }</td>			
	<td>	
	
	<a class="btn btn-info" onClick="callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore=${utl:encryptData(fornitore.id)}')"><i class="fa fa-search"></i></a>
	 
	 <a class="btn btn-warning" onClicK="modificaFornitoreModal('${fornitore.id}','${utl:escapeJS(fornitore.ragione_sociale)}','${utl:escapeJS(fornitore.indirizzo)}','${utl:escapeJS(fornitore.cap)}',
	  '${utl:escapeJS(fornitore.comune)}', '${utl:escapeJS(fornitore.provincia)}','${fornitore.p_iva }','${fornitore.cf }','${fornitore.email }')" title="Click per modificare il Fornitore"><i class="fa fa-edit"></i></a> 
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



<form id="nuovoFornitoreForm" name="nuovoFornitoreForm">
<div id="myModalnuovoFornitore" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Fornitore</h4>
      </div>
       <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committenti</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente[]" id="committente" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" data-live-search="true" style="width:100%" required multiple>
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ragione Sociale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ragione_sociale" name="ragione_sociale" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Partita Iva</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="p_iva" name="p_iva" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Fiscale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cf" name="cf" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Indirizzo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="indirizzo" name="indirizzo" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cap</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cap" name="cap" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
  <div class="row">
       
       
       	<div class="col-sm-3">
       		<label>Comune</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="comune" name="comune" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Provincia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="provincia" name="provincia" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email" name="email" class="form-control" type="text" style="width:100%" required>
       			
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




<form id="modificaFornitoreForm" name="nuovoFornitoreForm">
<div id="myModalModificaFornitore" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Fornitore</h4>
      </div>
           <div class="modal-body">

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committenti</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_mod[]" id="committente_mod" class="form-control select2" data-placeholder="Seleziona committente..." aria-hidden="true" data-live-search="true" style="width:100%" required multiple>
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Ragione Sociale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="ragione_sociale_mod" name="ragione_sociale_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Partita Iva</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="p_iva_mod" name="p_iva_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice Fiscale</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cf_mod" name="cf_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                 <div class="row">
       
       	<div class="col-sm-3">
       		<label>Indirizzo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="indirizzo_mod" name="indirizzo_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cap</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cap_mod" name="cap_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
  <div class="row">
       
       
       	<div class="col-sm-3">
       		<label>Comune</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="comune_mod" name="comune_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Provincia</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="provincia_mod" name="provincia_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Email</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="email_mod" name="email_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">
		
		<input type="hidden" id="id_fornitore" name="id_fornitore">
		<input type="hidden" id="remove_comm" name="remove_comm">

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


function modalNuovoFornitore(){
	
	$('#myModalnuovoFornitore').modal();
	
}

var committenti_bc;
function modificaFornitoreModal(id_fornitore,  ragione_sociale, indirizzo, cap, comune, provincia, p_iva, cf, email){
	
	$('#id_fornitore').val(id_fornitore);
	
	
	 var dataObj = {};
		dataObj.id_fornitore = id_fornitore;
		

	  $.ajax({
 type: "POST",
 url: "gestioneDocumentale.do?action=committenti_fornitore",
 data: dataObj,
 dataType: "json",
 //if received a response from the server
 success: function( data, textStatus) {
	
	  if(data.success)
		  {  
		  if(data.committenti!=null){
			  
			  var committenti = [];
			  data.committenti.forEach(function(item){
 				   committenti.push(item.id);
 				})
		  }
			
			committenti_bc = committenti;
   				committenti.forEach(function(item){
   				    $("#committente_mod option[value='" + item + "']").prop("selected", true);
   				})
   				$("#committente_mod").change();
			
   				$('#ragione_sociale_mod').val(ragione_sociale);
   				$('#indirizzo_mod').val(indirizzo);
   				$('#cap_mod').val(cap);
   				$('#comune_mod').val(comune);
   				$('#provincia_mod').val(provincia);
   				$('#p_iva_mod').val(p_iva);
   				$('#cf_mod').val(cf);
   				$('#email_mod').val(email);
   				
   				$('#myModalModificaFornitore').modal();
			
		  }else{
			
			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
			$('#myModalError').modal('show');			
		
		  }
 },
 error: function( data, textStatus) {
	  $('#myModalYesOrNo').modal('hide');
	  $('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').show();
			$('#visualizza_report').show();
				$('#myModalError').modal('show');

 }
 });
	
	


}


$("#committente_mod").change(function(){
	
	var values = $(this).val();
	var committenti_ac = "";
	
	committenti_bc.forEach(function(item){
		var remove = true;
		for(var i = 0;i<values.length;i++){
			if(item==parseInt(values[i])){
				remove = false;	
			}
		}
		if(remove){
			committenti_ac = committenti_ac+item+",";
		}
		
	});
	$('#remove_comm').val(committenti_ac);
});


/* $('#check_formatore').on('ifClicked',function(e){
	if($('#check_formatore').is( ':checked' )){
		$('#check_formatore').iCheck('uncheck');
		$('#formatore').val(0); 
	}else{
		$('#check_formatore').iCheck('check');
		$('#formatore').val(1); 
	}
});
	 

$('#check_formatore_mod').on('ifClicked',function(e){
	if($('#check_formatore_mod').is( ':checked' )){
		$('#check_formatore_mod').iCheck('uncheck');
		$('#formatore_mod').val(0); 
	}else{
		$('#check_formatore_mod').iCheck('check');
		$('#formatore_mod').val(1); 
	}
}); */

var columsDatatables = [];

$("#tabDocumFornitori").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDocumFornitori thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDocumFornitori thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$(document).ready(function() {
 

	  $('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     

     table = $('#tabDocumFornitori').DataTable({
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
		
		table.buttons().container().appendTo( '#tabDocumFornitori_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDocumFornitori').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});


$('#modificaFornitoreForm').on('submit', function(e){
	 e.preventDefault();
	 modificaFornitore();
});
 

 
 $('#nuovoFornitoreForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoFornitore();
});
 
 

 
  </script>
  
</jsp:attribute> 
</t:layout>

