
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
 						<th>ID</th>

            	       <th>Cliente - Sede</th>		   
            		   <th>Numero Strumenti</th>


 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaStrumentiPerSede}" var="sedi" varStatus="loop">

	 <tr role="row" id="${loop.index}">

	<td>${sedi.key}</td>
	<td >---</td>
	<td class="centered"><button class="btn btn-success" href="#">${fn:length(sedi.value)}</button></td>
  


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


<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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

</div>

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


  $(function(){
 	
  
 	 table = $('#tabPM').DataTable({
 	      paging: true, 
 	      ordering: true,
 	      info: true, 
 	      searchable: false, 
 	      targets: 0,
 	      responsive: true,
 	      scrollX: false,
 	      order:[[0, "desc"]],
 	      columnDefs: [
 					   { responsivePriority: 1, targets: 0 },
 	                   { responsivePriority: 3, targets: 2 }
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
   	    
   	    
 		



 $('#tabPM thead th').each( function () {
    var title = $('#tabPM thead th').eq( $(this).index() ).text();
    $(this).append( '<div><input style="width:100%" type="text" /></div>');
 } );

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

 
 
 
 