

<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="it.portaleSTI.DTO.CampioneDTO"%>
<%@page import="it.portaleSTI.DTO.TipoCampioneDTO"%>

<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
  
   
<t:layout title="Dashboard" bodyClass="skin-red-light sidebar-mini wysihtml5-supported">

<jsp:attribute name="body_area">

<div class="wrapper">
	
 

  <!-- Content Wrapper. Contains page content -->
  <div id="corpoframe" class="content-wrapper">
   <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1 class="display-1">
         Ops!! Errore 500
      </h1 >
      
        
    </section>
	<img src="images/error-500.png" class="img-fluid" alt="Responsive image">
    <!-- Main content -->
    <section class="content">
    <h4 class="display-2">Si è verificato un errore durante la gestione della richiesta.</h4>
 
    <p><button class="btn btn-primary" title="Click per inviare il report dell'errore" onClick="sendReport('${error}')">Invia Report</button>&nbsp;<a class="btn btn-primary" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a></p>

  
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

	
</jsp:attribute> 
</t:layout>
  
 
