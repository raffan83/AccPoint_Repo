<%@page import="com.mysql.jdbc.Util"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClassificazioneDTO"%>
<%@page import="it.portaleSTI.DTO.LuogoVerificaDTO"%>
<%@page import="it.portaleSTI.DTO.StatoInterventoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoStrumentoDTO"%>
<%@page import="it.portaleSTI.DTO.TipoRapportoDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.StrumentoDTO"%>
<%@page import="it.portaleSTI.Util.Utility" %>
<%@page import="it.portaleSTI.DTO.SedeDTO"%>
<%@ page language="java" import="java.util.List" %>
<%@ page language="java" import="java.util.ArrayList" %>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.InterventoDTO"/>

<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");

ArrayList<StatoInterventoDTO> listaStatoInterventi = (ArrayList)session.getAttribute("listaStatoInterventi");
ArrayList<InterventoDTO> listaInterventi = (ArrayList)session.getAttribute("listaInterventi");

%>

<div style="height:10px;"></div>
<div class="row">
<div class="col-lg-12">
 
 
<button class="btn btn-primary btnFiltri" id="btnTutti" onClick="filtraInterventi('tutti')" disabled>Visualizza Tutti</button>

 	<%
     for(StatoInterventoDTO str :listaStatoInterventi)
     {
     	 %> 
     	 <button class="btn btn-primary btnFiltri" id="btnFiltri_<%=str.getId() %>" onClick="filtraInterventi('<%=str.getDescrizione() %>','<%=str.getId() %>')" ><%=str.getDescrizione() %></button>
  	 <%	 
     }
     %>

 
</div>
</div>
 <div class="clearfix"></div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID</th>
 <th>Commessa</th>
 <th>Presso</th>
 <th>Sede</th>
 <th>Data Creazione</th>
 <th>Stato</th>
 <th>Company</th>
 <th>Responsabile</th>
 <th>Nome Pack</th>
 <td></td>

 </tr></thead>
 
 <tbody>
 
 <%
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(InterventoDTO intervento :listaInterventi)
 {
	 String classValue="";
	 if(listaInterventi.indexOf(intervento)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 	 <tr class="<%=classValue %> customTooltip" title="Doppio Click per aprire il dettaglio dell'Intervento" role="row" id="<%=intervento.getId() %>" ondblclick="callAction('gestioneInterventoDati.do?idIntervento=<%=Utility.encryptData(String.valueOf(intervento.getId()))%>');">
	 								
	 								

	 								 <td><%=intervento.getId()%></td>
	 								 <td><%=intervento.getIdCommessa()%></td>
	 							<td><%

                    	            if(intervento.getPressoDestinatario() == 0){
                    	         	%>
                    	          		<span class="label label-success">IN SEDE</span>
                    	          	<% 
                   	            }else if (intervento.getPressoDestinatario() == 1){
                   	            	%> 
                   	            	 	<span class="label label-info">PRESSO CLIENTE</span>
                   	            	 <%	 
                   	             }else if (intervento.getPressoDestinatario() == 2){
                   	            	%> 
                   	            	 	<span class="label label-warning">MISTO CLIENTE - SEDE</span>
                   	            	 <%	 
                   	             
								 }else if (intervento.getPressoDestinatario() == 3){
								    	%> 
								    	 	<span class="label label-primary">PRESSO LABORATORIO</span>
								    	 <%	 
								     
								}else if (intervento.getPressoDestinatario() == 4){
								   	%> 
								   	 	<span class="label label-info">PRESSO FORNITORE ESTERNO</span>
								   	 <%	 
								    }

                   	             else{
                   	             %> 
                   	             	<span class="label label-info">-</span>
								<%	
                   	             }
                    	             
                    	             %></td>
	 							<td><%=intervento.getNome_sede() %></td>
	 							<td><%
                    	             if(intervento.getDataCreazione()!= null){

                    	            		 out.println(sdf.format(intervento.getDataCreazione()));
                    	            	 
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
	 							
	 							<td id="stato_<%=intervento.getId() %>">
	 							<% if(intervento.getStatoIntervento().getId() == 0){ %>
									
									<a class="customTooltip" title="Click per chiudere l'Intervento"  href="#" onClick="chiudiIntervento('<%=Utility.encryptData(String.valueOf(intervento.getId())) %>',2,<%=listaInterventi.indexOf(intervento) %>)" id="statoa_<%=intervento.getId() %>"> <span class="label label-info">
	 										<% out.println(intervento.getStatoIntervento().getDescrizione());%>
	 								</span></a> 
	 							<%  } %>
	 							
	 							<% if(intervento.getStatoIntervento().getId() == 1){ %>
									<a class="customTooltip" title="Click per chiudere l'Intervento"  href="#" onClick="chiudiIntervento('<%=Utility.encryptData(String.valueOf(intervento.getId())) %>',2,<%=listaInterventi.indexOf(intervento) %>)" id="statoa_<%=intervento.getId() %>"> <span class="label label-success"> 
	 										<% out.println(intervento.getStatoIntervento().getDescrizione());%>
	 								</span></a> 
	 							<%  } %>
	 							
	 							<% if(intervento.getStatoIntervento().getId() == 2){ %>
									
	 							 
	 							<a class="customTooltip" title="Click per aprire l'Intervento"  href="#" onClick="apriIntervento('<%=Utility.encryptData(String.valueOf(intervento.getId()))  %>',2,<%=listaInterventi.indexOf(intervento) %>)" id="statoa_<%=intervento.getId() %>">
									 <span class="label label-warning"> 
	 										<% out.println(intervento.getStatoIntervento().getDescrizione());%>
	 								</span></a> 
	 							<%  } %>
	 						
	 							</td>
	 							<td><%out.println(intervento.getCompany().getDenominazione()); %></td>
	 							
                    	             <td><%=intervento.getUser().getNominativo() %></td>
                    	             <td><%=intervento.getNomePack()%></td>
                    	             <td>
										<a class="btn customTooltip" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=<%=Utility.encryptData(String.valueOf(intervento.getId()))%>');">
							                <i class="fa fa-arrow-right"></i>
          								 </a>
        								</td>
                    	            
                    	            
	 
	
	</tr>
<%
} 
 %>

 </tbody>
 </table>

</div>
</div>




 <script>

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
	    	   $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );

 $(document).ready(function(){
	
 
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
	                   { responsivePriority: 2, targets: 7 },
	                   { responsivePriority: 5, targets: 9 },
	                   { orderable: false, targets: 7 },
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
	   
/* 		$('#tabPM').on( 'dblclick','tr', function () {

  		var id = $(this).attr('id');
  		
  		var row = table.row('#'+id);
  		datax = row.data();

	   if(datax){
 	    	row.child.hide();
 	    	
/* 	    	callAction('gestioneInterventoDati.do?idIntervento='+'');  
 	    		
 	    }
	   
	
	   
	   
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
	
	if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
		   var datepicker = $.fn.datepicker.noConflict();
		   $.fn.bootstrapDP = datepicker;
		}

	$('.datepicker').bootstrapDP({
		format: "dd/mm/yyyy",
	    startDate: '-3d'
	});
	 


	 
	 
	
	 
 });


 </script>
 
 
 
 