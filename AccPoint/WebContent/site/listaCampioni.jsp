<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Richiesta Prenotazioni
        <small>Fai click per prenotare</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          <button class="btn btn-info" onclick="explore('listaCampioni.do?p=mCMP');">I miei Campioni</button>
          <button class="btn btn-info" onclick="explore('listaCampioni.do');">Tutti i Campioni</button>
          </div>
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <td>ID</td>
 <th>Proprietario</th>
 <th>Utilizzatore</th>
 <th>Stato Prenotazione</th>
 <th>Nome</th>
 <th>Tipo Campione</th>
 <th>Codice</th>
 <th>Costruttore</th>
 <th>Descrizione</th>
 <th>Stato Campione</th>
 <th>Data Verifica</th>
 <th>Data Scadenza</th>
 </tr></thead>
 
 <tbody>
 
 <%
 ArrayList<CampioneDTO> listaCampioni =(ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(CampioneDTO campione :listaCampioni)
 {
	 String classValue="";
	 if(listaCampioni.indexOf(campione)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 <tr class="<%=classValue %>" role="row" id="<%=campione.getCodice() %>">

	
    <td><%=campione.getId()%></td>
	<td><%=campione.getProprietario() %></td>
	<td><%=campione.getUtilizzatore() %></td>
		 <%

	
	 if(campione.getStatoPrenotazione()!=null && campione.getStatoPrenotazione().equals("0") && !campione.getStatoCampione().equals("N"))
	 {
		 %>
		 	<td align="center" ><span class="label label-info">ATTESA</span></td>
		 <% 
	 }
	 
	 if(campione.getStatoPrenotazione()!=null && campione.getStatoPrenotazione().equals("1") && !campione.getStatoCampione().equals("N"))
	 {
		 
		 %>
		 	<td align="center"><span class="label label-warning">PRENOTATO</span></td>
		 <% 
	 }
	 
	 if(campione.getStatoCampione().equals("N"))
     {
		 %>
		 <td align="center"><span class="label label-danger">NON DISPONIBILE</span></td>
		 <%  
	 }
	
	 if(campione.getStatoPrenotazione().equals("null")  && campione.getStatoCampione().equals("S")  )
	 {
		 %>
		 <td align="center"><span class="label label-success">DISPONIBILE</span></td>
		 <%  
	 }
%>
	<td><%=campione.getNome() %></td>
	<td><%=campione.getTipoCampione() %></td>
	<td><%=campione.getCodice() %></td>
	<td><%=campione.getCostruttore() %></td>
	<td><%=campione.getDescrizione() %></td>
	<td><%=campione.getStatoCampione() %></td>
	<%String dataVer="";
	  String dataScad="";
	  
	  if(campione.getDataVerifica()!=null)
	  {
		  dataVer= sdf.format(campione.getDataVerifica());
	  }
	  
	  if(campione.getDataScadenza()!=null)
	  {
		  dataScad=  sdf.format(campione.getDataScadenza());
	  }
	  
	%>
	<td><%=dataVer %></td>
	<td><%=dataScad %></td>
	</tr>
<% 	 
 } 
 %>
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
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Campione</a></li>
              <li class=""><a href="#valori" data-toggle="tab" aria-expanded="false" onclick="" id="valoriTab">Valori Campione</a></li>
              <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Controlla Prenotazione</a></li>
               <li class=""><a href="#aggiorna" data-toggle="tab" aria-expanded="false" onclick="" id="aggiornaTab">Aggiornamento Campione</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">


    			</div> 

              <!-- /.tab-pane -->
              <div class="tab-pane" id="valori">
                

         
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


<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body" id="myModalErrorContent" >

       
    
  		 </div>
      <div class="modal-footer">
       <!--  <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button> -->
      </div>
    </div>
  </div>
</div>

<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Spiacente</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalErrorContent">

        
  		 </div>
      
    </div>
  </div>
</div>

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
  	table.buttons().container()
      .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
     /*  $('#tabPM').DataTable({
      	"columnDefs": [
      	               { "width": "50px", "targets": 0 },
      	               { "width": "250px", "targets": 1 },
      	               { "width": "50px", "targets": 2 },
      	               { "width": "150px", "targets": 3 },
      	               { "width": "50px", "targets": 4 },
      	               { "width": "100px", "targets": 5 }
      	             ],
    	       
    	  "scrollY":        "350px",
          "scrollX":        true,
          "scrollCollapse": true,
     	    "paging":   false,
     	   
     	    }); */
     	 $( "#tabPM tr" ).dblclick(function() {
     		var id = $(this).attr('id');
     		
     		var row = table.row('#'+id);
     		datax = row.data();
         
   	    if(datax){
   	    	row.child.hide();
   	    	exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio");
   	    	$( "#myModal" ).modal();
   	    	$('body').addClass('noScroll');
   	    }
   	    
		$('#dettaglioTab').on('click', exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#dettaglio"));
  		$('#valoriTab').on('click', exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#valori"));
  		$('#prenotazioneTab').on('click', exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#prenotazione"));
  		//$('#aggiornaTab').on('click', exploreModal("dettaglioCampione.do","idCamp="+datax[0],"#aggiorna"));
   	    
  		$('#aggiornaTab').dblclick(alert('test'));
  		
  		campioneMio = false;
  		if(!campioneMio){
  			$('#aggiornaTab').hide();

  		}else{
  			$('#aggiornaTab').show();

  		}
  		
     	});
     	    
     	    
     	 $('#myModal').on('hidden.bs.modal', function (e) {
     	  	$('#noteApp').val("");
     	 	$('#empty').html("");
     	 	$('body').removeClass('noScroll');
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
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div>
   <div id="modal11"><!-- Place at bottom of page --></div> 
   <div id="modal12"><!-- Place at bottom of page --></div> 

