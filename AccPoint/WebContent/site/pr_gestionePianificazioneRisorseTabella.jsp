
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.PRRisorsaDTO"%>

<%@page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>


<%

ArrayList<PRRisorsaDTO> lista_risorse = (ArrayList<PRRisorsaDTO>) request.getSession().getAttribute("lista_risorse");
int anno = (Integer) request.getSession().getAttribute("anno");


%>





 <table id="tabPianificazioneRisorse" class="table table-primary table-bordered table-hover dataTable table-striped " role="grid" width="100%"  >
        <thead>
            <tr>
               <th >ID <input class="inputsearchtable" style="min-width:80px;width=100%" type="text"  id="inputsearchtable_0" /></th>
               <th>NOMINATIVO <input class="inputsearchtable" style="min-width:80px;width=100%" type="text" id="inputsearchtable_1"  /></th>
           <c:set var ="nuovoAnno" value="${anno + 1}"></c:set>                
         <c:forEach var="day" begin="${start_date }" end="${end_date }" step="1">
         
      <% 
      int dayValue =  (Integer) pageContext.getAttribute("day");
   
      int end_date =  (Integer) request.getSession().getAttribute("end_date");
     

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
      
          <c:forEach  items="${lista_risorse }" var="risorsa">
         <tr id="${risorsa.id}" >
        
         <td id = "col_1_${risorsa.id}" ">
       <b>${risorsa.id}</b>
         </td>
         <td id = "col_2_${risorsa.id}" data-toggle='tooltip' ><b >${risorsa.utente.nominativo}</b><div></div></td>

         <c:forEach var="day" begin="${start_date }" end="${end_date}" step="1">
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day>366 }">
			<td  id="${risorsa.id}_${day-366}" style="position:relative"></td> 
			</c:if>
			<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day>365 }">
			<td id="${risorsa.id}_${day-365}" style="position:relative"></td> 
			</c:if>
			<c:if test="${LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=366 }">
			<td  id="${risorsa.id}_${day}" style="position:relative"></td> 
			</c:if>
         	<c:if test="${!LocalDate.ofYearDay(anno, 1).isLeapYear() && day<=365 }">
			<td  id="${risorsa.id}_${day}" style="position:relative"></td> 
			</c:if>
         	<%-- <td id="${risorsa.id}_${day}" ondblclick="modalAssociaIntervento('${day}', '${commessa.ID_COMMESSA }')"></td> --%>
         	<%-- <td id="${risorsa.id}_${day}"></td> --%>
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







        .prenotato {
        
    }

/*       .riquadro {
      border: 1px solid red;
     padding: 5px;
       position:absolute;  
 
}  */

.riquadro {
     position: absolute; 
    left: 0;
    border: 1px solid #FFD700;
    background-color: #FFFFE0;
    text-align: center;
    font-weight: bold;
    padding: 4px; 
    white-space: normal;
    word-wrap: break-word;
    border-radius: 4px;
    box-sizing: border-box;
    z-index: 2;
}



#tabPianificazioneRisorse tbody tr {
   /*  width: auto !important; */
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
    

    


function modalAssociaIntervento(data_inizio,data_fine, id_risorsa, id_associazione){
	
	$('#id_risorsa').val(id_risorsa)
	$('#cella').val(data_inizio)
	$('#id_risorsa').val(id_risorsa)
	$('#calendario').val(1)
	
		var currentYear = new Date().getFullYear()
		var dayInizio = parseInt(data_inizio);
		var localDate = new Date(Date.UTC(currentYear, 0, dayInizio));
		var d = localDate.getUTCDate();
		var month = localDate.getUTCMonth() + 1; 
		var year = localDate.getUTCFullYear();
		var formattedDateInizio = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
		$('#data_inizio').val(formattedDateInizio)
		
		var dayFine = parseInt(data_fine);
		var localDate = new Date(Date.UTC(currentYear, 0, dayFine));
		var d = localDate.getUTCDate();
		var month = localDate.getUTCMonth() + 1; 
		var year = localDate.getUTCFullYear();
		var formattedDateFine = ('0' + d).slice(-2) + '/' + ('0' + month).slice(-2) + '/' + year;
		
		

	$('#data_fine').val(formattedDateFine)
		
		dataObj = {};
		dataObj.id_risorsa = id_risorsa;
		dataObj.data = formattedDateFine;
		
		
		
		callAjax(dataObj, "gestioneRisorse.do?action=trova_interventi_disponibili", function(data){
			
			if(data.success){
				
				var risorsa = data.risorsa;
				var lista_interventi = data.lista_interventi;
				var lista_interventi_risorsa = data.lista_interventi_risorsa;
				lista_interventi_json = lista_interventi;
				
				$('#title_pianificazione').html("Associa intervento a " +risorsa.utente.nominativo);
				
				var table_data = [];
				
				for(var i = 0; i<lista_interventi.length;i++){
					  var dati = {};
				/* 	  dati.check ="<td></td>"; */
				  dati.check = null; 
					  dati.id = lista_interventi[i].id;
					  dati.commessa = lista_interventi[i].idCommessa;
					
					   var presso = lista_interventi[i].pressoDestinatario;
					  	if(presso== 0){
						  dati.presso = "In Sede";
					 	 }else if(presso== 1){
						  dati.presso = "Presso il Cliente";
					  	}
						else if(presso== 2){
							 dati.presso = "Misto - Cliente - Sede";				  
					 	}
						else if(presso== 3){
							 dati.presso = "Presso Laboratorio";
						}
						else if(presso== 4){
							 dati.presso = "Presso Fornitore Esterno";
						}
					 
					  dati.cliente = escapeHtml(lista_interventi[i].nome_cliente);
					  dati.sede = lista_interventi[i].nome_sede;
					 // dati.responsabile = lista_interventi[i].user.nominativo;
					  
					  var risorsa_intervento = lista_interventi_risorsa.find(function(r) {
						    return r.id_intervento === lista_interventi[i].id;
						});
					/*   if(risorsa_intervento){
						  dati.date = '<input type="text" class="form-control daterange" id="daterange_'+lista_interventi[i].id+'" autocomplete="off" value="'+risorsa_intervento.data_inizio+' - '+risorsa_intervento.data_fine+'"/>';  
					  }else{
						  dati.date = '<input type="text" class="form-control daterange" id="daterange_'+lista_interventi[i].id+'" autocomplete="off" />';
					  } */
					
					  dati.azioni = "<a class='btn btn-primary' onClick='mostraRequisiti("+lista_interventi[i].id+")'>Requisiti</a>";
					  
					  
					  dati.DT_RowId = dati.id;
					  table_data.push(dati);
					
			
		    }

		
				 
				   var t = $('#tabInterventi').DataTable()
				t.clear().draw();
				   
				t.rows.add(table_data).draw();
					
				t.columns.adjust().draw();
				
				if(lista_interventi_risorsa!=null){
					
					for(var i = 0; i<lista_interventi_risorsa.length;i++){
						
						$('#tabInterventi').find("tr").each(function(){
							if($(this).attr("id")  == lista_interventi_risorsa[i].id_intervento && formattedDateInizio>= lista_interventi_risorsa[i].data_inizio && formattedDateFine<= lista_interventi_risorsa[i].data_fine ){
								 /* var input = lista_interventi_risorsa[i].data_inizio +" - "+lista_interventi_risorsa[i].data_fine
								t.row( "#"+lista_interventi_risorsa[i].id_intervento ).find("td").eq(7).find("input").val(input);*/
								t.row( "#"+lista_interventi_risorsa[i].id_intervento ).select(); 
							}
						})
						
					}
				}
			
				$('.daterange').daterangepicker({
				    locale: {
				        format: 'DD/MM/YYYY',
				        applyLabel: 'Applica',
				        cancelLabel: 'Annulla',
				        daysOfWeek: ['Do', 'Lu', 'Ma', 'Me', 'Gi', 'Ve', 'Sa'],
				        monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno',
				            'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
				        firstDay: 1
				    },
				    autoUpdateInput: false
				});

				$('.daterange').on('apply.daterangepicker', function(ev, picker) {
				    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
				});

				$('.daterange').on('cancel.daterangepicker', function(ev, picker) {
				    $(this).val('');
				});
			}
		
		$('#modalAssociazione').modal()
			
		}, "GET");
		
	  

	
	

}

var lista_interventi_json;

function mostraRequisiti(id_intervento){
	
	var str_doc ="<ul class='list-group list-group-unbordered'>";
	var str_san ="<ul class='list-group list-group-unbordered'>";
	
	
	var intervento_json = lista_interventi_json.find(item => item.id === id_intervento);
	

	if(intervento_json!=null){
		var listaRequisiti = intervento_json.listaRequisiti;
		
		for(var i = 0; i<listaRequisiti.length;i++){
			if(listaRequisiti[i].requisito_documentale!=null){
				str_doc+="<li class='list-group-item'>"+listaRequisiti[i].requisito_documentale.categoria.descrizione+"</li>"	
			}
			if(listaRequisiti[i].requisito_sanitario!=null){
				str_san+="<li class='list-group-item'>"+listaRequisiti[i].requisito_sanitario.descrizione+"</li>"	
			}
			
		}
	}
		

	str_doc +="</ul>";
	str_san +="</ul>";
	$("#content_requisiti_doc").html(str_doc);
	$("#content_requisiti_san").html(str_san);
	
	$('#modalRequisiti').modal()
}



var lista_requisiti_doc_risorse;
var lista_risorse_json;

function mostraRequisitiRisorsa(id_risorsa){
	
	var str_doc ="<ul class='list-group list-group-unbordered'>";
	var str_san ="<ul class='list-group list-group-unbordered'>";
	
	var risorsa_json = lista_risorse_json.find(item => item.id === id_risorsa);
	
	if(risorsa_json!=null){
		var listaRequisiti = risorsa_json.listaRequisiti;
		
		var risorsa_doc_json = lista_requisiti_doc_risorse[id_risorsa];
		
		for(var i = 0; i<risorsa_doc_json.length;i++){

			str_doc+="<li class='list-group-item'>"+risorsa_doc_json[i].descrizione+"</li>"	
	}
	for(var i = 0; i<listaRequisiti.length;i++){
		if(listaRequisiti[i].req_sanitario!=null){
			if(listaRequisiti[i].stato == 1){
				stato = "IDONEO";
			}else if(listaRequisiti[i].stato == 2){
				stato = "NON IDONEO";
			}else if(listaRequisiti[i].stato == 3){
				stato = "PARZIALMENTE IDONEO ("+ listaRequisiti[i].note+")";
			}
			str_san+="<li class='list-group-item'>"+listaRequisiti[i].req_sanitario.descrizione+ " - " +stato+ " - Scadenza: "+ listaRequisiti[i].req_san_data_fine+"</li>"	
		}
		
	}
	}


	str_doc +="</ul>";
	str_san +="</ul>";
	$("#content_requisiti_doc").html(str_doc);
	$("#content_requisiti_san").html(str_san);
	
	$('#modalRequisiti').modal()
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
    "order": [[0 , "asc" ]],
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
          leftColumns: 2,
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
	                     .attr('onclick', "modalAssociaIntervento('" + cellId.split("_")[1] + "','" + cellId.split("_")[1] + "', '" + cellId.split("_")[0] + "')")
	                     .html('<i class="fa fa-plus"></i>')
	                     .appendTo($buttonContainer);

	        table = $('#tabPianificazioneRisorse').DataTable()
	        table.draw(); 
	        $(window).scrollTop(scrollPos);
	        $(this).closest('.dataTables_scrollBody').scrollTop(scrollPosition);
	    
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
	
	  //pleaseWaitDiv.modal('hide');
});


	

var selectedDiv = null;
var offsetX;
var offsetY;




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

var cellCopy;




$(document).ready(function() {
	
	
	    	
	
	 var tableRisorse = $('#tabRisorse').DataTable({
		  language: {
		    emptyTable: "Nessun dato presente nella tabella",
		    info: "Vista da _START_ a _END_ di _TOTAL_ elementi",
		    infoEmpty: "Vista da 0 a 0 di 0 elementi",
		    infoFiltered: "(filtrati da _MAX_ elementi totali)",
		    lengthMenu: "Visualizza _MENU_ elementi",
		    loadingRecords: "Caricamento...",
		    processing: "Elaborazione...",
		    search: "Cerca:",
		    zeroRecords: "La ricerca non ha portato alcun risultato.",
		    paginate: {
		      first: "Inizio",
		      previous: "Precedente",
		      next: "Successivo",
		      last: "Fine"
		    },
		    aria: {
		      sortAscending: ": attiva per ordinare la colonna in ordine crescente",
		      sortDescending: ": attiva per ordinare la colonna in ordine decrescente"
		    }
		  },
		  pageLength: 25,
		  order: [[1, "desc"]],
		  paging: true,
		  ordering: true,
		  info: true,
		  searchable: true,

		  responsive: true,
		  scrollX: false,
		  stateSave: true,

		  select: {
		    style: 'multi-shift',
		    selector: 'td:first-child' // attenzione: meglio usare 'first-child' che 'nth-child(1)'
		  },

		  columns: [
		    { data: null }, // <- questo va così se non c'è "check" nel JSON
		    { data: "id" },
		    { data: "nominativo" },
		    { data: "data" },
		    { data: "azioni" }
		  ],

		  columnDefs: [
		    {
		      targets: 0,
		      className: 'select-checkbox',
		      orderable: false,
		      defaultContent: ''
		    },
		    { responsivePriority: 1, targets: 1 }
		  ],

		  buttons: [{
		    extend: 'colvis',
		    text: 'Nascondi Colonne'
		  }]
		});

 	    
	
	
	// pleaseWaitDiv.modal('show');
	console.log("dentro")
zoom_level  = parseFloat(Cookies.get('page_zoom'));

        fillTable("${anno}",'${filtro_tipo_pianificazioni}');
        


	    $(document.body).css('padding-right', '0px');
	    

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
	    console.log("Avvio fillTable");
	    pleaseWaitDiv.modal('show');
	    
	    $.ajax({
	        url: 'gestioneRisorse.do?action=lista_associazioni&anno=' + anno,
	        method: 'GET',
	        dataType: 'json',
	        success: function(response) {
	            var lista_associazioni = response.lista_associazioni;

	            $('.riquadro').remove();
	            $('#tabPianificazioneRisorse td').removeClass('prenotato_multi');

	            if (table == null) {
	                table = $('#tabPianificazioneRisorse').DataTable(settings);
	            } else {
	                $('#tabPianificazioneRisorse').DataTable().destroy();
	                table = $('#tabPianificazioneRisorse').DataTable(settings);
	            }

	      
	          //  const larghezza = 95;

	             for (var i = 0; i < lista_associazioni.length; i++) {
	                var pren = lista_associazioni[i];
	                var id_associazione = pren.id;
	                var cella_inizio = pren.cella_inizio;
	                var cella_fine = pren.cella_fine;
	                var id_risorsa = pren.risorsa.id;

	                var id_inizio = id_risorsa + "_" + cella_inizio;
	                var id_fine = id_risorsa + "_" + cella_fine;

	                var cellaInizio = $("#" + id_inizio);
	                var cellaFine = $("#" + id_fine);

	                var numeroRiquadri = cellaInizio.find('.riquadro').length;


	                
	                var cellaPrecedente = null;
 	                var cellaSuccessiva = null;
 	               var posizionePartenza = cellaInizio.offset();
	                var posizioneArrivo = cellaFine.offset();
	                
	                if(posizionePartenza!=null){
	                	
	                
	                if(id_inizio!=id_fine){
 	                	nCelle=parseInt(id_fine.split("_")[1]) - parseInt(id_inizio.split("_")[1])
 	                }else{
 	                	nCelle = 1
 	                }
	               
		            const distanza = 1;
	                var testo = pren.testo_riquadro
 	                var larghezzaTesto = getTextWidth(testo, '12px Arial') + 20; // Aggiungi un margine per una migliore presentazione

 	                var larghezza =  posizioneArrivo.left - posizionePartenza.left + cellaInizio.outerWidth(true);
 	                
 	             	if(nCelle>1){
 	             		larghezza = 0;
 	             	for(var k = 0; k<nCelle; k++){
 	             		var cellaCorrente = $('#'+id_risorsa+"_"+(cella_inizio+k))
 	             		larghezza = larghezza + cellaCorrente.outerWidth();
 	             	}
 	             	
 	             		//larghezza =nCelle * cellaInizio.outerWidth(true) + cellaInizio.outerWidth(true)
 	             	}
					
 	   
 	                var altezza = 45;
 	                 if(larghezzaTesto>=larghezza){
 	                	altezza = altezza * 2;
 	                	//larghezza = larghezzaTesto
 	                } 
	                
	                
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
 	                 
 	                 
 	                
 	                
 	                for (var j = 0; j < nCelle; j++) {
 						$('#'+id_inizio.split("_")[0]+"_"+(parseInt(id_inizio.split("_")[1]) + j)).addClass('prenotato');
 						var x = '#'+id_inizio.split("_")[0]+"_"+parseInt(id_inizio.split("_")[1]) + j
 						if(id_inizio!=id_fine){
 							$('#'+id_inizio.split("_")[0]+"_"+(parseInt(id_inizio.split("_")[1]) + j)).addClass('prenotato_multi');
 						}
 					}
 	               
					  if(id_inizio==id_fine){
						var larghezza =  larghezza - 2;
					}  

	                
	                var sinistra = 0;
	                var alto = 0

	                if(numeroRiquadri=== 0){
	                	
		                var riquadro = $("<div class='riquadro bg-warning text-dark p-2 rounded shadow-sm' style='margin-top:42px'></div>").css({
		                	 left: sinistra,
	 	                        top: alto,
	 	                        width: larghezza,
	 	                    
	 	                        'text-align': 'center',
	 	                        whiteSpace: "normal",
	 		                    wordWrap: "break-word", 
		                    fontWeight: "bold",
		                    border: "1px solid #FFD700",
		                    backgroundColor: "#FFFFE0",
		                    textAlign: "center",		            
		                }).html('ID: '+pren.id_intervento+'<br>'+pren.testo_riquadro).attr('ondblclick', 'modalModificaAssociazione('+id_associazione+',"'+pren.testo_riquadro+'")');

	                
		                cellaInizio.append(riquadro);
		                
		                 
		                var rowId = cellaInizio.closest('tr').attr('id');
 			            var altezzaRiga = $("#"+rowId).height();
 			            
 			           var altezzaRiquadro = riquadro.height();
 	                    
 	                    //var nuovaAltezzaRiga = (numeroRiquadri + 1) * (altezza + 42); // +1 per includere il nuovo riquadro
 	                    var nuovaAltezzaRiga  = altezzaRiga + altezzaRiquadro -42

 		                // Aggiorna l'altezza della riga
 		                if(nuovaAltezzaRiga>altezzaRiga){
 		                	cellaInizio.closest('tr').children('td').height(nuovaAltezzaRiga);
 		                } 
 		                
	                }else{
	                	
	                	
	                	
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
 	                 
 	                 
 	                var riquadro = $("<div class='riquadro bg-warning text-dark p-2 rounded shadow-sm' style='margin-top:5px'></div>").css({
	                	 left: sinistra,
	                        top: nuovaPosizioneVerticale,
	                        width: larghezza,
	                 
	                        'text-align': 'center',
	                         whiteSpace: "normal",
		                    wordWrap: "break-word", 
	                    fontWeight: "bold",
	                    border: "1px solid #FFD700",
	                    backgroundColor: "#FFFFE0",
	                    textAlign: "center",	  
 	               }).html('ID: '+pren.id_intervento+'<br>'+pren.testo_riquadro).attr('ondblclick', 'modalModificaAssociazione('+id_associazione+',"'+pren.testo_riquadro+'")');

               
	                cellaInizio.append(riquadro);
	                
	                
	                var rowId = cellaInizio.closest('tr').attr('id');
 		            var altezzaRiga = $("#"+rowId).height();

 	                    var altezzaRiquadro = riquadro.height();

 	                   var nuovaAltezzaRiga  = altezzaRiga + altezzaRiquadro
 	  	            if(altezzaRiga<=nuovaAltezzaRiga){
 	  	           // if(altezzaRiga<=ultimaPosizione){
 	  	            	   cellaInizio.closest('tr').children('td').height(nuovaAltezzaRiga);
 	  	            	 // updatePosition(cellaInizio.closest('tr'), nuovaAltezzaRiga, altezzaRiga); 
 	  	            	
 	  	            	
 	  	            }
	                	
	                }

	            } 
	                }
	            
	            // Ricostruzione ricerca
	            $('.inputsearchtable').on('input', function() {
	                var colIndex = $(this).closest('th').index();
	                var val = $(this).val();
	                table.column(colIndex).search(val).draw();
	            });

	            $('.inputsearchtable').on('click', function(e) {
	                e.stopPropagation();
	            });

	            table.columns.adjust().draw();

	            // Scroll automatico
	            var today = "${today}";
	            if (parseInt(today) > "${daysNumber}") today = null;
	            var coltoday = getDaysUntilMonday(parseInt(today), parseInt("${start_date}")) + 1;
	            scrollToColumn(today - coltoday);

	            pleaseWaitDiv.modal('hide');
	        },
	        error: function(xhr, status, error) {
	            console.error(status);
	        }
	    });
	}

	    
	    
	function modalModificaAssociazione(id_associazione, testo){
		
		dataObj ={}
		dataObj.id_associazione = id_associazione;
		
		
		
		$('#id_associazione').val(id_associazione)
		callAjax(dataObj, "gestioneRisorse.do?action=get_associazione", function(data){
			
			if(data.success){
				
				var associazione = data.associazione;
				var id_encrypted = data.id_encrypted;
		
				
				$('#label_intervento').html("Intervento ID: <a class='customTooltip' target='_blank' href='gestioneInterventoDati.do?idIntervento="+id_encrypted+"'>"+associazione.id_intervento+" </a>- "+testo)
				
				$('#data_inizio_mod').val(associazione.data_inizio);
				$('#data_fine_mod').val(associazione.data_fine);
				
			$('#modalModificaAssociazione').modal()
			
			}
			
		}, "GET");
	
	}

function filterTable() {
    var table = $('#tabPianificazioneRisorse');
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
	
	

    var tableWrapper = $('#tabPianificazioneRisorse_wrapper');
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
    
    pleaseWaitDiv.modal('hide');

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