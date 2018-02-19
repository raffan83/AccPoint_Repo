<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.DotazioneDTO"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
      <h1>
        Lista Dotazioni

      </h1>
    </section>

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
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovaDotazione')">Nuova Dotazione</button><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 
 <th>Company</th>
 <th>Marca</th>
 <th>Modello</th>
 <th>Tipologia</th>
 <th>Matricola</th>
 <th>Targa</th>

 <th>Azioni</th>
 
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaDotazioni}" var="dotazione" varStatus="loop">

	 <tr role="row" id="${dotazione.id}-${loop.index}">

	<td>${dotazione.id}</td>
	<td>${dotazione.company.denominazione}</td>
	<td>${dotazione.marca}</td>
	<td>${dotazione.modello}</td>
	<td>${dotazione.tipologia.codice} - ${dotazione.tipologia.descrizione}</td>
	<td>${dotazione.matricola}</td>
	<td>${dotazione.targa}</td>

	
	<td>
<%-- 
	 <a href="#" onClick="modalModificaDotazioni('${dotazione.id}','${dotazione.marca}','${dotazione.modello}','${dotazione.tipologia.id}','${dotazione.matricola}','${dotazione.targa}','${dotazione.schedaTecnica}')" class="btn btn-warning "><i class="fa fa-edit"></i></a> 
 --%>
		<a href="#" onClick="modalEliminaDotazione('${dotazione.id}','${dotazione.modello}')" class="btn btn-danger "><i class="fa fa-remove"></i></a>
		<c:if test="${!empty fn:trim(dotazione.schedaTecnica)}">
			<button class="btn btn-default" onClick="scaricaSchedaTecnica(${dotazione.id},'${dotazione.schedaTecnica}')"><i class="fa fa-download"></i></button>
		</c:if>
	</td>
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
 





  


<div id="modalNuovaDotazione" class="modal  fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Dotazione</h4>
      </div>
      <form class="form-horizontal"  id="formNuovaDotazione">
       <div class="modal-body">
       
		<div class="nav-tabs-custom">
   
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovaDotazione">


            
        <div class="form-group">
          	<label for="marca" class="col-sm-2 control-label">Marca:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="marca" type="text" name="marca" value=""  required />
     		</div>
     	 
   		</div>
    		<div class="form-group">
          	<label for="modello" class="col-sm-2 control-label">Modello:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="modello" type="text" name="modello" value=""   required />
     		</div>
     	 
   		</div>
   	

   	<div class="form-group">
   	               <label for="tipologia" class="col-sm-2 control-label">Tipologia</label>
   	               <div class="col-sm-10">
                  <select name="tipologia" id="tipologia" data-placeholder="Seleziona Tipologia" required class="form-control tipologia" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
             <c:forEach items="${listaTipologieDotazioni}" var="tipologia">
                           <option value="${tipologia.id}">${tipologia.codice} - ${tipologia.descrizione}</option>                            
                     </c:forEach>
                     
                  </select>
                   </div>
        </div>

       
	 </div>
 		<div class="form-group" id="matricolaForm">
          	<label for="matricola" class="col-sm-2 control-label">Matricola:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="matricola" type="text" name="matricola" value=""  />
     		</div>
     	 
   		</div>
   		
   		<div class="form-group" id="targaForm">
          	<label for="targa" class="col-sm-2 control-label">Targa:</label>

         	<div class="col-sm-10">
         			<input class="form-control" id="targa" type="text" name="targa" value=""  />
     		</div>
     	 
   		</div>
   		
   		<div class="form-group" id="schedaTecnicaForm">
          	<label for="schedaTecnica" class="col-sm-2 control-label">Scheda Tecnica:</label>

         	<div class="col-sm-10">

         			<input type="file" class="form-control" id="schedaTecnica" type="text" name="schedaTecnica"/>
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



<div id="modalModificaDotazione" class="modal  fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Dotazione</h4>
      </div>
      <form class="form-horizontal"  id="formModificaDotazione">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
     
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="modificaDotazione">

         			<input class="form-control" id="modid" name="modid" value="" type="hidden" />
        
            
                <div class="form-group">
          <label for="modmarca" class="col-sm-2 control-label">Marca:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="modmarca" type="text" name="modmarca" value=""  />
     	</div>
    
   </div>
    


    <div class="form-group">
          <label for="modmodello" class="col-sm-2 control-label">Modello:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modmodello" type="text" name="modmodello" value=""  />
         
			
     	</div>
   </div>

       	<div class="form-group">
   	               <label for="user" class="col-sm-2 control-label">Tipologia</label>
   	               <div class="col-sm-10">
                  <select name="modtipologia" id="modtipologia" data-placeholder="Seleziona Tipologia" required class="form-control modtipologia" aria-hidden="true" data-live-search="true">
                    <option value=""></option>
             <c:forEach items="${listaTipologieDotazioni}" var="tipologia">
                           <option value="${tipologia.id}">${tipologia.codice} - ${tipologia.descrizione}</option>                            
                     </c:forEach>
                       
                  </select>
                   </div>
        </div>
	 </div>
	 
	   <div class="form-group" id="modFormMatricola">
          <label for="modmodello" class="col-sm-2 control-label">Matricola:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modmatricola" type="text" name="modmatricola" value=""  />
         
			
     	</div>
   </div>
	 	   <div class="form-group" id="modFormTarga">
          <label for="modtarga" class="col-sm-2 control-label">Targa:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modtarga" type="text" name="modtarga" value=""  />
         
			
     	</div>
   </div>
   
   <div class="form-group" id="schedaTecnicaForm">
          	<label for="schedaTecnica" class="col-sm-2 control-label">Scheda Tecnica:</label>

         	<div class="col-sm-10">

         			<input type="file" class="form-control" id="modschedaTecnica" type="text" name="modschedaTecnica"/>

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



<div id="modalEliminaDotazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare la dotazione <span id="dotazioneElimina"></span>
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaDotazione()">Elimina</button>
    </div>
  </div>
    </div>

</div>

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

<div id="prenotazioniModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Calendario Prenotazioni</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="prenotazioniModalContent">

        
        
  		 </div>
      
    </div>
     <div class="modal-footer">
    	<button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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



   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	
     	$("#tipologia").select2({ width: '100%' });
     	$("#modtipologia").select2({ width: '100%' });
     	
     	$("#matricolaForm").hide();
     	$("#targaForm").hide();
     	
     	$("#tipologia").change(function(e){
    		
      			if($(this).val() == '1'){
      				$("#matricolaForm").hide();
      				$("#targaForm").show();
      			}else{
      				$("#matricolaForm").show();
      				$("#targaForm").hide();
      			}

            
      });
     	
     	$("#modFormMatricola").hide();
     	$("#modFormTarga").hide();
     	
     	$("#modtipologia").change(function(e){
    		
      			if($(this).val() == '1'){
      				$("#modFormMatricola").hide();
      				$("#modFormTarga").show();
      			}else{
      				$("#modFormMatricola").show();
      				$("#modFormTarga").hide();
      			}

            
      });
     	
     	
     	
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
    	
  	table.buttons().container().appendTo( '#tabPM_wrapper .col-sm-6:eq(1)');
  
  $('#tabPM thead th').each( function () {
      var title = $('#tabPM thead th').eq( $(this).index() - 1 ).text();

      $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
  } );
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
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	})
    	
    	
    	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});

	$('#formNuovaDotazione').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovaDotazione();

	});
   
	$('#formModificaDotazione').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    modificaDotazione();

	}); 

	
	
	
	var indexDotazione;
    $('#tabPM').on( 'dblclick','tr', function () {   
           	 //$( "#tabPM tr" ).dblclick(function() {
     		var id = $(this).attr('id');
   
     		indexDotazione = id.split('-');
     		var row = table.row('#'+id);
     		datax = row.data();
         
   	    if(datax){
   	    		row.child.hide();
			
   	   	    	exploreModal("dettaglioPrenotazioneDotazione.do","idDotazione="+datax[0],"#prenotazioniModalContent");
   	    		$( "#prenotazioniModal" ).modal();
   	    		$('body').addClass('noScroll');
   	    }
   	    
   
   	    
  		
  		
  	
  		
     	});
	
	
	
	    });


	    var validator = $("#formNuovaDotazione").validate({
	    	showErrors: function(errorMap, errorList) {
	    	  
	    	    this.defaultShowErrors();
	    	  },
	    	  errorPlacement: function(error, element) {
	    		  $("#ulError").html("<span class='label label-danger'>Compilare tutti i campi obbligatori</span>");
	    		 },
	    		 
	    		    highlight: function(element) {
	    		        $(element).closest('.form-group').addClass('has-error');
	    		        $(element).closest('.ui-widget-content input').addClass('error');
	    		        
	    		    },
	    		    unhighlight: function(element) {
	    		        $(element).closest('.form-group').removeClass('has-error');
	    		        $(element).closest('.ui-widget-content input').removeClass('error');
	    		       
	    		    }
	    });

	  
	
	
	    $('#myModalError').on('hidden.bs.modal', function (e) {
			if($( "#myModalError" ).hasClass( "modal-success" )){
				callAction("listaDotazioni.do");
			}
 		
  		});

  </script>
</jsp:attribute> 
</t:layout>
  
 
