<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
	%>
	
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
     <h1 class="pull-left">
        Lista Misure
      <!--   <small>Fai doppio click per entrare nel dettaglio</small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">


          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<c:if test="${fn:length(listaMisure) gt 0}">
<div class="row padding-bottom-30" >
	     <div class="col-xs-12" id="apporvaSelectedButtonGroup">
	     <%-- <c:if test="${actionParent == 'li'}"> <button id="generaSelected" class="btn btn-success" onClick="callAction('strumentiMisurati.do?action=lc&actionParent=${actionParent}&id=${listaMisure[0].interventoDati.id}')">Visualizza Certificati</button></c:if>
	      <c:if test="${actionParent == 'lt'}"> <button id="generaSelected" class="btn btn-success" onClick="callAction('strumentiMisurati.do?action=lc&actionParent=${actionParent}&id=${listaMisure[0].intervento.id}')">Visualizza Certificati</button></c:if>
          --%>  
<c:if test="${actionParent == 'li'}"> <button id="generaSelected" class="btn btn-success" onClick="callAction('strumentiMisurati.do?action=lc&actionParent=${actionParent}&id=${utl:encryptData(listaMisure[0].interventoDati.id)}')">Visualizza Certificati</button></c:if>
	      <c:if test="${actionParent == 'lt'}"> <button id="generaSelected" class="btn btn-success" onClick="callAction('strumentiMisurati.do?action=lc&actionParent=${actionParent}&id=${utl:encryptData(listaMisure[0].intervento.id)}')">Visualizza Certificati</button></c:if>
         
          </div>
	  </div>
</c:if>
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th></th>
 <th>ID</th>
 <th>Data Misura</th>
  <th>Strumento</th>
     <th>Matricola | Codice Interno</th>

	<th>Tipo Firma</th>
   <th>Stato Ricezione</th>
    <th>Obsoleta</th>
    <th>Note obsolescenza</th>
    <%-- <c:if test="${misura.lat=='S' }"><th>Registro Laboratorio</th></c:if> --%>
    <th>Registro Laboratorio</th>
    <th>Certificato/File Excel</th>
    <th>Allegati</th>
    <th>Note Allegati</th>
    <th>Operatore</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaMisure}" var="misura" varStatus="loop">

	 <tr role="row" id="${misura.id}-${loop.index}">
<td></td>
	<td><a href="#" class="customTooltip" title="Click per aprire il dettaglio della Misura"  onClick="callAction('dettaglioMisura.do?idMisura=${utl:encryptData(misura.id)}')" onClick="">${misura.id}</a></td>

<td>
<c:if test="${not empty misura.dataMisura}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${misura.dataMisura}" />
</c:if></td>
<td>${misura.strumento.denominazione}</td>
<td>${misura.strumento.matricola} | ${misura.strumento.codice_interno}</td>
<td>${misura.tipoFirma}</td>
<td>${misura.statoRicezione.nome}</td>
<td align="center">			
	<span class="label bigLabelTable <c:if test="${misura.obsoleto == 'S'}">label-danger</c:if><c:if test="${misura.obsoleto == 'N'}">label-success </c:if>">${misura.obsoleto}</span> </td>
<%-- </td> --%>
<td>${misura.note_obsolescenza }</td>

    <td>
    <c:if test="${misura.lat=='S' }">${misura.intervento.id}_${misura.misuraLAT.id }_${misura.strumento.__id}</c:if> 
    </td>
   
<td>
<c:forEach var="entry" items="${arrCartificati}">
<c:if test="${entry.key eq misura.id}">

  	<c:set var="certificato" value="${entry.value}"/>
  	<c:if test="${certificato.stato.id == 2}">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
	<c:set var = "flag" value="1"/>
	</c:if>
	<c:if test="${certificato.stato.id == 4}">
	<a  target="_blank" class="btn btn-danger customTooltip" title="Click per aggiungere il Certificato" onClick="modalCertificato('${certificato.id}','${misura.intervento.nomePack}')"><i class="fa fa-arrow-up"></i></a>
	</c:if>
</c:if>
</c:forEach>

<c:if test="${misura.interventoDati.nomePack==''}">
	<a  target="_blank" class="btn btn-success customTooltip" title="Click per aggiungere il file Excel" onClick="modalExcel('${misura.id}')"><i class="fa fa-arrow-up"></i></a>
</c:if>
</td>
<td>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" href="scaricaCertificato.do?action=download_allegato&id_misura=${utl:encryptData(misura.id)}" ><i class="fa fa-file-pdf-o"></i></a>
</c:if>
<a class="btn btn-primary customTooltip" title="Click per allegare un Pdf" onClick="modalAllegati('${misura.intervento.nomePack}','${misura.id }','${misura.note_allegato}')" ><i class="fa fa-arrow-up"></i></a>
<c:if test="${misura.file_allegato!=null &&  misura.file_allegato!=''}">
<a class="btn btn-danger customTooltip" title="Click per eliminare l'allegato" onClick="eliminaAllegato('${misura.id}','${misura.strumento.__id }','fromTable')" ><i class="fa fa-trash"></i></a>
</c:if>
</td>
<td>${misura.note_allegato }</td>
<td>${misura.user.nominativo }</td>

	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 
 
 
 
 <form id="formCertificato" name="formCertificato">
  <div id="myModalCertificato" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Certificato</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_certificato" type="file" accept=".pdf,.PDF" name="fileupload_certificato" class="form-control"/>
		   	 </span>
		   	 <label id="certificato_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="id_cert" name="id_cert">
        <input type="hidden" id="pack_cert" name="pack_cert">

  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateCertificato()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>
 

<form id="formAllegati" name="formAllegati">
  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_pdf" type="file" name="fileupload_pdf" class="form-control"/>
		   	 </span>
		   	 <label id="filename_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="pack" name=pack>
        <input type="hidden" id="id_misura" name=id_misura>
        <div class="row">
       <div class="col-xs-12">
        <label>Note Allegato</label>
        <textarea rows="5" style="width:100%" id="note_allegato" name="note_allegato"></textarea>        
       </div>
       
       </div>
       <div class="row">
       <div class="col-xs-12">
       <label>Attenzione! L'upload potrebbe sovrascrivere un altro file precedentemente caricato!</label>
       </div>
       </div>
  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateAllegati()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>


 <form id="formExcel" name="formExcel">
  <div id="myModalExcel" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">File Excel</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-xs-12">
         
       <span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un file...</span>

		        <input id="fileupload_excel" type="file" accept=".xls,.xlsx,.XLS,.XLSX,.xlsm,.xlsxm" name="fileupload_excel" class="form-control"/>
		   	 </span>
		   	 <label id="excel_label"></label>
		   	 <br>
       </div>
       </div>
       
        <input type="hidden" id="id_mis" name="id_mis">
       
  		 </div>
      <div class="modal-footer">
      <a class="btn btn-primary" onClick="validateExcel()">Salva</a>
      </div>
    </div>
  </div>
</div>
</form>


  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">


  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>




</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript">



   </script>

  <script type="text/javascript">

  function modalAllegati(pack,id_misura, note){
	  $('#myModalAllegati').modal();
	  $('#id_misura').val(id_misura);
	  $('#pack').val(pack);
	  $('#note_allegato').html(note);
  }
  
  function modalCertificato(id_certificato, pack){
	  $('#myModalCertificato').modal();
	  $('#id_cert').val(id_certificato);
	  $('#pack_cert').val(pack);
  }
  
  function modalExcel(id_misura){
	  $('#myModalExcel').modal();
	  $('#id_mis').val(id_misura);
	  
  }
  
	$("#fileupload_pdf").change(function(event){
		
		var fileExtension = 'pdf';
        if ($(this).val().split('.').pop()!= fileExtension) {
        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_pdf')[0].files[0].name;
       	 $('#filename_label').html(file );
        }
        
		
	});
	
	$("#fileupload_certificato").change(function(event){
		
		var fileExtension = 'pdf';
		var fileExtension2 = 'PDF';
        if ($(this).val().split('.').pop()!= fileExtension && $(this).val().split('.').pop()!= fileExtension2) {
        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo pdf!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_certificato')[0].files[0].name;
       	 	$('#certificato_label').html(file );
        }
        
		
	});
	
	
	$("#fileupload_excel").change(function(event){
		
		var fileExtension = 'xls';
		var fileExtension2 = 'xlsx';
        if ($(this).val().split('.').pop()!= fileExtension && $(this).val().split('.').pop()!= fileExtension2) {
        	
        
        	$('#myModalErrorContent').html("Attenzione! Inserisci solo xls!");
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");
			$('#myModalError').modal('show');

			$(this).val("");
        }else{
        	var file = $('#fileupload_excel')[0].files[0].name;
       	 	$('#excel_label').html(file );
        }
        
		
	});
	
	function validateAllegati(){
		var filename = $('#fileupload_pdf').val();
		//var filename = $('#fileupload_pdf')[0].files[0].name;
		if(filename == null || filename == ""){
			
		}else{
			submitFormAllegati("fromTable");
		}
	}
  
	function validateCertificato(){
		var filename = $('#fileupload_certificato').val();
		//var filename = $('#fileupload_pdf')[0].files[0].name;
		if(filename == null || filename == ""){
			
		}else{
			submitFormCertificato();
		}
	}
	
	function validateExcel(){
		var filename = $('#fileupload_excel').val();
		//var filename = $('#fileupload_pdf')[0].files[0].name;
		if(filename == null || filename == ""){
			
		}else{
			submitFormExcel();
		}
	}
  
	var columsDatatables = [];
	 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        if($(this).index()!= 0){
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	        }
	    } );
	} );

    $(document).ready(function() {
    

    	

    	table = $('#tabPM').DataTable({
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
  	    		order: [[ 1, "desc" ]],
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      stateSave: true,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 1 },
  	                   { responsivePriority: 2, targets: 2 },
  	                   { responsivePriority: 3, targets: 3 },
  	                 { responsivePriority: 4, targets: 10 },
  	                 { responsivePriority: 5, targets: 9 }
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                   /* exportOptions: {
  	                       modifier: {
  	                           page: 'current'
  	                       }
  	                   } */
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
    				
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
 
/*     $('#tabPM').on( 'dblclick','tr', function () {   
           	 //$( "#tabPM tr" ).dblclick(function() {
     		var id = $(this).attr('id');
   
     		var indexCampione = id.split('-');
     		var row = table.row('#'+id);
     		datax = row.data();
         
   	    if(datax){
   	    	row.child.hide();
   	    	exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
   	    	$( "#myModal" ).modal();
   	    	$('body').addClass('noScroll');
   	    }
   	   
  		
     	});
     	     */
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	resetCalendar("#prenotazione");
     	})


     	    $('.inputsearchtable').on('click', function(e){
     	       e.stopPropagation();    
     	    });
  // DataTable
	table = $('#tabPM').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	
	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });

});
  </script>
</jsp:attribute> 
</t:layout>
  
 
