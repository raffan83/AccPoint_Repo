<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:choose>
<c:when test="${item_pacco_fornitore.size()>0 && item_pacco_fornitore.get(0).getItem()!=null && item_pacco_fornitore.get(0).getItem().getTipo_item().getId()==4 }">
<c:set var="rilievi_dimensionali" value="1" ></c:set>
<table id="tabUscita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID Rilievo</th>
 <th>Disegno</th>
 <th>Variante</th>
 <th>Pezzi in Ingresso</th>
 <th>Note</th>
 <td><label>Seleziona</label> <input type="checkbox" id="check_all"></td> 

 </tr></thead>
 
 <tbody>
 <c:forEach items="${item_pacco_fornitore }" var="item_pacco" varStatus="loop">
<%--  <c:if test="${item_pacco.item.tipo_item.id==1}">  --%>
 <tr>
<td>${item_pacco.item.id_tipo_proprio }</td>
<td>${item_pacco.item.disegno }</td>
<td>${item_pacco.item.variante }</td>
<c:if test="${item_pacco.gia_spediti!=null && item_pacco.gia_spediti!=0 }">
<td>${item_pacco.item.pezzi_ingresso } (Spediti ${item_pacco.gia_spediti })</td>
</c:if>
<c:if test="${item_pacco.gia_spediti==null || item_pacco.gia_spediti==0 }">
<td>${item_pacco.item.pezzi_ingresso }</td>
</c:if>
<td>${item_pacco.note}</td>

<td><input class="check_strumenti" type="checkbox" id="checkbox_${item_pacco.item.id_tipo_proprio }"></td> 
</tr>
<%--  </c:if>  --%>
</c:forEach>
</tbody>
 </table>

</c:when>
<c:otherwise>
<div class="row row-search-flex" style="margin-top: 10px;">
	<!--  <div class="row" style="margin-top: 10px;">-->
	<div class="col-md-6">
		<label>Cerca strumento</label>
		<div class="input-group">
			<input type="text" id="searchStrumento" class="form-control"
				placeholder="ID strumento o QR"> <span
				class="input-group-btn">
				<button class="btn btn-primary" id="btnSearchStrumento">
					<i class="fa fa-search"></i>
				</button>
			</span>
		</div>
	</div>
	<div class="col-md-6">
		<div id="semaforoBox" class="semaforo-box">
			<div id="semaforoLed" class="semaforo-led semaforo-off">
				<span id="semaforoTxt" class="semaforo-txt"></span>
			</div>
		</div>
	</div>
	<!--  <div class="col-md-6">
		<span id="msgSearchStrumento" class="text-danger"
			style="display: none; margin-top: 28px; display: inline-block;">

		</span>
	</div>-->
</div>

<br>
<br>
<table id="tabUscita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
<c:set var="rilievi_dimensionali" value="0" ></c:set>
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Denominazione</th>
 <th>Matricola</th>
 <th>Stato</th>
 <th>Quantità</th>
  <th>Tipo</th>
 
 <th>Destinazione</th>
 <th>Priorità</th>
 <th>Note</th>
 <th>Attività</th>
 <td><label>Seleziona</label> <input type="checkbox" id="check_all"></td> 

 </tr></thead>
 
 <tbody>
 <c:forEach items="${item_pacco_fornitore }" var="item_pacco" varStatus="loop">
<%--  <c:if test="${item_pacco.item.tipo_item.id==1}">  --%>
 <tr>
<td>${item_pacco.item.id_tipo_proprio }</td>
<td>${item_pacco.item.descrizione }</td>
<td>${item_pacco.item.matricola }</td>
<td>${item_pacco.item.stato.descrizione }</td>
<td>${item_pacco.quantita }</td>
<td>${item_pacco.item.tipo_item.descrizione }</td>


<td>${item_pacco.item.destinazione }</td>
<c:choose>
<c:when test="${item_pacco.item.priorita==1}">
<td>Urgente</td>
</c:when>
<c:otherwise>
<td></td>
</c:otherwise>
</c:choose> 
<td>${item_pacco.note}</td>
<td>${item_pacco.item.attivita_item.descrizione }</td>
<td><input class="check_strumenti" type="checkbox" id="checkbox_${item_pacco.item.id_tipo_proprio }"></td> 
</tr>
<%--  </c:if>  --%>
</c:forEach>
</tbody>
 </table>


</c:otherwise>



</c:choose>


<input type="hidden" id="totale">

 <style>
.row-selezionata {
	background-color: #fff3cd !important;
}

.semaforo-box {
	height: 10px;
	display: flex;
	align-items: flex-end;
	justify-content: center;
	margin-top:80px;
	background: #fff;
}

.semaforo-led{
  width: 150px;
  height: 150px;
  border-radius: 50%;
  border: 3px solid rgba(0,0,0,.12);
  box-shadow: inset 0 0 10px rgba(0,0,0,.15);

  display: flex;                 
  align-items: center;          
  justify-content: center;      
  text-align: center;
}

.semaforo-txt{
  font-weight: 700;
  font-size: 12px;
  line-height: 1.2;
  color: #fff;                   
  padding: 0 6px;
  text-shadow: 0 1px 2px rgba(0,0,0,.4);
}

/* stati */
.semaforo-off {
	background: #e9ecef;
}

.semaforo-red {
	background: #dd4b39;
}

.semaforo-green {
	background: #00a65a;
}

.semaforo-amber {
	background: #f39c12;
}

.row-search-flex {
	display: flex;
	align-items: flex-end;
	flex-wrap: wrap;
}

.row-search-flex>[class*="col-"] {
	float: none !important;
}
</style>

 
 
 
 <script type="text/javascript">

   var columsDatatables = [];
 
	$("#tabUscita").on( 'init.dt', function ( e, settings ) {
	
	   var t = $('#tabUscita').DataTable();
	   var state = t.state.loaded();
	   	
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    		columsDatatables = state.columns;
	    }
	    $('#tabUscita thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabUscita thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    

	} );   
 
/* 	var columsDatatables3 = [];
	 
	$("#tabUscita").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables3 = state.columns;
	    }
	    $('#tabUscita thead th').each( function () {
	     	if(columsDatatables3.length==0 || columsDatatables3[$(this).index()]==null ){columsDatatables3.push({search:{search:""}});}
	    	  var title = $('#tabUscita thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	 // $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+' style="width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );
	    

	} ); */
	function valutaInput(valore) {

	    if (!valore) return "0";

	    valore = valore.trim();

	   
	    if (/^\d+$/.test(valore)) {
	        return valore;
	    }

	    
	    try {
	        var match = valore.match(/id_str=([^&]+)/);
	        if (match && match[1]) {

	            var base64 = match[1];

	            
	            var decoded = atob(base64);

	           
	            if (/^\d+$/.test(decoded)) {
	                return decoded;
	            }
	        }
	    } catch (e) {
	        
	        console.warn('Errore decodifica base64:', e);
	    }

	   
	    return "0";
	}

	
	$(document).off('click', '#btnSearchStrumento').on('click', '#btnSearchStrumento', function () {
		 var inputRaw = $('#searchStrumento').val().trim();
		 var idCercato = valutaInput(inputRaw);
	   	 var $msg = $('#msgSearchStrumento');
	   	
	   	 console.log("sono dentro");
	   	 console.log("inputRaw " + inputRaw);
	   	console.log("idCercato " + idCercato);
	   	 
	   	 setSemaforo('off', '');
	   	 
	   	 var t = $('#tabUscita').DataTable();
	   	 var trovato = false;
	   	 
	   	 
	     t.rows().every(function () {

	         var data = this.data();

	         var id          = data[0];
	         var denominazione   = data[1];
	         var matricola   = data[2];
	         var stato = data[3];
	         var quantita =data[4];
	         var note = data[5];
	        console.log("id: "+id);

	         if (id == idCercato) {
	        	 console.log("id_item " + id);
	             trovato = true;

	             // vai alla pagina corretta
	             t.page(this.index()).draw(false);

	             // evidenzia riga (opzionale)
	             $(this.node()).addClass('row-selezionata');
	             
	             // CHECK checkbox della riga trovata
	             $(this.node()).find('input.check_strumenti').prop('checked', true);

	             // chiamata come se avessi cliccato "+"
	            // insertItem(id, descrizione, codiceInt, matricola);
	            
	             setTimeout(function () {
	                     // ok -> verde
	                     setSemaforo('green', 'Trovato : ' + id + ' - ' + denominazione);
	                     // se vuoi ancora id+descrizione nel testo del cerchio:
	                     // setSemaforo('green', id);
	                     console.log("led: " + $('#semaforoLed').length);
	                     console.log("txt: " + $('#semaforoTxt').length);

	                 setTimeout(focusRicercaQR, 0);

	             }, 50); // 50ms: basta quasi sempre (aumenta a 150 se serve)
	             
	            // setSemaforo('green', 'Trovato e aggiunto: ' + id + ' - ' + descrizione);
	           
	             setTimeout(focusRicercaQR, 0);

	             return false; 
	    
	     }
	});
	     if (!trovato) {
	    
	     	$('#listaItemTop').text('');
	     	setSemaforo('red', 'Strumento non trovato');
	      //   $msg.text('Strumento non trovato').show();
	         setTimeout(focusRicercaQR, 0);
	     }
	 });
	
	function focusRicercaQR() {
	    var $in = $('#searchStrumento');
	    $in.focus();
	    $in.select(); // seleziona tutto: il prossimo scan sovrascrive
	}

	$('#searchStrumento').on('input', function () {
	    $('#msgSearchStrumento').hide().text('');
	});

	$(document).on('keyup', '#searchStrumento', function (e) {
	    if (e.key === 'Enter') {
	        $('#btnSearchStrumento').click();
	    }
	});

	function setSemaforo(stato, testo) {
		 console.log("setSemaforo chiamato: " + stato + " - " + testo);
	    var $led = $('#semaforoLed');
	    var $txt = $('#semaforoTxt');
	    console.log("led classi prima: " + $led.attr('class'));

	    $led.removeClass('semaforo-off semaforo-red semaforo-green semaforo-amber');

	    if (stato === 'green') $led.addClass('semaforo-green');
	    else if (stato === 'red') $led.addClass('semaforo-red');
	    else if (stato === 'amber') $led.addClass('semaforo-amber');
	    else $led.addClass('semaforo-off');
	    
	    console.log("led classi dopo: " + $led.attr('class'));

	    $txt.text(testo || '');
	}
	



	 function insertItem(id, descrizione, codice_interno, matricola){
		 
		 var note = $('#note_item'+id).val();

		 var priorita = 0;
		 if($('#priorita_item'+id).is( ':checked' ) ){			
		 priorita = 1;
		 }
		 
		 var attivita = $('#attivita_item'+id).val();
		 var destinazione = $('#destinazione_item'+id).val();
		 var attivita_json = JSON.parse('${attivita_json}');
		 insertEntryItem(id,descrizione, 'Strumento', 1, note, priorita, attivita, destinazione, codice_interno, matricola, attivita_json);
	 }


 		$('#check_all').change(function(){
			   var tabella = $('#tabUscita').DataTable();			  
				if(this.checked){					
					 var rows = tabella.rows({ 'search': 'applied' }).nodes();				    
				      $('input[type="checkbox"]', rows).prop('checked', true);
				 }else{					
					 var rows = tabella.rows({ 'search': 'applied' }).nodes();				    
				      $('input[type="checkbox"]', rows).prop('checked', false);
				 }
		}); 
	
	
 $(document).ready(function() {
	 $('#label_spediti').hide();
	 
	 console.log("itemUscita")

 
	 var ril = "${rilievi_dimensionali}";
	 if(ril=="1"){
		 isRilievi = "1";
		 coldef = [	 { responsivePriority: 1, targets: 0 },			 
			  {orderable: false, targets: 5}]
		
	 }else{
		 isRilievi = "0";
		 coldef = [	 { responsivePriority: 1, targets: 0 },
			  { responsivePriority: 2, targets: 8 },	    	  
			   { responsivePriority: 3, targets: 10 },
			  {orderable: false, targets: 10}];
	 }
	 



 
 table = $('#tabUscita').DataTable({
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
        pageLength: 100,
        "order": [[ 0, "desc" ]],
	      paging: true, 
	      ordering: false,
	      info: true, 
	      searchable: true, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: false,
	      columnDefs: coldef, 
	    });
	 coloraRigheUscita(table);
	 

 });
 
 
 $('.inputsearchtable').on('click', function(e){
      e.stopPropagation();    
   });
	 function coloraRigheUscita(tabella){
		var x = '${item_spediti_json}';
	  	 
		var item_spediti = JSON.parse(x)
		   var data = tabella
		     .rows()
		     .data();
	   		
	 		for(var i=0;i<data.length;i++){	
	 	 	    var node = $(tabella.row(i).node());  	    
	 	 	 
	 	 	    for(var j = 0;j<item_spediti.length;j++){
	 	 	    	if(data[i][0] == item_spediti[j].id_tipo_proprio){
	 	 	    		node.css('backgroundColor',"#FFE118");
	 	 	    		$('#label_spediti').css("color","#FFBF18");
	 	 	    		$('#label_spediti').show();
	 	 	    	}
	 	 	    }

	 	 	 }	
		}    
	 		

</script>