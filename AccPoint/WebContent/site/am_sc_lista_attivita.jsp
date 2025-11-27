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
        Lista attività
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
	Lista attività
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-2">
 <label class="control-label">Tipo Filtro:</label>
 <select class="form-control select2" style="width:100%" id="tipo_filtro" name="tipo_filtro">
 <c:if test="${tipo_filtro == null  || tipo_filtro == 'data'}">
<option value="data" selected>Data Attività</option>
</c:if>
<c:if test="${tipo_filtro != null  && tipo_filtro != 'data'}">
<option value="data" >Data Attività</option>
</c:if>
<c:if test="${tipo_filtro!=null && tipo_filtro == 'attrezzatura'  }">
<option value="attrezzatura" selected>Impianto</option>
</c:if>
<c:if test="${tipo_filtro!=null && tipo_filtro != 'attrezzatura'  }">
<option value="attrezzatura" >Impianto</option>
</c:if>

 </select>
 
</div>
<div class="col-xs-5" id="content_data"
     style="${tipo_filtro == 'attrezzatura' ? 'display:none' : ''}">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Filtra Data:</label>
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
	<div class="col-xs-5" id="content_attrezzature"  style="${tipo_filtro == 'data' ? 'display:none' : ''}">
	<label for="datarange" class="control-label">Filtra Impianto:</label>
		<select class="form-control select2" data-placeholder="Seleziona Impianto..." id="attrezzatura" name="attrezzatura" style="width:100%" >
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzatura}" var="attrezzatura" varStatus="loop">
       
       				<option value="${attrezzatura.id}" ${attrezzatura.id == id_attrezzatura ? 'selected' : ''}>${attrezzatura.descrizione }</option>
       			</c:forEach>
       		</select>      
	<br><br>
	</div>
	


</div><br>



<div class="row">
<div class="col-sm-12">

 <table id="tabAttivitaEffettuate" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th >ID</th>
<th>Impianto</th>
<th>Tipo</th>
<th>Data attività</th>
<th>Frequenza (mesi)</th>
<th>Data prossima Attività</th>
<th>Esito</th>
<th>Descrizione attività</th>
<th>Note</th>
<th>Utente </th>
<th>Allegati</th>
 </tr></thead>
 
 

 
 <tbody>
 
 	<c:forEach items="${lista_attivita }" var="attivita" varStatus="loop">
 	

	<tr id="row_${loop.index}" >

<td>${attivita.id }</td>
<td>${attivita.attrezzatura.descrizione }</td>
<td><c:if test="${attivita.tipo == 0 }">ORDINARIA</c:if><c:if test="${attivita.tipo == 1 }">STRAORDINARIA</c:if></td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${attivita.dataAttivita}" /></td>	
		<td>${attivita.frequenza }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${attivita.dataProssimaAttivita}" /></td>

<td><c:if test="${attivita.esito == 'P' }">POSITIVO</c:if><c:if test="${attivita.esito == 'N' }">NEGATIVO</c:if></td>

	<td>${attivita.attivita.descrizione }</td>
	<td>${attivita.note }</td>
	<td>${attivita.utente.nominativo }</td>
	<td><a class="btn btn-primary customTooltip" title="click per aprire gli allegati" onclick="modalAllegati('${attivita.id}')"><i class="fa fa-archive"></i></a></td>
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


  <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

<!--  <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Allega uno o più file...</span>
				<input accept=".pdf,.PDF,.jpg,.gif,.jpeg,.png,.doc,.docx,.xls,.xlsx"  id="fileupload" type="file" name="files[]" multiple>
		       
		   	 </span>

		   	 <br><br> -->

       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_documento_allegato" name="id_documento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
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
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_allegato_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoAttivita($('#id_allegato_elimina').val())" >SI</a>
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


  
  
  
  
  </style>


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">




function modalAllegati(id){
	
	var dataObj = {};
	dataObj.id = id;
	
	callAjax(dataObj, "amScGestioneScadenzario.do?action=lista_allegati", function(data){
		
		if(data.success){
			
			var lista_allegati = data.lista_allegati;
			
				
				var html = '<ul class="list-group list-group-bordered">';
	    		if(lista_allegati.length>0){
	    			for(var i= 0; i<lista_allegati.length;i++){
	    			    
		       			 var nome =  '<li class="list-group-item"><div class="row"><div class="col-xs-10"><b>'+lista_allegati[i].nome_file+'</b></div><div class="col-xs-2 pull-right">'; 	           
			             var elimina  = '<a class="btn btn-danger btn-xs pull-right" onClick="eliminaAllegatoModal(\''+lista_allegati[i].id+'\')"><i class="fa fa-trash"></i></a>';
			                
			    	           var download = '<a class="btn btn-danger btn-xs  pull-right"style="margin-right:5px" href="amScGestioneScadenzario.do?action=download_allegato&id_allegato='+lista_allegati[i].id+'"><i class="fa fa-arrow-down small"></i></a>';
			    	           
			    	            if("${userObj.checkRuolo('S2')}" == "true"){
			    	            	elimina = ""
			    	            }
			    	           html=  html +nome + elimina +download+   '</div></div></li>';
	    			}
	    		}else{
	    			 html= html + '<li class="list-group-item"> Nessun file allegato all\'attività! </li>';
	    		}
	    		
	    		$("#tab_allegati").html(html+"</ul>");
	
			
			$('#myModalArchivio').modal();
			
		}
		
		
	});
	
	
}


function eliminaAllegatoModal(id_allegato){
	
	$('#id_allegato_elimina').val(id_allegato);
	
	$('#myModalYesOrNo').modal();
}






function filtraDate(){
	
	var tipo_data = $('#tipo_data').val();
		
		var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	 	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	 	dataString = "?action=lista_attivita&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + 
	 			endDatePicker.format('YYYY-MM-DD')+"&tipo_filtro=data";
	 	
	 	 pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();

	 	callAction("amScGestioneScadenzario.do"+ dataString, false,true);

}




function resetDate(){
	pleaseWaitDiv = $('#pleaseWaitDialog');
		  pleaseWaitDiv.modal();
	callAction("amScGestioneScadenzario.do?action=lista_attivita&tipo_filtro=data");

}

$('#attrezzatura').change(function(){
	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	callAction("amScGestioneScadenzario.do?action=lista_attivita&tipo_filtro=attrezzatura&id_attrezzatura="+$(this).val());
});
 




var columsDatatables = [];

$("#tabAttivitaEffettuate").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAttivitaEffettuate thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAttivitaEffettuate thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );






	
function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


var array_color = [];

$(document).ready(function() {
 
	
	var array_buttons = [];
	
	

     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });    
     
     $('.select2').select2();
     
     
     
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

     table = $('#tabAttivitaEffettuate').DataTable({
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
		    	  
		    	
		    	  { responsivePriority: 2, targets: 7},
		    	  { responsivePriority: 3, targets: 10 }
		    	  
		    	  
		    	  
		               ], 	        
	  	    
		               
		    });
     
     
     
		//if(${!userObj.checkRuolo('F2')}){
			table.buttons().container().appendTo( '#tabAttivitaEffettuate_wrapper .col-sm-6:eq(1)');	
		//}
		
		
		
		
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
		

	$('#tabAttivitaEffettuate').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	
});



 $('#myModalAllegati').on('hidden.bs.modal',function(){
 	
 	$(document.body).css('padding-right', '0px');
 });

  
  
  
  function eliminaAllegatoAttivita(id_allegato){
 	 
 	 var dataObj = {}
 	 dataObj.id_allegato = id_allegato;
 	 
 	 callAjax(dataObj, "amScGestioneScadenzario.do?action=elimina_allegato")
 	 
  }
  
 
$('#tipo_filtro').change(function(){

	var val = $(this).val();
	
	if(val=='data'){
		$('#content_data').show();
		$('#content_attrezzature').hide()
	}else{
		$('#content_attrezzature').show();
		$('#content_data').hide()
	}
	
})

 
  </script>
  
</jsp:attribute> 
</t:layout>

