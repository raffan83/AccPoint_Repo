<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 

	String action = (String)request.getSession().getAttribute("action");


	%>
	
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
        Lista Pacchi
        <small></small>
      </h1>
    </section>

    <!-- Main content -->
     <section class="content">


  <div class="row">
        <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista pacchi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<div class="row">
<div class="col-lg-12">

<button class="btn btn-primary pull-left" onClick="creaNuovoPacco()">Nuovo Pacco</button>


</div>
</div>
<div class="row" style="margin-top:20px;">
<div class="col-lg-12">
  <table id="tabPM" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
 <th>ID</th>
 <th>Data Lavorazione</th>
 <th>Stato</th>
 <th>Cliente</th>
 <th>Sede</th>
 <th>Company</th>
 <th>Codice pacco</th>
 <th>Responsabile</th>
 <th>DDT</th>

 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_pacchi}" var="pacco" varStatus="loop">
<tr>
<td>${pacco.id}</td>
<td><fmt:formatDate pattern = "dd-MM-yyyy" value = "${pacco.data_lavorazione}" /></td>
<td>
		<c:choose>
  <c:when test="${pacco.stato_lavorazione.id == 1}">
		<span class="label label-success">ARRIVATO</span>
  </c:when>
  <c:when test="${pacco.stato_lavorazione.id == 0}">
		<span class="label label-info">IN LAVORAZIONE</span>
  </c:when>
   <c:when test="${pacco.stato_lavorazione.id == 2}">
		<span class="label label-warning">SPEDITO</span>
  </c:when>
  <c:otherwise>
    <span class="label label-info">-</span>
  </c:otherwise>
</c:choose>

</td>
<td>${pacco.nome_cliente}</td>
<td>${pacco.nome_sede }</td>
<td>${pacco.company.denominazione}</td>
<td>${pacco.codice_pacco}</td>
<td>${pacco.utente.nominativo}</td>
<td>${pacco.ddt.numero_ddt}</td>

	</tr>
	
	</c:forEach>
 
	
 </tbody>
 </table>  
</div>
</div>
</div>
</div>
</div>



  <div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
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
</div>
 
 
 
 
         <div id="myModalCreaNuovoPacco" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
    
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nuovo Pacco</h4>
      </div>
    <div class="modal-content">
       <div class="modal-body" id="myModalDownloadSchedaConsegnaContent">
 <form name="NuovoPaccoForm" method="post" id="NuovoPaccoForm" action="#">
 
     <div class="form-group">
                  <label>Cliente</label>
                  <select name="select1" id="select1" data-placeholder="Seleziona Cliente..."  class="form-control select2-drop" aria-hidden="true" data-live-search="true">
                  <c:if test="${userObj.idCliente != 0}">
                  
                      <c:forEach items="${lista_clienti}" var="cliente">
                       <c:if test="${userObj.idCliente == cliente.__id}">
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                        </c:if>
                     </c:forEach>
                  
                  
                  </c:if>
                 
                  <c:if test="${userObj.idCliente == 0}">
                  <option value=""></option>
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                     </c:forEach>
                  
                  
                  </c:if>
                    
                  </select>
        </div>
 
 <div class="form-group">
                  <label>Sede</label>
                  <select name="select2" id="select2" data-placeholder="Seleziona Sede"  disabled class="form-control select2-drop" aria-hidden="true" data-live-search="true">
                   <c:if test="${userObj.idSede != 0}">
             			<c:forEach items="${lista_sedi}" var="sedi">
             			  <c:if test="${userObj.idSede == sedi.__id}">
                          	 <option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>     
                          </c:if>                       
                     	</c:forEach>
                     </c:if>
                     
                     <c:if test="${userObj.idSede == 0}">
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             			 	<c:if test="${userObj.idCliente != 0}">
             			 		<c:if test="${userObj.idCliente == sedi.id__cliente_}">
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                          	 	</c:if>      
                          	</c:if>     
                          	<c:if test="${userObj.idCliente == 0}">
                           	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo}</option>       
                           	</c:if>                  
                     	</c:forEach>
                     </c:if>
                  </select>
                  
        </div>
 
  <div class="form-group">
  <label>Codice Pacco:</label>
  <div>
  <input type="text" name="codice_pacco">
 </div> 
  </div>
 
 <div class="form-group">
  <label>DDT:</label>
  <div>
  <input type="text" name="ddt">
  </div>
  </div>
 
 
 
 
 
 
 
 
 

</form>   
  		 </div>
      
    </div>
     <div class="modal-footer">

     <button class="btn btn-default pull-left" onClick="inserisciNuovoPacco()"><i class="glyphicon glyphicon"></i> Inserisci Nuovo Pacco</button>
   
    	
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
<script>


$(document).ready(function() {
	   
	

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
	      columnDefs: [
				   { responsivePriority: 1, targets: 0 },
	                   { responsivePriority: 2, targets: 1 },
	                   { responsivePriority: 3, targets: 2 }
	               ],

	    	
	    });
	

$('#tabPM thead th').each( function () {
  var title = $('#tabPM thead th').eq( $(this).index() ).text();
  $(this).append( '<div><input class="inputsearchtable" style="width:100%" type="text" /></div>');
} );
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });
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
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})


});

});




var idCliente = ${userObj.idCliente}
var idSede = ${userObj.idSede}

 $body = $("body");


  $("#select1").change(function() {
  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#select2 option').clone());
	  }
	  
	  var id = $(this).val();
	 
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		if(str.substring(str.indexOf("_")+1,str.length)==id)
		{
			
			//if(opt.length == 0){
				
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#select2").prop("disabled", false);
	 
	  $('#select2').html(opt);
	  
	  $("#select2").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#select2").change();  
	  //}
	  
	
	});
  
  $(document).ready(function() {
  

  	
  	

  	$(".select2").select2();
  	
  	if(idCliente != 0 && idSede != 0){
  		 $("#select1").prop("disabled", true);
  		$("#select2").change();
  	}else if(idCliente != 0 && idSede == 0){
  		 $("#select1").prop("disabled", true);
  		 $("#select2").prop("disabled", false);
  		$("#select1").change();
  	}else{
  		clienteSelected =  $("#select1").val();
  		sedeSelected = $("#select2").val();
  		
  		if((clienteSelected != null && clienteSelected != "") && (sedeSelected != null && sedeSelected != "")){
  			$("#select2").change();
  			 $("#select2").prop("disabled", false);
  			 $("#select1").prop("disabled", false);
  		}else if((clienteSelected != null && clienteSelected != "") && (sedeSelected == null || sedeSelected == "")){
  			$("#select1").change();
  			 $("#select1").prop("disabled", false);
  			 $("#select2").prop("disabled", false);
  		}
  	}
  	
  	
  
  
  });
 
  
  $("#select2").change(function(e){
		
        //get the form data using another method 
        var sede = $("#select2").val();
        var cliente = $("#select1").val();
       
        if(sede==""){
      	   sede = null;
        }

        dataString ="idSede="+ sede+";"+cliente;
/*         exploreModal("listaInterventiSede.do",dataString,"#posTab",function(data,textStatus){
      	  $('#myModal').on('hidden.bs.modal', function (e) {
           	  	$('#noteApp').val("");
           	 	$('#empty').html("");
           	 	$('body').removeClass('noScroll');
           	}) 


      		  
      	  
        });*/

        
  });
  
  
</script>





</jsp:attribute> 
</t:layout>
  
 
