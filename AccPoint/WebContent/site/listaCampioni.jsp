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
 
	ArrayList<CampioneDTO> listaCampioniarr =(ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");



	Gson gson = new Gson();
	JsonArray listaCampioniJson = gson.toJsonTree(listaCampioniarr).getAsJsonArray();
	request.setAttribute("listaCampioniJson", listaCampioniJson);
	request.setAttribute("utente", utente);


	System.out.println("***"+listaCampioniJson);	
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
        Lista Campioni
        <small>Fai doppio click per entrare nel dettaglio</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          <button class="btn btn-info" onclick="callAction('listaCampioni.do?p=mCMP');">I miei Campioni</button>
          <button class="btn btn-info" onclick="callAction('listaCampioni.do');">Tutti i Campioni</button>
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
<button class="btn btn-primary" onClick="nuovoInterventoFromModal('#modalNuovoCampione')">Nuovo Campione</button><div id="errorMsg" ></div>
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Proprietario</th>
 <th>Utilizzatore</th>
 <th>Nome</th>
 <th>Tipo Campione</th>
 <th>Codice</th>
 <th>Costruttore</th>
 <th>Descrizione</th>
 <th>Data Verifica</th>
 <th>Data Scadenza</th>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${listaCampioni}" var="campione" varStatus="loop">

	 <tr role="row" id="${campione.codice}-${loop.index}">

	<td>${campione.id}</td>
	<td>${campione.company.denominazione}</td>
	<td>${campione.company_utilizzatore.denominazione}</td>
	<td>${campione.nome}</td>
	<td>${campione.tipo_campione.nome}</td>
	<td>${campione.codice}</td>
	<td>${campione.costruttore}</td>
	<td>${campione.descrizione}</td>

<td>
<c:if test="${not empty campione.dataVerifica}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataVerifica}" />
</c:if></td>
<td>
<c:if test="${not empty campione.dataScadenza}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${campione.dataScadenza}" />
</c:if></td>
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
        <h4 class="modal-title" id="myModalLabel">Dettagli Campione</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true"   id="dettaglioTab">Dettaglio Campione</a></li>
              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false"   id="valoriTab">Valori Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false"   id="prenotazioneTab">Controlla Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false"   id="aggiornaTab">Aggiornamento Campione</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane table-responsive" id="valori">
                

         
			 </div>

              <!-- /.tab-pane -->

              <div class="tab-pane" id="prenotazione">
              

              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="aggiorna">
              

              </div>
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


<div id="myModalPrenotazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Prenotazione</h4>
      </div>
       <div class="modal-body" id="myModalPrenotazioneContent" >

      <div class="form-group">

                  <textarea class="form-control" rows="3" id="noteApp" placeholder="Entra una nota ..."></textarea>
                </div>
        
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="prenotazioneFromModal()"  >Prenota</button>
        <button type="button" class="btn btn-danger"onclick="$(myModalPrenotazione).modal('hide');"   >Annulla</button>
      </div>
    </div>
  </div>
</div>


<div id="modalNuovoCampione" class="modal  modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Campione</h4>
      </div>
      <form class="form-horizontal"  id="formNuovoCampione">
       <div class="modal-body">
       
<div class="nav-tabs-custom">
        <!--     <ul id="mainTabs" class="nav nav-tabs">
              <li class="active"><a href="#nuovoCampione" data-toggle="tab" aria-expanded="true"   id="nuovoCampioneTab">Dettaglio Campione</a></li>
              <li class=""><a href="#nuoviValori" data-toggle="tab" aria-expanded="false"   id="nuoviValoriTab">Valori Campione</a></li>

            </ul> -->
            <div class="tab-content">
              <div class="tab-pane  table-responsive active" id="nuovoCampione">


        
              

    <div class="form-group">
          <label for="inputEmail" class="col-sm-2 control-label">Proprietario:</label>

         <div class="col-sm-10">
         			<input class="form-control" id="proprietario" type="text" name="proprietario" disabled="disabled" value="${usrCompany.denominazione}" />
         
			
     	</div>
   </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Nome:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="nome" type="text" name="nome"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Campione:</label>
        <div class="col-sm-10">
                     
					   <select class="form-control required" id="tipoCampione" name="tipoCampione" required>
                       					<option value="">Seleziona un Tipo Campione</option>
                                            <c:forEach items="${listaTipoCampione}" var="cmp" varStatus="loop">

 												<option value="${cmp.id}">${cmp.nome}</option>
	 
											</c:forEach>
                        
                                            
                      </select>
                      
                      
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Codice:</label>
        <div class="col-sm-10">
                      <input class="form-control required" type="controllocodicecampione" id="codice" type="text" name="codice" value="" required/>
                      <span id="codiceError" class="help-block label label-danger"></span>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Matricola:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="matricola" type="text" name="matricola"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Descrizione:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="descrizione" type="text" name="descrizione"  value="" required/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Costruttore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="costruttore" type="text" name="costruttore"  value="" required/>
    </div>
       </div>
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Modello:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="modello" type="text" name="modello"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Interpolazione:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="interpolazione" type="number" name="interpolazione"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Frequenza Taratura:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="freqTaratura" type="number" name="freqTaratura"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Stato Campione:</label>
        <div class="col-sm-10">

                        <select class="form-control required" id="statoCampione" name="statoCampione" required>
                      					<option value="">Selezionare Stato</option>
	                                    <option value="S">In Servizio</option>
	 									<option value="N">Furoi Servizio</option>
                            	          
                      </select>
                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataVerifica" type="text" name="dataVerifica"  required value="" data-date-format="dd/mm/yyyy"/>

    </div>
       </div> 
       
<!--          <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Scadenza:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataScadenza" type="text" name="dataScadenza"  datepicker required value=""  data-date-format="dd/mm/yyyy"/>                      
    </div>
       </div>  -->
       
<!--          <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Tipo Verifica:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="tipoVerifica" type="text" name="tipoVerifica"  maxlength="1" value="" required/>
                      
    </div>
       </div>  -->
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Certificato:</label>
        <div class="col-sm-10">


                        <input type="file" class="form-control" id="certificato" type="text" name="certificato" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Numero Certificato:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="numeroCerificato" type="text" name="numeroCerificato"  value="" required/>
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Utilizzatore:</label>
        <div class="col-sm-10">
                      <input class="form-control required" id="utilizzatore" type="text" name="utilizzatore"  value="" required/>
    </div>
       </div> 
       
<!--          <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Inizio:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataInizio" type="text" name="dataInizio" datepicker  value="" data-date-format="dd/mm/yyyy" required/>

                      
    </div>
       </div> 
       
         <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Data Fine:</label>
        <div class="col-sm-10">
                      <input class="form-control datepicker required" id="dataFine" type="text" name="dataFine"  value=""datepicker  data-date-format="dd/mm/yyyy" required/>

                      
    </div>
       </div>  -->
       

<!--    </form> -->
   
    		<!-- 	</div> 

              /.tab-pane
              <div class="tab-pane table-responsive" id="nuoviValori"> -->
                
 
<!--  <form action="" method="post" id="formAppGrid"> -->

<table class="table table-bordered table-hover dataTable table-striped no-footer dtr-inline" id="tblAppendGrid">
</table>


 			


    		
    		
        
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

var listaStrumenti = ${listaCampioniJson};

   </script>

  <script type="text/javascript">

  
    $(document).ready(function() {
    

    	

    	table = $('#tabPM').DataTable({
  	      paging: true, 
  	      ordering: true,
  	      info: true, 
  	      searchable: false, 
  	      targets: 0,
  	      responsive: true,
  	      scrollX: false,
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
 
    $('#tabPM').on( 'dblclick','tr', function () {   
           	 //$( "#tabPM tr" ).dblclick(function() {
     		var id = $(this).attr('id');
   
     		var indexCampione = id.split('-');
     		var row = table.row('#'+id);
     		datax = row.data();
         
   	    if(datax){
   	    	row.child.hide();
   	    	exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
   	    	$( "#myModal" ).modal();
   	    	$('body').addClass('noScroll');
   	    }
   	    
   	 	campioneSelected = listaStrumenti[indexCampione[1]];

		 if(listaStrumenti[indexCampione[1]].company.id != '${utente.idCompany}')
	     {
			 
			 $('#aggiornaTab').hide();
			
		 }else{
			 $('#aggiornaTab').show();

		 }
   	    
   	    
  		
  		$('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


        	var  contentID = e.target.id;

        	
        	if(contentID == "dettaglioTab"){
        		exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
        	}
        	if(contentID == "valoriTab"){
        		exploreModal("valoriCampione.do","idCamp="+datax[0],"#valori")
        	}
        	if(contentID == "prenotazioneTab"){
        		
        		 if(listaStrumenti[indexCampione[1]].statoCampione == "N")
        	     {
        		
        			 $("#prenotazione").html("CAMPIONE NON DISPONIBILE");
        			
        		 }else{
        			
        			 
             		//exploreModal("richiestaDatePrenotazioni.do","idCamp="+datax[0],"#prenotazione")

        			loadCalendar("richiestaDatePrenotazioni.do","idCamp="+datax[0],"#prenotazione")
 
        		 }
        		
        		
        	}
        	
        	if(contentID == "aggiornaTab"){
        		 if(listaStrumenti[indexCampione[1]].company.id != '${utente.idCompany}')
        	     {
        		
        			 $('#aggiornaTab').hide();
        			
        		 }else{
        			 $('#aggiornaTab').show();
        			exploreModal("aggiornamentoCampione.do","idCamp="+datax[0],"#aggiorna")
        		 }
        	}
        	

  		})
  	
  		
     	});
     	    
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('#dettaglioTab').tab('show');
     	 	$('body').removeClass('noScroll');
     	 	resetCalendar("#prenotazione");
     	});
     	
     	 $('#myModalError').on('hidden.bs.modal', function (e) {
				if($( "#myModalError" ).hasClass( "modal-success" )){
					callAction("listaCampioni.do");
				}
     		
      	});
     	  

  
  $('#tabPM thead th').each( function () {
      var title = $('#tabPM thead th').eq( $(this).index() ).text();
      $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
  } );

  // DataTable
	table = $('#tabPM').DataTable();
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
    	
    	
    	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});

	$('#formNuovoCampione').on('submit',function(e){
		
		$("#ulError").html("");
	    e.preventDefault();
	    nuovoCampione();

	});
   
 		    
	    	
	    	var umJson = JSON.parse('${listaUnitaMisura}');
	    	var tgJson = JSON.parse('${listaTipoGrandezza}');
	    	
	    	$('#tblAppendGrid').appendGrid({
	            caption: 'Valori Campione',
	            captionTooltip: 'Valori Campione',
	            initRows: 1,
	            columns: [
						  { name: 'parametri_taratura', display: 'Parametri Taratura', type: 'text', ctrlClass: 'required', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'incertezza_relativa', display: 'Incertezza Relativa', type: 'number', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'valore_nominale', display: 'Valore Nominale', type: 'number', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%' } },
	                      { name: 'valore_taratura', display: 'Valore Taratura', type: 'number', ctrlClass: ' numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'incertezza_assoluta', display: 'Incertezza Assoluta', type: 'number', ctrlClass: 'numberfloat', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'unita_misura', display: 'Unita di Misura', type: 'select', ctrlClass: 'required', ctrlOptions: umJson, ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'interpolato', display: 'Interpolato', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'valore_composto', display: 'Valore Composto', type: 'select', ctrlOptions:';0:NO;1:SI', ctrlClass: 'required', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'divisione_UM', display: 'Divisione UM', type: 'number', ctrlClass: 'numberfloat required', ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'tipo_grandezza', display: 'Tipo Grandezza', type: 'select', ctrlClass: 'required', ctrlOptions: tgJson, ctrlCss: { 'text-align': 'center', width: '100%' }  },
	                      { name: 'id', type: 'hidden', value: 0 }
    
	                  ] ,
	               	
	               	
	                beforeRowRemove: function (caller, rowIndex) {
	                    return confirm('Are you sure to remove this row?');
	                },
	                afterRowRemoved: function (caller, rowIndex) {
	                	$(".ui-tooltip").remove();
	                }
	        });
	      
	    });


	    var validator = $("#formNuovoCampione").validate({
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

	
	    jQuery.validator.addMethod("controllocodicecampione", function(value, element) {
	    	  return this.optional(element) || /^[a-zA-Z0-9]*$/.test(value);
	    	}, "Codice non corretto, Inserire solo numeri e lettere");
	    
	    jQuery.validator.addMethod("numberfloat", function(value, element) {
	    	  return this.optional(element) || /^(\d+(?:[\.]\d{1,10})?)$/.test(value);
	    	}, "Float error");
	    
	    $("#codice").focusout(function(){
	    	var codice = $("#codice").val();
	    	var regex = /^[a-zA-Z0-9]*$/;
	    	
	    	

	    	if(validator.element( "#codice" )){
	    		checkCodiceCampione(codice);
	    	}else{

		    	if(codice.length>0){
		    		  $("#codiceError").html("Il codice deve contenere solo lettere e numeri");
	
		    	}

	    	}
	    });
	    
	    $("#codice").focusin(function(){
	    	$("#codiceError").html("");
	    });
	

  </script>
</jsp:attribute> 
</t:layout>
  
 
