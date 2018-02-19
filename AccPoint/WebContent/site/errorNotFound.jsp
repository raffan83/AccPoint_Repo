<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DAO.SessionFacotryDAO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="org.hibernate.Session"%>
<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>


<t:layout title="Error 404 - Page Not Found" bodyClass="hold-transition login-page">


	<jsp:attribute name="body_area"> 

 
<div class="login-box">




  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 70%">
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <h1 class="login-box-msg">ERRORE 404 </h1>

    <h3 class="login-box-msg">Pagina non trovata </h3>
    
    <p style="text-align:center;"><a  class="btn btn-default" href="./" ><i class="fa fa-home fa-4x" aria-hidden="true"></i></a></p>
       </div>
   </div>
     

</jsp:attribute>

<jsp:attribute name="extra_js_footer"> 

	<script>
	$( document ).ready(function() {
	 
		  	$('#loginForm').validator(); 

	  	  $( "input" ).keydown(function() {
	  		$('#erroMsg').html('');
	  	});
	});
	</script>

</jsp:attribute>

</t:layout>



