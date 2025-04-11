
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
        <div class="legend-item">
        <div class="legend-color" style="background-color: #fa9d58;"></div>
        <div class="legend-label">ATTESTATI SENZA FATTURA</div>
    </div>
    
        <div class="legend-item">
<i class="fa fa-star" aria-hidden="true"></i>
        <div class="legend-label">VIRTUALE</div>
    </div>
</div>




 <table id="tabForPianificazione" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th>CLIENTE <input class="inputsearchtable" style="min-width:80px;width=100%" type="text" id="inputsearchtable_0"/></th>
               <th>COMMESSA <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"/></th>
               <th>OGGETTO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  /></th>
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
         <td>${commessa.DESCR}</td>
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
			if(pianificazione.pausa_pranzo=='SI'){
				$('#pausa_pranzo').iCheck("check");
				$('#durata_pausa_pranzo').val(pianificazione.durata_pausa_pranzo);
				$('#durata_pausa_pranzo').change();
			}else{
				$('#pausa_pranzo').iCheck("uncheck");
			}
			
			
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
          leftColumns: 4, // Numero di colonne fisse
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
var cellCopy;
var selectedDiv = null;

let savedSearch = localStorage.getItem('lastSearch');
let indexSearchbox = localStorage.getItem('indexSearch');

$(document).ready(function() {
	
	console.log("dentro")
	

	console.log("test")
	



         fillTable("${anno}",'${filtro_tipo_pianificazioni}');
	
	
  
	    
	    $('[data-toggle="tooltip"]').tooltip();

	    $(document.body).css('padding-right', '0px');

	    
	    initContextMenu()
	    
	    
	     if (savedSearch && indexSearchbox!=null) {
		    indexSearchbox = parseInt(indexSearchbox);

		    // Imposta il valore di ricerca nella colonna corrispondente
		    $('thead .inputsearchtable').eq(indexSearchbox).val(savedSearch);
		
          //table.column(indexSearchbox).search(savedSearch).draw();
      }
});



function modalPianificazione(day, commessa, id){
	
	var cell = $('#'+commessa.replace("/", "")+"_"+day);
	
	var columnIndex = cell.index();

	// Recupera il testo dell'header corrispondente
	var headerText = cell.closest('table').find('thead th').eq(columnIndex).text();
	
	var currentYear = headerText.match(/\b\d{4}\b/)[0]
	//var currentYear = new Date().getFullYear()
	
	var dayValue = parseInt(day);
	var localDate = new Date(Date.UTC(currentYear, 0, dayValue));
	var d = localDate.getUTCDate();
	var month = localDate.getUTCMonth() + 1; 
	var year = localDate.getUTCFullYear();
	var formattedDate = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;


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
			if(pianificazione.pausa_pranzo=='SI'){
				$('#pausa_pranzo').iCheck("check");
				$('#durata_pausa_pranzo').val(pianificazione.durata_pausa_pranzo);
				$('#durata_pausa_pranzo').change();
			}else{
				$('#pausa_pranzo').iCheck("uncheck");
			}
			
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
		
			$('#anno_data').val(year);	

			
			$('#modalPianificazione').modal()
		});
		
		
	}else{
		$('#title_pianificazione').html("Pianificazione "+formattedDate+" Commessa: "+commessa)
		$('#day').val(day);
		$('#commessa').val(commessa);
		$('#anno_data').val(year);
		$('#btn_elimina').hide()
		$('#modalPianificazione').modal()
	}
	

	
}




function pastePianificazione(day, commessa){
	
	var id = cellCopy;
	
	if(cellCopy==null){
		id= $('#cellCopy').val();
	}
		
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
		$('#id_pianificazione').val("");
		$('#commessa').val(commessa);
		$('#day').val(day);
		$('#ora_inizio').val(pianificazione.ora_inizio);
		$('#ora_fine').val(pianificazione.ora_fine);
		$('#n_cella').val(day);
		$('#n_utenti').val(pianificazione.nUtenti);
		$('#descrizione').val(pianificazione.descrizione)




		nuovaPianificazione();
	});
	
	
}



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
		    lista_pianificazioni.sort(function(a, b) {
	            // Confronta le date
	            var dataA = new Date(a.data);
	            var dataB = new Date(b.data);

	            if (dataA.getTime() === dataB.getTime()) {
	                // Se le date sono uguali, confronta le ore di inizio
	                var oraInizioA = a.ora_inizio.split(':').map(Number); // [hour, minute]
	                var oraInizioB = b.ora_inizio.split(':').map(Number);

	                return oraInizioA[0] - oraInizioB[0] || oraInizioA[1] - oraInizioB[1];
	            }
	            return dataA - dataB; // Ordina per data
	        });
		    
		    
		    var is_modifica = response.is_modifica;
		    
		    var array = [];
		    var array_in_corso = [];
		    var day = [];
		    var map = {};
		    
		
		    var t = document.getElementById("tabForPianificazione");
		    var rows = t.rows;
		    for (var i = 1; i < rows.length; i++) {
		    	
		        var cells = rows[i].cells;
		        for (var j = 4; j < cells.length; j++) {
		          cells[j].innerHTML = "";
		        }
		      }
		    for (var i = 0; i < lista_pianificazioni.length; i++) {
		    	var id = lista_pianificazioni[i].id_commessa.replace("/","")+"_"+lista_pianificazioni[i].nCella;
				var cell = $("#"+id);
				
			
					var columnIndex = cell.index();
					var headerText = cell.closest('table').find('thead th').eq(columnIndex).text();
					
					if(headerText!=null && headerText!=''){
						var headerYear = headerText.match(/\b\d{4}\b/)[0]
						var pianYear = lista_pianificazioni[i].data.match(/\b\d{4}\b/)[0]
					}
				
				
				
				if(  headerYear == pianYear){
					var str_docenti = "";
					
					for(var j = 0; j < lista_pianificazioni[i].listaDocenti.length; j++){
						str_docenti += " - " + lista_pianificazioni[i].listaDocenti[j].nome +" "+ lista_pianificazioni[i].listaDocenti[j].cognome;
					}
					
					var icon = "";
					var orario = "";
					if(lista_pianificazioni[i].tipo.id==2){
						icon = '<i class="fa fa-star" aria-hidden="true"></i>   ';
						if(!lista_pianificazioni[i].descrizione.replace(":","").replace(".","").startsWith(lista_pianificazioni[i].ora_inizio.replace(":",""))){
							orario = lista_pianificazioni[i].ora_inizio+" - ";
						}
						
					}
					
					if(lista_pianificazioni[i].descrizione.length>20){
					
							//cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro'  style='margin-top:5px' ondblclick='modalPianificazione('"+lista_pianificazioni[i].nCella+"', '"+lista_pianificazioni[i].id_commessa+"','"+lista_pianificazioni[i].id+"')'>"+lista_pianificazioni[i].note.substring(0,20)+"...</div>");	
							cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPianificazione(\'"+lista_pianificazioni[i].nCella+"\', \'"+lista_pianificazioni[i].id_commessa+"\',\'"+lista_pianificazioni[i].id+"\')\">"+icon + orario + lista_pianificazioni[i].descrizione.substring(0,20)+"..."+str_docenti + "</div>");	
						
					}else{
						
							cell.append("<div id='riquadro_"+lista_pianificazioni[i].id+"' class='riquadro' style='margin-top:5px' ondblclick=\"modalPianificazione(\'"+lista_pianificazioni[i].nCella+"\', \'"+lista_pianificazioni[i].id_commessa+"\',\'"+lista_pianificazioni[i].id+"\')\">"+icon + orario + lista_pianificazioni[i].descrizione+str_docenti + "</div>");	
							 
						
						
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
						else if (lista_pianificazioni[i].stato.id == 6){
							riquadro.css("background-color", "#fa9d58");
							riquadro.css("border-color", "#fa6c03");
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
		    
		    
		
		     	    
			console.log("ciao")
		    
				
	  
			
			
			var today = "${today}"
			if(today>"${daysNumber}"){
				today = null;
			}else{
				order = parseInt(today) +3
			}
		
			var columsDatatables = [];
			
				if(table == null){
				    table = $('#tabForPianificazione').DataTable(settings)
				    
				  
			     
				 
				}else{
					table = $('#tabForPianificazione').DataTable();
				}
			
			    if (savedSearch && indexSearchbox!=null) {
				    indexSearchbox = parseInt(indexSearchbox);

				    // Imposta il valore di ricerca nella colonna corrispondente
				   // $('thead .inputsearchtable').eq(indexSearchbox).val(savedSearch);
				
		          table.column(indexSearchbox).search(savedSearch).draw();
		      }
			
/* 
				$("#tabForPianificazione").on( 'init.dt', function ( e, settings ) {
							    var api = new $.fn.dataTable.Api( settings );
							    var state = api.state.loaded();
							 
							    if(state != null && state.columns!=null){
							    		console.log(state.columns);
							    
							    columsDatatables = state.columns;
							    } 
						   	   
							     

							} );  */

			    
	  /*   $('.inputsearchtable').on('input', function() {
		    var columnIndex = $(this).closest('th').index(); // Ottieni l'indice della colonna
		    var searchValue = $(this).val(); // Ottieni il valore di ricerca

		    if(columsDatatables.length>0){
		    	 columsDatatables[columnIndex].search.search = searchValue;
		    }
		   

		    var x = table.column(columnIndex).data();
		    
		    table.column(columnIndex).search(searchValue).draw();
		    
		  
		
		    
		    
		  }); */
							
							
							
	  
	  $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
			
	  
	  

		 
		  var savedScrollLeft = localStorage.getItem('scrollLeftTablePianificazione');
		    if (savedScrollLeft !== null) {
		        $('#tabForPianificazione_wrapper .dataTables_scrollBody').scrollLeft(savedScrollLeft);
		    }else{
		    	  if(today!=null){
		    		  scrollToColumn(parseInt(today)-3);
		    		 
		              table.order([order, 'desc']).draw()
		    	  }else{
		    		  table.columns().draw();
		    	  }
		    }
	
			
		  


      // Aggiungi eventi per salvare i filtri e la ricerca su localStorage
    
     
      $('.inputsearchtable').on('input', function() {
          var searchValue = $(this).val();
          var columnIndex = $(this).closest('th').index();
          localStorage.setItem('lastSearch', searchValue);
          localStorage.setItem('indexSearch', columnIndex);
          table.column(columnIndex).search(searchValue).draw();
      });
	  
			  
	  
			  $(document.body).css('padding-right', '0px');
		  },
		  error: function(xhr, status, error) {
		    // Gestisci eventuali errori
		    console.error(error);
		  }
		  
		  
		  

		  
		});
	
	
	

}

function rimuoviFiltri(){

	    // Svuota tutti i searchbox
	    $('.inputsearchtable').each(function() {
	        $(this).val(''); // Pulisce il campo di input
	    });

	    // Rimuovi tutti i filtri dalla tabella
	    table.columns().search('').draw();

	    // Rimuovi i filtri salvati nel localStorage
	    localStorage.removeItem('lastSearch');
	    localStorage.removeItem('indexSearch');
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



window.addEventListener('beforeunload', function () {
    var scrollLeft = $('#tabForPianificazione_wrapper .dataTables_scrollBody').scrollLeft();
    localStorage.setItem('scrollLeftTablePianificazione', scrollLeft);
});

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