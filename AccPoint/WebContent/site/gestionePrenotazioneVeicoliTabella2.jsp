
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

<div id="tabellaContenitore" style="overflow-x: auto;">
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
			<td id="${veicolo.id}_${day-366}"></td> 
			</c:if>
			<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
			<td id="${veicolo.id}_${day-365}"></td> 
			</c:if>
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
			<td id="${veicolo.id}_${day}"></td> 
			</c:if>
         	<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
			<td id="${veicolo.id}_${day}"></td> 
			</c:if>
         	<%-- <td id="${veicolo.id}_${day}" ondblclick="modalPrenotazione('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
         	<%-- <td id="${veicolo.id}_${day}"></td> --%>
         </c:forEach>
         

  <%--   </c:forEach> --%>
         
         </tr>
  </c:forEach> 
         
        

                </tbody>
    </table>
    
    <div id="riquadro" class="riquadro"></div>
    </div>
    
    

    
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
/* .DTFC_RightBodyLiner {
top: -13px !important;
overflow-x: hidden;
}


.dataTables_wrapper .dataTables_scrollHead {
  overflow: hidden;
  position: relative;
}

.dataTables_wrapper .dataTables_scrollHead table {
  table-layout: fixed;
}

.dataTables_wrapper .dataTable {
  table-layout: fixed;
}

.dataTables_wrapper .dataTable td,
.dataTables_wrapper .dataTable th {
  padding-right: 10px;  
} */

#tabellaContenitore {
    position: relative;
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


    .riquadro {
      border: 1px solid red;
      padding: 5px;
 
        cursor: move;
      
}


/*   .button_add {
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 50%;
      background-color: #337ab7;
      text-align: center;
      line-height: 10px;
      font-size: 3px;
      cursor: pointer;
    }
 */

</style>


 
 
    <script type="text/javascript">  
    
    


function modalPrenotazione(day, id_veicolo, id){
	

/* 	
	var dayValue = parseInt(day);
	var localDate = new Date(Date.UTC(2023, 0, dayValue));
	var d = localDate.getUTCDate();
	var month = localDate.getUTCMonth() + 1; 
	var year = localDate.getUTCFullYear();
	var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;

	var cell = $('#'+commessa.replace("/", "")+"_"+day);
	var nota = cell.text()
	
		$('#title_prenotazione').html("Prenotazione ")
	
	if(nota!=null && nota!='' && id!=null){
		
		//var id = cell.attr("name");
		
		dataObj ={};
		dataObj.id = id;
		
		callAjax(dataObj, "gestioneFormazione.do?action=dettaglio_pianificazione", function(data){
			
			var pianificazione = data.pianificazione;
			var x = []
			for (var i = 0; i < pianificazione.listaDocenti.length; i++) {
				
				//$('#docente_mod option[value="'+json.lista_docenti[i].id+'"]').attr("selected", true);
				x.push(pianificazione.listaDocenti[i].id);

				
				$('#id_docenti').val($('#id_docenti').val()+pianificazione.listaDocenti[i].id+";")
			}
			$('#docente').val(x);
			$('#docente').change();	
			$('#stato').val(pianificazione.stato.id);
			$('#stato').change();	
			$('#tipo').val(pianificazione.tipo.id);
			$('#tipo').change();	
			$('#nota').val(pianificazione.note);
			$('#id_pianificazione').val(pianificazione.id);
			$('#commessa').val(pianificazione.id_commessa);
			$('#day').val(pianificazione.nCella);
			$('#ora_inizio').val(pianificazione.ora_inizio);
			$('#ora_fine').val(pianificazione.ora_fine);
			$('#n_cella').val(pianificazione.nCella);
			$('#n_utenti').val(pianificazione.nUtenti);
			$('#descrizione').val(pianificazione.descrizione)
			if(pianificazione.email_inviata==1){
				$('#label_email').show();
			}else{
				$('#label_email').hide();
			}
			
			if(pianificazione.aggiunto_agenda==1){
				$('#label_agenda').show();
			}else{
				$('#label_agenda').hide();
			}
			$('#btn_elimina').show()
		
				 */

			$('#day').val(day);
			$('#id_veicolo').val(id_veicolo);
			$('#modalPrenotazione').modal()
/* 		});
		
		
	}else{
		$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
		$('#day').val(day);
		$('#commessa').val(commessa);
		$('#btn_elimina').hide()
		$('#modalPrenotazione').modal()
	} */
	

	
}


 columsDatatables=[]
/* $('#tabPrenotazione thead th').each( function () {
 	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	  var title = $('#tabPrenotazione thead th').eq( $(this).index() ).text();
	
	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	
	}); 
 */





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
      targets: 0,
      responsive: false,
      scrollX: "100%",
      searching: true,
      scrollY: "700px",
      
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


    function editableCell(cell) {
	
	
	 $(cell).on('click', function() {
         $('.selected-cell').removeClass('selected-cell');
         $('.button_add').remove();
         $(this).addClass('selected-cell');
         var cellId = $(this).attr('id');
         var rowId =  $(this).closest('tr').attr('id');
         
         if(document.getElementById('button_add_'+cellId) != null){
        		 
         }else{
        	 
        	 
        	 $(this).append('<button class="button_add btn btn-primary btn-sm" id="button_add_'+cellId+'\" onclick="modalPrenotazione(\''+cellId.split("_")[1]+'\', \''+rowId+'\')" style="margin-top:5px"><i class="fa fa-plus"></i></button> '); 
         }
         
       });

	
	
	} 



$(window).on('load', function() {
	
	  pleaseWaitDiv.modal('hide');
});


var order = 1;

$(document).ready(function() {
	
	console.log("dentro")
	

	
	console.log("test")
	


         fillTable("${anno}",'${filtro_tipo_pianificazioni}');
	
	

	    
	    
	    $('[data-toggle="tooltip"]').tooltip();

	    $(document.body).css('padding-right', '0px');

	    
});





function fillTable(anno, filtro){


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
		        }
		      }
		    for (var i = 0; i < lista_prenotazioni.length; i++) {
		    	var id = lista_prenotazioni[i].veicolo.id+"_"+lista_prenotazioni[i].cella_inizio;
				var cell = $("#"+id);
				var num_giorni = lista_prenotazioni[i].cella_fine - lista_prenotazioni[i].cella_inizio;
				cell.addClass("start-cell")
				var id = lista_prenotazioni[i].veicolo.id+"_"+lista_prenotazioni[i].cella_fine;
				var cell = $("#"+id);
				cell.addClass("end-cell")
				
				
				
				 	var cella1Offset = $('#3_55').offset();
    var cella1Width = $('#3_55').outerWidth();
    var cella1Height = $('#3_55').outerHeight();

    // Calcola le dimensioni e le posizioni del rettangolo
    var riquadroLeft = cella1Offset.left;
    var riquadroTop = cella1Offset.top;
    var riquadroWidth = cella1Width * 3; // Copre tre celle
    var riquadroHeight = cella1Height;

    // Imposta le dimensioni e le posizioni del rettangolo
    $('#riquadro').css({
        'left': riquadroLeft,
        'top': riquadroTop,
        'width': riquadroWidth,
        'height': riquadroHeight
    });
	
    
    $('#riquadro').draggable({
        containment: "parent" // Assicura che il rettangolo rimanga all'interno del contenitore genitore
    });
				
				
	/* 			if(num_giorni>=1){
					cell.attr("colspan", num_giorni);
					for (var k = 1; k < num_giorni; k++) {
			            cell.next().remove();
			        }
				} */
				
			
					//cell.append("<div id='riquadro_"+lista_prenotazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPrenotazione(\'"+lista_prenotazioni[i].cella_inizio+"\', \'"+lista_prenotazioni[i].veicolo.id+"\',\'"+lista_prenotazioni[i].utente.id+"\')\">"+lista_prenotazioni[i].utente.nominativo+"</div>");	
						 
			
				cell.attr("name", lista_prenotazioni[i].id)

		/*  		 
				var riquadro = $('<div class="riquadro"></div>');

				riquadro.css("background-color", "#F7BEF6");
				riquadro.css("border-color", "#FF69B4");

				
				 riquadro.appendTo('body'); */ // Aggiunta del riquadro al body


				// addRectangleToRow();
				
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
				
/* 				 var startCellOffset = $('.start-cell').offset();
			        var startCellWidth = $('.start-cell').outerWidth();
			        var startCellHeight = $('.start-cell').outerHeight();

			        // Calcola le coordinate della cella di fine
			        var endCellOffset = $('.end-cell').offset();

			        // Calcola la posizione del riquadro
			        var riquadroLeft = startCellOffset.left + startCellWidth;
			        var riquadroTop = startCellOffset.top;
			        var riquadroWidth = endCellOffset.left - startCellOffset.left - startCellWidth;
			        var riquadroHeight = startCellHeight;

			        // Aggiungi il riquadro dinamicamente
			        $('<div class="riquadro"></div>').css({
			            'left': riquadroLeft,
			            'top': riquadroTop,
			            'width': riquadroWidth,
			            'height': riquadroHeight
			        }).appendTo('body');
			 */
			

			    
	    $('.inputsearchtable').on('input', function() {
		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

	    table.column(columnIndex).search(searchValue).draw();
		    
		  });
	  
	    
	  $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
			
	
	  
	  if(today!=null){
		  scrollToColumn(parseInt(today)-3);
		 
          table.order([order, 'desc']).draw()
	  }else{
		  table.columns().draw();
	  }
			
		  
	  
			  
	  
			  $(document.body).css('padding-right', '0px');
		  
		  },
		  error: function(xhr, status, error) {
		    // Gestisci eventuali errori
		    console.error(status);
		  }
		  
		  
		  

		  
		});
	
	
	

}


function addRectangleToRow() {
    // Seleziona la terza riga della tabella
    
    var targetRow = $('#tabPrenotazione tbody tr:eq(0)');
  //  var targetRow = $('#tabPrenotazione tbody tr:eq(0) td#3_55');
    var startCell = targetRow.find('td:eq(55)');
    var endCell = targetRow.find('td:eq(57)');

    // Verifica se la riga esiste
   if (startCell.length > 0 && endCell.length > 0) {
            // Calcola le dimensioni del rettangolo
        var startCellOffset = startCell.offset();
        var startCellWidth = startCell.outerWidth();
        var startCellHeight = startCell.outerHeight();

        // Calcola le coordinate della cella di fine
        var endCellOffset = endCell.offset();

        // Calcola la posizione e le dimensioni del rettangolo
        var riquadroLeft = startCellOffset.left;
        var riquadroTop = startCellOffset.top;
        var riquadroWidth = endCellOffset.left - startCellOffset.left + endCell.outerWidth();
        var riquadroHeight = startCellHeight;

            // Crea il rettangolo e aggiungilo alla riga
            $("#riquadro").css({
                'background-color': '#F7BEF6',
                'border-color': '#FF69B4',
                'position': 'absolute',
                'left': riquadroLeft,
                'top': riquadroTop,
                'width': riquadroWidth,
                'height': riquadroHeight
            });
    } else {
        console.error("La riga specificata non esiste.");
    }
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