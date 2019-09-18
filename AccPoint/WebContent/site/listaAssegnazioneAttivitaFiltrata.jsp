<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>



<div class="row">
<div class="col-sm-12">

 <table id="tabAssegnazioneAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>
<th>ID Intervento</th>
<th>Commessa</th>
<th>Cliente</th>
<th>Sede</th>
<th>Data</th>

<th>Descrizioni Attivita</th>
<th>Quantit� Totale</th>
<th>Quantit� Assegnata</th>

<th>Note</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_milestone }" var="milestone" varStatus="loop">
	<tr id="row_${loop.index}" >
 	<td></td>
	<td><a class="btn customTooltip customlink" onClicK="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(milestone.intervento.id)}')" >${milestone.intervento.id }</a></td>	
	<td>${milestone.intervento.idCommessa }</td>
	<td>${milestone.intervento.nome_cliente }</td>
	<td>${milestone.intervento.nome_sede }</td>
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${milestone.data}" /></td>

	 <%-- <td onClick="showText('${milestone.descrizioneMilestone }', '${loop.index}')">${utl:maxChar(milestone.descrizioneMilestone, 10)}</td> --%>  
	 <td>${milestone.descrizioneMilestone }</td> 
	<td>${milestone.quantitaTotale }</td>
	<td>${milestone.quantitaAssegnata }</td>

	<td>${milestone.note }</td>


	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>



<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


var columsDatatables = [];

$("#tabAssegnazioneAttivita").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAssegnazioneAttivita thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabVerInterventi thead th').eq( $(this).index() ).text();
    	
    	  if($(this).index()!=0 ){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
    	//  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );

/* $('#tabAssegnazioneAttivita').on( 'click', 'tbody td', function () {
    var data = table.cell( this ).render( function(data, type, row) {
        data = text;
        return data;
      });
 
    console.log( data );
} );
 */

 function showText(text, riga){
	
	table = $('#tabAssegnazioneAttivita').DataTable();
	
	
	if(table.cell(parseInt(riga), 6 ).data().length){
		
		table.cell(parseInt(riga), 6 ).data(text).draw();
		
	}else{
		 table.cell(parseInt(riga), 6 ).data(text).draw();
			
	}
	     

} 



$(document).ready(function(){
	
	
	 table = $('#tabAssegnazioneAttivita').DataTable({
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
	        "order": [[ 2, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		         
		      columnDefs: [
		    	 
		    	  { responsivePriority: 1, targets: 1 }
		    	   /* {
		    	        targets: 6,
		    	        
		    	        render: function(data, type, row) {
		    	            if (data != null) {
		    	                data = data.replace(/<(?:.|\\n)*?>/gm, '');
		    	                if(data.length > 10) {
		    	                  return data.substr(0, 10) + "...";
		    	                } else {
		    	                  return data;
		    	                }
		    	              } else {
		    	                return data;
		    	              }
		    	            }
		    	        
		    	        render: function(data, type, row) {
		    	            if (data != null) {
		    	                data = data.replace(/<(?:.|\\n)*?>/gm, '');
		    	                if(data.length > 10) {
		    	                  return '<span class=\"show-ellipsis\" >' + data.substr(0, 10) + '</span><span class=\"no-show\">' + data.substr(10) + '</span>';
		    	                } else {
		    	                  return data;
		    	                }
		    	              } else {
		    	                return data;
		    	              }
		    	            } 
		    	 
		    	  }  */
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAssegnazioneAttivita_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAssegnazioneAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
});


</script>