<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
    
<table id="tabPuntiQuota" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%"> 
 <thead><tr class="active">
 	<th>Quota</th>
	<th>Tolleranza -</th>
	<th>Tolleranza +</th>
	<th>Coordinata</th>
	<th>Valore Nominale</th>
	<c:forEach items="${lista_quote.get(0).listaPuntiQuota}" varStatus="loop">
		<th>Pezzo ${loop.index }</th>
	</c:forEach>

 </tr>
 
 </thead>
 
 <tbody>
 
 <c:forEach items="${lista_quote}" var="quota" varStatus="loop">
 <tr id="riga_${loop.index}">

 	<td>${quota.id }</td>
 	<td>${utl:getIncertezzaNormalizzata(quota.tolleranza_negativa)}</td>
 	<td>${utl:getIncertezzaNormalizzata(quota.tolleranza_positiva)}</td>
 	<td>${quota.coordinata }</td>
 	<td>${utl:getIncertezzaNormalizzata(quota.val_nominale)}</td>
 	<c:forEach items="${quota.listaPuntiQuota}" var="punto" varStatus="loop">		
		<td>${utl:changeDotComma(punto.valore_punto.toPlainString())}</td>
	</c:forEach>
 	
	</tr>
	
	</c:forEach>

	
 </tbody>
 </table>

 

<!-- <script src="https://cdn.datatables.net/select/1.2.7/js/dataTables.select.js"></script>
<script src="https://cdn.datatables.net/select/1.2.7/js/dataTables.select.min.js"></script> -->
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script>  
  <script type="text/javascript">

  
	var columsDatatables = [];
	 
	$("#tabPuntiQuota").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    

	} );

  $(document).ready(function(){

	    $('#tabPuntiQuota thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        
	      	      var title = $('#tabPuntiQuota thead th').eq( $(this).index() ).text();
	          	$(this).append( '<div><input class="inputsearchtable" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	          
	    } );
	 tab = $('#tabPuntiQuota').DataTable({
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
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: true, 
		      targets: 0,
		      responsive: false,
		      scrollX: true,
		      stateSave: true,
/* 		  	    select: {
		        	style:    'multi+shift'
		        	//selector: 'td:nth-child(2)'
		    	}, */
		    select:true,

		       columnDefs: [
					    { responsivePriority: 1, targets: 0 },
					    { responsivePriority: 2, targets: 1 }		                
		               ],  		    	
		    });
		


		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });
	//DataTable
	tab = $('#tabPuntiQuota').DataTable();
	//Apply the search
 	tab.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
		tab
	       .column( colIdx )
	       .search( this.value )
	       .draw();
	} );
	} ); 
	tab.columns.adjust().draw(); 
		

	$('#tabPuntiQuota').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	     theme: 'tooltipster-light'
	 });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	var table = $('#tabPuntiQuota').DataTable();
	 
	$('#tabPuntiQuota tbody').on( 'click', 'tr', function () {
	    if ($(this).hasClass('selected')) {
	        $(this).removeClass('selected');
	      	       
	        $('#val_nominale').val('');
	        $('#coordinata').val('');
	        $('#tolleranza_neg').val('');
	        $('#tolleranza_pos').val('');
	        var n_pezzi = ${numero_pezzi};
	        for(var i = 0; i<n_pezzi;i++){
	        	 $('#pezzo_'+(i+1)).val('');
	        }
	        
	    } else {	    	
	        table.$('tr.selected').removeClass('selected');
	        $(this).addClass('selected');
	        
	        var id = $(this).attr('id');
	        var row = table.row('#'+id);
			data = row.data();
	       
	        $('#val_nominale').val(data[4]);
	        $('#coordinata').val(data[3]);
	        $('#tolleranza_neg').val(data[1]);
	        $('#tolleranza_pos').val(data[2]);
	        var n_pezzi = ${numero_pezzi};
	        for(var i = 0; i<n_pezzi;i++){
	        	 $('#pezzo_'+(i+1)).val(data[5+i]);
	        }
	        
	        
	    }
	} );

 }); 
 
  
  //table = $('#tabPuntiQuota').DataTable();
	
  
 </script>
			
			 