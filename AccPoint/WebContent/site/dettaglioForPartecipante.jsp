<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Dashboard" bodyClass="skin-blue-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Partecipante
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Partecipante
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${partecipante.id}</a>
                </li>
               
              
                <li class="list-group-item">
                <b>Nome</b> <a class="pull-right">${partecipante.nome }</a>
                </li>
                
  				 <li class="list-group-item">
                <b>Cognome</b> <a class="pull-right">${partecipante.cognome}</a>
                </li>
                
                 <li class="list-group-item">
                  <b>Data di nascita</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${partecipante.data_nascita}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Luogo di nascita</b> <a class="pull-right">${partecipante.luogo_nascita}</a>
                </li>
                <li class="list-group-item">
                  <b>Codice fiscale</b> <a class="pull-right">${partecipante.cf}</a>
                </li>
               <li class="list-group-item">
                <b>Azienda</b> <a class="pull-right">${partecipante.nome_azienda}</a>
                </li>
                <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Sede</b> <a class="pull-right">${partecipante.nome_sede}</a>
                </div>
                </div>
                </li>
                
                 <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Note</b> <!-- <a class="pull-right"> --><textarea id="note" name="note" rows="3" style="width:100%" class="form-control pull-right">${partecipante.note }</textarea><!-- </a> -->
                </div>
                </div>
                </li>
        </ul>

</div>
</div>
</div>
<div class="col-md-6">

<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=scadenzario_partecipante&id_partecipante=${utl:encryptData(partecipante.id)}')">Vai allo scadenzario</a>

</div>



<%-- <div class="col-md-6">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio Tipologia
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
               <li class="list-group-item">
                  <b>Codice</b> <a class="pull-right">${corso.corso_cat.codice}</a>
                </li>
                <li class="list-group-item">
                  <b>Descrizione</b> <a class="pull-right">${corso.corso_cat.descrizione}</a>
                </li>                
                
                <li class="list-group-item">
                  <b>Frequenza</b> <a class="pull-right">${corso.corso_cat.frequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Durata</b> <a class="pull-right">${corso.corso_cat.durata}</a>
                </li>
               
			<li class="list-group-item">
                <b>Edizione</b> <a class="pull-right">${corso.edizione}</a>
                </li>
               
        </ul>

</div>
</div>
</div>
 --%>
       
 </div>
    
    
    
    <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Corsi 
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">


<table id="tabCorsi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
<th>ID</th>
<th>Codice</th>
<th>Descrizione Categoria</th>
<th>Ruolo</th>
<th>Data Corso</th>
<th>Data Scadenza</th>
<th>Ore partecipate</th>
<th>Ore totali</th>
<th>Tipologia</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_corsi_partecipante }" var="corso_part" varStatus="loop">
 	<tr id="row_${loop.index}" >
 	<td></td>
 	<td><a class="btn customTooltip customlink" title="Vai al corso" onclick="callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso=${utl:encryptData(corso_part.corso.id)}')">${corso_part.corso.id}</a></td>
 	<td>${corso_part.corso.corso_cat.codice}</td>
	<td>${corso_part.corso.corso_cat.descrizione}</td>
	<td>${corso_part.ruolo.descrizione}</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${corso_part.corso.data_corso}" /></td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${corso_part.corso.data_scadenza}" /></td>
	<td>${corso_part.ore_partecipate}</td>
	<td>${corso_part.corso.durata}</td>
	<td>${corso_part.corso.tipologia}</td>
	<td>
	 <a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_attestato&id_corso=${utl:encryptData(corso_part.corso.id)}&id_partecipante=${utl:encryptData(corso_part.partecipante.id)}&filename=${utl:encryptData(corso_part.attestato)}" title="Click per scaricare l'attestato"><i class="fa fa-file-pdf-o"></i></a>
	
	
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
</div>
 </div> 
</section>
</div>



  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


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

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  
 <script type="text/javascript">
 
 
 var columsDatatables = [];

 $("#tabCorsi").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabCorsi thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabCorsi thead th').eq( $(this).index() ).text();
     	
     	  if($(this).index()!=0 ){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
 	    	}

     	} );
     
     

 } );
   
    $(document).ready(function() {
    
    	$('.dropdown-toggle').dropdown();
    	
  	  table = $('#tabCorsi').DataTable({
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
	        "order": [[ 1, "desc" ]],
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
		
		table.buttons().container().appendTo( '#tabCorsi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabCorsi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});

    	
    });

    
    $('#note').change(function(){
    
    	
    	var dataObj = {};
    	dataObj.id_partecipante = "${partecipante.id}";
    	dataObj.nota = $(this).val();
    	
    	
    	callAjax(dataObj, "gestioneFormazione.do?action=update_nota_partecipante", function(){
    		
    	
    	});
    	
    	
    });
    
    
    
  </script>
  
</jsp:attribute> 
</t:layout>

