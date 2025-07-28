<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.Calendar" %>

<%
String[] nomiMesi = {
	    "GENNAIO", "FEBBRAIO", "MARZO", "APRILE", "MAGGIO", "GIUGNO",
	    "LUGLIO", "AGOSTO", "SETTEMBRE", "OTTOBRE", "NOVEMBRE", "DICEMBRE"
	};
    pageContext.setAttribute("nomiMesi", nomiMesi);
    

%>
  <c:set var="currentYear" value="<%= Calendar.getInstance().get(Calendar.YEAR) %>" />
<div class="row">
<div class="col-sm-9">
<a class="btn btn-primary" onClick="modalNuovaScadenza()"><i class="fa fa-plus"></i> Nuova Scadenza</a>


</div>

            <div class="col-xs-3"> 
            <label>Anno</label>
         <select class="form-control select2" id="anno" name="anno" style="width:100%" onchange="cambiaAnno()">

		
			  <c:set var="startYear" value="${currentYear - 5}" />
			  <c:set var="endYear" value="${currentYear + 5}" />
			
			  <c:forEach var="year" begin="${startYear}" end="${endYear}">
			  <c:if test="${year == anno }">
			  	    <option value="${year}" selected>${year}</option>
			  </c:if>
			   <c:if test="${year != anno }">
			  	    <option value="${year}" >${year}</option>
			  </c:if>
		
			  </c:forEach>
			</select>
             </div>
</div><br>

<!-- 
       	<div class="col-sm-9">       	
       		<input class="form-control" data-placeholder="Seleziona Cliente..." id="test" name="test" style="width:100%" >
       		 <input id="test" style="width:100%;" placeholder="type a number, scroll for more results" /> 	
       	</div>  -->

<div class="row">
<div class="col-sm-12">

 <table id="tabScadenzario" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
  <thead>
    <tr class="active">
      <th></th>
      <th></th>
      <c:forEach items="${lista_attrezzature}" var="attrezzatura">
        <th>${attrezzatura.descrizione}</th>
      </c:forEach>
    </tr>
  </thead>

  <tbody>
  <%--   <c:set var="anno" value="${anno }" /> --%>
    <c:forEach var="mese" begin="0" end="11" varStatus="status">
      <tr>
        <c:if test="${status.first}">
          <td rowspan="12" class="vertical-text" style="width:20px; max-width:20px; min-width:20px;">${anno}</td>
        </c:if>

        <!-- Nome del mese -->
        <td>${nomiMesi[status.index]}</td>

        <!-- Celle per ogni attrezzatura -->
        <c:forEach items="${lista_attrezzature}" var="attrezzatura">
          <td style="text-align:center;">
            <c:choose>
              <c:when test="${attrezzatura.mapScadenze[nomiMesi[status.index]] != null}">
                <a class="btn customTooltip customlink" target="_blank" href="amScGestioneScadenzario.do?action=lista_scadenze_mese&id_attrezzatura=${attrezzatura.id }&mese=${mese}&anno=${anno}">${attrezzatura.mapScadenze[nomiMesi[status.index]]}</a>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
        </c:forEach>
      </tr>
    </c:forEach>
  </tbody>
</table>
</div>
</div>


<form id="nuovaScadenzaForm" name="nuovaScadenzaForm">
<div id="myModalNuovaScadenza" class="modal fade" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività </h4>
      </div>
       <div class="modal-body">

        <div class="row">
       
       	<div class="col-sm-3">
       		<label>Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">       	
       		<select class="form-control select2" data-placeholder="Seleziona Attrezzatura..." id="attrezzatura" name="attrezzatura" style="width:100%" required>
       		<option value=""></option>
       			<c:forEach items="${lista_attrezzature}" var="attrezzatura" varStatus="loop">
       				<option value="${attrezzatura.id}">${attrezzatura.descrizione }</option>
       			</c:forEach>
       		</select>       	
       	</div>       	
       </div><br>
        <div class="row">
      	<div class="col-sm-3">
       		<label>Attività </label>
       	</div>
       	<div class="col-sm-9">
       	<a class="btn btn-primary" onclick="modalAggiungiAttivita()"><i class="fa fa-plus"></i></a>

       	</div>
       </div><br>

        
       </div>

  		 
      <div class="modal-footer">
    
		<input type="hidden" id="id_attivita" name="id_attivita" >


		 
		<button class="btn btn-primary" type="submit" >Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



<div id="myModalNuovaAttivita" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalNuovoRilievo">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuova Attività </h4>
      </div>
       <div class="modal-body">

        <div class="row">
        <div class="col-xs-12">
        
         <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" style="width:100%">
  <thead>
    <tr class="active">
      <th></th>
      <th style="max-width:20px">ID</th>
      <th style="min-width:100px">Data Attività </th>
      <th style="min-width:100px">Esito</th>
      <th style="max-width:40px">Frequenza</th>
      <th style="min-width:100px">Data Scadenza</th>
      <th style="max-width:120px">Note</th>
      <th style="min-width:120px">Descrizione attività </th>
     
    </tr>
  </thead>

  <tbody>
  
    <c:forEach items="${lista_attivita }" var="attivita" varStatus="status">
      <tr>
     
     <td></td>
        <td>${attivita.id }</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        
        <td>${attivita.descrizione }</td>

      </tr>
    </c:forEach>
  </tbody>
</table>
        
       </div>
       </div>
        
        
       </div>

  		 
      <div class="modal-footer">

		 
		<a class="btn btn-primary" type="submit" onclick="assegnaIdAttivita()">Salva</a> 
       
      </div>
    </div>
  </div>

</div>





  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
       <div id="tab_allegati"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      </div>
   
  </div>
  </div>
</div>


 <div id="myModalArchivio" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index: 9900;">
  
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati provvedimento legalizzazione bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">

 

       <div id="tab_allegati_provvedimento"></div>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      <input type="hidden" id="id_provvedimento_allegato" name="id_provvedimento_allegato">
      
      <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalArchivio').modal('hide')">Chiudi</a>
      
      </div>
   
  </div>
  </div>
</div>


  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato" style="z-index: 9999;">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'allegato?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_allegato_elimina">
      <a class="btn btn-primary" onclick="eliminaAllegatoLegalizzazione($('#id_allegato_elimina').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="myModalAssociaLegalizzazione" class="modal modal-fullscreen fade" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Associazione Legalizzazione Bilance</h4>
      </div>
       <div class="modal-body">
       <div class="row">
        <div class="col-xs-12">
      <table id="table_legalizzazione" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th style="max-width:15px"></th>
<th>ID</th>
<th>Descrizione Strumento</th>
<th>Costruttore</th>
<th>Modello</th>
<th>Classe</th>
<th>Tipo approvazione</th>
<th>Tipo provvedimento</th>
<th>Numero provvedimento</th>
<th>Data provvedimento</th>
<th>Rev.</th>
<th>Azioni</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
  		 </div>
  		 </div>
      <div class="modal-footer">
      
      
      <input type="hidden" id="id_strumento_legalizzazione" name="id_strumento_legalizzazione">
      <a class="btn btn-primary" onClick="associaStrumentoLegalizzazione(false)" id="button_salva">Salva</a>
      <a class="btn btn-primary" style="display:none" onClick="associaStrumentoLegalizzazione(true)" id="button_associa">Salva</a>
       <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalAssociaLegalizzazione').modal('hide')">Chiudi</a>
      </div>
   
  </div>
  </div>
</div>



 <style>
 input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}




.vertical-text {
  border-right: 1px solid #ddd !important;
  writing-mode: vertical-rl;
  transform: rotate(180deg);
  text-align: center;
  vertical-align: middle;
  padding: 5px;
  font-weight: bold;
  white-space: nowrap;
  font-size: 20px;
}
</style>


<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script>



<script type="text/javascript">


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}






function modalNuovaScadenza(){
	

	$('#myModalNuovaScadenza').modal();
	
}

function modalAggiungiAttivita(){
	

	$('#myModalNuovaAttivita').modal();
	
}




var columsDatatables = [];





$(document).ready(function() {

	console.log("test");
    $('.dropdown-toggle').dropdown();
   
   $("#attrezzatura").select2()

     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

    
     
  
    
   var table = $('#tabAttivita').DataTable({
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
	        order: [[1, "desc"]],
	        paging: false,
	        ordering: true,
	        info: true,
	        searchable: false,
	        targets: 0,
	        responsive: true,
	        scrollX: false,
	        stateSave: true,
	 
	        select: {
	            style: 'multi+shift',
	            selector: 'td:nth-child(1)'
	        },
	        columnDefs: [
	            { responsivePriority: 1, targets: 1 },
	            { className: "select-checkbox", targets: 0, orderable: false },
	            { targets: 1, width: "40px" },    // ID
	            { targets: 2, width: "120px" },   // Data Attività
	            { targets: 3, width: "80px" },   // Esito
	            { targets: 4, width: "60px" },    // Frequenza
	            { targets: 5, width: "120px" },   // Data Scadenza
	            { targets: 6, width: "150px" },   // Note
	            { targets: 7, width: "200px" }   
	        ]	     
			        
	  	    
		               
		    });
		
 		table.buttons().container().appendTo( '#tabScadenzario_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAttivita').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});  
	
	
	
	
	
	
});


$('#modificaVerStrumentoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaVerStrumento();
});



$('#nuovaScadenzaForm').on('submit', function(e){
	 e.preventDefault();
	 callAjaxForm("#nuovaScadenzaForm", "amScGestioneScadenzario.do?action=nuova_scadenza", function(data){
		 
		 if(data.success){
			 
			 
			 $('#report_button').hide();
				$('#visualizza_report').hide();
			  $("#modalNuovoReferente").modal("hide");
			  $('#myModalErrorContent').html(data.messaggio);
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-success");
				$('#myModalError').modal('show');
			 
			 $('#myModalError').on("hidden.bs.modal", function(){
				
				 if($(this).hasClass("modal-success")){
					 
					 

					  dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val();
					   exploreModal('amScGestioneScadenzario.do',dataString,'#posTab');
					   
					   $('.modal-backdrop').hide()
					 }				 
			 });
			 
		 }
		 
	 })
});


function cambiaAnno(){
	  dataString = "action=lista&id_cliente="+$('#cliente').val()+"&id_sede="+$("#sede").val()+"&anno="+$('#anno').val();
	   exploreModal('amScGestioneScadenzario.do',dataString,'#posTab');
	   
}

/* function assegnaIdAttivita(){
	
	var id_attivita_selected = "";
	var t = $('#tabAttivita').DataTable();
    t.rows({ selected: true }).every(function () {
        var $row = $(this.node());
        var id = $row.find('td').eq(1).text().trim(); // Colonna ID
        id_attivita_selected += id + ";";
    });
    
    $('#id_attivita').val(id_attivita_selected)
    
    $('#myModalNuovaAttivita').modal("hide");
} */


/* function assegnaIdAttivita(){
	
	var id_attivita_selected = "";
	var t = $('#tabAttivita').DataTable();
    t.rows({ selected: true }).every(function () {
        var $row = $(this.node());
        var valori = "";

        $row.find('td').each(function(i, cell) {
            let testo = "";

            if (i === 0 ) return; // Salta checkbox e descrizione

            if (i === 1) {
                // ID
                testo = $(cell).text().trim();
            } 
            
            else if (i === 3) {
                // SELECT
                let select = $(cell).find("select");
                if (select.length) {
                    testo = select.val();
                }
            } 
            else if(i===6){
            	
            	let textarea = $(cell).find("textarea");
                if (textarea.length) {
                    testo = textarea.val();
                }
            }
            else {
                // Datepicker input
                let input = $(cell).find("input");
                if (input.length) {
                    testo = input.val();
                }
            }

            valori += testo + ",";
        });

        id_attivita_selected += valori.slice(0, -1) + ";";
    });


    
    $('#id_attivita').val(id_attivita_selected)
    
    $('#myModalNuovaAttivita').modal("hide");
} */




function assegnaIdAttivita() {
    var id_attivita_selected = "";
    var t = $('#tabAttivita').DataTable();
    var tuttoValido = true;

    t.rows({ selected: true }).every(function () {
        var $row = $(this.node());
        var valori = "";

        $row.find('td').each(function(i, cell) {
            let testo = "";

            if (i === 0) return; // Salta checkbox

            if (i === 1) {
                // ID (solo testo, quindi ammesso anche vuoto)
                testo = $(cell).text().trim();
            } 
            else if (i === 3) {
                // SELECT obbligatoria
                let select = $(cell).find("select");
                if (select.length) {
                    testo = select.val();
                    if (!testo) {
                        alert("Seleziona un valore nella colonna " + (i+1));
                        tuttoValido = false;
                        return false;
                    }
                }
            } 
            else if (i === 6) {
                // TEXTAREA facoltativa
                let textarea = $(cell).find("textarea");
                testo = textarea.length ? textarea.val() || "" : "";
            } 
            else {
                // INPUT obbligatorio (es. datepicker)
                let input = $(cell).find("input");
                if (input.length) {
                    testo = input.val();
                    if (!testo || testo.trim() === "") {
                    	
                    	if(i == 2){
                    		var col = "DATA ATTIVITA'"
                    	}
                    	if(i == 4){
                    		var col = "FREQUENZA"
                    	}
                    	if(i == 5){
                    		var col = "DATA SCADENZA"
                    	}
                    	
                        alert("Compila il campo nella colonna " +col);
                        tuttoValido = false;
                        return false;
                    }
                }
            }

            valori += testo + ",";
        });

        if (!tuttoValido) return false; // blocca ciclo .every se un campo non va

        id_attivita_selected += valori.slice(0, -1) + ";";
    });

    if (!tuttoValido) return;

 $('#id_attivita').val(id_attivita_selected)
    
    $('#myModalNuovaAttivita').modal("hide");
}




$('#tabAttivita').on('select.dt', function (e, dt, type, indexes) {
    if (type === 'row') {
        indexes.forEach(function(index) {
            var row = dt.row(index).node();
            var id = "";

            $(row).find('td').each(function(i, cell) {
                const $cell = $(cell);

                // Leggi ID dalla cella 1 ma NON applicare bordi o altro
                if (i === 1) {
                    id = $cell.text().trim();
                }

                // Salta checkbox (0), ID (1) e ultima colonna (7) per stile/modifica
                if (i === 0 || i === 1 || i === 7) return;

                // Salva bordo originale (per eventuale ripristino)
                if (!$cell.data('original-border')) {
                    $cell.data('original-border', $cell.css('border'));
                }

                // Applica bordo rosso
                $cell.css('border', '1px solid red');

                // Inserisci input/select/datepicker a seconda della colonna
                if (i === 4) {
                    const input = '<input type="number" step="1" min="0" required class="form-control" onchange="aggiornaDataScadenza(' + id + ')" id="frequenza_' + id + '"/>';
                    $cell.html(input);
                }
                else if (i === 3) {
                    const options = '<select required class="form-control select2" id="esito_' + id + '" style="width:100%"> <option value="P">POSITIVO</option> <option value="N">NEGATIVO</option>  </select>';
                    $cell.html(options);
                    $('#esito_' + id).select2();
                }
                else if (i === 2) {
                    const input = $('<div class="input-group date datepicker"><input type="text" required onchange="aggiornaDataScadenza(' + id + ')" class="datepicker  form-control" id="data_attivita_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>');
                    $cell.html(input);
                    $('.datepicker').datepicker({
                        format: "dd/mm/yyyy"
                    });
                }
                else if (i === 5) {
                    const input = $('<div class="input-group date datepicker"><input type="text" readonly required class="form-control" id="data_scadenza_' + id + '"/><span class="input-group-addon"><span class="fa fa-calendar"></span></span></div>');
                    $cell.html(input);
                }
                else if (i === 6) {
                    const input = $('<textarea id="note_' + id + '" class="form-control" style="width:100%"/></textarea>');
                    $cell.html(input);
                }
            });
        });
    }
});


// Deselect row
$('#tabAttivita').on('deselect.dt', function (e, dt, type, indexes) {
    if (type === 'row') {
        indexes.forEach(function(index) {
            var row = dt.row(index).node();
            $(row).find('td').each(function(i, cell) {
                const $cell = $(cell);
                if (i === 0 || i === 1 || i === 7) return;

                const originalBorder = $cell.data('original-border');
                if (originalBorder !== undefined) {
                    $cell.css('border', originalBorder);
                    $cell.removeData('original-border');
                }

                $cell.text('');
            });
        });
    }
});

function aggiornaDataScadenza(id) {
    var frequenza = parseInt($('#frequenza_' + id).val());
    var data_attivita_str = $('#data_attivita_' + id).val(); // es: "20/11/1991"

    if (!data_attivita_str || isNaN(frequenza)) {
        console.warn("Data attivita o frequenza non valida per id:", id);
        return;
    }

    // Converte "DD/MM/YYYY" in oggetto Date
    var [giorno, mese, anno] = data_attivita_str.split('/').map(Number);
    var data_attivita = new Date(anno, mese - 1, giorno); // mese parte da 0

    // Calcola la nuova data aggiungendo i mesi
    var nuovaData = new Date(data_attivita);
    nuovaData.setMonth(nuovaData.getMonth() + frequenza);

    // Corregge l'eventuale overflow di giorni (es. 31 gennaio + 1 mese â†’ 3 marzo)
    if (nuovaData.getDate() !== giorno) {
        nuovaData.setDate(0); // imposta all'ultimo giorno del mese precedente
    }

    // Formatta in "DD/MM/YYYY"
    var giornoN = String(nuovaData.getDate()).padStart(2, '0');
    var meseN = String(nuovaData.getMonth() + 1).padStart(2, '0');
    var annoN = nuovaData.getFullYear();

    var dataFormattata = giornoN+"/"+meseN+"/"+annoN;

    // Aggiorna il campo data_scadenza
    $('#data_scadenza_' + id).val(dataFormattata);
}
</script>