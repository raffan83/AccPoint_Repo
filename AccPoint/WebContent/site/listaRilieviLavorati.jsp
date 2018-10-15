<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!--     <div class="row">
<div class="col-sm-12">
<button class="btn btn-primary" onClick="modalNuovoRilievo()"><i class="fa fa-plus"></i> Nuovo Rilievo</button>

</div>
</div><br> -->
    <div class="row">
<div class="col-sm-12">

 <table id="tabRilievi" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">
<th>ID</th>
<th>Data Inizio Rilievo</th>
<th>Mese di riferimento</th>
<th>Disegno</th>
<th>Variante</th>
<th>Fornitore</th>
<th>Apparecchio</th>
<th>Tipo Rilievo</th>
<th>Stato Rilievo</th>
<th>Cliente</th>
<th>Sede</th>
<th>Commessa</th>
<th>Data Consegna</th>
<th>Utente</th>
<th style="min-width:150px">Azioni</th>
<th>Allegati</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_rilievi }" var="rilievo" varStatus="loop">
	<tr id="row_${loop.index}" >
		<td>${rilievo.id }</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_inizio_rilievo }" /></td>	
		<td>${rilievo.mese_riferimento }</td>
		<td>${rilievo.disegno }</td>
		<td>${rilievo.variante }</td>
		<td>${rilievo.fornitore }</td>
		<td>${rilievo.apparecchio }</td>	
		<td>${rilievo.tipo_rilievo.descrizione }</td>
		<td>${rilievo.stato_rilievo.descrizione }</td>
		<td>${rilievo.nome_cliente_util }</td>
		<td>${rilievo.nome_sede_util }</td>
		<td>${rilievo.commessa}</td>
		<td><fmt:formatDate pattern = "dd/MM/yyyy" value = "${rilievo.data_consegna }" /></td>	
		<td>${rilievo.utente.nominativo }</td>
		<td>
		<a href="#" class="btn btn-info customTooltip" title="Click per aprire il dettaglio del rilievo" onclick="dettaglioRilievo('${rilievo.id}')"><i class="fa fa-search"></i></a>
		<%-- <a href="#" class="btn btn-primary customTooltip" title="Click allegare un file" onclick="modalAllegati('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a> --%>
	<%-- 	<a href="#" class="btn btn-warning customTooltip" title="Click per modificare il rilievo" onclick="modalModificaRilievo('${rilievo.id }','${rilievo.data_inizio_rilievo }','${rilievo.tipo_rilievo.id }','${rilievo.id_cliente_util }','${rilievo.id_sede_util }','${rilievo.commessa}',
		'${rilievo.disegno }', '${rilievo.variante }', '${rilievo.fornitore }', '${rilievo.apparecchio }', '${rilievo.data_inizio_rilievo }')">		
		<i class="fa fa-edit"></i></a>
		<a href="#" class="btn btn-danger customTooltip" title="Click per chiudere il rilievo" onclick="chiudiRilievo('${rilievo.id}')"><i class="glyphicon glyphicon-remove"></i></a> --%>
		</td>
		<td>
		<a href="#" class="btn btn-primary customTooltip" title="Click per allegare un file" onclick="modalAllegati('${rilievo.id }')"><i class="fa fa-arrow-up"></i></a>
		<c:if test="${rilievo.allegato!= null && rilievo.allegato !='' }">
			<a class="btn btn-danger customTooltip" title="Click per scaricare l'allegato" onClick="callAction('gestioneRilievi.do?action=download_allegato&id_rilievo=${rilievo.id}')" ><i class="fa fa-file-pdf-o"></i></a>
		</c:if>
		</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  
</div>
</div>

 <script type="text/javascript">
 
 
 function modalAllegati(id_rilievo){
	 
	 $('#id_rilievo').val(id_rilievo);
	 $('#myModalAllegati').modal();
}
 
 function modalNuovoRilievo(){
	 $('#myModalNuovoRilievo').modal();
 }
 

 function dettaglioRilievo(id_rilievo) {

 	 dataString = "?action=dettaglio&id_rilievo="+id_rilievo+"&cliente_filtro="+$('#cliente_filtro').val()+"&filtro_rilievi=" +$('#filtro_rilievi').val();
	  
	  callAction("gestioneRilievi.do"+dataString, false, false);
 }
	var columsDatatables = [];
	 
	$("#tabRilievi").on( 'init.dt', function ( e, settings ) {
	    var api = new $.fn.dataTable.Api( settings );
	    var state = api.state.loaded();
	 
	    if(state != null && state.columns!=null){
	    		console.log(state.columns);
	    
	    columsDatatables = state.columns;
	    }
	    $('#tabRilievi thead th').each( function () {
	     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
	    	  var title = $('#tabRilievi thead th').eq( $(this).index() ).text();
	    	
	    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
	    	
	    	} );
	    
	    

	} );
	

	
     var validator = $("#nuovoRilievoForm").validate({

    	showErrors: function(errorMap, errorList) {
    	  	
    	    this.defaultShowErrors();
    	    if($('#cliente').hasClass('has-error')){
				$('#cliente').css('background-color', '1px solid #f00');
			}
    	  },
    	  errorPlacement: function(error, element) {
    		  $("#label").show();
    		 },
    		 
    		    highlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
    		    	}else{
    		    		$(element).css('border', '1px solid #f00');    		        
    		    	}    		        
    		    	$('#label').show();
    		    },
    		    unhighlight: function(element) {
    		    	if($(element).hasClass('select2')){
    		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
    		    	}else{
    		    		$(element).css('border', '1px solid #d2d6de');
    		    	}
    		    	
    		    }
    }); 
	
     var validator2 = $("#modificaRilievoForm").validate({

     	showErrors: function(errorMap, errorList) {
     	  	
     	    this.defaultShowErrors();
     	    if($('#mod_cliente').hasClass('has-error')){
 				$('#mod_cliente').css('background-color', '1px solid #f00');
 			}
     	  },
     	  errorPlacement: function(error, element) {
     		  $("#mod_label").show();
     		 },
     		 
     		    highlight: function(element) {
     		    	if($(element).hasClass('select2')){
     		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
     		    	}else{
     		    		$(element).css('border', '1px solid #f00');    		        
     		    	}    		        
     		    	$('#mod_label').show();
     		    },
     		    unhighlight: function(element) {
     		    	if($(element).hasClass('select2')){
     		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
     		    	}else{
     		    		$(element).css('border', '1px solid #d2d6de');
     		    	}
     		    	
     		    }
     }); 
 
 
 
 
$(document).ready(function() {
	 $('#label').hide();
	 $('.select2').select2();
	 
	 $('#mod_label').hide();
	 $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 });
	 
	 $('.dropdown-toggle').dropdown();
	 table = $('#tabRilievi').DataTable({
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

		    	  { responsivePriority: 1, targets: 1 },
		    	  { responsivePriority: 2, targets: 14 }
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  } ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabRilievi_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabRilievi').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
});



$("#cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#sede option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{
			
			//if(opt.length == 0){
		 
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#sede").prop("disabled", false);
	 
	  $('#sede').html(opt);
	  
	  $("#sede").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#sede").change();  
	  //}
	  
	
	});

$("#mod_cliente").change(function() {
	  
	  if ($(this).data('options') == undefined) 
	  {
	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
	    $(this).data('options', $('#mod_sede option').clone());
	  }
	  
	  var selection = $(this).val()	 
	  var id = selection
	  var options = $(this).data('options');

	  var opt=[];
	
	  opt.push("<option value = 0>Non Associate</option>");

	   for(var  i=0; i<options.length;i++)
	   {
		var str=options[i].value; 
	
		//if(str.substring(str.indexOf("_")+1,str.length)==id)
		if(str.substring(str.indexOf("_")+1, str.length)==id)
		{
			
			//if(opt.length == 0){
		 
			//}
		
			opt.push(options[i]);
		}   
	   }
	 $("#mod_sede").prop("disabled", false);
	 
	  $('#mod_sede').html(opt);
	  
	  $("#mod_sede").trigger("chosen:updated");
	  
	  //if(opt.length<2 )
	  //{ 
		$("#mod_sede").change();  
	  //}
	  
	
	});

$('#nuovoRilievoForm').on('submit', function(e){
	 e.preventDefault();

});
$('#modificaRilievoForm').on('submit', function(e){
	 e.preventDefault();
	 modificaRilievo()
});

	</script>