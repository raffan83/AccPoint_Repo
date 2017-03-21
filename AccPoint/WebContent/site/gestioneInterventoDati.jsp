<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="it.portaleSTI.DTO.InterventoDTO"%>
<%@page import="java.util.ArrayList"%>
 <%
 CommessaDTO commessa= (CommessaDTO)request.getSession().getAttribute("commessa");
 SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");

 
 InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");


 
 %>
<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dettaglio Intervento
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
	 Dati Intervento
	<div class="box-tools pull-right">
		<button data-widget="collapse" class="btn btn-box-tool"><i class="glyphicon glyphicon-edit"></i> Nuovo Intervento</button>
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right"><%=intervento.getId() %></a>
                </li>
                <li class="list-group-item">
                  <b>Presso</b> <a class="pull-right">
<%
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
	%>

					</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right"><%=intervento.getNome_sede() %></a>
                </li>
                <li class="list-group-item">
                  <b>Data Creazione</b> <a class="pull-right"><%if(intervento.getDataCreazione()!=null)
	{ 
		sdf.format(intervento.getDataCreazione());
	}
	%></a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">
				<%
	if(intervento.getRefStatoIntervento().equals("1CHIUSA"))
	{ 
	%>
		<span class="label label-info">CHIUSA</span>
	<%
	}else if(intervento.getRefStatoIntervento().equals("1APERTA")){
	%>	
		<span class="label label-info">APERTA</span>
	<%
	}
	%>
				</a>
                </li>
                <li class="list-group-item">
                  <b>Responsabile</b> <a class="pull-right"><%=intervento.getRefUtenteCreazione()  %></a>
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
 
 <th>Data Car</th>
 <th>Nome Pack</th>
 <th>Stato</th>
 <th>N° Str Gen</th>
 <th>N° Str Mis</th>
 <th>Str Nuom</th>
 <td>Respons</td>
 <td>Gen</td>
 </tr></thead>
 
 <tbody>
 
 <%

 ArrayList<InterventoDTO> listaInterventi= (ArrayList<InterventoDTO>)request.getSession().getAttribute("listaInterventi");


 for(InterventoDTO pack :listaInterventi)
 {

	 
	 %>
	<tr role="row" id="<%=pack.getId()%>">

	<td>
	<a class="btn" onclick="explore('gestioneInterventoDati.do?idIntervento=<%=pack.getId() %>');">
		<%=pack.getId() %>
	</a>
	</td>
	<td><%=pack.getPressoDestinatario()%></td>
	<td><%=pack.getNome_sede() %></td>
	<td><%if(pack.getDataCreazione()!=null)
	{ 
		sdf.format(pack.getDataCreazione());
	}
	%></td>
	<td class="centered"><%
	if(pack.getRefStatoIntervento().equals("1CHIUSA"))
	{ 
	%>
		<span class="label label-info">CHIUSA</span>
	<%
	}else if(pack.getRefStatoIntervento().equals("1APERTA")){
	%>	
		<span class="label label-info">APERTA</span>
	<%
	}else{
	%>	
		<span class="label label-warning"></span>
	<%
	}
	%></td>
	<td><%=pack.getRefUtenteCreazione() %></td>
	<td><%=pack.getRefUtenteCreazione() %></td>

		<td>
			<a class="btn" onclick="">
                <i class="fa fa-gear"></i>
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
    	                   { responsivePriority: 2, targets: 7 },
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




