
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

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);

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
      <h1>
        Lista Strumenti
        <small></small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
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
	 Lista ${descrizioneClienteStrumenti}
	<div class="box-tools pull-right">
		
		<!-- <button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button> -->

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">

 <c:if test="${utente.checkPermesso('INSERIMENTO_CAMPIONE')}"> <button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoCampione')">Nuovo Campione</button></c:if><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 						<th>ID</th>
 						<!-- <td>Azioni</td>		 -->		   
            	       		<th>Stato Strumento</th>		   
            		   		<th>Denominazione</th>
                       	<th>Codice Interno</th>
                       	<th>Cliente</th>
                       	<th>Sede</th>
                       	<th>Data Ultima Verifica</th>
                       	<th>Data Prossima Verifica</th>
                       	<th>Costurttore</th>
                       	<th>Modello</th>
                       	<th>Matricola</th>
                       	<th>Divisione</th>
                       	<th>Campo Misura</th>
                       	<th>Tipo Strumento</th>
                      	<th>Freq. Verifica</th>
                       	<th>Reparto</th>
                        <th>Tipo Rapporto</th>
                        <th>Utilizzatore</th>
                        <th>Luogo Verifica</th>
                        <th>Interpolazioone</th>
                        <th>Classificazione</th>
                        <th>Company</th>
                        <th>Data Modifica</th>
                        <th>Utente Modifica</th> 

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaStrumenti}" var="strumento" varStatus="loop">

	 <tr role="row" id="${campione.codice}-${loop.index}" class="customTooltip" title="Doppio Click per aprire il dettaglio del Campione">

	<td>${strumento.__id}</td>
	<td id="stato_${strumento.__id}">${strumento.stato_strumento.nome}</td>

   <td>${strumento.denominazione}</td>
                    	             <td>${strumento.codice_interno}</td>

                    	             <c:set var="idcliente">${strumento.id_cliente}</c:set>
                    	             
                    	             <td><c:out value="${listaClientiStrumenti[idcliente]}" /></td>

                    	             <c:set var="idSede">${strumento.id__sede_}</c:set>
                    	              
                    	             <td><c:out value="${listaSediStrumenti[idSede]}" /> </td>
                    	             
                    	             <td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${not empty strumento.scadenzaDTO.dataUltimaVerifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${strumento.scadenzaDTO.dataUltimaVerifica}" />
</c:if>
</c:if></td>

<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${not empty strumento.scadenzaDTO.dataProssimaVerifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${strumento.scadenzaDTO.dataProssimaVerifica}" />
</c:if>
</c:if></td>
             
                    	             <td>${strumento.costruttore}</td>
                    	             <td>${strumento.modello}</td>
                    	             <td>${strumento.matricola}</td>
                    	             <td>${strumento.risoluzione}</td>
                    	             <td>${strumento.campo_misura}</td>
                    	             <td>${strumento.tipo_strumento.nome}</td>

<td>
<c:if test="${not empty strumento.scadenzaDTO}">
<c:if test="${strumento.scadenzaDTO.freq_mesi != 0}">
    
         ${strumento.scadenzaDTO.freq_mesi} 
</c:if>
</c:if></td>


<td>
<c:if test="${not empty strumento.getScadenzaDTO()}">
<c:if test="${strumento.getScadenzaDTO().tipo_rapporto.noneRapporto != ''}">

    ${strumento.getScadenzaDTO().tipo_rapporto.noneRapporto} 

</c:if>
</c:if></td>
 <td>${strumento.utilizzatore}</td>
<td>
<c:if test="${not empty strumento.luogo}">
    ${strumento.luogo.descrizione} >
</c:if></td>
<td>
<c:if test="${not empty strumento.interpolazione}">
   ${strumento.interpolazione} 
</c:if></td>
 <td>${strumento.classificazione.descrizione}</td>
  <td>${strumento.company.denominazione}</td>
  <td>
<c:if test="${not empty strumento.dataModifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${strumento.dataModifica}" />
</c:if></td>
   <td>
<c:if test="${not empty strumento.userModifica}">
   ${strumento.userModifica}
</c:if></td>

<td>


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
 





 <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
      
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 

 
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
 
      </div>
    </div>
  </div>
</div>




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
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
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
 	      order:[[0, "desc"]],
 	      columnDefs: [
 					   { responsivePriority: 1, targets: 0 },
 	                   { responsivePriority: 3, targets: 2 },
 	                   { responsivePriority: 4, targets: 3 },
 	                   { responsivePriority: 2, targets: 6 },

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
 	   
 	  $('#tabPM').on( 'dblclick','tr', function () {

   		var id = $(this).attr('id');
   		
   		var row = table.row('#'+id);
   		datax = row.data();

 	   if(datax){
  	    	row.child.hide();
  	    	exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
  	    	$( "#myModal" ).modal();
  	    	//$('body').addClass('noScroll');
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
 	   
 	   
   	});  
   	    
   	    
 		



 
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
 	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
 		   var datepicker = $.fn.datepicker.noConflict();
 		   $.fn.bootstrapDP = datepicker;
 		}

 	$('.datepicker').bootstrapDP({
 		format: "dd/mm/yyyy",
 	    startDate: '-3d'
 	});
 	 
 	

	$('#tabPM').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
 	
 	
 	
 	
 	var today = moment();


 	$("#dataUltimaVerifica").attr("value", today.format('DD/MM/YYYY'));
 	
 	$( "#ref_tipo_rapporto" ).change(function() {

 		  if(this.value == 7201){
 			  $("#freq_mesi").attr("disabled", false);
 			  $("#freq_mesi").attr("required", true);
  			  $("#dataProssimaVerifica").attr("required", true);
  			  $("#freq_mesi").val("");
  			  $("#dataProssimaVerifica").val("");

 		  }else{
 			  $("#freq_mesi").attr("disabled", true);
 			  $("#freq_mesi").attr("required", false);
  			  $("#dataProssimaVerifica").attr("required", false);
  			  $("#freq_mesi").val("");
  			  $("#dataProssimaVerifica").val("");
 		  }
  		});
 	$( "#freq_mesi" ).change(function() {

 		  if(this.value > 0){

 			  var futureMonth = moment(today).add(this.value, 'M');
 			  var futureMonthEnd = moment(futureMonth).endOf('month');
 			 
  
 			  $("#dataProssimaVerifica").val(futureMonth.format('DD/MM/YYYY'));
 			  $("#dataProssimaVerifica").attr("required", true);

 		  }else{
 			  $("#freq_mesi").val("");
 		  }
 		});
 	 $('.customTooltip').tooltipster({
 	        theme: 'tooltipster-light'
 	    });
 	
  });

  </script>
</jsp:attribute> 
</t:layout>
  
 
 
 
 