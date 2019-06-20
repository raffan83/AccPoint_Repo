<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
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
<%@page import="it.portaleSTI.Util.Utility" %>

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
JsonObject json = (JsonObject)session.getAttribute("myObjStr");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfoStr");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);


UtenteDTO user = (UtenteDTO)session.getAttribute("userObj");


String idSede = (String)session.getAttribute("id_Sede");
String idCliente = (String)session.getAttribute("id_Cliente");



ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList)session.getAttribute("listaTipoRapporto");
ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList)session.getAttribute("listaTipoStrumento");
ArrayList<StatoStrumentoDTO> listaStatoStrumento = (ArrayList)session.getAttribute("listaStatoStrumento");

ArrayList<LuogoVerificaDTO> listaLuogoVerifica = (ArrayList)session.getAttribute("listaLuogoVerifica");
ArrayList<ClassificazioneDTO> listaClassificazione = (ArrayList)session.getAttribute("listaClassificazione");


%>


<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabStrumentiCampioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 							<th></th>
 						<th>ID</th>
 						  
            	       <th>Stato Strumento</th>		   
            		   <th>Denominazione</th>
                       <th>Codice Interno</th>
                     
                       <th>Matricola</th>
            
                       <th>Tipo Strumento</th>
                       <th>Freq. Verifica</th>
                       <th>Data Ultima Verifica</th>
                       <th>Data Prossima Verifica</th>
                       <th>Reparto</th>
                        <th>Tipo Rapporto</th>
                         <th>Utilizzatore</th>
                          <th>Luogo Verifica</th>
                            <!-- <th>Interpolazione</th>  -->
                            <th>Classificazione</th>
                             <th>Company</th>
                              <th>Data Modifica</th>
                             <th>Utente Modifica</th> 
 						 <th>Costruttore</th>
                       <th>Modello</th>
                        <th>Divisione</th>
                       <th>Campo Misura</th>
                        <td style="min-width:100px;">Azioni</td> 
 </tr></thead>
 
 <tbody >

 <%
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(StrumentoDTO strumento :listaStrumenti)
 {
	 String classValue="";
	 if(listaStrumenti.indexOf(strumento)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 	 <tr class="<%=classValue %> customTooltip" title="Doppio Click per aprire il dettaglio dello Strumento" role="row" id="<%=strumento.get__id() %>">
	 						 <td></td>		
	 								

	 								 <td><%=strumento.get__id()%></td>
	 								 
                       				 <td><%if(strumento.getStato_strumento()!=null){
                       					out.print(strumento.getStato_strumento().getNome());
                       				 }else{
                       					out.print("NULLO");
                       				 } %>
                       				 </td>
                       			     <td><%=strumento.getDenominazione()%></td>
                    	             <td><%=strumento.getCodice_interno()%></td>
                    	            
                    	             
                    	             <td><%=strumento.getMatricola()%></td>
                    	            
                    	             <td><%=strumento.getTipo_strumento().getNome() %></td>
                    	             
                    	             <td><%

                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getFreq_mesi() != 0){
                    	            		 out.println(strumento.getScadenzaDTO().getFreq_mesi());
                    	            	 }
                   	            	 
                   	            		 }else{
                   	            	 	%> 
                   	            	 		-
                   	            	 	<%	 
                   	             	  }
                    	             
                    	             %></td>
                    	             <td><%
                    	             if(strumento.getScadenzaDTO()!= null){
                    	            	 if(strumento.getScadenzaDTO().getDataUltimaVerifica() != null){
                    	            		 out.println(sdf.format(strumento.getScadenzaDTO().getDataUltimaVerifica()));
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             
                    	             <td><%
                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getDataProssimaVerifica() != null){
                    	            		 out.println(sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%=strumento.getReparto()%></td>
                    	             
                    	             <td><%
                    	             if(strumento.getScadenzaDTO() != null){
                    	            	 if(strumento.getScadenzaDTO().getTipo_rapporto().getNoneRapporto() != null){
                    	            		 out.println(strumento.getScadenzaDTO().getTipo_rapporto().getNoneRapporto());
                    	            	 }
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             %></td>
                    	             
                    	             <td><%=strumento.getUtilizzatore()%></td>
                    	             <td><% 
                    	             if(strumento.getLuogo()!=null){
                    	            	 out.println(strumento.getLuogo().getDescrizione());
                    	            	 
                    	             }
                    	             %></td>                    	           
                    	             <td><%=strumento.getClassificazione().getDescrizione()%></td>
                    	             <td><%=strumento.getCompany().getDenominazione()%></td>
								 <td><%
                    	            	 if(strumento.getDataModifica() != null){
                    	            		 out.println(sdf.format(strumento.getDataModifica()));
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
								<td><%
                    	            	 if(strumento.getUserModifica() != null){
                    	            		 out.println(strumento.getUserModifica().getNominativo());
                    	        		 }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%=strumento.getCostruttore()%></td>
	  							<td><%=strumento.getModello()%></td>
                    	             <td><%=strumento.getRisoluzione()%></td>
                    	             <td><%=strumento.getCampo_misura()%></td>
                    	             
                    	                <td>
                    	              <button  class="btn btn-primary" onClick="checkMisure('<%=Utility.encryptData(String.valueOf(strumento.get__id()))%>')">Misure</button>
	 									<%-- <button  class="btn btn-danger" onClick="openDownloadDocumenti('<%=strumento.get__id()%>')"><i class="fa fa-file-text-o"></i></button> --%>
	 								</td>  
	
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  
 
 
 <input type="hidden" id ="selected">
</div>
</div>



<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript">

	var columsDatatables = [];
	 
	$("#tabStrumentiCampioni").on( 'init.dt', function ( e, settings ) {

	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	     $('#tabStrumentiCampioni thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	   var title = $('#tabStrumentiCampioni thead th').eq( $(this).index() ).text();
	    	   if($(this).index()!= 0){
	    		   $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="width:100%" type="text" value="'+columsDatatables[$(this).index()].search.search+'" /></div>');
	    	   }
	    	  
	    	} ); 

	} );
	
	

 $(document).ready(function(){
	
	 console.log("test");
 
	 tabStrumentiCampioni = $('#tabStrumentiCampioni').DataTable({
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
       pageLength: 10,
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      select: true,
	      order:[[1, "desc"]],
	      columnDefs: [
					
	                   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 7 },
	                   { responsivePriority: 4, targets: 3 },	                 
	                   { responsivePriority: 5, targets: 4 },
	                   { responsivePriority: 6, targets: 12 },
	                   { responsivePriority: 7, targets: 22 }, 
	                   { responsivePriority: 8, targets: 13 },
	               
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


		
		$('.inputsearchtable').on('click', function(e){
		    e.stopPropagation();    
		 });
		/* // DataTable
			tabStrumentiCampioni = $('#tabStrumentiCampioni').DataTable();
		// Apply the search
		tabStrumentiCampioni.columns().eq( 0 ).each( function ( colIdx ) {
		   $( 'input', tabStrumentiCampioni.column( colIdx ).header() ).on( 'keyup', function () {
			   tabStrumentiCampioni
		           .column( colIdx )
		           .search( this.value )
		           .draw();
		   } );
		} ); 
		tabStrumentiCampioni.columns.adjust().draw(); */
		
			if (!$.fn.bootstrapDP && $.fn.datepicker && $.fn.datepicker.noConflict) {
				   var datepicker = $.fn.datepicker.noConflict();
				   $.fn.bootstrapDP = datepicker;
				}
   

			
			$('#tabStrumentiCampioni tbody').on( 'click', 'tr', function () {
		     
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		            $('#selected').val("");
		        }
		        else {
		        	tabStrumentiCampioni.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		            $('#selected').val($(this).find("td").eq(1).text());
		        }
		        
		        
		    } );
			
	});
	
	


 </script>
 
 
 
 