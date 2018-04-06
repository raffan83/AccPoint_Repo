<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%



	%>
	<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoTrend')" style="margin-bottom:30px">Nuovo Trend</button>
</div>
</div>
	<div class="row">
<div class="col-lg-12">
  <table id="tabTrend" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Data | Assex</th>
 <th>Valore</th>
  <th>Company</th>
  <th>Tipo Trend</th>
  <th>Tipo Grafico</th>
  <td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaTrend}" var="trend" varStatus="loop">

	 <tr role="row" id="tabTrendTr_${trend.id}">

	<td>${trend.id}</td>
	<td> 	<fmt:formatDate pattern="dd/MM/yyyy" value="${trend.data}" /> ${trend.asse_x}</td>
	<td>${trend.val}</td>
	<td>${trend.company.denominazione}</td>
	<td>${trend.tipoTrend.descrizione}</td>
	<td>
<c:if test="${trend.tipoTrend.tipo_grafico == 1}"> Line </c:if>
<c:if test="${trend.tipoTrend.tipo_grafico == 2}"> Bar </c:if>
<c:if test="${trend.tipoTrend.tipo_grafico == 3}"> Horizontal Bar </c:if>
<c:if test="${trend.tipoTrend.tipo_grafico == 4}"> Pie </c:if>
	</td>
	<td>
		
		
		
		<%-- 	<a href="#" onClick="modalModificaTrend('${trend.id}','${trend.data}','${trend.val}','${trend.company.id}','${trend.tipoTrend.id}')" class="btn btn-warning "><i class="fa fa-edit"></i></a>  --%>
		<a href="#" onClick="modalEliminaTrend('${trend.id}')" class="btn btn-danger "><i class="fa fa-remove"></i></a> 

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>




<div id="modalNuovoTrend" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Trend</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoTrend">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
   
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoTrend">


            
                <div class="form-group">
          <label for="val" class="col-sm-2 control-label">Valore:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="val" type="number" name="val" value=""  required />
     	</div>
     	 
   </div>
    


    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Data:</label>

         <div class="col-sm-4">
         			<input class="form-control valtrendgroup" id="data" type="text" name="data" value=""/>
         
			
     	</div>
 			<label for="nome" class="col-sm-1 control-label">Oppure</label>
          <label for="nome" class="col-sm-1 control-label">Valore asse X:</label>

         <div class="col-sm-4">
         			<input class="form-control valtrendgroup" id="assex" type="text" name="assex" value=""/>
         
			
     	</div>
   </div>
   
      <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Tipo Trend:</label>

         <div class="col-sm-10">

            <select class="form-control" id="tipoTrend" name="tipoTrend" required>
                      
                       <option></option>
                       <c:forEach items="${listaTipoTrend}" var="tipotrend">
                       	 <option value="${tipotrend.id}">${tipotrend.descrizione}</option>
                       </c:forEach>
                                          
                                            
            </select>
			
     	</div>
     

     	
   </div>

   
       
	 </div>

              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>




	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>

		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"></script>
			<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/additional-methods.min.js"></script>
	

<script type="text/javascript">



   </script>

  <script type="text/javascript">


	var columsDatatables = [];
	 
	$("#tabTrend").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabTrend thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabTrend thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} );

    $(document).ready(function() {

    	tabTrend = $('#tabTrend').DataTable({
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
    	
    	tabTrend.buttons().container().appendTo( '#tabTrend_wrapper .col-sm-6:eq(1)');
  
 
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tabTrend = $('#tabTrend').DataTable();
  // Apply the search
  tabTrend.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tabTrend.column( colIdx ).header() ).on( 'keyup', function () {
    	  tabTrend
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tabTrend.columns.adjust().draw();
    	

	$('#tabTrend').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})

  	 $('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     });
    	
	$( "#data" ).datepicker({
        format: 'dd/mm/yyyy',

    });
	$('#formNuovoTrend').on('submit',function(e){
	    e.preventDefault();
		nuovoTrend();

	});
	$('#formNuovoTrend').validate({
		 rules: {
		    data: {
		    		require_from_group: [1, ".valtrendgroup"]
		    },
		    assex: {
		    		require_from_group: [1, ".valtrendgroup"]
		    }
		} 
	});
	      
});


	  

  </script>

