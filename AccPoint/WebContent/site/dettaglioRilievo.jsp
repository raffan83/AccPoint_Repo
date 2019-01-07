<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
        Dettaglio Rilievo 
        <small></small>
      </h1>     
         <a class="btn btn-default pull-right"  href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
      <a class="btn btn-default pull-right" style="margin-right:5px" onClick="callAction('listaRilieviDimensionali.do?id_stato_lavorazione=${utl:encryptData(filtro_rilievi)}&cliente_filtro=${utl:encryptData(cliente_filtro) }',null,true)"><i class="fa fa-dashboard"></i> Torna alla lista rilievi</a>
         
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">

        <div class="col-xs-12">
          <div class="box">
          
            <div class="box-body" id="errorePagina">
              
        <c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI')}">    
            <div class="row">
	   <div class="col-xs-12">
	

<a class="btn btn-primary pull-left" onClick="modalNuovaImpronta()"><i class="fa fa-plus"></i> Aggiungi Particolare</a>
<a class="btn btn-primary pull-right disabled" id="mod_particolare_button" onClick="modalModificaParticolare()"><i class="fa fa-pencil"></i> Modifica Particolare</a>

</div></div><br>
</c:if>
 
<div class="row">
<div class="col-xs-12">

<c:if test="${!userObj.checkRuolo('AM') && !userObj.checkPermesso('RILIEVI_DIMENSIONALI')}">
<div class="row">
<div class="col-xs-3">

<c:if test=""></c:if>
<label>Particolare</label>
	<select name="particolare" id="particolare" data-placeholder="Seleziona Particolare..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
		<option value=""></option>
		<c:forEach items="${lista_impronte }" var="particolare" varStatus="loop">
		<c:choose>
		<c:when test="${particolare.nome_impronta!=null && particolare.nome_impronta!='' }">
			<option value="${particolare.id}">${particolare.nome_impronta }</option>
		</c:when>
		<c:otherwise>
			<option value="${particolare.id}">Particolare ${loop.index +1}</option>
		</c:otherwise>
		</c:choose>
			
		</c:forEach>
	</select>

</div>


</div><br>

</c:if>
<%-- <c:if test="${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI')}"> --%>
<div id="operativita" style="display:none">
<div class="box box-danger box-solid">

<div class="box-header with-border">
	 Dettaglio Rilievo
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>

<div class="box-body">
<!-- <form id="formQuota" action="gestioneRilievi.do?action=nuova_quota" method="post" enctype="multipart/form-data"> -->
<form id="formQuota">
<div class="row">
<div class="col-xs-3">

<label>Particolare</label>
	<select name="particolare" id="particolare" data-placeholder="Seleziona Particolare..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
		<option value=""></option>
		<c:forEach items="${lista_impronte }" var="particolare" varStatus="loop">
		<c:choose>
		<c:when test="${particolare.nome_impronta!=null && particolare.nome_impronta!='' }">
			<option value="${particolare.id}">${particolare.nome_impronta }</option>
		</c:when>
		<c:otherwise>
			<option value="${particolare.id}">Particolare ${loop.index +1}</option>
		</c:otherwise>
		</c:choose>
			
		</c:forEach>
	</select>

</div>


</div>

<div class="row">
<div class="col-xs-2">
<label>Valore Nominale</label>
	<input name="val_nominale" id="val_nominale" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-2">
<label>Coordinata</label>
	<input name="coordinata" id="coordinata" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-2">
<label>Simbolo</label>
	<select name="simbolo" id="simbolo" data-placeholder="Seleziona Simbolo..."  class="form-contol select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<option value="Nessuno">Nessuno</option>
		<c:forEach items="${lista_simboli }" var="simbolo">
			<%-- <option value="${simbolo.id}_${simbolo.descrizione }" > ${simbolo.descrizione } </option> --%>
			<option value="${simbolo.id}_${simbolo.descrizione }"> ${simbolo.descrizione }</option>
		</c:forEach>
	</select>

</div>
<div class="col-xs-2">
<label>Campi di lunghezza</label>
	<select name="campi_lunghezza" id="campi_lunghezza"  class="form-contol select2" aria-hidden="true" data-live-search="true" style="width:100%" disabled>
		<option value=""></option>
		<option value="1">Fino a 10</option>
		<option value="2">Oltre 10 fino a 50</option>
		<option value="3">Oltre 50 fino a 120</option>
		<option value="4">Oltre 120 fino a 400</option>
		<option value="5">Oltre 400</option>
	</select>

</div>
<div class="col-xs-2">
<label>Tolleranza -</label>
	<input name="tolleranza_neg" id="tolleranza_neg" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-2">
<label>Tolleranza +</label>
	<input name="tolleranza_pos" id="tolleranza_pos" type="text" class="form-control" style="width:100%" required>
</div>
</div>
<div class="row">
<div class="col-xs-2">
<label>Quota Funzionale</label>
	<select name="quota_funzionale" id="quota_funzionale" data-placeholder="Seleziona Quota Funzionale..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<option value="0_nessuna">Nessuna</option>
		<c:forEach items="${lista_quote_funzionali }" var="quota_funzionale">
			<option value="${quota_funzionale.id}_${quota_funzionale.descrizione }">${quota_funzionale.descrizione }</option>
		</c:forEach>
	</select>

</div>

<%-- <c:if test="${rilievo.tipo_rilievo.id==2 }">
<div class="col-xs-2">
<label>Ripetizioni</label>
	<input name="ripetizioni" id="ripetizioni"  class="form-control" aria-hidden="true" data-live-search="true" style="width:100%">
</div>

<div class="col-xs-2">
<label>Capability</label>
	<input name="capability" id="capability"  class="form-control" aria-hidden="true" data-live-search="true" style="width:100%" value="">
</div>
</c:if> --%>
<c:choose>
<c:when test="${rilievo.tipo_rilievo.id==2 }">
<div class="col-xs-2">
<label>Ripetizioni</label>
	<input name="ripetizioni" id="ripetizioni"  class="form-control" aria-hidden="true" data-live-search="true" style="width:100%">
</div>

<div class="col-xs-2">
<label>Capability</label>
	<input name="capability" id="capability"  class="form-control" aria-hidden="true" data-live-search="true" style="width:100%" >
</div>
</c:when>
<c:otherwise>
<input type="hidden" name="capability" id="capability"  class="form-control" aria-hidden="true" data-live-search="true" style="width:100%" value="">
</c:otherwise>
</c:choose>


<div class="col-xs-2">

<label>Sigla Tolleranza</label>
	<select id="lettera" name="lettera" data-placeholder="Seleziona Lettera..."  class="form-control select2" aria-hidden="true" data-live-search="true" >
			<option value=""></option>
			<option value="A">A</option>
            <option value="B">B</option>
            <option value="C">C</option>
            <option value="CD">CD</option>
            <option value="D">D</option>
            <option value="5">E</option>
            <option value="EF">EF</option>
            <option value="F">F</option>
            <option value="FG">FG</option>
            <option value="G">G</option>
            <option value="H">H</option>
            <option value="JS">JS</option>
            <option value="J">J</option>
            <option value="K">K</option>
            <option value="M">M</option>
            <option value="N">N</option>
            <option value="P">P</option>
            <option value="R">R</option>
            <option value="S">S</option>
            <option value="T">T</option>
            <option value="U">U</option>
            <option value="V">V</option>
            <option value="X">X</option>
            <option value="Y">Y</option>
            <option value="Z">Z</option>
            <option value="ZA">ZA</option>
            <option value="ZB">ZB</option>
            <option value="ZC">ZC</option>
            <option value="a">a</option>
            <option value="b">b</option>
            <option value="c">c</option>
            <option value="cd">cd</option>
            <option value="d">d</option>
            <option value="e">e</option>
            <option value="ef">ef</option>
            <option value="f">f</option>
            <option value="fg">fg</option>
            <option value="g">g</option>
            <option value="h">h</option>
            <option value="js">js</option>
            <option value="j">j</option>
            <option value="k">k</option>
            <option value="m">m</option>
            <option value="n">n</option>
            <option value="p">p</option>
            <option value="r">r</option>
            <option value="s">s</option>
            <option value="t">t</option>
            <option value="u">u</option>
            <option value="v">v</option>
            <option value="x">x</option>
            <option value="y">y</option>
            <option value="z">z</option>
            <option value="za">za</option>
            <option value="zb">zb</option>
            <option value="zc">zc</option>
	</select>
	</div>
	<div class="col-xs-2" style="margin-top:24px">
	<select id = numero name="numero" data-placeholder="Seleziona numero..."  class="form-control select2" aria-hidden="true" data-live-search="true" >

	</select>
</div>
<div class="col-xs-2">
<!-- <a class="btn btn-primary" onClick="validateTolleranza()" style="margin-top:25px">Calcola Tolleranze</a> -->
<c:choose>
<c:when test="${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI')}">
<a class="btn btn-primary" onClick="calcolaTolleranzeForoAlbero()" style="margin-top:25px">Calcola Tolleranze</a>
</c:when>
<c:otherwise>
<a class="btn btn-primary disabled" onClick="calcolaTolleranzeForoAlbero()" style="margin-top:25px">Calcola Tolleranze</a>
</c:otherwise>
</c:choose>
  

</div>


</div>

<div class="row"><br>
<div class="col-xs-12">
<div id="pezzo_row"></div>

</div>
</div><br>


 <div class="row">
<div class="col-xs-6">
<label>Note Particolare</label>
<textarea rows="5" style="width:100%" id="note_part" name="note_part" readonly></textarea>

</div>

<div class="col-xs-6">
<label>Note Quota</label>
<textarea rows="5" style="width:100%" id="note_quota" name="note_quota"></textarea>

</div>

</div> 

<div class="row">
<div class="col-xs-3">
<input type="checkbox" id="applica_tutti" name="applica_tutti" style="margin-top:32px"><label  style="margin-top:32px; margin-left:5px"> Non applicare a tutti</label> 
<input type="hidden" id="id_quota" name="id_quota" value="">
 </div> 
<div class="col-xs-9">
<c:choose>
<c:when test="${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI')}">
<a class="btn btn-primary disabled" id="mod_button" onClick="nuovaQuota()" style="margin-top:25px" >Modifica Quota</a>
<a class="btn btn-primary" id="new_button"  onClick="InserisciNuovaQuota()" style="margin-top:25px">Inserisci Quota</a>
<a class="btn btn-primary disabled" id="xml_button"  onClick="modalXML()" style="margin-top:25px" >Importa da XML</a>
<!-- <a class="btn btn-primary" id="new_button"  onClick="callAction('gestioneRilievi.do?action=importa_da_xml')" style="margin-top:25px">Importa da XML</a> -->

<a class="btn btn-primary pull-right disabled" id="elimina_button"  onClick="eliminaQuota()" style="margin-top:25px">Elimina Quota</a>
</c:when>
<c:otherwise>
<a class="btn btn-primary disabled" id="mod_button" onClick="nuovaQuota()" style="margin-top:25px" >Modifica Quota</a>
<a class="btn btn-primary disabled" id="new_button"  onClick="InserisciNuovaQuota()" style="margin-top:25px">Inserisci Quota</a>
<a class="btn btn-primary disabled" id="xml_button"  onClick="modalXML()" style="margin-top:25px" >Importa da XML</a>
<!-- <a class="btn btn-primary" id="new_button"  onClick="callAction('gestioneRilievi.do?action=importa_da_xml')" style="margin-top:25px">Importa da XML</a> -->

<a class="btn btn-primary pull-right disabled" id="elimina_button"  onClick="eliminaQuota()" style="margin-top:25px">Elimina Quota</a>
</c:otherwise>
</c:choose>


<label id="error_label" style="color:red;margin-top:20px;display:none">Attenzione! Inserisci tutti i valori!</label>
<label id="error_label2" style="color:red;margin-top:20px;display:none">Attenzione! Compila i campi correttamente!</label>
</div>
</div>

</form>

</div>

</div>
</div>
<%-- </c:if> --%>



<div class="box box-danger box-solid">
<div class="box-header with-border">
	 Dettaglio Rilievo
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
<div class="col-xs-12">

<div id="tabella_punti_quota"></div>

</div>

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

      
  
  
  
   <div id="myModalNuovaImpronta" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Particolare</h4>
      </div>
       <div class="modal-body">
         <div class="row">
      	<div class="col-xs-3">
      	<label>Numero Pezzi Per Particolare</label>     	
      	</div>      	
      	<div class="col-xs-9">
      	<c:choose>
      	<c:when test="${rilievo.tipo_rilievo.id==2 }">
      	<input type="number" min="1" class="form-control" id="n_pezzi" name="n_pezzi" style="width:100%" value="1" disabled>
      	</c:when>
      	<c:otherwise>
      		<input type="number" min="1" class="form-control" id="n_pezzi" name="n_pezzi" style="width:100%">
      	</c:otherwise>
      	</c:choose>
      		
      	</div> 
      	</div><br>
		
      	<div class="row">
      	
      	<c:choose>
      	<c:when test="${rilievo.tipo_rilievo.id == 1 }">
      	<div class="col-xs-3">
      	<label>Numero Quote Per Pezzo</label>     	
      	</div>
		<div class="col-xs-9">
      		<input type="number" min="0" class="form-control" id="quote_pezzo" name="quote_pezzo" style="width:100%">
      	</div> 
      	
      	</c:when>
      	<c:otherwise>
      	<div class="col-xs-3">
      	<label>Numero Quote Per Pezzo</label>     	
      	</div>
		<div class="col-xs-3">
      		<input type="number" min="0" class="form-control" id="quote_pezzo" name="quote_pezzo" style="width:100%">
      	</div> 
      	<div class="col-xs-3">
      	<label>Numero Ripetizioni</label>           	
		</div>
		<div class="col-xs-3">
      		<input type="number" min="0" class="form-control" id="ripetizioni" name="ripetizioni" style="width:100%">
      	</div> 
      	</c:otherwise>
      	</c:choose>

      	</div><br> 
      	<div class="row">
      	<div class="col-xs-3">
      	<label>Numero Impronte</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<input type="number" class="form-control" id="numero_impronte" min ="0" name="numero_impronte" style="width:100%">
      	</div> 
      	</div> <br>     
      	
<%--       	<div class="row">
      	<div class="col-xs-3">
      	<label>Note</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<textarea rows="3" style="width:100%" id="note_particolare" name="note_particolare"></textarea>
      	</div> 
      	</div> <br>    --%> 
      		
      	</div>      	

      <div class="modal-footer">
		
		<a class="btn btn-primary"  onClick="modalNomiImpronte()">Salva</a>
      </div>
    </div>
  </div>
</div>


  

   <div id="myModalNomiImpronte" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Inserisci Nomi Impronte</h4>
      </div>
       <div class="modal-body">
		<div id="nomi_body"></div> 

  		 </div>
      <div class="modal-footer">
      <label id="label_errore_nomi" style="color:red;display:none;margin-right:25px">Attenzione! Compila tutti i Campi!</label>
		<a class="btn btn-primary"  onClick="validateNomiImpronta()">Salva</a>
      </div>
    </div>
  </div>
</div>


     <div id="errorMsg"><!-- Place at bottom of page --></div> 
  

</section>
   
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

		<link type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
		<link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" />		
 		<link rel="stylesheet" type="text/css" href="css/handsontable.css" /> 
 		<link href="https://cdn.jsdelivr.net/npm/handsontable@5.0.1/dist/handsontable.full.min.css" rel="stylesheet" media="screen"> 
 		 		
</jsp:attribute>



<jsp:attribute name="extra_js_footer">

		<script src="https://cdn.jsdelivr.net/npm/handsontable@5.0.1/dist/handsontable.full.min.js"></script>
		<!-- <script src="https://cdn.jsdelivr.net/npm/handsontable-pro/dist/handsontable.full.min.js"></script> -->
		<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="plugins/datejs/date.js"></script>
		 <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script> 
		

 		<script type="text/javascript">
 
 function modalNuovaImpronta(){
	 $('#myModalNuovaImpronta').modal();
	 
 }


 
 function validateNomiImpronta(){
	 var esito=true;
	 for(var i = 0; i<$('#numero_impronte').val();i++){
		 if($('#nome_impronta_'+(i+1)).val()==""){
			 $('#nome_impronta_'+(i+1)).css('border', '1px solid #f00');
			 esito=false;
		 }else{
			 $('#nome_impronta_'+(i+1)).css('border', '1px solid #d2d6de');
		 }		 
	 }
	 if(esito){
		 $('#label_errore_nomi').hide();
		 for(var i = 0; i<$('#numero_impronte').val();i++){			
				 $('#nome_impronta_'+(i+1)).css('border', '1px solid #d2d6de');
				 
			 }	
		 salvaImpronta();
	 }else{
		 $('#label_errore_nomi').show();
	 }
 }
 
 function validateParticolare(){
	 var esito = false;
	 
	 if($('#n_pezzi').val()==""){
		 $('#n_pezzi').css('border', '1px solid #f00');
		 esito=false;
	 }else{
		 $('#n_pezzi').css('border', '1px solid #d2d6de');	
		 esito = true;
	 }
	 
	 if(esito){
		 salvaImpronta();
	 }

 }
 
 
 function modalNomiImpronte(){
	

 	 impronte = $('#numero_impronte').val();
	 var string=""
	 if(impronte!="" && impronte!=0){
		 
		 for(var i = 0; i<impronte; i++){
			string = string + '<div class="row"><div class="col-xs-3"><label>Nome Impronta '+(i+1)+'</label></div>'+
			'<div class="col-xs-9"><input type="text" class="form-control" width="100%" id="nome_impronta_'+(i+1)+'" name="nome_impronta_'+(i+1)+'"></div></div><br>';				 
		 }		 
		 
		 $('#nomi_body').html(string);
		 $('#myModalNuovaImpronta').modal('hide');
		 $('#myModalNomiImpronte').modal();
	 }else{
		 //salvaImpronta();
		 validateParticolare();
	 } 
	 
 }

	function validateTolleranza(){
		
		var lettera = $('#lettera').val();
		var numero = $('#numero').val();
		
		var value =  $('#val_nominale').val().replace(",",".");
		if(isNaN(value) || value=="" ){
			$('#error_label2').show();
			$('#val_nominale').css('border', '1px solid #f00');
		}		
		else{
			$('#error_label').hide();
			$('#error_label2').hide();
			calcolaTolleranze();
		}
	}
	
	function InserisciNuovaQuota(){
		 $('#id_quota').val("");	
		 nuovaQuota();
	}


 
 $('#val_nominale').change(function(){
	 $('#error_label').hide();
	 $('#error_label2').hide();
	var numero = $(this).val().replace(",",".");
	
//	calcolaTolleranzeForoAlbero(numero);
	var simbolo = $('#simbolo').val();
	var classe_tolleranza = "${rilievo.classe_tolleranza}";
	var tolleranze = [];
	if(numero != '' && simbolo!="2_ANGOLO" ){
		tolleranze = calcolaTolleranzeSimbolo(numero, simbolo, classe_tolleranza);	
		$('#tolleranza_pos').val(tolleranze[0]);
		$('#tolleranza_neg').val(tolleranze[1]);	
	}
	validateTolleranzeForoAlbero();
	 $('#lettera').val("");
	 $('#lettera').change();
 });
 
 
 function calcolaTolleranzeSimbolo(numero, simbolo, classe_tolleranza){
	 var tolleranze = [];
	 
	 if(simbolo==''|| simbolo =="6_DIAMETRO" || simbolo == "20_RAGGIO" || simbolo=="Nessuno"){
		 if(classe_tolleranza == "f"){
			 if(numero>=0 && numero<=6){
				 tolleranze[0] = 0.05;
				 tolleranze[1] = -0.05;
			 }
			 if(numero>6 && numero<=30){
				 tolleranze[0] = 0.1;
				 tolleranze[1] = -0.1;
			 }
			 else if(numero>30 && numero<=120){
				 tolleranze[0] = 0.15;
				 tolleranze[1] = -0.15;
			 }
			 else if(numero>120 && numero<=400){
				 tolleranze[0] = 0.2;
				 tolleranze[1] = -0.2;
			 }
			 else if(numero>400 && numero<=1000){
				 tolleranze[0] = 0.3;
				 tolleranze[1] = -0.3;
			 }
			 else if(numero>1000 && numero<=2000){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 else{
				 
			 }			
		 }
		 else if(classe_tolleranza == "m"){
			 if(numero>=0 && numero<=6){
				 tolleranze[0] = 0.1;
				 tolleranze[1] = -0.1;
			 }
			 if(numero>6 && numero<=30){
				 tolleranze[0] = 0.2;
				 tolleranze[1] = -0.2;
			 }
			 else if(numero>30 && numero<=120){
				 tolleranze[0] = 0.3;
				 tolleranze[1] = -0.3;
			 }
			 else if(numero>120 && numero<=400){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 else if(numero>400 && numero<=1000){
				 tolleranze[0] = 0.8;
				 tolleranze[1] = -0.8;
			 }
			 else if(numero>1000 && numero<=2000){
				 tolleranze[0] = 1.2;
				 tolleranze[1] = -1.2;
			 }
			 else if(numero>2000 && numero<=4000){
				 tolleranze[0] = 2;
				 tolleranze[1] = -2;
			 }
			 else{
				 
			 }		
		 }
		 else if(classe_tolleranza =="c"){
			 if(numero>=0 && numero<=3){
				 tolleranze[0] = 0.2;
				 tolleranze[1] = -0.2;
			 }
			 if(numero>3 && numero<=6){
				 tolleranze[0] = 0.3;
				 tolleranze[1] = -0.3;
			 }
			 if(numero>6 && numero<=30){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 else if(numero>30 && numero<=120){
				 tolleranze[0] = 0.8;
				 tolleranze[1] = -0.8;
			 }
			 else if(numero>120 && numero<=400){
				 tolleranze[0] = 1.2;
				 tolleranze[1] = -1.2;
			 }
			 else if(numero>400 && numero<=1000){
				 tolleranze[0] = 2;
				 tolleranze[1] = -2;
			 }
			 else if(numero>1000 && numero<=2000){
				 tolleranze[0] = 3;
				 tolleranze[1] = -3;
			 }
			 else if(numero>2000 && numero<=4000){
				 tolleranze[0] = 4;
				 tolleranze[1] = -4;
			 }
			 else{
				 
			 }		
		 }		 
		 else if(classe_tolleranza =="v"){
			 if(numero>=3 && numero<=6){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 if(numero>6 && numero<=30){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }
			 else if(numero>30 && numero<=120){
				 tolleranze[0] = 1.5;
				 tolleranze[1] = -1.5;
			 }
			 else if(numero>120 && numero<=400){
				 tolleranze[0] = 2.5;
				 tolleranze[1] = -2.5;
			 }
			 else if(numero>400 && numero<=1000){
				 tolleranze[0] = 4;
				 tolleranze[1] = -4;
			 }
			 else if(numero>1000 && numero<=2000){
				 tolleranze[0] = 6;
				 tolleranze[1] = -6;
			 }
			 else if(numero>2000 && numero<=4000){
				 tolleranze[0] = 8;
				 tolleranze[1] = -8;
			 }
			 else{
				 
			 }		
		 }
		 
		
	 }
	 else if(simbolo=="21_RAGGIO_SMUSSO"){
		 if(classe_tolleranza=="f" || classe_tolleranza == "m"){
			 if(numero>=0 && numero<=3){
				 tolleranze[0] = 0.2;
				 tolleranze[1] = -0.2;
			 }
			 else if(numero>3 && numero<=6){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 else if(numero>6){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }			 
		 }
		 else if(classe_tolleranza == "c" || classe_tolleranza == "v"){
			 if(numero>=0 && numero<=3){
				 tolleranze[0] = 0.4;
				 tolleranze[1] = -0.4;
			 }
			 else if(numero>3 && numero<=6){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }
			 else if(numero>6){
				 tolleranze[0] = 2;
				 tolleranze[1] = -2;
			 }
		 }		
	 }
	 else if(simbolo=="2_ANGOLO"){
		 if(classe_tolleranza=="f" || classe_tolleranza == "m"){
			 if(numero=="1"){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }
			 else if(numero=="2"){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }
			 else if(numero=="3"){
				 tolleranze[0] = 0.333;
				 tolleranze[1] = -0.333;
			 }	
			 else if(numero=="4"){
				 tolleranze[0] = 0.166;
				 tolleranze[1] = -0.166;
			 }	
			 else if(numero=="5"){
				 tolleranze[0] = 0.083;
				 tolleranze[1] = -0.083;
			 }	
		 }
		 else if(classe_tolleranza=="c"){
			 if(numero=="1"){
				 tolleranze[0] = 1.5;
				 tolleranze[1] = -1.5;
			 }
			 else if(numero=="2"){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }
			 else if(numero=="3"){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }	
			 else if(numero=="4"){
				 tolleranze[0] = 0.25;
				 tolleranze[1] = -0.25;
			 }	
			 else if(numero=="5"){
				 tolleranze[0] = 0.166;
				 tolleranze[1] = -0.166;
			 }	
		 }
		 else if(classe_tolleranza=="v"){
			 if(numero=="1"){
				 tolleranze[0] = 3;
				 tolleranze[1] = -3;
			 }
			 else if(numero=="2"){
				 tolleranze[0] = 2;
				 tolleranze[1] = -2;
			 }
			 else if(numero=="3"){
				 tolleranze[0] = 1;
				 tolleranze[1] = -1;
			 }	
			 else if(numero=="4"){
				 tolleranze[0] = 0.5;
				 tolleranze[1] = -0.5;
			 }	
			 else if(numero=="5"){
				 tolleranze[0] = 0.333;
				 tolleranze[1] = -0.333;
			 }	
		 }
	 }
	 return tolleranze;
 }
 
 
 
 function validateTolleranzeForoAlbero(){	 
	 
		$('#lettera option[value="CD"]').prop("disabled", false);
		$('#lettera option[value="EF"]').prop("disabled", false);
		$('#lettera option[value="FG"]').prop("disabled", false);
		$('#lettera option[value="A"]').prop("disabled", false);
		$('#lettera option[value="B"]').prop("disabled", false);
		$('#lettera option[value="C"]').prop("disabled", false);
		$('#lettera option[value="J"]').prop("disabled", false);
		$('#lettera option[value="V"]').prop("disabled", false);
		$('#lettera option[value="X"]').prop("disabled", false);
		$('#lettera option[value="Y"]').prop("disabled", false);
		$('#lettera option[value="Z"]').prop("disabled", false);
		$('#lettera option[value="ZA"]').prop("disabled", false);
		$('#lettera option[value="ZB"]').prop("disabled", false);
		$('#lettera option[value="ZC"]').prop("disabled", false);
		$('#lettera option[value="T"]').prop("disabled", false);
		$('#lettera option[value="V"]').prop("disabled", false);
		$('#lettera option[value="Y"]').prop("disabled", false);

		$('#lettera option[value="cd"]').prop("disabled", false);
		$('#lettera option[value="ef"]').prop("disabled", false);
		$('#lettera option[value="fg"]').prop("disabled", false);
		$('#lettera option[value="a"]').prop("disabled", false);
		$('#lettera option[value="b"]').prop("disabled", false);
		$('#lettera option[value="c"]').prop("disabled", false);
		$('#lettera option[value="j"]').prop("disabled", false);
		$('#lettera option[value="v"]').prop("disabled", false);
		$('#lettera option[value="x"]').prop("disabled", false);
		$('#lettera option[value="y"]').prop("disabled", false);
		$('#lettera option[value="z"]').prop("disabled", false);
		$('#lettera option[value="za"]').prop("disabled", false);
		$('#lettera option[value="zb"]').prop("disabled", false);
		$('#lettera option[value="zc"]').prop("disabled", false);
		$('#lettera option[value="t"]').prop("disabled", false);
		$('#lettera option[value="v"]').prop("disabled", false);
		$('#lettera option[value="y"]').prop("disabled", false);
		
		$('#numero option[value="9"]').prop("disabled", false);
		$('#numero option[value="8"]').prop("disabled", false);
		
		if($('#val_nominale').val().replace(",",".")!=""){
			if($('#val_nominale').val().replace(",",".")>10 ){
				$('#lettera option[value="CD"]').prop("disabled", true);
				$('#lettera option[value="EF"]').prop("disabled", true);
				$('#lettera option[value="FG"]').prop("disabled", true);
				
				$('#lettera option[value="cd"]').prop("disabled", true);
				$('#lettera option[value="ef"]').prop("disabled", true);
				$('#lettera option[value="fg"]').prop("disabled", true);
			}
			if($('#val_nominale').val().replace(",",".")>500){
				$('#lettera option[value="A"]').prop("disabled", true);
				$('#lettera option[value="B"]').prop("disabled", true);
				$('#lettera option[value="C"]').prop("disabled", true);
				$('#lettera option[value="J"]').prop("disabled", true);
				$('#lettera option[value="V"]').prop("disabled", true);
				$('#lettera option[value="X"]').prop("disabled", true);
				$('#lettera option[value="Y"]').prop("disabled", true);
				$('#lettera option[value="Z"]').prop("disabled", true);
				$('#lettera option[value="ZA"]').prop("disabled", true);
				$('#lettera option[value="ZB"]').prop("disabled", true);
				$('#lettera option[value="ZC"]').prop("disabled", true);
				
				$('#lettera option[value="a"]').prop("disabled", true);
				$('#lettera option[value="b"]').prop("disabled", true);
				$('#lettera option[value="c"]').prop("disabled", true);
				$('#lettera option[value="j"]').prop("disabled", true);
				$('#lettera option[value="v"]').prop("disabled", true);
				$('#lettera option[value="x"]').prop("disabled", true);
				$('#lettera option[value="y"]').prop("disabled", true);
				$('#lettera option[value="z"]').prop("disabled", true);
				$('#lettera option[value="za"]').prop("disabled", true);
				$('#lettera option[value="zb"]').prop("disabled", true);
				$('#lettera option[value="zc"]').prop("disabled", true);		
			}
			if($('#val_nominale').val().replace(",",".")>3 && $('#lettera').val()=="j"){
				$('#numero option[value="8"]').prop("disabled", true);
			}
			if($('#val_nominale').val().replace(",",".")>3 && $('#lettera').val()=="K"){
				$('#numero option[value="9"]').prop("disabled", true);
			}
		
			if($('#val_nominale').val().replace(",",".")<=24){
				$('#lettera option[value="T"]').prop("disabled", true);
				$('#lettera option[value="t"]').prop("disabled", true);
			}
			if($('#val_nominale').val().replace(",",".")<=14){
				$('#lettera option[value="V"]').prop("disabled", true);
				$('#lettera option[value="v"]').prop("disabled", true);
			}
			if($('#val_nominale').val().replace(",",".")<=18){
				$('#lettera option[value="Y"]').prop("disabled", true);
				$('#lettera option[value="y"]').prop("disabled", true);
			}
		
		}
		$('#lettera').select2();
		$('#numero').select2();
 }
 
 
 function calcolaTolleranzeForoAlbero(){
		
		var numero = $('#numero').val();
		if(numero!=null && numero!=""){
			if(isNaN($('#val_nominale').val().replace(",","."))){
				$('#val_nominale').css('border', '1px solid #f00');  
				$('#error_label2').show();
			}else{
				if($('#val_nominale').val().replace(",",".")<=3150){
				 validateTolleranza();
				 $('#error_label').hide();
				 $('#error_label2').hide();
				}else{
					$('#myModalErrorContent').html("Attenzione! Non è possibile inserire un valore maggiore di 3150!");
				  	$('#myModalError').removeClass();
					$('#myModalError').addClass("modal modal-danger");			
				$('#myModalError').modal('show');	
				}
			}
		}
 }
 
 var opt = [];
 
 var permesso;
 

 $(document).ready(function(){	
	 
 	permesso = ${userObj.checkRuolo('AM') || userObj.checkPermesso('RILIEVI_DIMENSIONALI')};
 	if(permesso){
 		$('#operativita').show();
 	}
	 
	 var tipo_rilievo = "${rilievo.tipo_rilievo.id}";
	 
	 if(tipo_rilievo == 1){
		 
		 $('#quota_funzionale option').each(function(){
			
			if($(this).val()!= "" && $(this).val()!="0_nessuna" && $(this).val()!="1_F"){
				$('#quota_funzionale option[value="'+$(this).val()+'"]').remove();
			} 
		 });
		 
	 }
	 
	 
	 
	 opt =document.getElementById('numero').options;
	 $('#error_label').hide();
	 $('#error_label2').hide();
	 $('.select2').select2();

		$("#simbolo").select2({
			templateResult: formatData,
			  templateSelection: formatData
		});
	 
	 

 });

 
	 function formatData (data) {
		  if (!data.id|| data.id=="Nessuno") { return data.text; }
		  if(data.id.split("_")[0]<10){
			  var filename = data.id.substring(2, data.id.length);
		  }else{
			  var filename = data.id.substring(3, data.id.length);
		  }	  
		  var $result= $(
		    '<span><img src="./images/simboli_rilievi/'+filename+'.bmp"/ style="height:28px"> </span>'
		  );
		  return $result;
		};
 $('#particolare').change(function(){
	
	 id_impronta = $('#particolare').val();
	 
	 
	 if(permesso){
	 	$('#mod_particolare_button').removeClass('disabled');
	 }
	  $('#val_nominale').val("");
	  $('#tolleranza_neg').val("");
	  $('#tolleranza_pos').val("");
	  $('#coordinata').val("");
	  $('#note_quota').html("");		
	  $('#capability').html("");
	  
	 dataString ="id_impronta="+ id_impronta;
       exploreModal("gestioneRilievi.do?action=dettaglio_impronta",dataString,"#errorePagina");
       

 });
 
 $('#simbolo').change(function(){
	 $('#tolleranza_pos').val("");
	 $('#tolleranza_neg').val("");
	 if($(this).val()=="2_ANGOLO"){
		 $('#campi_lunghezza').attr('disabled', false);		
		 $('#campi_lunghezza').attr('required', true);
	 }else{
		 $('#campi_lunghezza').val("");
		 $('#campi_lunghezza').change();
		 $('#campi_lunghezza').attr('required', false);		
		 $('#campi_lunghezza').attr('disabled', true);	
		 $('#campi_lunghezza').siblings(".select2-container").css('border', '0px solid #d2d6de');
		 if($('#val_nominale').val()!=''){
			 var tolleranze = calcolaTolleranzeSimbolo($('#val_nominale').val().replace(",","."), $(this).val(), "${rilievo.classe_tolleranza}");
			 $('#tolleranza_pos').val(tolleranze[0]);
			 $('#tolleranza_neg').val(tolleranze[1]);
		 }
	 }
	
 });
 
 
 $('#campi_lunghezza').change(function(){	
	 if($(this).val()!=''){
		 
		 var tolleranze = calcolaTolleranzeSimbolo($(this).val(), "2_ANGOLO", "${rilievo.classe_tolleranza}");
		 $('#tolleranza_pos').val(tolleranze[0]);
		 $('#tolleranza_neg').val(tolleranze[1]);
	 }
 });
 
 
 
   $('#formQuota').on('submit', function(e){
	 e.preventDefault();
 });  
   
   

   
   var validator = $("#formQuota").validate({

   	showErrors: function(errorMap, errorList) {   	  	
   	    this.defaultShowErrors();   	
   	  },
   	  errorPlacement: function(error, element) {
   		$('#error_label2').hide();
   		  $('#error_label').show();
   		 },
   		 
   		    highlight: function(element) {
   		    	if($(element).hasClass('select2')){
   		    		$(element).siblings(".select2-container").css('border', '1px solid #f00');
   		    	}else{
   		    		$(element).css('border', '1px solid #f00');    		        
   		    	}    		        
   		    	
   		    },
   		    unhighlight: function(element) {
   		    	if($(element).hasClass('select2')){
   		    		$(element).siblings(".select2-container").css('border', '0px solid #d2d6de');
   		    	}else{
   		    		$(element).css('border', '1px solid #d2d6de');
   		    	}
   		    	
   		    }
   }); 
 
  
   $('#lettera').change(function(){
	  
	   var lettera = $('#lettera').val();
	  // var opt = $(this).data('options');
	   var new_opt = []
	   new_opt.push('<option value=""></option>');
	   if(lettera=="J"){
		   new_opt.push('<option value="6">6</option>');
		   new_opt.push('<option value="7">7</option>');
		   new_opt.push('<option value="8">8</option>');		   
	   }
	   else if(lettera=="K"){
		   new_opt.push('<option value="8">8</option>');
		   if($('#val_nominale').val()<=3){
		       new_opt.push('<option value="9">9</option>');
		   }else{
			   new_opt.push('<option value="9" disabled>9</option>');
		   }

	   }
	   else if(lettera=="M"){
		   new_opt.push('<option value="8">8</option>');
		   new_opt.push('<option value="9">9</option>');			
	   }
	   else if(lettera=="N"){
		   new_opt.push('<option value="8">8</option>');
		   new_opt.push('<option value="9">9</option>');			  
	   }
	   else if(lettera=="j"){
		   new_opt.push('<option value="5">5</option>');
		   new_opt.push('<option value="6">6</option>');
		   new_opt.push('<option value="7">7</option>');
		   if($('#val_nominale').val()<=3){
			   new_opt.push('<option value="8">8</option>');		   
   			}else{
   				new_opt.push('<option value="8" disabled>8</option>');
   			}
	   } 
	   else{
		   new_opt.push('<option value=""></option>');
		   new_opt.push('<option value="1">1</option>');
		   new_opt.push('<option value="2">2</option>');
		   new_opt.push('<option value="3">3</option>');
		   new_opt.push('<option value="4">4</option>');
		   new_opt.push('<option value="5">5</option>');
		   new_opt.push('<option value="6">6</option>');
		   new_opt.push('<option value="7">7</option>');
		   new_opt.push('<option value="8">8</option>');
		   new_opt.push('<option value="9">9</option>');
		   new_opt.push('<option value="10">10</option>');
		   new_opt.push('<option value="11">11</option>');
		   new_opt.push('<option value="12">12</option>');
	       new_opt.push('<option value="13">13</option>');
		   new_opt.push('<option value="14">14</option>');
		   new_opt.push('<option value="15">15</option>');
		   new_opt.push('<option value="16">16</option>');
		   new_opt.push('<option value="17">17</option>');
	   	   new_opt.push('<option value="18">18</option>');
	   }

	   $('#numero').html(new_opt);	   
	   
   });
   

  </script>
  
  
  
  
</jsp:attribute> 
</t:layout>


 
 






