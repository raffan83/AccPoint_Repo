<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
<div class="row">
<div class="col-xs-12">
<a class="btn btn-primary customTooltip pull-left" title="Vai allo storico email" onClick="modalStorico('${corso.id}')"><i class="fa fa-envelope"></i></a>
 <a class="btn btn-primary pull-right" onClick="associaUtentiModal('${corso.id}')" title="Click per associare gli utenti al corso"><i class="fa fa-plus"></i> Aggiungi Partecipanti</a>
 <a class="btn bg-olive pull-right" onClick="inviaEmail('${corso.id}')" style="margin-right:5px"><i class="fa fa-envelope"></i> Invia Email</a>
 <a class="btn bg-purple pull-right" onClick="associaEmailMoodle('${corso.id}')" style="margin-right:5px"><i class="fa fa-users"></i> Associa Email da Moodle</a>
 <a class="btn btn-danger pull-right" onClick="scaricaTutti(${corso.id})"style="margin-right:5px"><i class="fa fa-arrow-down"></i> Scarica tutti gli attestati</a>
</div>
</div><br>
</c:if>

<c:if test="${userObj.checkRuolo('F2') ||userObj.checkRuolo('F3') }"> 
<div class="row">
<div class="col-xs-12">
 <a class="btn btn-danger pull-right" onClick="scaricaTutti(${corso.id})"style="margin-right:5px"><i class="fa fa-arrow-down"></i> Scarica tutti gli attestati</a>
</div>
</div><br>
</c:if>
<table id="tabPartecipanti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th style="max-width:65px" class="text-center"></th>

<th>Nominativo</th>
<th>Email</th>
<th>Ruolo</th>
<th>Ore partecipate</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${listaPartecipanti }" var="partecipante" varStatus="loop">
 	<tr id="row_${partecipante.partecipante.id}" >
 	<td class="select-checkbox"></td>
 	<td><a class="btn customTooltip customlink" title="Vai al partecipante" onclick="callAction('gestioneFormazione.do?action=dettaglio_partecipante&id_partecipante=${utl:encryptData(partecipante.partecipante.id)}')">${partecipante.partecipante.nome } ${partecipante.partecipante.cognome }</a></td>
	<td>
    <input type="text" class="form-control email-input" data-id="${partecipante.partecipante.id}"  value="${partecipante.partecipante.email}" style="width: 100%;">
  </td>
  
	<td>${partecipante.ruolo.descrizione }</td>
	<td>${partecipante.ore_partecipate }</td>
	<td>
	<c:if test="${partecipante.attestato!=null }">
	<a target="_blank" class="btn btn-danger" href="gestioneFormazione.do?action=download_attestato&id_corso=${utl:encryptData(corso.id)}&id_partecipante=${utl:encryptData(partecipante.partecipante.id)}&filename=${utl:encryptData(partecipante.attestato)}" title="Click per scaricare l'attestato"><i class="fa fa-file-pdf-o"></i></a>
	</c:if>
	<c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('GESTIONE_FORMAZIONE_ADMIN') }"> 
	<a class="btn btn-warning" title="Click per modificare" onclick="modificaPartecipanteCorso('${partecipante.partecipante.id}','${partecipante.corso.id }','${partecipante.ruolo.id }','${partecipante.ore_partecipate }','${partecipante.attestato.replace('\'','&prime;') }')"><i class="fa fa-edit"></i></a>
	<a href="#" class="btn btn-danger customTooltip" title="Click per eliminare il partecipante dal corso" onclick="modalYesOrNoPart('${partecipante.partecipante.id}','${partecipante.ruolo.id }')"><i class="fa fa-trash"></i></a>
	</c:if> 
	</td>
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>
 
 
 
   <div id="myModalYesOrNoPart" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il partecipante?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_partecipante_id" name="elimina_partecipante_id">      
      <input type="hidden" id="elimina_ruolo_id" name="elimina_ruolo_id">
      <a class="btn btn-primary" onclick="dissociaPartecipanteCorso($('#elimina_partecipante_id').val(), '${corso.id}',$('#elimina_ruolo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNoPart').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>
 
 
<form id="formAssociazioneUtenteCorso" name="formAssociazioneUtenteCorso">
<div id="myModalAssociaUtenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associa partecipante al corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-12">
       
       <select name="partecipante" id="partecipante" data-placeholder="Seleziona Partecipante..."  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  required>
                    
                    <option value=""></option> 
                        <c:forEach items="${lista_partecipanti}" var="part">
                       		<c:choose>
                     			 <c:when test="${corso.listaPartecipanti.contains(part) }">
                      				<option value="${part.id }" disabled>${part.nome} ${part.cognome } - ${part.cf }</option> 
                    			 </c:when>
                     			 <c:otherwise>
                    				<option value="${part.id }">${part.nome} ${part.cognome } - ${part.cf }</option> 
                     			 </c:otherwise>
                      		</c:choose>
                     	</c:forEach>
                    
                  </select>
                  </div>
       </div><br>
       
         <div class="row">
       <div class="col-xs-12">
       
       <select name="ruolo" id="ruolo" data-placeholder="Seleziona Ruolo..."  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  required>
                    
                    <option value=""></option>  
                      <c:forEach items="${lista_ruoli}" var="ruolo">
                           <option value="${ruolo.id }">${ruolo.descrizione}</option> 
                     </c:forEach>
                  </select>
                  </div>
       </div><br>
       
        <div class="row">
       <div class="col-xs-4">
       <label>Ore Partecipate</label>
       </div>
       <div class="col-xs-8">
       <input id="ore_partecipate" name="ore_partecipate" type="number" min="0" max="${corso.durata }" step="0.1" class="form-control" required>
       </div>
       </div><br>
       
       <div class="row">
       <div class="col-xs-12">
       <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Attestato...</span><input accept=".pdf,.PDF"  id="fileupload_att" name="fileupload_att" type="file" required></span><label id="label_attestato"></label></div>
       </div>
     
      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_corso_user" name="id_corso_user">
      <!-- <a class="btn btn-primary" onclick="associaPartecipanteCorso()" >Associa</a> -->
		 <button class="btn btn-primary" type="submit" >Associa</button> 
      </div>
    </div>
  </div>

</div>
</form>


<form id="formModificaAssociazioneUtenteCorso" name="formModificaAssociazioneUtenteCorso">
<div id="myModalModificaAssociaUtenti" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associa partecipante al corso</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
       <div class="col-xs-12">
       
       <select name="partecipante_mod" id="partecipante_mod" data-placeholder="Seleziona Partecipante..." disabled class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  required>
                    
                    <option value=""></option> 
                        <c:forEach items="${lista_partecipanti}" var="part">
                       		<c:choose>
                     			 <c:when test="${corso.listaPartecipanti.contains(part) }">
                      				<option value="${part.id }" disabled>${part.nome} ${part.cognome }</option> 
                    			 </c:when>
                     			 <c:otherwise>
                    				<option value="${part.id }">${part.nome} ${part.cognome }</option> 
                     			 </c:otherwise>
                      		</c:choose>
                     	</c:forEach>
                    
                  </select>
                  </div>
       </div><br>
       
         <div class="row">
       <div class="col-xs-12">
       
       <select name="ruolo_mod" id="ruolo_mod" data-placeholder="Seleziona Ruolo..."  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%"  required>
                    
                    <option value=""></option>  
                      <c:forEach items="${lista_ruoli}" var="ruolo">
                           <option value="${ruolo.id }">${ruolo.descrizione}</option> 
                     </c:forEach>
                  </select>
                  </div>
       </div><br>
       
        <div class="row">
       <div class="col-xs-4">
       <label>Ore Partecipate</label>
       </div>
       <div class="col-xs-8">
       <input id="ore_partecipate_mod" name="ore_partecipate_mod" type="number" min="0" max="${corso.durata }" step="0.1"class="form-control" required>
       </div>
       </div><br>
       
       <div class="row">
       <div class="col-xs-12">
       <span class="btn btn-primary fileinput-button"><i class="glyphicon glyphicon-plus"></i><span>Carica Attestato...</span><input accept=".pdf,.PDF"  id="fileupload_mod" name="fileupload_mod" type="file" ></span><label id="label_attestato_mod"></label></div>
       </div>
     
      	
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_partecipante" name="id_partecipante">
      <input type="hidden" id="id_corso" name="id_corso">
      <input type="hidden" id="ruolo_old" name="ruolo_old">
      
      
		 <button class="btn btn-primary" type="submit" >Associa</button> 
      </div>
    </div>
  </div>

</div>
</form>
  <div id="myModalStorico" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Storico</h4>
      </div>
       <div class="modal-body">       
      	<div id="content_storico"></div>
      	</div>
      <div class="modal-footer">

      
		<a class="btn btn-primary" onclick="$('#myModalStorico').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>

<style>

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
.table th {
    background-color: #3c8dbc !important;
  }</style>

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
 
 
 function modalYesOrNoPart(id_partecipante, id_ruolo){
	 
	 $('#elimina_partecipante_id').val(id_partecipante);
	 $('#elimina_ruolo_id').val(id_ruolo);
	 $('#myModalYesOrNoPart').modal();
	 
 }
 
 
 function modificaPartecipanteCorso(id_partecipante,id_corso,id_ruolo, ore_partecipate, attestato){
	
	 $('#id_partecipante').val(id_partecipante);
	 $('#id_corso').val(id_corso);
	
	 $('#partecipante_mod').val(id_partecipante);
	 $('#partecipante_mod').change();
	 
	 $('#ruolo_mod').val(id_ruolo);
	 $('#ruolo_mod').change();
	 
	 if(ore_partecipate!=null && ore_partecipate!=''){
		 $('#ore_partecipate_mod').val(""+ore_partecipate.replace(",","."));	 
	 }
	 if(attestato!=null){
		 $('#label_attestato_mod').html(attestato);	 
	 }
	 
	 
	 $('#myModalModificaAssociaUtenti').modal();
	 
 }
 
function associaUtentiModal(id_corso){
	
	$('#id_corso_user').val(id_corso);	

	$('#myModalAssociaUtenti').modal();
}
 
 var columsDatatables = [];

 $("#tabPartecipanti").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabPartecipanti thead th').each( function () {
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabForPartecipanti thead th').eq( $(this).index() ).text();
     	
     	  if($(this).index()!=0){
 		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
     	  }	
      	 else if($(this).index() ==0){
	    	  	$(this).append( '<input class="pull-left" id="checkAll" type="checkbox" />');
	      }
     	 $('#checkAll').iCheck({
             checkboxClass: 'icheckbox_square-blue',
             radioClass: 'iradio_square-blue',
             increaseArea: '20%' // optional
           });

     	} );
     
     

 } );
   
 
 $('#fileupload_att').change(function(){
	$('#label_attestato').html($(this).val().split("\\")[2]) ;
 });
 
 $('#fileupload_mod').change(function(){
		$('#label_attestato_mod').html($(this).val().split("\\")[2]) ;
	 });
 
 function scaricaTutti(id_corso){
	 
	 callAction("gestioneFormazione.do?action=download_attestato_all&id_corso="+id_corso, null, true);
	 pleaseWaitDiv.modal('hide')
	 

	 
	// location.reload()
 }
 
 function inviaEmail(id_corso){
	 
	 pleaseWaitDiv.modal('show');
	  dataObj = {};
	  dataObj.id_corso = id_corso;
	  
	  var id_partecipanti = "";
	  
	  var t = $('#tabPartecipanti').DataTable();
	   t.rows({ selected: true }).every(function () {
	        var $row = $(this.node());
	    
			id_partecipanti += $row[0].id.split("_")[1]+";";	        
	    });
	  
	  
	   dataObj.id_partecipanti = id_partecipanti;
	   
		 callAjax(dataObj,"gestioneFormazione.do?action=inviaEmail", function(data){
			 if(data.success){
				 if(data.errore){
					 $('#myModalErrorContent').html(data.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-warning");
				 }else{
					 $('#myModalErrorContent').html(data.messaggio);
						$('#myModalError').removeClass();
						$('#myModalError').addClass("modal modal-success");
				 }
					
					
					$('#myModalError').modal('show');
				 
			 }else{
				 $('#myModalErrorContent').html(data.messaggio);
					$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");
					$('#myModalError').modal('show');
			 }
			 

			 pleaseWaitDiv.modal('hide');
		 });
		 
		 
	 
 }
 
 function associaEmailMoodle(id_corso){
	 
	  dataObj = {};
	  dataObj.id_corso = id_corso;
		 
		 callAjax(dataObj,"gestioneFormazione.do?action=associaEmail",function(data){
			
			if(data.success)
			{
				location.reload();     
			}
		 });
	 pleaseWaitDiv.modal('hide');

 }
		 
 var partecipanti_options;
    $(document).ready(function() {
    	
    	partecipanti_options = $('#partecipante option').clone();
    	
    	$('.select2').select2();
    	console.log("test2")
    	
    	  table = $('#tabPartecipanti').DataTable({
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
  	        pageLength: 25,
  	        "order": [[ 0, "desc" ]],
  		      paging: true, 
  		      ordering: true,
  		      info: true, 
  		      searchable: true, 
  		      targets: 0,
  		      responsive: true,
  		      scrollX: false,
  		      stateSave: true,	
  		    select: {
			    style: 'multi-shift',
			    selector: 'td:nth-child(1)' // attenzione: meglio usare 'first-child' che 'nth-child(1)'
			  }, 
  		      columnDefs: [
  		    	  { className: "select-checkbox", targets: 0,  orderable: false },
  		    	  { responsivePriority: 1, targets: 1 },
  		    	  
  		    	  
  		               ], 	        
  	  	      buttons: [   
  	  	          {
  	  	            extend: 'colvis',
  	  	            text: 'Nascondi Colonne'  	                   
  	 			  } ]
  		               
  		    });
  		
  		table.buttons().container().appendTo( '#tabPartecipanti_wrapper .col-sm-6:eq(1)');
  	 	    $('.inputsearchtable').on('click', function(e){
  	 	       e.stopPropagation();    
  	 	    });

  	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
  	      table
  	          .column( colIdx )
  	          .search( this.value )
  	          .draw();
  	  } );
  	} );  
  	
  	
  	
  		table.columns.adjust().draw();
  		
  		

  		

  	$('#tabPartecipanti').on( 'page.dt', function () {
  		$('.customTooltip').tooltipster({
  	        theme: 'tooltipster-light'
  	    });
  		
  		$('.removeDefault').each(function() {
  		   $(this).removeClass('btn-default');
  		})

  		

  	});
  	
   	$('#checkAll').on('ifChecked', function (ev) {

		$("#checkAll").prop('checked', true);
		table.rows().deselect();
		var allData = table.rows({filter: 'applied'});
		table.rows().deselect();
		i = 0;
		table.rows({filter: 'applied'}).every( function ( rowIdx, tableLoop, rowLoop ) {
		    //if(i	<maxSelect){
				 this.select();
		   /*  }else{
		    		tableLoop.exit;
		    }
		    i++; */
		    
		} );

  	});
	$('#checkAll').on('ifUnchecked', function (ev) {

		
			$("#checkAll").prop('checked', false);
			table.rows().deselect();
			var allData = table.rows({filter: 'applied'});
			table.rows().deselect();

	  	});
     	
  		var n_partecipanti = table.rows()[0].length;
  		
  		$("#n_partecipanti").html(n_partecipanti);
	});

    $('#ore_partecipate').focusout(function(){
    	
    	var max = '${corso.durata}';
    	
    	if($(this).val()>parseInt(max)){
    		$(this).val(max) ;
    	}
    })
    
    $('#ore_partecipate_mod').focusout(function(){
    	
    	var max = '${corso.durata}';
    	
    	if($(this).val()>parseInt(max)){
    		$(this).val(max) ;
    	}
    })
    
    $('#formAssociazioneUtenteCorso').on('submit', function(e){
    	e.preventDefault();
    	
    	associaPartecipanteCorso();
    });
    
    $('#formModificaAssociazioneUtenteCorso').on('submit', function(e){
    	e.preventDefault();
    	
    	modificaAssociazionePartecipanteCorso();
    });

    $('.email-input').on('keydown', function (e) {
        if (e.key === 'Enter') {
          e.preventDefault();
          aggiornaEmail($(this));
        }
      });

      // Evento su perdita del focus
      $('.email-input').on('blur', function () {
        aggiornaEmail($(this));
      });

      
      
      function modalStorico(id_corso){
    	  
    	  dataString ="action=storico_email&id_corso="+ id_corso+"&attestato=1";
         exploreModal("gestioneFormazione.do",dataString,"#content_storico",function(datab,textStatusb){
         });
    	  
    	  $('#myModalStorico').modal()
     }
      
      
    
    function aggiornaEmail($input) {
        const email = $input.val().trim();
        const partecipanteId = $input.data('id');

  	  dataObj = {};
	  dataObj.id_partecipante = partecipanteId;
	  dataObj.email = email;
	  
		 callAjax(dataObj,"gestioneFormazione.do?action=aggiornaEmail",function(data){
			
		 });
	

      }
  </script>