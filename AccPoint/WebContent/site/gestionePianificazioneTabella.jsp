
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@page import="it.portaleSTI.DTO.ForPiaPianificazioneDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.Date" %>

<%

ArrayList<CommessaDTO> lista_commesse = (ArrayList<CommessaDTO>) request.getSession().getAttribute("lista_commesse");
int anno = (Integer) request.getSession().getAttribute("anno");

//Integer.parseInt((String) request.getSession().getAttribute("daysNumber"));
/* ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni = (ArrayList<ForPiaPianificazioneDTO>) request.getSession().getAttribute("lista_pianificazioni"); */
%>

				
<div class="legend">
    <div class="legend-item">
        <div class="legend-color" style="background-color:#DCDCDC;"></div>
        <div class="legend-label">NON CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #FFFFE0;"></div>
        <div class="legend-label">CONFERMATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #90EE90;"></div>
        <div class="legend-label">EROGATO</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #ADD8E6;"></div>
        <div class="legend-label">FATTURATO SENZA ATTESTATI</div>
    </div>
    <div class="legend-item">
        <div class="legend-color" style="background-color: #F7BEF6;"></div>
        <div class="legend-label">FATTURATO CON ATTESTATI</div>
    </div>
</div>
<c:if test="${LocalDate.ofYearDay(LocalDate.now().getYear(), 1).isLeapYear()}">
<c:set var="nGiorni" value="366"></c:set>
</c:if>

<c:if test="${!LocalDate.ofYearDay(LocalDate.now().getYear(), 1).isLeapYear()}">
<c:set var="nGiorni" value="365"></c:set>
</c:if>

 <table id="tabForPianificazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th>CLIENTE</th>
               <th>COMMESSA</th>
                <th>STATO</th>
                           
         <c:forEach var="day" begin="1" end="${daysNumber }" step="1">
      <% 
        int dayValue = (Integer) pageContext.getAttribute("day");
        LocalDate localDate = LocalDate.ofYearDay(anno, dayValue);
        LocalDateTime localDateTime = localDate.atStartOfDay();
        Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
        ArrayList<LocalDate> festivitaItaliane = (ArrayList<LocalDate>) request.getSession().getAttribute("festivitaItaliane");
        
        if(localDate.getDayOfWeek().getValue() == 6 || localDate.getDayOfWeek().getValue() == 7){
      %>
       <th class="weekend">
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
            </th>
            
            <%}else if(festivitaItaliane.contains(localDate)){ %>
              <th class="festivita">
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
            </th>
            <%}else{ %>
      
      <th>
                <fmt:formatDate value="<%= date %>" pattern="dd/MM/yyyy" />
            </th>
         <%} %>
      

      
    </c:forEach>
            </tr >
        </thead>
        <tbody>
      
          <c:forEach  items="${lista_commesse }" var="commessa">
         <tr id="${commessa.ID_COMMESSA.replace('/','')}">
        
         <td data-toggle="tooltip" title="${commessa.ID_ANAGEN_NOME}">
          <c:if test="${commessa.ID_ANAGEN_NOME!=null  && commessa.ID_ANAGEN_NOME.length()>20 }">
         ${commessa.ID_ANAGEN_NOME.substring(0,19)}...
         
         </c:if>
          <c:if test="${commessa.ID_ANAGEN_NOME!=null  && commessa.ID_ANAGEN_NOME.length()<=20}">
          ${commessa.ID_ANAGEN_NOME}
          </c:if>
         </td>
         <td>${commessa.ID_COMMESSA}</td>
         <td id="stato_${commessa.ID_COMMESSA.replace('/','')}"></td>
         <c:forEach var="day" begin="1" end="${daysNumber}" step="1">

         	<td id="${commessa.ID_COMMESSA.replace('/','')}_${day}" ondblclick="modalPianificazione('${day}', '${commessa.ID_COMMESSA }')"></td>
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
    
    


function modalPianificazione(day, commessa){
	

	
	var dayValue = parseInt(day);
	var localDate = new Date(Date.UTC(2023, 0, dayValue));
	var d = localDate.getUTCDate();
	var month = localDate.getUTCMonth() + 1; 
	var year = localDate.getUTCFullYear();
	var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;

	var cell = $('#'+commessa.replace("/", "")+"_"+day);
	var nota = cell.text()
	
		$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
	
	if(nota!=null && nota!=''){
		
		var id = cell.attr("name");
		
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
			

			$('#btn_elimina').show()
		
				

			
			$('#modalPianificazione').modal()
		});
		
		
	}else{
		$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
		$('#day').val(day);
		$('#commessa').val(commessa);
		$('#btn_elimina').hide()
		$('#modalPianificazione').modal()
	}
	

	
}


columsDatatables=[]
$('#tabForPianificazione thead th').each( function () {
 	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	  var title = $('#tabForPianificazione thead th').eq( $(this).index() ).text();
	
	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	
	});



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
    "order": [[ parseInt("${today}")+2, "desc" ]],
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
    	  
    	 
    	  
               ], 	        
	      buttons: [   
	         /*  {
	            extend: 'colvis',
	            text: 'Nascondi Colonne'  	                   
			  },  */{
				 extend: 'excel',
  	            text: 'Esporta Excel'  
			  } ]
               
    }


$(document).ready(function() { 
	pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	
	
	console.log("test")
	


         fillTable("${anno}");
	
	

	    
	    
	    $('[data-toggle="tooltip"]').tooltip();

	    $(document.body).css('padding-right', '0px');
		   pleaseWaitDiv.modal('hide');
	    
});

function fillTable(anno){



	
	$.ajax({
		  url: 'gestioneFormazione.do?action=lista_pianificazioni&anno='+anno, // Specifica l'URL della tua servlet
		  method: 'GET',
		  dataType: 'json',
		  success: function(response) {
		    // Recupera il JSONElement dalla risposta
		    var lista_pianificazioni = response.lista_pianificazioni;
		    
		    var array = [];
		    var day = [];
		    var map = {};
		    
		    for (var i = 0; i < lista_pianificazioni.length; i++) {
		    	var id = lista_pianificazioni[i].id_commessa.replace("/","")+"_"+lista_pianificazioni[i].nCella;
				var cell = $("#"+id);
				if(lista_pianificazioni[i].note.length>20){
					cell.html(lista_pianificazioni[i].note.substring(0,20)+"...");
					
				}else{
					cell.html(lista_pianificazioni[i].note);
					
				}
				cell.attr("name", lista_pianificazioni[i].id)
				
				
				
				if(lista_pianificazioni[i].stato.id != 5){
					
					var cell_stato = $("#stato_"+lista_pianificazioni[i].id_commessa.replace("/",""));
					cell_stato.html("In Corso");
					if(lista_pianificazioni[i].stato.id == 1){
						cell.css("background-color", "#DCDCDC");
					}else if(lista_pianificazioni[i].stato.id == 2){
						cell.css("background-color", "#FFFFE0");
					}else if(lista_pianificazioni[i].stato.id == 3){
						cell.css("background-color", "#90EE90");
					}else if (lista_pianificazioni[i].stato.id == 4){
						cell.css("background-color", "#ADD8E6");
					}
					
					
					var indice = array.indexOf(lista_pianificazioni[i].id_commessa.replace("/",""));
				//	var indice2 = day.indexOf(lista_pianificazioni[i].nCella);
					if (indice !== -1) {
					  array.splice(indice, 1);
				// day.splice(indice,1)
					}
					
				
					
			}else{
			//	var cell_stato = $("#stato_"+lista_pianificazioni[i].id_commessa.replace("/",""));
			//	cell_stato.html("Da Chiudere");
				cell.css("background-color", "#F7BEF6");
			
				array.push(lista_pianificazioni[i].id_commessa.replace("/",""));
							
					
				
			}
				
				
		    }
		    
		   
		     for (var i = 0; i < array.length; i++) {
		    		var commessa_da_chiudere = true;			
					var riga_vuota = true;
		    	  $("#" + array[i] + " td").slice(3).each(function() {
		    		    var testoCella = $(this).text().trim();
		    		    if (testoCella !== "") {
		    		    	var coloreCella = $(this).css('background-color');
			            	riga_vuota = false;
			            	
			            	if(rgbToHex(coloreCella).toUpperCase() != "#F7BEF6"){
			            		commessa_da_chiudere = false;
			            		return false;
			            	}
		    		    }
		    		  });
		        
		        var cell = $("#stato_"+array[i]);
		        if(commessa_da_chiudere && !riga_vuota){
		        		        
		        	cell.html("Da Chiudere");
		        }else if(riga_vuota){
		        	
		        }else{
		        	cell.html("In Corso");
		        }
				
			}
		     	    
		
		    
			var today = "${today}"
				if(table == null){
				    table = $('#tabForPianificazione').DataTable(settings);
				}else{
					table = $('#tabForPianificazione').DataTable();
				}

			    
	    $('.inputsearchtable').on('input', function() {
		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

		    columsDatatables[columnIndex].search.search = searchValue;

		    var x = table.column(columnIndex).data();
		    
		    table.column(columnIndex).search(searchValue).draw();
		  });
	  
	  $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
			
	  table.columns().draw();
	  
			 scrollToColumn(parseInt(today)-3);
		  
			  $(document.body).css('padding-right', '0px');
		  },
		  error: function(xhr, status, error) {
		    // Gestisci eventuali errori
		    console.error(error);
		  }
		});
	
}


function scrollToColumn(columnIndex) {
    var tableWrapper = $('#tabForPianificazione_wrapper');
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