<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Dettaglio Commessa
        <small></small>
      </h1>
      
    </section>
<div style="clear: both;"></div>
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
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${commessa.ID_COMMESSA}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Commessa</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" 
         value="${commessa.DT_COMMESSA}" /></a>
                </li>
                <li class="list-group-item">
                  <b>Cliente</b> <a class="pull-right">${commessa.ID_ANAGEN_NOME}</a>
                </li>
                <li class="list-group-item">
                  <b>Sede</b> <a class="pull-right">${commessa.ANAGEN_INDR_DESCR} ${commessa.ANAGEN_INDR_INDIRIZZO}</a>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">
				 <c:choose>
  <c:when test="${commessa.SYS_STATO == '1CHIUSA'}">
    <span class="label label-info">CHIUSA</span>
  </c:when>
  <c:when test="${commessa.SYS_STATO == '1APERTA'}">
    <span class="label label-info">APERTA</span>
  </c:when>
  <c:when test="${commessa.SYS_STATO == '0CREATA'}">
    <span class="label label-info">CREATA</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose>  </a>
                </li>
                <li class="list-group-item">
                  <b>Note:</b> <a class="pull-right">${commessa.NOTE_GEN}</a>
                </li>
        </ul>

</div>
</div>
</div>
</div>
             <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Attivit&agrave;
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
 </div>

<div class="box-body">

              <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
  <th></th>
 <th>Descrizione Attivita</th>
 <th>Note</th>
 <th>Descrizione Articolo</th>
 <th>Quantit&agrave;</th>
 <th>Codice Articolo</th>
  <th>Codice Aggregatore</th>
<%--   <th>Action</th> --%>
 </tr></thead>
 
 <tbody>
 <c:forEach items="${commessa.listaAttivita}" var="attivita">
 
 <tr role="row">
 
	<td>
	</td>
	<td>
  ${attivita.descrizioneAttivita}
	</td>
		<td>
  ${attivita.noteAttivita}
	</td>	
	<td>
  ${attivita.descrizioneArticolo}
	</td>	
	<td>
  ${attivita.quantita}
	</td>
		<td>
  ${attivita.codiceArticolo}
	</td>
			<td>
  ${attivita.codiceAggregatore}
	</td>
<%-- 	<td>
		<c:set var = "exist" value="false" />
	 	<c:forEach items="${listaInterventi}" var="interventoAttivita">
	 		<c:if test="${interventoAttivita.idAttivita == attivita.codiceAggregatore}">
			<c:set var = "exist" value="true" />
			</c:if>
		</c:forEach>
	
		<c:if test="${!exist}">
		      <a class="btn btn-default pull-right" href="gestioneInterventoCampionamento.do?action=nuovoIntervento&idCommessa=${commessa.ID_COMMESSA}&idRiga=${attivita.id_riga}"><i class="glyphicon glyphicon-edit"></i> Nuovo Intervento</a>
		</c:if>
	</td> --%>
	</tr>
 
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>       
            
            
            
              <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Interventi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID</th>
 <th>ID Attività</th>
  <th>Data Creazione</th>
 <th>Stato</th>
 <th>Responsabile</th>
 <th>Nome Pack</th>
 <td></td>
 </tr></thead>
 
 <tbody>
 <c:forEach items="${listaInterventi}" var="intervento">
 
 <tr role="row" id="${intervento.id}">

	<td>
	<a class="btn customTooltip" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${intervento.id}');">
		${intervento.id}
	</a>
	</td>
	<td>
 		${intervento.idAttivita}
 
	</td>


	<td>
	<c:if test="${not empty intervento.dataCreazione}">
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${intervento.dataCreazione}" />
	</c:if>
	</td>
	<td class="centered">
	<span class="label label-info">${intervento.stato.descrizione}</span>
	</td>
	
		<td>${intervento.user.nominativo}</td>
		<td>${intervento.nomePack}</td>
		<td>
			<a class="btn customTooltip" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDatiCampionamento.do?idIntervento=${intervento.id}');">
                <i class="fa fa-arrow-right"></i>
            </a>
        </td>
	</tr>
 
	</c:forEach>

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
        <h4 class="modal-title" id="myModalLabel">Nuovo Intervento</h4>
      </div>
       <div class="modal-body">

        
        
        	<div class="form-group">
        	<input type="text" disabled="disabled" value=""  name="codicearticolo" id="condicearticolo"/>
				<select class="form-control" id="sede" class="selectpicker">
				  <option value=0>In Sede</option>
				  <option value=1>Presso il Cliente</option>
				</select>

                </div>
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-danger"onclick="saveInterventoFromModal('${commessa.ID_COMMESSA}')"  >Salva</button>
      </div>
    </div>
  </div>
</div>

  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div>
 
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript">
 var tableAttivita;  
    $(document).ready(function() {
    	table = $('#tabPM').DataTable({
    	      paging: true, 
    	      ordering: true,
    	      info: true, 
    	      searchable: false, 
    	      targets: 0,
    	      responsive: true,
    	      scrollX: false,
    	      order: [[ 0, "desc" ]],
    	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
    	                   { responsivePriority: 3, targets: 2 },
    	                   { responsivePriority: 4, targets: 3 },
    	                   { responsivePriority: 2, targets: 6 },
    	                   { orderable: false, targets: 6 },
    	                   { width: "50px", targets: 0 },
    	                   { width: "70px", targets: 1 },
    	                   { width: "50px", targets: 4 },
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

    	                          ],
    	                          "rowCallback": function( row, data, index ) {
    	                        	   
    	                        	      $('td:eq(1)', row).addClass("centered");
    	                        	      $('td:eq(4)', row).addClass("centered");
    	                        	  }
    	    	
    	      
    	    });
    	table.buttons().container()
        .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
     	   
       	    
       	    
       	 

    
    $('#tabPM thead th').each( function () {
        var title = $('#tabPM thead th').eq( $(this).index() ).text();
        $(this).append( '<div><input style="width:100%" type="text" /></div>');
    } );
 
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
    
    
    tableAttivita = $('#tabAttivita').DataTable({
	      paging: false, 
	      pageLength: 5,
	      ordering: false,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	  	  select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	   	 	},
	      columnDefs: [
					   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 3, targets: 1 },
	                   { "visible": false, "targets": 6 }
	               ],
       
	               buttons: [ {
	                   extend: 'copy',
	                   text: 'Copia',
	  	                 exportOptions: {
	                         rows: { selected: true }
	                     }
	                   
	               },{
	                   extend: 'excel',
	                   text: 'Esporta Excel',
	  	                 exportOptions: {
	                         rows: { selected: true }
	                     }
	                  
	               },{
	                   extend: 'pdf',
	                   text: 'Esporta Pdf',
	  	                 exportOptions: {
	                         rows: { selected: true }
	                     }
	                  
	               },
	               
	               {
	                   text: 'Nuovo Intervento',
	                   action: function ( e, dt, node, config ) {
	                	      nuovoInterventoCampionamentoSelected();
	                   },
	                   className: 'btn btn-warning'
	               }
	                         
	                          ],
	                          "rowCallback": function( row, data, index ) {
	                        	   
	                        	      $('td:eq(4)', row).addClass("centered");
	                        	      $('td:eq(5)', row).addClass("centered");
	                        	  },
	                        	  "drawCallback": function ( settings ) {
	                                  var api = this.api();
	                                  var rows = api.rows( {page:'current'} ).nodes();
	                                  var last=null;
	                       
	                                  api.column(6, {page:'current'} ).data().each( function ( group, i ) {
	                                      if ( last !== group ) {
	                                    	  
	                                  /*   	  listaInterventiJson = JSON.parse('${listaInterventiJson}');
	                                    	  exist = false;
	                                    	 	for (var i = 0; i < listaInterventiJson.length; i++) {
												var array_element = listaInterventiJson[i].idAttivita;
												if(array_element == group){
													exist=true;
												}
												
											}
		                                    	 if(exist){
		                                    		 $(rows).eq( i ).before(
				                                              '<tr class="group"><td colspan="6">Codice Attività: '+group+' </td></tr>'
				                                          ); 
		                                    	 }else{ */
		                                          $(rows).eq( i ).before(
		                                              '<tr class="group bg-yellow"><td><input class="idsaggregati" type="checkbox" name="ids[]" value="'+group+'" /></td><td colspan="5">Codice Attività: '+group+' </td></tr>'
		                                          );
		                                    	// }
	                                          last = group;
	                                      }
	                                  } );
	                              }
	    	
	      
	    });
    tableAttivita.buttons().container().appendTo( '#tabAttivita_wrapper .col-sm-6:eq(1)' );
	   
 	    
 	    
 	 


/* $('#tabAttivita thead th').each( function () {
  var title = $('#tabAttivita thead th').eq( $(this).index() ).text();
  $(this).append( '<div><input style="width:100%" type="text" placeholder="'+title+'" /></div>');
} ); */

// DataTable
//tableAttivita = $('#tabAttivita').DataTable();
// Apply the search
/* tableAttivita.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', tableAttivita.column( colIdx ).header() ).on( 'keyup', function () {
	  tableAttivita
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  */

//tableAttivita.columns.adjust().draw();
    

    
    
    $('#myModal').on('hidden.bs.modal', function (e) {
   	  	$('#noteApp').val("");
   	 	$('#empty').html("");
   	})
    
    
    });
    
    function nuovoInterventoCampionamentoSelected(){
    	  
  		pleaseWaitDiv = $('#pleaseWaitDialog');
  		pleaseWaitDiv.modal();

		var selezionati = [];
		
		$('.idsaggregati:checked').each(function() {
			$(this).val();
			selezionati.push($(this).val());
		});
		
			if(selezionati.length > 0){
				
				creaNuovoInterventoCampionamento(selezionati,"${commessa.ID_COMMESSA}");
			}else{
				pleaseWaitDiv.modal('hide');  
			}

	  	
	}
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



