<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>

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
        Schede di Consegna
        
      </h1>
      
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
       
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div style="clear: both;"></div>
<div class="row">
        <div class="col-xs-12">


 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Schede Consegna
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">



        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#standard" data-toggle="tab" aria-expanded="true"   id="standardTab">Schede di Consegna</a></li>
              		<li class=""><a href="#rilievi" data-toggle="tab" aria-expanded="false"   id="rilieviTab">Rilievi Dimensionali</a></li>
             	

            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="standard">
	<table id="tabSC" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Intervento</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Data Creazione Intervento</th>
 <th>Commessa</th>
 <th>Data Creazione Scheda</th>
 <th>Stato</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna}" var="scheda" varStatus="loop">
 <c:if test="${scheda.abilitato==1}">
	 <tr role="row" id="${scheda.id}-${loop.index}">

<td>

<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(scheda.intervento.id)}');">
		${scheda.intervento.id}
	</a>
</td>
<td>${scheda.intervento.nome_cliente }</td>
<td>${scheda.intervento.nome_sede }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.intervento.dataCreazione }" /></td>
<td>${scheda.intervento.idCommessa }</td>
<td>${scheda.data_caricamento}</td>
<td>
<c:choose>
<c:when test="${scheda.stato==0 }">
Da Fatturare
</c:when>
<c:otherwise>
Fatturata
</c:otherwise>
</c:choose>
</td>
<td>
<a  target="_blank" class="btn btn-danger customTooltip  pull-center" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('${utl:encryptData(scheda.intervento.id)}', '${scheda.nome_file}')"><i class="fa fa-file-pdf-o"></i></a>
 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','0')"><i class="glyphicon glyphicon-refresh"></i></a>  	
	</tr>
	</c:if> 
	</c:forEach>
 
	
 </tbody>
 </table> 

    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="rilievi">
              
              
              
              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Mese</th>
 <th>Anno</th>
 <th>Commessa</th>
 <th>Data Creazione</th> 
 <th>Stato</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_schede_consegna_rilievi}" var="scheda" varStatus="loop">

<tr role="row" id="${scheda.id}-${loop.index}">
	
<td>${scheda.id}</td>
<td>${scheda.nome_cliente }</td>
<td>${scheda.nome_sede}</td>
<td>${scheda.mese}</td>
<td>${scheda.anno}</td>
<td>${scheda.commessa }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${scheda.data_creazione}" /></td>
<td>
<c:choose>
<c:when test="${scheda.stato==0 }">
Da Fatturare
</c:when>
<c:otherwise>
Fatturata
</c:otherwise>
</c:choose>
</td>
<td>
 <a  target="_blank" class="btn btn-danger customTooltip" title="Click per scaricare la scheda di consegna"   onClick="scaricaSchedaConsegnaFile('','${scheda.file}', '${utl:encryptData(scheda.id)}')"><i class="fa fa-file-pdf-o"></i></a>
 <a  class="btn btn-warning customTooltip" title="Cambia Stato"   onClick="cambiaStatoSchedaConsegna('${scheda.id}','1')"><i class="glyphicon glyphicon-refresh"></i></a>  
<%-- <a  target="_blank" class="btn btn-primary customTooltip  pull-center" title="Click per eliminare la scheda di consegna"   onClick="eliminaSchedaConsegna(${scheda.id})"><i class="fa fa-remove" style="color:black"></i></a> --%>	
</td>
	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
                

         
			 </div>



              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>


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

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

<script type="text/javascript">
  
  
  
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {


  	var  contentID = e.target.id;

  	
/*   	if(contentID == "standardTab"){
  		
  		//exploreModal("showSchedeConsegna.do","","#standard");
  	} */
/*   	if(contentID == "rilieviTab"){
  		
  		exploreModal("showSchedeConsegna.do","action=rilievi","#rilievi");
  		$('#rilieviTab').show();
  	} */
  	

	});
  
  

	 var columsDatatables = [];
	 var columsDatatables2 = [];
	 
	$("#tabSC").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabSC thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabSC thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} ); 

	
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables2 = state.columns;
	    }
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables2[$(this).index()].search.search+'" /></div>');
	    } );

	} );

  
    $(document).ready(function() {
   
    	
    	table = $('#tabSC').DataTable({
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
  	    stateSave: true,
  	      columnDefs: [
					   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 7 }
  	               ],

  	    	
  	    });
    	
  

     	    $('.inputsearchtable').on('click', function(e){
     	       e.stopPropagation();    
     	    });
  // DataTable
	table = $('#tabSC').DataTable();
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
    	
	
	$('#tabSC').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });
	
	
	
	
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
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	    stateSave: true,
	      columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 8 },
	                   { responsivePriority: 4, targets: 7 }
	               ],

	    	
	    });
	


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
  
 
