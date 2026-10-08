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
<c:when test="${userObj.getListaRuoli().size()==1 && (userObj.checkRuolo('F1') || userObj.checkRuolo('F2') || userObj.checkRuolo('F3')) }">
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


<c:if test="${userObj.checkRuolo('F3')}">
    <!-- GRAFICO PARTECIPANTI PER SEDE -->
    <div class="col-sm-6 col-xs-12 graficoSede dashboard-col">
        <div class="box box-primary dashboard-box">

            <div class="box-header with-border">
                <h3 class="box-title">PARTECIPANTI PER SEDE</h3>
                <div class="box-tools pull-right">
                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                        <i class="fa fa-minus"></i>
                    </button>
                    <button type="button" class="btn btn-box-tool" data-widget="remove">
                        <i class="fa fa-times"></i>
                    </button>
                </div>
            </div>

            <div class="box-body">

                <div class="text-center" style="margin-bottom:10px;">
                    <div style="font-size:22px; font-weight:bold;">
                        Totale partecipanti:
                        <span id="totalePartecipanti">0</span>
                    </div>

                    <div style="font-size:12px; margin-top:5px; line-height:22px;">
                        <c:forEach items="${lista_count}" var="sede" varStatus="loop">
                            ${sede.key}: <strong>${sede.value}</strong>
                            <c:if test="${!loop.last}"> &nbsp; | &nbsp; </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div class="chart chart-sede">
                    <div class="chart-sede-small">
                        <canvas id="graficoSede"></canvas>
                    </div>

                    <p id="noDatiSede" class="text-center text-muted" style="display:none;">
                        Nessun partecipante presente
                    </p>
                </div>

            </div>
        </div>
    </div>
    </c:if>
    
    
    <!-- ISTOGRAMMA PARTECIPANTI PER CATEGORIA -->
<div class="col-sm-6 col-xs-12 graficoPartCat dashboard-col">
    <div class="box box-primary dashboard-box">

        <div class="box-header with-border">
            <h3 class="box-title">ISCRIZIONI PER CATEGORIA</h3>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                    <i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div class="box-body">

            <div class="text-center" style="margin-bottom:10px;">
                <div style="font-size:22px; font-weight:bold;">
                    Totale Iscrizioni:
                    <span id="totalePartCat">0</span>
                </div>
            </div>

            <div class="chart chart-partcat">
                <div class="chart-partcat-small">
                    <canvas id="graficoPartCat"></canvas>
                </div>

                <p id="noDatiPartCat" class="text-center text-muted" style="display:none;">
                    Nessun partecipante presente
                </p>
            </div>

        </div>
    </div>
</div>
    
    
    <!-- GRAFICO CORSI PER CATEGORIA -->
<div class="col-sm-6 col-xs-12 graficoCategoria dashboard-col">
    <div class="box box-primary dashboard-box">

        <div class="box-header with-border">
            <h3 class="box-title">CORSI PER CATEGORIA</h3>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                    <i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div class="box-body">

            <div class="text-center" style="margin-bottom:10px;">
                <div style="font-size:22px; font-weight:bold;">
                    Totale corsi:
                    <span id="totaleCorsi">0</span>
                </div>

         
            </div>

            <div class="chart chart-categoria">
                <div class="chart-categoria-small">
                    <canvas id="graficoCategoria"></canvas>
                </div>

                <p id="noDatiCategoria" class="text-center text-muted" style="display:none;">
                    Nessun corso presente
                </p>
            </div>

        </div>
    </div>
</div>

<!-- ISTOGRAMMA PARTECIPANTI PER FASCIA DI ETA' -->
<div class="col-sm-6 col-xs-12 graficoEta dashboard-col">
    <div class="box box-primary dashboard-box">

        <div class="box-header with-border">
            <h3 class="box-title">DIPENDENTI PER FASCIA D'ETÀ</h3>
            <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                    <i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>

        <div class="box-body">

            <div class="text-center" style="margin-bottom:10px;">
                <div style="font-size:22px; font-weight:bold;">
                    Totale Dipendenti:
                    <span id="totalePartEta">0</span>
                </div>
            </div>

            <div class="chart chart-eta">
                <div class="chart-eta-small">
                    <canvas id="graficoEta"></canvas>
                </div>

                <p id="noDatiEta" class="text-center text-muted" style="display:none;">
                    Nessun dipendente presente
                </p>
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

<style>
.dashboard-row { display: flex; flex-wrap: wrap; }
.dashboard-row:before, .dashboard-row:after { display: none; }

.dashboard-col { display: flex; margin-bottom: 15px; }
.dashboard-col.col-collapsed { align-self: flex-start; }

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

.dashboard-box .chart {
    position: relative;
    flex: 1;
    min-height: 260px;
    width: 100%;
}

.chart-sede-small {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
}

.dashboard-box .chart > canvas {
    position: absolute;
    top: 0; left: 0;
}

#noDatiSede {
    position: absolute;
    top: 50%; left: 0; right: 0;
    transform: translateY(-50%);
    margin: 0;
}

@media (max-width: 767px) {
    .dashboard-col { display: block; }
    .dashboard-box .chart { min-height: 280px; }
}

.chart-categoria-small {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
}

#noDatiCategoria {
    position: absolute;
    top: 50%; left: 0; right: 0;
    transform: translateY(-50%);
    margin: 0;
}

.chart-partcat-small {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
}

#noDatiPartCat {
    position: absolute;
    top: 50%; left: 0; right: 0;
    transform: translateY(-50%);
    margin: 0;
}

.chart-eta-small {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
}

#noDatiEta {
    position: absolute;
    top: 50%; left: 0; right: 0;
    transform: translateY(-50%);
    margin: 0;
}
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

var sedeLabels = ${empty sedeLabelsJson ? '[]' : sedeLabelsJson};
var sedeValues = ${empty sedeValuesJson ? '[]' : sedeValuesJson};

var catLabels = ${empty CatJson ? '[]' : CatJson};
var catValues = ${empty CountCorsoJson ? '[]' : CountCorsoJson};

var partCatLabels = ${empty PartecipantiCatJson ? '[]' : PartecipantiCatJson};
var partCatValues = ${empty CountPartecipantiCatJson ? '[]' : CountPartecipantiCatJson};

var etaLabelsRaw = ${empty PartecipantiEtaJson ? '[]' : PartecipantiEtaJson};
var etaValuesRaw = ${empty CountPartecipantiEtaJson ? '[]' : CountPartecipantiEtaJson};

window.addEventListener('pageshow', function (event) {
    if (event.persisted) {
        window.location.reload();
    }
});
$(document).ready(function() {

/* GRAFICO PARTECIPANTI PER SEDE */

var coloriSede = [
    'rgba(99, 102, 241, 0.82)',
    'rgba(34, 211, 238, 0.82)',
    'rgba(52, 211, 153, 0.82)',
    'rgba(251, 191, 36, 0.82)',
    'rgba(251, 113, 133, 0.82)',
    'rgba(167, 139, 250, 0.82)',
    'rgba(45, 212, 191, 0.82)',
    'rgba(96, 165, 250, 0.82)',
    'rgba(244, 114, 182, 0.82)',
    'rgba(163, 230, 53, 0.82)',
    'rgba(251, 146, 60, 0.82)',
    'rgba(129, 140, 248, 0.82)',
    'rgba(56, 189, 248, 0.82)'
];

var bordiSede = [
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

// Un colore per ogni sede (la palette si ripete se le sedi sono più di 13)
var backgroundSede = [];
var borderSede = [];
for (var i = 0; i < sedeLabels.length; i++) {
    backgroundSede.push(coloriSede[i % coloriSede.length]);
    borderSede.push(bordiSede[i % bordiSede.length]);
}

var graficoSede = {
    labels: sedeLabels,
    datasets: [{
        label: "# Partecipanti",
        data: sedeValues,
        backgroundColor: backgroundSede,
        borderColor: borderSede,
        borderWidth: 2
    }]
};



var canvasSede = document.getElementById("graficoSede");

if (canvasSede != null) {
    var ctxSede = canvasSede.getContext("2d");

var myChartSede = new Chart(ctxSede, {
    type: "pie",
    data: graficoSede,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: { duration: 800 },
        legend: {
            display: true,
            position: 'bottom'
        },
        tooltips: {
            callbacks: {
                label: function(tooltipItem, data) {

                    var value = data.datasets[0].data[tooltipItem.index];
                    var label = data.labels[tooltipItem.index];

                    var totale = data.datasets[0].data.reduce(function(a, b) {
                        return a + b;
                    }, 0);

                    var percentage = totale > 0 ? value / totale * 100 : 0;

                    return label + ': ' + value + ' - ' + percentage.toFixed(2) + '%';
                }
            }
        }
    }
});
}


/* ISTOGRAMMA CORSI PER CATEGORIA */

var backgroundCat = [];
var borderCat = [];
for (var j = 0; j < catLabels.length; j++) {
    backgroundCat.push(coloriSede[j % coloriSede.length]);
    borderCat.push(bordiSede[j % bordiSede.length]);
}

var ctxCat = document.getElementById("graficoCategoria").getContext("2d");

var myChartCat = new Chart(ctxCat, {
    type: "bar",
    data: {
        labels: catLabels,   // nomi completi: servono al tooltip
        datasets: [{
            label: "# Corsi",
            data: catValues,
            backgroundColor: backgroundCat,
            borderColor: borderCat,
            borderWidth: 2
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: { duration: 800 },
        legend: { display: false },
        scales: {
            xAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Categoria'
                },
                gridLines: { display: false },
                ticks: {
                    autoSkip: false,
                    maxRotation: 45,
                    minRotation: 0,
                    // Etichetta abbreviata sull'asse
                    callback: function(value) {
                        return abbreviaTesto(value, 12);
                    }
                }
            }],
            yAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Numero corsi'
                },
                ticks: {
                    beginAtZero: true,
                    callback: function(value) {
                        if (Number.isInteger(value)) { return value; }
                    }
                }
            }]
        },
        tooltips: {
            callbacks: {
                // Titolo: nome completo della categoria
                title: function(tooltipItems, data) {
                    return data.labels[tooltipItems[0].index];
                },
                label: function(tooltipItem, data) {
                    return data.datasets[0].label + ': ' + tooltipItem.yLabel;
                }
            }
        }
    }
});

/* ISTOGRAMMA PARTECIPANTI PER CATEGORIA */

var backgroundPartCat = [];
var borderPartCat = [];
for (var k = 0; k < partCatLabels.length; k++) {
    backgroundPartCat.push(coloriSede[k % coloriSede.length]);
    borderPartCat.push(bordiSede[k % bordiSede.length]);
}

var ctxPartCat = document.getElementById("graficoPartCat").getContext("2d");

var myChartPartCat = new Chart(ctxPartCat, {
    type: "bar",
    data: {
        labels: partCatLabels,   // nomi completi: servono al tooltip
        datasets: [{
            label: "# Iscrizioni",
            data: partCatValues,
            backgroundColor: backgroundPartCat,
            borderColor: borderPartCat,
            borderWidth: 2
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        animation: { duration: 800 },
        legend: { display: false },
        scales: {
            xAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Categoria'
                },
                gridLines: { display: false },
                ticks: {
                    autoSkip: false,
                    maxRotation: 45,
                    minRotation: 0,
                    // Etichetta abbreviata sull'asse
                    callback: function(value) {
                        return abbreviaTesto(value, 12);
                    }
                }
            }],
            yAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Numero iscrizioni'
                },
                ticks: {
                    beginAtZero: true,
                    callback: function(value) {
                        if (Number.isInteger(value)) { return value; }
                    }
                }
            }]
        },
        tooltips: {
            callbacks: {
                // Titolo del tooltip: nome completo della categoria
                title: function(tooltipItems, data) {
                    return data.labels[tooltipItems[0].index];
                },
                label: function(tooltipItem, data) {
                    return data.datasets[0].label + ': ' + tooltipItem.yLabel;
                }
            }
        }
    }
});

/* ISTOGRAMMA PARTECIPANTI PER FASCIA D'ETA' */

//Chiave di ordinamento: "< 25" va per prima, poi in base al primo numero
//("25-34", "35-44", "55+", ...). Etichette senza numeri (es. "N/D") in fondo.
function chiaveFasciaEta(label) {
 var s = String(label);
 if (s.indexOf('<') === 0) { return -1; }
 var m = s.match(/\d+/);
 return m ? parseInt(m[0], 10) : Number.MAX_VALUE;
}

//Riordino le coppie (fascia, conteggio) mantenendole allineate
var etaCoppie = [];
for (var e = 0; e < etaLabelsRaw.length; e++) {
 etaCoppie.push({ label: etaLabelsRaw[e], value: etaValuesRaw[e] });
}
etaCoppie.sort(function(a, b) {
 return chiaveFasciaEta(a.label) - chiaveFasciaEta(b.label);
});

var etaLabels = etaCoppie.map(function(c) { return c.label; });
var etaValues = etaCoppie.map(function(c) { return c.value; });

var backgroundEta = [];
var borderEta = [];
for (var h = 0; h < etaLabels.length; h++) {
    backgroundEta.push(coloriSede[h % coloriSede.length]);
    borderEta.push(bordiSede[h % bordiSede.length]);
}

var ctxEta = document.getElementById("graficoEta").getContext("2d");

var myChartEta = new Chart(ctxEta, {
 type: "bar",
 data: {
     labels: etaLabels,
     datasets: [{
    	    label: "# Dipendenti",
    	    data: etaValues,
    	    backgroundColor: backgroundEta,   // prima: 'rgba(99, 102, 241, 0.82)'
    	    borderColor: borderEta,           // prima: 'rgba(79, 70, 229, 1)'
    	    borderWidth: 2
    	}]
 },
 options: {
     responsive: true,
     maintainAspectRatio: false,
     animation: { duration: 800 },
     legend: { display: false },
     scales: {
         xAxes: [{
             scaleLabel: {
                 display: true,
                 labelString: 'Fascia d\'età'
             },
             gridLines: { display: false }
         }],
         yAxes: [{
             scaleLabel: {
                 display: true,
                 labelString: 'Numero dipendenti'
             },
             ticks: {
                 beginAtZero: true,
                 callback: function(value) {
                     if (Number.isInteger(value)) { return value; }
                 }
             }
         }]
     },
     tooltips: {
         callbacks: {
             title: function(tooltipItems, data) {
                 return 'Età: ' + data.labels[tooltipItems[0].index];
             },
             label: function(tooltipItem, data) {
                 return data.datasets[0].label + ': ' + tooltipItem.yLabel;
             }
         }
     }
 }
});

//Abbrevia il testo oltre maxLen caratteri, aggiungendo i puntini
function abbreviaTesto(testo, maxLen) {
    if (testo == null) { return ''; }
    testo = String(testo);
    return testo.length > maxLen ? testo.substring(0, maxLen - 1).trim() + '...' : testo;
}


function aggiornaGraficoEta() {

 var totale = 0;
 for (var i = 0; i < etaValues.length; i++) {
     totale += etaValues[i];
 }

 $("#totalePartEta").text(totale);

 if (totale > 0) {
     $("#noDatiEta").hide();
     $("#graficoEta").css("visibility", "visible");
     myChartEta.update();
 } else {
     $("#graficoEta").css("visibility", "hidden");
     $("#noDatiEta").show();
 }
}




function aggiornaGraficoPartCat() {

    var totale = 0;
    for (var i = 0; i < partCatValues.length; i++) {
        totale += partCatValues[i];
    }

    $("#totalePartCat").text(totale);

    if (totale > 0) {
        $("#noDatiPartCat").hide();
        $("#graficoPartCat").css("visibility", "visible");
        myChartPartCat.update();
    } else {
        $("#graficoPartCat").css("visibility", "hidden");
        $("#noDatiPartCat").show();
    }
}


function aggiornaGraficoCategoria() {

 var totale = 0;
 for (var i = 0; i < catValues.length; i++) {
     totale += catValues[i];
 }

 $("#totaleCorsi").text(totale);

 if (totale > 0) {
     $("#noDatiCategoria").hide();
     $("#graficoCategoria").css("visibility", "visible");
     myChartCat.update();
 } else {
     $("#graficoCategoria").css("visibility", "hidden");
     $("#noDatiCategoria").show();
 }
}



function aggiornaGraficoSede() {

	  if (typeof myChartSede === 'undefined' || !myChartSede) { return; } // F2: grafico assente

    var totale = 0;
    for (var i = 0; i < sedeValues.length; i++) {
        totale += sedeValues[i];
    }

    $("#totalePartecipanti").text(totale);

    if (totale > 0) {
        $("#noDatiSede").hide();
        $("#graficoSede").css("visibility", "visible");
        myChartSede.update();
    } else {
        $("#graficoSede").css("visibility", "hidden");
        $("#noDatiSede").show();
    }
}

// Inizializzazione del grafico delle sedi
aggiornaGraficoSede();

aggiornaGraficoCategoria();

aggiornaGraficoPartCat();

aggiornaGraficoEta();


});


</script>
</jsp:attribute> 
</t:layout>


