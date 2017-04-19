<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
     	})

  
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
    	
    	
    	


    
    	/*$('#posTab').on('click', 'tr', function () { 
    	 var table = $('#tabPM').DataTable();
         var data = table.row( this ).data();
        
       
        var content="";
        
       $.ajax({
            type: "POST",
            url: "dettaglioCampione.do",
            data: "idCamp="+data[0],
            dataType: "json",
            
            //if received a response from the server
            success: function( data, textStatus) {
            	
            	if(data.success){ 
              
            	var buttonPre="<input type=\"button\" class=\"button\" style=\"margin-left:15px;\" value=\"Prenota\" id=\"pren\" onClick=callAction('prenota.do&id="+data.dataInfo.id+"')/> </td>";
            	var buttonCon="<input type=\"button\" class=\"button\" style=\"margin-left:15px;\" value=\"Controlla Prenotazione\" id=\"pren\" onClick=callAction('controlloPrenotazione.do&id="+data.dataInfo.id+"')/> </td>";	
               	
            	content="<div class=\"testo14\"style=\"height:500px;\">"+
            	 
               	"<table class=\"myTab\" >"+
  			     "<tr><td>Proprietario:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.proprietario+"\"></input></td></tr>"+
	             "<tr><td>Nome:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.nome+"\"></input></td></tr>"+
	             "<tr><td>Tipo Campione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.tipoCampione+"\"></input></td></tr>"+
	             "<tr><td>Codice:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.codice+"\"></input></td></tr>"+
	             "<tr><td>Matricola:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.matricola+"\"></input></td></tr>"+
	             "<tr><td>Descrizione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.descrizione+"\"></input></td></tr>"+
	             "<tr><td>Costruttore:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.costruttore+"\"></input></td></tr>"+
	             "<tr><td>Modello:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.modello+"\"></input></td></tr>"+
	             "<tr><td>Interpolazione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.interpolazionePermessa+"\"></input></td></tr>"+
	             "<tr><td>Freq Taratura:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.freqTaraturaMesi+"\"></input></td></tr>"+
	             "<tr><td>Stato Campione:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.statoCampione+"\"></input></td></tr>"+
	             "<tr><td>Data Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataVerifica+"\"></td></tr>"+
	             "<tr><td>Data Scadenza:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataScadenza+"\"></input></td></tr>"+
	             "<tr><td>Tipo Verifica:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.tipoVerifica+"\"></input></td></tr>"+
	             "<tr><td>Certificato:</td><td style=\"text-align:center;\"><a href=# OnClick=\"DoAction(\'"+data.dataInfo.filenameCertificato+"\');\">Scarica Certificato</a></td></tr>"+
	             "<tr><td>Numero Certificato:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.numeroCertificato+"\"></input></td></tr>"+
	             "<tr><td>Utilizzatore:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.utilizzatore+"\"></input></td></tr>"+
	             "<tr><td>Data Inizio:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataInizioPrenotazione+"\"></input></td></tr>"+
	             "<tr><td>Data Fine:</td><td><input type=\"text\"disabled=\"disabled\" Value=\""+data.dataInfo.dataFinePrenotazione+"\"></input></td></tr>"+
	             "<tr><td colspan=\"2\" style=\"padding:15px;\"><input type=\"button\" id=\"valCmp\"  class=\"button\"  value=\"Valori Campione\" style=\"margin-left:15px;\" onClick=\"ValCMP('"+data.dataInfo.id+"');\" />";
	             if(data.prenotazione)
	             {
	            	 content+=buttonPre;
	             }
	             if(data.controllo)
	             {
	            		 content+=buttonCon;
	             }
	             
	             content+="</tr></table></div>";
	              
                
                
                $('#modal1').html(content);
                $('#modal1').dialog({
                	autoOpen: true,
                	title:"Specifiche Campione",
                	width: "500px",
                });
                
            	}
            }
            });
    }); */
   
 
    });


  </script>
</jsp:attribute> 
</t:layout>
  
 
