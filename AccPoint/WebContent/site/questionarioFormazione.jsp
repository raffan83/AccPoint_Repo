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

<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
          <h1 class="pull-left">
        Questionario Corso
        <small></small>
      </h1>
    <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            


	
 <div class="row">
<div class="col-md-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dettaglio Corso
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${corso.id}</a>
                </li>
                <li class="list-group-item">
                  <b>Commessa</b> <a class="pull-right">${corso.commessa}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Corso</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${corso.data_corso}" /></a>
                </li>
                
  				 <li class="list-group-item">
                <div class="row">
                     <div class="col-xs-12"> 
                <b>Descrizione</b>
                  
                 <a class="pull-right">${corso.descrizione}</a>
                 </div>
                 </div>
                </li>
  				  <li class="list-group-item">
                  <b>Numero Partecipanti</b> <a class="pull-right">${numero_partecipanti}</a>
                </li>
                
               
        </ul>

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
<div class="col-md-12">
<div class="box box-danger box-solid">
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
</section>
</div>



  
 
  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  
</div>
  <t:control-sidebar />
   


<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

<link type="text/css" href="css/bootstrap.min.css" />
</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>

  <script src="plugins/datatables-rowsgroup/dataTables.rowsGroup.js"></script>
  
 <script type="text/javascript">
 

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
			 
			 table.cell(i,5).data(perc +"%").draw();
			 
			 
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
			 
			 table.cell(i,6).data(perc +"%").draw();
			 
			 calcolaGrafici(table);
		 }
		 
		 
		  if(data[i][4]!='' && isNaN(parseInt(data[i][4]))){
			  
			  risposte = risposte+""+";"	 
		 	  table.cell(i,4).data("").draw();
		 	 
		 }else{
			 
			 risposte = risposte+data[i][4]+";"	 			 
		 } 
		 
	 }
	 
	 var id_questionario = $('#id_questionario').val();
	 
	 var dataObj = {};
	  dataObj.risposte = risposte;		
	  dataObj.id_questionario = id_questionario;
	  
	  $.ajax({
	    	  type: "POST",
	    	  url: "gestioneFormazione.do?action=compila_questionario",
	    	  data: dataObj,
	    	  dataType: "json",
	    	  success: function( data, textStatus) {
	    		  
	    		  pleaseWaitDiv.modal('hide');
	    		  $(".ui-tooltip").remove();
	    		  if(data.success)
	    		  { 
	    			 

	    		
	    		  }else{
	    			  $('#myModalErrorContent').html("Errore nel salvataggio!");
	    			  
	    			  	$('#myModalError').removeClass();
	    				$('#myModalError').addClass("modal modal-danger");
	    				$('#report_button').show();
	    	  			$('#visualizza_report').show();
	    				$('#myModalError').modal('show');
	    			 
	    		  }
	    	  },
	
	    	  error: function(jqXHR, textStatus, errorThrown){
	    		  pleaseWaitDiv.modal('hide');
	
	    		  $('#myModalErrorContent').html(textStatus);
	    		  $('#myModalErrorContent').html(data.messaggio);
	    		  	$('#myModalError').removeClass();
	    			$('#myModalError').addClass("modal modal-danger");
	    			$('#report_button').show();
	  			$('#visualizza_report').show();
					$('#myModalError').modal('show');
						
	    	  }
 });
	  

 }
 

 var numero_partecipanti = ${numero_partecipanti}
 
 
    $(document).ready(function() {
    	
    	$('.dropdown-toggle').dropdown();
    	
    	var t_data = $('#tabQuestionarioData').DataTable({
		 ordering:false,
		 paging:   false,
	        ordering: false,
	        info:     false,
	        searching: false,
	 });
    	
    	
    	var data = t_data.rows().data();
    	
    	
    	const editableCell = function(cell) {
    		  let original

    		  cell.setAttribute('contenteditable', true)
    		  cell.setAttribute('spellcheck', false)
    		  var index = cell._DT_CellIndex;
			  cell.setAttribute('id',""+index.row+""+index.column)	
			   $(cell).css('text-align', 'center');
			  
			  
    		  cell.addEventListener('focus', function(e) {
    		    original = e.target.textContent
    	
    		     $(cell).css('border', '2px solid red');
    		    
    		  })
			
    		   cell.addEventListener('focusout', function(e) {
    		    original = stripHtml(e.target.textContent)
    		
    		    $(cell).css('border', '1px solid #d1d1d1');
    		   $(cell).css('border-bottom-width', '0px');
    		    $(cell).css('border-left-width', '0px');
    		     
    		     
    		    //$(e.currentTarget).html('<input type="text" value="'+original+'" onChange="salvaModificaQuestionario()">');
    		  })
    		  
    		  cell.addEventListener('blur', function(e) {
    		    if (original !== e.target.textContent) {
    		      const row = table.row(e.target.parentElement)
    		      table.cell(row.index(),e.target.cellIndex).data(e.target.textContent).draw();
    		      var x = table.rows().data();
    		      	salvaModificaQuestionario();
    		      console.log('Row changed: ', row.data())
    		    }
    		  })
    		};
    	
    	
    	
    	
    	
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
    			 
    			 $(cell).val(perc+"%");
    			 
    		 }
   		
   		};    

    	const PercCell2 = function(cell) {
    		
   		 $(cell).css('text-align', 'center');
   		 
   		var row = cell._DT_CellIndex.row;
		 
		 var val = t_data.cell(row, 3).data();
		 
		 if(val!=''&&!isNaN(parseInt(val))){
			 
			 var perc = (parseInt(val)/numero_partecipanti)*100;
			 
			 $(cell).val(perc+"%");
			 
		 }
  		
  		};
    	
    	var table = $('#tabQuestionario').DataTable({
    		columns: [
    			  {
    		            name: 'first',
    		            title: 'MACROAREA',
    		            createdCell: macroAreaCell
    		        },
    		        {
    		            name: 'second',
    		            title: 'DOMANDA',
    		        },
    		        {
    		            title: 'NON SODDISFACENTE <br> POCO SODDISFACENTE <br> <br>(PUNTEGGIO 1-2)',
    		            createdCell: editableCell
    		        }, 
    		        {
    		            title: 'SODDISFACENTE<br> MOLTO SODDISFACENTE <br><br>(PUNTEGGIO 3-4)',
    		            createdCell: editableCell
    		        },
    		        {
    		            title: 'SENZA RISPOSTA',
    		            createdCell: editableCell
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
    		$('#media_sod').val(media_s+"%");
    	}
    	if((risposte_date_ns!=0)){
    		media_ns = somma_ns/risposte_date_ns;
    		$('#media_non_sod').val(media_ns+"%");
    	}
    	
    	
    	
    }
    
    
    function calcolaGrafici(table){
    	var data1 = [table.cell(0,5).data().split("%")[0],table.cell(1,5).data().split("%")[0]]
    	var data2 = [table.cell(0,6).data().split("%")[0],table.cell(1,6).data().split("%")[0]]
    	var label1 = table.cell(0,1).data();
    	var label2 = table.cell(1,1).data()
    	
    	
    	var data3 = [table.cell(2,5).data().split("%")[0],table.cell(3,5).data().split("%")[0]]
    	var data4 = [table.cell(2,6).data().split("%")[0],table.cell(3,6).data().split("%")[0]]
    	var data5 = [table.cell(4,5).data().split("%")[0],table.cell(5,5).data().split("%")[0]]
    	var data6 = [table.cell(4,6).data().split("%")[0],table.cell(5,6).data().split("%")[0]]
    	var label3 = table.cell(2,1).data();
    	var label4 = table.cell(3,1).data()
    	var label5 = table.cell(4,1).data();
    	var label6 = table.cell(5,1).data()
    	
    	
    	var data7 = [table.cell(6,5).data().split("%")[0],table.cell(7,5).data().split("%")[0]]
    	var data8 = [table.cell(6,6).data().split("%")[0],table.cell(7,6).data().split("%")[0]]
    	var label7 = table.cell(6,1).data();
    	var label8 = table.cell(7,1).data()
    	
    	
    	var data9 = [table.cell(8,5).data().split("%")[0],table.cell(9,5).data().split("%")[0]]
    	var data10 = [table.cell(8,6).data().split("%")[0],table.cell(9,6).data().split("%")[0]]
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
  
</jsp:attribute> 
</t:layout>

