<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<t:layout title="Dashboard" bodyClass="skin-green-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   
<!-- Content Header (Page header) -->
    <section class="content-header">
     <h1 class="pull-left">

      Scadenzario Documenti <c:if test="${nome_fornitore!=null && nome_fornitore!='' }"> di ${nome_fornitore }</c:if>
   
      </h1><br><br>
      
        
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
	 <div id="calendario" >
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



$(function () {
	

	var id_fornitore = "${id_fornitore}";
	
	if(id_fornitore==""){
		addCalendarDocumentale(0);
	}else{
		addCalendarDocumentale(id_fornitore);
	}
	
	
	
	

	});
	
	
</script>
 
</jsp:attribute> 
</t:layout>