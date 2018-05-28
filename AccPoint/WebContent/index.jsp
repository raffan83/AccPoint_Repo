<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<%@page import="it.portaleSTI.DAO.SessionFacotryDAO"%>
<%@page import="it.portaleSTI.DTO.TipoTrendDTO"%>
<%@page import="it.portaleSTI.DTO.TrendDTO"%>
<%@page import="org.hibernate.Session"%>
<%@ page import = "javax.servlet.RequestDispatcher" %>
<%@page import="it.portaleSTI.bo.GestioneTrendBO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%
	if (request.getSession().getAttribute("userObj")!=null ) {

		 response.sendRedirect("login.do");
		
/* 		UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
 		Session hsession = SessionFacotryDAO.get().openSession();
		
 		
 		ArrayList<TipoTrendDTO> tipoTrend = (ArrayList<TipoTrendDTO>)GestioneTrendBO.getListaTipoTrendAttivi(hsession);
		String tipoTrendJson = new Gson().toJson(tipoTrend);

		ArrayList<TrendDTO> trend = (ArrayList<TrendDTO>)GestioneTrendBO.getListaTrendAttiviUser(""+utente.getCompany().getId(),hsession);
		Gson gson = new GsonBuilder().setDateFormat("M/yyyy").create();
		String trendJson = gson.toJson(trend);

		request.getSession().setAttribute("tipoTrend", tipoTrend);
		request.getSession().setAttribute("trend", trend);
		request.getSession().setAttribute("trendJson", trendJson);
		request.getSession().setAttribute("tipoTrendJson", tipoTrendJson);
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dashboard.jsp");
    		dispatcher.forward(request,response); */
    		
	}
%>
<t:layout title="Login Page" bodyClass="hold-transition login-page">



	<jsp:attribute name="body_area"> 

  <form id="loginForm" name="frmLogin" method="post" action="">

<div class="login-box">




  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 70%">
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Accedi per iniziare la tua sessione</p>
 <div class="row">
  <div class="col-xs-12">
       <div class="form-group has-feedback control-group">

			<input type="text" name="uid" type="text" class="form-control"
									value="" placeholder="username" id="user" required aria-invalid="false" />
        
        	<span
									class="glyphicon glyphicon-envelope form-control-feedback"></span>
									 <p class="help-block with-errors"></p>
      </div>
      </div>
  <div class="col-xs-12">
      <div class="form-group has-feedback">

        	<input type="password" name="pwd" type="password"
									class="form-control" value="" placeholder="password" id="pass" required aria-invalid="false" />
        
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
         <p class="help-block with-errors"></p>
      </div>
      <c:if test="${not empty errorMessage}">
    <div id="erroMsg" class="form-group has-error">
    <label class="control-label" for="inputError">
                    ${errorMessage}</label>
                 
              </div>
	</c:if>
      </div>
        <div class="col-xs-12">
      
       <div class="form-group">
                	<button id="submitLogin" class="btn btn-primary btn-block btn-flat"
								onclick="Controllo()">Login</button>

      </div>
           </div>
     

      
        <div class="col-xs-12 centered">
       <div class="form-group">

        	<a id="submitLogin" href="passwordReset.do?action=resetView" class="btn btn-primary btn-block btn-flat"
								>Recupera Password</a>
       </div>  
       </div>
    <div class="col-xs-12 centered">
       <div class="form-group">

        	<a id="submitLogin" href="registrazione.do" class="btn btn-primary btn-block btn-flat"
								>Registrati</a>
       </div>  
       </div>
  
  <!-- /.login-box-body -->
</div>

</div>
    
  </div>   
		
		</form>
     <div class="frase">Innovation of quality</div>   

</jsp:attribute>


<jsp:attribute name="extra_css">
<link rel="stylesheet" href="plugins/vegas/vegas.min.css">

</jsp:attribute>


<jsp:attribute name="extra_js_footer"> 
<script src="plugins/vegas/vegas.min.js"></script>
	<script>
	$( document ).ready(function() {
	 
		  	$('#loginForm').validator(); 

	  	  $( "input" ).keydown(function() {
	  		//$('#erroMsg').html('');
	  	});
	  	  
	  	$("body").vegas({
	  	    slides: [
	  	        { src: "images/bg1.png" },
	  	        { src: "images/bg2.png" },
	  	        { src: "images/bg3.png" },
	  	        { src: "images/bg4.png" },
	  	      	{ src: "images/bg5.png" }
	  	    ],
	  		timer:false,
	  		transitionDuration:3000,
	  		animation: 'random'
	  	  
	  	});
	  	  
	  	  
	  	  
	});
	</script>

</jsp:attribute>

</t:layout>



