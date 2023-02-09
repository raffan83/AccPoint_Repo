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
        Lista Controlli Operativi
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
	 Lista  Controlli Operativi
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">

<div class="row">
<div class="col-xs-12">

<button class="btn btn-primary pull-left" id="attivi_btn" disabled onClick="filtraControlli('NO')"> Attivi</button>
<button class="btn btn-primary pull-left" id="obsoleti_btn"  style="margin-left:5px" onClick="filtraControlli('SI')"> Obsoleti</button>
<button class="btn btn-primary pull-left" id="tutti_btn"  style="margin-left:5px"  onClick="filtraControlli('')">Tutti</button>

<!--  <a class="btn btn-primary pull-right" onClick="modalNuovoIntervento()"><i class="fa fa-plus"></i> Nuovo Intervento</a> --> 
<a class="btn btn-primary pull-right" onClick="modalNuovoControllo()"><i class="fa fa-plus"></i> Nuovo Controllo Operativo</a> 



</div>
</div><br>

<div class="row">
<div class="col-sm-12">

 <table id="tabControlli" class="table table-bordered table-hover dataTable table-striped" role="grid" width="100%">
 <thead><tr class="active">


<th>ID</th>
<th>Attrezzatura</th>
<th>Codice Attrezzatura</th>
<th>Data controllo</th>
<th>Data prossimo controllo</th>
<th>Esito Generale</th>
<th>Note</th>
<th>Stato</th>
<th>Obsoleti</th>
<th>Azioni</th>
 </tr></thead>
 
 <tbody>
 
 	<c:forEach items="${lista_controlli}" var="controllo" varStatus="loop">
	<c:if test="${controllo.disabilitato ==0 }">
	<c:choose>
	<c:when test="${controllo.stato.id==1 }">

 	<tr id="row_${loop.index}">
 	</c:when>
 	<c:when test="${controllo.stato.id==2 }">
	<tr id="row_${loop.index}" style="background-color:#F8F26D" >
	</c:when>
	 	<c:when test="${controllo.stato.id==3 && controllo.obsoleto == 0}">
	<tr id="row_${loop.index}" style="background-color:#FA8989" >
	</c:when>
	<c:otherwise>
	<tr id="row_${loop.index}">
	</c:otherwise>
	</c:choose>
 	

	<td>${controllo.id }</td>	
	<td>${controllo.attrezzatura.descrizione }</td>
	<td>${controllo.attrezzatura.codice }</td>
		<td><fmt:formatDate pattern="dd/MM/yyyy" value="${controllo.data_controllo }"></fmt:formatDate></td>	
			<td><fmt:formatDate pattern="dd/MM/yyyy" value="${controllo.data_prossimo_controllo }"></fmt:formatDate></td>	
		<td>
		<c:if test="${controllo.esito_generale.equals('P') }">
		Positivo
		</c:if>
		<c:if test="${controllo.esito_generale.equals('N') }">
		Negativo
		</c:if>
		</td>	
	
	<td>${controllo.note }</td>
<td>${controllo.stato.descrizione }</td>
<td>
<c:if test="${controllo.obsoleto == 1 }">SI</c:if>
<c:if test="${controllo.obsoleto == 0 }">NO</c:if>
</td>
	<td>	
<a class="btn btn-info customTooltip" onClicK="modalModificaControllo('${controllo.id }', '${controllo.attrezzatura.id }', '${controllo.data_controllo}', '${controllo.data_prossimo_controllo }', '${utl:escapeJS(controllo.note) }', '${controllo.attrezzatura.frequenza_controllo }', true)" title="Click per aprire il dettaglio"><i class="fa fa-search"></i></a>
  <a class="btn btn-warning customTooltip" onClicK="modalModificaControllo('${controllo.id }', '${controllo.attrezzatura.id }', '${controllo.data_controllo}', '${controllo.data_prossimo_controllo }', '${utl:escapeJS(controllo.note) }', '${controllo.attrezzatura.frequenza_controllo }', false)" title="Click per modificare il controllo"><i class="fa fa-edit"></i></a>
	  <a class="btn btn-danger customTooltip" onClicK="modalEliminaControllo('${controllo.id }')" title="Click per eliminare il controllo"><i class="fa fa-trash"></i></a>
	  <a class="btn btn-primary customTooltip" onClicK="modalDuplicaControllo('${controllo.id }', '${controllo.attrezzatura.id }', '${controllo.data_controllo}', '${controllo.data_prossimo_controllo }', '${utl:escapeJS(controllo.note) }', '${controllo.attrezzatura.frequenza_controllo }', true)" title="Click per duplicare il dettaglio"><i class="fa fa-copy"></i></a>
	  
 	 

	</td>
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



<form id="nuovoControlloForm" name="nuovoControlloForm">
<div id="modalNuovoControllo" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Controllo</h4>
      </div>
       <div class="modal-body">
       
       
             <div class="row">
             
              
       
       	<div class="col-sm-3">
       		<label>Filtra frequenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                   <select name="filtro_frequenza" id="filtro_frequenza" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="width:50%" >
                <option value="0" selected>TUTTE</option>
                <option value="1">MENSILI</option>
                <option value="3">TRIMESTRALI</option>
                <option value="4">QUADRIMESTRALI</option>
           
				
                  </select> 
    
       			
       	</div>       	
       </div><br>
                    
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
          <div style="display:none"> 
    <select name="attrezzatura_opt" id="attrezzatura_opt" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="display:none">
                <option value=""></option>
                      <c:forEach items="${lista_attrezzature}" var="attrezzatura">
                     <c:if test="${attrezzatura.disabilitato ==0 }">
                           <option value="${attrezzatura.id}_${attrezzatura.frequenza_controllo}">${attrezzatura.descrizione} - ${attrezzatura.codice} - Freq. ${attrezzatura.frequenza_controllo}</option> 
                         </c:if>
                     </c:forEach>
				
                  </select> 
       			
       			
       			</div>
       	<select name="attrezzatura" id="attrezzatura" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="width:100%" required>
       	</select>		
       	</div>       	
       </div><br>
       
       
          <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <input id="data_controllo" name="data_controllo" class="form-control datepicker" type="text"  style="width:100%" >
    
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <input id="data_prossimo_controllo" name="data_prossimo_controllo" class="form-control datepicker" type="text" style="width:100%" >
    
       			
       	</div>       	
       </div><br>
       


      <div class="row">
       <div class="col-sm-12">
       
       
       <div id="content_controlli"></div>
       
       
       </div>
    
       </div><br>
             
             
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="5" style="width:100%" id="note" class="form-control "name="note"></textarea>
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




<form id="modificaControlloForm" name="nuovoControlloForm">
<div id="modalModificaControllo" class="modal fade" role="dialog" aria-labelledby="myLargeModal">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" id="close_button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#modalModificaControllo').modal('hide')"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="modalModificaLabel">Modifica Controllo</h4>
      </div>
       <div class="modal-body">
       
          <div class="row">
             
              
       
       	<div class="col-sm-3">
       		<label>Filtra frequenza controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                   <select name="filtro_frequenza_mod" id="filtro_frequenza_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="width:50%" >
                <option value="0" selected>TUTTE</option>
                <option value="1">MENSILI</option>
                <option value="3">TRIMESTRALI</option>
                <option value="4">QUADRIMESTRALI</option>
           
				
                  </select> 
    
       			
       	</div>       	
       </div><br>
             <div class="row">
       
       	<div class="col-sm-3">
       		<label>Attrezzatura</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        	<select name="attrezzatura_mod" id="attrezzatura_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="width:100%" required>
<%--     <select name="attrezzatura_mod" id="attrezzatura_mod" class="form-control select2" aria-hidden="true"  data-placeholder="Seleziona Attrezzatura..." data-live-search="true" style="width:100%" required >
                <option value=""></option>
                      <c:forEach items="${lista_attrezzature}" var="attrezzatura">
                        <c:if test="${attrezzatura.disabilitato ==0 }">
                           <option value="${attrezzatura.id}">${attrezzatura.descrizione} </option> 
                         </c:if>
                     </c:forEach>
				 --%>
                  </select> 
       			
       	</div>       	
       </div><br>
       
  <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <input id="data_controllo_mod" name="data_controllo_mod" class="form-control datepicker" type="text" style="width:100%" >
    
       			
       	</div>       	
       </div><br>
       
           <div class="row">
       
       	<div class="col-sm-3">
       		<label>Data prossimo controllo</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
                <input id="data_prossimo_controllo_mod" name="data_prossimo_controllo_mod" class="form-control datepicker" type="text" style="width:100%" >
    
       			
       	</div>       	
       </div><br>
       

      <div class="row">
       <div class="col-sm-12">
       
       
       <div id="content_controlli_mod"></div>
       
       
       </div>

       </div><br>
                 
              <div class="row">
       
       	<div class="col-sm-3">
       		<label>Note</label>
       	</div>
       	<div class="col-sm-9">      
       	  	
        <textarea rows="5" style="width:100%" id="note_mod" class="form-control "name="note_mod"></textarea>
       	</div>       	
       </div><br>
       
       </div>
  		 
      <div class="modal-footer">

	<input type="hidden" id="dettaglio" name="dettaglio">
	<input type="hidden" id="id_controllo" name="id_controllo">
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
      	Sei sicuro di voler eliminare il controllo operativo?
      	</div>
      <div class="modal-footer">
      <input type="hidden" id="elimina_controllo">
      <a class="btn btn-primary" onclick="eliminaControllo($('#elimina_controllo').val())" >SI</a>
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


function modalEliminaControllo(id_controllo){
	
	
	$('#elimina_controllo').val(id_controllo);
	$('#myModalYesOrNo').modal()
	
}


function eliminaControllo(){
	
	dataObj = {};
	
	dataObj.id_controllo = $('#elimina_controllo').val();
	
	callAjax(dataObj, "gestioneControlliOperativi.do?action=elimina_controllo");
}




$('#attrezzatura').on('change', function() {
	

	dataObj = {};
	
	dataObj.id = $(this).val();
	
	callAjax(dataObj, "gestioneControlliOperativi.do?action=dettaglio_attrezzatura", function(datab,textStatusb){
		
		var str = "<ul class='list-group list-group-unbordered'><li class='list-group-item'><label>Controllo</label> <label class='pull-right'>Esito</label></li>";

		if(datab.success){
			
			for (var i = 0; i < datab.attrezzatura.listaTipiControllo.length; i++) {
				str = str + "<li  class='list-group-item'><div class='row'> <div class='col-xs-8'>" +datab.attrezzatura.listaTipiControllo[i].descrizione+"</div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(positivo_"+datab.attrezzatura.listaTipiControllo[i].id+")' type='radio' id='positivo_"+datab.attrezzatura.listaTipiControllo[i].id+"' name='positivo_"+datab.attrezzatura.listaTipiControllo[i].id+"'><label class='pull-right'> Positivo</label></div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(negativo_"+datab.attrezzatura.listaTipiControllo[i].id+")' type='radio' id='negativo_"+datab.attrezzatura.listaTipiControllo[i].id+"' name='negativo_"+datab.attrezzatura.listaTipiControllo[i].id+"'><label class='pull-right'> Negativo</label> </div></div></li>"
			}
		
			
			$('#content_controlli').html(str+"</ul>");
			
			frequenza_controllo = datab.attrezzatura.frequenza_controllo;

			$('#data_controllo').val(formatDate(new Date()));
			$('#data_controllo').change();

		}
		
	});
	
});

function filtraControlli(filtro){
	  table
      .columns( 8 )
      .search( filtro )
      .draw();
	  if(filtro==''){
		  $("#obsoleti_btn").prop("disabled",false);
		  $("#attivi_btn").prop("disabled",false);
		  $("#tutti_btn").prop("disabled",true);
	  }
	  else if(filtro=='SI'){
		  $("#obsoleti_btn").prop("disabled",true);
		  $("#attivi_btn").prop("disabled",false);
		  $("#tutti_btn").prop("disabled",false);
	  }
	  else{
		  $("#obsoleti_btn").prop("disabled",false);
		  $("#attivi_btn").prop("disabled",true);
		  $("#tutti_btn").prop("disabled",false);
	  }
	  
	 
}


$('#filtro_frequenza').change(function(){
	
	var tutte_opt = $('#attrezzatura_opt option').clone();
	
	var filtro_opt = [];
	
	
	var value = $(this).val();
	
	if(value == "0"){
		$('#attrezzatura').html(tutte_opt);
	}
	else{
		
		tutte_opt.each(function(index, item){
			filtro_opt.push("<option value=''></option>")
			if(item.value!='' && item.value.split("_")[1]==value){
				filtro_opt.push(item);
			}
		});
		$('#attrezzatura').html(filtro_opt);
	}
	
});



$('#filtro_frequenza_mod').change(function(){
	
	var tutte_opt = $('#attrezzatura_opt option').clone();
	
	var filtro_opt = [];
	
	
	var value = $(this).val();
	
	if(value == "0"){
		$('#attrezzatura_mod').html(tutte_opt);
	}
	else{
		
		tutte_opt.each(function(index, item){
			filtro_opt.push("<option value=''></option>")
			if(item.value!='' && item.value.split("_")[1]==value){
				filtro_opt.push(item);
			}
		});
		$('#attrezzatura_mod').html(filtro_opt);
	}
	
});



var frequenza_controllo;


$('#data_controllo').change(function(){
	
	if(frequenza_controllo!=null && frequenza_controllo !=''){
		
		var date = $('#data_controllo').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_prossimo_controllo').val(formatDate(c));
			    $('#datepicker_data_prossimo_controllo').datepicker("setDate", c );
			
		}
	}
	
	
});

$('#data_controllo_mod').change(function(){
	
	if(frequenza_controllo!=null && frequenza_controllo !=''){
		
		var date = $('#data_controllo_mod').val();
		var d = moment(date, "DD-MM-YYYY");
		if(date!='' && d._isValid){
			
			   var year = d._pf.parsedDateParts[0];
			   var month = d._pf.parsedDateParts[1];
			   var day = d._pf.parsedDateParts[2];
			   var c = new Date(year, month + parseInt(frequenza_controllo), day);
			    $('#data_prossimo_controllo_mod').val(formatDate(c));
			    $('#datepicker_data_prossimo_controllo_mod').datepicker("setDate", c );
			
		}
	}
	
	
});

function formatDate(data){
	
	   var mydate = new Date(data);
	   
	   if(!isNaN(mydate.getTime())){
	   
		   str = mydate.toString("dd/MM/yyyy");
	   }			   
	   return str;	 		
}


$('#attrezzatura_mod').on('change', function() {
	

	dataObj = {};
	
	dataObj.id_attrezzatura = $(this).val();
	dataObj.esito = 1; 
	
	callAjax(dataObj, "gestioneControlliOperativi.do?action=lista_controlli_attrezzatura", function(datab,textStatusb){
		
		var str = "<ul class='list-group list-group-unbordered'><li class='list-group-item'><label>Controllo</label> <label class='pull-right'>Esito</label></li>";

		if(datab.success){
			
			for (var i = 0; i < datab.lista_controlli.length; i++) {
				if(datab.lista_controlli[i].esito == "P"){
					str = str + "<li  class='list-group-item'><div class='row'> <div class='col-xs-8'>" +datab.lista_controlli[i].tipo_controllo.descrizione+"</div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod)' type='radio' id='positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' name='positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' checked><label class='pull-right'> Positivo</label></div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod)' type='radio' id='negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' name='negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod'><label class='pull-right'> Negativo</label> </div></div></li>"	
				}else{
					str = str + "<li  class='list-group-item'><div class='row'> <div class='col-xs-8'>" +datab.lista_controlli[i].tipo_controllo.descrizione+"</div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod)' type='radio' id='positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' name='positivo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod'><label class='pull-right'> Positivo</label></div> <div class='col-xs-2'><input class='pull-right' onClick='clickRadio(negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod)' type='radio' id='negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' name='negativo_"+datab.lista_controlli[i].tipo_controllo.id+"_mod' checked><label class='pull-right'> Negativo</label> </div></div></li>"
				}
				
				
			}
		
			
			$('#content_controlli_mod').html(str+"</ul>");
			
			
		}
		
		if($('#dettaglio').val()=="1"){
		
			$("#modalModificaControllo" ).each(function(){
			    $(this).find(':input').attr("disabled", true) //<-- Should return all input elements in that specific form.
			    
			    
			    $(this).find(':radio').attr('disabled', true);
			    
			    $('#modalModificaLabel').html("Dettaglio Controllo");
			    
			    $('#close_button').attr("disabled", false);
			});	
		}else{
			
			$("#modalModificaControllo" ).each(function(){
			    $(this).find(':input').attr("disabled", false) //<-- Should return all input elements in that specific form.
			    
			    
			    $(this).find(':radio').attr('disabled', false);
			    
			    
			    $('#close_button').attr("disabled", false);
			});	
			  $('#modalModificaLabel').html("Modifica Controllo");
		}
		
		
		$('#modalModificaControllo').modal();
	});
	
});


function clickRadio(element){
	
if(!element.disabled){
	var id = element.id;	

	var mod = "";
	if(id.includes("_mod")){
		mod = "_mod"
	}
		
		if(element.checked){
		
			if(id.includes("positivo")){
				$('#negativo_'+id.split("_")[1]+mod).attr('checked', false);
			}else{
				$('#positivo_'+id.split("_")[1]+mod).attr('checked', false);
			}

		}
		
}	
	

	
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

function modalNuovoControllo(){
	
	$('#modalNuovoControllo').modal();
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


function modalModificaControllo(id,id_attrezzatura, data_controllo, data_prossimo_controllo, note, frequenza, dettaglio){
	
	$('#filtro_frequenza_mod').change();
	

	$('#id_controllo').val(id);
	
	if(data_controllo!=null && data_controllo!=''){
		$('#data_controllo_mod').val(Date.parse(data_controllo).toString("dd/MM/yyyy"));	
	}
	if(data_prossimo_controllo!=null && data_prossimo_controllo!=''){
		$('#data_prossimo_controllo_mod').val(Date.parse(data_prossimo_controllo).toString("dd/MM/yyyy"));	
	}
	
	
	$('#note_mod').val(note);

	frequenza_controllo = frequenza;
	
	$('#attrezzatura_mod').val(id_attrezzatura+"_"+frequenza);

	$('#attrezzatura_mod').change();
		
	
	if(dettaglio){
		
		$('#dettaglio').val(1);
		
	}else{
		
		$('#dettaglio').val(0);
	}
}



function modalDuplicaControllo(id,id_attrezzatura, data_controllo, data_prossimo_controllo, note, frequenza, dettaglio){
	
	$('#filtro_frequenza').change();
	


	if(data_controllo!=null && data_controllo!=''){
		$('#data_controllo').val(Date.parse(data_controllo).toString("dd/MM/yyyy"));	
	}
	if(data_prossimo_controllo!=null && data_prossimo_controllo!=''){
		$('#data_prossimo_controllo').val(Date.parse(data_prossimo_controllo).toString("dd/MM/yyyy"));	
	}
	
	
	$('#note').val(note);

	frequenza_controllo = frequenza;
	
	$('#attrezzatura').val(id_attrezzatura+"_"+frequenza);

	$('#attrezzatura').change();
		
	

	$('#dettaglio').val(0);
	
	$('#modalNuovoControllo').modal()
	
	
	
}





var columsDatatables = [];

$("#tabControlli").on( 'init.dt', function ( e, settings ) {
    var api = new $.fn.dataTable.Api( settings );
    var state = api.state.loaded();
 
    if(state != null && state.columns!=null){
    		console.log(state.columns);
    
    columsDatatables = state.columns;
    }
    $('#tabControlli thead th').each( function () {
     	if(columsDatatables.length==0 || columsDatatables[$(this).index()]==null ){columsDatatables.push({search:{search:""}});}
    	  var title = $('#tabControlli thead th').eq( $(this).index() ).text();
    	
    	  //if($(this).index()!=0 && $(this).index()!=1){
		    	$(this).append( '<div><input class="inputsearchtable" style="width:100%"  value="'+columsDatatables[$(this).index()].search.search+'" type="text" /></div>');	
	    	//}

    	} );
    
    

} );



function aggiungiOpzione(tag){

/* 	if(mod){
		
		$('#isMod').val(1);
		$('#tipo_attrezzatura_mod').select2('close');
		modalNuovoTipoControllo(true);
	}else{
		$('#isMod').val(0);
		$('#tipo_attrezzatura').select2('close');
		modalNuovoTipoControllo(false);
	} */
	
	$('#isMod').val(tag);
	
	$('#'+tag).select2('close');
	modalNuovoTipoControllo(tag);
	
}

$(document).ready(function() {
	
	
 
	
	$('#filtro_frequenza').change()
	
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


$('.select2').select2();
	
     $('.dropdown-toggle').dropdown();
     $('.datepicker').datepicker({
		 format: "dd/mm/yyyy"
	 }); 

     table = $('#tabControlli').DataTable({
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
		    	  
		    	  { responsivePriority: 1, targets: 9 },
		    	  
		    	  
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
		
		table.buttons().container().appendTo( '#tabControlli_wrapper .col-sm-6:eq(1)');
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
		

	$('#tabControlli').on( 'page.dt', function () {
		$('.customTooltip').tooltipster({
	        theme: 'tooltipster-light'
	    });
		
		$('.removeDefault').each(function() {
		   $(this).removeClass('btn-default');
		})


	});
	
	
	
	

	filtraControlli('NO');
	
});


$('#modificaControlloForm').on('submit', function(e){
	 e.preventDefault();

	 
	 
	 callAjaxForm('#modificaControlloForm','gestioneControlliOperativi.do?action=modifica_controllo');
});
 

 
 $('#nuovoControlloForm').on('submit', function(e){
	 e.preventDefault();


	 
	 callAjaxForm('#nuovoControlloForm','gestioneControlliOperativi.do?action=nuovo_controllo');
	 
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


