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

  <table id="tabAccessori" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 
 <th>Company</th>
 <th>Nome</th>
 <th>Descrizione</th>
 <th>Tipologia</th>
 <th>Quantit�</th>
 <th>Action</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaAccessori}" var="accessorio" varStatus="loop">

	 <tr role="row" id="${accessorio.id}-${loop.index}">

	<td>${accessorio.id}</td>
	<td>${accessorio.company.denominazione}</td>
	<td>${accessorio.nome}</td>
	<td>${accessorio.descrizione}</td>
	<td>${accessorio.tipologia.codice}</td>
	
	<c:set var = "quantitaNecessaria" value = "${articolo.checkAccessorio(accessorio.id)}"/>
	<td id="tdqy_${accessorio.id}">
	 	<c:if test = "${quantitaNecessaria == 0}">
			<input id="qty_${accessorio.id}" type="number" min="0"  value="1" /> 
		</c:if> 
		<c:if test = "${quantitaNecessaria > 0}">
			 ${quantitaNecessaria}
		</c:if> 
	</td>
	
	<td>
  			
			<button id="btnAssociaAccessorio_${accessorio.id}" onClick="associaAccessorio('${accessorio.id}','${idArticolo}')" class="btn btn-success  customTooltip" title="Associa" <c:if test = "${quantitaNecessaria>0}">disabled="disabled"</c:if> ><i class="fa fa-check"></i></button> 
			<button id="btnDisAssociaAccessorio_${accessorio.id}" onClick="disassociaAccessorio('${accessorio.id}','${idArticolo}')" class="btn btn-danger  customTooltip" title="Disassocia" <c:if test = "${quantitaNecessaria==0}">disabled="disabled"</c:if> ><i class="fa fa-remove"> </i></button>

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	
     	$("#tipologia").select2({ width: '100%' });
     	$("#modtipologia").select2({ width: '100%' });
     	
    	table = $('#tabAccessori').DataTable({
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
    	
  	table.buttons().container().appendTo( '#tabAccessori_wrapper .col-sm-6:eq(1)');
  
  $('#tabAccessori thead th').each( function () {
      var title = $('#tabAccessori thead th').eq( $(this).index() - 1 ).text();

      $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
  } );

  // DataTable
	table = $('#tabAccessori').DataTable();
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
  	})
    	
    	
  	 $('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     });
    });
  </script>
