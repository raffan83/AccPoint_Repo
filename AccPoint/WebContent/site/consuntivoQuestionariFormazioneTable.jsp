<%@page import="com.google.gson.JsonArray"%>
<%@page import="it.portaleSTI.Util.Costanti"%>
<%@page import="it.portaleSTI.DTO.PuntoMisuraDTO"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>







<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
<div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	 Dettaglio corsi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

      <div class="row">
    <div class="col-xs-12"> 
    
  <table id="tabCorsi" class="table table-bordered datatable table-hover  table-striped" role="grid" width="100%">
 <thead><tr class="active">



<th>ID Corso</th>
<th>Categoria </th>
<th>Descrizione </th>
<th>Commessa</th>
<th>Data Inizio</th>
<th>Numero partecipanti</th>
<th>Questionario compilato</th>
 </tr></thead>
 
 <tbody>
 <c:forEach items="${lista_corsi }" var="corso" varStatus="loop">
 <tr>
 <td>${corso.id }</td>
 <td>${corso.corso_cat.descrizione }</td>
 <td>${corso.descrizione }</td>
 <td>${corso.commessa }</td>
 <td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${corso.data_corso}" /></td>	
 <td>${lista_n_partecipanti.get(loop.index) }</td>
 <td>
 <c:if test="${lista_questionari_compilati.get(loop.index) == 1}">
 SI
 </c:if>
  <c:if test="${lista_questionari_compilati.get(loop.index) == 0}">
 NO
 </c:if>
</td>
 
 </c:forEach>
 
 
	</tbody>
	</table>
	</div>
	</div>
	
	       <div class="row"> 
   <div class="col-xs-10"></div>
    <div class="col-xs-2">
    <label> TOT. PARTECIPANTI CORSI CON QUESTIONARIO</label>
    <input type="text" readonly class="form-control" id="numero_partecipanti_questionari">
    </div>

   </div>
    
    <br>

</div>
</div>
</div>
       
 </div>

	

 
    
    <div class="row">
    <div class="col-xs-12"> 
    
  <table id="tabQuestionarioData" style="display:none" class="table table-bordered datatable table-hover  table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th style="max-width:20px">MACROAREA</th>
<th>DOMANDA</th>
<th>NON SODDISFACENTE <BR> POCO SODDISFACENTE <BR> <BR> (PUNTEGGIO 1-2)</th>
<th>SODDISFACENTE <BR> MOLTO SODDISFACENTE <BR> <BR> (PUNTEGGIO 3-4)</th>
<th>SENZA RISPOSTA</th>
<th>NON SODDISFACENTE <BR> POCO SODDISFACENTE <BR> % <BR> (PUNTEGGIO 1-2)</th>
<th>SODDISFACENTE <BR> MOLTO SODDISFACENTE <BR> % <BR> (PUNTEGGIO 3-4)</th>
 </tr></thead>
 
 <tbody>
 
	<tr>


	<td><strong>UTILIT&Agrave;</strong></td>
	<td id="00">a) Congruenza dei contenuti del corso rispetto agli obiettivi enunciati</td>
	<td id="01">${questionario.seq_risposte.split(";")[0].split(",")[0] }</td>
	<td >${questionario.seq_risposte.split(";")[0].split(",")[1] }</td>
	<td id="03">${questionario.seq_risposte.split(";")[0].split(",")[2] }</td>	
	<td id="04"></td>
	<td id="05"></td>
	</tr>
	
	
	<tr>
	<td><strong>UTILIT&Agrave;</strong></td>
	<td id="10">b) Rispondenza dei contenuti formativi rispetto alle aspettative iniziali</td>
	<td id="11">${questionario.seq_risposte.split(";")[1].split(",")[0] }</td>
	<td id="12">${questionario.seq_risposte.split(";")[1].split(",")[1] }</td>
	<td id="13">${questionario.seq_risposte.split(";")[1].split(",")[2] }</td>	
	<td id="14"></td>
	<td id="15"></td>
	</tr>
	 
	 
	<tr>

	<td><strong> DIDATTICA</strong></td>	
	<td id="20">c) Quale è la sua opinione sull'efficacia dei metodi didattici impiegati nel corso</td>
	<td id="21">${questionario.seq_risposte.split(";")[2].split(",")[0] }</td>
	<td id="22">${questionario.seq_risposte.split(";")[2].split(",")[1] }</td>
	<td id="23">${questionario.seq_risposte.split(";")[2].split(",")[2] }</td>	
	<td id="24"></td>
	<td id="25"></td>
	</tr> 
	
	
	<tr>
	<td><strong> DIDATTICA</strong></td>
	<td id="30">d) Come valuta il materiale didattico fornito</td>
	<td id="31">${questionario.seq_risposte.split(";")[3].split(",")[0] }</td>
	<td id="32">${questionario.seq_risposte.split(";")[3].split(",")[1] }</td>
	<td id="33">${questionario.seq_risposte.split(";")[3].split(",")[2] }</td>	
	<td id="34"></td>
	<td id="35"></td>
	</tr>
	
	
	
	<tr>
	<td><strong> DIDATTICA</strong></td>
	<td id="40">e) Valutazione contenuto delle lezioni</td>
	<td id="41">${questionario.seq_risposte.split(";")[4].split(",")[0] }</td>
	<td id="42">${questionario.seq_risposte.split(";")[4].split(",")[1] }</td>
	<td id="43">${questionario.seq_risposte.split(";")[4].split(",")[2] }</td>	
	<td id="44"></td>
	<td id="45"></td>
	</tr>
	
	
	
	<tr>
	<td><strong> DIDATTICA</strong></td>
	<td id="50">f) Valutazione chiarezza di esposizione docenti</td>
	<td id="51">${questionario.seq_risposte.split(";")[5].split(",")[0] }</td>
	<td id="52">${questionario.seq_risposte.split(";")[5].split(",")[1] }</td>
	<td id="53">${questionario.seq_risposte.split(";")[5].split(",")[2] }</td>	
	<td id="54"></td>
	<td id="55"></td>
	</tr>
	
	
	<tr>
	<td><strong>ORGANIZZAZIONE<br>
(solo nel caso di corsi erogati presso la sede CRESCO)</strong></td>	
	<td id="60">g) Funzionalità e confortevolezza dei locali utilizzati</td>
	<td id="61">${questionario.seq_risposte.split(";")[6].split(",")[0] }</td>
	<td id="62">${questionario.seq_risposte.split(";")[6].split(",")[1] }</td>
	<td id="63">${questionario.seq_risposte.split(";")[6].split(",")[2] }</td>	
	<td id="64"></td>
	<td id="65"></td>
	</tr>
	
	
	<tr>
	<td><strong>ORGANIZZAZIONE<br>
(solo nel caso di corsi erogati presso la sede CRESCO)</strong></td>	
	<td id="70">h) Assistenza da parte del personale non docente (segreteria, tecnici, ecc..)</td>
	<td id="71">${questionario.seq_risposte.split(";")[7].split(",")[0] }</td>
	<td id="72">${questionario.seq_risposte.split(";")[7].split(",")[1] }</td>
	<td id="73">${questionario.seq_risposte.split(";")[7].split(",")[2] }</td>	
	<td id="74"></td>
	<td id="75"></td>
	</tr>
	
	
		<tr>
	<td><strong>GIUDIZIO IN SINTESI</strong></td>	
	<td id="80">i) La invitiamo a indicare la qualità complessiva del percorso</td>
	<td id="81">${questionario.seq_risposte.split(";")[8].split(",")[0] }</td>
	<td id="82">${questionario.seq_risposte.split(";")[8].split(",")[1] }</td>
	<td id="83">${questionario.seq_risposte.split(";")[8].split(",")[2] }</td>	
	<td id="84"></td>
	<td id="85"></td>
	</tr>
	
	
	<tr>
	<td><strong>GIUDIZIO IN SINTESI</strong></td>
	<td id="90">l) Aderenza dell'intervento formativo ai bisogni esplicitati e alle necessità lavorative</td>
	<td id="91">${questionario.seq_risposte.split(";")[9].split(",")[0] }</td>
	<td id="92">${questionario.seq_risposte.split(";")[9].split(",")[1] }</td>
	<td id="93">${questionario.seq_risposte.split(";")[9].split(",")[2] }</td>	
	<td id="94"></td>
	<td id="95"></td>
	</tr>
	
		
 </tbody>
 </table>   

    <table id="tabQuestionario" class="table table-bordered datatable table-hover  table-striped" role="grid" width="100%"></table>
    <input type="hidden" id="id_questionario" value="${corso.questionario.id }")>
    
    </div>
    </div>
    
       <div class="row"> 
   <div class="col-xs-8"></div>
    <div class="col-xs-2">
    <label >MEDIA NON SODDISFACENTE - POCO SODDISFACENTE</label>
    <input type="text" readonly class="form-control" id="media_non_sod">
    </div>
     <div class="col-xs-2">
      <label >MEDIA SODDISFACENTE - MOLTO SODDISFACENTE</label>
      <input type="text" readonly class="form-control" id="media_sod"></div>
   </div>
    
    <br>
    
    
           <div class="row"> 
   <div class="col-xs-8"></div>
    <div class="col-xs-4">
    <c:if test= "${userObj.checkRuolo('F2') == false}">
   <%--  <a class="btn btn-primary pull-right" onClick="salvaCompilazioneQuestionario('${corso.questionario.id}')">Termina compilazione questionario</a> --%>
    </c:if>
    </div>

   </div>
    
    <br>
    
    <div class="row">
<div class="col-md-12">
<div class="box box-primary box-solid">
<div class="box-header with-border">
	Grafici
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-xs-6">
<canvas id="macro1" width="100" height="50"></canvas>
</div>

<div class="col-xs-6">        
<canvas id="macro2" width="100" height="50"></canvas>
</div>
</div>

<br><br>
<div class="row">
<div class="col-xs-6">
<canvas id="macro3" width="100" height="50"></canvas>
</div>

<div class="col-xs-6">        
<canvas id="macro4" width="100" height="50"></canvas>
</div>
</div>



</div>
</div>
</div>
       
 </div>
        
        
        

</div>
</div>
</div>
 </div> 





  
 
  
  <!-- /.content-wrapper -->




<!-- ./wrapper -->

<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>


<link type="text/css" href="css/bootstrap.min.css" />


<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>

  <script src="plugins/datatables-rowsgroup/dataTables.rowsGroup.js"></script>
  
 <script type="text/javascript">
 function dettaglioCorso(id_corso){
		
		callAction('gestioneFormazione.do?action=dettaglio_corso&id_corso='+id_corso);
	}


 

 //var numero_partecipanti = ${numero_partecipanti}
 var numero_partecipanti = 0
 
 
 
 var columsDatatables = [];

 $("#tabCorsi").on( 'init.dt', function ( e, settings ) {
     var api = new $.fn.dataTable.Api( settings );
     var state = api.state.loaded();
  
     if(state != null && state.columns!=null){
     		console.log(state.columns);
     
     columsDatatables = state.columns;
     }
     $('#tabCorsi thead th').each( function () {
     	
     
      	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
     	  var title = $('#tabCorsi thead th').eq( $(this).index() ).text();
     	
     	
     	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');  
     	

     	} );
     
     

 } );

 
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
    	
    	
    	 t = $('#tabCorsi').DataTable({
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
 		      ordering: true,
 		      info: true, 
 		      searchable: true, 
 		      targets: 0,
 		      responsive: true,
 		      scrollX: false,
 		      stateSave: true,	
 		           
 		      columnDefs: [
 		    	  

 		    	  
 		               ], 	        
 	  	      buttons: [   
 	  	          {
 	  	            extend: 'colvis',
 	  	            text: 'Nascondi Colonne'  	                   
 	 			  }, {
 	 				 extend: 'excel',
 		  	            text: 'Esporta Excel'  
 	 			  } ]
 		               
 		    });
 		
 		t.buttons().container().appendTo( '#tabCorsi_wrapper .col-sm-6:eq(1)');
 	 	    $('.inputsearchtable').on('click', function(e){
 	 	       e.stopPropagation();    
 	 	    });

 	 	     t.columns().eq( 0 ).each( function ( colIdx ) {
 	  $( 'input', t.column( colIdx ).header() ).on( 'keyup', function () {
 	      t
 	          .column( colIdx )
 	          .search( this.value )
 	          .draw();
 	  } );
 	} );  
 	
 	
 	
 		t.columns.adjust().draw();
 		

 	$('#tabCorsi').on( 'page.dt', function () {
 		$('.customTooltip').tooltipster({
 	        theme: 'tooltipster-light'
 	    });
 		
 		$('.removeDefault').each(function() {
 		   $(this).removeClass('btn-default');
 		})


 	});
    	
 	//$("#tabCorsi tbody tr").each(function () {
 	t.rows({ filter: 'applied' }).every(function () {
 	    let valore = parseFloat(this.data()[5]); // colonna 5
 	    let condizione = this.data()[6].trim(); // colonna 6

        if (condizione === "SI" && !isNaN(valore)) {
            numero_partecipanti += valore;
        }
        
        
        $('#numero_partecipanti_questionari').val(numero_partecipanti);
    });
 	
    	
    	
    	
    	var t_data = $('#tabQuestionarioData').DataTable({
		 ordering:false,
		 paging:   false,
	        ordering: false,
	        info:     false,
	        searching: false,
	 });
    	
    	
    	var data = t_data.rows().data();

    	
    	
    	const macroAreaCell = function(cell) {
    		
    		 $(cell).css('vertical-align', 'middle');
    		 $(cell).css('font-size', '15px');
    		
    	};    	
    	
    	
    	const PercCell1 = function(cell) {
    		
    		 $(cell).css('text-align', 'center');
    		 
    		 var row = cell._DT_CellIndex.row;
    		    		 
    		 var val = t_data.cell(row, 2).data();
    		 
    		 if(val!=''&&!isNaN(parseInt(val))){
    			 
    			 var perc = (parseInt(val)/numero_partecipanti)*100;
    			 
    			 $(cell).val(Math.round((perc + Number.EPSILON) * 100) / 100+"%");
    			 
    		 }
   		
   		};    

    	const PercCell2 = function(cell) {
    		
   		 $(cell).css('text-align', 'center');
   		 
   		var row = cell._DT_CellIndex.row;
		 
		 var val = t_data.cell(row, 3).data();
		 
		 if(val!=''&&!isNaN(parseInt(val))){
			 
			 var perc = (parseInt(val)/numero_partecipanti)*100;
			 
			 $(cell).val(Math.round((perc + Number.EPSILON) * 100) / 100+"%");
			 
		 }
  		
  		};
    	
    	var table = $('#tabQuestionario').DataTable({
    		columns: [
    			  {
    		            name: 'first',
    		            title: 'MACROAREA',
    		           // createdCell: macroAreaCell
    		        },
    		        {
    		            name: 'second',
    		            title: 'DOMANDA',
    		        },
    		        {
    		            title: 'NON SODDISFACENTE <br> POCO SODDISFACENTE <br> <br>(PUNTEGGIO 1-2)',
    		           // createdCell: editableCell
    		        }, 
    		        {
    		            title: 'SODDISFACENTE<br> MOLTO SODDISFACENTE <br><br>(PUNTEGGIO 3-4)',
    		         //   createdCell: editableCell
    		        },
    		        {
    		            title: 'SENZA RISPOSTA',
    		         //   createdCell: editableCell
    		        },
    		        {
    		            title: 'NON SODDISFACENTE <br>POCO SODDISFACENTE<br> % <br>(PUNTEGGIO 1-2)',
    		            createdCell: PercCell1
    		        },
    		        {
    		            title: 'SODDISFACENTE <br>MOLTO SODDISFACENTE<br> %<br> (PUNTEGGIO 3-4)',
    		            createdCell: PercCell2
    		        },
    		        
    		      
    		],
    		data: data,
    		lengthChange: false,
    		searching: false,
    		searchable: false,
    		paging: false,
    		ordering: false,
    		info:false,
    		order: [],
    		//keys: true,
    		rowsGroup: [// Always the array (!) of the column-selectors in specified order to which rows groupping is applied
    					// (column-selector could be any of specified in https://datatables.net/reference/type/column-selector)
    					 'first:name',    					
    		],
    	})
    	table.draw(false);

    	salvaModificaQuestionario();

    	calcolaGrafici(table);
    	
    	
    	
    	
    	

    });
    
    function salvaModificaQuestionario(){
   	 
   	 var table = $('#tabQuestionario').DataTable();
   	 
   	 var data = table.rows().data();
   	 
   	 var risposte ="";
   	 
   	 var flag = true;
   	 
   	 for(var i = 0; i<data.length;i++){	 

   		 
   		  if(data[i][2]!='' && isNaN(parseInt(data[i][2]))){
   			
   			 risposte = risposte+""+","
   			 table.cell(i,2).data("").draw();
   			 table.cell(i,5).data("").draw();
   		 }
   		  else if(data[i][2]==''){
   			  
   			  table.cell(i,5).data("").draw();
   			  risposte = risposte+""+","
   		  }
   		  else{	
   			 
   			 risposte = risposte+data[i][2]+","	 	
   			 
   			 var val = parseInt(data[i][2]);
   			 
   			 var perc = (val/numero_partecipanti)*100;			 
   			 
   			// table.cell(i,5).data(perc +"%").draw();
   			 table.cell(i,5).data( Math.round((perc + Number.EPSILON) * 100) / 100 +"%").draw();
   			
   			 
   			 calcolaGrafici(table);
   			 
   		 }
   		 
   		 if(data[i][3]!='' && isNaN(parseInt(data[i][3]))){
   			
   			 risposte = risposte+""+","
   			 table.cell(i,3).data("").draw();
   			
   		 }
   		 else if(data[i][3]==''){
   			  
   			  table.cell(i,6).data("").draw();
   			  risposte = risposte+""+","
   		  }
   		 else{
   			
   			 risposte = risposte+data[i][3]+","			
   			 
   			var val = parseInt(data[i][3]);
   			 
   			 var perc = (val/numero_partecipanti)*100;			 
   			 
   			 //table.cell(i,6).data(perc +"%").draw();
   			 table.cell(i,6).data(Math.round((perc + Number.EPSILON) * 100) / 100 +"%").draw();
   			 
   			 calcolaGrafici(table);
   		 }
   		 
   		 
   		  if(data[i][4]!='' && isNaN(parseInt(data[i][4]))){
   			  
   			  risposte = risposte+""+";"	 
   		 	  table.cell(i,4).data("").draw();
   		 	 
   		 }else{
   			 
   			 risposte = risposte+data[i][4]+";"	 			 
   		 } 
   		 
   	 }
    }

    
    function calcolaMedia(table){
    	
    	var media_s;
    	var media_ns;
    	
    	var somma_ns = 0.0;
    	var somma_s = 0.0;
    	
    	var risposte_date_s = 0;
    	var risposte_date_ns = 0;
    	
    	var data = table.rows().data();
    	
    	for(var i = 0; i<data.length;i++){
    		
    		if(!isNaN(parseFloat(data[i][5]))){
    			somma_ns = somma_ns + parseFloat(data[i][5]);
    			risposte_date_ns++;
    		}
    		if(!isNaN(parseFloat(data[i][6]))){
    			somma_s = somma_s + parseFloat(data[i][6]);
    			risposte_date_s++;
    		}
    	}
    	if((risposte_date_s!=0)){
    		media_s = somma_s/ risposte_date_s;	
    		$('#media_sod').val(Math.round((media_s + Number.EPSILON) * 100) / 100+"%");
    	}
    	if((risposte_date_ns!=0)){
    		media_ns = somma_ns/risposte_date_ns;
    		$('#media_non_sod').val(Math.round((media_ns + Number.EPSILON) * 100) / 100+"%");
    	}
    	
    	
    	
    }
    
    
    function calcolaGrafici(table){
    	
    	var data1 = [table.cell(0,5).data().split("%")[0],table.cell(0,6).data().split("%")[0]]
    	var data2 = [table.cell(1,5).data().split("%")[0],table.cell(1,6).data().split("%")[0]]
    	var label1 = table.cell(0,1).data();
    	var label2 = table.cell(1,1).data()
    	
    	
    	var data3 = [table.cell(2,5).data().split("%")[0],table.cell(2,6).data().split("%")[0]]
    	var data4 = [table.cell(3,5).data().split("%")[0],table.cell(3,6).data().split("%")[0]]
    	var data5 = [table.cell(4,5).data().split("%")[0],table.cell(4,6).data().split("%")[0]]
    	var data6 = [table.cell(5,5).data().split("%")[0],table.cell(5,6).data().split("%")[0]]
    	var label3 = table.cell(2,1).data();
    	var label4 = table.cell(3,1).data()
    	var label5 = table.cell(4,1).data();
    	var label6 = table.cell(5,1).data()
    	
    	
    	var data7 = [table.cell(5,5).data().split("%")[0],table.cell(6,6).data().split("%")[0]]
    	var data8 = [table.cell(6,5).data().split("%")[0],table.cell(7,6).data().split("%")[0]]
    	var label7 = table.cell(6,1).data();
    	var label8 = table.cell(7,1).data()
    	
    	
    	var data9 = [table.cell(7,5).data().split("%")[0],table.cell(8,6).data().split("%")[0]]
    	var data10 = [table.cell(8,5).data().split("%")[0],table.cell(9,6).data().split("%")[0]]
    	var label9 = table.cell(8,1).data();
    	var label10 = table.cell(9,1).data()
    	
    	
    	var d =[];
    	
     	d.push(data1);
    	d.push(data2);
    	d.push(data3);
    	d.push(data4);
    	d.push(data5);
    	d.push(data6);
    	d.push(data7);
    	d.push(data8);
    	d.push(data9);
    	d.push(data10);
    	
    	
    	calcolaMedia(table);
    	
    	var l = [];
    	
    	
    	l.push(label1);
    	l.push(label2);
    	l.push(label3);
    	l.push(label4);
    	l.push(label5);
    	l.push(label6);
    	l.push(label7);
    	l.push(label8);
    	l.push(label9);
    	l.push(label10);
    	
    	
    	
    	for(var i = 0; i<4;i++){
    		
    	
    	var ctx = document.getElementById('macro'+(i+1)).getContext('2d');
    	
    	if(i!=1){
    		if(i==0){
    			var j = i;
    		}else if(i==2){
    			var j = 6;
    		}else{
    			var j = 8;
    		}
    		var myChart = new Chart(ctx, {
        	    type: 'horizontalBar',
        	    data: {
        	    	  labels: [['NON SODDISFACENTE', 'POCO SODDISFACENTE'], ['SODDISFACENTE','MOLTO SODDISFACENTE' ]],
        	        datasets: [{
        	            label: l[j],
        	            data: d[j],
        	            backgroundColor: [
        	                
        	                 'rgba(54, 162, 235, 0.2)',
        	                 'rgba(54, 162, 235, 0.2)',
        	                  
        	            ],
        	            borderColor: [
        	            	'rgba(54, 162, 235, 1)',
        	            	'rgba(54, 162, 235, 1)',
        	            ],
        	            borderWidth: 1
        	        },
        	        {
        	            label: l[j+1],
        	            data: d[j+1],
        	             backgroundColor: [

        	                
        	                    'rgba(255, 99, 132, 0.2)',
        	                    'rgba(255, 99, 132, 0.2)',
        	           
        	            ], 
        	            borderColor: [
        	            	'rgba(255, 99, 132, 1)',
    	                    'rgba(255, 99, 132, 1)',
        	            ],
        	            borderWidth: 1
        	        }]
        	    },
        	    options: {
        	        scales: {
        	            xAxes: [{
        	                ticks: {
        	                	min: 0,
        	                    max: 100,
        	                    callback: function(value) {
        	                        return value + " %"
        	                    },
        	                    beginAtZero: true
        	                }
        	            }]
        	        }
        	    }
        	});
    	}else{
    		var myChart = new Chart(ctx, {
        	    type: 'horizontalBar',
        	    data: {
        	    	  labels: [['NON SODDISFACENTE', 'POCO SODDISFACENTE'], ['SODDISFACENTE','MOLTO SODDISFACENTE' ]],
        	        datasets: [{
        	            label: l[i+1],
        	            data: d[i+1],
        	            backgroundColor: [
        	                
        	                 'rgba(54, 162, 235, 0.2)',
        	                 'rgba(54, 162, 235, 0.2)',
        	                 'rgba(54, 162, 235, 0.2)',
        	                 'rgba(54, 162, 235, 0.2)',
        	                  
        	            ],
        	            borderColor: [
        	            	'rgba(54, 162, 235, 1)',
        	            	'rgba(54, 162, 235, 1)',  
        	            	'rgba(54, 162, 235, 1)',
        	            	'rgba(54, 162, 235, 1)',  
        	 
        	            ],
        	            borderWidth: 1
        	        },
        	        {
        	            label: l[i+2],
        	            data: d[i+2],
        	             backgroundColor: [

        	                
        	            	 'rgba(255, 206, 86, 0.2)',
        	            	 'rgba(255, 206, 86, 0.2)',
        	            	 'rgba(255, 206, 86, 0.2)',
        	            	 'rgba(255, 206, 86, 0.2)',
        	           
        	            ], 
        	            borderColor: [
        	            	'rgba(255, 206, 86, 1)',
        	            	'rgba(255, 206, 86, 1)',
        	            	'rgba(255, 206, 86, 1)',
        	            	'rgba(255, 206, 86, 1)',
       			         
        	            ],
        	            borderWidth: 1
        	        },
        	        {
        	            label: l[i+3],
        	            data: d[i+3],
        	             backgroundColor: [

        	                
        	            	 'rgba(153, 102, 255, 0.2)',
        	            	 'rgba(153, 102, 255, 0.2)',
        	            	 'rgba(153, 102, 255, 0.2)',
        	            	 'rgba(153, 102, 255, 0.2)',
        			     
        	           
        	            ], 
        	            borderColor: [
        	            	 'rgba(153, 102, 255, 1)',
        	            	 'rgba(153, 102, 255, 1)',
        	            	 'rgba(153, 102, 255, 1)',
        	            	 'rgba(153, 102, 255, 1)',
        			        
        	            ],
        	            borderWidth: 1
        	        },
        	        {
        	            label: l[i+4],
        	            data: d[i+4],
        	             backgroundColor: [

        	            	 'rgba(255, 99, 132, 0.2)',
     	                    'rgba(255, 99, 132, 0.2)',
        	                    'rgba(255, 99, 132, 0.2)',
        	                    'rgba(255, 99, 132, 0.2)',
        	           
        	            ], 
        	            borderColor: [
        	            	'rgba(255, 99, 132, 1)',
    	                    'rgba(255, 99, 132, 1)',
    	                    'rgba(255, 99, 132, 1)',
    	                    'rgba(255, 99, 132, 1)',
        	            ],
        	            borderWidth: 1
        	        }]
        	    },
        	    options: {
        	        scales: {
        	            xAxes: [{
        	                ticks: {
        	                	min: 0,
        	                    max: 100,
        	                    callback: function(value) {
        	                        return value + " %"
        	                    },
        	                    beginAtZero: true
        	                }
        	            }]
        	        }
        	    }
        	});
    	}
    	
    	
    	
    	
    	
    	}
    	
    }
  </script>
  


