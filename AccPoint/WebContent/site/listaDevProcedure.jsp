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
        Lista Procedure
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
	 Lista Procedure
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">


<a class="btn btn-primary pull-right" onClick="$('#modalNuovaProcedura').modal()"><i class="fa fa-plus"></i>Nuova procedura</a><br><br>

	 <table id="tabProcedura" class="table table-bordered table-hover dataTable table-striped" role="dialog" width="100%">
 <thead><tr class="active">

                   <th>ID</th>
 												
 						  <th>Descrizione</th>
 						  <th>Tipo procedura</th> 
 						  <th>Frequenza</th> 	
 						  <th>Scadenza contratto</th>		   
 						     <th>Azioni</th>
 </tr></thead>
 
 <tbody>
  <c:forEach items="${lista_procedure }" var="procedura">

 <tr >

 <td >${procedura.id }</td>
  <td >${procedura.descrizione }</td>

  <td>
  ${procedura.tipo_procedura.descrizione }

  </td>
  <td>${procedura.frequenza }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${procedura.scadenza_contratto }"></fmt:formatDate></td>
 <td>
  <a class="btn btn-warning customTooltip" onClicK="modificaProcedura('${procedura.id}','${procedura.tipo_procedura.id }','${utl:escapeJS(procedura.descrizione) }','${utl:escapeJS(procedura.frequenza)}','${procedura.scadenza_contratto }')" title="Click per modificare la procedura"><i class="fa fa-edit"></i></a> 
<a class="btn btn-danger customTooltip" onClicK="modalYesOrNo('${procedura.id}')" title="Click per eliminare"><i class="fa fa-trash"></i></a>
 </td> 
 
 </tr>
 </c:forEach> 
 
 </tbody>
              			   		
              
</table> <br>

</div></div>
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
      Sei sicuro di voler eliminare il la procedura?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_procedura" >
      <a class="btn btn-primary" onclick="eliminaProceduraDevice($('#id_elimina_procedura').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>
<form id="formNuovaProcedura" name="formNuovaProcedura" >
<div id="modalNuovaProcedura" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalNuovaProcedura').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Procedura</h4>
      </div>
       <div class="modal-body">     
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo procedura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_procedura" name="tipo_procedura" data-placeholder="Seleziona tipo procedura..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_procedure }" var="tipo">
  
        <option value="${tipo.id }" >${tipo.descrizione }</option>

        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione_procedura" name="descrizione_procedura" required>
       			
       	</div>       	
       </div><br>  
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control" id="frequenza_procedura" name="frequenza_procedura" required>
       			
       	</div>       	
       </div><br> 
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Scadenza contratto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="scadenza_contratto" name="scadenza_contratto" >
       			
       	</div>       	
       </div><br> 
      
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_device" name="id_device" value="${id_device }">
      
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
      </div>
    </div>
  </div>

</div>
</form>


<form id="formModificaProcedura" name="formModificaProcedura" >
<div id="modalModificaProcedura" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" >
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onclick="$('#modalModificaProcedura').modal('hide')"  aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Procedura</h4>
      </div>
       <div class="modal-body">     
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo procedura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <select id="tipo_procedura_mod" name="tipo_procedura_mod" data-placeholder="Seleziona tipo procedura..." class="form-control select2" style="width:100%" required>
        <option value=""></option>
        <c:forEach items="${lista_tipi_procedure }" var="tipo">
  
        <option value="${tipo.id }" >${tipo.descrizione }</option>

        
        </c:forEach>
        
        </select>
       			
       	</div>       	
       </div><br>  
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text"  class="form-control" id="descrizione_procedura_mod" name="descrizione_procedura_mod" required>
       			
       	</div>       	
       </div><br>  
       
       
        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control" id="frequenza_procedura_mod" name="frequenza_procedura_mod" required>
       			
       	</div>       	
       </div><br> 
       
       
               <div class="row">
       
       	<div class="col-sm-3">
       		<label>Scadenza contratto</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input type="text" class="form-control datepicker" id="scadenza_contratto_mod" name="scadenza_contratto_mod" >
       			
       	</div>       	
       </div><br> 
      	
      	</div>
      <div class="modal-footer">
	<input type="hidden"  class="form-control" id="id_procedura" name="id_procedura">
	<input type="hidden"  class="form-control" id="id_device_mod" name="id_device_mod" value="${id_device }">
      
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Salva</button> 
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
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">



console.log("test2")

$('#data').change(function(){
	
	var frequenza = $('#frequenza').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima').val(formatDate(c));
			 //   $('#datepicker_data_prossima').datepicker("setDate", c );
			
		}
		
	}
	
});

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}

$('#data_mod').change(function(){
	
	var frequenza = $('#frequenza_mod').val();
	
	if(frequenza!=null && frequenza!=''){
		var date = $('#data_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima_mod').val(formatDate(c));
			 //   $('#datepicker_data_prossima').datepicker("setDate", c );
			
		}
		
	}
	
});


$('#frequenza').change(function(){
	
	var date = $('#data').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima').val(formatDate(c));
			    
			
		}
	}
	
});
 
 
$('#frequenza_mod').change(function(){
	
	var date = $('#data_mod').val();
	var frequenza = $(this).val();
	if(date!=null && date!='' && frequenza!=''){
		
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza), day);
			    $('#data_prossima_mod').val(formatDate(c));
			    
			
		}
	}
	
});
 
 function modificaProcedura(id_procedura, tipo_procedura, descrizione, frequenza, scadenza_contratto){
		
		$('#id_procedura').val(id_procedura);
		$('#tipo_procedura_mod').val(tipo_procedura);
		$('#tipo_procedura_mod').change()
		$('#descrizione_procedura_mod').val(descrizione);
		
		$('#frequenza_procedura_mod').val(frequenza);
		if(scadenza_contratto!=null){
			$('#scadenza_contratto_mod').val(Date.parse(scadenza_contratto).toString("dd/MM/yyyy"));	
		}
		
		
		$('#modalModificaProcedura').modal();
	}
 

$(document).ready(function(){

	 $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

	var tableNote = $('#tabProcedura').DataTable({
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
	     order:[[0, "desc"]]
	     

	     
	   });




	$('#tabProcedura thead th').each( function () {
		var title = $('#tabProcedura thead th').eq( $(this).index() ).text();
		
		$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
	} );
		
	$('.inputsearchtable').on('click', function(e){
			e.stopPropagation();    
	});

	// DataTable
		tableNote = $('#tabProcedura').DataTable();

	// Apply the search
	tableNote.columns().eq( 0 ).each( function ( colIdx ) {
		$( 'input', tableNote.column( colIdx ).header() ).on( 'keyup', function () {
			tableNote.column( colIdx ).search( this.value ).draw();		
		} );
	} ); 

	tableNote.columns.adjust().draw();
	
	
	
	
	
});

 
 $('#formNuovaProcedura').on('submit', function(e){
	
	 e.preventDefault();
	 callAjaxForm('#formNuovaProcedura', 'gestioneDevice.do?action=nuova_procedura')
		 
		 
		 
	 
 });
 
 $('#formModificaProcedura').on('submit', function(e){
		
	 e.preventDefault();
	 callAjaxForm('#formModificaProcedura', 'gestioneDevice.do?action=modifica_procedura')
	 
 });
 
 function modalYesOrNo(id_procedura){
	 $('#id_elimina_procedura').val(id_procedura);
	 $('#myModalYesOrNo').modal()
 }

 function eliminaProceduraDevice(){
	 
	 dataObj = {}
	 dataObj.id = $('#id_elimina_procedura').val();
	 
	 callAjax(dataObj, "gestioneDevice.do?action=elimina_procedura")
 }
 


 
  </script>
  
</jsp:attribute> 
</t:layout>


