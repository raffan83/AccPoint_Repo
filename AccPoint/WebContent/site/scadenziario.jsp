<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
        Scadenziario ${verificazione!=null ? "Verificazione":"Campioni" }
       <!--  <small>Fai click per prenotare</small> -->
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
            
                <div class="row">
	
	<div class="col-xs-3">
	<div class="btn btn-primary" style="background-color:#00a65a;border-color:#00a65a" onClick="addCalendar(1,${verificazione})"></div><label style="margin-left:5px">Data manutenzione</label>
	</div>
	
	<div class="col-xs-3">
	<div class="btn btn-primary" style="background-color:#777;border-color:#777"  onClick="addCalendar(5, ${verificazione})"></div><label style="margin-left:5px">Data verifica intermedia</label>
	</div>
	

	<div class="col-xs-3">
	<div class="btn btn-primary" style="background-color:#dd4b39;border-color:#dd4b39"  onClick="addCalendar(2,${verificazione})"></div><label style="margin-left:5px">Data taratura</label>
	</div>
	<div class="col-xs-3">
	<a class="btn btn-default pull-right" id="generale_btn" onClick="addCalendar(0,${verificazione})" style="display:none"><i class="fa fa-arrow-left"></i> Torna al generale</a>
	</div>
	
	<div class="col-xs-12">
	
	<!-- <a target="_blank" class="btn btn-danger pull-right" href="listaCampioni.do?action=campioni_scadenza&data_start=+$('#data_start').val()+&data_end=+$('#data_end').val()">Esporta Campioni in scadenza</a> -->
	<a class="btn btn-danger pull-right" onClick="esportaCampioniScadenzario('${verificazione}', '${lat }')">Esporta Campioni in scadenza</a>
	
	</div>
	<div class="col-xs-12">
	 <div id="calendario" >
	</div>
	<div id="calendario2" >
	</div>
	</div>
	
		<input type="hidden" id="data_start">
	<input type="hidden" id="data_end">
</div>

<div class="row">
	<div class="col-xs-12">
	 <div id='calendario' >
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


</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">


</jsp:attribute>

<jsp:attribute name="extra_js_footer">

<script type="text/javascript">


/* $('#button_export').click(function(){
	
	var start = $('#data_start').val();
	var end = $('#data_end').val();	
	
	$('#button_export').attr("href",'listaCampioni.do?action=campioni_scadenza&data_start='+start+'&data_end='+end);
}); */



$(function () {
	
	addCalendar(0, "${verificazione}", "${lat}");

	});
	
	
</script>
</jsp:attribute> 
</t:layout>


