<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<%
	ArrayList<ClienteDTO> lista_clienti = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
	ArrayList<ClienteDTO> lista_fornitori = (ArrayList<ClienteDTO>)request.getSession().getAttribute("lista_fornitori");
%>	
<c:set var="listaClienti" value="<%=lista_clienti %>"></c:set>
<c:set var="listaFornitori" value="<%=lista_clienti %>"></c:set>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Lista Item Magazzino
        <small></small>
      </h1>
    </section>

    <!-- Main content -->
     <section class="content">
<div class=row>
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Item in magazzino
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-sm-12">
</div>
</div>
<div class="row" style="margin-top:20px;">
<div class="col-sm-12">
  <table id="tab_lista_item" class="table table-bordered table-hover dataTable table-striped" role="grid">
 <thead><tr class="active">
 <th>ID Item</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Commessa</th>
 <th>Stato</th>
 <th>Data Arrivo</th>
 <th>Pacco</th>
 <th>Denominazione</th>
 <th>N. Colli</th>
 <th>Attività</th>
 <th>Destinazione</th>
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
<td>${item_pacco.pacco.nome_cliente}</td>
<td>${item_pacco.pacco.nome_sede }</td>
<td>
<c:if test="${item_pacco.pacco.commessa!=null && item_pacco.pacco.commessa!=''}">
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio della commessa" onclick="dettaglioCommessa('${item_pacco.pacco.commessa}');">${item_pacco.pacco.commessa}</a>
</c:if>
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
</td>
<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${item_pacco.pacco.ddt.data_arrivo}" /></td>
<td>
<a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del pacco" onclick="dettaglioPacco('${item_pacco.pacco.id}')">
${item_pacco.pacco.id}
</a>
</td>
<td>${item_pacco.item.descrizione}</td>
<td>${item_pacco.pacco.ddt.colli }</td>
  <c:choose>
  <c:when test="${item_pacco.item.attivita !='undefined'}">
  <td>${item_pacco.item.attivita }</td>
  </c:when>
  <c:otherwise><td></td></c:otherwise>
  </c:choose>
  <c:choose>
  <c:when test="${item_pacco.item.destinazione !='undefined'}">
 <td>${item_pacco.item.destinazione }</td>
  </c:when>
  <c:otherwise><td></td></c:otherwise>
  </c:choose>
<td>  <c:if test="${item_pacco.item.priorita ==1}">Urgente</c:if>
    <c:if test="${item_pacco.item.priorita ==0}"></c:if></td>
<td>${item_pacco.note}</td>
<c:choose>
<c:when test="${item_pacco.pacco.ddt.numero_ddt!='' && item_pacco.pacco.ddt.numero_ddt!=null }">
<td><a href="#" class="btn customTooltip customlink" title="Click per aprire il dettaglio del DDT" onclick="callAction('gestioneDDT.do?action=dettaglio&id=${item_pacco.pacco.ddt.id}')">
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



  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" style="z-index:1070">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Messaggio</h4>
      </div>
       <div class="modal-body">
			<div id="myModalErrorContent">
			
			</div>
   
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="button" id="close_button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
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




$(document).ready(function(){
	
    
	var columsDatatables = [];

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
	    pageLength: 10,
	     "order": [ 6, "desc" ], 
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


</script>


</jsp:attribute> 
</t:layout>
  
 
