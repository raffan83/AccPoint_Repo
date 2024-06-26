<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.CertificatoCampioneDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonElement jsonElem = (JsonElement)json.getAsJsonObject("dataInfo");

Gson gson = new Gson();
CampioneDTO dettaglioCampionec=(CampioneDTO)session.getAttribute("dettaglioCampione");

SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


%>

 <table id="tabCertificati" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th>Id Certificato</th>
  <th>Misura</th>
  <th>Denominazione</th>
 <th>Matricola</th>
 <th>Codice Interno</th>
	
<th>Data Misura</th>
	<th>Azioni</th>
	
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_certificati}" var="certificato" varStatus="loop">

	<tr role="row" id="${certificato.id}-${loop.index}">
	
		<td>${certificato.id}</td>
		<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della misura" onclick="callAction('dettaglioMisura.do?idMisura=${utl:encryptData(certificato.misura.id)}')">${certificato.misura.id }</a></td>
	
		<td>${certificato.misura.strumento.denominazione}</td>
		<td>${certificato.misura.strumento.matricola}</td>
		<td>${certificato.misura.strumento.codice_interno}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificato.misura.dataMisura}" /></td>		
		<td>
		<c:if test="${certificato.stato.id==2 }">
		<a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare il PDF del Certificato"  href="scaricaCertificato.do?action=certificatoStrumento&nome=${utl:encryptData(certificato.nomeCertificato)}&pack=${utl:encryptData(certificato.misura.intervento.nomePack)}" ><i class="fa fa-file-pdf-o"></i></a>
		</c:if>	
		<c:if test="${certificato.misura.file_xls_ext!=null &&  certificato.misura.file_xls_ext!=''}">
		<a href="#" class="btn btn-success" title="Click per scaricare il file" onClick="scaricaPacchettoUploaded('${certificato.misura.interventoDati.nomePack}','${certificato.misura.intervento.nomePack}')"><i class="fa fa-file-excel-o"></i></a>
		</c:if>	
		</td>
	
		
	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 
<input type="hidden" id="selected">



<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
 <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabCertificati").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    
	    $('#tabCertificati thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    } );
	} );
  
    $(document).ready(function() {
    	
    	console.log("test");
    
   var tableCertificati = $('#tabCertificati').DataTable({
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
     
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      stateSave: true,
  	      select: true,
  	    order: [[ 0, "desc" ]],
  	      
  	      columnDefs: [
  	                  { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 6 }
  	       
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	  
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	tableCertificati.buttons().container().appendTo( '#tabCertificati_wrapper .col-sm-6:eq(1)');
	    
  
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tableCertificati = $('#tabCertificati').DataTable();
  // Apply the search
  tableCertificati.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableCertificati.column( colIdx ).header() ).on( 'keyup', function () {
    	  tableCertificati
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tableCertificati.columns.adjust().draw();
    	
	
	$('#tabCertificati').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
  	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});
  	
  	
	$('#tabCertificati tbody').on( 'click', 'tr', function () {
	     
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            $('#selected').val("");
        }
        else {
        	tableCertificati.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $('#selected').val($(this).find("td").eq(0).text());
        }
        
        
    } );


 
    });




  </script>				