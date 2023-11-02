<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

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
      <h1 class="pull-left">
        Gestione Tipo Strumento
       
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	Gestione Tipo Strumento
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
	<div class="col-lg-6">
	<a class="btn btn-primary" onClick="modalNuovoTipoStrumento()"><i></i> Nuovo Tipo Strumento</a>
	<a class="btn btn-warning" onClick="modalAggiungiTipoStrumento()"><i></i> Aggiungi Tipo Grandezza</a>
	</div>


	
	</div>
	<br>
	
	<div id="tab_nuovotipoastrumento" style="display:none">
<div class="row">
       	<div class="col-sm-12">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-6">      
       	  	
      	<input class="form-control" style="width:100%" id="descrizione" name="descrizione">
       			
       	</div>    
       	<div class="col-sm-6">
       	<label id="label_presente" style="color:#f00;display:none">Attenzione! Tipo strumento già inserito!</label>
       	<label id="label_vuoto" style="color:#f00;display:none">Attenzione! Inserisci una descrizione!</label>
       	   
       	</div>   	
       </div><br><div class="row">
  
       	<div class="col-sm-8">      
       	
       	
       	<table id="tabTipoGrandezze" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Tipo Grandezza</th>
<th></th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_tipo_grandezza }" var="grandezza" varStatus="loop">
 	<tr id="row_${grandezza.id }">
	<td>${grandezza.nome }</td>	
	<td >
		
		<input type="checkbox" id="id_${grandezza.id }" data-toggle="toggle" data-size="mini" data-on=" " data-off=" "  style="margin-right:2px">
	</td>
	
	
	</tr>
	</c:forEach>
	 

 </tbody>
 </table>  

       			
       	</div>     	
       </div><br>
       
       <div class="row">
       <div class="col-xs-8">
       <button class="btn btn-primary pull-right" id="save_button" disabled onclick="salvaTipoStrumento()">Salva</button>
       </div>
       </div>
	
	</div>
	
	
	
	
	<div id="tab_aggiungitipostrumento" style="display:none">
<div class="row">
       	<div class="col-sm-12">
       		<label>Descrizione</label>
       	</div>
       	<div class="col-sm-6">      
       	
       		<select id="descrizione_mod" name="descrizione_mod" class="form-control select2" data-placeholder="Seleziona Tipo Strumento..." style="width:100%">
       		
       		<option value=""></option>
       		<c:forEach items="${lista_tipo_strumento }" var="tipo" varStatus="loop">
       		<option value="${tipo.id }">${tipo.nome}</option>
       		</c:forEach>
       		</select>
		
       	</div>    
     	
       </div><br><div class="row">
  
       	<div class="col-sm-8">      
       	
       	<div id="posTab"></div>
       	

       			
       	</div>     	
       </div><br>
       

	
	</div>
	
	
	
	
	
	</div>


</div>
</div>




            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 
</div>
</div>
</div>


 
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

 <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet"> 
 
</jsp:attribute>

<jsp:attribute name="extra_js_footer">


<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

 


<script type="text/javascript">  




$('input[type="checkbox"]').on('ifClicked', function (e) {
    
	
	
    $('#'+e.target.id).bootstrapToggle('toggle');
    
    if($(this).prop('checked') && $('#descrizione').val()!=''){
    	
		$('#save_button').attr('disabled', false);
		check_presente();
	}
});


var columsDatatables = [];

$("#tabTipoGrandezze").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabTipoGrandezze thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabTipoGrandezze thead th').eq( $(this).index() ).text();
    	
    	  if($(this).index()==0){
    	  	$(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	  }    	
    	} );
    
    

} );



$('#descrizione_mod').change(function(){
	$('#posTab').html('');
	dataString = "action=grandezze_tipo_strumento&id_tipo_strumento="+$(this).val();
	   exploreModal('gestioneTipoStrumento.do',dataString,'#posTab'); 
	
});


$(document).ready(function(){
	

	$('.select2').select2();
	
	table = $('#tabTipoGrandezze').DataTable({
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
  	        	previous:	"Prec.",
  	        	next:	"Succ.",
  	        last:	"Fine",
	        	},
	        aria:	{
  	        	srtAscending:	": attiva per ordinare la colonna in ordine crescente",
  	        sortDescending:	": attiva per ordinare la colonna in ordine decrescente",
	        }
        },
        pageLength: 10,
        "order": [[ 0, "asc" ]],
	      paging: true, 
	      ordering: true,
	      info: true, 
	      searchable: false, 
	      targets: 0,
	      responsive: true,
	      scrollX: false,
	      stateSave: true,			       
	      columnDefs: [
	    	  {orderable: false, targets: 1} 
	               ], 	        
  	      /* buttons: [   
  	          {
  	            extend: 'colvis',
  	            text: 'Nascondi Colonne'  	                   
 			  } ] */
	               
	    });
	
	table.buttons().container().appendTo( '#tabTipoGrandezze_wrapper .col-sm-6:eq(1)');
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
	

$('#tabTipoGrandezze').on( 'page.dt', function () {
	$('.customTooltip').tooltipster({
        theme: 'tooltipster-light'
    });
	
	$('.removeDefault').each(function() {
	   $(this).removeClass('btn-default');
	})
	
	});
	
	

	
});

function modalNuovoTipoStrumento(){
	
	$('#tab_aggiungitipostrumento').hide();
	$('#tab_nuovotipoastrumento').show();
}

function modalAggiungiTipoStrumento(){
	$('#tab_nuovotipoastrumento').hide();
	$('#tab_aggiungitipostrumento').show();
}


function check_presente(){
	
	$('#descrizione').css('border', '1px solid #d2d6de');
	$('#label_presente').hide();
	$('#save_button').attr('disabled', false);
	
	var tipo_strumenti = ${lista_tipo_strumento_json};
	var descrizione = $('#descrizione').val();
	
	for(var i = 0; i<tipo_strumenti.length;i++){
		if(tipo_strumenti[i].nome.toLowerCase()==descrizione.toLowerCase()){
			
			$('#descrizione').css('border', '1px solid #f00');
			
			$('#label_presente').show();
			
			$('#save_button').attr('disabled', true);
						
		}
	}
	
	
}

$('#descrizione').focusout(function(){
	
	$('#label_vuoto').hide();
	check_presente();
	
});



$('#NuovoTipoStrumentoForm').on('submit', function(e){
	
	e.preventDefault();
	nuovoTipoStrumentoForm();
});


function salvaTipoStrumento(){

	$('#descrizione').css('border', '1px solid #d2d6de');
	$('#label_vuoto').hide();
	$('#save_button').attr('disabled', false);
	
	var descrizione = $('#descrizione').val();
	var tabella = $('#tabTipoGrandezze').DataTable();
	
	var tab_length = tabella.rows();
	if(descrizione!=''){
		var checked = false;
		var ids = "";
		for(var i = 0; i<tabella.rows()[0].length; i++){
			var id_row = tabella.row(i).id();	
			if($('#id_'+id_row.split("_")[1]).prop('checked')){
				ids = ids+id_row.split("_")[1]+";"
				checked = true;
				
			}
		}
		
		if(checked){
			submitTipoStrumento(descrizione, ids);
		}
		
	}else{
		
		$('#descrizione').css('border', '1px solid #f00');	
		$('#label_vuoto').show();
		
		$('#save_button').attr('disabled', true);
		
	}
	
} 




  


</script>

</jsp:attribute> 
</t:layout>