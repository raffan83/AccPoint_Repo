<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="java.math.RoundingMode"%>
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
	</tr>
<% 	 
 } 
 %>       
</tbody></table>

<button onClick='callAction("modificaValoriCampione.do?view=edit&idC=<%= idC %>")' class="btn btn-warning"><i class="fa fa-edit"></i> MODIFICA VALORI</button>


 <script type="text/javascript">

  
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