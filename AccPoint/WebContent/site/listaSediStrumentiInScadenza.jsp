
<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.StatoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>

<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>




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
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">


</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 						<th>Clienti / Sedi</th>

            	       <%-- <th>Cliente - Sede</th>		    --%>
            		   <th>Numero Strumenti</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaStrumentiPerSede}" var="sedi" varStatus="loop">

	 <tr role="row" id="${loop.index}">
	
	
	
	
 	<c:if test = "${fn:contains(sedi.key, 's_')}">
 	
 	
 		<c:set var="name" value="${fn:substringAfter(sedi.key, 's_')}"/>
 		<%-- <td>id Sede: ${name}</td> --%>
	 
		<td > 
        <c:out value="${listaSediStrumenti[name]}"/>
        
        	</td>
		<td class="centered"><button class="btn btn-success" onClick="listaStrumentiSede(${name})">${fn:length(sedi.value)}</button></td>
	
	
      </c:if>
      
      <c:if test = "${fn:contains(sedi.key, 'c_')}">
      
      	<c:set var="name" value="${fn:substringAfter(sedi.key, 'c_')}"/>
 		<%-- <td>id Cliente: ${name}</td> --%>
	 
		<td > 
        <c:out value="${listaClientiStrumenti[name]}"/>
        
        	</td>
		<td class="centered"><button class="btn btn-success" onClick="listaStrumentiCliente(${name})">${fn:length(sedi.value)}</button></td>
	
      </c:if>
	

  


	</tr>
	
	 
	</c:forEach>
 
	
 </tbody>
 </table>  
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
        <!-- /.col -->
 





 <%--  <div id="myModal" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettagli Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="dettaglioTab">Dettaglio Campione</a></li>
              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false"   id="valoriTab">Valori Campione</a></li>
               <li class=""><a href="#certificati" data-toggle="tab" aria-expanded="false"   id="certificatiTab">Lista Certificati Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false"   id="prenotazioneTab">Controlla Prenotazione</a></li>
               <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false"   id="aggiornaTab">Aggiornamento Campione</a></li></c:if>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="valori">
                

         
			 </div>

              <!-- /.tab-pane -->

			<div class="tab-pane table-responsive" id="certificati">
                

         
			 </div>

              <!-- /.tab-pane -->
              
              <div class="tab-pane" id="prenotazione">
              

              </div>
              <!-- /.tab-pane -->
              <c:if test="${utente.checkPermesso('MODIFICA_CAMPIONE')}"> <div class="tab-pane" id="aggiorna">
              

              </div></c:if>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>

 --%>


<!-- <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
    </div>
    
  </div>
    </div>

</div> -->

<div id="modalEliminaCertificatoCampione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare il certificato?
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaCertificatoCampione()">Elimina</button>
    </div>
  </div>
    </div>

</div>




	<script src="plugins/jquery.appendGrid/jquery.appendGrid-1.6.3.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>


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


  $(function(){
 	
  
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
 	      order:[[0, "asc"]],
 	      columnDefs: [
 					   { responsivePriority: 1, targets: 0 },

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
   		datax = row.data();

 	   if(datax){
  	    	row.child.hide();
  	    	exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
  	    	$( "#myModal" ).modal();
  	    	$('body').addClass('noScroll');
  	    }
 	   
 	   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


        	var  contentID = e.target.id;


        	if(contentID == "dettaglioTab"){
        		exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
        	}
        	if(contentID == "misureTab"){
        		exploreModal("strumentiMisurati.do?action=ls&id="+datax[0],"","#misure")
        	}
      
        	
        	
        	

  		});
 	   
 	   
   	}); */
   	    
   	    
 		



 
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

 
 
 
 