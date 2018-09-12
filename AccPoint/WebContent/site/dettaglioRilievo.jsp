<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
         <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>
         
    </section>
<div style="clear: both;"></div>
    <!-- Main content -->
    <section class="content">

<div class="row">

        <div class="col-xs-12">
          <div class="box">
          
            <div class="box-body">
              
            
            <div class="row">
	   <div class="col-xs-12">
	   <c:if test="${ddt.tipo_ddt.id!=1 }">
<!-- <button class="btn btn-success pull-right" onClick="avviaMisurazione()">Avvia Misurazione <i class="fa fa-arrow-right"></i></button> -->

</c:if>
<button class="btn btn-primary pull-left" onClick="modalNuovaImpronta()"><i class="fa fa-plus"></i> Aggiungi Particolare</button>
</div></div><br>

<div class="row">
<div class="col-xs-12">


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
		<c:forEach items="${lista_impronte }" var="particolare">
		<c:choose>
		<c:when test="${particolare.nome_impronta!=null && particolare.nome_impronta!='' }">
			<option value="${particolare.id}">${particolare.nome_impronta }</option>
		</c:when>
		<c:otherwise>
			<option value="${particolare.id}">${particolare.id }</option>
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
<div class="col-xs-1">
<label>Simbolo</label>
	<select name="simbolo" id="simbolo" data-placeholder="Seleziona Simbolo..."  class="form-contol select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_simboli }" var="simbolo">
			<option value="${simbolo.id}_${simbolo.descrizione }">${simbolo.descrizione }</option>
		</c:forEach>
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

<div class="col-xs-2">
<label>Quota Funzionale</label>
	<select name="quota_funzionale" id="quota_funzionale" data-placeholder="Seleziona Quota Funzionale..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_quote_funzionali }" var="quota_funzionale">
			<option value="${quota_funzionale.id}_${quota_funzionale.descrizione }">${quota_funzionale.descrizione }</option>
		</c:forEach>
	</select>

</div>
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
<a class="btn btn-primary" onClick="validateTolleranza()" style="margin-top:25px">Calcola Tolleranze</a>
</div>


</div>

<div class="row"><br>
<div class="col-xs-12">
<div id="pezzo_row"></div>
<a class="btn btn-primary" onClick="modalNuovoPezzo()" style="margin-top:25px">Aggiungi Pezzo</a>
</div>
</div><br>


<%-- <div class="row">
<div class="col-xs-6">
<label>Note</label>
<textarea rows="5" style="width:100%">${rilievo.note }</textarea>

</div>

</div> --%>

<div class="row">
<div class="col-xs-12">
<input type="hidden" id="id_quota" name="id_quota" value="">
<input type="checkbox" id="applica_tutti" name="applica_tutti" style="margin-top:25px"><label  style="margin-top:25px"> Non applicare a tutti</label>
<a class="btn btn-primary disabled" id="mod_button" onClick="nuovaQuota()" style="margin-top:25px" >Modifica Quota</a>
<a class="btn btn-primary" id="new_button"  onClick="InserisciNuovaQuota()" style="margin-top:25px">Inserisci Quota</a>
<label id="error_label" style="color:red;margin-top:20px;display:none">Attenzione! Inserisci tutti i valori!</label>
<label id="error_label2" style="color:red;margin-top:20px;display:none">Attenzione! Compila i campi correttamente!</label>
</div>
</div>

</form>

</div>
</div>





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
        <h4 class="modal-title" id="myModalLabel">Nuova Impronta</h4>
      </div>
       <div class="modal-body">
         <div class="row">
      	<div class="col-xs-3">
      	<label>Numero Pezzi Per Particolare</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<input type="number" min="0" class="form-control" id="n_pezzi" name="n_pezzi" style="width:100%">
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
      		<input type="number" class="form-control" id="numero_impronte" name="numero_impronte" style="width:100%">
      	</div> 
      	</div> <br>     	
      	</div>      	

      <div class="modal-footer">
		<!-- <button class="btn btn-primary"  onClick="salvaImpronta()">Salva</button> -->
		<button class="btn btn-primary"  onClick="modalNomiImpronte()">Salva</button>
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
		<button class="btn btn-primary"  onClick="validateNomiImpronta()">Salva</button>
      </div>
    </div>
  </div>
</div>



   <div id="myModalNuovoPezzo" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Nuovo Pezzo</h4>
      </div>
       <div class="modal-body">
      	<div class="row">
      	<div class="col-xs-3">
      	<label>Numero Pezzi Da Inserire</label>     	
      	</div>      	
      	<div class="col-xs-9">
      		<input class="form-control" type="number" id="pezzi_da_aggiungere" name="pezzi_da_aggiungere" style="width:100%">
      	</div> 
      	</div><br>

  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  onClick="salvaPezzi()">Salva</button>
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
		<script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
		<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
		<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

 		<script type="text/javascript">
 
 function modalNuovaImpronta(){
	 $('#myModalNuovaImpronta').modal();
	 
 }
 
 function modalNuovoPezzo(){
	 $('#myModalNuovoPezzo').modal();
	 
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
		 salvaImpronta();
	 } 
	 
 }

	function validateTolleranza(){
		
		var lettera = $('#lettera').val();
		var numero = $('#numero').val();
		
		var value =  $('#val_nominale').val().replace(",",".");
		if(isNaN(value) || value==""){
			$('#error_label2').show();
			$('#val_nominale').css('border', '1px solid #f00');    		
		}else{
			$('#error_label').hide();
			$('#error_label2').hide();
			calcolaTolleranze();
		}
	}
	
	function InserisciNuovaQuota(){
		 $('#id_quota').val("");
		 nuovaQuota();
	}

 
 $('#numero').change(function(){
	 $('#error_label').hide();
	 $('#error_label2').hide();
	 if(isNaN($('#val_nominale').val().replace(",","."))){
			$('#val_nominale').css('border', '1px solid #f00');  
			$('#error_label2').show();
	 }else{
		if($('#val_nominale').val().replace(",",".")<=3150){
			 validateTolleranza();
			 $('#error_label').hide();
			}else{
				$('#myModalErrorContent').html("Attenzione! Non è possibile inserire un valore maggiore di 3150!");
			  	$('#myModalError').removeClass();
				$('#myModalError').addClass("modal modal-danger");			
			$('#myModalError').modal('show');	
			}

	 }
 });
 
 
 $('#val_nominale').change(function(){
	 $('#error_label').hide();
	 $('#error_label2').hide();
	var numero = $('#numero').val();
	
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
	
	if($(this).val()!=""){
		if($(this).val().replace(",",".")>10 ){
			$('#lettera option[value="CD"]').prop("disabled", true);
			$('#lettera option[value="EF"]').prop("disabled", true);
			$('#lettera option[value="FG"]').prop("disabled", true);
			
			$('#lettera option[value="cd"]').prop("disabled", true);
			$('#lettera option[value="ef"]').prop("disabled", true);
			$('#lettera option[value="fg"]').prop("disabled", true);
		}
		if($(this).val().replace(",",".")>500){
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
		if($(this).val().replace(",",".")>3 && $('#lettera').val()=="j"){
			$('#numero option[value="8"]').prop("disabled", true);
		}
		if($(this).val().replace(",",".")>3 && $('#lettera').val()=="K"){
			$('#numero option[value="9"]').prop("disabled", true);
		}
	
		if($(this).val().replace(",",".")<=24){
			$('#lettera option[value="T"]').prop("disabled", true);
			$('#lettera option[value="t"]').prop("disabled", true);
		}
		if($(this).val().replace(",",".")<=14){
			$('#lettera option[value="V"]').prop("disabled", true);
			$('#lettera option[value="v"]').prop("disabled", true);
		}
		if($(this).val().replace(",",".")<=18){
			$('#lettera option[value="Y"]').prop("disabled", true);
			$('#lettera option[value="y"]').prop("disabled", true);
		}
	
	}
	

	$('#lettera').select2();
	$('#numero').select2();
	if(numero!=null && numero!=""){
		if(isNaN($(this).val().replace(",","."))){
			$(this).css('border', '1px solid #f00');  
			$('#error_label2').show();
		}else{
			if($(this).val().replace(",",".")<=3150){
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
	
	
	 
 });
 var opt = [];
// var numero_pezzi;
 $(document).ready(function(){
	 
	 opt =document.getElementById('numero').options;
	 $('#error_label').hide();
	 $('#error_label2').hide();
	 $('.select2').select2();
	 
	 
	 var tipo_rilievo = "${particolare.tipo}"
	 

 });

 $('#particolare').change(function(){
	
	 id_impronta = $('#particolare').val();
	 
	 dataString ="id_impronta="+ id_impronta;
       exploreModal("gestioneRilievi.do?action=dettaglio_impronta",dataString,"#tabella_punti_quota",function(datab,textStatusb){
    	   
       });
       

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


 
 






