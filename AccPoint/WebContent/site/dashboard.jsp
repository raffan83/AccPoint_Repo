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
			<div class="row">
			   <c:forEach items="${tipoTrend}" var="val" varStatus="loop">

 				<div class="col-sm-6 col-xs-12 grafico1" id="box_${val.id}_${val.descrizione}">
					
					
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title"></h3>
			
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                 <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> 
			              </div>
			            </div>
			            <div class="box-body">
			              <div class="chart">
			                <canvas id="${val.id}_${val.descrizione}"></canvas>
			              </div>
			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>
				
				</c:forEach>
				
				<div class="col-sm-6 col-xs-12 ">	
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">Bacheca Messaggi</h3>
		
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
			              </div>
			            </div>
			            <div class="box-body">
		 				<div class="table-responsive mailbox-messages">
			            <table id="tabBacheca" class="table table-hover table-striped" role="grid" width="100%">
						 <thead><tr class="active">
						 <th>Mittente</th>						
						 <th>Oggetto</th>
						  <th>Data</th>
						<%--  <td></td> --%>
						 						 
						 </tr>
						 </thead>
						 
						 <tbody id="tbodyitem">
						 
						 <c:forEach items="${lista_messaggi}" var="messaggio" varStatus="loop">
							<tr>
							<c:choose>
							<c:when test="${messaggio.letto_da_me==1}">
								<td>${messaggio.utente.nominativo }</td>
								<td><a href=# class="mailbox-name" onClick="dettaglioMessaggio('${messaggio.id}','${messaggio.letto_da_me }')"> ${messaggio.titolo} </a></td>
								<td><fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${messaggio.data }" /></td>
							</c:when>
							<c:otherwise>
								<td style="color:red;font-weight: bold;">${messaggio.utente.nominativo }</td>
								<td style="color:red;font-weight: bold;"><a href=# class="mailbox-name" style="color:red" onClick="dettaglioMessaggio('${messaggio.id}','${messaggio.letto_da_me }')">${messaggio.titolo}</a></td>
								<td style="color:red;font-weight: bold;"><fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${messaggio.data }" /></td>
							</c:otherwise>
							</c:choose>
							
							</tr>	
						  
						  </c:forEach>
						
						</tbody>
						 </table>
   </div>
   
   
      <div id="myModalMessaggio" class="modal" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
     
     
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Dettaglio messaggio </h4>
        
      </div>
    
       <div class="modal-body" id="messaggio_body">
       	
       
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
	

       
      </div>
    </div>
  </div>
</div>

			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>

	
	
		<div class="col-sm-12 col-xs-12 ">	
					<div class="box box-primary">
			            <div class="box-header with-border">
			              <h3 class="box-title">Pacchi in attesa di lavorazione</h3>
		
			              <div class="box-tools pull-right">
			                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
			                </button>
			                <!-- <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button> -->
			              </div>
			            </div>
			            <div class="box-body">
		 				<div class="table-responsive mailbox-messages">
			            <table id="tabPacchi" class="table table-hover table-striped" role="grid" width="100%">
						 <thead><tr class="active">
						 <th>Pacco Origine</th>						
						 <th>Cliente</th>
						  <th>Commessa</th>
						  <th>Data Commessa</th>
						  <th>Data Arrivo</th>
						  <th>Data Creazione</th>
						  <th>Diff.</th>
						 
						  <th>Utente</th>
						   <th>Note</th>
						<%--  <td></td> --%>
						 						 
						 </tr>
						 </thead>
						 
						 <tbody >
						 
						  <c:forEach items="${lista_pacchi_grafico}" var="origine" varStatus="loop">
                            <c:set var="splitted" value="${origine.split(';')}"/>
                          <%--   <c:if test="${fn:length(splitted)>9}">
                            <c:if test="${splitted[7] == 0}">
                            <tr style="position:relative" style="background-color:#F3F5A3">
                           </c:if>
                            <c:if test="${splitted[7] == 1}">
                            <tr style="position:relative" style="background-color:#B1CE7B">
                           </c:if>
                            </c:if>
                              <c:if test="${fn:length(splitted)<=9}">
                            <tr style="position:relative">
                            </c:if> --%>
                            <c:if test="${splitted[7] == '1'}">
                            <tr style="position:relative;background-color:#F3F5A3">
                           </c:if>
                            <c:if test="${splitted[7] == '2'}">
                            <tr style="position:relative;background-color:#B1CE7B">
                           </c:if>
                           <c:if test="${splitted[7] == '0'}">
                            <tr style="position:relative">
                           </c:if>
                           
                               <td  id="${splitted[0]}_1" style="position:relative">${splitted[0]}</td>
                               <td  id="${splitted[0]}_2" style="position:relative">${splitted[1]}</td>
                               <td  id="${splitted[0]}_3" style="position:relative">${splitted[2]}</td>
                               <td  id="${splitted[0]}_4" style="position:relative">${splitted[3]}</td>
                               <td  id="${splitted[0]}_5" style="position:relative">${splitted[4]}</td>
                               <td  id="${splitted[0]}_6" style="position:relative">${splitted[5]}</td>
                               <td  id="${splitted[0]}_7" style="position:relative">${splitted[6]}</td>
                               <td  id="${splitted[0]}_8" style="position:relative">${splitted[8]}</td>
                               <td  id="${splitted[0]}_9" style="position:relative">${splitted[9]}</td>
              
                            </tr>
                        </c:forEach>
						 
						<%--  <c:forEach items="${lista_pacchi_grafico}" var="origine" varStatus="loop">
							   <tr>
                    <td>${fn:split(origine, ";")[0]}</td>
                    <td>${fn:split(origine, ";")[1]}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 2 ? fn:split(origine, ";")[2] : ""}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 3 ? fn:split(origine, ";")[3] : ""}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 4 ? fn:split(origine, ";")[4] : ""}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 5 ? fn:split(origine, ";")[5] : ""}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 6 ? fn:split(origine, ";")[6] : ""}</td>
                    <td>${fn:length(fn:split(origine, ";")) > 7 ? fn:split(origine, ";")[7] : ""}</td>
                </tr>
						  
						  </c:forEach>
						 --%>
						</tbody>
						 </table>
   </div>


			            </div>
			            <!-- /.box-body -->
			          </div>
				</div>
				
				
				
				
				
				
				
				
			</div>
		
		</section>
		
     
     
     </c:if>
  </div>
  <!-- /.content-wrapper -->


    <ul class='custom-menu'><label>Seleziona stato</label>
  <li data-action = "in_corso">In Corso</li>
  <li data-action = "completato">Completato</li>
</ul>
	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">



<c:if test="${userObj.checkRuolo('F1')|| userObj.checkRuolo('F2') }">

<style>


.table th {
    background-color: #3c8dbc !important;
  }</style>

</c:if>


<style>

.custom-menu {
    display: none;
    z-index: 1000;
    position: absolute;
    overflow: hidden;
    white-space: nowrap;
    font-family: sans-serif;     
    border-radius: 5px;
    background-color: #f9f9f9;
    border: 1px solid #ccc;
    padding: 5px;
    border-radius: 4px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    
}

.custom-menu li {
    padding: 8px 12px;
    cursor: pointer;
}

.custom-menu li:hover {
    background-color: #DEF;
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

    	 
   
   
   
	tab = $('#tabPacchi').DataTable({
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
        
  
    	
        pageLength: 5,
         "order": [ 6, "asc" ],  
	      paging: false, 
	      ordering: true,
	      info: true, 

	      searchable: true,  
	      targets: 0,
	      responsive: false,
	      scrollX: true,
	      scrollY: "220px",
	      stateSave: true,
	      searching: true, 
	      columnDefs: [
	         
	          { type: 'num', targets: 6 }  // Assuming the second column "oggetto" contains numeric values
	      ],

        buttons: [  
 	    	 {
   	            extend: 'excel',
   	            text: 'Esporta Excel'  	                   
  			  },
 	          {
 	            extend: 'colvis',
 	            text: 'Nascondi Colonne'  	                   
			  } ]
	               



	    });
	
	   $('.inputsearchtable').on('click', function(e){
	       e.stopPropagation();    
	    }); 
	   
		tab.buttons().container().appendTo( '#tabPacchi_wrapper .col-sm-6:eq(1)');


// Apply the search
tab.columns().eq( 0 ).each( function ( colIdx ) {
$( 'input', tab.column( colIdx ).header() ).on( 'keyup', function () {
	tab
       .column( colIdx )
       .search( this.value )
       .draw();
} );
} ); 
	table.columns.adjust().draw();  
	 $('#tabPacchi_wrapper .col-sm-6:eq(0)').append('<div class="legend"> <div class="legend-item"> <div class="legend-color" style="background-color:#F3F5A3;"></div> <div class="legend-label">IN CORSO</div> </div> <div class="legend-item"> <div class="legend-color" style="background-color:#B1CE7B;"></div> <div class="legend-label">COMPLETATO</div> </div></div>');

$('#tabPacchi').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
     theme: 'tooltipster-light'
 }); 
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})  

	
	
	

});


initContextMenu();
    	
    	
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
});

/*     $('#tabPacchi tbody td').on('contextmenu',  function(e) {
    
    	    e.preventDefault(); // Prevent default context menu
    

    	});  */
	
    	var cellIndex;
    function initContextMenu(){
    	
    	$("#tabPacchi tbody td").bind("contextmenu", function (event) {
    		
    	     
    	     // Avoid the real one
    	     event.preventDefault();

    	     var cell = $("#"+event.currentTarget.id).offset();
    	     cellIndex = event.currentTarget.id

    	 	 var x  = cell.left ;
    	 	var y  = cell.top; 

    	     

    	     // Show contextmenu
    	     $(".custom-menu").finish().toggle(). 
    	     css({
    	         top: y + "px",
    	         left: x + "px"
    	     });
    	     
    	     
    	     //alert("X:"+(x-240) +"Y:"+ (y-280))
    	 });


    	 // If the document is clicked somewhere
    	 $(document).bind("mousedown", function (e) {
    	     
    	     // If the clicked element is not the menu
    	     if (!$(e.target).parents(".custom-menu").length > 0) {
    	         
    	         // Hide it
    	         $(".custom-menu").hide(100);
    	     }
    	 });


    	 // If the menu element is clicked
    	 $(".custom-menu li").click(function(e){
    	     

    		 
    	     // This is the triggered action name
    	     switch($(this).attr("data-action")) {
    	         
    	         // A case for each action. Your actions here
    	     case 'in_corso':
                 // Implement copy functionality
                 
                 
                 updateStato(cellIndex.split("_")[0]+"_"+cellIndex.split("_")[1], 1);
                 
                 
                 break;
             case 'completato':
                 
             		
             		updateStato(cellIndex.split("_")[0]+"_"+cellIndex.split("_")[1], 2);
                          	
                
                 break;
    	     }
    	   
    	     // Hide it AFTER the action was triggered
    	     $(".custom-menu").hide(100);
    	   });




    	  
    	
    }
    	 
    	 
    	 
    	 
   function updateStato(origine, stato){
	   
   dataObj ={};
   dataObj.origine = origine;
   dataObj.stato = stato;
   
   callAjax(dataObj, "gestionePacco.do?action=update_dashboard", function(datab, status){
	
	   if(datab.success){
		   
		   location.reload()
		   
	   }else{
		   
		   
		   
	   }
   
   })
   
	   
   
    	 
   }
    	 
    	 
    	 
    	 
    	 
    	 
    	 
    	 
</script>
</jsp:attribute> 
</t:layout>


