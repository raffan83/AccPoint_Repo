<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
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
        Lista Item Magazzino
        <small></small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
       <a class="btn btn-default pull-right" href="#" id="tornaItem" onClick="tornaItem()" style="margin-right:5px;display:none"><i class="fa fa-dashboard"></i> Torna agli Item</a>
    </section><br>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
     <div class="row">
     

 				<div class="col-sm-6 col-xs-12 grafico1" id="box_chart_lavorazione" style="max-height:30%;min-height:20%">
					
					
					<div class="box box-primary" >
			            <div class="box-header with-border">
			              <h3 class="box-title"></h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                 <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> 
			              </div>
			            </div>
			            <div class="box-body">
			             <div class="chart" style="margin-top:59px;margin-bottom:59px">
			              <!-- <div class="chart"> -->
			                <canvas id="chart_lavorazione"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>
				
				
				 <div class="col-sm-6 col-xs-12 grafico2" id="box_chart_storico" >	
					<div class="box box-primary" >
			            <div class="box-header with-border">
			              <h3 class="box-title"></h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                 <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> 
			              </div>
			            </div>
			            <div class="box-body">
			            <div class="row">
			            <div class="col-sm-4">
			            <label>ID Item</label>
			            <input type="text" class="form-control" id="id_item_text">			            
			            </div>
			            <div class="col-sm-4">
			            <label>Matricola</label>
			            <input type="text" class="form-control" id="matricola_item_text">			            
			            </div>
			            <div class="col-sm-4">
			            <button class="btn btn-primary" onClick="cercaPacchiOrigine($('#id_item_text').val(), $('#matricola_item_text').val())" style="margin-top:25px">Cerca</button>
			            </div>
			            </div>
			            
			            
			            <div class="row">
			            <div class="col-sm-8">
			            <label>Pacco Origine</label>
			            <select class="form-control select2" id="pacco_origine" data-placeholder="Seleziona Pacco Origine..." disabled>
			            <option value=""></option>
			            </select>			            
			            </div>
			            <div class="col-sm-4">
			           
			            </div>
			            </div>
			            
			              <!-- <div class="chart2"> -->
			              <div id="grafico_storico" class="chart2" style="margin-top:158px">
			                 <canvas id="chart_storico"></canvas>
			              </div>
			            </div>
			           
			          </div>
				</div>
				

     </div>
     

     
     
<div class=row>
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Item
	<div class="box-tools pull-right">		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>
	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-sm-12">
</div>
</div>
     <div class="row">
     <div class = col-sm-6>
     	<button class="btn btn-primary customTooltip" onClick="itemEsterno()" title="Click per visualizzare gli Item fuori dal magazzino" >Item all'esterno</button>
     
     </div>
     </div><br>
<div class="row">
<div class="col-sm-12">
  <table id="tab_lista_item" class="table table-bordered table-hover dataTable table-striped" role="grid">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Origine</th>
 <th>Denominazione</th>
 <th>Codice Interno</th>
 <th>Matricola</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Commessa</th>
 <th>Pacco</th>
 <th>Stato Pacco</th>
 <th>Stato Item</th>
 <th>Data Arrivo/Rientro</th>
 <th>Data Spedizione</th>
 <th>N. Colli</th>
 <th>Attività</th>
 <th>Destinazione</th>
 <th>Fornitore</th>
 <th>Priorità</th>
 <th>Note</th>
 <th>DDT</th>
 <th>Porto</th>
 <th>Company</th>
 <th>Responsabile</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_item_pacco}" var="item_pacco" varStatus="loop">
<tr>
<c:choose>
<c:when test="${item_pacco.item.tipo_item.id ==1}">
  <td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dello strumento" onclick="dettaglioStrumento('${item_pacco.item.id_tipo_proprio}')">${item_pacco.item.id_tipo_proprio}</a></td></c:when>
  <c:otherwise>
  <td>${item_pacco.item.id_tipo_proprio }</td></c:otherwise> </c:choose>
  <td>
<c:if test="${item_pacco.pacco.origine!='' && item_pacco.pacco.origine!=null}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(item_pacco.pacco.origine.split('_')[1])}')">${item_pacco.pacco.origine}</a>
</c:if>
</td>
  <td>${item_pacco.item.descrizione}</td>
  <td>${item_pacco.item.codice_interno }</td>
  <td>${item_pacco.item.matricola }</td>
<td>${item_pacco.pacco.nome_cliente}</td>
<td>${item_pacco.pacco.nome_sede }</td>
<td>
<c:if test="${item_pacco.pacco.commessa!=null && item_pacco.pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${item_pacco.pacco.commessa}');">${item_pacco.pacco.commessa}</a>
</c:if>
</td>
<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${utl:encryptData(item_pacco.pacco.id)}')">
${item_pacco.pacco.id}
</a>
</td>
<td>
<c:if test="${item_pacco.pacco.stato_lavorazione.id == 1}">
 <span class="label label-info">${item_pacco.pacco.stato_lavorazione.descrizione} </span></c:if>
 <c:if test="${item_pacco.pacco.stato_lavorazione.id == 2}">
 <span class="label label-success" >${item_pacco.pacco.stato_lavorazione.descrizione}</span></c:if>
  <c:if test="${item_pacco.pacco.stato_lavorazione.id == 3}">
 <span class="label label-danger" >${item_pacco.pacco.stato_lavorazione.descrizione}</span></c:if>
   <c:if test="${item_pacco.pacco.stato_lavorazione.id == 4}">
 <span class="label label-warning" >${item_pacco.pacco.stato_lavorazione.descrizione}</span></c:if>
   <c:if test="${item_pacco.pacco.stato_lavorazione.id == 5}">
 <span class="label label-primary" >${item_pacco.pacco.stato_lavorazione.descrizione}</span></c:if>
 <c:if test="${item_pacco.pacco.stato_lavorazione.id == 6}">
 <span class="label" style="background-color:#ac7339">${item_pacco.pacco.stato_lavorazione.descrizione}</span></c:if>
</td>
<td>${item_pacco.item.stato.descrizione }</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${item_pacco.pacco.data_arrivo}" /></td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${item_pacco.pacco.data_spedizione}" /></td>
<td>${item_pacco.pacco.ddt.colli }</td>
<%--   <c:choose>
  <c:when test="${item_pacco.item.attivita !='undefined'}">
  <td>${item_pacco.item.attivita }</td>
  </c:when>
  <c:otherwise><td></td></c:otherwise>
  </c:choose> --%>
 <td>${item_pacco.item.attivita_item.descrizione }</td>
  <c:choose>
  <c:when test="${item_pacco.item.destinazione !='undefined'}">
 <td>${item_pacco.item.destinazione }</td>
  </c:when>
  <c:otherwise><td></td></c:otherwise>
  </c:choose>
  <td>${item_pacco.pacco.fornitore }</td>
<td>  <c:if test="${item_pacco.item.priorita ==1}">Urgente</c:if>
    <c:if test="${item_pacco.item.priorita ==0}"></c:if></td>
<td>${item_pacco.note}</td>
<c:choose>
<c:when test="${item_pacco.pacco.ddt.numero_ddt!='' && item_pacco.pacco.ddt.numero_ddt!=null }">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${utl:encryptData(item_pacco.pacco.ddt.id)}')">
${item_pacco.pacco.ddt.numero_ddt} del <fmt:formatDate pattern = "dd/MM/yyyy" value = "${item_pacco.pacco.ddt.data_ddt}" />
</a></td></c:when>
<c:otherwise><td></td></c:otherwise>
</c:choose>
<td>${item_pacco.pacco.ddt.tipo_porto.descrizione }</td>
<td>${item_pacco.pacco.company.denominazione}</td>
<td>${item_pacco.pacco.utente.nominativo}</td>



	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>
</div>



 <div id="myModalCommessa" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabelCommessa">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista Attività </h4>
      </div>
       <div class="modal-body" id="commessa_body">
       
       
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">


       
      </div>
    </div>
  </div>
</div>
 

   <div id="myModal" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Strumento</h4>
      </div>
       <div class="modal-body">

        <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#dettaglio" data-toggle="tab" aria-expanded="true" onclick="" id="dettaglioTab">Dettaglio Strumento</a></li>
              <li class=""><a href="#misure" data-toggle="tab" aria-expanded="false" onclick="" id="misureTab">Misure</a></li>
       <!--        <li class=""><a href="#prenotazione" data-toggle="tab" aria-expanded="false" onclick="" id="prenotazioneTab">Stato Prenotazione</a></li> -->
        
 		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
               <li class=""><a href="#modifica" data-toggle="tab" aria-expanded="false" onclick="" id="modificaTab">Modifica Strumento</a></li>
		</c:if>		
		 <li class=""><a href="#documentiesterni" data-toggle="tab" aria-expanded="false" onclick="" id="documentiesterniTab">Documenti esterni</a></li>
             </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="dettaglio">

    			</div> 

              <!-- /.tab-pane -->
             
			  <div class="tab-pane" id="misure">
                

         
			 </div> 


              <!-- /.tab-pane -->


               		<c:if test="${userObj.checkPermesso('MODIFICA_STRUMENTO_METROLOGIA')}">
              
              			<div class="tab-pane" id="modifica">
              

              			</div> 
              		</c:if>		
              		
              		<div class="tab-pane" id="documentiesterni">
              

              			</div> 
              
            </div>
            <!-- /.tab-content -->
          </div>
    
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

      </div>
    </div>
  </div>
</div> 


</div>
  </section>
  </div>

  
  <!-- /.content-wrapper -->

  <t:dash-footer />
  

  <t:control-sidebar />
 

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
<script type="text/javascript">


 $("#tab_lista_item").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    } 
    
     	  $('#tab_lista_item thead th').each( function () {     		  
     		  $('#search_input_'+$(this).index()).val(columsDatatables[$(this).index()].search.search);

    	    	}); 
    	 
    	  }); 

 
 $('#pacco_origine').on('change', function(){

     creaStoricoItem($('#pacco_origine').val(), $('#id_item_text').val(), $('#matricola_item_text').val());

 });

 $('#id_item_text').on('change', function(){
	
	 $('#pacco_origine').attr("disabled", true);
 });
 
 
function itemEsterno(){
	
	dataString = "?action=item_esterno";

pleaseWaitDiv = $('#pleaseWaitDialog');
pleaseWaitDiv.modal();

callAction("listaItem.do"+ dataString, false,true);
}

function cercaPacchiOrigine(id_item, matricola){
	if(id_item!=""){	
		if(isNaN(id_item)){
			$('#myModalErrorContent').html("Attenzione! Inserisci un valore numerico per l'ID!");
		  	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");	  
			$('#myModalError').modal('show');
		}else{
			
				cercaOrigini(id_item, matricola);	
			
		}
	}else{
		if(matricola!=""){
			cercaOrigini(null, matricola);
		}
	}
}

function tornaItem(){
	dataString = "?action=lista";

	pleaseWaitDiv = $('#pleaseWaitDialog');
	pleaseWaitDiv.modal();

	callAction("listaItem.do"+ dataString, false,true);
}

var columsDatatables = [];
$(document).ready(function(){
	
	 creaGrafico();
	
	$('.dropdown-toggle').dropdown();
	
	

    $('#tab_lista_item thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tab_lista_item thead th').eq( $(this).index() ).text();
    	  $(this).append( '<div><input class="inputsearchtable" id="search_input_'+$(this).index()+'" style="width:100%" type="text"  value=""/></div>');
    	} );

 	table_item = $('#tab_lista_item').DataTable({
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
	     "order": [ 8, "desc" ], 
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: true, 
	      targets: 0,
	      responsive: false,
	      stateSave: true,
		  searching: true,
		  scrollX: true,
		  scrollY: "450px",
		  fixedColumns: false,
		  scrollCollapse: true,
	       columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ],

	    	
	    }); 
	    

		    $('.inputsearchtable').on('click', function(e){
		       e.stopPropagation();    
		    });  
	//DataTable
	 table = $('#tab_lista_item').DataTable();
	//Apply the search
	table.columns().eq( 0 ).each( function ( colIdx ) {
	$( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	  table_item
	      .column( colIdx )
	      .search( this.value )
	      .draw();
	} );
	} ); 
	table.columns.adjust().draw();


	$('#tab_lista_item').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
	    theme: 'tooltipster-light'
	});

	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	}) 


	});
	
	
	 
	 var item_esterno = ${item_esterno};
	 
	 if(item_esterno){
		 $('#tornaItem').show();
	 }else{
		 $('#tornaItem').hide();
	 }
	
	
});

function dettaglioStrumento(id_strumento){

	$('#myModalLabelHeader').html("");
	
	$('#myModalError').removeClass();
	$('#myModalError').addClass("modal modal-success");
	$('#myModalError').css("z-index", "1070");
	    	exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
	    	$( "#myModal" ).modal();
	    	//$('body').addClass('noScroll');

   $('a[data-toggle="tab"]').one('shown.bs.tab', function (e) {


   	var  contentID = e.target.id;

   	if(contentID == "dettaglioTab"){
   		exploreModal("dettaglioStrumento.do","id_str="+id_strumento,"#dettaglio");
   	}
   	if(contentID == "misureTab"){
   		exploreModal("strumentiMisurati.do?action=ls&id="+id_strumento,"","#misure")
   	}
   	if(contentID == "modificaTab"){
   		exploreModal("modificaStrumento.do?action=modifica&id="+id_strumento,"","#modifica")
   	}
   	if(contentID == "documentiesterniTab"){
   		exploreModal("documentiEsterni.do?id_str="+id_strumento,"","#documentiesterni")
   
   	}
   	
		});
 
}

$("#myModalCommessa").on("hidden.bs.modal", function(){
	
	$(document.body).css('padding-right', '0px');
	
});

$('#myModal').on('hidden.bs.modal', function (e) {

 	$('#dettaglioTab').tab('show');
 	$(document.body).css('padding-right', '0px');
 	
});

function dettaglioPaccoFromOrigine(origine){
	
	var id = origine.split("_")
	dettaglioPacco(id[1]);
	
}


function creaGrafico(){

	var item_pacco_json = ${item_pacco_json};
	var lavorati=0;
	var in_lavorazione=0;
	if(item_pacco_json!=null){
	item_pacco_json.forEach(function(idx){
		if(idx.item.stato.id==1){
			in_lavorazione++;
		}
		else if(idx.item.stato.id==2){
			lavorati++;
		}
		
	});
	}
	var ctx = document.getElementById("chart_lavorazione").getContext('2d');
	var myChart = new Chart(ctx, {
	    type: 'horizontalBar',
	    responsive:false,
	    maintainAspectRatio: false,
	    data: {
	        labels: ["In lavorazione", "Lavorati"],
	        datasets: [{
	            label: '# di strumenti',
	            data: [in_lavorazione, lavorati],
	            backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255,99,132,1)',
	                'rgba(54, 162, 235, 1)'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        scales: {
	        	xAxes: [{
                    
                    ticks: {
                        //beginAtZero:this.beginzero,
                    	beginAtZero:true
                    }
                }],
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
	        }
	    }
	});

}
</script>


</jsp:attribute> 
</t:layout>
  
 
