<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.Util.Utility"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.JsonElement"%>
<%@page import="it.portaleSTI.DTO.ValoreCampioneDTO"%>
<% 
UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");

String idC = (String)session.getAttribute("idCamp");
JsonObject json = (JsonObject)session.getAttribute("myObjValoriCampione");

JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);

%>



<table id="tableValoriCampione" class="table table-hover table-striped dataTable">
                <thead><tr>
                		<th>Parametri Taratura</th>
                   		<th>Valore Nominale</th>
 	                   	<th>Valore Taratura</th>
 	                   	<th>Incertezza Assoluta</th>
 	                   	<th>Incertezza Relativa</th>
 	                   	<th>UM</th>
 	                   	<th>Interpolato</th>
 	                   	<th>Valore Composto</th>
 	                   	<th>Divisione UM</th>
 	                   	<th>Tipo Grandezza</th>
 	                   	<th>Azioni</th>
 	                   	
                </tr></thead><tbody>
                <%

                
 for(ValoreCampioneDTO valori :listaValori)
 {
	 String classValue="";
	 if(listaValori.indexOf(valori)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "even";
	 }
	 
	 %>
	 <tr class="<%=classValue %>" role="row" >
	
	<td><%=Utility.checkStringNull(valori.getParametri_taratura())%></td>
	<td><%=Utility.checkBigDecimalNull(valori.getValore_nominale()) %></td>
	<td><%=Utility.checkBigDecimalNull(valori.getValore_taratura()) %></td>
    <td><%=Utility.checkBigDecimalNull(valori.getIncertezza_assoluta()) %></td>
	<td><%=Utility.checkBigDecimalNull(valori.getIncertezza_relativa())%></td>
	<td><%=Utility.checkStringNull(valori.getUnita_misura().getNome()) %></td>
	<td><% 

		if(valori.getInterpolato()==0){
		
			%>
			NO
			<%
		}else{
			%>
			SI
			<%
		}
	%></td>
	<td><% 
	if(valori.getValore_composto()!=null){
		if(valori.getValore_composto()==0){
		
			%>
			NO
			<%
		}else{
			%>
			SI
			<%
		}
	}
	%></td>
	<td><%=Utility.checkBigDecimalNull(valori.getDivisione_UM())%></td>
	<td><%=Utility.checkStringNull(valori.getTipo_grandezza().getNome())%></td>
		<%if(utente.checkPermesso("MODIFICA_SINGOLO_VALORE_CAMPIONE")){ %>
	<td><button class="btn btn-warning" onClick="modificaSingoloValoreCampione('<%=idC%>','<%=valori.getId()%>')" title="Click per modificare il valore campione"><i class="fa fa-edit"></i></button></td>
	<%}else{ %>
	<td></td>
	<%} %>
	</tr>
<% 	 
 } 
 %>       
</tbody></table>
<%if(utente.checkPermesso("MODIFICA_VALORI_CAMPIONE_METROLOGIA")){ %>
<button onClick='callAction("modificaValoriCampione.do?view=edit&idC=<%= idC %>")' class="btn btn-warning"><i class="fa fa-edit"></i> MODIFICA VALORI</button>
<% 	 
 } 
 %>   
 
 
   <div id="modificaSingoloValCampioneModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" onClick="hideModal()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Valore Campione</h4>
      </div>
       <div class="modal-body">
			<div id="modificaSingoloValCampioneModalContent">
			
			</div>
   
  		<!-- <div id="empty" class="testo12"></div> -->
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_valore_campione">
 <button onClick="salvaSingoloValoreCampione($('#id_valore_campione').val(), '<%=idC %>')" class="btn btn-success pull-left"  type="button">Salva</button>
         
      </div>
    </div>
  </div>
</div>  

 <script type="text/javascript">

 function hideModal(){
	 $('#modificaSingoloValCampioneModal').modal('hide');
	 
 }
 
	var columsDatatables = [];
	 
	$("#tableValoriCampione").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    

	} );

  
    $(document).ready(function() {
    
    var 	tableValoriCampione = $('#tableValoriCampione').DataTable({
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
  	      paging: false, 
  	      ordering: false,
  	      info: true, 
  	      searchable: false, 
  	      bFilter: false,
  	      targets: 0,
  	      responsive: false,
  	      scrollX: false,
  	      order: [[ 0, "desc" ]],
  	      
  	      columnDefs: [
  	                  { responsivePriority: 1, targets: 0 },
  	                   { responsivePriority: 2, targets: 1 },
  	                   { responsivePriority: 3, targets: 2 }
  	       
  	               ],
  	     
  	               buttons: [ {
  	                   extend: 'copy',
  	                   text: 'Copia',
  	                 
  	               },{
  	                   extend: 'excel',
  	                   text: 'Esporta Excel',
  	                 
  	               },
  	               {
  	                   extend: 'colvis',
  	                   text: 'Nascondi Colonne'
  	                   
  	               }
  	  
  	                         
  	          ]
  	    	
  	      
  	    });
    	
    tableValoriCampione.buttons().container().appendTo( '#tableValoriCampione_wrapper .col-sm-6:eq(1)');
	    
 

  // DataTable
	tableValoriCampione = $('#tableValoriCampione').DataTable();
  // Apply the search
   
  tableValoriCampione.columns.adjust().draw();
    	

	$('#tableValoriCampione').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
	  } );
    	
  	$('.removeDefault').each(function() {
  	   $(this).removeClass('btn-default');
  	});


 
    });


  </script>		