
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Lista Prenotazioni
      </h1>
         <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
 <div style="clear: both;"></div> 
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">
 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista prenotazioni per utenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
 <div class="clearfix"></div>
<br>
<div class="row"> 

	</div>
              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Targa Veicolo</th>
 <th>Modello Veicolo</th>
 <th>Data Inizio Prenotazione</th>
 <th>Data Fine Prenotazione</th>
 <th>Stato Prenotazione</th>
 <th>Conferma</th>

 </tr></thead>
 
 <tbody>
 
  <c:forEach items="${listaPrenotazione}" var="prenotazione">
 <tr role="row" id="${prenotazione.id}">

<td><c:out value="${prenotazione.id}"/></td>
	
	<td><c:out value="${prenotazione.veicolo.targa}"/></td>
	<td><c:out value="${prenotazione.veicolo.modello}"/></td>
	<td>
	<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${prenotazione.data_inizio_prenotazione}" />
	
	<%-- <c:out value="${prenotazione.data_inizio_prenotazione}"/> --%></td>
	<td>
	<fmt:formatDate pattern="dd/MM/yyyy HH:mm" value="${prenotazione.data_fine_prenotazione}" />
	<%-- <c:out value="${prenotazione.data_fine_prenotazione}"/ --%></td>

	<td class="centered">

 <c:choose>
  <c:when test="${prenotazione.stato_prenotazione == '1'}">
    <span class="label label-warning">IN PRENOTAZIONE</span>
  </c:when>
  <c:when test="${prenotazione.stato_prenotazione == '2'}">
    <span class="label label-success">PRENOTATO</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">RIENTRATO</span>
  </c:otherwise>
</c:choose> 
</td>
		<td>
			<%-- <a class="btn customTooltip" title="Click per aprire il dettaglio della Commessa" onclick="callAction('gestioneIntervento.do?idCommessa=${commessa.ID_COMMESSA}');"> --%>
			<c:if test="${prenotazione.stato_prenotazione == '1' }">
			<a class="btn btn-success customTooltip" title="Click per confermare la prenotazione" onclick="confermaPrenotazione('${prenotazione.id}')">
                <i class="fa fa-check"></i>
          
            </a>
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
            <!-- /.box-body -->
          </div>
        </div>
        <!-- /.col -->
 </div>
</div>




  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Approvazione</h4>
      </div>
       <div class="modal-body">

        
        
        	<div class="form-group">

                  <textarea class="form-control" rows="3" id="noteApp" placeholder="Entra una nota ..."></textarea>
                </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"  >Non Approva</button>
      </div>
    </div>
  </div>
</div>

   <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div> 

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

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
  
  
  
  function confermaPrenotazione(id_prenotazione){
	  
	  var dataObj = {};
	  dataObj.id_prenotazione = id_prenotazione;
	  
	  callAjax(dataObj, "confermaPrenotazione.do?action=conferma_prenotazione");
	  
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
	        		$(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
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
	        pageLength: 50,
    	      paging: true, 
    	      ordering: true,
    	      info: true, 
    	      searchable: false, 
    	      targets: 0,
    	      responsive: true,
    	      scrollX: false,
    	      stateSave: true,
    	      dom : "t<'col-xs-6'i><'col-xs-6'p>",
    	      columnDefs: [
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
    	                         
    	                          ]
    	    	
    	      
    	    });
    	table.buttons().container()
        .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
     	   
 			/* $('#tabPM').on( 'dblclick','tr', function () {

       		var id = $(this).attr('id');
       		
       		var row = table.row('#'+id);
       		data = row.data();
           
     	    if(data){
     	    	 row.child.hide();
             	$( "#myModal" ).modal();
     	    }
       	}); */
       	    
       	    
       	 $('#myModal').on('hidden.bs.modal', function (e) {
       	  	$('#noteApp').val("");
       	 	$('#empty').html("");
       	})

    

$('.inputsearchtable').on('click', function(e){
   e.stopPropagation();    
});
 
    // DataTable
  	table = $('#tabPM').DataTable();
    
    // Apply the search
    table.columns().eq( 0 ).each( function ( colIdx ) {
        $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
            table.column( colIdx ).search( this.value ).draw();

        } );
    } ); 
    	table.columns.adjust().draw();
    
    	 $('#tabPM').on( 'page.dt', function () {
				$('.customTooltip').tooltipster({
			        theme: 'tooltipster-light'
			    });
			  } );
    });
    

  </script>
  
  
</jsp:attribute> 
</t:layout>




