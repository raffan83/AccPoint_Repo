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
     
   
    <c:if test="${scadenzarioGenerale!=1 }">
     Scadenzario attività del campione ${id_campione}
     </c:if>
     <c:if test="${scadenzarioGenerale==1 }">
      
      Scadenzario LAT
     </c:if>
   
        <small>Fai click per visualizzare le scadenze del campione</small>
      </h1><br><br>
      
      <a class="btn btn-default pull-right" style="margin-right:5px;"  href="listaCampioni.do" ><i class="fa fa-arrow-left"></i> Torna ai campioni</a>
   
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
	<c:if test="${scadenzarioGenerale!=1 }">
	<div class="btn btn-primary" style="background-color:#00a65a;border-color:#00a65a" onClick="addCalendarAttivitaCampione(1, '${id_campione}')"></div><label style="margin-left:5px">Data manutenzione</label>
	</c:if>
		<c:if test="${scadenzarioGenerale==1 }">
		<div class="btn btn-primary" style="background-color:#00a65a;border-color:#00a65a" onClick="addCalendarAttivitaCampione(1)"></div><label style="margin-left:5px">Data manutenzione</label>
		</c:if>
	</div>
	<c:if test="${registroEventi!=1 }">
		<div class="col-xs-3">
		<c:if test="${scadenzarioGenerale!=1 }">
		<div class="btn btn-primary" style="background-color:#dd4b39;border-color:#dd4b39"  onClick="addCalendarAttivitaCampione(2, '${id_campione}')"></div><label style="margin-left:5px">Data verifica intermedia</label>
		</c:if>
		<c:if test="${scadenzarioGenerale==1 }">
		<div class="btn btn-primary" style="background-color:#dd4b39;border-color:#dd4b39"  onClick="addCalendarAttivitaCampione(2)"></div><label style="margin-left:5px">Data verifica intermedia</label>
		</c:if>
		</div>
	</c:if>
	<div class="col-xs-3">
	<c:if test="${scadenzarioGenerale!=1 }">
	<div class="btn btn-primary" style="background-color:#777;border-color:#777"  onClick="addCalendarAttivitaCampione(3, '${id_campione}')"></div><label style="margin-left:5px">Data taratura</label>
	</c:if>
		<c:if test="${scadenzarioGenerale==1 }">
	<div class="btn btn-primary" style="background-color:#777;border-color:#777"  onClick="addCalendarAttivitaCampione(3)"></div><label style="margin-left:5px">Data taratura</label>
	</c:if>
	</div>
	<div class="col-xs-3">
	<c:if test="${scadenzarioGenerale!=1 }">
	<a class="btn btn-default pull-right" id="generale_btn" onClick="addCalendarAttivitaCampione(0, '${id_campione}')" style="display:none"><i class="fa fa-arrow-left"></i> Torna al generale</a>
		</c:if>
		<c:if test="${scadenzarioGenerale==1 }">
		<a class="btn btn-default pull-right" id="generale_btn" onClick="addCalendarAttivitaCampione(0)" style="display:none"><i class="fa fa-arrow-left"></i> Torna al generale</a>
		</c:if>
	</div>
	<c:if test="${scadenzarioGenerale==1 }">
	<div class="col-xs-12">
	
	<a class="btn btn-danger pull-right"  onClick="esportaCampioniScadenzario(1)">Esporta Campioni in scadenza</a>
	
	</div>
	</c:if>

	<div class="col-xs-12">
	 <div id="calendario" >
	</div>
	<div id="calendario2" >
	</div>
	</div>
	
	<input type="hidden" id="data_start">
	<input type="hidden" id="data_end">
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
<style>
.btn-circle.btn-xl {
    width: 70px;
    height: 70px;
    padding: 10px 16px;
    border-radius: 35px;
    font-size: 24px;
    line-height: 1.33;
}

.btn-circle {
    width: 30px;
    height: 30px;
    padding: 6px 0px;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 1.42857;
}
</style>
</jsp:attribute>

<jsp:attribute name="extra_js_footer">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>

<script type="text/javascript">




/* $('#button_export').click(function(){
	
	var start = $('#data_start').val();
	var end = $('#data_end').val();	
	
	$('#button_export').attr("href",'listaCampioni.do?action=campioni_scadenza&data_start='+start+'&data_end='+end);
}); */


$(function () {
	
	var registro = false;
	
	if(${registroEventi == '1'}){
		registro = true;
	}
	
	if(${scadenzarioGenerale==1}){
		addCalendarAttivitaCampione(0, null,registro);
	}else{
		addCalendarAttivitaCampione(0, "${id_campione}",registro);	
	}
	

	});
	
	
</script>
 
</jsp:attribute> 
</t:layout>