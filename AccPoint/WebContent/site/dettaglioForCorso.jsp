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
        Dettaglio Corso
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
	 Dettaglio Corso
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${corso.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${corso.commessa}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Corso</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_corso}" /></a>
                </li>
                
                <li class="list-group-item">
                  <b>Data Scadenza</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_scadenza}" /></a>
                </li>
                <li class="list-group-item">
                <b>Docente</b> 
                <c:if test="${corso.docente!=null }"><a target="_blank" class="btn btn-danger  btn-xs pull-right customTooltip" href="gestioneFormazione.do?action=download_curriculum&id_docente=${utl:encryptData(corso.docente.id)}" title="Click per scaricare il cv"><i class="fa fa-file-pdf-o"></i></a></c:if>
                <a class="pull-right">${corso.docente.nome } ${corso.docente.cognome }</a>
                
                </li>
                <li class="list-group-item">
              
                <b>Numero partecipanti</b> <a class="pull-right" id="n_partecipanti"></a>
                </li>
                
  				 <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Descrizione</b>
                  
                 <a class="pull-right">${corso.descrizione}</a>
                 </div>
                 </div>
                </li>
  				 
                
               
        </ul>

</div>
</div>
</div>




<div class="col-md-6">
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
                <div class="row">
                     <div class="col-xs-12"> 
                  <b>Descrizione</b> <a class="pull-right">${corso.corso_cat.descrizione}</a>
                  </div>
                  </div>
                </li>                
                
                <li class="list-group-item">
                  <b>Frequenza (mesi)</b> <a class="pull-right">${corso.corso_cat.frequenza}</a>
                </li>
                <li class="list-group-item">
                  <b>Durata (ore)</b> <a class="pull-right">${corso.durata}</a>
                </li>
               
			<li class="list-group-item">
                <b>Edizione</b> <a class="pull-right">${corso.edizione}</a>
                </li>
               
        </ul>

</div>
</div>




<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Referenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <a class="btn btn-primary pull-right" onClick="$('#modalReferenti').modal()"><i class="fa fa-plus"></i> Referenti corso</a>

</div>
</div>
</c:if>

</div>

       
 </div>
        <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Allegati
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_allegati"></div>

</div>
</div>
</div>
    
    </div>
    
    
   	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">

<c:if test="${corso.questionario== null || corso.questionario.salvato==0 }">
<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Compila questionario</a>
</c:if>

<c:if test="${corso.questionario!= null && corso.questionario.salvato==1 }">


<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza o modifica questionario</a>

</c:if>

</div>
</div>

</div>
</div>
</div>
    
    </div>
 </c:if>   
 
 
    	<c:if test="${userObj.checkRuolo('F2') && corso.questionario!= null && corso.questionario.salvato==1 }">
    	  <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Questionario
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div class="row">
<div class="col-md-12">




<a class="btn btn-primary pull-right" onClick="callAction('gestioneFormazione.do?action=questionario&id_corso=${utl:encryptData(corso.id)}')"><i class="fa fa-edit"></i> Visualizza questionario</a>


</div>
</div>

</div>
</div>
</div>
    
    </div>
    	
    	</c:if>
 
 
    
    <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Partecipanti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

<div id="tab_partecipanti"></div>


</div>
</div>
</div>
    
    </div>
        
          <div id="modalReferenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Referenti Corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
      	<div class="col-xs-12">
      	
      	<a class="btn btn-primary pull-right" onClick="$('#modalAssociaReferenti').modal()"><i class="fa fa-plus"></i> Associa Referente</a>
      	
      	</div>
      	</div><br>
      	<div class="row">
      	<div class="col-xs-12">
      	<div id="content_referenti">
      	<c:forEach items="${corso.getListaReferenti() }" var="referente">
      	 <li class="list-group-item">
                  <div class="row">  <div class="col-xs-4"><b>${referente.nome } ${referente.cognome }</b></div><div class="col-xs-4"> <b>${referente.nome_azienda } - ${referente.nome_sede }</b></div><div class="col-xs-4"> <a class="pull-right">${referente.email }</a></div></div>
                </li>
      	
      	</c:forEach>
      	</div>
      	</div>
      	
      	</div>
      	</div>
      <div class="modal-footer">
     
    </div>
  </div>

</div>




 <div id="modalAssociaReferenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Referenti</h4>
      </div>
       <div class="modal-body">       

      	<div class="row">
      	<div class="col-xs-12">
      	<table id="tabForCorso" class="table table-bordered table-hover dataTable table-striped " role="grid" width="100%" >
 <thead><tr class="active">


<th style="max-width:40px">Sel</th>
<th>Nome</th>
<th>Cognome</th>
<th>Azienda</th>
<th>Sede</th>
<th>Email</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_referenti }" var="referente" varStatus="loop">
	<tr id="row_${loop.index}" >

	<td>
	<c:if test="${corso.getListaReferenti().contains(referente) }">
	<input type="checkbox" id="check_referente_${referente.id }" checked onchange="associaDissociaReferente('${referente.id}', '${corso.id }')">
	</c:if>
	<c:if test="${!corso.getListaReferenti().contains(referente) }">
	<input type="checkbox" id="check_referente_${referente.id }" onchange="associaDissociaReferente('${referente.id}', '${corso.id }')">
	</c:if>
	</td>
	<td>${referente.nome }</td>
	<td>${referente.cognome }</td>	
	<td>${referente.nome_azienda }</td>	
	<td>${referente.nome_sede }</td>	
	<td>${referente.email }</td>	
		
	
	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
      	</div>
      	
      	</div>
      	</div>
      <div class="modal-footer">
     
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
 
 

 var columsDatatables1 = [];
 $("#tabForCorso").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables1 = state.columns;
     }
     $('#tabForCorso thead th').each( function () {
      	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
     	  var title = $('#tabForCorso thead th').eq( $(this).index() ).text();
     	
     	  if($(this).index() >0 ){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
 	    	}

     	} );
     
     


 } );

 
function modalArchivio(id_corso){
	 
	 $('#tab_archivio').html("");
	 
	 dataString ="action=archivio&id_categoria=0&id_corso="+ id_corso;
    exploreModal("gestioneFormazione.do",dataString,"#tab_allegati",function(datab,textStatusb){
    });
$('#myModalArchivio').modal();
}
   
   
   
function associaDissociaReferente(id_referente, id_corso){
	
	var azione = 'dissocia';
	
	if($('#check_referente_'+id_referente).is( ':checked' )){
		azione = 'associa'
	}
	
	var dataObj = {};
	dataObj.id_corso = id_corso;
	dataObj.id_referente = id_referente;
	dataObj.azione = azione

	  $.ajax({
	type: "POST",
	url: "gestioneFormazione.do?action=associa_dissocia_referente",
	data: dataObj,
	dataType: "json",
	//if received a response from the server
	success: function( data, textStatus) {
		pleaseWaitDiv.modal('hide');
		  if(data.success){	  			
	   				  
		  }else{
			
			$('#myModalErrorContent').html(data.messaggio);
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#report_button').hide();
			$('#visualizza_report').hide();
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


$('input:checkbox').on('ifToggled', function() {
	
	var id =$(this)[0].id;
			
		id=id.split("_")[2];

		associaDissociaReferente(id, '${corso.id}');

	
}) 
   
   
    $(document).ready(function() {
    

    	 dataString ="action=dettaglio_partecipanti_corso";
        exploreModal("gestioneFormazione.do",dataString,"#tab_partecipanti",function(datab,textStatusb){
        });
        
        modalArchivio('${corso.id}')
        
      var  table = $('#tabForCorso').DataTable({
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
	        pageLength: 50,
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
		    	  { responsivePriority: 2, targets: 5 },
		    	   { targets: 0,  orderable: false }
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
        
        
		
        table.buttons().container().appendTo( '#tabForCorso_wrapper .col-sm-6:eq(1)');
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
	     
	 	$('#tabForCorso').on( 'page.dt', function () {
			$('.customTooltip').tooltipster({
		        theme: 'tooltipster-light'
		    });
			
			$('.removeDefault').each(function() {
			   $(this).removeClass('btn-default');
			})


		});
    });
    
    
    
    $('#modalAssociaReferenti').on('hidden.bs.modal', function(){  
    	
    	var dataObj = {};
    	dataObj.id_corso = '${corso.id}';


    	  $.ajax({
    	type: "POST",
    	url: "gestioneFormazione.do?action=referenti_corso",
    	data: dataObj,
    	dataType: "json",
    	//if received a response from the server
    	success: function( data, textStatus) {
    		pleaseWaitDiv.modal('hide');
    		  if(data.success){	  	
    			  
    			  html = '';
    			  
    			  var referenti = data.lista_referenti_corso;
    			  for (var i = 0; i < referenti.length; i++) {
					html = html +' <li class="list-group-item"> <div class="row">  <div class="col-xs-4"><b>'+referenti[i].nome +' '+ referenti[i].cognome+'</b> </div>  <div class="col-xs-4"> <b>'+referenti[i].nome_azienda+' - '+referenti[i].nome_sede+'</b> </div>  <div class="col-xs-4">  <a class="pull-right">'+referenti[i].email+'</a></div></div></li>'
				}
    			  
					$('#content_referenti').html(html)
    		    	$('#modalReferenti').modal();  
    		  }else{
    			
    			$('#myModalErrorContent').html(data.messaggio);
    		  	$('#myModalError').removeClass();
    			$('#myModalError').addClass("modal modal-danger");	  
    			$('#report_button').hide();
    			$('#visualizza_report').hide();
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
    	
    	
    
    	
    })
    

  </script>
  
</jsp:attribute> 
</t:layout>

