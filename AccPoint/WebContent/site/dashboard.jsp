<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@ page language="java" import="java.util.ArrayList" %>
 <%@page import="com.google.gson.Gson"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

<c:choose>
<c:when test="${userObj.getListaRuoli().size()==1 && (userObj.checkRuolo('F1') || userObj.checkRuolo('F2')) }">
<c:set var="calver_color" value="blue"></c:set>
</c:when>
<c:when test="${userObj.getListaRuoli().size()==1 && (userObj.checkRuolo('D1') || userObj.checkRuolo('D2')) }">
<c:set var="calver_color" value="green"></c:set>
</c:when>
<c:otherwise>
<c:set var="calver_color" value="red"></c:set>
</c:otherwise>

</c:choose>


<t:layout title="Calver" bodyClass="skin-${calver_color }-light sidebar-mini wysihtml5-supported">



<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
     <c:if test="${userObj.checkPermesso('GRAFICI_TREND') || userObj.checkRuolo('AM')}"> 
     
     <section class="content-header">
       <h1 class="pull-left">
        Dashboard
        <small></small>
      </h1>
         <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    
    

    <div style="clear: both;"></div>    
    
     <section class="content">
    <div class="row dashboard-row">

        <c:forEach items="${tipoTrend}" var="val" varStatus="loop">
            <div class="col-sm-6 col-xs-12 grafico1 dashboard-col" id="box_${val.id}_${val.descrizione}">
                <div class="box box-primary dashboard-box">
                    <div class="box-header with-border">
                        <h3 class="box-title"></h3>
                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <div class="box-body">
                        <div class="chart">
                            <canvas id="${val.id}_${val.descrizione}"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

       <!-- GRAFICO ITEM -->
<div class="col-sm-6 col-xs-12 graficoItem dashboard-col">

    <div class="box box-primary dashboard-box">

        <div class="box-header with-border">

            <h3 class="box-title">
                ITEM IN LAVORAZIONE/LAVORATI
                <span id="meseItem"></span>
            </h3>

            <div class="box-tools pull-right">

                <button type="button"
                        class="btn btn-box-tool"
                        data-widget="collapse">
                    <i class="fa fa-minus"></i>
                </button>

                <button type="button"
                        class="btn btn-box-tool"
                        data-widget="remove">
                    <i class="fa fa-times"></i>
                </button>

            </div>

        </div>

        <div class="box-body">

            <!-- TOTALE -->
            <div class="text-center"
                 style="margin-bottom:10px;">

                <div style="font-size:22px; font-weight:bold;">
                    Totale item:
                    <span id="totaleItemMese">0</span>
                </div>

                <!-- DETTAGLIO -->
                <div style="font-size:12px; margin-top:5px; line-height:22px;">

                    In lavorazione:
                    <strong id="numeroItemInLavorazione">0</strong>
                     
                     &nbsp; | &nbsp;

                    Fornitori:
                    <strong id="numeroItemFornitori">0</strong>

                
                      
                     &nbsp; | &nbsp;

                    Lavorati in Magazzino:
                    <strong id="numeroItemLavoratiInIngresso">0</strong>


                    &nbsp; | &nbsp;
                
                    In spedizione:
                    <strong id="numeroItemLavoratiInSpedizione">0</strong>

              

                </div>

            </div>

            <!-- GRAFICO -->
            <div class="chart chart-item">

                <div class="chart-item-small">
                    <canvas id="graficoItem"></canvas>
                </div>

                <p id="noDatiItem"
                   class="text-center text-muted"
                   style="display:none;">
                    Nessun item per il mese selezionato
                </p>

            </div>

        </div>

    </div>

</div>
        
       <!-- GRAFICO CERTIFICATI LAT / SVT / RDT -->
<div class="col-sm-6 col-xs-12 graficoCertificati dashboard-col">

    <div class="box box-primary dashboard-box">

        <div class="box-header with-border">

          <h3 class="box-title">
    CERTIFICATI EMESSI NEL MESE
    <span id="meseCertificati"></span>
</h3>

            <div class="box-tools pull-right">

                <button type="button"
                        class="btn btn-box-tool"
                        data-widget="collapse">
                    <i class="fa fa-minus"></i>
                </button>

                <button type="button"
                        class="btn btn-box-tool"
                        data-widget="remove">
                    <i class="fa fa-times"></i>
                </button>

            </div>

        </div>

        <div class="box-body">
        <div class="text-center" style="margin-bottom: 10px;">

    <div style="font-size: 22px; font-weight: bold;">
        Totale certificati:
        <span id="totaleCertificatiMese">0</span>
    </div>

    <div style="font-size: 13px; margin-top: 5px;">

        LAT: <strong id="numeroLAT">0</strong> &nbsp; | &nbsp;
        SVT: <strong id="numeroSVT">0</strong> &nbsp; | &nbsp;
        RDT: <strong id="numeroRDT">0</strong> &nbsp; | &nbsp;
        RDP: <strong id="numeroRDP">0</strong> &nbsp; | &nbsp;
        SE: <strong id="numeroSE">0</strong>

    </div>

</div>

            <div class="chart chart-certificati">

                <div class="chart-certificati-small">
                    <canvas id="graficoCertificati"></canvas>
                </div>

                <p id="noDatiCertificati"
                   class="text-center text-muted"
                   style="display:none;">
                    Nessun certificato per il mese selezionato
                </p>

            </div>

        </div>

    </div>

</div>

        <!-- BACHECA MESSAGGI -->
        <div class="col-sm-6 col-xs-12 dashboard-col">
            <div class="box box-primary dashboard-box">
                <div class="box-header with-border">
                    <h3 class="box-title">Bacheca Messaggi</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive mailbox-messages">
                        <table id="tabBacheca" class="table table-hover table-striped" role="grid" width="100%">
                            <thead>
                                <tr class="active">
                                    <th>Mittente</th>
                                    <th>Oggetto</th>
                                    <th>Data</th>
                                </tr>
                            </thead>
                            <tbody id="tbodyitem">
                                <c:forEach items="${lista_messaggi}" var="messaggio" varStatus="loop">
                                    <tr>
                                        <c:choose>
                                            <c:when test="${messaggio.letto_da_me==1}">
                                                <td>${messaggio.utente.nominativo}</td>
                                                <td><a href="#" class="mailbox-name" onClick="dettaglioMessaggio('${messaggio.id}','${messaggio.letto_da_me}')">${messaggio.titolo}</a></td>
                                                <td><fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss" value="${messaggio.data}" /></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td style="color:red;font-weight:bold;">${messaggio.utente.nominativo}</td>
                                                <td style="color:red;font-weight:bold;"><a href="#" class="mailbox-name" style="color:red" onClick="dettaglioMessaggio('${messaggio.id}','${messaggio.letto_da_me}')">${messaggio.titolo}</a></td>
                                                <td style="color:red;font-weight:bold;"><fmt:formatDate pattern="dd/MM/yyyy HH:mm:ss" value="${messaggio.data}" /></td>
                                            </c:otherwise>
                                        </c:choose>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- MODALE: spostata dentro il box-body ma è position:fixed, non altera il layout -->
                    <div id="myModalMessaggio" class="modal" role="dialog" aria-labelledby="myLargeModalLabel">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="myModalLabel">Dettaglio messaggio</h4>
                                </div>
                                <div class="modal-body" id="messaggio_body">
                                    <div id="empty" class="testo12"></div>
                                </div>
                                <div class="modal-footer"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</section>
		
     
     
     </c:if>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

 <style>
.dashboard-col .dashboard-box {
    height: 380px;
}

.dashboard-col .box-body {
    height: 300px;
}

.dashboard-col .chart {
    height: 330px;
}

.chart-item-small,
.chart-certificati-small {
    width: 100%;
    height: 230px;
    margin: 0 auto;
    position: relative;
}
        .chart-item-small {
            width: 430px;
            height: 230px;
            margin: 0 auto;
            position: relative;
        }

    </style>

<c:if test="${userObj.checkRuolo('F1')|| userObj.checkRuolo('F2') }">

<style>

.table th {
    background-color: #3c8dbc !important;
  }</style>

</c:if>




</style>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
 <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
  <script type="text/javascript" src="js/customCharts.js"></script>
 	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
	<script src="https://cdn.datatables.net/plug-ins/1.10.16/sorting/date-euro.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.8.0/jquery.contextMenu.min.js"></script> 

<script type="text/javascript">
	var tipoTrendJson = ${tipoTrendJson};
	var trendJson = ${trendJson};
	var pacchiChiusi = ${empty pacchiChiusi ? 0 : pacchiChiusi};
	var pacchiAperti = ${empty pacchiAperti ? 0 : pacchiAperti};
	
	var totalePacchi = pacchiChiusi + pacchiAperti;

	var certificatiLAT = ${empty certificatiLATJson ? '[0,0,0,0,0,0]' : certificatiLATJson};
	var certificatiSVT = ${empty certificatiSVTJson ? '[0,0,0,0,0,0]' : certificatiSVTJson};
	var certificatiRDT = ${empty certificatiRDTJson ? '[0,0,0,0,0,0]' : certificatiRDTJson};
	var certificatiRDP = ${empty certificatiRDPJson ? '[0,0,0,0,0,0]' : certificatiRDPJson};
	var certificatiSE  = ${empty certificatiSEJson ? '[0,0,0,0,0,0]' : certificatiSEJson};
	
	var itemInLavorazione = ${empty itemInLavorazione ? 0 : itemInLavorazione};
	var itemFornitori = ${empty itemFornitori ? 0 : itemFornitori};
	var itemLavoratiInIngresso = ${empty itemLavoratiInIngresso ? 0 : itemLavoratiInIngresso};
	var itemLavoratiInSpedizione = ${empty itemLavoratiInSpedizione ? 0 : itemLavoratiInSpedizione};
//	var itemLavoratiInUscita = ${empty itemLavoratiInUscita ? 0 : itemLavoratiInUscita};
	//var itemLavoratiInSpedizione = ${empty itemLavoratiInSpedizione ? 0 : itemLavoratiInSpedizione};
		
	var columsDatatables = [];
	 
 	$("#tabBacheca").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabBacheca thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabBacheca thead th').eq( $(this).index() ).text();
	    	  $(this).append( '<div><input class="inputsearchtable" style="width:100%;" type="text" value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	} );

	} ); 
	
	 $("#myModalMessaggio").on("hidden.bs.modal", function(){
			
			$(document.body).css('padding-right', '0px');
			//location.reload();
		});
	 
	 

	
    $(document).ready(function() {
    	
    	/* INVERSIONE POSIZIONE:
    	   MISURE EFFETTUATE <-> CERTIFICATI */

    	var boxMisure =
    	    document.getElementById("box_1_Misure Effettuate");

    	var boxCertificati =
    	    document.querySelector(".graficoCertificati");

    	if (boxMisure != null && boxCertificati != null) {

    	    var parent = boxMisure.parentNode;

    	    // Segnaposto della posizione originale di Misure Effettuate
    	    var placeholder = document.createComment("posizione-misure");

    	    parent.insertBefore(placeholder, boxMisure);

    	    // Porta Misure Effettuate nella posizione dei Certificati
    	    parent.insertBefore(boxMisure, boxCertificati);

    	    // Porta Certificati nella vecchia posizione di Misure Effettuate
    	    parent.insertBefore(boxCertificati, placeholder);

    	    // Elimina il segnaposto
    	    parent.removeChild(placeholder);
    	}
    	
    	$.fn.dataTable.moment( 'dd/MM/yyyy HH:mm:ss' );
    	
    	table = $('#tabBacheca').DataTable({
    		language: {
    	        	emptyTable : 	"Nessun dato presente nella tabella",
    	        	info	:"Vista da _START_ a _END_ di _TOTAL_ elementi",
    	        	infoEmpty:	"Vista da 0 a 0 di 0 elementi",
    	        	infoFiltered:	"(filtrati da _MAX_ elementi totali)",
    	        	infoPostFix:	"",
    	        infoThousands:	".",
    	       /*   lengthMenu:	"Visualizza _MENU_ elementi",  */
    	        loadingRecords:	"Caricamento...",
    	        	processing:	"Elaborazione...",
    	        	 search:	"Cerca:", 
    	        	zeroRecords	:"La ricerca non ha portato alcun risultato.",
    	        	paginate:	{
      	        	first:	"Inizio",
      	        	previous:	"Prec.",
      	        	next:	"Succ.",
      	        last:	"Fine",
    	        	},
    	        aria:	{
      	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
      	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
    	        }
            },
            
             "lengthMenu": [ [5, 10, 25, -1], [5, 10, 25, "All"] ], 
        	
            pageLength: 5,
             "order": [ 2, "desc" ],  
    	      paging: true, 
    	      ordering: true,
    	      info: true, 
    	      lengthChange:false,  
    	      displayLength:false,
    	      searchable: true,  
    	      targets: 0,
    	      responsive: true,
    	      scrollX: false,
    	      stateSave: true,
    	      searching: true, 
    	     
    	      dom : "t<'col-xs-6'i><'col-xs-6'p>",
    	      columns : [
    	      	 {"data" : "mittente"},
    	      	 {"data" : "oggetto"},
    	      	 {"data" : "data"}

    	       ],	
    	       
    	      columnDefs:[
				   { responsivePriority: 1, targets: 0 },
                   { responsivePriority: 3, targets: 2 },
                   { type: 'date-euro', targets: 2 }
                  
               ]

    	    });
    	
    	   $('.inputsearchtable').on('click', function(e){
  	       e.stopPropagation();    
  	    }); 
 // DataTable
  table = $('#tabBacheca').DataTable();
 // Apply the search
 table.columns().eq( 0 ).each( function ( colIdx ) {
   $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
       table
           .column( colIdx )
           .search( this.value )
           .draw();
   } );
 } ); 
 	table.columns.adjust().draw();  
 	

   $('#tabBacheca').on( 'page.dt', function () {
 	$('.customTooltip').tooltipster({
         theme: 'tooltipster-light'
     }); 
 	
  	$('.removeDefault').each(function() {
 	   $(this).removeClass('btn-default');
 	})  


 });

   

    	
    	
if(trendJson!=null){
    	tipoTrendJson.forEach(function(item, index) {

    		newArrColor = [
		         'rgba(255, 99, 132, 0.2)',
		         'rgba(54, 162, 235, 0.2)',
		         'rgba(255, 206, 86, 0.2)',
		         'rgba(75, 192, 192, 0.2)',
		         'rgba(153, 102, 255, 0.2)',
		         'rgba(255, 159, 64, 0.2)',
		         'rgba(255,0,0,0.2)',
		         'rgba(46,46,255,0.2)',
		         'rgba(255,102,143,0.2)',
		         'rgba(255,240,36,0.2)',
		         'rgba(255,54,255,0.2)',
		         'rgba(107,255,235,0.2)',
		         'rgba(255,83,64,0.2)'
		     ];
     		newArrColorBorder = [
		         'rgba(255, 99, 132, 1)',
		         'rgba(54, 162, 235, 1)',
		         'rgba(255, 206, 86, 1)',
		         'rgba(75, 192, 192, 1)',
		         'rgba(153, 102, 255, 1)',
		         'rgba(255, 159, 64, 1)',
		         'rgba(255,0,0,1)',
		         'rgba(46,46,255,1)',
		         'rgba(255,102,143,1)',
		         'rgba(255,240,36,1)',
		         'rgba(255,54,255,1)',
		         'rgba(107,255,235,1)',
		         'rgba(255,83,64,1)'
		     ];


    	numberBack1 = Math.ceil(Object.keys(trendJson).length/6);
    	if(numberBack1>0){
    		grafico1 = {};
    		grafico1.labels = [];
    		 
    		dataset1 = {};
    		dataset1.data = [];
    		dataset1.label = "# "+item.descrizione;
	
    		//dataset1.backgroundColor = newArrColor[Math.floor(Math.random() * newArrColor.length)];
		    //dataset1.borderColor = newArrColorBorder[Math.floor(Math.random() * newArrColor.length)];
		    
			dataset1.backgroundColor = [];
			dataset1.borderColor = [];
		    
    		dataset1.borderWidth = 1;
    		
    		var itemHeight1 = 200;
    		var type;
    		var totalElement = 0;
    		$.each(trendJson, function(i,val){
		if(val.tipoTrend.id == item.id){
			//alert(val.data);
			//alert(val.asse_x);
    				if(val.data==null)
    			{
    				
    				grafico1.labels.push(""+val.asse_x);
    				
    			}else
    			{
    				
    				grafico1.labels.push(""+val.data);
    				
    			}
				
    				
    				if(val.tipoTrend.tipo_grafico==1)
    				{
    					type="line"
    					
    				}
    				else if(val.tipoTrend.tipo_grafico==2)
    				{
    					
    					type="bar"
    				}
    				
    				else if(val.tipoTrend.tipo_grafico==3)
    				{
    					type="horizontalBar"
    				}
    				
    				else{
    					type="pieLabels"
    				}
    				
    			dataset1.data.push(val.val);
    			totalElement += val.val;
    			itemHeight1 += 12;
    			dataset1.backgroundColor = dataset1.backgroundColor.concat(newArrColor);
    			
		}
    		});
    		//$(".grafico1").height(itemHeight1);
    		 grafico1.datasets = [dataset1];
    		 
    		 var ctx1 = document.getElementById(item.id+"_"+item.descrizione).getContext("2d");
 
    		 if(type=="pieLabels"){
    			 myChart1 = new Chart(ctx1, {
        		     type: type,
        		     data: grafico1,
        		     options: {
        		    	 responsive: true, 
        		    	 maintainAspectRatio: false,
        		         scales: {
        		             yAxes: [{
        		                 ticks: {
        		                     beginAtZero:true,
        		                     autoSkip: false
        		                 }
        		             }],
        		             xAxes: [{
        		                 ticks: {
        		                     autoSkip: false
        		                 }
        		             }]
        		         },
        		         tooltips: {
	    	    		    		 callbacks: {
	    	    		    		      // tooltipItem is an object containing some information about the item that this label is for (item that will show in tooltip). 
	    	    		    		      // data : the chart data item containing all of the datasets
	    	    		    		      label: function(tooltipItem, data) {
	    	    		    		    	  var value = data.datasets[0].data[tooltipItem.index];
	    	    		                      var label = data.labels[tooltipItem.index];
	    	    		                      var percentage =  value / totalElement * 100;
	    	    		                     
	    	    		                      return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';
	    	
	    	    		    		      }
	    	    		    		    }
        		    		  } 

        		     }
        		  
        		 });
    		 }else{
    			 myChart1 = new Chart(ctx1, {
        		     type: type,
        		     data: grafico1,
        		     options: {
        		    	 responsive: true, 
        		    	 maintainAspectRatio: true,
        		         scales: {
        		             yAxes: [{
        		                 ticks: {
        		                     beginAtZero:true,
        		                     autoSkip: false
        		                 }
        		             }],
        		             xAxes: [{
        		                 ticks: {
        		                	 beginAtZero:true,
        		                     autoSkip: false
        		                 }
        		             }]
        		         }

        		     }
        		  
        		 });
    		 }
    		  
    		  
    		}
   
    	 if(	numberBack1==0){
    		 $("#box_"+item.id+"_"+item.descrizione).hide();
    		 
    	 }else{
    		 $("#box_"+item.id+"_"+item.descrizione).show();
    	 }
    	});
}else{
	 $(".grafico1").hide();
}



/* GRAFICO ITEM */

//Configurazione iniziale del grafico
var graficoItem = {

 labels: [
     "In lavorazione",
     "Presso Fornitori",
     "Lavorati in magazzino",
     "Lavorati in spedizione",
 ],

 datasets: [{

     label: "# Item",

     data: [0, 0, 0, 0, 0, 0, 0],

     backgroundColor: [
         'rgba(255, 99, 132, 0.5)',      
         'rgba(255, 206, 86, 0.5)',      
         'rgba(54, 162, 235, 0.5)',
         'rgba(153, 102, 255, 0.5)'
      
     ],

     borderColor: [
         'rgba(255, 99, 132, 1)',      
         'rgba(255, 206, 86, 1)',
         'rgba(54, 162, 235, 1)',
         'rgba(153, 102, 255, 1)'
         
     ],

     borderWidth: 1

 }]

};


//Contesto del canvas
var ctxItem =
 document.getElementById("graficoItem").getContext("2d");


//Creazione del grafico
var myChartItem = new Chart(ctxItem, {

 type: "pie",

 data: graficoItem,

 options: {

     responsive: true,

     maintainAspectRatio: false,

     animation: {
         duration: 800
     },

     legend: {
         display: true,
         position: 'bottom',
         labels: {
             boxWidth: 10,
             fontSize: 10
         }
     },

     tooltips: {

         callbacks: {

             label: function(tooltipItem, data) {

                 var value =
                     data.datasets[0].data[tooltipItem.index];

                 var label =
                     data.labels[tooltipItem.index];

                 var totale =
                     data.datasets[0].data.reduce(
                         function(a, b) {
                             return a + b;
                         }, 0
                     );

                 var percentage = totale > 0
                     ? value / totale * 100
                     : 0;

                 return label
                     + ': '
                     + value
                     + ' - '
                     + percentage.toFixed(2)
                     + '%';
             }

         }

     }

 }

});





 // Aggiornamento dei contatori
function aggiornaGraficoItem() {

    var totale =
        itemInLavorazione +
        itemFornitori +
        itemLavoratiInIngresso +
        itemLavoratiInSpedizione;
    // Aggiornamento dei contatori
    $("#totaleItemMese").text(totale);

    $("#numeroItemInLavorazione").text(itemInLavorazione);
    $("#numeroItemFornitori").text(itemFornitori);
    $("#numeroItemLavoratiInIngresso").text(itemLavoratiInIngresso);
    $("#numeroItemLavoratiInSpedizione").text(itemLavoratiInSpedizione);
 //   $("#numeroItemLavoratiInUscita").text(itemLavoratiInUscita);
 //   $("#numeroItemInSpedizione").text(itemLavoratiInSpedizione);
  

    // Aggiornamento del grafico
    myChartItem.data.datasets[0].data = [
        itemInLavorazione,
        itemFornitori,
        itemLavoratiInIngresso,
        itemLavoratiInSpedizione,
    //    itemLavoratiInUscita,
    //    itemLavoratiInSpedizione,
    ];

    if (totale > 0) {

        $("#noDatiItem").hide();
        $("#graficoItem").css("visibility", "visible");

        myChartItem.update();

    } else {

        $("#graficoItem").css("visibility", "hidden");
        $("#noDatiItem").show();

    }
}
/* GRAFICO CERTIFICATI LAT / SVT / RDT / RDP / SE */

//Mese visualizzato (0 = corrente, 5 = cinque mesi fa)
var indiceMese = 0;

//Riferimento al primo giorno del mese corrente
var dataRiferimento = new Date();
dataRiferimento.setDate(1);

//Nomi dei mesi
var nomiMesi = [
 "GENNAIO",
 "FEBBRAIO",
 "MARZO",
 "APRILE",
 "MAGGIO",
 "GIUGNO",
 "LUGLIO",
 "AGOSTO",
 "SETTEMBRE",
 "OTTOBRE",
 "NOVEMBRE",
 "DICEMBRE"
];

//Numero di mesi disponibili
var numeroMesi = Math.min(
 certificatiLAT.length,
 certificatiSVT.length,
 certificatiRDT.length,
 certificatiRDP.length,
 certificatiSE.length
);

//Configurazione iniziale del grafico
var graficoCertificati = {

 labels: [
     "LAT",
     "SVT",
     "RDT",
     "RDP",
     "SE"
 ],

 datasets: [{

     label: "# Certificati",

     data: [0, 0, 0, 0, 0],

     backgroundColor: [
         'rgba(54, 162, 235, 0.5)',
         'rgba(75, 192, 192, 0.5)',
         'rgba(255, 206, 86, 0.5)',
         'rgba(153, 102, 255, 0.5)',
         'rgba(255, 99, 132, 0.5)'
     ],

     borderColor: [
         'rgba(54, 162, 235, 1)',
         'rgba(75, 192, 192, 1)',
         'rgba(255, 206, 86, 1)',
         'rgba(153, 102, 255, 1)',
         'rgba(255, 99, 132, 1)'
     ],

     borderWidth: 1

 }]

};


//Contesto del canvas
var ctxCertificati =
 document.getElementById("graficoCertificati").getContext("2d");


//Creazione del grafico
var myChartCertificati = new Chart(ctxCertificati, {

 type: "pie",

 data: graficoCertificati,

 options: {

     responsive: true,

     maintainAspectRatio: false,

     animation: {
         duration: 800
     },

     legend: {
         display: true,
         position: 'bottom'
     },

     tooltips: {

         callbacks: {

             label: function(tooltipItem, data) {

                 var value =
                     data.datasets[0].data[tooltipItem.index];

                 var label =
                     data.labels[tooltipItem.index];

                 var totale = data.datasets[0].data.reduce(
                     function(a, b) {
                         return a + b;
                     }, 0
                 );

                 var percentage = totale > 0
                     ? value / totale * 100
                     : 0;

                 return label
                     + ': '
                     + value
                     + ' - '
                     + percentage.toFixed(2)
                     + '%';
             }

         }

     }

 }

});


//Funzione per visualizzare un determinato mese
function aggiornaGraficoCertificati() {

 if (numeroMesi === 0) {
     return;
 }

 // Recupero dei cinque valori relativi al mese
 var lat = certificatiLAT[indiceMese];
 var svt = certificatiSVT[indiceMese];
 var rdt = certificatiRDT[indiceMese];
 var rdp = certificatiRDP[indiceMese];
 var se  = certificatiSE[indiceMese];
 


 // Totale del mese
 var totale = lat + svt + rdt + rdp + se;
 
//Aggiornamento dei numeri visualizzati nel box

 $("#totaleCertificatiMese").text(totale);

 $("#numeroLAT").text(lat);
 $("#numeroSVT").text(svt);
 $("#numeroRDT").text(rdt);
 $("#numeroRDP").text(rdp);
 $("#numeroSE").text(se);

 // Calcolo del mese da visualizzare
 var dataMese = new Date(dataRiferimento);

 dataMese.setMonth(
     dataRiferimento.getMonth() - indiceMese
 );

 var nomeMese = nomiMesi[dataMese.getMonth()];
 var anno = dataMese.getFullYear();

 // Aggiornamento del titolo del box
 $("#meseCertificati").text(
     " - " + nomeMese + " " + anno
 );

 // Aggiornamento dei valori del grafico
 myChartCertificati.data.datasets[0].data = [
     lat,
     svt,
     rdt,
     rdp,
     se
 ];

//Gestione dei mesi senza certificati

 if (totale > 0) {

     $("#noDatiCertificati").hide();

     // Ripristina la visibilità del grafico
     $("#graficoCertificati").css("visibility", "visible");

     // Aggiorna il grafico
     myChartCertificati.update();

 } else {

     // Nasconde la torta senza modificare le dimensioni del canvas
     $("#graficoCertificati").css("visibility", "hidden");

     // Mostra il messaggio
     $("#noDatiCertificati").show();

 }

}


//Inizializzazione del grafico degli item
aggiornaGraficoItem();

// Inizializzazione del grafico dei certificati
aggiornaGraficoCertificati();

// Rotazione dei soli certificati ogni 5 secondi
if (numeroMesi > 1) {

    var intervalloCertificati = setInterval(function() {

        indiceMese = (indiceMese + 1) % numeroMesi;

        aggiornaGraficoCertificati();

    }, 5000);
}
 

});

/*     $('#tabPacchi tbody td').on('contextmenu',  function(e) {
    
    	    e.preventDefault(); // Prevent default context menu
    

    	});  */
	
    	
    	 
    	 
</script>
</jsp:attribute> 
</t:layout>


