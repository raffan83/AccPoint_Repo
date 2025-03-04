<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
        Dettaglio Commessa
        <small></small>
      </h1>
         
        <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
      
      
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
            <div class="row">
<div class="col-xs-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Commessa
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
        <ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                  <b>ID</b> <a class="pull-right">${commessa.ID_COMMESSA}</a>
                </li>
                <li class="list-group-item">
                  <b>Data Commessa</b> <a class="pull-right"><fmt:formatDate pattern="dd/MM/yyyy" value="${commessa.DT_COMMESSA}" /></a>
                </li>
                <li class="list-group-item">
                 <div class="row">
                     <div class="col-xs-12"> 
                  <b>Cliente</b> <a class="pull-right">${commessa.ID_ANAGEN_NOME}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                 <div class="row">
                     <div class="col-xs-12"> 
                  <b>Indirizzo Cliente</b> <a class="pull-right">${commessa.INDIRIZZO_PRINCIPALE}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                 <div class="row">
                     <div class="col-xs-12"> 
                  <b>Sede</b> <a class="pull-right">${commessa.ANAGEN_INDR_DESCR} ${commessa.ANAGEN_INDR_INDIRIZZO}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <b>Stato</b> <a class="pull-right">
				 <c:choose>
  <c:when test="${commessa.SYS_STATO == '1CHIUSA'}">
    <span class="label label-danger">CHIUSA</span>
  </c:when>
  <c:when test="${commessa.SYS_STATO == '1APERTA'}">
    <span class="label label-success">APERTA</span>
  </c:when>
  <c:when test="${commessa.SYS_STATO == '0CREATA'}">
    <span class="label label-warning">CREATA</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose>  </a>
                </li>
                <li class="list-group-item">
                  <b>Note:</b> <spanclass="pull-right">${commessa.NOTE_GEN}</span>
                </li>
                <li class="list-group-item">
                 <b>Responsabile Commessa:</b> <a class="pull-right">${commessa.RESPONSABILE}</a>
                </li> 
        </ul>

</div>
</div>
</div>

<div class="col-xs-6">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dati Utilizzatore
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body" id="body_map" style="height:369px">
       		<ul class="list-group list-group-unbordered">
                <li class="list-group-item">
                 <div class="row">
                     <div class="col-xs-12"> 
                  <b>Cliente Utilizzatore</b> <a class="pull-right">${commessa.NOME_UTILIZZATORE}</a>
                  </div>
                  </div>
                </li>
                <li class="list-group-item">
                 <div class="row">
                     <div class="col-xs-12"> 
                  <b>Indirizzo Utilizzatore</b> <a class="pull-right">${commessa.INDIRIZZO_UTILIZZATORE}</a>
                  </div>
                  </div>
                </li>
                </ul>
 
         
                <!--      <b class="">${commessa.NOME_UTILIZZATORE} - </b><a class=""> ${commessa.INDIRIZZO_UTILIZZATORE}</a> -->
               
                
		
	 <div class="map" id="map" ></div> 
</div>
</div>
</div>

</div>
             <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid collapsed-box">
<div class="box-header with-border">
	 Lista Attivit&agrave;
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-plus"></i></button>

	</div>
</div>
<div class="box-body">

              <table id="tabAttivita" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>Descrizione Attivita</th>
 <th>Note</th>
<%--  <th>Descrizione Articolo</th> --%>
<th>UM</th>
 <th>Quantit&agrave;</th>

 </tr></thead>
 
 <tbody>
<%--   <c:forEach items="${listaPacco}" var="pacco">
  ${pacco.item.id }
  </c:forEach> --%>
 <c:forEach items="${commessa.listaAttivita}" var="attivita">
 
 <tr role="row">

	<td>
  ${attivita.descrizioneAttivita}
	</td>
		<td>
  ${attivita.noteAttivita}
	</td>	
<%-- 	<td>
  ${attivita.descrizioneArticolo}
	</td>	 --%>
	<td>${attivita.unitaMisura }</td>
	<td>
  ${attivita.quantita}
	</td>
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>       
            
            
            
              <div class="row">
        <div class="col-xs-12">
<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Interventi Verificazione
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">

              <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 
 <th>ID</th>
 <th>Presso</th>
 <th>Sede</th>
 <th>Data Creazione</th>
 <th>Stato</th>
 <th>Company</th>
 <th>Responsabile</th>
 <th>Nome Pack</th>
 <td></td>
 </tr></thead>
 
 <tbody>
 <c:forEach items="${listaInterventi}" var="intervento" varStatus="loop">
 
 <tr role="row" id="${intervento.id}">

	<td>
	
	<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')">
		${intervento.id}
	</a>
	</td>
		<td class="centered">
		<c:choose>
  <c:when test="${intervento.in_sede_cliente == 0}">
		<span class="label label-success">IN SEDE</span>
  </c:when>
  <c:when test="${intervento.in_sede_cliente == 1}">
		<span class="label label-info">PRESSO CLIENTE</span>
  </c:when>
   <c:when test="${intervento.in_sede_cliente == 2}">
		<span class="label label-warning">ALTRO LUOGO</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose> 
	</td>
	<td>
	<c:if test="${intervento.nome_sede != null && intervento.nome_sede!=''}">
	${intervento.nome_sede}
	</c:if>
	
	<c:if test="${intervento.nome_sede == null || intervento.nome_sede==''}">
	${commessa.INDIRIZZO_PRINCIPALE}
	</c:if>
	</td>
	<td>
	<c:if test="${not empty intervento.data_creazione}">
	<fmt:setLocale value="it_IT" />
   <fmt:formatDate pattern="dd/MM/yyyy" 
         value="${intervento.data_creazione}" />
	</c:if>
	</td>
	<td class="centered">
	<c:if test="${intervento.id_stato_intervento == 0}">
						<%-- <a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-info">${intervento.statoIntervento.descrizione}</span></a> --%>
						<a href="#" class="customTooltip" title="Click per chiudere l'Intervento"  onClick="chiudiVerIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-success">APERTO</span></a>
						
					</c:if>
					
					<c:if test="${intervento.id_stato_intervento == 1}">
						<a href="#" class="customTooltip" title="Click per aprire l'Intervento"  onClick="apriVerIntervento('${utl:encryptData(intervento.id)}',0,0)" id="statoa_${intervento.id}"> <span class="label label-warning">CHIUSO</span></a>
						
					</c:if>

	</td>
	<td>${intervento.company.denominazione }</td>
		<td>${intervento.user_creation.nominativo}</td>
		<td>${intervento.nome_pack}</td>
		<td>
			<a class="btn customTooltip" title="Click per aprire il dettaglio dell'Intervento" onclick="callAction('gestioneVerIntervento.do?action=dettaglio&id_intervento=${utl:encryptData(intervento.id)}')">
                <i class="fa fa-arrow-right"></i>
            </a>
        </td>
	</tr>
 
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
 </div>
</div>




 

<!--   <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="modalErrorDiv">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
    </div>
  </div>
</div> -->
 
  

     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">

 <!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDssNibshh7Dy58qH70-1ooKXu5z9Ybk-o&region=IT"></script> -->
 <!-- <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCuBQxPwqQMTjowOqSX4z-7wZtgZDXNaVI&sensor=false"></script> -->
 <!-- <script src="http://www.openlayers.org/api/OpenLayers.js"></script>  -->
 <script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.1.1/build/ol.js"></script>
 
<!-- <script src="plugins/jbdemonte-gmap3/dist/gmap3.min.js"></script> -->
 
 <script type="text/javascript">
 
 	var columsDatatables = [];
 
	$("#tabPM").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabPM thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	        var title = $('#tabPM thead th').eq( $(this).index() ).text();
	        $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    } );

	} );
	
	var columsDatatables2 = [];
	  
	$("#tabAttivita").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables2 = state.columns;
	}
	    $('#tabAttivita thead th').each( function () {
	     	if(columsDatatables2.length==0 || columsDatatables2[$(this).index()]==null ){columsDatatables2.push({search:{search:""}});}
	    	  var title = $('#tabAttivita thead th').eq( $(this).index() ).text();
	    	  $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text"   value="'+columsDatatables2[$(this).index()].search.search+'"/></div>');
	    	} );

	} );
	
	
	function mapping(lat, lon){
		
		var iconFeature = new ol.Feature({
			  geometry: new ol.geom.Point(ol.proj.fromLonLat([lon, lat])),
			  name: 'Null Island',
			  population: 4000,
			  rainfall: 500
			});
		
		var iconStyle = new ol.style.Style({
			  image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
			    anchor: [0.5, 0.96],			 
			    scale: 0.03,
			    anchorXUnits: 'fraction',
			    anchorYUnits: 'fraction',
			    opacity: 0.8,
			    src: 'images/marker.png'			  
			  }))
			});
	
		iconFeature.setStyle(iconStyle);
		
		var vectorSource = new ol.source.Vector({
			  features: [iconFeature]
			});

			var vectorLayer = new ol.layer.Vector({
			  source: vectorSource
			});
		
		   var map = new ol.Map({			
			  controls : ol.control.defaults({
       		  attribution : false,
       		  rotate: false,       		 
  		  }),
			    target: 'map',
			    layers: [
			      new ol.layer.Tile({
			        source: new ol.source.OSM()
			      })
			    ],
			    view: new ol.View({
			      center: ol.proj.fromLonLat([lon, lat]),
			      zoom: 16
			    })
			 
		   	
			  });
		
			 map.addLayer(vectorLayer); 
			 
		   $('#map').css("height","250px");
		   $('#map').css("width","100%");

	}
	
	
	
    function init() {
    	

    	var address = "${commessa.INDIRIZZO_UTILIZZATORE}";
    	
 	   var lat;
       var lon;
    	
    	 $.get(location.protocol + '//nominatim.openstreetmap.org/search?format=json&q='+address, function(data){
    	       console.log(data);
  
    	     if(data[0]!=null){
    	       lat = data[0].lat;
    	       lon = data[0].lon;
    	       mapping(lat, lon);
    	     }else{
    	    	 address = address.split("-");
    	    	 
    	    	 $.get(location.protocol + '//nominatim.openstreetmap.org/search?format=json&q='+address[1], function(data){
    	    	       console.log(data);    	    	
    	    	     if(data[0]!=null){
    	    	       lat = data[0].lat;
    	    	       lon = data[0].lon;
    	    	       mapping(lat, lon);
    	    	     }
    	    	    });
    	     }
    	    });
    	
 }

    
    
    $(document).ready(function() {
    	    	
    	
		init();

		
		
    	$('.select2').select2();
    	
    	table = $('#tabPM').DataTable({
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
    	      paging: true, 
    	      ordering: true,
    	      info: true, 
    	      searchable: false, 
    	      targets: 0,
    	      responsive: true,
    	      scrollX: false,
    	      stateSave: true,
    	      order: [[ 0, "desc" ]],
    	      columnDefs: [
						   { responsivePriority: 1, targets: 0 },
    	                   { responsivePriority: 3, targets: 2 },
    	                   { responsivePriority: 4, targets: 3 },
    	                   { responsivePriority: 2, targets: 6 },
    	                   { orderable: false, targets: 6 },
    	                   { width: "50px", targets: 0 },
    	                   { width: "70px", targets: 1 },
    	                   { width: "50px", targets: 4 },
    	               ],
             
    	               buttons: [ {
    	                   extend: 'copy',
    	                   text: 'Copia',
    	                   /* exportOptions: {
	                       modifier: {
	                           page: 'current'
	                       }
	                   } */
    	               },{
    	                   extend: 'excel',
    	                   text: 'Esporta Excel',
    	                   /* exportOptions: {
    	                       modifier: {
    	                           page: 'current'
    	                       }
    	                   } */
    	               },
    	               {
    	                   extend: 'colvis',
    	                   text: 'Nascondi Colonne'
    	                   
    	               }
    	                         
    	                          ],
    	                          "rowCallback": function( row, data, index ) {
    	                        	   
    	                        	      $('td:eq(1)', row).addClass("centered");
    	                        	      $('td:eq(4)', row).addClass("centered");
    	                        	  }
    	    	
    	      
    	    });
    	table.buttons().container()
        .appendTo( '#tabPM_wrapper .col-sm-6:eq(1)' );
     	   
       	    
       	    
       	 

    
   

  
    // DataTable
  	table = $('#tabPM').DataTable();
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
    $('#tabPM').on( 'page.dt', function () {
			$('.customTooltip').tooltipster({
		        theme: 'tooltipster-light'
		    });
		  } );
    
    var tableAtti�vita = $('#tabAttivita').DataTable({
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
	      paging: true, 
	      pageLength: 5,
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,
	      order: [[ 0, "desc" ]],
	      columnDefs: [
					   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 3, targets: 2 },
	               ],
       
	               buttons: [ {
	                   extend: 'copy',
	                   text: 'Copia',
	                   
	               },{
	                   extend: 'excel',
	                   text: 'Esporta Excel',
	                  
	               },{
	                   extend: 'pdf',
	                   text: 'Esporta Pdf',
	                  
	               },
	               {
	                   extend: 'colvis',
	                   text: 'Nascondi Colonne'
	                   
	               }
	                         
	                          ],
	                          "rowCallback": function( row, data, index ) {
	                        	   
	                        	      $('td:eq(1)', row).addClass("centered");
	                        	      $('td:eq(4)', row).addClass("centered");
	                        	  }
	    	
	      
	    });
    tableAtti�vita.buttons().container().appendTo( '#tabAttivita_wrapper .col-sm-6:eq(1)' );
	   
    $('#tabAttivita').on( 'page.dt', function () {
			$('.customTooltip').tooltipster({
		        theme: 'tooltipster-light'
		    });
		  } );
 	    
 	 



$('.inputsearchtable').on('click', function(e){
    e.stopPropagation();    
 });
// DataTable
tableAtti�vita = $('#tabAttivita').DataTable();
// Apply the search
tableAtti�vita.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
      table
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} ); 

tableAtti�vita.columns.adjust().draw();
    
 
    $('#myModal').on('hidden.bs.modal', function (e) {
   	  	$('#noteApp').val("");
   	 	$('#empty').html("");
   	})
    
    });
    var indirizzoutilizzatore = "${commessa.INDIRIZZO_UTILIZZATORE}";

 
    
  </script>
  
</jsp:attribute> 
</t:layout>


 
 
 
 



