<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
	<%
 	UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 

	String action = (String)request.getSession().getAttribute("action");


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
        Lista Certificati
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
		          <div class="box-header">
		                <div class="row">
		              <div class="col-sm-6">
		              
		                <div class="form-group">
		                  <select name="selectCliente" id="selectCliente" data-placeholder="Seleziona Cliente..."   onchange="filtraCertificati()" class="form-control select2" aria-hidden="true" data-live-search="true">
		                       <option></option>
		                        <option value="0_0">Tutti i clienti</option>
		                      <c:forEach items="${listaClienti}" var="cliente">
		                           <option value="${cliente.key}">${cliente.value}</option>                   
		                     </c:forEach>
		                    </select>
		              </div>
		              </div>
		        <div class="col-sm-4">
		  
		  
		  <div class="form-group">
		                
		 				<select name="selectFiltri" id="selectFiltri" data-placeholder="Seleziona tipologia..."  onchange="filtraVerCertificati()" class="form-control select2" aria-hidden="true" data-live-search="true">
		                             <option>
		                            <c:if test="${userObj.checkPermesso('LISTA_CERTIFICATI_TUTTI_METROLOGIA')}"> 
		         					 	<option value="tutti">Tutte le tipologie</option>
		         					 	</c:if>
		         					 	<c:if test="${userObj.checkPermesso('LISTA_CERTIFICATI_METROLOGIA')}"> 
								          <option value="lavorazione">In lavorazione</option>
								          <option value="chiusi">Chiusi</option>		
								          </c:if>						          
		                     </select>
		
		                   
		              </div>
		  
		</div>
		<div class="col-sm-2">
		  <div class="form-group">
		                      <button type="button" onclick="filtraVerCertificati()" class="btn btn-info btn-flat">Applica</button>
		                    </div>
		</div>
		</div>
          </div>
            <div class="box-body">
            <div class="row">
			<div id="tabellaVerCertificati" class="col-sm-12">
			
			 </div>
			  </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
 





</section>
  </div>
  <!-- /.content-wrapper -->



	
  <t:dash-footer />
  

  <t:control-sidebar />
   

</div>
<!-- ./wrapper -->

</jsp:attribute>


<jsp:attribute name="extra_css">

	<link rel="stylesheet" href="https://cdn.datatables.net/select/1.2.2/css/select.dataTables.min.css">

</jsp:attribute>

<jsp:attribute name="extra_js_footer">
	<script src="https://cdn.datatables.net/select/1.2.2/js/dataTables.select.min.js"></script>
<script>
$(document).ready(function() {
	$('.select2').select2();
	filtraCertificati();
});
</script>
</jsp:attribute> 
</t:layout>
  
 
