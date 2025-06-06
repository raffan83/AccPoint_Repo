<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="it.portaleSTI.DTO.MagPaccoDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DTO.ClienteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        Lista Contratto
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
	 Lista Contratto
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<a class="btn btn-primary pull-left" onClick="callAction('gestioneDevice.do?action=lista_contratti')">Contratti In Corso</a> 



</div>

</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabContratto" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Company</th>
<th>Fornitore</th>
<th>Descrizione</th>
<th>Subscription</th>
<th>Data inizio</th>
<th>Data scadenza</th> 
 <th>Permanente</th>
 <th>Numero licenze</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_contratto }" var="contratto" varStatus="loop">
 	<c:if test="${contratto.stato=='S' }">
	<tr id="row_${device.id }" style="background-color:#D8796F">
</c:if>
<c:if test="${contratto.stato!='S' }">
	<tr id="row_${device.id }">
</c:if>
	<td>${contratto.id }</td>		
	<td>${contratto.company.ragione_sociale }</td>
	<td>${contratto.fornitore }</td>
	<td>${contratto.descrizione }</td>
	<td>${contratto.subscription }</td>
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${contratto.data_inizio }"></fmt:formatDate></td> 
	<td><fmt:formatDate pattern="dd/MM/yyyy" value="${contratto.data_scadenza }"></fmt:formatDate></td>
		<td>${contratto.permanente }</td>
<td>${contratto.n_licenze }</td>

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






<div id="tableContainer" style="display: none;">

       <div class="row" >
       	<div class="col-sm-3">
       	<label>Software Associati</label>
       	</div>
       	<br>
       
		 <div class="col-sm-12">      
		     <table id="tabSoftware" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
		 <thead><tr class="active">
		
		
		<th>ID</th>
		<th>Nome</th>
		<th>Produttore</th>		
		<th>Data scadenza</th>
		<th>Versione</th>
		 </tr></thead>
		 
		 <tbody> 
		
		 </tbody>
		 </table> 
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
      Sei sicuro di voler rendere obsoleto il contratto?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="id_elimina_contratto">
      <a class="btn btn-primary" onclick="eliminaContratto($('#id_elimina_contratto').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div> 




<div id="myModalStorico" class=" modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <a type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></a>
        <h4 class="modal-title" id="myModalLabelHeader">Storico contratto</h4>
      </div>
       <div class="modal-body">
       <div class="row">
       <div class="col-sm-12">
			
      
        
 <table id="table_storico" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Company</th>
<th>Fornitore</th>
<th>Descrizione</th>
<th>Subscription</th>
<th>Permanente</th>
<th>Data inizio</th>

<th>Data scadenza</th>
<th>N. licenze</th>

 </tr></thead>
 
 <tbody>
</tbody>
</table>
</div>
		</div>

     
    </div>
          <div class="modal-footer">
 		
 		<a class="btn btn-default pull-right" onClick="$('#myModalStorico').modal('hide')">Chiudi</a>
         
         
         </div>
  </div>
</div>
</div>




  <div id="myModalAllegati" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Allegati</h4>
      </div>
       <div class="modal-body">       
      <div id="content_allegati"></div>
      	</div>
      <div class="modal-footer">      
      
		<a class="btn btn-primary" onclick="$('#myModalAllegati').modal('hide')" >Chiudi</a>
      </div>
    </div>
  </div>

</div>

<div id="modalSoftwareTot" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Lista software</h4>
      </div>
       <div class="modal-body">
       		
        <table id="tabSoftwareTot" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th></th>
<th></th>
<th>ID</th>
<th>Nome</th>
<th>Produttore</th>
<th>Data scadenza</th>
<th>Versione</th>
<th>Contratto</th> 
 </tr></thead>

 <tbody> 

 </tbody>
 </table>  
        
        
        
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
      
      <input type="hidden" id="id_device_contratto" >
      	<input type="hidden" id="is_modifica">
      	<a class="btn btn-primary" onClick="associaSoftware()">Associa software selezionati</a>
      	
      	
     
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



</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript">

function associaSoftware(){
	
	
	  pleaseWaitDiv = $('#pleaseWaitDialog');
	  pleaseWaitDiv.modal();
	  
	  var table = $('#tabSoftwareTot').DataTable();
		var dataSelected = table.rows( { selected: true } ).data();
		var selectedJsonArray = [];
		for (var i = 0; i < dataSelected.length; i++) {
		    selectedJsonArray.push(dataSelected[i]); 
		}
		
		
		createTableAssociati(selectedJsonArray);
		
		table.rows().deselect();
		
		$('#modalSoftwareTot').modal("hide")
}





var settings = {
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
ordering: false,
	  columns : [
		  {"data" : "id"},
  	  {"data" : "nome"},
  	  {"data" : "produttore"},
  	  {"data" : "data_scadenza"},
  	  
  	  {"data" : "versione"}
  	  
  	  
]


}




function createTableAssociati(lista_software_associati, id_contratto){

	 
	 tabSw.clear();	
	
	if(lista_software_associati!=null){
	

		 		var table_data = [];
		 		//
				
				  for(var i = 0; i<lista_software_associati.length;i++){
					  var dati = {};
					  
					  dati.id = lista_software_associati[i].id; 
					  dati.nome = lista_software_associati[i].nome;
					  dati.produttore = lista_software_associati[i].produttore;
					 

					  if(lista_software_associati[i].data_scadenza!=null){
				  			dati.data_scadenza = lista_software_associati[i].data_scadenza;  
				  		  }else{
				  			dati.data_scadenza = '' 
				  		  }

					  if(lista_software_associati[i].versione!=null){
						  dati.versione =  lista_software_associati[i].versione;
					  }else{
						  dati.versione =  '';
					  }
					  
					 
					  table_data.push(dati);
				  }
				  	
				//  tabSW = $('#tabSoftware').DataTable();
				  tabSw.rows.add(table_data)
				
				//table.rows.add(table_data).draw();
				
				
				
				tabSw.columns.adjust().draw();
				 pleaseWaitDiv = $('#pleaseWaitDialog');
			   	  pleaseWaitDiv.modal('hide');
				 $( "#myModal" ).modal();
		       	    $('body').addClass('noScroll'); 
				
		       	    if($('#is_modifica').val()==1){
		       	    	$('#modal_modifica_content').html($("#tableContainer").html())
		       	    }else{
		       	    	$('#modal_nuovo_content').html($("#tableContainer").html())   	
		       	    }
		       	 
		
	}else{
		

		dataString ="action=software_associati&id_contratto="+ id_contratto;
	    exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
	    	
	    	
	    	
	    	  var result = JSON.parse(datab);
		      	  
	      	  if(result.success){ 
					  
					var lista_software_associati = result.lista_software_associati;
					var table_data = [];
					
				
					
					  for(var i = 0; i<lista_software_associati.length;i++){
						  var dati = {};
						  
						  dati.id = lista_software_associati[i].id; 
						  dati.nome = lista_software_associati[i].nome;
						  dati.produttore = lista_software_associati[i].produttore;
						 

						  if(lista_software_associati[i].data_scadenza!=null){
					  			dati.data_scadenza = lista_software_associati[i].data_scadenza;  
					  		  }else{
					  			dati.data_scadenza = '' 
					  		  }

						  if(lista_software_associati[i].versione!=null){
							  dati.versione =  lista_software_associati[i].versione;
						  }else{
							  dati.versione =  '';
						  }
						  
						 
						  table_data.push(dati);
					  }
					  			
					
					  //tabSW = $('#tabSoftware').DataTable();
					//  tabSw.clear().draw();
					
					//table.rows.add(table_data).draw();
					tabSw.rows.add(table_data).draw();
					
					
					tabSw.columns.adjust().draw();
					 pleaseWaitDiv = $('#pleaseWaitDialog');
				 	  pleaseWaitDiv.modal('hide');
					 $( "#myModal" ).modal();
				 	    $('body').addClass('noScroll');
					
				 	   $('#modal_modifica_content').html($("#tableContainer").html())
	      	  }
		});
		
		
	}
	
	
	

}


function controllaAssociati(table, lista_software_associati){
	
	//var dataSelected = table.rows( { selected: true } ).data();
	
	if(lista_software_associati!=null){
		var data = table.rows().data();
		for(var i = 0;i<lista_software_associati.length;i++){
		
			table.row( "#row_sw_"+lista_software_associati[i].id ).select();
				
			}
	}

		
		
	
}


function modalSoftware(is_modifica){
	
	if(is_modifica==1){
		dataString ="action=associa_software&id_contratto="+ $('#id_contratto').val()
	}else{
		dataString ="action=associa_software";
	}
	
		
	
    exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
  	  	
  	  var result = JSON.parse(datab);
  	  
  	  if(result.success){  		  
  		 
  		var t_data = [];
  		
  		var lista_software = result.lista_software;
  		var lista_software_associati = result.lista_software_associati;
  		
  	  for(var i = 0; i<lista_software.length;i++){
  		  var dati = {};
  	
  		  dati.empty = '<td></td>';
  		  dati.check='<td></td>';
  		  dati.id = lista_software[i].id; 
  		  dati.nome = lista_software[i].nome;
  		  dati.produttore = lista_software[i].produttore;
 			if(lista_software[i].data_scadenza!=null){
 				dati.data_scadenza =lista_software[i].data_scadenza;
 			}else{
 				dati.data_scadenza ='';
 			}
  		 

  		 dati.versione = lista_software[i].versione;
  		 if(lista_software[i].contratto!=null){
  			 dati.contratto = "ID: "+lista_software[i].contratto.id+" - "+lista_software[i].contratto.fornitore
  		 }else{
  			 dati.contratto ="";
  		 }
  		 // dati.azioni = '<td><a class="btn btn-primary customTooltip" title="Aggiungi validazione" onClick="modalValidazione('+lista_software[i].id+')"><i class="fa fa-plus">Validazione</i></a></td>'
  		t_data.push(dati);
  	  }
  	  
  	
  	 $('#is_modifica').val(is_modifica)



  	var table = $('#tabSoftwareTot').DataTable();
  	
  	table.clear().draw();
  	
  	table.rows.add(t_data).draw();
  	
  	table.columns.adjust().draw();
  	

  	var p = table.rows({ page: 'all' }).nodes();
  	 
  	 for (var i = 0; i < p.length; i++) {
  		p[i].id = "row_sw_"+ p[i].childNodes[2].innerText
	}
  	
  	controllaAssociati(table, lista_software_associati);
  	$('#modalSoftwareTot').modal();
  	
  	
  	
  	$('#modalSoftwareTot').on('shown.bs.modal', function () {
  	var table = $('#tabSoftwareTot').DataTable();
  	table.columns.adjust().draw();
  	
  	});
  	  
  
    }
    });
}



function modalNuovoContratto(){
	
	$('#myModalNuovoContratto').modal();
	
}

 
 function modalStorico(id_contratto){
		
	  dataString ="action=storico_contratto&id_contratto="+ id_contratto;
     exploreModal("gestioneDevice.do",dataString,null,function(datab,textStatusb){
   	  	
   	  var result =datab;
   	  
   	  if(result.success){
   		  
   		 
   		  var table_data = [];
   		  
   		  var lista_contratti = result.lista_contratti;
   		  
   		  for(var i = 0; i<lista_contratti.length;i++){
   			  var dati = {};
   			  if( lista_contratti[i].id!= id_contratto){
   				  
   			  
   			  dati.id = lista_contratti[i].id;
   			  dati.company = lista_contratti[i].company.ragione_sociale;
   			  dati.fornitore = lista_contratti[i].fornitore;
   			  dati.descrizione = lista_contratti[i].descrizione;
   			  if(lista_contratti[i].subscription==null){
   				  dati.subscription = ''; 
   			  }else{
   				  dati.subscription = lista_contratti[i].subscription;
   			  }    	
   			  dati.permanente = lista_contratti[i].permanente;
   			 if(lista_contratti[i].n_licenze == null){
   				 dati.n_licenze = '';
   			 }else{
   				 dati.n_licenze = lista_contratti[i].n_licenze;	 
   			 }
   			if(lista_contratti[i].data_inizio == null){
  				 dati.data_inizio = '';
  			 }else{
  				 dati.data_inizio = lista_contratti[i].data_inizio;	 
  			 }
   			 
   			 if(lista_contratti[i].data_scadenza == null){
   				 dati.data_scadenza = '';
   			 }else{
   				 dati.data_scadenza = lista_contratti[i].data_scadenza;	 
   			 }
   			 if(lista_contratti[i].email_referenti == null){
   				 dati.email_referenti = '';
   			 }else{
   				 dati.email_referenti = lista_contratti[i].email_referenti;	 
   			 }
   			

   			  table_data.push(dati);
   			  }
   		  }
   		  var table= $('#table_storico').DataTable();
   		  
   		  table.clear().draw();
    		   
   		  table.rows.add(table_data).draw();
   		  table.columns.adjust().draw();
  			
  		  $('#myModalStorico').modal();
  			
   	  }
   	  
   	  $('#myModalStorico').on('shown.bs.modal', function () {
   		  var table = $('#table_storico').DataTable();
   		  
   		  table.columns.adjust().draw();
 			
   		})
   	  
     });
	  

	
}
 



var columsDatatables = [];

$("#tabContratto").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabContratto thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabContratto thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );


function modalYesOrNo(id_contratto){
	
	
	$('#id_elimina_contratto').val(id_contratto);
	$('#myModalYesOrNo').modal();
	
}

function eliminaContratto(id_contratto){
	
	var dataObj = {};
	dataObj.id_contratto = id_contratto;
	
	callAjax(dataObj, "gestioneDevice.do?action=rendi_obsoleto");
	
}







var tabSw;

$(document).ready(function() {
 

     $('.dropdown-toggle').dropdown();
     $('.select2').select2();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 
  

     table = $('#tabContratto').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 8 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabContratto_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabContratto').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	$("#tabSoftwareTot").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    $('#tabSoftwareTot thead th').each( function () {
	     	
	    	  var title = $('#tabSoftwareTot thead th').eq( $(this).index() ).text();
	    	
	    	  if($(this).index()!=0 && $(this).index()!=1){
			    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="" type="text" /></div>');	
		    	}

	    	} );
	    
	    

	} );
	
	
	
	
	tabSw = $('#tabSoftware').DataTable(settings);
	 
	 
	 

	
	
	tabSWTot = $('#tabSoftwareTot').DataTable({
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
    select: {
    	style:    'multi-shift',
    	selector: 'td:nth-child(2)'
	},
	destroy: true,
	  ordering: false,
		  columns : [
			  {"data" : "empty"},  
		    	{"data" : "check"},  
			  {"data" : "id"},
	    	  {"data" : "nome"},
	    	  {"data" : "produttore"},
	    	  {"data" : "data_scadenza"},
	    	  {"data" : "versione"},
	    	  {"data" : "contratto"}
	    	  
	    	  
	    	  
	  ],
	  columnDefs: [
{ className: "select-checkbox", targets: 1,  orderable: false }
	]
});
	    $('.inputsearchtable').on('click', function(e){
	 	       e.stopPropagation();    
	 	    });
	  
	  tabSWTot.columns().eq( 0 ).each( function ( colIdx ) {
	   	  $( 'input', tabSWTot.column( colIdx ).header() ).on( 'keyup', function () {
	   		tabSWTot
	   	          .column( colIdx )
	   	          .search( this.value )
	   	          .draw();
	   	  } );
	   	} );  
	  
	  
	  
	  
	  
	  tab = $('#table_storico').DataTable({
			language: {
		        	emptyTable : 	"Non sono presenti documenti precedenti",
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
		      paging: false, 
		      ordering: true,
		      info: false, 
		      searchable: false, 
		      targets: 0,
		      responsive: true,  
		      scrollX: false,
		      stateSave: true,	
		      columns : [
		      	{"data" : "id"},
		      	{"data" : "company"},
		      	{"data" : "fornitore"},
		      	{"data" : "descrizione"},
		      	{"data" : "subscription"},
		      	{"data" : "permanente"},
		      	{"data" : "data_inizio"},
		      	{"data" : "data_scadenza"},
		      
		      	{"data" : "n_licenze"},
		    
		       ],	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 7 },
		    	  
		    	  
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
	  
	  
	  
  });
	
	



$('#modificaContrattoForm').on('submit', function(e){
	 e.preventDefault();
	 var table = $('#tabSoftware').DataTable();
	 var allData = table.rows().data(); // Prende tutte le righe

	 // Estrai la prima colonna e crea la stringa
	 var firstColumnString = [];
	 for (var i = 0; i < allData.length; i++) {
		 if(!allData[i][0].includes("Nessun")){
			 firstColumnString.push(allData[i][0]); // Assumendo che i dati siano in formato array	 
		 }
	     
	 }

	 var resultString = firstColumnString.join(';');
	 
	 $('#id_software_associazione_mod').val(resultString); 
	 callAjaxForm('#modificaContrattoForm','gestioneDevice.do?action=modifica_contratto');
});
 

 
 $('#nuovoContrattoForm').on('submit', function(e){
	 e.preventDefault();
	 
	 var table = $('#tabSoftware').DataTable();
	 var allData = table.rows().data(); // Prende tutte le righe

	 // Estrai la prima colonna e crea la stringa
	 var firstColumnString = [];
	 for (var i = 0; i < allData.length; i++) {
	     firstColumnString.push(allData[i][0]); // Assumendo che i dati siano in formato array
	 }

	 var resultString = firstColumnString.join(';');
	 
	 $('#id_software_associazione').val(resultString); 
	 callAjaxForm('#nuovoContrattoForm','gestioneDevice.do?action=nuovo_contratto');
	
});
 
 
 

$('#myModalNuovoContratto').on("hidden.bs.modal",function(){
	
	$('#fornitore').val("")
	$('#data_inizio').val("")
	$('#data_scadenza').val("")
	$('#permanente').val("")
	 tabSw.clear().draw();
});
 
  </script>
  
</jsp:attribute> 
</t:layout>


