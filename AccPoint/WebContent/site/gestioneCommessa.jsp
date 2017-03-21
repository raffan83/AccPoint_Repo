<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="java.util.ArrayList"%>

<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Commesse
        <small>Fai click per entrare nel dettaglio della commessa</small>
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
 

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID commessa</th>
 <th>Data Commessa</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Stato Richiedente</th>
 <th>Data Chiusura</th>
 <td></td>
 </tr></thead>
 
 <tbody>
 
 <%

 ArrayList<CommessaDTO> listaCommesse= (ArrayList<CommessaDTO>)request.getSession().getAttribute("listaCommesse");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");


 for(CommessaDTO commessa :listaCommesse)
 {

	 
	 %>
	<tr role="row" id="<%=commessa.getID_COMMESSA()%>">

	<td>
	<a class="btn" onclick="explore('gestioneIntervento.do?idCommessa=<%=commessa.getID_COMMESSA() %>');">
		<%=commessa.getID_COMMESSA() %>
	</a>
	</td>
	<td><%=sdf.format(commessa.getDT_COMMESSA()) %></td>
	<td><%=commessa.getID_ANAGEN_NOME() %></td>
	<td><%=commessa.getANAGEN_INDR_DESCR() + " - " + commessa.getANAGEN_INDR_INDIRIZZO() %></td>

	<td class="centered"><%
	if(commessa.getSYS_STATO().equals("1CHIUSA"))
	{ 
	%>
		<span class="label label-info">CHIUSA</span>
	<%
	}else if(commessa.getSYS_STATO().equals("1APERTA")){
	%>	
		<span class="label label-info">APERTA</span>
	<%
	}
	%></td>
	<td><%if(commessa.getFIR_CHIUSURA_DT()!=null)
	{ 
		sdf.format(commessa.getFIR_CHIUSURA_DT());
	}
	%></td>
		<td>
			<a class="btn" onclick="explore('gestioneIntervento.do?idCommessa=<%=commessa.getID_COMMESSA() %>');">
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
        <button type="button" class="btn btn-danger"onclick="approvazioneFromModal('noApp')"  >Non Approva</button>
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
     	   
 			/* $('#tabPM').on( 'dblclick','tr', function () {

       		var id = $(this).attr('id');
       		
       		var row = table.row('#'+id);
       		data = row.data();
           
     	    if(data){
     	    	 row.child.hide();
             	$( "#myModal" ).modal();
     	    }
       	}); */
       	    
       	    
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



