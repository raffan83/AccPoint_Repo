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
      <h1 class="pull-left">
        Ricerca Clienti con Strumenti in scadenza
        
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
	 
			 <div class="form-group">
			 
			 <div class="col-md-4">
	
			<!--  <div class="input">
				                    		<i class="fa fa-calendar"></i> -->
				                  	<!-- </div> -->
								    
			  <div class="form-group">
				 <label for="datarange" class="control-label">Date Ricerca:</label>
					<div class="col-md-10 input-group" >
						<div class="input-group-addon">
				             <i class="fa fa-calendar"></i>
				        </div>				                  	
						 <input type="text" class="form-control " id="datarange" name="datarange" value="">					    
										                     
  					</div>  								
			 </div>	
			 </div>
			 <div class="col-md-2">
			 <label for="datarange" class="control-label">Tipo Rapporto:</label>
			  <select id="tipo_rapporto" class="form-control select2">
								    <option value="0">TUTTI</option>
								     <c:forEach items="${lista_tipo_rapporto}" var="tipo">
								    <option value="${tipo.id }">${tipo.noneRapporto }</option>
								    </c:forEach> 
								    
								    </select>
			 </div>
			 <div class="col-md-2">
			 
			  <span class="input-group-btn">
				                      	<button type="button"  style="margin-top:25px" class="btn btn-info btn-flat" onclick="cercaStrumentiInScadenzaClienti()">Cerca</button>
				                    </span>
			 </div>
			 
			 
			 
<%-- 			 
						        <label for="datarange" class="control-label">Date Ricerca:</label>

						     	<div class="col-md-8 input-group">
						     		<div class="input-group-addon">
				                    		<i class="fa fa-calendar"></i>
				                  	</div>
								    <input type="text" class="form-control" id="datarange" name="datarange" value="">
								    <select id="filtro_tipo" >
								    <option value="0">TUTTI</option>
								    <c:forEach items="lista_tipo_rapporto" var="tipo">
								    <option value="${tipo.id }">${tipo.nome }</option>
								    </c:forEach>
								    
								    </select>
								    
								    <span class="input-group-btn">
				                      	<button type="button" class="btn btn-info btn-flat" onclick="cercaStrumentiInScadenzaClienti()">Cerca</button>
				                    </span>
  								</div>
  								 --%>
  							
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
	
	$('.select2').select2();
	
	$('#tipo_rapporto').val(0);
	$('#tipo_rapporto').change();
	
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


