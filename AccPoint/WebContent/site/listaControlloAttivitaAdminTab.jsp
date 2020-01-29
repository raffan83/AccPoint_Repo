<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>



<div class="row">
<div class="col-sm-12">
<button class="btn btn-primary" onClick="filtraNonConformi('C')" id="filtro_c">Conformi</button>
<button class="btn btn-primary" onClick="filtraNonConformi('N')" id="filtro_nc">Non Conformi</button>
<button class="btn btn-primary" onClick="filtraNonConformi('')" id="filtro_t" disabled>Tutte</button><br><br>

 <table id="tabControlloAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>Intervento</th>
<th>Cliente</th>
<th>Sede</th>
<th>Data</th>
<th>UM</th>
<th>Quantità Tot Caricata</th>
<th>Quantità Ass</th> 

<th></th>
<th>Note</th>
 <th>Controllato</th>
 
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_controllo_attivita }" var="controllo" varStatus="loop">
 	<c:if test="${controllo.controllato!=1 && controllo.strumentiAss > controllo.strumentiTot}">
	<tr id="row_${loop.index}" style="background-color:#FF7C7C">
 	</c:if>
 	<c:if test="${controllo.controllato==1 || controllo.strumentiAss == controllo.strumentiTot}">
	<tr id="row_${loop.index}" style="background-color:#00ff80">
 	</c:if>
		
	<td><a href="#" class="btn customTooltip customlink"  style="color:#000000" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(controllo.intervento.id)}');">${controllo.intervento.id }</a></td>	
	<td>${controllo.intervento.nome_cliente }</td>
	<td>${controllo.intervento.nome_sede }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${controllo.intervento.dataCreazione }" /></td>
	<td>${controllo.unita_misura }</td>
	<td>${controllo.strumentiTot }</td>
	<td>${controllo.strumentiAss }</td>
	
	<td>
	<c:if test="${controllo.controllato!=1 && controllo.strumentiAss > controllo.strumentiTot}">
	N
	</c:if>
	
	<c:if test="${controllo.controllato==1 || controllo.strumentiAss == controllo.strumentiTot}">
	C
	</c:if>
	</td>
	<td><textarea rows="3" style="width:100%" readonly>${controllo.note_operatore }</textarea></td>
 	<td>
	<c:if test="${controllo.controllato == 1 }">
	<input type="checkbox" id="controllato_${loop.index }" onClick="checkControlloMilestone('${controllo.intervento.id}','${controllo.operatore.id}',0)" checked>
	</c:if>
	<c:if test="${controllo.controllato == 0 }">
	<input type="checkbox" id="controllato_${loop.index }" onClick="checkControlloMilestone('${controllo.intervento.id}','${controllo.operatore.id}',1)">
	</c:if>
	</td> 
	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


  <div id="myModalModificaAssegnazione" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Assegnazione</h4>
      </div>
       <div class="modal-body">       
       <div class="row">
		<div class="col-md-9" >
        <label>Prezzo Unitario:</label>
        </div>
        <div class="col-md-12">
       <input class="form-control" id="prezzo_unitario" type="text" name="prezzo_unitario"/>
    </div>
      
     	<div class="col-md-9" >
        <label  >Prezzo Assegnato:</label>
        </div>
        <div class="col-md-12">
                      <input class="form-control" id="prezzo_assegnato" type="text" name="prezzo_assegnato"/>
    </div>
       
            	<div class="col-md-9" >
        <label  >Quantità Totale:</label>
        </div>
        <div class="col-md-12">
                      <input class="form-control" id="quantita_totale" type="text" name="quantita_totale"/>
    </div>
         	<div class="col-md-9" >
        <label  >Quantità Assegnata:</label>
        </div>
        <div class="col-md-12">
                      <input class="form-control" id="quantita_assegnata" type="text" name="quantita_assegnata"/>
    </div>
         	<div class="col-md-9" >
        <label  >Note:</label>
        </div>
        <div class="col-md-12">
        <textarea id="note" name="note" style="width:100%" rows="3"></textarea>
                     
    </div>
      	

      	</div>
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_assegnazione">
      <a class="btn btn-primary" onclick="submitModifica()" >Salva</a>
		
      </div>
    </div>
  </div>

</div>





  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'assegnazione?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_assegnazione_elimina">
      <a class="btn btn-primary" onclick="eliminaAssegnazioneAdmin()" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>




<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">


function modalYesOrNo(id){
	$('#id_assegnazione_elimina').val(id);
	$('#myModalYesOrNo').modal();
}

function modalModificaAssegnazione(prezzo_unitario, prezzo_assegnato, quantita_totale, quantita_assegnata, note, id){
	
	$('#id_assegnazione').val(id);
	$('#prezzo_unitario').val(prezzo_unitario);
	$('#prezzo_assegnato').val(prezzo_assegnato);
	$('#quantita_totale').val(quantita_totale);
	$('#quantita_assegnata').val(quantita_assegnata);
	$('#note').val(note);	
	
	
	$('#myModalModificaAssegnazione').modal();
}


function submitModifica(){
	 var prezzo_unitario = $('#prezzo_unitario').val();
	 var prezzo_assegnato = $('#prezzo_assegnato').val();
	 var quantita_totale = $('#quantita_totale').val();
	 var quantita_assegnata = $('#quantita_assegnata').val();	  
	 var note = $('#note').val();
	 var id_assegnazione = $('#id_assegnazione').val();
	 
	 $('#prezzo_unitario').css('border', '1px solid #d2d6de');
	 $('#prezzo_assegnato').css('border', '1px solid #d2d6de');
	 $('#quantita_totale').css('border', '1px solid #d2d6de');
	 $('#quantita_assegnata').css('border', '1px solid #d2d6de');
	 
	 var esito = true;
	 
	 if(isNaN(prezzo_unitario)){
		 esito = false;
		 $('#prezzo_unitario').css('border', '1px solid #f00');
	 }
	 if(isNaN(prezzo_assegnato)){
		 esito = false;
		 $('#prezzo_assegnato').css('border', '1px solid #f00');
	 }
	 if(isNaN(quantita_totale)){
		 esito = false;
		 $('#quantita_totale').css('border', '1px solid #f00');
	 }
	 if(isNaN(quantita_assegnata)){
		 esito = false;
		 $('#quantita_assegnata').css('border', '1px solid #f00');
	 }
	 
	 if(esito){
		 modificaAssegnazioneAdmin(prezzo_unitario, prezzo_assegnato,quantita_totale,quantita_assegnata);
	 }
	 
}


var columsDatatables = [];

$("#tabControlloAttivita").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabControlloAttivita thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabControlloAttivita thead th').eq( $(this).index() ).text();
    	
    	 // if($(this).index()!=0 ){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    //	}
    	//  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );


		
 		function filtraNonConformi(value){
			var tabella = $('#tabControlloAttivita').DataTable();
			
			tabella.columns( 7 ).search( value ).draw();
			
			if(value =='N'){
				$('#filtro_c').attr('disabled',false);
				$('#filtro_nc').attr('disabled',true);
				$('#filtro_t').attr('disabled',false);
			}else if(value=='C'){
				$('#filtro_c').attr('disabled',true);
				$('#filtro_nc').attr('disabled',false);
				$('#filtro_t').attr('disabled',false);
			}else{
				$('#filtro_c').attr('disabled',false);
				$('#filtro_nc').attr('disabled',false);
				$('#filtro_t').attr('disabled',true);
			}
		} 

		
		
		
$(document).ready(function(){
	
	
	 table = $('#tabControlloAttivita').DataTable({
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
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: false,	
		         
		      columnDefs: [
		    	 
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 4 },
		    	 
		               ], 	        
	  	      buttons: [   
	  	    	{
	                extend: 'excel',
	                text: 'Esporta Excel',
	                 exportOptions: {
	                    modifier: {
	                        page: 'current'
	                    }
	                } 
	            },
	  	    	  {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabControlloAttivita_wrapper .col-sm-6:eq(1)');
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
	
	table.columns( [7] ).visible( false );
	    
		table.columns.adjust().draw();
		

	$('#tabControlloAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
//	coloraRighe(table);


	
});


</script>