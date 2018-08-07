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
<div class="row">
<div class="col-xs-1">
<label>Impronta</label>
	<select name="impronte" id="impronte" data-placeholder="Seleziona Impronta..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_impronte }" var="impronta">
			<option value="${impronta.id}">${impronta.nome_impronta }</option>
		</c:forEach>
	</select>

</div>

<div class="col-xs-2">
<label>Valore Nominale</label>
	<input name="val_nominale" id="val_nominale" type="text" class="form-control" style="width:100%">
</div>
<div class="col-xs-2">
<label>Coordinata</label>
	<input name="coordinata" id="coordinata" type="text" class="form-control" style="width:100%">
</div>
<div class="col-xs-1">
<label>Simbolo</label>
	<select name="simbolo" id="simbolo" data-placeholder="Seleziona Simbolo..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_simboli }" var="simbolo">
			<option value="${simbolo.id}">${simbolo.descrizione }</option>
		</c:forEach>
	</select>

</div>
<div class="col-xs-2">
<label>Tolleranza -</label>
	<input name="tolleranza_neg" id="tolleranza_neg" type="text" class="form-control" style="width:100%">
</div>
<div class="col-xs-2">
<label>Tolleranza +</label>
	<input name="tolleranza_pos" id="tolleranza_pos" type="text" class="form-control" style="width:100%">
</div>

<div class="col-xs-2">
<label>Quota Funzionale</label>
	<select name="quota_funzionale" id="quota_funzionale" data-placeholder="Seleziona Quota Funzionale..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_quote_funzionali }" var="quota_funzionale">
			<option value="${quota_funzionale.id}">${quota_funzionale.descrizione }</option>
		</c:forEach>
	</select>

</div>
<div class="col-xs-1">
<label>Sigla Tolleranza</label>
	<input name="sigla_tolleranza" id="sigla_tolleranza" type="text" class="form-control" style="width:100%">
</div>

</div>
        

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
             

            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        

        
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

 <script type="text/javascript">
 
 $(document).ready(function(){
	
	 $('.select2').select2();
	 
	 
 });

 $('#impronte').change(function(){
	
	 id_impronta = $('#impronte').val();
	 
	 dataString ="id_impronta="+ id_impronta;
       exploreModal("gestioneRilievi.do?action=dettaglio_impronta",dataString,"#tabella_punti_quota",function(datab,textStatusb){

       });
 });
 
  </script>
  
</jsp:attribute> 
</t:layout>


 
 






