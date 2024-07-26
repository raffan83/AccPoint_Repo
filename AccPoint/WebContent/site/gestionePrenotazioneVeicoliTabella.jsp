
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
<%@ page import="java.util.Locale" %>


<%

ArrayList<PaaVeicoloDTO> lista_veicoli = (ArrayList<PaaVeicoloDTO>) request.getSession().getAttribute("lista_veicoli");
int anno = (Integer) request.getSession().getAttribute("anno");

//Integer.parseInt((String) request.getSession().getAttribute("daysNumber"));
/* ArrayList<ForPiaPianificazioneDTO> lista_prenotazioni = (ArrayList<ForPiaPianificazioneDTO>) request.getSession().getAttribute("lista_prenotazioni"); */
%>


 <table id="tabPrenotazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th >ID VEICOLO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  id="inputsearchtable_0" /></th>
               <th>TARGA <input class="inputsearchtable" style="min-width:80px;width=100%" type="text" id="inputsearchtable_1"  /></th>
                <th>MODELLO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text" id="inputsearchtable_2"  /></th>
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
        String dayOfWeekString = localDate.getDayOfWeek().getDisplayName(
                java.time.format.TextStyle.FULL,
                Locale.ITALIAN
            ).toUpperCase();
        
        if(localDate.getDayOfWeek().getValue() == 6 || localDate.getDayOfWeek().getValue() == 7){
      %>
       <th class="weekend" style="text-align:center">
       <c:out value="<%=dayOfWeekString %>"></c:out>
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
               <!--  <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div> -->
            </th>
            
            <%}else if(festivitaItaliane.contains(localDate)){ %>
              <th class="weekend" style="text-align:center">
               <c:out value="<%=dayOfWeekString %>"></c:out>
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
                
                <!-- <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div> -->
            </th>
            <%}else{ %>
      
      <th style="text-align:center">
       <c:out value="<%=dayOfWeekString %>"></c:out>
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
                <!-- 
                <div><input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></div> -->
            </th>
         <%} %>
      

      
    </c:forEach>
            </tr >
        </thead>
        <tbody>
      
          <c:forEach  items="${lista_veicoli }" var="veicolo">
         <tr id="${veicolo.id}" >
        
         <td id = "col_1_${veicolo.id}">
       <b>${veicolo.id}</b>
         </td>
         <td id = "col_2_${veicolo.id}" ><b>${veicolo.targa}</b></td>
         <td id = "col_3_${veicolo.id}"><b>${veicolo.modello}</b></td>

         <c:forEach var="day" begin="${start_date }" end="${end_date}" step="1">
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day>366 }">
			<td  id="${veicolo.id}_${day-366}" style="position:relative"></td> 
			</c:if>
			<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
			<td id="${veicolo.id}_${day-365}" style="position:relative"></td> 
			</c:if>
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
			<td  id="${veicolo.id}_${day}" style="position:relative"></td> 
			</c:if>
         	<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
			<td  id="${veicolo.id}_${day}" style="position:relative"></td> 
			</c:if>
         	<%-- <td id="${veicolo.id}_${day}" ondblclick="modalPrenotazione('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
         	<%-- <td id="${veicolo.id}_${day}"></td> --%>
         </c:forEach>
         

  <%--   </c:forEach> --%>
         
         </tr>
  </c:forEach> 
         
        

                </tbody>
    </table>
    
   

    <ul class='custom-menu'>
  <li data-action = "copy">Copia</li>
  <li data-action = "paste">Incolla</li>
  <li data-action = "delete">Elimina</li>
</ul>

    
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







        .prenotato {
        
    }

     .riquadro {
      border: 1px solid red;
      padding: 5px;
      position:absolute;
 
} 

#tabPrenotazione tbody tr {
    width: auto !important;
    height: 100px !important;
    overflow: hidden;
}

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



</style>


 
 
    <script type="text/javascript">  
    
    

    


function modalPrenotazione(day, id_veicolo, id_prenotazione){
	
	

	if(permesso == "true"){
		
		var currentYear = new Date().getFullYear()
		var dayValue = parseInt(day);
		var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
		var d = localDate.getUTCDate();
		var month = localDate.getUTCMonth() + 1; 
		var year = localDate.getUTCFullYear();
		var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
		
		var cell = $('#'+id_veicolo+"_"+day);
		var text = cell.text()
		
				$('#ora_inizio').timepicker('remove');
				$('#ora_fine').timepicker('remove');
				
		
		if(text!=null && text!='' && id_prenotazione!=null && id_prenotazione!=''){
			

			dataObj ={};
			dataObj.id = id_prenotazione;
			
			callAjax(dataObj, "gestioneParcoAuto.do?action=dettaglio_prenotazione", function(data){
				
				var prenotazione = data.prenotazione;
				
				var obj = {};
	            
				if(prenotazione.manutenzione == 1){
					$('#manutenzione').iCheck('check');
				}else{
					$('#manutenzione').iCheck('uncheck');
					$('#utente').val(prenotazione.utente.id);
					$('#utente').change();	
				}
				
				if(prenotazione.rifornimento == 1){
					$('#rifornimento').iCheck('check');
				}else{
					$('#rifornimento').iCheck('uncheck');
				
				}
			
				$('#stato').val(prenotazione.stato_prenotazione);
				$('#stato').change();
				$('#content_stato').show()
				
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
	 			initializeTimepicker(prenotazione.data_inizio_prenotazione.split(" ")[1], prenotazione.data_fine_prenotazione.split(" ")[1]);
		
				$('#day').val(day);
				$('#id_veicolo').val(id_veicolo);
				$('#id_prenotazione').val(id_prenotazione);
				
				$('#note').val(prenotazione.note);
			
				$('#btn_elimina').show()
				
			});
			
		}else{
			
			if(cell.hasClass("prenotato")){
				
				var riquadriIds = cell.find('div').map(function() {
					if(this.id!=''){
						return this.id;
					}
				    
				}).get();
				
				
				  if (cell.hasClass('prenotato') && riquadriIds.length === 0) {
			            // Se la cella ha la classe "prenotato" ma non ha riquadri, cerca nella cella precedente
			            var cellaPrecedente = cell.prev();
			            while (cellaPrecedente.length > 0) {
			            	riquadriIds = cellaPrecedente.find('div').map(function() {
			    				if(this.id!=''){
			    					return this.id;
			    				}
			    			    
			    			}).get();
			                if (riquadriIds.length > 0) {
			                    break; // Riquadro trovato nella cella precedente, interrompi il ciclo
			                }
			                cellaPrecedente = cellaPrecedente.prev();
			            }
			        }
				
				var data_fine = [];
				var ora_fine = [];
			//	orariDisabilitati = [];
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
				            
				            obj.inizio = prenotazione.data_inizio_prenotazione
				            obj.fine = prenotazione.data_fine_prenotazione
				            obj.id = prenotazione.id
				        	
				           
				        	
				           // orariDisabilitati.push(obj);
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
					
					initializeTimepicker("08:00", "17:00");
				});
				

				
				
			}else{
				
				
				
				$('#utente').val("");
				$('#utente').change();
				$('#id_prenotazione').val("");
				$('#data_inizio').val(formattedDate);
				$('#data_fine').val(formattedDate);
				$('#id_veicolo').val(id_veicolo);
				$('#day').val(day);
				
				initializeTimepicker("08:00", "17:00");
			}
			
		
		}

		
	  

		$('#modalPrenotazione').modal()
		
	}
	

}




function initializeTimepicker(start, end) {
    $('#ora_inizio').timepicker({
        minuteStep: 5,
        disableTextInput: true,
        showMeridian: false,
        defaultTime: start, // Imposta l'orario di inizio predefinito
        // Callback per disabilitare gli orari sovrapposti
        
        disableTimeRanges: orariDisabilitati,
        beforeShow: function(input, instance) {
            var inizioPrenotazione  = moment($('#ora_inizio').val(), "HH:mm");
            var finePrenotazione  = moment($('#ora_fine').val(), "HH:mm");

            instance.$input.timepicker('setTimeDisabled', function(time) {
                return time.isBetween(inizioPrenotazione, finePrenotazione, null, '[)') ||
                    time.isBetween(inizioPrenotazione, finePrenotazione, null, '(]') ||
                    inizioPrenotazione.isBetween(time, finePrenotazione, null, '(]') ||
                    finePrenotazione.isBetween(time, finePrenotazione, null, '[)');
            });
        }
    }).on('changeTime.timepicker', function(e) {
        var inizio = moment($('#ora_inizio').val(), "HH:mm");
        var fine = moment($('#ora_fine').val(), "HH:mm");
    });

    $('#ora_fine').timepicker({
        minuteStep: 5,
        disableTextInput: true,
        showMeridian: false,
        defaultTime: end, // Imposta l'orario di fine predefinito
        // Callback per disabilitare gli orari sovrapposti
        beforeShow: function(input, instance) {
            var inizio = moment($('#ora_inizio').val(), "HH:mm");
            var fine = moment($('#ora_fine').val(), "HH:mm");

            instance.$input.timepicker('setTimeDisabled', function(time) {
                return time.isBetween(inizio, fine) || time.isSame(inizio) || time.isSame(fine);
            });
        }
    }).on('changeTime.timepicker', function(e) {
        var inizio = moment($('#ora_inizio').val(), "HH:mm");
        var fine = moment($('#ora_fine').val(), "HH:mm");
    });
}



 columsDatatables=[]
	var columsDatatables = [];
 




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
      //scrollTo: 'cell',
      searching: true,      
     scrollY: "1500px",
      "autoWidth": false,
      
         fixedColumns: {
          leftColumns: 3,
          heightMatch: 'auto'// Numero di colonne fisse
      },    
      
      stateSave: true,	
      columnDefs: [
    	  {
    		  targets: '_all',
    		 createdCell: editableCell
    	  } 
    	  
    	  
               ], 	
               fixedHeader: true, 

   
	      buttons: [   
	     {
				 extend: 'excel',
  	            text: 'Esporta Excel'  
			  } ]
               
    } 
 
 


var scrollPos;
	
	function editableCell(cell) {
	    $(cell).on('click', function() {
	    	 scrollPos = $(window).scrollTop();
	    	 var scrollPosition = $(this).closest('.dataTables_scrollBody').scrollTop();
	    	if(permesso == "true"){
	    	
	        $('.selected-cell').removeClass('selected-cell');
	        $('.button_add').remove();

	        $(this).addClass('selected-cell');
	        var cellId = $(this).attr('id');
	        var rowId = $(this).closest('tr').attr('id');

	        // Creazione del contenitore per il pulsante e il contenuto della cella
	        var $container = $('<div>').css('position', 'relative').css('height', 'auto');
	        var $buttonContainer = $('<div>').css('position', 'relative').css('top', '0').css('left', '0');
	        var $contentContainer = $('<div>').css('margin-top', '0px'); // Aggiungi margine per il pulsante

	        // Aggiungi il contenitore del pulsante e il contenitore del contenuto alla cella
	        $container.appendTo($(this)).append($buttonContainer).append($contentContainer);

	        // Aggiungi il pulsante al contenitore del pulsante
	        $('<button>').addClass('button_add btn btn-primary btn-sm')
	                     .attr('id', 'button_add_' + cellId)
	                     .attr('onclick', "modalPrenotazione('" + cellId.split("_")[1] + "', '" + cellId.split("_")[0] + "')")
	                     .html('<i class="fa fa-plus"></i>')
	                     .appendTo($buttonContainer);

	        table = $('#tabPrenotazione').DataTable()
	        table.draw(); 
	        $(window).scrollTop(scrollPos);
	        $(this).closest('.dataTables_scrollBody').scrollTop(scrollPosition);
	    	}
	    });
	}
	
	
	


	
	function updatePosition(currentRow, newHeight, oldHeight, edit) {
	    var nextRow = currentRow.next();
	    while (nextRow.length > 0) {
	        // Calcola la differenza tra l'altezza della riga precedente e quella successiva
	      //  
	        if(edit == 1){
	        	var heightDifference = newHeight - oldHeight;
	        }else{
	        	var heightDifference = 75;
	        }
	          

	        // Aggiorna la posizione verticale di ciascun riquadro nella riga successiva
	        nextRow.find('.riquadro').each(function() {
	            var currentTop = $(this).position().top;
	            var newTop = currentTop + heightDifference ; // Aggiungi la differenza di altezza per mantenere la posizione relativa
	            $(this).css('top', newTop);
	        });

	        nextRow = nextRow.next();
	    }
	}
	
	

	
$(window).on('load', function() {
	
	  pleaseWaitDiv.modal('hide');
});


function pastePrenotazione(day, veicolo){
	
	var id = cellCopy;
	
	dataObj ={};
	dataObj.id = id;
	
	callAjax(dataObj, "gestioneParcoAuto.do?action=dettaglio_prenotazione", function(data){
		
		var prenotazione = data.prenotazione;
		
		var obj = {};
        
		if(prenotazione.manutenzione == 1){
			$('#manutenzione').iCheck('check');
		}else{
			$('#manutenzione').iCheck('uncheck');
			$('#utente').val(prenotazione.utente.id);
			$('#utente').change();	
		}
	
		
		if(prenotazione.rifornimento == 1){
			$('#rifornimento').iCheck('check');
		}else{
			$('#rifornimento').iCheck('uncheck');
		
		}
		$('#stato').val(prenotazione.stato_prenotazione);
		$('#stato').change();
	
		
		
		var currentYear = new Date().getFullYear()
		var dayValue = parseInt(day);
		var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
		var d = localDate.getUTCDate();
		var month = localDate.getUTCMonth() + 1; 
		var year = localDate.getUTCFullYear();
		var formattedDateInizio = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
		
		$('#data_inizio').val(formattedDateInizio);
	
		
		var lunghezzaIntervallo = prenotazione.cella_fine - prenotazione.cella_inizio;
		
		if(lunghezzaIntervallo>0){
			var dayValue = parseInt(day)+lunghezzaIntervallo;
			var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
			var d = localDate.getUTCDate();
			var month = localDate.getUTCMonth() + 1; 
			var year = localDate.getUTCFullYear();
			var formattedDateFine= ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
		}else{
			var formattedDateFine=formattedDateInizio;
		}
		$('#data_fine').val(formattedDateFine);
		$('#ora_inizio').val(prenotazione.data_inizio_prenotazione.split(" ")[1]);
		$('#ora_fine').val(prenotazione.data_fine_prenotazione.split(" ")[1]);
			initializeTimepicker(prenotazione.data_inizio_prenotazione.split(" ")[1], prenotazione.data_fine_prenotazione.split(" ")[1]);

		$('#day').val(day);
		$('#id_veicolo').val(veicolo);
		
		$('#note').val(prenotazione.note);
	
		obj = {};
		  obj.inizio =  prenotazione.data_inizio_prenotazione
          obj.fine =  prenotazione.data_fine_prenotazione
          obj.id = prenotazione.id
          obj.id_veicolo = prenotazione.veicolo.id
      	
          orariDisabilitati.push(obj); 
		  
		  isPaste = true;
		  $('#id_prenotazione').val(0)

		nuovaPrenotazione();
	});
	
	
}

var selectedDiv = null;
var offsetX;
var offsetY;
/* $('#tabPrenotazione tbody td').on('contextmenu', 'div',  function(e) {
	if($(this).hasClass("riquadro")){
	    selectedDiv = $(this);
	    e.preventDefault(); // Prevent default context menu
	}

}); */






/* 
$(document).bind("contextmenu", function(e) {
	
	var x  = $('#'+e.target.id).offset().left / zoom_level;
	var y  = $('#'+e.target.id).offset().top / zoom_level;
    $(".tooltip").css({left:x, top:y});
   // $('.tooltip').show();
    e.preventDefault();
}); */

/* $(window).on('scroll', function() {
    var windowScrollTop = $(window).scrollTop();
    var tableHeaderHeight = $('.dataTables_scrollHead').outerHeight();
    var scrollPosition = $('.dataTables_scrollBody').outerHeight();

    // Se lo scroll della finestra è inferiore all'altezza dell'header della tabella,
    // fai in modo che l'header della tabella sia posizionato in alto.
   // if (windowScrollTop < tableHeaderHeight) {
   //     $('.dataTables_scrollHead').css('top', -windowScrollTop);
  // } else {
        // Altrimenti, fai in modo che l'header della tabella sia posizionato al top della finestra.
        
        var windowHeight = $(window).height(); // Altezza della finestra del browser
var scrollTop = $(window).scrollTop(); // Posizione dello scroll verticale
var visibleHeight = windowHeight - scrollTop;
        
        $('.dataTables_scrollHead').css('top',windowScrollTop - windowHeight);
  //  }
}); */

$(window).on('scroll', function() {
    var windowScrollTop = $(window).scrollTop();
    var tableHeaderHeight = $('.dataTables_scrollHead').outerHeight();
    var tableHeaderWidth = $('.dataTables_scrollHead').outerWidth();
    var fixedColumnsHeaderHeight = $('.DTFC_LeftHeadWrapper').outerHeight();
    var fixedColumnsHeaderWidth = $('.DTFC_LeftHeadWrapper').outerWidth();


    
    var combinedHeaderHeight = tableHeaderHeight + fixedColumnsHeaderHeight;
    // Se lo scroll della finestra è maggiore dell'altezza dell'header della tabella
    
    // sposta l'header sopra la finestra
  //  if (windowScrollTop >= tableHeaderHeight) {
	  if (windowScrollTop > combinedHeaderHeight) {
        $('.dataTables_scrollHead').css({
            'position': 'fixed',
            'top': '0',
            //'left': '0',
            'width': '100%',
            'z-index': '99'
        });
        
        $('.DTFC_LeftHeadWrapper').css({
            'position': 'fixed',
            'top': '0',
            'left':fixedColumnsHeaderWidth-102,
            'z-index': '100', // Livello di z-index inferiore rispetto all'header principale
        });
    } else {
        // Altrimenti, ripristina lo stile predefinito dell'header
        $('.dataTables_scrollHead, .DTFC_LeftHeadWrapper').css({
            'position': 'static'
        });
    }
});





var order = 1;

var permesso = "${userObj.checkPermesso('GESTIONE_PARCO_AUTO_ADMIN')}";

var cellCopy;

$(document).ready(function() {
	
	console.log("dentro")
zoom_level  = parseFloat(Cookies.get('page_zoom'));

         fillTable("${anno}",'${filtro_tipo_pianificazioni}');
	
	

       

	    $(document.body).css('padding-right', '0px');
	    
	    initContextMenu()
	    

	    $('.dropdown-menu').css('z-index', 200);
	   		
	    
});

 
 function getTextWidth(text, font) {
	    var canvas = document.createElement('canvas');
	    var context = canvas.getContext('2d');
	    context.font = font;
	    var metrics = context.measureText(text);
	    return metrics.width;
	}

 
 
 function fillTable(anno, filtro) {
	    console.log("dddd");

	    $.ajax({
	        url: 'gestioneParcoAuto.do?action=lista_prenotazioni&anno=' + anno,
	        method: 'GET',
	        dataType: 'json',
	        success: function(response) {
	        	
	        	
	        	$("#tabPrenotazione").on( 'init.dt', function ( e, settings ) {
	        	    var api = new $.fn.dataTable.Api( settings );
	        	    var state = api.state.loaded();
	        	 
	        	    if(state != null && state.columns!=null){
	        	    		console.log(state.columns);
	        	    
	        	    columsDatatables = state.columns;
	        	    } 
	        	    $('#tabPrenotazione thead th').each( function () {
	        	    	  $('#inputsearchtable_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);
	        	    	 
	        	    	}); 
	        	     

	        	} ); 
	        
	            var lista_prenotazioni = response.lista_prenotazioni;
	            $('.riquadro').remove();
	            $('#tabPrenotazione td').removeClass('prenotato');
	            if(table == null){
				    table = $('#tabPrenotazione').DataTable(settings);
				  
				}else{
					   $('#tabPrenotazione').DataTable().destroy();
					table = $('#tabPrenotazione').DataTable(settings);
				}

	            
	            for (var i = 0; i < lista_prenotazioni.length; i++) {
	                var id_inizio = lista_prenotazioni[i].veicolo.id + "_" + lista_prenotazioni[i].cella_inizio;
	                var id_fine = lista_prenotazioni[i].veicolo.id + "_" + lista_prenotazioni[i].cella_fine;
	                var id_prenotazione = lista_prenotazioni[i].id;
	                
	                
	                var obj = {};

		            
		            obj.inizio =  lista_prenotazioni[i].data_inizio_prenotazione
		            obj.fine =  lista_prenotazioni[i].data_fine_prenotazione
		            obj.id = id_prenotazione
		            obj.id_veicolo = lista_prenotazioni[i].veicolo.id 
		        	
		            orariDisabilitati.push(obj); 
	                
					
	                var cellaInizio = $("#" + id_inizio);
	                var cellaFine = $("#" + id_fine);

	                var posizionePartenza = cellaInizio.offset();
	                var posizioneArrivo = cellaFine.offset();
	                
	                if(lista_prenotazioni[i].manutenzione==1){
	                	var text = "MANUTENZIONE";
	                }else{
	                	var text = lista_prenotazioni[i].utente.nominativo;
	                }
	                
	                
	                
	                if(posizionePartenza!=null){
	                	
	                	 var testo = text + " (" + lista_prenotazioni[i].data_inizio_prenotazione.split(" ")[1] + " - " + lista_prenotazioni[i].data_fine_prenotazione.split(" ")[1] + ")";
	 	                var larghezzaTesto = getTextWidth(testo, '12px Arial') + 20; // Aggiungi un margine per una migliore presentazione

	 	                var larghezza =  Math.abs(posizioneArrivo.left - posizionePartenza.left + cellaInizio.outerWidth());
	 	               //var larghezza = 115;
	 	   
	 	                var altezza = 36;
	 	                 if(larghezzaTesto>=larghezza){
	 	                	altezza = altezza * 2;
	 	                	//larghezza = larghezzaTesto
	 	                } 
	 	                
	 	     
	 	                var numeroRiquadri = cellaInizio.find('.riquadro').length;
	 	                
	 	                var cellaPrecedente = null;
	 	                var cellaSuccessiva = null;
	 	                 if(numeroRiquadri === 0 && cellaInizio.hasClass('prenotato_multi')){
	 	                	 cellaPrecedente = cellaInizio.prev();
	 	     	            while (cellaPrecedente.length > 0) {
	 	     	            	numeroRiquadri = cellaPrecedente.find('.riquadro').length;
	 	     	                if (numeroRiquadri > 0) {
	 	     	                    break; // Riquadro trovato nella cella precedente, interrompi il ciclo
	 	     	                }
	 	     	                cellaPrecedente = cellaPrecedente.prev();
	 	     	            }
	 	                	
	 	                }
	 	                
	 	                if(numeroRiquadri === 0 && cellaFine.hasClass('prenotato_multi')){
	 	                	 cellaSuccessiva = cellaInizio.next();
	 	     	            while (cellaSuccessiva.length > 0) {
	 	     	            	numeroRiquadri = cellaSuccessiva.find('.riquadro').length;
	 	     	                if (numeroRiquadri > 0) {
	 	     	                    break; // Riquadro trovato nella cella precedente, interrompi il ciclo
	 	     	                }
	 	     	               cellaSuccessiva = cellaSuccessiva.next();
	 	     	            }
	 	                	
	 	                } 
	 	                
	 	                var celleTraCelle = null;
	 	                 if (numeroRiquadri === 0 && id_inizio != id_fine && cellaInizio.length > 0 && cellaFine.length > 0) {
	 	                	celleTraCelle =  cellaInizio.nextUntil(cellaFine);
	 	                	 numeroRiquadri = 0
	 	                    celleTraCelle.each(function() {
	 	                        n = $(this).find('.riquadro').length;
	 	                        if(n>numeroRiquadri){
	 	                        	numeroRiquadri = n;
	 	                        }
	 	                    });
	 	                } 
	 	                
	 	                nCelle = 1;
	 	                
	 	                if(id_inizio!=id_fine){
	 	                	nCelle=parseInt(id_fine.split("_")[1]) - parseInt(id_inizio.split("_")[1])
	 	                }
	 	                
	 	                for (var j = 0; j < nCelle; j++) {
	 						$('#'+id_inizio.split("_")[0]+"_"+(parseInt(id_inizio.split("_")[1]) + j)).addClass('prenotato');
	 						var x = '#'+id_inizio.split("_")[0]+"_"+parseInt(id_inizio.split("_")[1]) + j
	 						if(id_inizio!=id_fine){
	 							$('#'+id_inizio.split("_")[0]+"_"+(parseInt(id_inizio.split("_")[1]) + j)).addClass('prenotato_multi');
	 						}
	 					}
	 	               
						 if(id_inizio!=id_fine){
							var larghezza =  larghezza - 5;
						} 
	 	       
	 	               //var sinistra = posizionePartenza.left - $('#tabPrenotazione').offset().left;
	 	                var sinistra = 0;
	 	                //var alto = posizionePartenza.top - $('#tabPrenotazione').offset().top;
	 	                var alto = 0;
	 	                
	 	     
	 	                
	 	                var border_color;
	 	                var background_color;
	 	                
	 	                if(lista_prenotazioni[i].stato_prenotazione == 1){
	 	                   var border_color = "#FFD700";
		 	               var background_color = "#FFFFE0";
	 	                }else if(lista_prenotazioni[i].stato_prenotazione == 2){
	 	                	var border_color = "#A0CE00";
			 	            var background_color = "#90EE90";
	 	                }
	 	               else if(lista_prenotazioni[i].stato_prenotazione == 3){
	 	            	   
	 	            	  if(lista_prenotazioni[i].rifornimento == 1){
		 	            	  	var border_color = "#F2861B ";
				 	            var background_color = "#F7BB80";
							}else{
								var border_color = "#1E90FF";
				 	            var background_color = "#ADD8E6";
							}
	 	               
	 	                	
			 	
	 	                }
	 	                
	 	           
	 	          /*     else if(lista_prenotazioni[i].stato_prenotazione == 4){
	 	                	var border_color = "#A0CE00";
			 	            var background_color = "#90EE90";
	 	                } */

	 	                if (numeroRiquadri === 0) {
	 	                    // Se non ci sono riquadri presenti, aggiungi normalmente il nuovo riquadro
	 	                  $("<div  data-toggle='tooltip' title='"+escapeHtml(lista_prenotazioni[i].note)+"' class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:42px;background-color:"+background_color+";border-color:"+border_color+"' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+text+ " (" +lista_prenotazioni[i].data_inizio_prenotazione.split(" ")[1] + " - "+lista_prenotazioni[i].data_fine_prenotazione.split(" ")[1]+ ")"+"</div>").addClass('riquadro').css({
	 	                	 /* $("<div   title='"+escapeHtml(lista_prenotazioni[i].note)+"' class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:42px;background-color:"+background_color+";border-color:"+border_color+"' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+text+ " (" +lista_prenotazioni[i].data_inizio_prenotazione.split(" ")[1] + " - "+lista_prenotazioni[i].data_fine_prenotazione.split(" ")[1]+ ")"+"</div>").addClass('riquadro').css({ */
	 	                  
	 	                	   // $("<div  data-toggle='tooltip' title='"+lista_prenotazioni[i].note+"' class='riquadro' id='riquadro_"+id_prenotazione+"' style='background-color:"+background_color+";border-color:"+border_color+"' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+text+ " (" +lista_prenotazioni[i].data_inizio_prenotazione.split(" ")[1] + " - "+lista_prenotazioni[i].data_fine_prenotazione.split(" ")[1]+ ")"+"</div>").addClass('riquadro').css({
	 	                        left: sinistra,
	 	                        top: alto,
	 	                        width: larghezza,
	 	                        height: altezza,
	 	                        'text-align': 'center',
	 	                       'font-weight': 'bold'
	 	                    }).appendTo(cellaInizio);
	 	                    
	 	                    var rowId = cellaInizio.closest('tr').attr('id');
	 			            var altezzaRiga = $("#"+rowId).height();
	 	                    
	 	                    var nuovaAltezzaRiga = (numeroRiquadri + 1) * (altezza + 42); // +1 per includere il nuovo riquadro

	 		                // Aggiorna l'altezza della riga
	 		                if(nuovaAltezzaRiga>altezzaRiga){
	 		                	cellaInizio.closest('tr').children('td').height(nuovaAltezzaRiga);
	 		                }
	 		                
	 	                    

	 	                
	 	                } else {
	 	                    // Se ci sono già riquadri presenti, aggiungi il nuovo riquadro sotto a quelli esistenti
	 	                    if(cellaPrecedente!=null){
	 	                    	var ultimoRiquadro = cellaPrecedente.find('.riquadro:last');
	 	                    	var posizioneUltimoRiquadro = ultimoRiquadro.position();
	 	                    	 posizioneUltimoRiquadro.left = ultimoRiquadro.position().left + cellaPrecedente.outerWidth();
	 	                    	 //posizioneUltimoRiquadro.top = ultimoRiquadro.position().top;
	 	                    	 posizioneUltimoRiquadro.top = ultimoRiquadro[0].offsetTop 
	 	                    }
	 	                    else if(cellaSuccessiva!=null){
	 	                    	var ultimoRiquadro = cellaSuccessiva.find('.riquadro:last');
	 	                    	var posizioneUltimoRiquadro = ultimoRiquadro.position();
	 	                    	 posizioneUltimoRiquadro.left = ultimoRiquadro.position().left - cellaSuccessiva.outerWidth();
	 	                    	 //posizioneUltimoRiquadro.top = ultimoRiquadro.position().top;
	 	                    	 posizioneUltimoRiquadro.top = ultimoRiquadro[0].offsetTop 
	 	                    }
	 	                    else if(celleTraCelle!=null){
	 	                    	var ultimoRiquadro = celleTraCelle.find('.riquadro:last');
	 	                    	var posizioneUltimoRiquadro = ultimoRiquadro.position();
	 	                    	 posizioneUltimoRiquadro.left = ultimoRiquadro.position().left - celleTraCelle.outerWidth();
	 	                    	 //posizioneUltimoRiquadro.top = ultimoRiquadro.position().top;
	 	                    	 posizioneUltimoRiquadro.top = ultimoRiquadro[0].offsetTop 
	 	                    }
	 	                    
	 	                    else{
	 	                    	var ultimoRiquadro = cellaInizio.find('.riquadro:last');
	 	                    	var posizioneUltimoRiquadro = ultimoRiquadro.position();
	 	                    	
	 	                    	 posizioneUltimoRiquadro.left = ultimoRiquadro.position().left;
	 	                    	 //posizioneUltimoRiquadro.top = ultimoRiquadro.position().top;
	 	                    	 posizioneUltimoRiquadro.top = ultimoRiquadro[0].offsetTop
	 	                    }
	 	                    
	 	                    var altezzaUltimoRiquadro = ultimoRiquadro.height();
	 	                    
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
	 	                 
	 	                 else if (cellaInizio!= cellaFine && cellaFine.find('.riquadro:eq(1)').length > 0) {
	 	                     var altezzaRiquadroSuccessivo = cellaFine.find('.riquadro:eq(1)').height();
	 	                     if (nuovaPosizioneVerticale + altezza > posizioneUltimoRiquadro.top + altezzaRiquadroSuccessivo) {
	 	                         nuovaPosizioneVerticale = posizioneUltimoRiquadro.top + altezzaRiquadroSuccessivo + distanzaVerticale;
	 	                     }
	 	                 }

	 	  
	 	                 
	 	                 $("<div data-toggle='tooltip' title='"+escapeHtml(lista_prenotazioni[i].note)+"'  class='riquadro' id='riquadro_"+id_prenotazione+"' style='margin-top:5px;background-color:"+background_color+";border-color:"+border_color+"' ondblclick='modalPrenotazione("+id_inizio.split("_")[1]+", "+id_inizio.split("_")[0]+", "+id_prenotazione+")' >"+text+ " (" +lista_prenotazioni[i].data_inizio_prenotazione.split(" ")[1] + " - "+lista_prenotazioni[i].data_fine_prenotazione.split(" ")[1]+ ")"+"</div>").addClass('riquadro').css({
	 	                    // left: posizioneUltimoRiquadro.left,
	 	                     left: sinistra,
	 	                     top: nuovaPosizioneVerticale,
	 	                     width: larghezza,
	 	                     height: altezza,
	 	                     'text-align': 'center',
	 	                    'font-weight': 'bold'
	 	                 }).appendTo(cellaInizio);
	 	                 
	 	                 
	 	                  var ultimaPosizione = ultimoRiquadro[0].offsetTop +  ultimoRiquadro[0].offsetHeight + 3; // Aggiungi 5 pixel di spazio
	 	                  //var ultimaPosizione = ultimoRiquadro[0].offsetTop +  altezza +3; // Aggiungi 5 pixel di spazio
	 	               
	 	  	           
	 	  	          var rowId = cellaInizio.closest('tr').attr('id');
	 		            var altezzaRiga = $("#"+rowId).height();
	 	  	           // var nuovaAltezzaRiga = 35 + numeroRiquadri  * ultimoRiquadro[0].offsetHeight;
	 	  	         //   var nuovaAltezzaRiga = altezzaRiga +  altezza ;
	 	  	            var nuovaAltezzaRiga = 42+ (numeroRiquadri +1) * 75 ;
	 	  	            if(altezzaRiga<=nuovaAltezzaRiga){
	 	  	           // if(altezzaRiga<=ultimaPosizione){
	 	  	            	   
	 	  	            	 updatePosition(cellaInizio.closest('tr'), nuovaAltezzaRiga, altezzaRiga);
	 	  	            	cellaInizio.closest('tr').children('td').height(nuovaAltezzaRiga);
	 	  	            	var x = id_prenotazione;
	 	  	            }
	 	                 
	 	                 
	 	                }
	 	               
	 	            }

	                
	                }
	               
	            console.log("ciao");

	            var today = "${today}";
	            if (today > "${daysNumber}") {
	                today = null;
	            } else {
	                order = parseInt(today) + 3;
	            }

	            
	    	    $('.inputsearchtable').on('input', function() {
	    		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
	    		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

	    		    table.column(columnIndex).search(searchValue).draw();
	    		    
	    		  
	    		    
	    		  });
	    	  
	    	  $('.inputsearchtable').on('click', function(e){
	     	       e.stopPropagation();    
	     	    });
	    	
	           
	            table.columns.adjust().draw();
	            
	            
	    	    $('#tabPrenotazione_wrapper').prepend('<div class="legend"> '+
	    	    	    '<div class="legend-item"> <div class="legend-color" style="background-color:#FFFFE0;"></div>'+
	    	    	    '<div class="legend-label">IN PRENOTAZIONE</div></div> '+
	    	    	    
	    	    	    '<div class="legend-item"> <div class="legend-color" style="background-color:#90EE90;"></div>'+
	    	    	    '<div class="legend-label">PRENOTATO</div> </div> '+
	    	    	    
	    	    	    '<div class="legend-item"> <div class="legend-color" style="background-color:#ADD8E6;"></div>'+
	    	    	    '<div class="legend-label">RIENTRATO</div> </div>'+
	    	    	    
	    	    	    '<div class="legend-item"> <div class="legend-color" style="background-color:#F7BB80;"></div>'+
	    	    	    '<div class="legend-label">RIFORNIMENTO EFFETTUATO</div> </div>'+
	    	    	    
	    	    	    '</div>');
	           
	         //   scrollToColumn(parseInt(today) -1);

	         var coltoday = getDaysUntilMonday(parseInt(today), parseInt("${start_date}")) +1
	          scrollToColumn(today - coltoday) 
	            
	        // $('[data-toggle="tooltip"]').tooltip();
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


function getDaysUntilMonday(today, start_date) {
    var currentYear = new Date().getFullYear();
    var startDate = new Date(currentYear, 0); // Imposta la data al 1° gennaio dell'anno corrente
    startDate.setDate((today+start_date)); // Imposta il giorno dell'anno fornito
    var dayOfWeek = startDate.getDay(); // Ottiene il giorno della settimana (0 = Domenica, 1 = Lunedì, ..., 6 = Sabato)
    var daysUntilMonday = (dayOfWeek === 0) ? 6 : dayOfWeek - 1; // Calcola i giorni che mancano al Lunedì
  //  return (today > daysUntilMonday) ? 7 - today + daysUntilMonday : daysUntilMonday - today;
    return daysUntilMonday;
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