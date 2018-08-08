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
<button class="btn btn-success pull-right" onClick="avviaMisurazione()">Avvia Misurazione <i class="fa fa-arrow-right"></i></button>

</c:if>
<button class="btn btn-primary pull-left" onClick="aggiungiImpronta()"><i class="fa fa-plus"></i> Aggiungi Impronta</button>
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
<div class="col-xs-1">

<label>Impronta</label>
	<select name="impronta" id="impronta" data-placeholder="Seleziona Impronta..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
		<option value=""></option>
		<c:forEach items="${lista_impronte }" var="impronta">
			<option value="${impronta.id}">${impronta.nome_impronta }</option>
		</c:forEach>
	</select>

</div>

<div class="col-xs-2">
<label>Valore Nominale</label>
	<input name="val_nominale" id="val_nominale" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-2">
<label>Coordinata</label>
	<input name="coordinaa" id="coordinata" type="text" class="form-control" style="width:100%" required>
</div>
<div class="col-xs-1">
<label>Simbolo</label>
	<select name="simbolo" id="simbolo" data-placeholder="Seleziona Simbolo..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
		<option value=""></option>
		<c:forEach items="${lista_simboli }" var="simbolo">
			<option value="${simbolo.id}">${simbolo.descrizione }</option>
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
	<select name="quota_funzionale" id="quota_funzionale" data-placeholder="Seleziona Quota Funzionale..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%" required>
		<option value=""></option>
		<c:forEach items="${lista_quote_funzionali }" var="quota_funzionale">
			<option value="${quota_funzionale.id}">${quota_funzionale.descrizione }</option>
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
			<option value=""></option>
			<option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
	</select>
	<!-- <input name="sigla_tolleranza" id="sigla_tolleranza" type="text" class="form-control" > -->
</div>



</div>

<div class="row">
<div id="pezzo_row"></div>
<a class="btn btn-primary" onClick="nuovaQuota()" style="margin-top:25px">Inserisci Quota</a>
<!-- <button class="btn btn-primary" type="submit" style="margin-top:25px">Inserisci Quota</button> -->
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

      
  
  
  
        <div id="myModalSaveStato" class="modal fade" role="dialog" aria-labelledby="myLargeModalsaveStato">
    <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
     <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Salva Configurazione</h4>
      </div>
       <div class="modal-body">
       Vuoi salvare la configurazione del DDT per la sede selezionata?
  		<div id="empty" class="testo12"></div>
  		 </div>
      <div class="modal-footer">
		<button class="btn btn-primary"  id = "yes_button" onClick="salvaConfigurazione(1)">SI</button>
		<button class="btn btn-primary"  id = "no_button"  onClick="salvaConfigurazione(0)">NO</button>
       
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
</jsp:attribute>



<jsp:attribute name="extra_js_footer">

		 <script type="text/javascript" src="plugins/datepicker/locales/bootstrap-datepicker.it.js"></script> 
		 <script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 
<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
	<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.1/jquery.validate.min.js"></script>

 <script type="text/javascript">
 
 function creaInputPezzo(n_pezzi){
	 var html="";
	 for(var i = 0;i<n_pezzi;i++){		 
		html = html+ '<div class="col-xs-1"><label>Pezzo '+(i+1)+'</label><input name="pezzo_'+(i+1)+'" id="pezzo_'+(i+1)+'" type="text" class="form-control" style="width:100%"></div>';
	 }
	 $('#pezzo_row').html(html);
 }
 
 
 $(document).ready(function(){
	
	 $('.select2').select2();
	 creaInputPezzo(${numero_pezzi});
	 
 });

 $('#impronta').change(function(){
	
	 id_impronta = $('#impronta').val();
	 
	 dataString ="id_impronta="+ id_impronta;
       exploreModal("gestioneRilievi.do?action=dettaglio_impronta",dataString,"#tabella_punti_quota",function(datab,textStatusb){

       });
 });
 
 
   $('#formQuota').on('submit', function(e){
	 e.preventDefault();
	 controllaCampi()
 });  
   
   
   
   
   
   var validator = $("#formQuota").validate({

   	showErrors: function(errorMap, errorList) {
   	  	
   	    this.defaultShowErrors();
/*    	    if($('#val_nominale').hasClass('has-error')){
				$('#cliente').css('background-color', '1px solid #f00');
			} */
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
 
  </script>
  
  
  
  
</jsp:attribute> 
</t:layout>


 
 






