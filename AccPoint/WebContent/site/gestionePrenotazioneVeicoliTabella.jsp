
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.PaaVeicoloDTO"%>

<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.Date" %>

<%

ArrayList<PaaVeicoloDTO> lista_veicoli = (ArrayList<PaaVeicoloDTO>) request.getSession().getAttribute("lista_veicoli");
int anno = (Integer) request.getSession().getAttribute("anno");

//Integer.parseInt((String) request.getSession().getAttribute("daysNumber"));
/* ArrayList<ForPiaPianificazioneDTO> lista_prenotazioni = (ArrayList<ForPiaPianificazioneDTO>) request.getSession().getAttribute("lista_prenotazioni"); */
%>


 <table id="tabPrenotazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th>ID VEICOLO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
               <th>TARGA <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
                <th>MODELLO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
           <c:set var ="nuovoAnno" value="${anno + 1}"></c:set>                
         <c:forEach var="day" begin="${start_date }" end="${end_date }" step="1">
         
      <% 
      int dayValue =  (Integer) pageContext.getAttribute("day");
   
      int end_date =  (Integer) request.getSession().getAttribute("end_date");
     
/*       if(LocalDate.ofYearDay(anno, 1).isLeapYear()){
    	 if(dayValue>366){
    		 System.out.println("Bisestile");
    		 dayValue =  dayValue-366;
    		 anno = Integer.parseInt(""+pageContext.getAttribute("nuovoAnno"));
    	 }
    	  
      }else{ */
    	  if(dayValue>365){
     		 dayValue = dayValue-365 ;
     		 anno = Integer.parseInt(""+pageContext.getAttribute("nuovoAnno"));
     	 }
    //  }
      if (dayValue <= 0) {
    	    dayValue = 1;
    	}
      
 
        LocalDate localDate = LocalDate.ofYearDay(anno, dayValue);
        LocalDateTime localDateTime = localDate.atStartOfDay();
        Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
        ArrayList<LocalDate> festivitaItaliane = (ArrayList<LocalDate>) request.getSession().getAttribute("festivitaItaliane");
        
        if(localDate.getDayOfWeek().getValue() == 6 || localDate.getDayOfWeek().getValue() == 7){
      %>
       <th class="weekend">
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
                <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div>
            </th>
            
            <%}else if(festivitaItaliane.contains(localDate)){ %>
              <th >
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
                
                <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div>
            </th>
            <%}else{ %>
      
      <th >
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
                
                <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div>
            </th>
         <%} %>
      

      
    </c:forEach>
            </tr >
        </thead>
        <tbody>
      
          <c:forEach  items="${lista_veicoli }" var="veicolo">
         <tr id="${veicolo.id}">
        
         <td data-toggle="tooltip">
        ${veicolo.id}
         </td>
         <td>${veicolo.targa}</td>
         <td>${veicolo.modello}</td>

         <c:forEach var="day" begin="${start_date }" end="${end_date}" step="1">
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day>366 }">
			<td id="${veicolo.id}_${day-366}" ></td> 
			</c:if>
			<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
			<td id="${veicolo.id}_${day-365}" ></td> 
			</c:if>
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
			<td id="${veicolo.id}_${day}" ></td> 
			</c:if>
         	<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
			<td id="${veicolo.id}_${day}" ></td> 
			</c:if>
         	<%-- <td id="${veicolo.id}_${day}" ondblclick="modalPrenotazione('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
         	<%-- <td id="${veicolo.id}_${day}"></td> --%>
         </c:forEach>
         

  <%--   </c:forEach> --%>
         
         </tr>
  </c:forEach> 
         
        

                </tbody>
    </table>
    
   

    

    
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/1.10.13/js/dataTables.bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/fixedcolumns/3.2.2/js/dataTables.fixedColumns.min.js"  type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/responsive/2.1.1/js/dataTables.responsive.min.js"  type="text/javascript" charset="utf-8"></script>
 <script src="https://cdn.datatables.net/responsive/2.1.1/js/responsive.bootstrap.min.js"  type="text/javascript" charset="utf-8"></script>
 <script src=" https://code.jquery.com/jquery-3.3.1.js"  type="text/javascript" charset="utf-8"></script>
 <script src=" https://datatables.net/release-datatables/media/js/jquery.dataTables.js"  type="text/javascript" charset="utf-8"></script>
 <script src=" https://datatables.net/release-datatables/media/js/dataTables.bootstrap4.js"  type="text/javascript" charset="utf-8"></script>
 <script src=" https://datatables.net/release-datatables/extensions/FixedColumns/js/dataTables.fixedColumns.js"  type="text/javascript" charset="utf-8"></script>

<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.1/css/bootstrap.css"> -->
	<link rel="stylesheet" href="https://datatables.net/release-datatables/media/css/dataTables.bootstrap4.css">
	<link rel="stylesheet" href="https://datatables.net/release-datatables/extensions/FixedColumns/css/fixedColumns.bootstrap4.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
 
<style>
<!--



 .tooltip {
    position: absolute;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 4px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  


}


 .legend {
  display: flex;
}

.legend-item {
  display: flex;
  align-items: center;
  margin-right: 10px;
}

.legend-color {
  width: 20px;
  height: 20px;
}

.legend-label {
  margin-left: 5px;
}


/*     .riquadro {
      border: 1px solid red;
      padding: 5px;
 
        cursor: move;
      
} */

/*     .prenotato {
        //background-color: #FFD700; 
    } */
        .prenotato {
        
    }

    .riquadro {
      border: 1px solid red;
      padding: 5px;
      position: absolute;
}


#tabPrenotazione tbody tr {
    width: auto !important;
}

#tabPrenotazione tbody tr {
    height: auto !important; /* Imposta l'altezza della riga su 'auto' */
}

</style>


 
 
    <script type="text/javascript">  
    
    


function modalPrenotazione(day, id_veicolo, id_prenotazione){

	var currentYear = new Date().getFullYear()
	var dayValue = parseInt(day);
	var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
	var d = localDate.getUTCDate();
	var month = localDate.getUTCMonth() + 1; 
	var year = localDate.getUTCFullYear();
	var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
	
	var cell = $('#'+id_veicolo+"_"+day);
	var text = cell.text()
	
	if(text!=null && text!='' && id_prenotazione!=null && id_prenotazione!=''){
		

		dataObj ={};
		dataObj.id = id_prenotazione;
		
		callAjax(dataObj, "gestioneParcoAuto.do?action=dettaglio_prenotazione", function(data){
			
			var prenotazione = data.prenotazione;
			
			
			$('#utente').val(prenotazione.utente.id);
			$('#utente').change();	
			
			$('#data_inizio').val(prenotazione.data_inizio_prenotazione.split(" ")[0]);
			
			var dayValue = parseInt(prenotazione.cella_fine);
			var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
			var d = localDate.getUTCDate();
			var month = localDate.getUTCMonth() + 1; 
			var year = localDate.getUTCFullYear();
			var formattedDateFine = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
			
			
			$('#data_fine').val(prenotazione.data_fine_prenotazione.split(" ")[0]);
			
			$('#ora_inizio').val(prenotazione.data_inizio_prenotazione.split(" ")[1]);
			$('#ora_fine').val(prenotazione.data_fine_prenotazione.split(" ")[1]);
			
			$('#day').val(day);
			$('#id_veicolo').val(id_veicolo);
			$('#id_prenotazione').val(id_prenotazione);
			
			$('#nota').val(prenotazione.nota);
		
			$('#btn_elimina').show()
			
		});
		
	}else{
		
		if(cell.hasClass("prenotato")){
			
			var riquadriIds = cell.find('div').map(function() {
			    return this.id;
			}).get();
			
			var data_fine = [];
			var ora_fine = [];
			orariDisabilitati = [];
			var promises = []; // Array per memorizzare le promesse

			riquadriIds.forEach(function(riquadroId) {
			    dataObj = {};
			    dataObj.id = riquadroId.split("_")[1];

			    // Crea una nuova promessa per ogni chiamata AJAX
			    var promise = new Promise(function(resolve, reject) {
			        callAjax(dataObj, "gestioneParcoAuto.do?action=dettaglio_prenotazione", function(data) {
			            var prenotazione = data.prenotazione;
			            
			            var obj = {};

			            data_fine.push(prenotazione.data_fine_prenotazione);
			            
			            obj.inizio = prenotazione.data_inizio_prenotazione.split(" ")[1]
			            obj.fine = prenotazione.data_fine_prenotazione.split(" ")[1]
			        	
			            orariDisabilitati.push(obj);
			            // Risolve la promessa quando la chiamata AJAX è completata
			            resolve();
			        });
			    });

			    // Aggiungi la promessa all'array
			    promises.push(promise);
			});

			// Attendere il completamento di tutte le chiamate AJAX
			Promise.all(promises).then(function() {

				$('#utente').val("");
				$('#utente').change();
				$('#id_prenotazione').val("");			
				$('#data_inizio').val(formattedDate);
				$('#data_fine').val(formattedDate);
				$('#day').val(day);
				$('#id_veicolo').val(id_veicolo);
			});
			

			
			
		}else{
			
			$('#utente').val("");
			$('#utente').change();
			$('#id_prenotazione').val("");
			$('#data_inizio').val(formattedDate);
			$('#data_fine').val(formattedDate);
			$('#day').val(day);
			$('#id_veicolo').val(id_veicolo);
			$('#ora_inizio').val(formattedDate);
			$('#ora_fine').val(formattedDate);
		}
		
	
	}


	$('#modalPrenotazione').modal()

	
}





 columsDatatables=[]




var settings ={
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
    dom: 'rt<"bottom"ip>',
    pageLength: 100,
  
      paging: false, 
      ordering: true,
      info: true, 
      searchable: false, 
//      targets: 0,
      responsive: false,
      scrollX: "100%",
      searching: true,
      scrollY: "700px",
      "autoWidth": false,
      
        fixedColumns: {
          leftColumns: 3, // Numero di colonne fisse
      },  
      
      stateSave: false,	
           
      columnDefs: [
    	  {
    		  targets: '_all',
    		 createdCell: editableCell
    	  } 
    	  
    	  
               ], 	
               

   
	      buttons: [   
	     {
				 extend: 'excel',
  	            text: 'Esporta Excel'  
			  } ]
               
    } 


/*     function editableCell(cell) {
	
	
	 $(cell).on('click', function() {
         $('.selected-cell').removeClass('selected-cell');
         $('.button_add').remove();
         $(this).addClass('selected-cell');
         var cellId = $(this).attr('id');
         var rowId =  $(this).closest('tr').attr('id');
         
         var riquadroPresente = $(this).find('.riquadro').length > 0;
         
         if(document.getElementById('button_add_'+cellId) != null){
        		 
         }else{
        	 

				
        	  $(this).append('<div><button class="button_add btn btn-primary btn-sm" id="button_add_'+cellId+'\" onclick="modalPrenotazione(\''+cellId.split("_")[1]+'\', \''+cellId.split("_")[0]+'\')" style="margin-top:5px"><i class="fa fa-plus"></i></button></div>');  
         }
         
       });

	
	
	}  */

	
	function editableCell(cell) {
	    $(cell).on('click', function() {
	        $('.selected-cell').removeClass('selected-cell');
	        $('.button_add').remove();
	        $(this).closest('tr').children('td').height(nuovaAltezzaRiga);
	        $(this).addClass('selected-cell');
	        var cellId = $(this).attr('id');
	        var rowId = $(this).closest('tr').attr('id');

	        var $buttonContainer = $('<div>'); // Crea un contenitore per il pulsante
	        $(this).css('height','auto');
	        // Verifica se ci sono riquadri nella cella
	        var riquadri = $(this).find('.riquadro');
	        if (riquadri.length > 0) {
	            // Se ci sono riquadri, calcola la posizione del pulsante sotto all'ultimo riquadro
	            var ultimoRiquadro = riquadri.last();
	            var ultimaPosizione = ultimoRiquadro[0].offsetTop +  ultimoRiquadro[0].offsetHeight + 3; // Aggiungi 5 pixel di spazio
	            $buttonContainer.appendTo($(this)).css('position', 'absolute').css('top', ultimaPosizione).css('height','auto');
	            
	            var numeroRiquadri = riquadri.length;
	            var altezzaRiga = $(this).height();
	            var nuovaAltezzaRiga = 35 + numeroRiquadri  * ultimoRiquadro[0].offsetHeight;
	            if(altezzaRiga<=nuovaAltezzaRiga){
	            	   
	   	        
	   	             $(this).closest('tr').children('td').height(nuovaAltezzaRiga);
	            }
	         
	            
	        } else {
	            // Se non ci sono riquadri, aggiungi il pulsante direttamente alla cella
	            $buttonContainer.appendTo($(this));
	        }

	        // Aggiungi il pulsante al contenitore
	        $('<button>').addClass('button_add btn btn-primary btn-sm')
	                     .attr('id', 'button_add_' + cellId)
	                     .attr('onclick', "modalPrenotazione('" + cellId.split("_")[1] + "', '" + cellId.split("_")[0] + "')")
	                     .html('<i class="fa fa-plus"></i>')
	                     .css('margin-top', '5px')
	                     .appendTo($buttonContainer);
	    });
	    
	    
	
	}



$(window).on('load', function() {
	
	  pleaseWaitDiv.modal('hide');
});


var order = 1;

$(document).ready(function() {
	
	console.log("dentro")


         fillTable("${anno}",'${filtro_tipo_pianificazioni}');
	
	


	    $('[data-toggle="tooltip"]').tooltip();

	    $(document.body).css('padding-right', '0px');

/* 	    var table = $('#tabPrenotazione').DataTable();
	    $('#tabPrenotazione tbody').on('click', 'td', function () {
	    	 var cellaPartenza = $(this);
	         var cellaArrivo = cellaPartenza.next(); // Esempio: consideriamo la cella successiva, puoi modificare secondo necessità
	         var posizionePartenza = cellaPartenza.offset(); // Utilizza offset invece di position
	         var posizioneArrivo = cellaArrivo.offset(); // Utilizza offset invece di position

	         // Calcola le dimensioni e le coordinate del riquadro relative alla tabella
	         var larghezza = Math.abs(posizioneArrivo.left - posizionePartenza.left + cellaPartenza.outerWidth());
	         var altezza = Math.abs(posizioneArrivo.top - posizionePartenza.top + cellaPartenza.outerHeight());
	         var sinistra = Math.min(posizionePartenza.left, posizioneArrivo.left) - $('#tabPrenotazione').offset().left;
	         var alto = Math.min(posizionePartenza.top, posizioneArrivo.top) - $('#tabPrenotazione').offset().top;

	         // Rimuovi eventuali riquadri precedenti
	         $('.riquadro').remove();

	         // Aggiungi il riquadro alla tabella
	         $('<div>').addClass('riquadro').css({
	             left: sinistra,
	             top: alto,
	             width: larghezza,
	             height: altezza
	         }).appendTo('#tabPrenotazione');
	    }); */
	
});



function impostaOrarioMinMax(min, max) {
    $('.timepicker').timepicker('option', {
        minTime: min,
        maxTime: max
    });
}

/* function fillTable(anno, filtro){


console.log("dddd")


	
	$.ajax({
		  url: 'gestioneParcoAuto.do?action=lista_prenotazioni&anno='+anno, // Specifica l'URL della tua servlet
		  method: 'GET',
		  dataType: 'json',
		  success: function(response) {
		    // Recupera il JSONElement dalla risposta
		    var lista_prenotazioni = response.lista_prenotazioni;
		    var is_modifica = response.is_modifica;
		    
		    var array = [];
		    var array_in_corso = [];
		    var day = [];
		    var map = {};
		    
		
		    var t = document.getElementById("tabPrenotazione");
		    var rows = t.rows;
		    for (var i = 1; i < rows.length; i++) {
		    	
		        var cells = rows[i].cells;
		        for (var j = 3; j < cells.length; j++) {
		          cells[j].innerHTML = "";
		          cells[j].classList.remove("prenotato");
		        }
		      }
		    for (var i = 0; i < lista_prenotazioni.length; i++) {
		    	var id_inizio = lista_prenotazioni[i].veicolo.id+"_"+lista_prenotazioni[i].cella_inizio;
				var cellaInizio = $("#"+id_inizio);
				var num_giorni = lista_prenotazioni[i].cella_fine - lista_prenotazioni[i].cella_inizio;
	
				var id_fine = lista_prenotazioni[i].veicolo.id+"_"+lista_prenotazioni[i].cella_fine;
				var cellaFine = $("#"+id_fine);
	
				
				 var cellePrenotate = [];
				 if(id_inizio!=id_fine){
					 cellePrenotate=  $('#' + id_inizio).nextUntil('#' + id_fine).addBack(); // Seleziona tutte le celle tra quella di inizio e quella di fine inclusa
					 cellePrenotate = cellePrenotate.add($('#' + id_fine));
				 }else{
					 cellePrenotate=  $('#' + id_inizio);
				 }
				 
				 
				 
				 colspan = cellePrenotate.length;

			     var id_prenotazione = lista_prenotazioni[i].id;
			     var tdElement = document.getElementById(id_inizio);
			   
			     $('#' + id_inizio).addClass('prenotato');
			     //cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPianificazione(\'"+lista_pianificazioni[i].nCella+"\', \'"+lista_pianificazioni[i].id_commessa+"\',\'"+lista_pianificazioni[i].id+"\')\">"+lista_pianificazioni[i].descrizione.substring(0,20)+"...</div>");
			     if(colspan>1){
			    	 
			    	 $('#' + id_inizio).attr('colspan', colspan).append("<div  class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:5px' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+lista_prenotazioni[i].utente.nominativo+"</div>").css('text-align', 'center');
			    	 
			    	   
			    	   //$('#' + id_inizio).attr('colspan', colspan).append(lista_prenotazioni[i].utente.nominativo).css('text-align', 'center');

						 $('#'+ id_inizio.split("_")[0]+"_"+(parseInt(id_inizio.split("_")[1])+1)).css('display', 'none');
						 $('#'+ id_fine).css('display', 'none');
			     }else{
			    	
			    	 $('#' + id_inizio).append("<div  class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:5px' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+lista_prenotazioni[i].utente.nominativo+"</div>").css('text-align', 'center');
			    	// $('#' + id_inizio).append(lista_prenotazioni[i].utente.nominativo).css('text-align', 'center');
			     }
			  
				 
		
			
        }

			console.log("ciao")			
			var today = "${today}"
			if(today>"${daysNumber}"){
				today = null;
			}else{
				order = parseInt(today) +3
			}
		
			
				if(table == null){
				    table = $('#tabPrenotazione').DataTable(settings);
				  
				}else{
					table = $('#tabPrenotazione').DataTable();
				}
				
			
		
			    
	    $('.inputsearchtable').on('input', function() {
		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

	    table.column(columnIndex).search(searchValue).draw();
		    
		  });
	  
	    
	  $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
			
	
      $('.prenotato').each(function() {
          editableCell(this);
      });
	  
	  table.columns.adjust().draw();
	  scrollToColumn(parseInt(today)-3);


		  
		  },
		  error: function(xhr, status, error) {
		    // Gestisci eventuali errori
		    console.error(status);
		  }
		  
		  
		  

		  
		});
	
	
	

}

 */

 
 
 function fillTable(anno, filtro) {
	    console.log("dddd");

	    $.ajax({
	        url: 'gestioneParcoAuto.do?action=lista_prenotazioni&anno=' + anno,
	        method: 'GET',
	        dataType: 'json',
	        success: function(response) {
	            var lista_prenotazioni = response.lista_prenotazioni;
	            $('.riquadro').remove();

	            if(table == null){
				    table = $('#tabPrenotazione').DataTable(settings);
				  
				}else{
					table = $('#tabPrenotazione').DataTable();
				}
	            
	            for (var i = 0; i < lista_prenotazioni.length; i++) {
	                var id_inizio = lista_prenotazioni[i].veicolo.id + "_" + lista_prenotazioni[i].cella_inizio;
	                var id_fine = lista_prenotazioni[i].veicolo.id + "_" + lista_prenotazioni[i].cella_fine;
	                var id_prenotazione = lista_prenotazioni[i].id;

	                var cellaInizio = $("#" + id_inizio);
	                var cellaFine = $("#" + id_fine);

	                var posizionePartenza = cellaInizio.offset();
	                var posizioneArrivo = cellaFine.offset();
	                
	               // var larghezza = cellaInizio.outerWidth();
	                var larghezza = Math.abs(posizioneArrivo.left - posizionePartenza.left + cellaInizio.outerWidth());
	               // var altezza = cellaInizio.outerHeight();
	                var altezza = 36;
	               

	       
	                var sinistra = posizionePartenza.left - $('#tabPrenotazione').offset().left;
	                var alto = posizionePartenza.top - $('#tabPrenotazione').offset().top;

	                // Verifica se ci sono già riquadri presenti nella cella
	                var numeroRiquadri = cellaInizio.find('.riquadro').length;
	                
	                var nuovaAltezzaRiga = (numeroRiquadri + 1) * 50; // +1 per includere il nuovo riquadro

	                // Aggiorna l'altezza della riga
	                cellaInizio.closest('tr').children('td').height(nuovaAltezzaRiga);

	                
	                if (numeroRiquadri === 0) {
	                    // Se non ci sono riquadri presenti, aggiungi normalmente il nuovo riquadro
	                    $("<div  class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:5px' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+lista_prenotazioni[i].utente.nominativo+"</div>").addClass('riquadro').css({
	                        left: sinistra,
	                        top: alto,
	                        width: larghezza,
	                        height: altezza,
	                        'text-align': 'center'
	                    }).appendTo(cellaInizio);
	                } else {
	                    // Se ci sono già riquadri presenti, aggiungi il nuovo riquadro sotto a quelli esistenti
	                    var ultimoRiquadro = cellaInizio.find('.riquadro:last');
	                    var altezzaUltimoRiquadro = ultimoRiquadro.height();
	                    var posizioneUltimoRiquadro = ultimoRiquadro.position();
	                    var distanzaVerticale = 15; // Distanza verticale tra i riquadri

	                  

	                 // Calcola la posizione verticale del nuovo riquadro
	                 var nuovaPosizioneVerticale = posizioneUltimoRiquadro.top + altezzaUltimoRiquadro + distanzaVerticale;

	                 // Verifica se il nuovo riquadro si sovrappone con il successivo
	                 if (cellaInizio.find('.riquadro:eq(1)').length > 0) {
	                     var altezzaRiquadroSuccessivo = cellaInizio.find('.riquadro:eq(1)').height();
	                     if (nuovaPosizioneVerticale + altezza > posizioneUltimoRiquadro.top + altezzaRiquadroSuccessivo) {
	                         nuovaPosizioneVerticale = posizioneUltimoRiquadro.top + altezzaRiquadroSuccessivo + distanzaVerticale;
	                     }
	                 }

	                 // Aggiungi il nuovo riquadro sotto a quelli esistenti
	                  $("<div  class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:5px' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+lista_prenotazioni[i].utente.nominativo+"</div>").addClass('riquadro').css({
	                     left: posizioneUltimoRiquadro.left,
	                     top: nuovaPosizioneVerticale,
	                     width: larghezza,
	                     height: altezza,
	                     'text-align': 'center'
	                 }).appendTo(cellaInizio);
	                }
	               
	            }

	            console.log("ciao");

	            var today = "${today}";
	            if (today > "${daysNumber}") {
	                today = null;
	            } else {
	                order = parseInt(today) + 3;
	            }

	           
	            table.columns.adjust().draw();
	           
	            scrollToColumn(parseInt(today) - 3);
	        },
	        error: function(xhr, status, error) {
	            console.error(status);
	        }
	    });
	}


function filterTable() {
    var table = $('#tabPrenotazione');
    var rows = table.find('tr:gt(0)');
    
    rows.each(function() {
        var row = $(this);
        var hideRow = true;
        
        row.find('td:gt(2)').each(function() { // Inizia dalla quarta colonna (indice 3)
          if ($(this).text() !== '') {
            hideRow = false;
            return false; // Esci dal loop interno se una cella non è vuota
          }
        });
        
        if (hideRow) {
          row.hide(); // Nascondi le righe con tutte le celle vuote a partire dalla quarta colonna
        } else {
          row.show(); // Mostra le righe con almeno una cella piena a partire dalla quarta colonna
        }
      });
  }


function scrollToColumn(columnIndex) {
    var tableWrapper = $('#tabPrenotazione_wrapper');
    var scrollBody = tableWrapper.find('.dataTables_scrollBody');
    var scrollHead = tableWrapper.find('.dataTables_scrollHead');
    var columnWidths = scrollHead.find('th').map(function() {
        return $(this).outerWidth();
    }).get();
    
    var scrollLeft = 0;
    for (var i = 0; i < columnIndex; i++) {
        scrollLeft += columnWidths[i];
    }
    
    scrollBody.animate({ scrollLeft: scrollLeft }, 500);
}


function rgbToHex(rgb) {
	  var parts = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
	  delete parts[0];
	  for (var i = 1; i <= 3; ++i) {
	    parts[i] = parseInt(parts[i]).toString(16);
	    if (parts[i].length === 1) parts[i] = '0' + parts[i];
	  }
	  return '#' + parts.join('');
	}


</script>