<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%

%>

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
        Gestione Tabelle
        <small>Gestione delle tabelle del DB</small>
      </h1>
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
    </section>
    <div style="clear: both;"></div>    
  <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
          <div class="box-header">
          
          </div>
            <div class="box-body">

<div class="row">
	<div class="col-xs-12">
	
	 <div id="boxLista" class="box box-danger box-solid">
<div class="box-header with-border">
	Gestione Tabelle
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
</div>
<div class="box-body">
<div class="row">
	<div class="col-lg-6">
	<select name="lista_tabelle" id="lista_tabelle" data-placeholder="Seleziona Tabella..."  class="form-control select2" aria-hidden="true" data-live-search="true" style="width:100%">
		<option value=""></option>
		<c:forEach items="${lista_tabelle}" var="tabella">
			<option value="${tabella}">${tabella}</option>
		</c:forEach>
	</select>
	</div></div><br>
	
	
	<div id="table_view">
	
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



 
  <div  class="modal"><!-- Place at bottom of page --></div> 
   <div id="modal1"><!-- Place at bottom of page --></div> 
   
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">
        <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/bootstrap-datetimepicker.css" /> 
 <link rel="stylesheet" type="text/css" href="plugins/datetimepicker/datetimepicker.css" /> 


</jsp:attribute>

<jsp:attribute name="extra_js_footer">



<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="plugins/datetimepicker/bootstrap-datetimepicker.js"></script> 


<script type="text/javascript">  

$(document).ready(function(){
	
	$('.select2').select2();
});


$('#lista_tabelle').change(function(){

	
	//var selection = $('#lista_tabelle').val();
	dataString = "tabella="+$('#lista_tabelle').val();;
	exploreModal('gestioneTabelle.do?action=mostra_tabella', dataString, '#table_view', null);
	$(document.body).css('padding-right', '0px');

});

$('#myModalError').on('hidden.bs.modal', function(){
	
	if($('#myModalError').hasClass('modal-success')){
		 $('#modificaTabellaModal').modal('hide');
		 $('#lista_tabelle').change();
	}
	
});




</script>

</jsp:attribute> 
</t:layout>