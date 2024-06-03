<%@page import="it.portaleSTI.DTO.MisuraDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
	%>
	
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
       Lista Ore Scaricate
      <!--   <small>Fai doppio click per entrare nel dettaglio</small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">


          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Ore Scaricate
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">


<div class="row">
	<div class="col-xs-12">
	<label>Escludi Ore Previste &nbsp;</label>
<input type="checkbox" id="excludeFilter"><br>
</div>
</div><br>

<div class="row">
	<div class="col-xs-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>Username</th>
 <th>ID Commessa</th>
 <th>Oggetto Commessa</th>
 <th>Cliente</th>
  <th>Data Commessa</th>
 <th>Fase</th>
<th>Milestone</th>
 <th>Ore Previste</th> 
  <th>Ore Scaricate</th>
  <th>Scostamento</th>
  
  <th>Glb Fase</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaOre}" var="ore" varStatus="loop">

<c:if test="${ore.duplicato == 1 }">
		 <tr role="row" style="background-color:#ffff99">
</c:if>
<c:if test="${ore.duplicato != 1 }">
		 <tr role="row" >
</c:if>
	<td>${ore.username}</td>
	<td>${ore.id_commessa}</td>
	<td>${ore.oggetto_commessa}</td>
	<td>${ore.cliente}</td>
	<td> <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${ore.data_commessa}" /></td>
	<td>${ore.fase}</td>
	<td>${ore.milestone }</td>
	<td>${ore.ore_previste}</td>
	<td>${ore.ore_scaricate}</td>
	<td><fmt:formatNumber value="${ore.scostamento}"  minFractionDigits="2" maxFractionDigits="2"></fmt:formatNumber></td>

	<td>${ore.glb_fase }</td>


	</tr>
	 
	</c:forEach>
 
	
 </tbody>
 </table> 
  <div class="row">
 <div class="col-xs-6"></div>
 <div class="col-xs-2">
 <label>Tot. Ore Previste</label>
 <input class="form-control" readonly type="text" id="tot_previste" style="font-weight:bold;">
 </div>
 <div class="col-xs-2">
 <label>Tot. Ore Scaricate</label>
 <input class="form-control" readonly type="text" id="tot_scaricate" style="font-weight:bold;">
 </div>

 
 </div> 
 
 </div>
 </div>
</div>
</div>
</div>
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        </div>
        </div>
        <!-- /.col -->
 
 
  <div id="myModalModificaStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">


<div class="tab-pane" id="modifica">
        
            <!-- /.tab-content -->
          </div>
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div> 










</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<style>
    .global-column {

        hidden: ${global != null ?  'table-cell' : 'hidden'};
    }
</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript">



   </script>

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

	

	 function sommaDati(){
		 
		 var table = $('#tabPM').DataTable();
		 
		 var tot_previste = 0;
		 var tot_scaricate = 0;
		 
		 var data = table.rows({ search: 'applied' }).data();
		 
		 var fasi = [];
		 for(var i = 0; i<data.length; i++){
			 
			 if(!fasi.includes(data[i][10]) && data[i][8]!=null && data[i][8]!=''){
				 fasi.push(data[i][10]);		
				 tot_previste = tot_previste + parseFloat(data[i][7]);
			 }
			 
			 if(data[i][8]!=null && data[i][8]!=''){
				 tot_scaricate = tot_scaricate  + parseFloat(data[i][8]);	 
			 }
			 

			 
			 
		 }
		 
		 $('#tot_previste').val(tot_previste.toFixed(2));
		 $('#tot_scaricate').val(tot_scaricate.toFixed(2));
		 
		 if(tot_previste>=tot_scaricate){
			 $('#tot_previste').css("background-color", "#5DEB4F")
			 $('#tot_scaricate').css("background-color", "#5DEB4F")
		 }else{
			 $('#tot_previste').css("background-color", "#EE894F")
			 $('#tot_scaricate').css("background-color", "#EE894F")
		 }
		 
	 }
	 

	
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
  	    		order: [[ 2, "desc" ]],
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	      stateSave: true,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 1 }
	
						   
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
    	
    	
    
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');

     	    



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
          sommaDati();
      } );
  } ); 

    	
	
	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    
 
    });
	
	if("${global}"!=null && "${global}"!=""){
		table.column(10).visible(true);
	}else{
		table.column(10).visible(false);	
	}
	
	
	
	
	
	$('input:checkbox').on('ifToggled', function() {
		
		$('#excludeFilter').on('ifChecked', function(event){
			 var searchText = "0.0";
		        table.search('').draw(); // Resetta la ricerca
		        $.fn.dataTable.ext.search.push(
		            function(settings, data, dataIndex) {
		                // Controlla se uno dei valori nella riga corrisponde esattamente al testo da escludere
		                for (var i = 0; i < data.length; i++) {
		                    if (data[7].toLowerCase().trim() === searchText) {
		                        return false;
		                    }
		                }
		                return true;
		            }
		        );
		        table.draw();
		        $.fn.dataTable.ext.search.pop(); // Rimuovi il filtro personalizzato dopo la ricerca
		        
		        sommaDati()
		
		});
		
		$('#excludeFilter').on('ifUnchecked', function(event) {
			
			var searchText = "";
	        table.search('').draw(); // Resetta la ricerca
	        $.fn.dataTable.ext.search.push(
	            function(settings, data, dataIndex) {
	                // Controlla se uno dei valori nella riga corrisponde esattamente al testo da escludere
	                for (var i = 0; i < data.length; i++) {
	                    if (data[7].toLowerCase().trim() === searchText) {
	                        return false;
	                    }
	                }
	                return true;
	            }
	        );
	        table.draw();
	        $.fn.dataTable.ext.search.pop(); // Rimuovi il filtro personalizzato dopo la ricerca
	        
	        sommaDati()
		
		});
		
			})
	
	
	

    $('#excludeFilter').on('keyup', function() {
        var searchText = this.value.toLowerCase().trim();
        table.search('').draw(); // Resetta la ricerca
        $.fn.dataTable.ext.search.push(
            function(settings, data, dataIndex) {
                // Controlla se uno dei valori nella riga corrisponde esattamente al testo da escludere
                for (var i = 0; i < data.length; i++) {
                    if (data[7].toLowerCase().trim() === searchText) {
                        return false;
                    }
                }
                return true;
            }
        );
        table.draw();
        $.fn.dataTable.ext.search.pop(); // Rimuovi il filtro personalizzato dopo la ricerca
        
        sommaDati()
    });
	
  	table.columns.adjust().draw();
});
    
    
    

  </script>
</jsp:attribute> 
</t:layout>
  
 

 