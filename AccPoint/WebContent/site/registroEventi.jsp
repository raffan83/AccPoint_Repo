<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    

<button class="btn btn-primary" id="nuovo_evento_btn" onClick="nuovoInterventoFromModal('#modalNuovoEvento')">Nuova Manutenzione</button><br><br>

 <table id="tabRegistroEventi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

 <th>ID</th>
 <th>Data</th>
 <th>Tipo Manutenzione</th>
 <th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_eventi}" var="evento" varStatus="loop">
<tr>
<td>${evento.id }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${evento.data_evento}" /></td>
<td>${evento.tipo_manutenzione.descrizione}</td>
<td><button class="btn customTooltip btn-info" onClick="dettaglioAttivitaManutenzione('${evento.id}')" title="Click per visualizzare le attività di manutenzione"><i class="fa fa-arrow-right"></i></button></td>

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table> 
 
 <form class="form-horizontal" id="formNuovaManutenzione">
<div id="modalNuovoEvento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn2" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attività Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalNuovoEventoContent" >
       
        <div class="form-group">
  
      <div class="col-sm-2">
			<label >Tipo di Manutenzione:</label>
		</div>
		
		<div class="col-sm-4">
              <select name="select_tipo_man" id="select_tipo_man" data-placeholder="Seleziona Tipo Manutenzione..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              
              <option value=""></option>
              <c:forEach items="${lista_tipo_manutenzione}" var="manutenzione">	  
	                     <option value="${manutenzione.id}">${manutenzione.descrizione}</option> 	                        
	            </c:forEach>
              </select>
        </div>
        
        <div class="col-sm-2 ">
			<label class="pull-right">Data Manutenzione:</label>
		</div>
        <div class="col-sm-3">
             
             <div class="input-group date datepicker"  id="datetimepicker">
            <input class="form-control  required" id="data_manutenzione" type="text" name="data_manutenzione" required/> 
            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
        </div>
              
        </div>
       </div>      
       
	
      <div class="form-group" id = form_group_1>  
      <div class="col-sm-2">
			<label >Attività 1:</label>
		</div>		
		<div class="col-sm-5">
               <select name="descrizione_attivita_1" id="descrizione_attivita_1" data-placeholder="Seleziona Attività..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
                <option value=""></option>
              <c:forEach items="${lista_tipo_attivita_manutenzione}" var="attivita">	  
	                     <option value="${attivita.id}">${attivita.descrizione}</option> 	                        
	            </c:forEach>
               </select>
        </div>   
        <div class="col-sm-3">
              <select name="select_esito_1" id="select_esito_1" data-placeholder="Seleziona Esito..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
              <option value=""></option>
              <option value="P">P</option>
              <option value="N">N</option>
              </select>
        </div>                
         <div class="col-sm-2">
                  <a class="btn btn-info" title="Click per aggiungere attività" onClick="aggiungiAttivita()"><i class="fa fa-plus"></i></a>
                   <a class="btn btn-danger" title="Click per eliminare attività" onClick="eliminaRiga()"><i class="fa fa-minus"></i></a>
        </div>  			
        </div>
        
  		<div id="emptyPrenotazione" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" >Salva</button>
       
      </div>
    </div>
  </div>

</div>
   </form>
   
   
   <div id="modalAttivita" class="modal fade" role="dialog" aria-labelledby="myModalLabel">

    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" id="close_btn"  aria-label="Close"><span aria-hidden="true">&times;</span></button> 
       
        <h4 class="modal-title" id="myModalLabel">Lista Attività Manutenzione</h4>
      </div>
       <div class="modal-body" id="modalAttivitaContent" >
	
	
  		 </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>

</div>


   <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" >
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" id="close_button" class="btn btn-outline" >Chiudi</button>
      </div>
    </div>
  </div>
</div> 



<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>


 <script type="text/javascript">
 
 var index = 2;
 
	var columsDatatables = [];
	 
	$("#tabRegistroEventi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabRegistroEventi thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	var title = $('#tabRegistroEventi thead th').eq( $(this).index() ).text();
	    	$(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} );


	function aggiungiAttivita(){
		
		var html1 = '<div class="form-group" id="form_group_'+index+'"><div class="col-sm-2"><label >Attività '+index+':</label></div>';
		var html2 = '<div class="col-sm-5"><select name="descrizione_attivita_'+index+'" id="descrizione_attivita_'+index+'" data-placeholder="Seleziona Attività..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>';
		var html3 = '<option value=""></option><c:forEach items="${lista_tipo_attivita_manutenzione}" var="attivita"><option value="${attivita.id}">${attivita.descrizione}</option></c:forEach></select></div>';
		var html4 = '<div class="col-sm-3"><select name="select_esito_'+index+'" id="select_esito_'+index+'" data-placeholder="Seleziona Esito..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>';
        var html5 = '<option value=""></option><option value="P">P</option><option value="N">N</option></select></div></div>';
		
		
		var html = html1.concat(html2).concat(html3).concat(html4).concat(html5);	        

	        $('#modalNuovoEventoContent').append(html);
	        $(".select2").select2();
	        index++;
	}
	
	function eliminaRiga(){
		
		if(index>2){
		$('#form_group_'+(index-1)).remove();
		index--;
		}
	}

	function dettaglioAttivitaManutenzione(id_evento){
		//callAction('registroEventi.do?action=lista_attivita&id_evento='+id_evento, '#modalAttivitaContent', false);
		dataString = 'action=lista_attivita&id_evento='+id_evento;
		$('#modalAttivita').modal();
		exploreModal("registroEventi.do",dataString,"#modalAttivitaContent",function(datab,textStatusb){
			  
	
 		  
          });
		
		
		
	} 
	
  $(document).ready(function() {
 
	  $(".select2").select2();
	  $('.datepicker').bootstrapDP({
			format: "dd/mm/yyyy"
		});
	  $('#modalAttivita').addClass('modal-fullscreen');
 tab = $('#tabRegistroEventi').DataTable({
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
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ], 

	    	
	    });
	


	    $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    });
//DataTable
tab = $('#tabRegistroEventi').DataTable();
//Apply the search
tab.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
   tab
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	tab.columns.adjust().draw();
	

$('#tabRegistroEventi').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});


 }); 
 
  $('#formNuovaManutenzione').on('submit',function(e){
		
		e.preventDefault();
	    nuovaManutenzione(index-1, datax[0]);

	});
  
  $('#close_btn').on('click', function(){
	  $('#modalAttivita').modal('hide');
  });
 
  $('#close_btn2').on('click', function(){
	  $('#modalNuovoEvento').modal('hide');
  });

 $('#modalAttivita').on('hidden.bs.modal', function(){
	  contentID == "registro_eventiTab";
	  
  }); 




</script>