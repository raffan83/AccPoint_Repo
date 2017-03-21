<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.InterventoDTO"%>
<%@page import="java.util.ArrayList"%>
 <%
 CommessaDTO commessa= (CommessaDTO)request.getSession().getAttribute("commessa");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");

 
 %>
<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dettaglio Commessa
        <small></small>
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
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Commessa
	<div class="box-tools pull-right">
		<button data-widget="collapse" class="btn btn-box-tool"><i class="glyphicon glyphicon-edit"></i> Nuovo Intervento</button>
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right"><%=commessa.getID_COMMESSA() %></a>
                </li>
                <li class="list-group-item">
                  <b>Data Commessa</b> <a class="pull-right"><%=sdf.format(commessa.getDT_COMMESSA()) %></a>
                </li>
                <li class="list-group-item">
                  <b>Cliente</b> <a class="pull-right"><%=commessa.getID_ANAGEN_NOME() %></a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right"><%=commessa.getANAGEN_INDR_DESCR() + " - " + commessa.getANAGEN_INDR_INDIRIZZO() %></a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">
				<%
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
	%>
				</a>
                </li>
                <li class="list-group-item">
                  <b>Data Chiusura</b> <a class="pull-right"><%if(commessa.getFIR_CHIUSURA_DT()!=null)
	{ 
		sdf.format(commessa.getFIR_CHIUSURA_DT());
	}
	%></a>
                </li>
        </ul>

</div>
</div>
</div>
</div>
            
            
            
            
              <div class="row">
        <div class="col-xs-12">
 

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID</th>
 <th>Presso</th>
 <th>Sede</th>
 <th>Data Creazione</th>
 <th>Stato</th>
 <th>Responsabile</th>
 <td></td>
 </tr></thead>
 
 <tbody>
 
 <%

 ArrayList<InterventoDTO> listaInterventi= (ArrayList<InterventoDTO>)request.getSession().getAttribute("listaInterventi");


 for(InterventoDTO intervento :listaInterventi)
 {

	 
	 %>
	<tr role="row" id="<%=intervento.getId()%>">

	<td>
	<a class="btn" onclick="explore('gestioneInterventoDati.do?idIntervento=<%=intervento.getId() %>');">
		<%=intervento.getId() %>
	</a>
	</td>
		<td class="centered"><%
	if(intervento.getPressoDestinatario() == 0)
	{ 
	%>
		<span class="label label-info">IN SEDE</span>
	<%
	}else if(intervento.getPressoDestinatario() == 1){
	%>	
		<span class="label label-warning">PRESSO CLIENTE</span>
	<%
	}else{
	%>	
		<span class="label label-primary"></span>
	<%
	}
	%></td>
	<td><%=intervento.getNome_sede() %></td>
	<td><%if(intervento.getDataCreazione()!=null)
	{ 
		sdf.format(intervento.getDataCreazione());
	}
	%></td>
	<td class="centered"><%
	if(intervento.getRefStatoIntervento().equals("1CHIUSA"))
	{ 
	%>
		<span class="label label-info">CHIUSA</span>
	<%
	}else if(intervento.getRefStatoIntervento().equals("1APERTA")){
	%>	
		<span class="label label-info">APERTA</span>
	<%
	}else{
	%>	
		<span class="label label-warning"></span>
	<%
	}
	%></td>
	
		<td><%=intervento.getRefUtenteCreazione() %></td>

		<td>
			<a class="btn" onclick="explore('gestioneInterventoDati.do?idIntervento=<%=intervento.getId() %>');">
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



