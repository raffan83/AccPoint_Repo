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
        Lista Configurazioni Clienti
        <!-- <small></small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
     <section class="content">
<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Nuova Configurazione Cliente
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

		<div class="box-body">
		<!-- <form id="nuovaConfigurazioneForm" name="nuovaConfigurazioneForm"> -->
		<form name="nuovaConfigurazioneForm" method="post" id="nuovaConfigurazioneForm" action="gestioneConfigurazioniClienti.do?action=nuovo" enctype="multipart/form-data">
		<div class="row">
	
			<div class="col-md-3">
			<label>Cliente</label>
			<input class="form-control"  style="width:100%" id="cliente" name="cliente" required >
			
		                      <select name="cliente_appoggio" id="cliente_appoggio" class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%;display:none" >
                
                      <c:forEach items="${lista_clienti}" var="cliente">
                     
                           <option value="${cliente.__id}">${cliente.nome}</option> 
                         
                     </c:forEach>

                  </select> 
       			
			</div>
			
			<div class="col-md-3">
			<label>Sede</label>
			<select class="form-control select2" data-placeholder="Seleziona Sede..."  aria-hidden="true" data-live-search="true" style="width:100%" id="sede" name="sede" disabled>
			
			<option value=""></option>
			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
			 <option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo}</option>     
			</c:forEach>
			</select>
			</div>
			<div class="col-xs-1">
			<label>Tutte</label><br>
			<input type="checkbox" id="check_all" name="check_all" />			
			</div>
			<div class="col-md-3">
			<label>Tipo Rapporto</label>
			<select class="form-control select2" data-placeholder="Seleziona Tipo Rapporto..."  aria-hidden="true" data-live-search="true" style="width:100%" id="tipo_rapporto" name="tipo_rapporto" required>
			<c:forEach items="${lista_tipo_rapporto}" var="tipo_rapporto" varStatus="loop">
			<option value=""></option>
			 <option value="${tipo_rapporto.id}">${tipo_rapporto.noneRapporto}</option>     
			</c:forEach>
			</select>
			</div>
			<div id="content_formato_data" style="display:none">
			<div class="col-xs-2">
			<label>Formato Data Anno/Mese</label><br>
			<input type="checkbox" id="check_fmt_data" name="check_fmt_data" />			
			</div>
			</div>
		</div><br>
		<div class="row">


		
				<div class="col-md-3">
				<label>Firma</label>
		<select class="form-control select2" data-placeholder="Seleziona Firma..."  aria-hidden="true" data-live-search="true" style="width:100%" id="firma" name="firma" required>
		<option value=""></option>
		<option value="0">OP + RL</option>
		<option value="1">OP</option>
		<option value="2">OP + RL + CL</option>
		<option value="3">OP + CL</option>		
		
			</select>
		</div>
		
		
				<div class="col-md-3">
		<label>Modello Certificato</label>
		<input type="text" class="form-control" id="modello" name="modello">
		</div>
		
				<div class="col-md-3">
	<label>Revisione Certificato</label>
		<input type="text" class="form-control" id="revisione" name="revisione">
		</div>
		
						<div class="col-md-3">
		<label>Modello Lista Strumenti</label>
		<input type="text" class="form-control" id="modello_lista_strumenti" name="modello_lista_strumenti">
		</div>
		
						<div class="col-md-3">
		<label>Revisione Lista Strumenti</label>
		<input type="text" class="form-control" id="revisione_lista_strumenti" name="revisione_lista_strumenti">
		</div>
		
		
				<div class=col-md-3>
		       <span class="btn btn-primary fileinput-button pull-right" style="margin-top:25px">
		        <i class="glyphicon glyphicon-plus "></i>
		        <span>Seleziona un logo...</span>

		        <input id="fileupload" accept=".jpg,.JPG,.jpeg,.JPEG,.png,.PNG,.btm,.BTM,.tiff,.TIFF"  type="file" name="fileupload" class="form-control" required/>
		   	 </span>
		</div>
		
		<div class=col-md-3>
		       <label style="margin-top:25px">Attezione! Si raccomanda l'uso di un logo di dimensioni 800x400</label>
		</div>
		</div><br><br>
			<div class="row">
		
		<div class="col-md-12">
		<input type="hidden" name="seleziona_tutte" id="seleziona_tutte">
		<input type="hidden" name="formato_mese_anno" id="formato_mese_anno">

			<!-- <a class="btn btn-primary" id="salva_btn" onClick="inserisciNuovaConfigurazione()">Salva</a> -->
			<button class="btn btn-primary pull-right" id="salva_btn" type="submit">Salva</button>
		</div>
		
		</div>
		</form>
	</div>
</div>
</div>
</div>



<div class="row">
      <div class="col-xs-12">

 <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Lista Configurazioni Clienti
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-md-12">

<table id="tabConfigurazioni" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">

<th>Cliente</th>
<th>Sede</th>
<th>Tipo Rapporto</th>
<th>Tipo Firma</th>
<th>Modello Certificato</th>
<th>Revisione Certificato</th>
<th>Modello Lista Strumenti</th>
<th>Revisione Lista Strumenti</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_configurazioni }" var="configurazione" varStatus="loop">
	<tr id="row_${loop.index}">
			
		<td>${configurazione.nome_cliente }</td>
		<td>${configurazione.nome_sede }</td>
		<td>${configurazione.tipo_rapporto.noneRapporto }</td>
		<td>
		<c:choose>
			<c:when test="${configurazione.id_firma == 0}">
			OP + RL
			</c:when>
			<c:when test="${configurazione.id_firma == 1}">
			OP
			</c:when>
			<c:when test="${configurazione.id_firma == 2}">
			OP + RL + CL
			</c:when>
			<c:otherwise>
			OP + CL
			</c:otherwise>
		</c:choose>
		</td>
		<td>${configurazione.modello_certificato }</td>
		<td>${configurazione.revisione_certificato}</td>
		<td>${configurazione.modello_lista_strumenti }</td>
		<td>${configurazione.revisione_lista_strumenti}</td>
		<td>
		<%-- <a class="btn btn-warning" onClick="modalModifica('${configurazione.id_cliente}','${configurazione.nome_cliente}','${configurazione.id_sede }','${configurazione.nome_sede }','${configurazione.tipo_rapporto.id}','${configurazione.nome_file_logo }','${configurazione.id_firma }')"><i class="fa fa-edit"></i></a> --%>
		<a class="btn btn-warning custom toolTip" title="Click per modificare la configurazione"  onClick="modalModifica('${configurazione.id_cliente}','${configurazione.id_sede }','${configurazione.tipo_rapporto.id }','${configurazione.nome_file_logo }','${configurazione.id_firma }','${configurazione.modello_certificato }','${configurazione.revisione_certificato }','${configurazione.modello_lista_strumenti }','${configurazione.revisione_lista_strumenti }','${configurazione.fmt_data_mese_anno }')"><i class="fa fa-edit"></i></a>
		<a class="btn btn-primary custom toolTip" title="Click per scaricare il logo" onClick="callAction('gestioneConfigurazioniClienti.do?action=download_logo&id_cliente=${utl:encryptData(configurazione.id_cliente)}&id_sede=${utl:encryptData(configurazione.id_sede) }&tipo_rapporto=${utl:encryptData(configurazione.tipo_rapporto.id) }')"><i class="fa fa-image"></i></a>
		</td>
	</tr>
	</c:forEach>

 </tbody>
 </table>  

</div>
</div>
</div>
</div>

<form name="modificaConfigurazioneForm" method="post" id="modificaConfigurazioneForm" action="gestioneConfigurazioniClienti.do?action=modifica" enctype="multipart/form-data">
<div id="myModalModifica" class="modal fade modal-fullscreen" role="dialog" aria-labelledby="myLargeModalLabel">
  
    <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Configurazione</h4>
      </div>
       <div class="modal-body">
       <div class="row">
     
       <div class="col-md-3">
			<label>Cliente</label>
				<!-- <input class="form-control"  style="width:100%" id="mod_cliente" name="mod_cliente" required > -->
				<input class="form-control" data-placeholder="Seleziona Cliente..." id="mod_cliente" name="mod_cliente" style="width:100%" required>
<%-- 			<select class="form-control select2" data-placeholder="Seleziona Cliente..."  aria-hidden="true" data-live-search="true" style="width:100%" id="mod_cliente" name="mod_cliente" required>
			<option value=""></option>
			<c:forEach items="${lista_clienti}" var="cliente" varStatus="loop">
			 <option value="${cliente.__id}_${cliente.nome}">${cliente.nome}</option> 
			</c:forEach>
			</select> --%>
			</div>			
			<div class="col-md-3">
			<label>Sede</label>
			<select class="form-control select2" data-placeholder="Seleziona Sede..."  aria-hidden="true" data-live-search="true" style="width:100%" id="mod_sede" name="mod_sede" disabled>
			
			<option value=""></option>
			<c:forEach items="${lista_sedi}" var="sede" varStatus="loop">
			 <%-- <option value="${sede.__id}_${sede.id__cliente_}__${sede.descrizione} - ${sede.indirizzo} ">${sede.descrizione} - ${sede.indirizzo}</option> --%>
			 <option value="${sede.__id}_${sede.id__cliente_}">${sede.descrizione} - ${sede.indirizzo}</option>     
			</c:forEach>
			</select>
			</div>
			<div class="col-md-1">
			<label>Tutte</label><br>
			<input type="checkbox" id="mod_check_all" name="mod_check_all" />			
			</div>
			<div class="col-md-3">
			<label>Tipo Rapporto</label>
			<select class="form-control select2" data-placeholder="Seleziona Tipo Rapporto..."  aria-hidden="true" data-live-search="true" style="width:100%" id="mod_tipo_rapporto" name="mod_tipo_rapporto" required>
			<c:forEach items="${lista_tipo_rapporto}" var="tipo_rapporto" varStatus="loop">
			<option value=""></option>
			 <option value="${tipo_rapporto.id}">${tipo_rapporto.noneRapporto}</option>     
			</c:forEach>
			</select>
			</div>
			
			<div class="col-xs-2" >
			<div id="content_formato_data_mod" style="display:none;margin-bottom:25px">
			<label>Formato Data Anno/Mese</label><br>
			<input type="checkbox" id="check_fmt_data_mod" name="check_fmt_data_mod" />			
			</div>
			</div>
		</div><br>
		<div class="row">
<!-- 		<div class=col-md-5>
		       
		</div> -->
		<!-- <div class="col-md-3">
		
		</div> -->
		<div class="col-md-3">
		<label>Firma</label>
		<select class="form-control select2" data-placeholder="Seleziona Firma..."  aria-hidden="true" data-live-search="true" style="width:100%" id="mod_firma" name="mod_firma" required>
		<option value=""></option>
		<option value="0">OP + RL</option>
		<option value="1">OP</option>
		<option value="2">OP + RL + CL</option>
		<option value="3">OP + CL</option>		
		
			</select>
		</div>
		<div class="col-md-3">
		<label>Modello</label>
		<input type="text" class="form-control" id="modello_mod" name="modello_mod">
		</div>
		
				<div class="col-md-3">
	<label>Revisione</label>
		<input type="text" class="form-control" id="revisione_mod" name="revisione_mod">
		</div>
		<div class="col-md-3">
		<label>Modello Lista Strumenti</label>
		<input type="text" class="form-control" id="modello_lista_strumenti_mod" name="modello_lista_strumenti_mod">
		</div>
		

		
		</div>
		
		 <div class="row"> 
		 						<div class="col-md-3">
		<label>Revisione Lista Strumenti</label>
		<input type="text" class="form-control" id="revisione_lista_strumenti_mod" name="revisione_lista_strumenti_mod">
		</div>
		 
		<div class="col-md-4" style="margin-top:25px">
		<span class="btn btn-primary fileinput-button">
		        <i class="glyphicon glyphicon-plus"></i>
		        <span>Seleziona un logo...</span>

		        <input id="mod_fileupload" accept=".jpg,.JPG,.jpeg,.JPEG,.png,.PNG,.btm,.BTM,.tiff,.TIFF"  type="file" name="mod_fileupload" class="form-control" />
		   	 </span>
		   	 <label id="label_nome_file"></label>
		</div>
		
		<div class="col-md-5" style="margin-top:25px">
		       <label >Attezione! Si raccomanda l'uso di un logo di dimensioni 800x400</label>
		</div>
		 </div> 
		
		<br>
		<div class="row">
		<div class="col-md-12">
		<input type="hidden" name="mod_seleziona_tutte" id="mod_seleziona_tutte">
		<input type="hidden" name="cliente_old" id="cliente_old">
		<input type="hidden" name="sede_old" id="sede_old">
		<input type="hidden" name="tipo_rapporto_old" id="tipo_rapporto_old">
		<input type="hidden" name="formato_mese_anno_mod" id="formato_mese_anno_mod">

			<!-- <a class="btn btn-primary" id="salva_btn" onClick="inserisciNuovaConfigurazione()">Salva</a> -->
			     <button class="btn btn-primary pull-right" id="mod_salva_btn" type="submit">Salva</button>
		</div>
		
		</div>
       

       </div>

  		 </div>
  		 </div>
      <div class="modal-footer">


      </div>
   
  </div>
  </form>
  </div>
</div>

<!-- </div>


</div>
 -->

</section>
</div>
   <t:dash-footer />
   
  <t:control-sidebar />
<!-- ./wrapper -->
</div>
</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">
	<link type="text/css" href="css/bootstrap.min.css" />


</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
<script type="text/javascript" src="plugins/datejs/date.js"></script>
<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-process.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-validate.js"></script>
<script src="plugins/jqueryuploadfile/js/jquery.fileupload-ui.js"></script>
<script src="plugins/fileSaver/FileSaver.min.js"></script>
<script type="text/javascript">
 
 
 
var columsDatatables = [];

$("#tabConfigurazioni").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabConfigurazioni thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabConfigurazioni thead th').eq( $(this).index() ).text();
    	
    	  $(this).append( '<div><input class="inputsearchtable" id="inputsearchtable_'+$(this).index()+'" style="min-width:80px;width=100%" type="text"  value="'+columsDatatables[$(this).index()].search.search+'"/></div>');
    	
    	} );
    
    

} );


$('#mod_fileupload').change(function(){
	var str = $('#mod_fileupload').val();
	$('#label_nome_file').html(str.split("\\")[2]);
});

$('#nuovaConfigurazioneForm').on('submit', function(e){
	 e.preventDefault();

	/*  inserisciNuovaConfigurazione(); */
	 
	  if($('#check_all').prop('checked')){
		 	$('#seleziona_tutte').val("YES");
		 	$('#sede').prop("required", false);
		 	
		 }else{
			 $('#seleziona_tutte').val("NO");
			 $('#sede').prop("required", true);
		 }
		 //$('#nuovaConfigurazioneForm')[0].submit(); 
	  inserisciNuovaConfigurazione();
}); 


$('#tipo_rapporto').change(function(){
	
	var value = $(this).val();
	
	if(value==7201){
		$('#content_formato_data').show();
	}else{
		$('#check_fmt_data').iCheck('uncheck');
		$('#content_formato_data').hide();
	}
	
})

$('#mod_tipo_rapporto').change(function(){
	
	var value = $(this).val();
	
	if(value==7201){
		$('#content_formato_data_mod').show();
	}else{
		$('#check_fmt_data_mod').iCheck('uncheck');
		$('#content_formato_data_mod').hide();
	}
	
})



$('#modificaConfigurazioneForm').on('submit', function(e){
	 e.preventDefault();

	/*  inserisciNuovaConfigurazione(); */
	 
	  if($('#mod_check_all').prop('checked')){
		 	$('#mod_seleziona_tutte').val("YES");
		 	$('#mod_sede').prop("required", false);
		 	
		 }else{
			 $('#mod_seleziona_tutte').val("NO");
			 $('#mod_sede').prop("required", true);
		 }
		 //$('#nuovaConfigurazioneForm')[0].submit(); 
	  modificaConfigurazioneCliente();
}); 

$('#check_all').on('ifChecked', function (ev) {

	$('#sede').prop("required", false);
	$('#sede').prop("disabled", true);
	$('#sede').val("");
	$('#sede').change();
  	});
$('#check_all').on('ifUnchecked', function (ev) {

	$('#sede').prop("required", false);
	$('#sede').prop("disabled", true);

	});
	
$('#mod_check_all').on('ifChecked', function (ev) {

	$('#mod_sede').prop("required", false);
	$('#mod_sede').prop("disabled", true);
	$('#mod_sede').val("");
	$('#mod_sede').change();
  	});
$('#mod_check_all').on('ifUnchecked', function (ev) {

	$('#mod_sede').prop("required", true);
	$('#mod_sede').prop("disabled", false);

	});



$('#check_fmt_data').on('ifChecked', function (ev) {


	$('#formato_mese_anno').val("S");

  	});
$('#check_fmt_data').on('ifUnchecked', function (ev) {

	$('#formato_mese_anno').val("N");
	});

$('#check_fmt_data_mod').on('ifChecked', function (ev) {


	$('#formato_mese_anno_mod').val("S");

  	});
$('#check_fmt_data_mod').on('ifUnchecked', function (ev) {

	$('#formato_mese_anno_mod').val("N");
	});

     $(document).ready(function() {
    	 
    	
    	 initSelect2('#cliente');
    	 initSelect2('#mod_cliente');
    	 
    	 $('#sede').select2();
    	 $('#tipo_rapporto').select2();
    	 $('#firma').select2();
    	 $('#mod_sede').select2();
    	 $('#mod_tipo_rapporto').select2();
    	 $('#mod_firma').select2();
    	 
    	   $('.dropdown-toggle').dropdown();
    	 table = $('#tabConfigurazioni').DataTable({
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

 		    	  
 		               ], 	        
 	  	      buttons: [   
 	  	          {
 	  	            extend: 'colvis',
 	  	            text: 'Nascondi Colonne'  	                   
 	 			  } ]
 		               
 		    });
 		
 		table.buttons().container().appendTo( '#tabConfigurazioni_wrapper .col-sm-6:eq(1)');
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
 		

 	$('#tabConfigurazioni').on( 'page.dt', function () {
 		$('.customTooltip').tooltipster({
 	        theme: 'tooltipster-light'
 	    });
 		
 		$('.removeDefault').each(function() {
 		   $(this).removeClass('btn-default');
 		})


     });
     
     


     });
     
     
     
     
  

     
     $('#cliente').change(function(){
   	    
   	 
    	 if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#sede option').clone());
   	  }
   	  
   	  var selection = $(this).val()
   	 
   	  var id = selection;
   	  
   	  var options = $(this).data('options');

   	  var opt=[];
   	
   	  opt.push("<option value = 0>Non Associate</option>");

   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 
   	
   		if(str.split("_")[1]==id)
   		{

   			opt.push(options[i]);
   		}   
   	   }
   	 $("#sede").prop("disabled", false);
   	 
   	  $('#sede').html(opt);
   	  
   	  $("#sede").trigger("chosen:updated");
   	  

   		$("#sede").change();  

     });
     

    

     
     
     $('#mod_cliente').change(function(){
    	    
       	 
    	 if ($(this).data('options') == undefined) 
   	  {
   	    /*Taking an array of all options-2 and kind of embedding it on the select1*/
   	    $(this).data('options', $('#mod_sede option').clone());
   	  }
   	  
   	  var selection = $(this).val()
   	 
   	  var id = selection;
   	  
   	  var options = $(this).data('options');

   	  var opt=[];
   	
   	  opt.push("<option value = 0>Non Associate</option>");

   	   for(var  i=0; i<options.length;i++)
   	   {
   		var str=options[i].value; 
   	
   		if(str.split("_")[1]==id)
   		{

   			opt.push(options[i]);
   		}   
   	   }
   	 $("#mod_sede").prop("disabled", false);
   	 
   	  $('#mod_sede').html(opt);
   	  
   	  $("#mod_sede").trigger("chosen:updated");
   	  

   		$("#mod_sede").change();  

     });
     
     
     
     
     function modalModifica(id_cliente,  id_sede,  tipo_rapporto, nome_file, firma, modello, revisione, modello_lista_strumenti, revisione_lista_strumenti, formato_anno_data){
    	 
    	
    	 $('#mod_cliente').val(id_cliente);
    	 //	$('#mod_cliente option[value="'+id_cliente+'"').attr("selected", true);
			$('#mod_cliente').change();
    	 
    	 if(id_sede!=0){
    	 	//$('#mod_sede').val(id_sede+"_"+id_cliente+"__"+nome_sede.replace("*","\'"));
    		 $('#mod_sede').val(id_sede+"_"+id_cliente);
    	 }else{
    		 $('#mod_sede').val(0); 
    	 }
    	 $('#mod_sede').change();
    	 
    	 $('#mod_tipo_rapporto').val(tipo_rapporto);
    	 $('#mod_tipo_rapporto').change();
    	
    	 $('#mod_firma').val(firma);
    	 $('#mod_firma').change();
    	 
    	 $('#label_nome_file').html(nome_file);
    	 
  		if(formato_anno_data!=null && formato_anno_data=="S"){
  			$('#content_formato_data_mod').show();
  			$('#check_fmt_data_mod').iCheck("check");
  		}
    	 
    	 $('#cliente_old').val(id_cliente);
    	 $('#sede_old').val(id_sede+"_"+id_cliente);
    	 $('#tipo_rapporto_old').val(tipo_rapporto);
    	 $('#modello_mod').val(modello);
    	 $('#revisione_mod').val(revisione);
    	 $('#modello_lista_strumenti_mod').val(modello_lista_strumenti);
    	 $('#revisione_lista_strumenti_mod').val(revisione_lista_strumenti);
      	 
    	 $('#myModalModifica').modal();
     }
     
     
     var options_cl =  $('#cliente_appoggio option').clone();
     function mockData() {
     	  return _.map(options_cl, function(i) {		  
     	    return {
     	      id: i.value,
     	      text: i.text,
     	    };
     	  });
     	}
     
     
     
     function initSelect2(id_input, placeholder) {
    	  if(placeholder==null){
    		  placeholder = "Seleziona Cliente...";
    	  }

     	$(id_input).select2({
     	    data: mockData(),
     	    placeholder: placeholder,
     	    multiple: false,
     	    // query with pagination
     	    query: function(q) {
     	      var pageSize,
     	        results,
     	        that = this;
     	      pageSize = 20; // or whatever pagesize
     	      results = [];
     	      if (q.term && q.term !== '') {
     	        // HEADS UP; for the _.filter function i use underscore (actually lo-dash) here
     	        results = _.filter(x, function(e) {
     	        	
     	          return e.text.toUpperCase().indexOf(q.term.toUpperCase()) >= 0;
     	        });
     	      } else if (q.term === '') {
     	        results = that.data;
     	      }
     	      q.callback({
     	        results: results.slice((q.page - 1) * pageSize, q.page * pageSize),
     	        more: results.length >= q.page * pageSize,
     	      });
     	    },
     	  });
     }
     
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






