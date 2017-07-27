<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.AccessorioDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%



	%>

  <table id="tabDotazioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 
 <th>Codice</th>
 <th>Descrizione</th>

 <th>Action</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaTipologiaDotazioni}" var="tipoDotazione" varStatus="loop">

	 <tr role="row" id="${tipoDotazione.id}-${loop.index}">

	<td>${tipoDotazione.id}</td>
	<td>${tipoDotazione.codice}</td>
	<td>${tipoDotazione.descrizione}</td>

	<td>

			<button id="btnAssociaTipologiaDotazione_${tipoDotazione.id}" onClick="associaTipologiaDotazione('${tipoDotazione.id}','${idArticolo}')" class="btn btn-success  customTooltip" title="Associa" <c:if test = "${articolo.checkTipoDotazione(tipoDotazione.id)}">disabled="disabled"</c:if> ><i class="fa fa-check"></i></button> 
			<button id="btnDisAssociaTipologiaDotazione_${tipoDotazione.id}" onClick="disassociaTipologiaDotazione('${tipoDotazione.id}','${idArticolo}')" class="btn btn-danger  customTooltip" title="Disassocia" <c:if test = "${!articolo.checkTipoDotazione(tipoDotazione.id)}">disabled="disabled"</c:if> ><i class="fa fa-remove"> </i></button>

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	
     	$("#tipologia").select2({ width: '100%' });
     	$("#modtipologia").select2({ width: '100%' });
     	
    	table = $('#tabDotazioni').DataTable({
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 }

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
  	              /*  ,
  	               {
  	             		text: 'I Miei Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do?p=mCMP');
                 		},
                 		 className: 'btn-info removeDefault'
    				},
  	               {
  	             		text: 'Tutti gli Strumenti',
                 		action: function ( e, dt, node, config ) {
                 			explore('listaCampioni.do');
                 		},
                 		 className: 'btn-info removeDefault'
    				} */
  	                         
  	          ]
  	    	
  	      
  	    });
    	
  	table.buttons().container().appendTo( '#tabDotazioni_wrapper .col-sm-6:eq(1)');
  
  $('#tabDotazioni thead th').each( function () {
      var title = $('#tabDotazioni thead th').eq( $(this).index() - 1 ).text();

      $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
  } );

  // DataTable
	table = $('#tabDotazioni').DataTable();
  // Apply the search
  table.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', table.column( colIdx ).header() ).on( 'keyup change', function () {
          table
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  	table.columns.adjust().draw();
    	
    	
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});
    	
    	
  	 $('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     });
    });
  </script>

