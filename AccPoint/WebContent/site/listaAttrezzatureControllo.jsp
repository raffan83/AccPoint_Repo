<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
        Lista Attrezzature
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
	 Lista  Attrezzature
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovaAttrezzatura()"><i class="fa fa-plus"></i> Nuova Attrezzatura</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabAttrezzature" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Tipo Attrezzatura</th>
<th>Descrizione</th>
<th>Codice</th>

<th>Marca</th>
<th>Modello</th>
<th>Portata massima</th>
<th>Frequenza controllo (Mesi)</th>
<th>Data scadenza</th>
<th>Scaduta</th>
<th>Azioni</th>

 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_attrezzature}" var="attrezzatura" varStatus="loop">
	<c:if test="${attrezzatura.disabilitato ==0 }">
	<jsp:useBean id="now" class="java.util.Date"/>
	<c:choose>

	<c:when test="${attrezzatura.data_scadenza lt now}">
	
	<tr id="row_${loop.index}" style="background-color:#FA8989">
	</c:when>
	<c:otherwise>
		<tr id="row_${loop.index}" >
	</c:otherwise>
	</c:choose>
	
 

	<td>${attrezzatura.id }</td>	
	<td>${attrezzatura.tipo.descrizione }</td>
	<td>${attrezzatura.descrizione }</td>
	<td>${attrezzatura.codice }</td>

	<td>${attrezzatura.marca }</td>
		<td>${attrezzatura.modello }</td>
		<td>${attrezzatura.portata_max }</td>		
	<td>${attrezzatura.frequenza_controllo }</td>		
<td><fmt:formatDate pattern="dd/MM/yyyy" value="${attrezzatura.data_scadenza }"></fmt:formatDate></td>	
		<td>
	<c:choose>

	<c:when test="${attrezzatura.data_scadenza lt now}">
	SI
	
	</c:when>
	<c:otherwise>
	NO
	</c:otherwise>
	</c:choose>
	</td>
	
	<td>	

 	  <a class="btn btn-warning customTooltip" onClicK="modalModificaAttrezzatura('${attrezzatura.id }','${attrezzatura.tipo.id }','${utl:escapeJS(attrezzatura.descrizione) }','${utl:escapeJS(attrezzatura.modello) }','${utl:escapeJS(attrezzatura.marca) }','${utl:escapeJS(attrezzatura.codice) }','${attrezzatura.data_scadenza }','${attrezzatura.frequenza_controllo }','${attrezzatura.portata_max }')" title="Click per modificare l'attrezzatura"><i class="fa fa-edit"></i></a>
	  <a class="btn btn-primary customTooltip" onClicK="modalAllegati('${attrezzatura.id }')" title="Click per visualizzare gli allegati"><i class="fa fa-archive"></i></a>
 	<a class="btn btn-danger customTooltip" onClicK="modalEliminaAttrezzatura('${attrezzatura.id }')" title="Click per eliminare l'attrezzatura"><i class="fa fa-trash"></i></a>

	</td >

	</tr>
	</c:if>
	</c:forEach>
	 

 </tbody>
 </table>  
</div>
</div>


</div>

 
</div>
</div>


</section>



<form id="nuovaAttrezzaturaForm" name="nuovoAttrezzaturaForm">
<div id="myModalNuovaAttrezzatura" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuova Attrezzatura</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_attrezzatura" id="tipo_attrezzatura" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipi DPI..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipi_attrezzatura}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       


      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_controllo" id="tipo_controllo" class="form-control select2" aria-hidden="true"  multiple data-placeholder="Seleziona Tipi Controllo" data-live-search="true" style="width:100%" required>
                <option value=""></option>
                       <c:forEach items="${lista_tipi_controllo}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione" name="descrizione" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
                
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Marca</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="marca" name="marca" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello" name="modello" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Portata massima</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="portata_max" name="portata_max" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice" name="codice" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_controllo" name="frequenza_controllo" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br> 
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="data_scadenza" name="data_scadenza" class="form-control datepicker" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br> 
       
   
       
       </div>
  		 
      <div class="modal-footer">
<input type="hidden" id="nuovo_tipo_attrezzatura" name="nuovo_tipo_attrezzatura">
<input type="hidden" id="nuovo_tipo_controllo" name="nuovo_tipo_controllo">
<input type="hidden" id="id_tipi_controllo" name="id_tipi_controllo">
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>




<form id="modificaAttrezzaturaForm" name="modificaAttrezzaturaForm">
<div id="myModalmodificaattrezzatura" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
     <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modifica Attrezzatura</h4>
      </div>
               <div class="modal-body">
       
       
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_attrezzatura_mod" id="tipo_attrezzatura_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Tipo attrezzatura..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_tipi_attrezzatura}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione} </option> 
                         
                     </c:forEach>
				
                  </select> 
       			
       	</div>       	
       </div><br>
       


      <div class="row">
       
       	<div class="col-sm-3">
       		<label>Tipo Controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        
    <select name="tipo_controllo_mod" id="tipo_controllo_mod" class="form-control select2" aria-hidden="true"  multiple data-placeholder="Seleziona Tipi Controllo" data-live-search="true" style="width:100%" required>
                <option value=""></option>
                       <c:forEach items="${lista_tipi_controllo}" var="tipo">
                     
                           <option value="${tipo.id}">${tipo.descrizione}</option> 
                         
                     </c:forEach>

                  </select> 
       			
       	</div>       	
       </div><br>
             
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Descrizione attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="descrizione_mod" name="descrizione_mod" class="form-control" type="text" style="width:100%" required>
       			
       	</div>       	
       </div><br>
       
       
       <div class="row">
       
       	<div class="col-sm-3">
       		<label>Marca</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="marca_mod" name="marca_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Modello</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="modello_mod" name="modello_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
                <div class="row">
       
       	<div class="col-sm-3">
       		<label>Portata massima</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="portata_max_mod" name="portata_max_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Codice</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="codice_mod" name="codice_mod" class="form-control" type="text" style="width:100%" >
       			
       	</div>       	
       </div><br>
       
         <div class="row">
       
       	<div class="col-sm-3">
       		<label>Frequenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <input id="frequenza_controllo_mod" name="frequenza_controllo_mod" class="form-control" type="number" min="0" step="1" style="width:100%" >
       			
       	</div>       	
       </div><br> 
       
<div class="row">
       
       	<div class="col-sm-3">
       		<label>Data scadenza</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <input id="data_scadenza_mod" name="data_scadenza_mod" class="form-control datepicker" type="text" style="width:100%" >
    
       			
       	</div>       	
       </div><br>
   
       
       </div>
  		 

  		 
      <div class="modal-footer">
	<input type="hidden" id="id_attrezzatura" name="id_attrezzatura">
		<input type="hidden" id="nuovo_tipo_attrezzatura_mod" name="nuovo_tipo_attrezzatura_mod">
		<input type="hidden" id="nuovo_tipo_controllo_mod" name="nuovo_tipo_controllo_mod">
		<input type="hidden" id="id_tipi_controllo_mod" name="id_tipi_controllo_mod">
		<input type="hidden" id="id_tipi_controllo_dissocia" name="id_tipi_controllo_dissocia">
		
		<button class="btn btn-primary" type="submit">Salva</button> 
       
      </div>
    </div>
  </div>

</div>

</form>



  <div id="myModalYesOrNo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
      </div>
       <div class="modal-body">       
      	Sei sicuro di voler eliminare l'attrezzatura?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_attrezzatura">
      <a class="btn btn-primary" onclick="eliminaAttrezzatura($('#elimina_attrezzatura').val())" >SI</a>
		<a class="btn btn-primary" onclick="$('#myModalYesOrNo').modal('hide')" >NO</a>
      </div>
    </div>
  </div>

</div>


  <div id="modalNuovoTipoControllo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
   
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci descrizione</h4>
      </div>
       <div class="modal-body">    
       <div class="row">
       <div class="col-xs-12">
         <label>Descrizione</label>
      <input class="form-control" type="text" id="descrizione_nuovo_tipo">
       </div>
       </div>   <br>

    
      	</div>
      <div class="modal-footer">
<input type="hidden" id=isMod>
      <a class="btn btn-primary" onclick="assegnaValoreOpzione()" >Salva</a>
		<a class="btn btn-primary" onclick="$('#modalNuovoTipoControllo').modal('hide')" >Chiudi</a>
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


function modalEliminaAttrezzatura(id_attrezzatura){
	
	
	$('#elimina_attrezzatura').val(id_attrezzatura);
	$('#myModalYesOrNo').modal()
	
}


function eliminaAttrezzatura(){
	
	dataObj = {};
	
	dataObj.id_attrezzatura = $('#elimina_attrezzatura').val();
	
	callAjax(dataObj, "gestioneControlliOperativi.do?action=elimina_attrezzatura");
}

function modalAllegati(id_attrezzatura){
	
	 exploreModal("gestioneControlliOperativi.do","action=lista_allegati&id_attrezzatura="+id_attrezzatura,"#content_allegati", function(datab, textstatus){
		 
		 
		 $('#myModalAllegati').modal();
	 });
	
}



$('#tipo_controllo_mod').on('change', function() {
	  
	var selected = $(this).val();
	var selected_before = $('#id_tipi_controllo_mod').val().split(";");
	var deselected = "";
	

	if(selected!=null && selected.length>0){
		
		for(var i = 0; i<selected_before.length;i++){
			var found = false
			for(var j = 0; j<selected.length;j++){
				if(selected_before[i] == selected[j]){
					found = true;
				}
			}
			if(!found && selected_before[i]!=''){
				deselected = deselected+selected_before[i]+";";
			}
		}
	}else{
		deselected = $('#id_tipi_controllo_mod').val();
	}
	 
	
	$('#id_tipi_controllo_dissocia').val(deselected)
	
  });




function modalNuovaAttrezzatura(){
	
	$('#myModalNuovaAttrezzatura').modal();
	
}

function modalNuovoTipoControllo(){
	
	$('#modalNuovoTipoControllo').modal();
}









function assegnaValoreOpzione(){
	

	
	var data = {
		    id: 0,
		    text: $('#descrizione_nuovo_tipo').val()
		};

		var newOption = new Option(data.text, data.id, false, false);
		var tag = $('#isMod').val();
		

		$('#'+tag).append(newOption).trigger('change');
		$('#'+tag).val(0)
		
		if(tag.includes("tipo_controllo")){
			$('#nuovo_'+tag).val($('#nuovo_'+tag).val()+$('#descrizione_nuovo_tipo').val()+";");
		}else{
			$('#nuovo_'+tag).val($('#descrizione_nuovo_tipo').val());
		}
		
		

		$('#descrizione_nuovo_tipo').val("");
		$('#modalNuovoTipoControllo').modal('hide');
	
}




function modalModificaAttrezzatura(id,id_tipo, descrizione, modello, marca, codice, data_scadenza,frequenza_controllo, portata_max){
	
	dataObj = {};
	
	dataObj.id = id;
	
	callAjax(dataObj, "gestioneControlliOperativi.do?action=dettaglio_attrezzatura", function(datab,textStatusb){
		
		if(datab.success){
			var lista_tipi = datab.attrezzatura.listaTipiControllo;

			for (var i = 0; i < lista_tipi.length; i++) {
				$('#tipo_controllo_mod option[value="'+lista_tipi[i].id+'"]').attr("selected", true);
				$('#tipo_controllo_mod').change();
				
				$('#id_tipi_controllo_mod').val($('#id_tipi_controllo_mod').val()+lista_tipi[i].id+";");
			}
			
		}
		
		
	});
	
	$('#id_attrezzatura').val(id);
	
	
	$('#frequenza_controllo_mod').val(frequenza_controllo);
	$('#tipo_attrezzatura_mod').val(id_tipo);
	$('#tipo_attrezzatura_mod').change();
	$('#marca_mod').val(marca);
	$('#portata_max_mod').val(portata_max);
	
	if(data_scadenza!=null && data_scadenza!=''){
		$('#data_scadenza_mod').val(Date.parse(data_scadenza).toString("dd/MM/yyyy"));	
	}

	$('#modello_mod').val(modello);
	$('#codice_mod').val(codice);
	$('#descrizione_mod').val(descrizione);


	$('#myModalmodificaattrezzatura').modal();
}


function modalCreaRestituzione(id_attrezzatura, quantita){
	
	$('#id_attrezzatura_restituzione').val(id_attrezzatura);
	$('#quantita_rest').attr("max", quantita);
	$('#quantita_rest').val( quantita);
	
	$('#myModalRestituzione').modal();
}


var columsDatatables = [];

$("#tabAttrezzature").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabAttrezzature thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabAttrezzature thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function aggiungiOpzione(tag){


	
	$('#isMod').val(tag);
	
	$('#'+tag).select2('close');
	modalNuovoTipoControllo(tag);
	
}

$(document).ready(function() {
 
//$('.select2').select2();

$('#tipo_attrezzatura')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_attrezzatura\')">Crea Nuovo Tipo Attrezzatura</a>');
});

$('#tipo_attrezzatura_mod')
    .select2()
    .on('select2:open', () => {
        $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_attrezzatura_mod\')">Crea Nuovo Tipo Attrezzatura</a>');
});


$('#tipo_controllo')
.select2()
.on('select2:open', () => {
    $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_controllo\')">Crea Nuovo Tipo Controllo</a>');
});

$('#tipo_controllo_mod')
.select2()
.on('select2:open', () => {
    $(".select2-results:not(:has(a))").append('<a href="#" style="padding: 6px;height: 20px;display: inline-table;" onClick="aggiungiOpzione(\'tipo_controllo_mod\')">Crea Nuovo Tipo Controllo</a>');
});


$('#lavoratore').select2();
$('#lavoratore_mod').select2();
$('#tipo_scheda').select2();
$('#lavoratore_scheda').select2();
$('#company').select2();
$('#company_mod').select2();
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabAttrezzature').DataTable({
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
		    
		      responsive: true,
		      scrollX: false,
		      stateSave: true,	
		           
		      columnDefs: [
		    	  
		    	  { responsivePriority: 1, targets: 10 },
		    	  { responsivePriority: 2, targets: 9 },
		               ], 	        
	  	      buttons: [   
	  	          {
	  	            extend: 'colvis',
	  	            text: 'Nascondi Colonne'  	                   
	 			  }, 
	 			 {
		  	            extend: 'excel',
		  	            text: 'Esporta Excel'  	                   
		 			  }
	 			  ]
		               
		    });
		
		table.buttons().container().appendTo( '#tabAttrezzature_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabAttrezzature').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	 
	 	     

	
	
});


$('#modificaAttrezzaturaForm').on('submit', function(e){
	 e.preventDefault();
	
	if($('#tipo_controllo_mod').val()!=null && $('#tipo_controllo_mod').val()!=''){
		 
		 var values = $('#tipo_controllo_mod').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#id_tipi_controllo_mod').val(ids);
	 }
	 
	 
	 callAjaxForm('#modificaAttrezzaturaForm','gestioneControlliOperativi.do?action=modifica_attrezzatura');
});
 

 
 $('#nuovaAttrezzaturaForm').on('submit', function(e){
	 e.preventDefault();

if($('#tipo_controllo').val()!=null && $('#tipo_controllo').val()!=''){
		 
		 var values = $('#tipo_controllo').val();
		 var ids = "";
		 for(var i = 0;i<values.length;i++){
			 ids = ids + values[i]+";";
		 }
		 
		 $('#id_tipi_controllo').val(ids);
	 }
	 
	 
	 callAjaxForm('#nuovaAttrezzaturaForm','gestioneControlliOperativi.do?action=nuova_attrezzatura');
	 
});


$('#modalScheda').on('hidden.bs.modal', function(){
	
	$('#tipo_scheda').val("");
	$('#tipo_scheda').change();
	$('#lavoratore_scheda').val("");
	$('#lavoratore_scheda').change();
	
});

 
  </script>
  
</jsp:attribute> 
</t:layout>


