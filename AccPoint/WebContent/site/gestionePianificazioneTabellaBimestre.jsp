
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




 <table id="tabForPianificazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th>CLIENTE <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
               <th>COMMESSA <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
                <th>STATO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
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
         <c:forEach var="day" begin="${start_date }" end="${end_date}" step="1">
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day>366 }">
			<td id="${commessa.ID_COMMESSA.replace('/','')}_${day-366}"></td> 
			</c:if>
			<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
			<td id="${commessa.ID_COMMESSA.replace('/','')}_${day-365}"></td> 
			</c:if>
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
			<td id="${commessa.ID_COMMESSA.replace('/','')}_${day}"></td> 
			</c:if>
         	<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
			<td id="${commessa.ID_COMMESSA.replace('/','')}_${day}"></td> 
			</c:if>
         	<%-- <td id="${commessa.ID_COMMESSA.replace('/','')}_${day}" ondblclick="modalPianificazione('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
         	<%-- <td id="${commessa.ID_COMMESSA.replace('/','')}_${day}"></td> --%>
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


    .riquadro {
      border: 1px solid red;
      padding: 5px;
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
    
    


function modalPianificazione(day, commessa, id){
	
	var currentYear = new Date().getFullYear()
	
	var dayValue = parseInt(day);
	var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
	var d = localDate.getUTCDate();
	var month = localDate.getUTCMonth() + 1; 
	var year = localDate.getUTCFullYear();
	var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;

	var cell = $('#'+commessa.replace("/", "")+"_"+day);
	var nota = cell.text()
	
		$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
	
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
/* $('#tabForPianificazione thead th').each( function () {
 	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	  var title = $('#tabForPianificazione thead th').eq( $(this).index() ).text();
	
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
        	 var comm = rowId.substring(0,rowId.length-2)+"/"+rowId.substring(rowId.length-2,rowId.length);
        	 
        	 $(this).append('<button class="button_add btn btn-primary btn-sm" id="button_add_'+cellId+'\" onclick="modalPianificazione(\''+cellId.split("_")[3]+'\', \''+comm+'\')" style="margin-top:5px"><i class="fa fa-plus"></i></button> '); 
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

if(filtro!=3){
    $('#btn_tutte').attr("disabled",true)
    $('#btn_elearning').attr("disabled",false)
}else{
    $('#btn_tutte').attr("disabled",false)
    $('#btn_elearning').attr("disabled",true)
}
	
	$.ajax({
		  url: 'gestioneFormazione.do?action=lista_pianificazioni&anno='+anno+"&filtro_tipo_pianificazioni="+filtro, // Specifica l'URL della tua servlet
		  method: 'GET',
		  dataType: 'json',
		  success: function(response) {
		    // Recupera il JSONElement dalla risposta
		    var lista_pianificazioni = response.lista_pianificazioni;
		    var is_modifica = response.is_modifica;
		    
		    var array = [];
		    var array_in_corso = [];
		    var day = [];
		    var map = {};
		    
		
		    var t = document.getElementById("tabForPianificazione");
		    var rows = t.rows;
		    for (var i = 1; i < rows.length; i++) {
		    	
		        var cells = rows[i].cells;
		        for (var j = 3; j < cells.length; j++) {
		          cells[j].innerHTML = "";
		        }
		      }
		    for (var i = 0; i < lista_pianificazioni.length; i++) {
		    	var id = lista_pianificazioni[i].id_commessa.replace("/","")+"_"+lista_pianificazioni[i].nCella;
				var cell = $("#"+id);
				if(lista_pianificazioni[i].descrizione.length>20){
				
						//cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro'  style='margin-top:5px' ondblclick='modalPianificazione('"+lista_pianificazioni[i].nCella+"', '"+lista_pianificazioni[i].id_commessa+"','"+lista_pianificazioni[i].id+"')'>"+lista_pianificazioni[i].note.substring(0,20)+"...</div>");	
						cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPianificazione(\'"+lista_pianificazioni[i].nCella+"\', \'"+lista_pianificazioni[i].id_commessa+"\',\'"+lista_pianificazioni[i].id+"\')\">"+lista_pianificazioni[i].descrizione.substring(0,20)+"...</div>");	
					
				}else{
					
						cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPianificazione(\'"+lista_pianificazioni[i].nCella+"\', \'"+lista_pianificazioni[i].id_commessa+"\',\'"+lista_pianificazioni[i].id+"\')\">"+lista_pianificazioni[i].descrizione+"</div>");	
						 
					
					
				}
				cell.attr("name", lista_pianificazioni[i].id)

		 		 
				var riquadro = $('#riquadro_'+lista_pianificazioni[i].id);
				if(lista_pianificazioni[i].stato.id != 5){
					
					var cell_stato = $("#stato_"+lista_pianificazioni[i].id_commessa.replace("/",""));
					cell_stato.html("In Corso");
					
					if(lista_pianificazioni[i].stato.id == 1){
						riquadro.css("background-color", "#DCDCDC");
						riquadro.css("border-color", "#C0C0C0");
					}else if(lista_pianificazioni[i].stato.id == 2){
						riquadro.css("background-color", "#FFFFE0");
						riquadro.css("border-color", "#FFD700");
					}else if(lista_pianificazioni[i].stato.id == 3){
						riquadro.css("background-color", "#90EE90");
						riquadro.css("border-color", "#A0CE00");
					}else if (lista_pianificazioni[i].stato.id == 4){
						riquadro.css("background-color", "#ADD8E6");
						riquadro.css("border-color", "#1E90FF");
					}
					
					
					var indice = array.indexOf(lista_pianificazioni[i].id_commessa.replace("/",""));
					if (indice !== -1) {
					  array.splice(indice, 1);
					}
					array_in_corso.push(lista_pianificazioni[i].id_commessa.replace("/",""));
					
				
					
			}else{

				riquadro.css("background-color", "#F7BEF6");
				riquadro.css("border-color", "#FF69B4");
				if(!array.includes(lista_pianificazioni[i].id_commessa.replace("/","")) && !array_in_corso.includes(lista_pianificazioni[i].id_commessa.replace("/",""))){
					array.push(lista_pianificazioni[i].id_commessa.replace("/",""));	
				}
				
							
					
				
			}
				
				
		    }
		    
		   
	
		    
		     for (var i = 0; i < array.length; i++) {
		    	 
		 	    var oggettiFiltrati = $.grep(lista_pianificazioni, function(obj) {
			    	  return obj.id_commessa.replace("/","") === array[i];
			    	});
			    
		    	 
		    		var commessa_da_chiudere = true;			
					var riga_vuota = true;
					
					
					$.each(oggettiFiltrati, function(index, oggetto) {
						  // Ottieni lo stato dall'oggetto
						  var stato = oggetto.stato.id;

						  var cell = $("#stato_"+array[i]);
						  if (stato == 5) {
							  cell.html("Da Chiudere");
						  } else {
							  cell.html("In Corso");
						  }
						});
					


				
			}
		    
		    
		    
		    
/*  		     for (var i = 0; i < array.length; i++) {
		    		var commessa_da_chiudere = true;			
					var riga_vuota = true;
		    	  $("#" + array[i] + " td").slice(3).each(function() {
		    		  
		    		  var riquadri = $(this).find(".riquadro");
		    		  
		    		  if(riquadri.length>0){
		    			  for (var j = 0; j < riquadri.length; j++) {
							var id_riquadro = riquadri[j].id;
							var coloreRiquadro = $("#"+id_riquadro).css('background-color');
							riga_vuota = false;
			            	
			            	if(rgbToHex(coloreRiquadro).toUpperCase() != "#F7BEF6"){
			            		commessa_da_chiudere = false;
			            		return false;
			            	}
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
				
			} */ 
		     	    
			console.log("ciao")
		    
			
			
			var today = "${today}"
			if(today>"${daysNumber}"){
				today = null;
			}else{
				order = parseInt(today) +3
			}
		
			
				if(table == null){
				    table = $('#tabForPianificazione').DataTable(settings);
				}else{
					table = $('#tabForPianificazione').DataTable();
				}
			
			

			    
	    $('.inputsearchtable').on('input', function() {
		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

		   // columsDatatables[columnIndex].search.search = searchValue;

		   // var x = table.column(columnIndex).data();
		    
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
		    console.error(error);
		  }
		  
		  
		  

		  
		});
	
	
	

}


function filterTable() {
    var table = $('#tabForPianificazione');
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