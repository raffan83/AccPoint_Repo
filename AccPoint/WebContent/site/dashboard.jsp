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
        SE: <strong id="numeroSE">0</strong> &nbsp; | &nbsp;
        ALTRO: <strong id="numeroAltro">0</strong>

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
.dashboard-row { display: flex; flex-wrap: wrap; }
.dashboard-row:before, .dashboard-row:after { display: none; }

.dashboard-col { display: flex; margin-bottom: 15px; }

/* Colonna con box collassato: non si allunga all'altezza della riga */
.dashboard-col.col-collapsed {
    align-self: flex-start;
}

.dashboard-box {
    width: 100%;
    display: flex;
    flex-direction: column;
    margin-bottom: 0;
}

.dashboard-box .box-body {
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 0;
}

/* L'area grafico prende tutto lo spazio rimasto nel box */
.dashboard-box .chart {
    position: relative;
    flex: 1;
    min-height: 260px;   /* altezza minima, poi cresce col box */
    width: 100%;
}

/* Il wrapper interno riempie l'area grafico */
.chart-item-small,
.chart-certificati-small {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
}

/* Il canvas diretto dei grafici dinamici */
.dashboard-box .chart > canvas {
    position: absolute;
    top: 0; left: 0;
}

/* Messaggio "nessun dato" centrato sull'area grafico */
#noDatiItem, #noDatiCertificati {
    position: absolute;
    top: 50%; left: 0; right: 0;
    transform: translateY(-50%);
    margin: 0;
}

.dashboard-box .mailbox-messages { flex: 1; overflow-y: auto; }

@media (max-width: 767px) {
    .dashboard-col { display: block; }
    .dashboard-box .chart { min-height: 280px; }
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
	var certificatiAltro = ${empty certificatiAltroJson ? '[0,0,0,0,0,0]' : certificatiAltroJson};
	
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

    	/* PALETTE COLORI DASHBOARD */
    	var coloriDashboard = [
    'rgba(99, 102, 241, 0.62)',
    'rgba(34, 211, 238, 0.62)',
    'rgba(52, 211, 153, 0.62)',
    'rgba(251, 191, 36, 0.62)',
    'rgba(251, 113, 133, 0.62)',
    'rgba(167, 139, 250, 0.62)',
    'rgba(45, 212, 191, 0.62)',
    'rgba(96, 165, 250, 0.62)',
    'rgba(244, 114, 182, 0.62)',
    'rgba(163, 230, 53, 0.62)',
    'rgba(251, 146, 60, 0.62)',
    'rgba(129, 140, 248, 0.62)',
    'rgba(56, 189, 248, 0.62)'
   ];
    	var bordiDashboard = [
    	    'rgba(79, 70, 229, 1)',
    	    'rgba(6, 182, 212, 1)',
    	    'rgba(16, 185, 129, 1)',
    	    'rgba(245, 158, 11, 1)',
    	    'rgba(244, 63, 94, 1)',
    	    'rgba(139, 92, 246, 1)',
    	    'rgba(20, 184, 166, 1)',
    	    'rgba(59, 130, 246, 1)',
    	    'rgba(236, 72, 153, 1)',
    	    'rgba(132, 204, 22, 1)',
    	    'rgba(249, 115, 22, 1)',
    	    'rgba(99, 102, 241, 1)',
    	    'rgba(14, 165, 233, 1)'
    	];

    	
    	$(document).on('click', '.dashboard-box [data-widget="collapse"]', function () {
    	    var box = $(this).closest('.dashboard-box');
    	    var col = box.closest('.dashboard-col');

    	    // aspetta la fine dell'animazione di AdminLTE (default 500ms)
    	    setTimeout(function () {
    	        if (box.hasClass('collapsed-box')) {
    	            col.addClass('col-collapsed');
    	        } else {
    	            col.removeClass('col-collapsed');
    	            $(window).trigger('resize');   // Chart.js ricalcola il canvas
    	        }
    	    }, 500);
    	});
    	
    	
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
    		
    		var coloriTrend = coloriDashboard;
            var bordiTrend = bordiDashboard;

            if (item.descrizione &&
                item.descrizione.toLowerCase().indexOf("certificat") !== -1) {

            	coloriTrend = [
            	    'rgba(96, 165, 250, 0.58)',    // azzurro soft
            	    'rgba(110, 231, 183, 0.58)',   // verde soft
            	    'rgba(253, 224, 71, 0.58)',    // giallo soft
            	    'rgba(251, 146, 60, 0.58)',    // arancio soft
            	    'rgba(251, 113, 133, 0.58)',   // corallo soft
            	    'rgba(196, 181, 253, 0.58)',   // viola soft
            	    'rgba(94, 234, 212, 0.58)'     // teal soft
            	];

            	bordiTrend = [
            	    'rgba(96, 165, 250, 0.90)',
            	    'rgba(110, 231, 183, 0.90)',
            	    'rgba(253, 224, 71, 0.90)',
            	    'rgba(251, 146, 60, 0.90)',
            	    'rgba(251, 113, 133, 0.90)',
            	    'rgba(196, 181, 253, 0.90)',
            	    'rgba(94, 234, 212, 0.90)'
            	];
            }

            newArrColor = coloriTrend;
            newArrColorBorder = bordiTrend;

		


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
				dataset1.borderColor = dataset1.borderColor.concat(newArrColorBorder);
    			
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

     data: [0, 0, 0, 0],

     backgroundColor: [
    	 'rgba(248, 113, 113, 0.68)',    // In lavorazione
         'rgba(245, 158, 11, 0.82)',    // Presso fornitori
         'rgba(16, 185, 129, 0.82)',    // Lavorati in magazzino
         'rgba(6, 182, 212, 0.82)'      // Lavorati in spedizione
     ],

     borderColor: [
    	 'rgba(239, 68, 68, 0.90)', 
         'rgba(245, 158, 11, 0.90)',
         'rgba(16, 185, 129, 0.90)',
         'rgba(6, 182, 212, 0.90)'
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

     maintainAspectRatio:false,
     onResize: function(chart, size) {
         var fs = Math.max(9, Math.min(14, size.height / 25));
         chart.options.legend.labels.fontSize = fs;
         chart.update();
     },

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
 certificatiSE.length,
 certificatiAltro.length
);

//Configurazione iniziale del grafico
var graficoCertificati = {

		labels: ["LAT", "SVT", "RDT", "RDP", "SE", "ALTRO"],

		datasets: [{
		 label: "# Certificati",
		 data: [0, 0, 0, 0, 0, 0],

		 backgroundColor: [
			 'rgba(16, 185, 129, 0.82)',	// LAT
			 'rgba(245, 158, 11, 0.82)',     // SVT
             'rgba(59, 130, 246, 0.82)',    // RDT             
             'rgba(6, 182, 212, 0.82)',// RDP
             'rgba(244, 63, 94, 0.82)',     // SE
             'rgba(148, 163, 184, 0.82)'     // ALTRO
         ],

         borderColor: [
        	 'rgba(16, 185, 129, 1)',        	 
        	  'rgba(245, 158, 11, 1)',
             'rgba(37, 99, 235, 1)',          
             'rgba(6, 182, 212, 1)',
             'rgba(244, 63, 94, 1)',
             'rgba(100, 116, 139, 1)'
         ],

         borderWidth: 2
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
 var altro = certificatiAltro[indiceMese];



 // Totale del mese
var totale = lat + svt + rdt + rdp + se + altro;
 
//Aggiornamento dei numeri visualizzati nel box

 $("#totaleCertificatiMese").text(totale);

 $("#numeroLAT").text(lat);
 $("#numeroSVT").text(svt);
 $("#numeroRDT").text(rdt);
 $("#numeroRDP").text(rdp);
 $("#numeroSE").text(se);
 $("#numeroAltro").text(altro);

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
myChartCertificati.data.datasets[0].data = [lat, svt, rdt, rdp, se, altro];

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


