<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
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
        Lista Prenotazioni Gestite
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>

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
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID Prenotazione</th>
 <th>Campione</th>
  <th>Codice Campione</th>
 <th>Stato</th>
 <th>Proprietario</th>
 <th>Azienda Richiedente</th>
 <th>Utente Richiedente</th>
 <th>Data Richiesta</th>
 <th>Data Gestione</th>
 <th>Data Inizio Prenotazione</th>
 <th>Data Fine Prenotazione</th>
 <th>Note</th>
 <th>Note Gestione</th>
 </tr></thead>
 
 <tbody>
 <c:forEach items="${listaPrenotazioniNG}" var="prenotazione" varStatus="loop">

	 <tr role="row" id="${prenotazione.id}">


	<td>${prenotazione.id}</td>
    <td>${prenotazione.campione.nome}</td>
    <td>${prenotazione.campione.codice}</td>
	<td>
		<c:if test="${prenotazione.stato.id == 0}">
			<span class="label  label-warning">
		</c:if>
		<c:if test="${prenotazione.stato.id == 1}">
			<span class="label  label-success">
		</c:if>
		<c:if test="${prenotazione.stato.id == 2}">
			<span class="label  label-danger">
		</c:if>
		${prenotazione.stato.descrizione}</span> 
	</td>
	<td>${prenotazione.campione.company.denominazione}</td>
	<td>${prenotazione.companyRichiedente.denominazione}</td>
	<td>${prenotazione.userRichiedente.nominativo}</td>
	<td>
	<c:if test="${not empty prenotazione.dataRichiesta}">
   	<fmt:formatDate pattern="dd/MM/yyyy" value="${prenotazione.dataRichiesta}" />
	</c:if></td>
		<td>
	<c:if test="${not empty prenotazione.dataGestione}">
   	<fmt:formatDate pattern="dd/MM/yyyy" value="${prenotazione.dataGestione}" />
	</c:if></td>
		<td>
	<c:if test="${not empty prenotazione.prenotatoDal}">
   	<fmt:formatDate pattern="dd/MM/yyyy" value="${prenotazione.prenotatoDal}" />
	</c:if></td>
		<td>
	<c:if test="${not empty prenotazione.prenotatoAl}">
   	<fmt:formatDate pattern="dd/MM/yyyy" value="${prenotazione.prenotatoAl}" />
	</c:if></td>

	<td>${prenotazione.note}</td>
	<td>${prenotazione.noteApprovazione}</td>
	

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
 </div>
</div>




  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio Storico</h4>
      </div>
       <div class="modal-body">

        
        
        	<div class="form-group">


                </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
 

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
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
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
    	      info: true, 
    	      searchable: false, 
    	      targets: 0,
    	      responsive: true,
    	      scrollX: false,
    	      stateSave: true,
    	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
    	                   { responsivePriority: 2, targets: 1 },
    	                   { responsivePriority: 3, targets: 2 },
    	                   { responsivePriority: 4, targets: 6 }
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
       /*  $('#tabPM').DataTable({
        	"columnDefs": [
        	               { "width": "50px", "targets": 0 },
        	               { "width": "250px", "targets": 1 },
        	               { "width": "50px", "targets": 2 },
        	               { "width": "150px", "targets": 3 },
        	               { "width": "50px", "targets": 4 },
        	               { "width": "100px", "targets": 5 }
        	             ],
      	       
      	  "scrollY":        "350px",
            "scrollX":        true,
            "scrollCollapse": true,
       	    "paging":   false,
       	   
       	    }); */
       	    
/*        	 $( "#tabPM tr" ).dblclick(function() {
 */       	   
 			$('#tabPM').on( 'dblclick','tr', function () {

       		var id = $(this).attr('id');
       		
       		var row = table.row('#'+id);
       		data = row.data();
           
     	    if(data){
     	    	 row.child.hide();
             	//$( "#myModal" ).modal();
				callAction("listaPrenotazioniCampione.do?idPrenotazione="+id);
     	    }
       	});
       	    
       	    
       	/*  $('#myModal').on('hidden.bs.modal', function (e) {
       	  	$('#noteApp').val("");
       	 	$('#empty').html("");
       	}) */

    
  
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
    	  } );
    });
  </script>
  
  

     
</jsp:attribute> 
</t:layout>


