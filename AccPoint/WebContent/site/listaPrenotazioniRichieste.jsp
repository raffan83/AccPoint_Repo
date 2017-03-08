<%@page import="it.portaleSTI.DTO.PrenotazioneDTO"%>
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

 
 <div id="posTab" style="padding:5px;">

 <table id="tabPM" class="table table-bordered table-hover">
 <thead><tr>
 
 <th>ID Prenotazione</th>
 <th>Campione</th>
 <td>Stato</td>
 <th>Proprietario</th>
 <th>Azienda Richiedente</th>
 <th>Utente Richiedente</th>
 <th>Data Richiesta</th>
 <th>Data Gestione</th>
 <th>Data Inizio Prenotazione</th>
 <th>Data Fine Prenotazione</th>
 <th>Note</th>
 </tr></thead>
 
 <tbody>
 
 <%
 ArrayList<PrenotazioneDTO> listaPrenotazioni =(ArrayList<PrenotazioneDTO>)request.getSession().getAttribute("listaPrenotazioni");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
 for(PrenotazioneDTO prenotazione :listaPrenotazioni)
 {
	 %>
	 <tr>

	<td><%=prenotazione.getId() %></td>
    <td><%=prenotazione.getNomeCampione() %></td>
	<td><%=prenotazione.getDescrizioneStatoPrenotazione() %></td>
	<td><%=prenotazione.getNomeCompanyProprietario() %></td>
	<td><%=prenotazione.getNomeCompanyRichiedente() %></td>
	<td><%=prenotazione.getNomeUtenteRichiesta() %></td>
	<td><%=sdf.format(prenotazione.getDataRichiesta())%></td>
	<td><%if(prenotazione.getDataGestione()!=null)
	{ 
		sdf.format(prenotazione.getDataGestione());
	}
	%></td>
	<td><%=sdf.format(prenotazione.getPrenotatoDal()) %></td>
	<td><%=sdf.format(prenotazione.getPrenotatoAl()) %></td>
	<td><%=prenotazione.getNote()%></td>
	</tr>
<% 	 
 } 
 %>
 </tbody>
 </table>  
 </div>





  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Approvazione</h4>
      </div>
       <div class="modal-body">
        <textarea rows="5" cols="30" id="noteApp"></textarea>
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="approvazioneFromModal('app')"  >Approva</button>
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"   >Non Approva</button>
      </div>
    </div>
  </div>
</div>


  <script type="text/javascript">
   


    $(document).ready(function() {
    	$('#tabPM').DataTable({
    	      "paging": true, 
    	      "ordering": true,
    	      "info": true, 
  
    	      "responsive": true
    	    });
    	
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

       	 table = $('#tabPM').DataTable();
    $('#posTab').on('click', 'tr', function () {
    	 
          data = table.row( this ).data();

 	    if(data){
         
         	$( "#myModal" ).modal();
 	    }

    });
    
    $('#posTab thead th').each( function () {
        var title = $('#posTab tfoot th').eq( $(this).index() ).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
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


    });


  </script>
  
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>




