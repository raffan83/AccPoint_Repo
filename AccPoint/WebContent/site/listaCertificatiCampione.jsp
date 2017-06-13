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
  <th>Numero Certificato</th>
 <th>Data Creazione</th>

	<th>Action</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${dettaglioCampione.listaCertificatiCampione}" var="certificatocamp" varStatus="loop">

	<tr role="row" id="${certificatocamp.id}-${loop.index}">
	
		<td>${certificatocamp.id}</td>
		<td>${certificatocamp.numero_certificato}</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${certificatocamp.dataCreazione}" /></td>

		<td>
		<a href="scaricaCertificato.do?action=certificatoCampioneDettaglio&idCert=${certificatocamp.id}" class="btn btn-danger"><i class="fa fa-file-pdf-o"></i></a>
		<a href="scaricaCertificato.do?action=eliminaCertificatoCampione&idCert=${certificatocamp.id}" class="btn btn-danger"><i class="fa fa-remove"></i></a>
		
		</td>
	
		
	
	
	</tr>

	</c:forEach>
 
	
 </tbody>
 </table> 


 <script type="text/javascript">

  
    $(document).ready(function() {
    
    	tableCertificati = $('#tabCertificati').DataTable({
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      order: [[ 0, "desc" ]],
  	      
  	      columnDefs: [
  	                  { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 }
  	       
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
    	
  	tableCertificati.buttons().container().appendTo( '#ttabCertificati_wrapper .col-sm-6:eq(1)');
	    
  $('#tabCertificati thead th').each( function () {
      var title = $('#tabPM thead th').eq( $(this).index() ).text();
      $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
  } );

  // DataTable
	tableCertificati = $('#tabCertificati').DataTable();
  // Apply the search
  tableCertificati.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tableCertificati.column( colIdx ).header() ).on( 'keyup change', function () {
    	  tableCertificati
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tableCertificati.columns.adjust().draw();
    	
    	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});


 
    });


  </script>				