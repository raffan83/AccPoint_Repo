<%@page import="java.util.ArrayList"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="it.portaleSTI.DTO.AMOperatoreDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
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
        ${scadenze.get(0).getAttrezzatura().getDescrizione().toUpperCase() } - Attività in scadenza a ${mese } ${anno }
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
	 Lista attività in scadenza
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">


<div class="row">
<div class="col-sm-12">

 <table id="tabScadenzeAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Data attività</th>
<th>Esito</th>
<th>Frequenza (mesi)</th>
<th>Data scadenza attività</th>
<th>Note</th>
<th>Attività</th>
<th>Utente</th>
<th>Allegati</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${scadenze }" var="scadenza" varStatus="loop">
	<tr id="row_${loop.index}" >
	
	<td>${scadenza.id }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scadenza.dataAttivita }" /></td>
	<td>
	<c:if test="${scadenza.esito == 'P' }">
	POSITIVO
	</c:if>
	<c:if test="${scadenza.esito == 'N' }">
		NEGATIVO
		</c:if>
	</td>		
	<td>${scadenza.frequenza }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scadenza.dataProssimaAttivita }" /></td>
	<td>${scadenza.note }</td>
	<td style="min-width:200px">${scadenza.attivita.descrizione }</td>
	<td>${scadenza.utente.nominativo }</td>
	<td><a class="btn btn-primary customTooltip" title="click per aprire gli allegati" onclick="modalAllegati('${scadenza.id}')"><i class="fa fa-archive"></i></a></td>
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










 <div id="image-popup"><img id="popup-img" src="" /></div> 
 <div id="image-popup_mod"><img id="popup-img_mod" src="" /></div> 

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
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> 
	<style>
	
	


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

#image-popup_mod{
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
#image-popup_mod img{
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
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">
/* 

$('#fileupload').fileupload({
	 url: "amScGestioneScadenzario.do?action=upload_allegato&id_documento="+$('#id_documento_allegato').val(),
	 dataType: 'json',	 
	 getNumberOfFiles: function () {
	     return this.filesContainer.children()
	         .not('.processing').length;
	 }, 
	 start: function(e){
	 	pleaseWaitDiv = $('#pleaseWaitDialog');
	 	pleaseWaitDiv.modal();
	 	
	 },
	 singleFileUploads: false,
	  add: function(e, data) {
	     var uploadErrors = [];
	     var acceptFileTypes = /(\.|\/)(gif|jpg|jpeg|tiff|png|pdf|doc|docx|xls|xlsx)$/i;
	   
	     for(var i =0; i< data.originalFiles.length; i++){
	    	 if(data.originalFiles[i]['name'].length && !acceptFileTypes.test(data.originalFiles[0]['name'])) {
		         uploadErrors.push('Tipo del File '+data.originalFiles[i]['name']+' non accettato. ');
		         break;
		     }	 
	    	 if(data.originalFiles[i]['size'] > 30000000) {
		         uploadErrors.push('File '+data.originalFiles[i]['name']+' troppo grande, dimensione massima 30mb');
		         break;
		     }
	     }	     		     
	     if(uploadErrors.length > 0) {
	     	$('#myModalErrorContent').html(uploadErrors.join("\n"));
	 			$('#myModalError').removeClass();
	 			$('#myModalError').addClass("modal modal-danger");
	 			$('#myModalError').modal('show');
	     } 
	     else {
	         data.submit();
	     }  
	 },
	
	 done: function (e, data) {
	 		
	 	pleaseWaitDiv.modal('hide');
	 	
	 	if(data.result.success){
	 		//$('#myModalAllegatiArchivio').modal('hide');
	 		$('#myModalAllegati').hide();
	 		$('#myModalErrorContent').html(data.result.messaggio);
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-success");
			$('#myModalError').modal('show');
			
			
			$('#myModalError').on("hidden.bs.modal",function(){
				
		 	if($('#cliente').val()==null && $("#sede").val()==null){
				
				location.reload();
			}else{ 
				dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val();
				   exploreModal('gestioneVerStrumenti.do',dataString,'#posTab', function(){
						$(document.body).css('padding-right', '0px');
						$('.modal-backdrop').hide();
				   });
				   
			}
				  
				   
			});
	 	}else{		 			
	 			$('#myModalErrorContent').html(data.result.messaggio);
	 			$('#myModalError').removeClass();
	 			$('#myModalError').addClass("modal modal-danger");
	 			$('#report_button').show();
	 			$('#visualizza_report').show();
	 			$('#myModalError').modal('show');
	 		}
	 },
	 fail: function (e, data) {
	 	pleaseWaitDiv.modal('hide');

	     $('#myModalErrorContent').html(errorMsg);
	     
	 		$('#myModalError').removeClass();
	 		$('#myModalError').addClass("modal modal-danger");
	 		$('#report_button').show();
	 		$('#visualizza_report').show();
	 		$('#myModalError').modal('show');

	 		$('#progress .progress-bar').css(
	                'width',
	                '0%'
	            );
	 },
	 progressall: function (e, data) {
	     var progress = parseInt(data.loaded / data.total * 100, 10);
	     $('#progress .progress-bar').css(
	         'width',
	         progress + '%'
	     );

	 }
});		

$('#myModalArchivio').modal();

} */


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

	


function formatDate(data){
	
	   var mydate =  Date.parse(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		var   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}




	 
$("#tabScadenzeAttivita").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabScadenzeAttivita thead th').each( function () {
     //	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabScadenzeAttivita thead th').eq( $(this).index() ).text();
    	
    	  
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"   type="text" /></div>');	
	    	

    	} );
    
    

} );


	

$(document).ready(function() {
	


    $('.dropdown-toggle').dropdown();
     
     table = $('#tabScadenzeAttivita').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 5 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabScadenzeAttivita_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabScadenzeAttivita').on( 'page.dt', function () {
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
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

