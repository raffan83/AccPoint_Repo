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

<jsp:directive.page import="it.portaleSTI.DTO.ClienteDTO"/>
<jsp:directive.page import="it.portaleSTI.DTO.StrumentoDTO"/>

<% 
JsonObject json = (JsonObject)session.getAttribute("myObj");
JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
Gson gson = new Gson();
Type listType = new TypeToken<ArrayList<StrumentoDTO>>(){}.getType();
ArrayList<StrumentoDTO> listaStrumenti = new Gson().fromJson(jsonElem, listType);

%>


  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
					   <th>ID</th>
            	       <th>Stato Strumento</th>		   
            		   <th>Denominazione</th>
                       <th>Codice Interno</th>
                       <th>Costurttore</th>
                       <th>Modello</th>
                       <th>Matricola</th>
                       <th>Risoluzione</th>
                       <th>Campo Misura</th>
                       <th>Tipo Strumento</th>
                       <th>Freq. Verifica</th>
                       <th>Data Ultima Verifica</th>
                       <th>Data Prossima Verifica</th>
                       <th>Tipo Rapporto</th>
 </tr></thead>
 
 <tbody>
 
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
	 	 <tr class="<%=classValue %>" role="row" id="<%=strumento.get__id() %>">
	 
	 
	 								 <td><%=strumento.get__id()%></td>
                       				 <td><%=strumento.getRef_stato_strumento()%></td>
                       			     <td><%=strumento.getDenominazione()%></td>
                    	             <td><%=strumento.getCodice_interno() %></td>
                    	             <td><%=strumento.getCostruttore()%></td>
                    	             <td><%=strumento.getModello()%></td>
                    	             <td><%=strumento.getMatricola()%></td>
                    	             <td><%=strumento.getRisoluzione()%></td>
                    	             <td><%=strumento.getCampo_misura()%></td>
                    	             <td><%=strumento.getRef_tipo_strumento()%></td>
                    	             <td><%=strumento.getScadenzaDto().getFreq_mesi()%></td>
                    	             <td><%
                    	             if(strumento.getScadenzaDto().getDataUltimaVerifica() != null){
                    	            	
                    	            	 strumento.getScadenzaDto().getDataUltimaVerifica();
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%
                    	             if(strumento.getScadenzaDto().getDataProssimaVerifica() != null){
                    	            	
                    	            	 strumento.getScadenzaDto().getDataProssimaVerifica();
                    	            	 
                    	             }else{
                    	            	 %> 
                    	            	 -
                    	            	 <%	 
                    	             }
                    	             
                    	             %></td>
                    	             <td><%=strumento.getScadenzaDto().getRef_tipo_rapporto()%></td>
	 
	
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  

 <script>
 $(function(){
	
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
	                   { responsivePriority: 3, targets: 2 },
	                   { responsivePriority: 4, targets: 3 },
	                   { responsivePriority: 2, targets: 6 },
	                   { orderable: false, targets: 6 },
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
	   
		$('#tabPM').on( 'dblclick','tr', function () {

  		var id = $(this).attr('id');
  		
  		var row = table.row('#'+id);
  		datax = row.data();

	   if(datax){
 	    	row.child.hide();
 	    	exploreModal("dettaglioStrumento.do","id_str="+datax[0],"#dettaglio");
 	    	$( "#myModal" ).modal();
 	    	$('body').addClass('noScroll');
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
	 
	 
 });
 
 </script>
 
 
 