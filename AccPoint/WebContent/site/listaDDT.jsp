<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%-- 	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 
	String action = (String)request.getSession().getAttribute("action");

	
	%> --%>
<%-- <%
	ArrayList<ClienteDTO> lista_clienti = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
	ArrayList<ClienteDTO> lista_fornitori = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_fornitori");
%>	
<c:set var="listaClienti" value="<%=lista_clienti %>"></c:set>
<c:set var="listaFornitori" value="<%=lista_clienti %>"></c:set> --%>
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
        Lista DDT
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista DDT
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-sm-12">
	<div class="col-xs-6">
			 <div class="form-group">
				 <label for="datarange" class="control-label">Ricerca Data DDT:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control" id="datarange" name="datarange" value=""/> 						    
							 <span class="input-group-btn">
				               <button type="button" class="btn btn-info btn-flat" onclick="filtraDDTPerData()">Cerca</button>
				               <button type="button" style="margin-left:5px" class="btn btn-primary btn-flat" onclick="resetDate()">Reset Date</button>
				             </span>				                     
  					</div>  								
			 </div>	
			 
			 

	</div>

</div>
</div>

<div class="row">
<div class="col-sm-12">



 <table id="tabDDT" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Numero</th>
<th>Data DDT</th>
<th>Mittente/Destinatario</th>
<th>Sede Mittente/Destinatario</th>
<th>Destinazione</th>
<th>Sede Destinazione</th>
<th>Commessa</th>
<th>Tipo DDT</th>
<th>Azioni</th>


 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_ddt }" var="ddt" varStatus="loop">
	<tr>
		<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${utl:encryptData(ddt.id) }')">
		${ddt.id }
			</a></td>
		<td>${ddt.numero_ddt }</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${ddt.data_ddt }" /></td>
		<td>${ddt.destinatario }</td>
		<td>${ddt.sede_destinatario }</td>
		<td>${ddt.destinazione }</td>
		<td>${ddt.sede_destinazione }</td>
		<td>${ddt.commessa }</td>
		<td><c:choose>
			<c:when test="${ddt.tipo_ddt.id == 1}">
			 <span class="label label-info">${ddt.tipo_ddt.descrizione } </span></c:when>
			 <c:when test="${ddt.tipo_ddt.id == 2}">
			 <span class="label label-success">${ddt.tipo_ddt.descrizione }</span></c:when>			  
			 </c:choose>
		</td>
		<td>
			<c:if test="${ddt.link_pdf!=null && ddt.link_pdf!=''}">
			<c:url var="url" value="gestioneDDT.do">
			
			<c:param name="action" value="download" />
			 <c:param name="id_ddt" value="${utl:encryptData(ddt.id) }"></c:param>
			  </c:url>
			<%-- <button   class="btn customTooltip btn-danger" style="background-color:#A11F12;border-color:#A11F12;border-width:0.11em" title="Click per scaricare il DDT"   onClick="callAction('${url}')"><i class="fa fa-file-pdf-o fa-sm"></i></button> --%>
			<a  target="_blank"  class="btn btn-danger customTooltip" title="Click per scaricare il DDT"   href="${url}"><i class="fa fa-file-pdf-o"></i></a>
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

  </div>
  
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="plugins/datejs/date.js"></script>

 <script type="text/javascript">
 

 function filtraDDTPerData(){
		
			
	var startDatePicker = $("#datarange").data('daterangepicker').startDate;
	var endDatePicker = $("#datarange").data('daterangepicker').endDate;
	
	dataString = "?action=filtraDateDDT&dateFrom=" + startDatePicker.format('YYYY-MM-DD') + "&dateTo=" + endDatePicker.format('YYYY-MM-DD');
		 	
	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();

		 	callAction("listaPacchi.do"+ dataString, false,true);
		 	
			
		}
 
 function resetDate(){
		pleaseWaitDiv = $('#pleaseWaitDialog');
		pleaseWaitDiv.modal();
		callAction("listaPacchi.do?action=lista_ddt");

	}
 

 
	var columsDatatables = [];
	 
	$("#tabDDT").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabDDT thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabDDT thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    
	    

	} );
	
	
	function formatDate(data){
		
		   var mydate = new Date(data);
		   
		   if(!isNaN(mydate.getTime())){
		   
			   str = mydate.toString("dd/MM/yyyy");
		   }			   
		   return str;	 		
	}
 
 $(document).ready(function() {
	 
	 
	 $('input[name="datarange"]').daterangepicker({
		    locale: {
		      format: 'DD/MM/YYYY'
		    
		    }
		}, 
		function(start, end, label) {

		});
	 
	 var start = "${dateFromDdt}";
	 var end = "${dateToDdt}";
	 if(start!=null && start!=""){
		 	$('#datarange').data('daterangepicker').setStartDate(formatDate(start));
		 	$('#datarange').data('daterangepicker').setEndDate(formatDate(end));
		
		 	$("#tipo_data option[value='']").remove();
		 	$('#tipo_data option[value="${tipo_data}"]').attr("selected", true);
		 }
	 
	 $('.dropdown-toggle').dropdown();
	 table = $('#tabDDT').DataTable({
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

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 9 }
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDDT_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDDT').on( 'page.dt', function () {
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


 
 






