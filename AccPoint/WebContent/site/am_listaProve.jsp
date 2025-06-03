<%@page import="java.util.ArrayList"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="it.portaleSTI.DTO.AMOperatoreDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@page import="it.portaleSTI.DTO.CommessaDTO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista  prove
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista prove
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">



<div class="row">
<div class="col-sm-12">

 <table id="tabAMprove" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

  <th>ID</th>   
  <th>Cliente</th>
  <th>Sede</th>
  <th>Cliente Utilizzatore</th>
  <th>Sede Utilizzatore</th>
  <th>Commessa</th>
 <th>Tipo prova</th>
  <th>Data Prova</th>
  <th>Oggetto Prova</th>

  <th>Matricola</th>
  <th>Campione</th>
 <th>Esito</th>	

 <th>Numero Rapporto</th>
 <th>Assistente</th>

 <td style="min-width:150px">Azioni</td>
 </tr></thead>
 
 <tbody>
 
 <c:forEach items="${lista_prove}" var="rapporto">
 
 	<tr role="row" id="${rapporto.prova.id}">


 	<td>${rapporto.prova.id}</td>
 	<td>${rapporto.prova.intervento.nomeCliente }</td>
 	<td>${rapporto.prova.intervento.nomeSede }</td>
 	<td>${rapporto.prova.intervento.nomeClienteUtilizzatore }</td>
 	<td>${rapporto.prova.intervento.nomeSedeUtilizzatore }</td>
 	<td>${rapporto.prova.intervento.idCommessa }</td>
<td>${rapporto.prova.tipoProva.descrizione}</td>
<td> <fmt:formatDate pattern="dd/MM/yyyy"  value="${rapporto.prova.data}" />	</td>
<td>${rapporto.prova.strumento.descrizione}</td>
<td>${rapporto.prova.strumento.matricola}</td>
<td>${rapporto.prova.campione.codiceInterno }</td>
<td>${rapporto.prova.esito }</td>

<td>${rapporto.prova.nRapporto }</td>
<td>${rapporto.prova.operatore.nomeOperatore }</td>

<td>
<a class="btn btn-info customTooltip" title="Click per aprire il dettaglio della prova" onClick="callAction('amGestioneInterventi.do?action=dettaglio_prova&id_prova=${utl:encryptData(rapporto.prova.id)}')"><i class="fa fa-search"></i></a>



<c:if test="${rapporto.stato.id == 2}">
<a target="_blank"   class="btn btn-danger customTooltip" title="Click per scaricare il Cerificato"  href="amGestioneInterventi.do?action=download_certificato&id_prova=${utl:encryptData(rapporto.prova.id)}" > <i class="fa fa-file-pdf-o"></i></a>
 
 </c:if>
<%--
<a class="btn btn-danger customTooltip" title="Click per generare il certificato" onClick="callAction('gestioneVerprova.do?action=crea_certificato&id_prova=${utl:encryptData(prova.id)}')"><i class="fa fa-file-pdf-o"></i></a>
<c:if test="${prova.nomeFile_inizio_prova!=null && prova.nomeFile_inizio_prova!=''}">
<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di inizio prova" onClick="callAction('gestioneVerprova.do?action=download_immagine&id_prova=${utl:encryptData(prova.id)}&filename=${prova.nomeFile_inizio_prova}&nome_pack=${prova.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if>
<c:if test="${prova.nomeFile_fine_prova!=null && prova.nomeFile_fine_prova!='' }">

<a class="btn btn-primary customTooltip" title="Click per scaricare l'immagine di fine prova" onClick="callAction('gestioneVerprova.do?action=download_immagine&id_prova=${utl:encryptData(prova.id)}&filename=${prova.nomeFile_fine_prova}&nome_pack=${prova.verIntervento.nome_pack }')"><i class="fa fa-image"></i></a>
</c:if> --%>
</td>
		
		
	</tr>
 
	</c:forEach>
 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>
</div>

</section>





<form id="nuovoStrumentoForm">

  <div id="modalNuovoStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Oggetto Prova</h4>
      </div>
       <div class="modal-body">
       
           <div class="row">
    

        <label for="inputEmail" class="col-sm-3 control-label">Cliente:</label>
         <div class="col-sm-9">
    
    	                  <select name="cliente_appoggio_general" id="cliente_appoggio_general"  class="form-control select2"  aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
							
                  <option value=""></option>
                      <c:forEach items="${lista_clienti}" var="cliente">
                           <option value="${cliente.__id}">${cliente.nome} </option> 
                     </c:forEach>
                  
	                  </select>
    
            
                  <input  name="cliente_general" id="cliente_general"  class="form-control" style="width:100%" >
   
        </div>

  </div><br>
  
       <div class="row">
                 <label for="inputEmail" class="col-sm-3 control-label">Sede:</label>
                  
                     

         <div class="col-sm-9">
                  <select name="sede_general" id="sede_general" data-placeholder="Seleziona Sede..."  disabled class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             	
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	     
                          
                     	</c:forEach>
                    
                  </select>
                  
        </div>
</div><br>

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione" name="descrizione" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola" name="matricola" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="zona_rif_fasciame" name="zona_rif_fasciame" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="spessore_fasciame" name="spessore_fasciame" style="width:100%" required>       	
       	</div>
       </div><br>
           <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo" name="tipo" style="width:100%" required>       	
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume" name="volume" style="width:100%" required>
       	</div>
       </div><br>
       
       		<div class="row">
       	<div class="col-sm-3">
       		<label>Materiale Fasciame</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="materiale_fasciame" name="materiale_fasciame" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione" name="pressione" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore" name="costruttore" style="width:100%" required>
       	</div>
       </div><br>
       
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica" name="numero_fabbrica" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="zona_rif_fondo" name="zona_rif_fondo" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="spessore_fondo" name="spessore_fondo" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno" name="anno"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza" name="frequenza" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica" name="data_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica" name="data_prossima_verifica" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">

        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>


<form id="modificaStrumentoForm">

  <div id="modalModificaStrumento" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Strumento</h4>
      </div>
       <div class="modal-body">
       
        <div class="row">
    

        <label for="inputEmail" class="col-sm-3 control-label">Cliente:</label>
         <div class="col-sm-9">
    
    	                     
            
                  <input  name="cliente_general_mod" id="cliente_general_mod"  class="form-control" style="width:100%" >
   
        </div>

  </div><br>
  
       <div class="row">
                 <label for="inputEmail" class="col-sm-3 control-label">Sede:</label>
                  
                     

         <div class="col-sm-9">
                  <select name="sede_general_mod" id="sede_general_mod" data-placeholder="Seleziona Sede..."  disabled class="form-control select2 classic_select" aria-hidden="true" data-live-search="true" style="width:100%">
               
                    	<option value=""></option>
             			<c:forEach items="${lista_sedi}" var="sedi">
             	
                          	 		<option value="${sedi.__id}_${sedi.id__cliente_}">${sedi.descrizione} - ${sedi.indirizzo} - ${sedi.comune} (${sedi.siglaProvincia})</option>       
                          	     
                          
                     	</c:forEach>
                    
                  </select>
                  
        </div>
</div><br>

		<div class="row">
       	<div class="col-sm-3">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="descrizione_mod" name="descrizione_mod" style="width:100%" required>  
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Matricola</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="matricola_mod" name="matricola_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="zona_rif_fasciame_mod" name="zona_rif_fasciame_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fasciame</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="spessore_fasciame_mod" name="spessore_fasciame_mod" style="width:100%" required>       	
       	</div>
       </div><br>
           <div class="row">
       	<div class="col-sm-3">
       		<label>Tipo</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="tipo_mod" name="tipo_mod" style="width:100%" required>       	
       	</div>
       </div><br>
       
              <div class="row">
       	<div class="col-sm-3">
       		<label>Volume</label>
       	</div>
       	<div class="col-sm-9">
       		<input class="form-control" id="volume_mod" name="volume_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       		<div class="row">
       	<div class="col-sm-3">
       		<label>Materiale Fasciame</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="materiale_fasciame_mod" name="materiale_fasciame_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Pressione</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="pressione_mod" name="pressione_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Costruttore</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="costruttore_mod" name="costruttore_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Numero di fabbrica</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="numero_fabbrica_mod" name="numero_fabbrica_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Zona Riferimento Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="zona_rif_fondo_mod" name="zona_rif_fondo_mod" style="width:100%" required>
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Spessore Fondo</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="spessore_fondo_mod" name="spessore_fondo_mod" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Anno</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="anno_mod" name="anno_mod"  type="number" step="1" min="0" style="width:100%" required>
       	</div>
       </div><br>
       
        <div class="row">
       	<div class="col-sm-3">
       		<label>Frequenza (mesi)</label>
       	</div>
       	<div class="col-sm-9">
				<input class="form-control" id="frequenza_mod" name="frequenza_mod"  type="number" step="1" min="0" style="width:100%" >
       	</div>
       </div><br>
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_verifica_mod" name="data_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
      
       
       <div class="row">
       	<div class="col-sm-3">
       		<label>Data Prossima Verifica</label>
       	</div>
       	<div class="col-sm-9">
				<div class='input-group date datepicker' id='datepicker_data_intervento'>
               <input type='text' class="form-control input-small" id="data_prossima_verifica_mod" name="data_prossima_verifica_mod" >
                <span class="input-group-addon">
                    <span class="fa fa-calendar" >
                    </span>
                </span>
        </div> 
       	</div>
       </div><br>
       
       

  		  <div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<input type="hidden" id="id_prova" name="id_prova">
        <button type="submit" class="btn btn-danger"  >Salva</button>
      </div>
    </div>
  </div>
</div>
</form>







</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/css/bootstrap-timepicker.css"> 

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-timepicker/0.5.2/js/bootstrap-timepicker.js"></script> 
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">








var columsDatatables = [];

$("#tabAMprove").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAMprove thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAMprove thead th').eq( $(this).index() ).text();
    	
    	  
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	
	
	
    	} );
    
    

} );






var commessa_options;
$(document).ready(function() {
 


     table = $('#tabAMprove').DataTable({
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
	        "order": [[ 0, "desc" ]],
		      paging: true, 
		      ordering: true,
		      info: true, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
	    
		      columnDefs: [
		    	  
		    	  { responsivePriority: 0, targets: 14 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAMprove_wrapper .col-sm-6:eq(1)');
	 	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });

	 	     table.columns().eq( 0 ).each( function ( colIdx ) {
	 	  	  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
	 	  	      table
	 	  	          .column( colIdx )
	 	  	          .search( this.value )
	 	  	          .draw();
	 	  	  } );
	 	  	} );  

		table.columns.adjust().draw();
		

	$('#tabAMprove').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	
	
});




 
  </script>
  
</jsp:attribute> 
</t:layout>

