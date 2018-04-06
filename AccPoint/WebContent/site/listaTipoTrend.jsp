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
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoTipoTrend')" style="margin-bottom:30px">Nuova Tipologia Trend</button>
</div>
</div>
	<div class="row">
<div class="col-lg-12">
  <table id="tabTipoTrend" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
  <th>Descrizione</th>
   <th>Tipo Grafico</th>
    <td>Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaTipoTrend}" var="tipotrend" varStatus="loop">

	 <tr role="row" id="tabTipoTrendTr_${tipotrend.id}">

	<td>${tipotrend.id}</td>
 	<td>${tipotrend.descrizione}</td>
	<td>
<c:if test="${tipotrend.tipo_grafico == 1}"> Line </c:if>
<c:if test="${tipotrend.tipo_grafico == 2}"> Bar </c:if>
<c:if test="${tipotrend.tipo_grafico == 3}"> Horizontal Bar </c:if>
<c:if test="${tipotrend.tipo_grafico == 4}"> Pie </c:if>

	</td>
	
 	<td>
		
		<c:if test="${tipotrend.attivo}"> <c:set var="classAtt" value="btn-danger"></c:set> </c:if>
		<c:if test="${!tipotrend.attivo}"><c:set var="classAtt" value="btn-success"></c:set> </c:if>
		
		<a href="#" onClick="toggleTipoTrend(this,'${tipotrend.id}')" class="btn  ${classAtt} "> <c:if test="${tipotrend.attivo}"><i class="fa fa-remove"></i></c:if><c:if test="${!tipotrend.attivo}"><i class="fa fa-check"></i></c:if></a> 
		<a href="#" onClick="modalModificaTipoTrend('${tipotrend.id}','${tipotrend.descrizione}','${tipotrend.tipo_grafico}',${tipotrend.attivo})" class="btn btn-warning "><i class="fa fa-edit"></i></a>  

	</td>
	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
 </div>
</div>

<div id="modalNuovoTipoTrend" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Tipo Trend</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoTipoTrend">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
   
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoTrend">


            
                <div class="form-group">
          <label for="val" class="col-sm-2 control-label">Descrizione:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="descrizione" type="text" name="descrizione" value=""  required />
     	</div>
     	 
   </div>
    


    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">TipoGrafico:</label>

         <div class="col-sm-10">
         			
            <select class="form-control" id="tipoGrafico" name="tipoGrafico" required>
                      
                       <option></option>
               
                       <option value="1">Line</option>
                       <option value="2">Bar</option>
                       <option value="3">Horizontal Bar</option>
                       <option value="4">Pie</option>                 
                                            
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

<div id="modalModificaTipoTrend" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Tipo Trend</h4>
      </div>
      <form class="form-horizontal"  id="formModificaTipoTrend">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
   
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="modificaTipoTrend">

		<input class="form-control" id="idtipotrend" type="hidden" name="idtipotrend" value=""  required />
            
                <div class="form-group">
          <label for="descrizionemod" class="col-sm-2 control-label">Descrizione:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="descrizionemod" type="text" name="descrizionemod" value=""  required />
     	</div>
     	 
   </div>
    


    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">TipoGrafico:</label>

         <div class="col-sm-10">
         			
            <select class="form-control" id="tipoGraficomod" name="tipoGraficomod" required>
                                  
                       <option value="1">Line</option>
                       <option value="2">Bar</option>
                       <option value="3">Horizontal Bar</option>
                       <option value="4">Pie</option>                 
                                            
            </select>
         
			
     	</div>
   </div>
   
    <div class="form-group">
          <label for="nome" class="col-sm-2 control-label">Attivo:</label>

         <div class="col-sm-10">
         			
           <input type="checkbox" name="attivomod"  id="attivomod" value="false">

			
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
	 
	$("#tabTipoTrend").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabTipoTrend thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabTipoTrend thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    } );

	} );

  
    $(document).ready(function() {
   

    	
    	  $('#attivomod').iCheck({
    		    checkboxClass: 'icheckbox_minimal-blue',

    		    increaseArea: '20%' // optional
    		  });
    	  
    	  $('#attivomod').on('ifChecked', function (event){
    		    $(this).closest("input").attr('checked', true);       
    		    $(this).closest("input").attr('value', true);    
    		});
    		$('#attivomod').on('ifUnchecked', function (event) {
    		    $(this).closest("input").attr('checked', false);
    		    $(this).closest("input").attr('value', false);    
    		});
    	
    	tabTipoTrend = $('#tabTipoTrend').DataTable({
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
						   { responsivePriority: 1, targets: 0 }
  	                

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
    	
    	tabTipoTrend.buttons().container().appendTo( '#tabTipoTrend_wrapper .col-sm-6:eq(1)');
  
  
  $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
  // DataTable
	tabTipoTrend = $('#tabTipoTrend').DataTable();
  // Apply the search
  tabTipoTrend.columns().eq( 0 ).each( function ( colIdx ) {
      $( 'input', tabTipoTrend.column( colIdx ).header() ).on( 'keyup', function () {
    	  tabTipoTrend
              .column( colIdx )
              .search( this.value )
              .draw();
      } );
  } ); 
  tabTipoTrend.columns.adjust().draw();
    	

	$('#tabTipoTrend').on( 'page.dt', function () {
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
    	
	
	$('#formNuovoTipoTrend').on('submit',function(e){
	    e.preventDefault();
		nuovoTipoTrend();

	});
	$('#formModificaTipoTrend').on('submit',function(e){
	    e.preventDefault();
		modificaTipoTrend();

	});
	      
});


	  

  </script>

