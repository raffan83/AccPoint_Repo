<%@page import="it.portaleSTI.DTO.CertificatoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

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
       <a class="btn btn-default pull-right" href="/"><i class="fa fa-dashboard"></i> Home</a>
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
		    
		                <div class="form-group" id="form_dom">
		                  <select name="selectCliente" id="selectCliente" data-placeholder="Seleziona Cliente..."   onchange="filtraVerCertificati()" class="form-control select2" data-live-search="true" >
		                       <option></option>
		                       <c:choose>
		                       <c:when test="${userObj.isTras() }">
		                        <option value="${encrypt_0 }">Tutti i clienti</option>
		                        </c:when>
		                        <c:otherwise>
		                         <option value="${encrypt_0 }_${userObj.company.id }">Tutti i clienti</option>
		                        </c:otherwise>
		                        </c:choose>
		                      <c:forEach items="${listaClienti}" var="cliente">
		                        <c:choose>
		                       <c:when test="${userObj.isTras() }">
		                       <option value="${utl:encryptData(cliente.key)}">${cliente.value}</option>  
		                       </c:when>
		                        <c:otherwise>
		                           <option value="${utl:encryptData(cliente.key)}_${utl:encryptData(userObj.company.id) }">${cliente.value}</option>   
		                           </c:otherwise>
		                        </c:choose>                
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
		         					 	 <c:if test="${userObj.checkPermesso('LISTA_CERTIFICATI_VERIFICAZIONE')}">       					 	
								          <option value="lavorazione">In lavorazione</option>
								          </c:if>		
								           <option value="chiusi_0">Chiusi Da Emettere</option>
								           <option value="chiusi_1">Chiusi Emessi</option>		
								           <option value="obsoleti">Obsoleti</option>			          
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

});

$(window).on('beforeunload', function() {
	 document.getElementById("selectCliente").selectedIndex = -1;
	 document.getElementById("selectFiltri").selectedIndex = -1;
	});  
</script>
</jsp:attribute> 
</t:layout>
  
 
