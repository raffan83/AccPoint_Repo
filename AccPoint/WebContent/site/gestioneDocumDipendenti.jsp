<meta http-equiv = "Content-type" content = "text / html; charset = utf-8" />
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>


<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	

  <t:main-sidebar />
 <t:main-header />

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="pull-left">
        Lista Dipendenti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-success box-solid">
<div class="box-header with-border">
	 Lista Dipendenti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">


<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoDipendente()"><i class="fa fa-plus"></i> Nuovo Dipendente</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabDocumDipendenti" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nominativo</th>
<th>Qualifica</th>

<th>Note</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_dipendenti}" var="dipendente" varStatus="loop">
	<c:if test="${dipendente.stato.id==1 }">
 	<tr id="row_${loop.index}" style="background-color:#00ff80" >
 	</c:if>
 	<c:if test="${dipendente.stato.id==2 }">
	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
	</c:if>
	 	<c:if test="${dipendente.stato.id==3 }">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:if>

	<td>${dipendente.id }</td>	
	<td>${dipendente.committente.nome_cliente } - ${dipendente.committente.indirizzo_cliente }</td>
	<td><a href="#" class="btn customTooltip customlink" onClick="callAction('gestioneDocumentale.do?action=dettaglio_fornitore&id_fornitore=${utl:encryptData(dipendente.fornitore.id)}')">${dipendente.fornitore.ragione_sociale }</a></td>
	<td>${dipendente.nome } ${dipendente.cognome }</td>
	<td>${dipendente.qualifica }</td>
	
	<td>${dipendente.note }</td>
		
	<td>	
	  <a class="btn btn-warning" onClicK="modificaDipendenteModal('${dipendente.committente.id }','${dipendente.id}','${dipendente.fornitore.id}','${utl:escapeJS(dipendente.nome)}','${utl:escapeJS(dipendente.cognome)}','${utl:escapeJS(dipendente.note)}',
	   '${dipendente.qualifica}')" title="Click per modificare il Dipendente"><i class="fa fa-edit"></i></a>   
	   <a class="btn btn-info customTooltip" title="Associa documenti" onClick="modalAssociaDocumenti('${dipendente.committente.id }','${dipendente.fornitore.id }','${dipendente.id}')"><i class="fa fa-plus"></i></a>
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


</section>



<form id="nuovoDipendenteForm" name="nuovoDipendenteForm">
<div id="myModalnuovoDipendente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Dipendente</h4>
      </div>
       <div class="modal-body">
       
       
                    <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_dip" id="committente_dip" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona committente..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="fornitore" id="fornitore" class="form-control select2" data-placeholder="Seleziona fornitore..." aria-hidden="true" required disabled data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_fornitori}" var="fornitore">
                     
                           <option value="${fornitore.id}">${fornitore.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome" name="nome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome" name="cognome" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica" name="qualifica" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       

       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note" name="note" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
	
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaDipendenteForm" name="modificaDipendenteForm">
<div id="myModalModificaDipendente" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Dipendente</h4>
      </div>
                  <div class="modal-body">
                  
                                      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Committente</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="committente_dip_mod" id="committente_dip_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona committente..." data-live-search="true" style="width:100%" >
                <option value=""></option>
                      <c:forEach items="${lista_committenti}" var="committente">
                     
                           <option value="${committente.id}">${committente.nome_cliente} - ${committente.indirizzo_cliente }</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>

      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Fornitore</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="fornitore_mod" id="fornitore_mod" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" >
                
                      <c:forEach items="${lista_fornitori}" var="fornitore">
                     
                           <option value="${fornitore.id}">${fornitore.ragione_sociale}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Nome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="nome_mod" name="nome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Cognome</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="cognome_mod" name="cognome_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Qualifica</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="qualifica_mod" name="qualifica_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
             
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="3" style="width:100%" id="note_mod" name="note_mod" class="form-control"></textarea>
       			
       	</div>       	
       </div><br>


       
       </div>
  		 
      <div class="modal-footer">
		<input type="hidden" id="fornitore_temp" name="fornitore_temp">
		<input type="hidden" id="id_dipendente" name="id_dipendente">

		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>

<div id="myModalAssociaDocumenti" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Associa documenti al dipendente</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_doc" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th style="min-width:25px"></th>
<th>ID</th>
<th>Committente</th>
<th>Fornitore</th>
<th>Nome documento</th>
<th>Numero documento</th>
<th>Data caricamento</th>
<th>Frequenza</th>
<th>Data scadenza</th>
<th>Stato</th>
<th>Rilasciato</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
          
          <input type="hidden" id="id_dipendente_associazione"> 
 		
 		
        <a class = "btn btn-primary pull-right" onClick="associaDocumenti()">Salva</a> 
        <a class="btn btn-primary pull-right"  style="margin-right:5px"  onClick="$('#myModalAssociaDocumenti').modal('hide')">Chiudi</a>
         
         </div>
  </div>
</div>
</div>




  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare il rilievo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_rilievo_id">
      <a class="btn btn-primary"  onclick="eliminaRilievo($('#elimina_rilievo_id').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>



</div>
   <t:dash-footer />
   
  <t:control-sidebar />
</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />

<style>


.table th {
    background-color: #00a65a !important;
  }</style>

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">



function associaDocumenti(){
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var table = $('#table_doc').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();
		var selezionati = "";
		for(i=0; i< dataSelected.length; i++){
			dataSelected[i];
			selezionati = selezionati +dataSelected[i].id+";";
		}
		console.log(selezionati);
		table.rows().deselect();
		associaDocumentiDipendente(selezionati, $('#id_dipendente_associazione').val());
		
	}


function modalAssociaDocumenti(id_committente, id_fornitore,id_dipendente){
	
	$('#id_dipendente_associazione').val(id_dipendente);
	
	dataString ="action=documenti_dipendente&id_committente="+ id_committente+"&id_fornitore="+id_fornitore+"&id_dipendente="+id_dipendente;
    exploreModal("gestioneDocumentale.do",dataString,null,function(datab,textStatusb){
  	  	
  	  var result = JSON.parse(datab.replace());
  	  
  	  if(result.success){  		  
  		 
  		  var table_data = [];
  		  
  		  var lista_documenti = result.lista_documenti;
  		  var lista_documenti_associati = result.lista_documenti_associati;
  		  
  		  for(var i = 0; i<lista_documenti.length;i++){
  			  
  			if(lista_documenti[i].obsoleto==0 && lista_documenti[i].disabilitato == 0){
  				
  		
  			  var dati = {};
  			  dati.empty = '<td></td>';
  			  dati.check = '<td></td>';
  			  dati.id = lista_documenti[i].id;
  			  dati.committente = lista_documenti[i].committente.nome_cliente +" - "+lista_documenti[i].committente.indirizzo_cliente;
  			  dati.fornitore = lista_documenti[i].fornitore.ragione_sociale;
  			  dati.nome_documento = lista_documenti[i].nome_documento;
  			  if(lista_documenti[i].numero_documento==null){
  				dati.numero_documento = "";
  			  }else{
  				dati.numero_documento = lista_documenti[i].numero_documento; 
  			  }
  			  
  			  dati.data_caricamento =  formatDate(moment(lista_documenti[i].data_caricamento, "DD, MMM YY"));
  			  dati.frequenza = lista_documenti[i].frequenza_rinnovo_mesi;
  			  dati.data_scadenza =  formatDate(moment(lista_documenti[i].data_scadenza, "DD, MMM YY"));
  			  if(lista_documenti[i].stato!=null){
  				  dati.stato = lista_documenti[i].stato.nome 
  			  }else{
  				dati.stato = "";
  			  }
  			  
  			  dati.rilasciato = lista_documenti[i].rilasciato;
  			  dati.azioni = '<a  class="btn btn-danger" href="gestioneDocumentale.do?action=download_documento_table&id_documento='+lista_documenti[i].id+'" title="Click per scaricare il documento"><i class="fa fa-file-pdf-o"></i></a>';
  				
  			
  			  table_data.push(dati);
  			}
  		  }
  		  var table = $('#table_doc').DataTable();
  		  
   		   table.clear().draw();
   		   
   			table.rows.add(table_data).draw();
   			
   			table.columns.adjust().draw();
 			
   			$('#table_doc tr').each(function(){
   				var val  = $(this).find('td:eq(2)').text();
   				$(this).attr("id", val)
   			});
   			controllaAssociati(table,lista_documenti_associati );
 		  $('#myModalAssociaDocumenti').modal();
 			
  	  }
  	  
  	  $('#myModalAssociaDocumenti').on('shown.bs.modal', function () {
  		  var table = $('#table_doc').DataTable();
  			table.columns.adjust().draw();
  			
  		})
  	  
    });
	  
}

function controllaAssociati(table, lista_documenti_associati){
	
	//var dataSelected = table.rows( { selected: true } ).data();
	var data = table.rows().data();
	for(var i = 0;i<lista_documenti_associati.length;i++){
	
		table.row( "#"+lista_documenti_associati[i].id ).select();
			
		}
		
		
	
}


function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


function modalNuovoDipendente(){
	
	$('#myModalnuovoDipendente').modal();
	
}


function modificaDipendenteModal(id_committente, id_dipendente, fornitore, nome, cognome, note,  qualifica){
	
	
	$('#fornitore_temp').val(fornitore);
	
	$('#id_dipendente').val(id_dipendente);
	
	$('#committente_dip_mod').val(id_committente);
	$('#committente_dip_mod').change();
	

	$('#nome_mod').val(nome);
	$('#cognome_mod').val(cognome);
	$('#note_mod').val(note);
	
	$('#qualifica_mod').val(qualifica);

	
	$('#myModalModificaDipendente').modal();
}



$('#committente_dip').change(function(){
	
	 var id_committente = $(this).val();
	 getFornitoriCommittente("", id_committente);
	 
});


$('#committente_dip_mod').change(function(){
		
	 var id_committente = $(this).val();
	 getFornitoriCommittente("_mod", id_committente);
	 
});


var columsDatatables = [];

$("#tabDocumDipendenti").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabDocumDipendenti thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabDocumDipendenti thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


	var columsDatatables1 = [];

		$("#table_doc").on( 'init.dt', function ( e, settings ) {
		    var api = new $.fn.dataTable.Api( settings );
		    var state = api.state.loaded();
		 
		    if(state != null && state.columns!=null){
		    		console.log(state.columns);
		    
		    		columsDatatables1 = state.columns;
		    }
		    $('#table_doc thead th').each( function () {
		     	if(columsDatatables1.length==0 || columsDatatables1[$(this).index()]==null ){columsDatatables1.push({search:{search:""}});}
		    	  var title = $('#table_doc thead th').eq( $(this).index() ).text();
		    	
		    	  if($(this).index()!=0 && $(this).index()!=1){
				    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables1[$(this).index()].search.search+'" type="text" /></div>');	
			    	}

		    	} );
		    
		    

		} );
$('#fileupload').change(function(){
	$('#label_file').html($(this).val().split("\\")[2]);
	 
 });
$('#fileupload_mod').change(function(){
	$('#label_file_mod').html($(this).val().split("\\")[2]);
	 
 });

$(document).ready(function() {
 
	$('.select2').select2();
	 
     $('.dropdown-toggle').dropdown();
     

     table = $('#tabDocumDipendenti').DataTable({
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
		      searchable: true, 
		      targets: 0,
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabDocumDipendenti_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabDocumDipendenti').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	tab = $('#table_doc').DataTable({
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
        "order": [[ 2, "desc" ]],
	      paging: false, 
	      ordering: true,
	      info: false, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,  
	      scrollX: false,
	      stateSave: true,	
	      select: {
	        	style:    'multi+shift',
	        	selector: 'td:nth-child(2)'
	    	},
	      columns : [
	    	  {"data" : "empty"},  
	    	{"data" : "check"},  
	      	{"data" : "id"},
	      	{"data" : "committente"},
	      	{"data" : "fornitore"},
	      	{"data" : "nome_documento"},
	      	{"data" : "numero_documento"},
	      	{"data" : "data_caricamento"},
	      	{"data" : "frequenza"},
	      	{"data" : "data_scadenza"},
	      	{"data" : "stato"},
	      	{"data" : "rilasciato"},
	      	{"data" : "azioni"},
	       ],	
	           
	      columnDefs: [
	    	  
	    	  { responsivePriority: 1, targets: 1 },
	    	  { responsivePriority: 2, targets: 9 },
	    	  
	    	  { className: "select-checkbox", targets: 1,  orderable: false }
	    	  ],
	    	  
	     	          
  	      buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ]
	               
	    });
	
	tab.buttons().container().appendTo( '#table_doc_wrapper .col-sm-6:eq(1)');
 	    $('.inputsearchtable').on('click', function(e){
 	       e.stopPropagation();    
 	    });

 	     tab.columns().eq( 0 ).each( function ( colIdx ) {
  $( 'input', table.column( colIdx ).header() ).on( 'keyup', function () {
      tab
          .column( colIdx )
          .search( this.value )
          .draw();
  } );
} );  



	table.columns.adjust().draw();
	


	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})



	
	
});


$('#modificaDipendenteForm').on('submit', function(e){
	 e.preventDefault();
	 modificaDipendente();
});
 

 
 $('#nuovoDipendenteForm').on('submit', function(e){
	 e.preventDefault();
	 nuovoDipendente();
});
 

  </script>
  
</jsp:attribute> 
</t:layout>

