<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<div class="row">
<div class="col-sm-3"></div>
<div class="col-sm-3"></div>
<div class="col-sm-3">

</div>
<div class="col-sm-3">
<label class="pull-right">Importo Assegnato Totale (&#x20AC;)</label>

<input type="text" id="importo_assegnato" class="form-control pull-right" readonly style="width:50%;text-align:right;">
</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAssegnazioneAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th></th>

<th>Commessa</th>
<th>Cliente</th>
<th>Data</th>
<th>Utente</th>
<th>Descrizione</th>
<th>Prezzo Un</th>
<th>Prezzo Ass</th>
<th>UM</th>
<th>Q.ta Totale Milestone</th>
<th>Q.ta Assegnata</th>
<th>Luogo</th>
<th>Note</th>
<th>ID Intervento</th>
 <th>Azioni</th> 
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_milestone }" var="milestone" varStatus="loop">
	<tr id="row_${loop.index}" >
 	<td></td>
		
	<td>${milestone.intervento.idCommessa }</td>
	<td>${milestone.intervento.nome_cliente }</td>	
	<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${milestone.data}" /></td>
	<td>${milestone.user.nominativo }</td>
	<td onClick="showText('${milestone.descrizioneMilestone.replace('\'','#') }', '${loop.index}','5')">${utl:maxChar(milestone.descrizioneMilestone, 50)}</td>
	<td>${milestone.prezzo_un }</td>	
	<td>${milestone.presso_assegnato }</td>
	<td>${milestone.unita_misura }</td>
	<td>${milestone.quantitaTotale }</td>
	<td>${milestone.quantitaAssegnata }</td>
	
	<td>
		<c:choose>
		  <c:when test="${milestone.intervento.pressoDestinatario == 0}">
				<span class="label label-success">IN SEDE</span>
		  </c:when>
		  <c:when test="${milestone.intervento.pressoDestinatario == 1}">
				<span class="label label-info">PRESSO CLIENTE</span>
		  </c:when>
		    <c:when test="${milestone.intervento.pressoDestinatario == 2}">
				<span class="label label-warning">MISTO CLIENTE - SEDE</span>
		  </c:when>
		  <c:otherwise>
		    <span class="label label-info">-</span>
		  </c:otherwise>
		</c:choose> 
	</td>
	<td >${milestone.note}</td>
	<%-- <td onClick="showText('${milestone.note }', '${loop.index}','7')">${utl:maxChar(milestone.note, 10)}</td> --%>
	<td><a class="btn customTooltip customlink" onClicK="callAction('gestioneInterventoDati.do?idIntervento=${utl:encryptData(milestone.intervento.id)}')" >${milestone.intervento.id }</a></td>
 	<td>
		<a class="btn btn-warning" onClicK="modalModificaAssegnazione('${milestone.prezzo_un}','${milestone.presso_assegnato}','${milestone.quantitaTotale}','${milestone.quantitaAssegnata}','${milestone.note}','${milestone.unita_misura }','${milestone.id}')" ><i class="fa fa-edit"></i></a>
		<a class="btn btn-danger" onClicK="modalYesOrNo('${milestone.id}')" ><i class="fa fa-trash"></i></a>
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
       <input class="form-control" id="prezzo_unitario" type="text" name="prezzo_unitario" readonly/>
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
                      <input class="form-control" id="quantita_totale" type="text" name="quantita_totale" readonly/>
    </div>
         	<div class="col-md-9" >
        <label  >Quantità Assegnata:</label>
        </div>
        <div class="col-md-12">
                      <input class="form-control" id="quantita_assegnata" type="text" name="quantita_assegnata"/>
    </div>
    <div class="col-md-9" >
        <label  >Unità di misura:</label>
        </div>
        <div class="col-md-12">
                      <input class="form-control" id="unita_misura" type="text" name="unita_misura"/>
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

function modalModificaAssegnazione(prezzo_unitario, prezzo_assegnato, quantita_totale, quantita_assegnata, note,unita_misura, id){
	
	$('#id_assegnazione').val(id);
	$('#prezzo_unitario').val(prezzo_unitario);
	$('#prezzo_assegnato').val(prezzo_assegnato);
	$('#quantita_totale').val(quantita_totale);
	$('#quantita_assegnata').val(quantita_assegnata);
	$('#note').val(note);	
	$('#unita_misura').val(unita_misura)
	
	
	$('#myModalModificaAssegnazione').modal();
}


function submitModifica(){
	 var prezzo_unitario = $('#prezzo_unitario').val();
	 var prezzo_assegnato = $('#prezzo_assegnato').val();
	 var quantita_totale = $('#quantita_totale').val();
	 var quantita_assegnata = $('#quantita_assegnata').val();	  
	 var note = $('#note').val();
	 var id_assegnazione = $('#id_assegnazione').val();
	 var unita_misura = $('#unita_misura').val();
	 
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
		 modificaAssegnazioneAdmin();
	 }
	 
}


var columsDatatables = [];

$("#tabAssegnazioneAttivita").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAssegnazioneAttivita thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabVerInterventi thead th').eq( $(this).index() ).text();
    	
    	  if($(this).index()!=0){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	}
    	  
    	//  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );

 function showText(text, riga, cella){
	
	 text = text.replace('#','\'')
	 
	table = $('#tabAssegnazioneAttivita').DataTable();
	
	
	if( table.cell(parseInt(riga), parseInt(cella) ).data().length>53){
		
		table.cell(parseInt(riga), parseInt(cella) ).data(text.substring(0,50)+"...").draw();
		
	}else{
		 table.cell(parseInt(riga), parseInt(cella) ).data(text).draw();
			
	}
	     

} 

	function contaImportoTotale(table){
		
		//var table = $("#tabPM").DataTable();
		
		var data = table
	     .rows({ search: 'applied' })
	     .data();
		var somma = 0.0;
		for(var i=0;i<data.length;i++){	
			var num = parseFloat(stripHtml(data[i][7]));
			somma = somma + num;
		}
		$('#importo_assegnato').val(somma.toFixed(2));
	}
	
	$('#quantita_assegnata').change(function(){
		
		var qta = $(this).val();
		var prezzo = $('#prezzo_unitario').val();
		
		var prezzo_ass = qta*prezzo;
		if((""+prezzo_ass).includes(".",0)){
			$('#prezzo_assegnato').val(prezzo_ass);
		}else{
			$('#prezzo_assegnato').val(prezzo_ass+".00");	
		}
		
		
		
	});
	


$(document).ready(function(){
	
	
	 table = $('#tabAssegnazioneAttivita').DataTable({
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
	        "order": [[ 3, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		         
		      columnDefs: [
		    	 
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 11 },
		    	 
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
		
		table.buttons().container().appendTo( '#tabAssegnazioneAttivita_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAssegnazioneAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	contaImportoTotale(table);

	table.on( 'search.dt', function () {
		contaImportoTotale(table);
	} );
	
});


</script>