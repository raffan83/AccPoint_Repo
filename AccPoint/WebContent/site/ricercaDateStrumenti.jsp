<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
  <t:main-header  />
  <t:main-sidebar />
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   
<!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Ricerca Clienti con Strumenti in  scadenza
        
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">

<div class="row">
        <div class="col-xs-12">
          <div class="box">
            <div class="box-body">
<div class="row">
	<div class="col-xs-12">
	 
			 <div class="form-group">
						        <label for="datarange" class="control-label">Date Ricerca:</label>

						     	<div class="col-md-4 input-group">
						     		<div class="input-group-addon">
				                    		<i class="fa fa-calendar"></i>
				                  	</div>
								    <input type="text" class="form-control" id="datarange" name="datarange" value="">
								    <span class="input-group-btn">
				                      	<button type="button" class="btn btn-info btn-flat" onclick="cercaStrumentiInScadenzaClienti()">Cerca</button>
				                    </span>
  								</div>
  								
						   </div>



	</div>
</div>
<div class="row">
	<div class="col-xs-12">
	 <div id='tabellaLista' >
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

$(document).ready(function() {
	
 	$('input[name="datarange"]').daterangepicker({
	    locale: {
	      format: 'DD/MM/YYYY'
	    }
	}, 
	function(start, end, label) {
	      /* startDatePicker = start;
	      endDatePicker = end; */
	});
 	
 	cercaStrumentiInScadenzaClienti();
});
	
</script>
</jsp:attribute> 
</t:layout>


