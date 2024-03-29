<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%

	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");



	//System.out.println("***"+listaUtentiJson);	
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
        Lista Company

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
	 Lista
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-lg-12">
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovaCompany')">Nuova Company</button><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Denominazione</th>
 <th>Partita Iva</th>
 <th>Indirizzo</th>
 <th>Comune</th>
 <th>Cap</th>
 <th>e-mail</th>
 <th>Telefono</th>
 <th>Codice Affiliato</th>
  <th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCompany}" var="company" varStatus="loop">

	 <tr role="row" id="${company.id}-${loop.index}">

	<td>${company.id}</td>
	<td>${company.denominazione}</td>
	<td>${company.pIva}</td>
	<td>${company.indirizzo}</td>
	<td>${company.comune}</td>
	<td>${company.cap}</td>
	<td>${company.mail}</td>
	<td>${company.telefono}</td>
	<td>${company.codAffiliato}</td>
	<td>

		<a href="#" onClick="modalModificaCompany('${company.id}','${company.denominazione}','${company.pIva}','${company.indirizzo}','${company.comune}','${company.cap}','${company.mail}','${company.telefono}','${company.codAffiliato}','${company.email_pec}','${company.host_pec }','${company.porta_pec }')" class="btn btn-warning "><i class="fa fa-edit"></i></a> 
		<%-- <a href="#" onClick="modalEliminaCompany('${company.id}','${company.denominazione}')" class="btn btn-danger "><i class="fa fa-remove"></i></a>	 --%>

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
</div>
</div>
<div id="modalNuovaCompany" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
       
       <div class="row">
            <div class="col-sm-6">
      
        </div>
          <div class="col-sm-6">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      
         
        </div>
        
        </div>
      </div>
      <form class="form-horizontal"  id="formNuovaCompany">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
     
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovaCompany">


            <div class="row">
            <div class="col-sm-6">
              <h4 class="modal-title" id="myModalLabel">Nuova Company</h4><br>
              
                              <div class="form-group">
          <label for="denominazione" class="col-sm-2 control-label">ID:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="id" type="number" step="1" name="id" value="" min = "0" required />
     	</div>
     
   </div>
              
              
                <div class="form-group">
          <label for="denominazione" class="col-sm-2 control-label">Denominazione:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="denominazione" type="text" name="denominazione" value="" required />
     	</div>
     
   </div>
    


    <div class="form-group">
          <label for="pIva" class="col-sm-2 control-label">Partita Iva:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="pIva" type="text" name="pIva" value="" required />
	
     	</div>
   </div>

    
    <div class="form-group">
        <label for="indirizzo" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="indirizzo" type="text" name="indirizzo"  value="" required autocomplete="new-password"/>
    </div>
    </div>
    <div class="form-group">
        <label for="comune" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="comune" type="text" name="comune"  value="" required autocomplete="new-password"/>
    </div>
    </div>
    <div class="form-group">
        <label for="cap" class="col-sm-2 control-label">CAP:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="cap" type="text" name="cap"  value="" required autocomplete="new-password"/>
    </div>
    </div>
    <div class="form-group">
        <label for="mail" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="email" id="mail" type="text" name="mail"  value="" required autocomplete="new-password"/>
    </div>
    </div>
     <div class="form-group">
        <label for="telefono" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="telefono" type="text" name="telefono"  value="" required autocomplete="new-password"/>
    </div>
     </div>
     <div class="form-group">
        <label for="codAffiliato" class="col-sm-2 control-label">Codice Affiliato:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="codAffiliato" type="text" name="codAffiliato"  value="" required autocomplete="new-password"/>
    </div>
     </div>
     
	</div>
	<div class="col-sm-6">
	  <h4 class="modal-title" id="myModalLabel">Configurazione PEC</h4><br>
	     <div class="form-group">
        <label for="email_pec" class="col-sm-2 control-label">Email PEC:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="email_pec" type="text" name="email_pec"  value="" autocomplete="new-password" />
    </div>
     </div>
     
     	     <div class="form-group">
        <label for="password_pec" class="col-sm-2 control-label">Password:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="password_pec" type="password" name="password_pec"  value="" autocomplete="new-password"/>
    </div>
     </div>
     
          	     <div class="form-group">
        <label for="host_pec" class="col-sm-2 control-label">Host:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="host_pec" type="text" name="host_pec"  value="" />
    </div>
     </div>
     
	           <div class="form-group">
        <label for="porta_pec" class="col-sm-2 control-label">Porta:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="porta_pec" type="text" name="porta_pec"  value="" />
    </div>
     </div>
	
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
			<span id="ulError" class="pull-left"></span><button type="submit" class="btn btn-danger"  id="btn_save" >Salva</button>
      </div>
        </form>
    </div>
  </div>
</div>


<div id="modalModificaCompany" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
     
      </div>
      <form class="form-horizontal"  id="formModificaCompany">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
  

            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="modificaCompany">

         			 <input class="form-control" id="modid" name="modid" value="" type="hidden" /> 
        
           <div class="row">
            <div class="col-sm-6">
              <h4 class="modal-title" id="myModalLabel">Modifica Company</h4><br>
            
            
            
                <div class="form-group">
          <label for="moddenominazione" class="col-sm-2 control-label">Denominazione:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="moddenominazione" type="text" name="moddenominazione" value=""  />
     	</div>
     	 
   </div>
    


    <div class="form-group">
          <label for="modpIva" class="col-sm-2 control-label">Partita IVA:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="modpIva" type="text" name="modpIva" value=""  />
         
			
     	</div>
   </div>
    
    <div class="form-group">
        <label for="modindirizzo" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modindirizzo" type="text" name="modindirizzo"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modcomune" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcomune" type="text" name="modcomune"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modcap" class="col-sm-2 control-label">CAP:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcap" type="text" name="modcap"  value="" />
    </div>
    </div>
    <div class="form-group">
        <label for="modemail" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="email" id="modmail" type="text" name="modmail"  value="" />
    </div>
    </div>
     <div class="form-group">
        <label for="modtelefono" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modtelefono" type="text" name="modtelefono"  value="" />
    </div>
     </div>
     <div class="form-group">
        <label for="modtcodAffiliato" class="col-sm-2 control-label">Codice Affiliato:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modcodAffiliato" type="text" name="modcodAffiliato"  value="" />
    </div>
     </div>
      
       </div>
       
       	<div class="col-sm-6">
	  <h4 class="modal-title" id="myModalLabel">Configurazione PEC</h4><br>
	     <div class="form-group">
        <label for="mod_email_pec" class="col-sm-2 control-label">Email PEC:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="mod_email_pec" type="text" name="mod_email_pec"  value="" autocomplete="new-password"/>
    </div>
     </div>
     
     	     <div class="form-group">
        <label for="mod_password_pec" class="col-sm-2 control-label">Password:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="mod_password_pec" type="password" name="mod_password_pec"  value="" autocomplete="new-password"/>
    </div>
     </div>
     
          	     <div class="form-group">
        <label for="mod_host_pec" class="col-sm-2 control-label">Host:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="mod_host_pec" type="text" name="mod_host_pec"  value="" />
    </div>
     </div>
     
	           <div class="form-group">
        <label for="mod_porta_pec" class="col-sm-2 control-label">Porta:</label>
        <div class="col-sm-10">
                      <input class="form-control " id="mod_porta_pec" type="text" name="mod_porta_pec"  value="" />
    </div>
     </div>
	
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

<div id="modalEliminaCompany" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="">
		     
			<input class="form-control" id="idElimina" name="idElimina" value="" type="hidden" />
		
			Sei Sicuro di voler eliminare la company <span id="denominazioneElimina"></span>
        
        
  		 </div>
      
    </div>
    <div class="modal-footer">
    	<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Annulla</button>
    	<button type="button" class="btn btn-danger" onClick="eliminaCompany()">Elimina</button>
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
 
  
  $('#id').focusout(function(){
		$('#id').css('border', '1px solid #d2d6de');
		$('#label_id').hide();
		$('#btn_save').attr('disabled', false);
		$("#ulError").html("");
		 $('#tabPM tbody tr').each(function(){		 
				 var td = $(this).find('td').eq(0);
				if(td!=null && td[0].innerText== $('#id').val()){
					$('#id').css('border', '1px solid #f00');
					$('#label_id').show();
					 $("#ulError").html("<span class='label label-danger'>ID gi� inserito!</span>");
					$('#btn_save').attr('disabled', true);
				}
		 });
	});
  

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
	        var title = $('#tabPM thead th').eq( $(this).index() -1).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    } );

	} );

  
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
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
  	    stateSave: true,
  	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 },
  	                   { responsivePriority: 4, targets: 6 }
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

	$('#formNuovaCompany').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovaCompany();

	});
   
	$('#formModificaCompany').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    modificaCompany();

	}); 
	      
	    });


	    var validator = $("#formNuovaCompany").validate({
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
				 pleaseWaitDiv = $('#pleaseWaitDialog');
				  pleaseWaitDiv.modal();
				callAction("listaCompany.do");
			}
 		
  		});

  </script>
</jsp:attribute> 
</t:layout>
  
 
