
</html>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
 <t:main-header />
  <t:main-sidebar />



  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Pacchi in attesa di lavorazione
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
               <div class="box">
          <div class="box-header">
   	 <%-- <c:if test="${userObj.checkPermesso('CAMPIONI_COMPANY_METROLOGIA')}"> 	 
          <button class="btn btn-info" onclick="callAction('listaCampioni.do?p=mCMP');">I miei Campioni</button>
                  </c:if>
          <button class="btn btn-info" onclick="callAction('listaCampioni.do');">Tutti i Campioni</button> --%>
         
          </div>
            <div class="box-body">

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
			            <table id="tabPacchi" class="table table-hover " role="grid" width="100%">
						 <thead><tr class="active">
						 <th>Pacco Origine</th>						
						 <th>Cliente</th>
						  <th>Commessa</th>
						  <th>Data Commessa</th>
						  <th>Data Arrivo</th>
						  <th>Data Creazione</th>
						  <th>Diff.</th>
						 
						  <th>Utente</th>
						  <th>Urgente</th>
						   <th>Note</th>
						<%--  <td></td> --%>
						 						 
						 </tr>
						 </thead>
						 
						 <tbody >
						 
						  <c:forEach items="${lista_pacchi_grafico}" var="origine" varStatus="loop">
                            <c:set var="splitted" value="${origine.split(';')}"/>
  							<c:if test="${splitted[7] == '0' && splitted[9] == '1'}">
  							<tr style="position:relative;background-color:#F98989">
  							</c:if>
                            <c:if test="${splitted[7] == '1'}">
                            <tr style="position:relative;background-color:#F3F5A3">
                           </c:if>
                            <c:if test="${splitted[7] == '2'}">
                            <tr style="position:relative;background-color:#B1CE7B">
                           </c:if>
                           <c:if test="${splitted[7] == '0' && splitted[9] == '0'}">
                            <tr style="position:relative">
                           </c:if>
                            
                               <td  id="${splitted[0]}_1" style="position:relative"><a href="gestionePacco.do?action=dettaglio&id_pacco=${utl:encryptData(splitted[0].split('_')[1])})" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" >${splitted[0]}</a></td>
                               <td  id="${splitted[0]}_2" style="position:relative">${splitted[1]}</td>
                               <td  id="${splitted[0]}_3" style="position:relative"><a href="gestioneIntervento.do?idCommessa=${utl:encryptData(splitted[2])}" class="btn customTooltip customlink" title="Click per aprire il dettaglio della Commessa" >${splitted[2]}</a></td>
                               <td  id="${splitted[0]}_4" style="position:relative">${splitted[3]}</td>
                               <td  id="${splitted[0]}_5" style="position:relative">${splitted[4]}</td>
                               <td  id="${splitted[0]}_6" style="position:relative">${splitted[5]}</td>
                               <td  id="${splitted[0]}_7" style="position:relative">${splitted[6]}</td>
                               <td  id="${splitted[0]}_8" style="position:relative">${splitted[8]}</td>
                               <td  id="${splitted[0]}_9" style="position:relative">
                                <c:if test="${splitted[9] == '0'}">
                               NO
                               </c:if>
                               <c:if test="${splitted[9] == '1'}">
                               SI
                               </c:if>
                               
                               </td>
                               <td  id="${splitted[0]}_10" style="position:relative">${splitted[10]}</td>
              
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
</div>
</section>




</div>


 <ul class='custom-menu'><label>Seleziona stato</label>
    <li data-action = "da_fare">Da Fare</li>
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
	<link type="text/css" href="css/bootstrap.min.css" />
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


.dataTables_wrapper .dataTables_scrollHead th.sorting:before,
.dataTables_wrapper .dataTables_scrollHead th.sorting:after,
.dataTables_wrapper .dataTables_scrollHead th.sorting_asc:before,
.dataTables_wrapper .dataTables_scrollHead th.sorting_asc:after,
.dataTables_wrapper .dataTables_scrollHead th.sorting_desc:before,
.dataTables_wrapper .dataTables_scrollHead th.sorting_desc:after {
    display: none;
}

</style>




</jsp:attribute>

  
<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">



$("#tabPacchi th").on("click", function(e){
	if (tab.settings()[0]._bInitComplete) {
        tab.settings()[0].oFeatures.bSort = false;
        $('.dataTables_wrapper .dataTables_scrollHead th').removeClass('sorting sorting_asc sorting_desc');
    }
	e.preventDefault()
	
});

function dettaglioPaccoFromOrigine(origine){
	
	var id = origine.split("_")
	dettaglioPacco(id[1]);
	
}



$(document).ready(function() {
	
	let initialOrderExecuted = false;
	   $.fn.dataTable.ext.order['priorita-si'] = function(settings, col) {
		    return this.api().column(col, { order: 'index' }).nodes().map(function(td, i) {
		        return $(td).text().trim() === 'SI' ? 0 : 1;  // 'SI' ha la priorità
		    });
		};
		
/* 	    $.fn.dataTable.ext.type.order['num-custom-pre'] = function(data) {
	        return parseFloat(data.replace(/[^0-9.-]/g, '')) || 0;
	    }; */
 

     $('.dropdown-toggle').dropdown();
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
         
   
         "stripeClasses": [],
         pageLength: 5,
        
 	      paging: false, 
 	      ordering: false,
 	      info: true, 

 	      searchable: true,  
 	      targets: 0,
 	      responsive: false,
 	      scrollX: true,
 	      scrollY: "700px",
 	      stateSave: false,
 	      searching: true, 
 	      columnDefs: [
 	         
 	          //{ type: 'num', targets: 6 }, 
 	          { orderDataType: 'priorita-si', targets: 8}
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
 tab.columns.adjust().draw();  
 	 $('#tabPacchi_wrapper .col-sm-6:eq(0)').append('<div class="legend"> <div class="legend-item"> <div class="legend-color" style="background-color:#FFFBFB;border: 1px solid #313131"></div> <div class="legend-label">DA FARE</div> </div><div class="legend-item"> <div class="legend-color" style="background-color:#F3F5A3;"></div> <div class="legend-label">IN CORSO</div> </div> <div class="legend-item"> <div class="legend-color" style="background-color:#B1CE7B;"></div> <div class="legend-label">COMPLETATO</div> </div><div class="legend-item"> <div class="legend-color" style="background-color:#F98989;"></div> <div class="legend-label">URGENTE</div> </div></div>');

 $('#tabPacchi').on( 'page.dt', function () {
 	$('.customTooltip').tooltipster({
      theme: 'tooltipster-light'
  }); 
 	
 	$('.removeDefault').each(function() {
 	   $(this).removeClass('btn-default');
 	})  

 	
 	 $('#tabPacchi tr').removeClass('odd even');
 	 $('#tabPacchi tr').css('background-color', 'white');

 	
 	
 });

// tab.order( [8, 'asc']).draw();

riorganizzaColonna8(tab)
 initContextMenu();

 


});


function riorganizzaColonna8(table) {


	  var rows = table.rows().nodes();

      // Converte le righe in un array per il riordino
      var sortedRows = Array.from(rows).sort(function (rowA, rowB) {
          var colA = $(rowA).find('td:eq(8)').text().trim(); // Colonna 8 (indice 4)
          var colB = $(rowB).find('td:eq(8)').text().trim();
          return colB.localeCompare(colA); // "SI" prima di "NO"
      });

      // Appendi le righe riordinate direttamente al corpo della tabella
      $.each(sortedRows, function (index, row) {
          $('#tabPacchi tbody').append(row);
      });
}


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
	    case 'da_fare':
                  
            updateStato(cellIndex.split("_")[0]+"_"+cellIndex.split("_")[1], 0);                     
                 
         break;
	         
	         
	     case 'in_corso':
          
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
	   
	   //callAction("login.do");
	   
   }else{
	   
	   
	   
   }

})

   

	 
}


 
 
 
  </script>
  
</jsp:attribute> 
</t:layout>

