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

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
              <div class="row">
        <div class="col-xs-12">
        	<!-- <div class="input-group-btn">
                  <button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-expanded="false">Action
                    <span class="fa fa-caret-down"></span></button>
                  <ul class="dropdown-menu">
                    <li><a class="toggle-vis" data-column="0">ID Prenotazione</a></li>
                    <li><a class="toggle-vis" data-column="1">Campione</a></li>
                    <li><a class="toggle-vis" data-column="2">Stato</a></li>
                    <li><a class="toggle-vis" data-column="3">Proprietario</a></li>
                    <li><a class="toggle-vis" data-column="4">Azienda Richiedente</a></li>
                    <li><a class="toggle-vis" data-column="5">Utente Richiedente</a></li>
                    <li><a class="toggle-vis" data-column="6">Data Richiesta</a></li>
                    <li><a class="toggle-vis" data-column="7">Data Gestione</a></li>
                    <li><a class="toggle-vis" data-column="8">Data Inizio Prenotazione</a></li>
                    <li><a class="toggle-vis" data-column="9">Data Fine Prenotazione</a></li>
                    <li><a class="toggle-vis" data-column="10">Note</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                  </ul>
                </div> -->
              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
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
	 String classValue="";
	 if(listaPrenotazioni.indexOf(prenotazione)%2 == 0){
		 
		 classValue = "odd";
	 }else{
		 classValue = "odd";
	 }
	 
	 %>
	 <tr class="<%=classValue %>" role="row" id="<%=prenotazione.getId() %>">

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
</div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 </div>
</div>




  <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Approvazione</h4>
      </div>
       <div class="modal-body">

        
        
        	<div class="form-group">

                  <textarea class="form-control" rows="3" id="noteApp" placeholder="Entra una nota ..."></textarea>
                </div>
        
        
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
       	    
/*        	 $( "#tabPM tr" ).dblclick(function() {
 */       	   
 			$('#tabPM').on( 'dblclick','tr', function () {

       		var id = $(this).attr('id');
       		
       		var row = table.row('#'+id);
       		data = row.data();
           
     	    if(data){
     	    	 row.child.hide();
             	$( "#myModal" ).modal();
     	    }
       	});
       	    
       	    
       	 $('#myModal').on('hidden.bs.modal', function (e) {
       	  	$('#noteApp').val("");
       	 	$('#empty').html("");
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
    
    });
  </script>
  
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>