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
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>

<t:layout title="Login Page" bodyClass="hold-transition login-page">


	<jsp:attribute name="body_area"> 

 
<div class="login-box">




  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 70%">
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Per il primo accesso è necessario inserire una nuova password. </p>
    <p class="login-box-msg" >${username}</p>
 <div class="row">
 
   <div class="col-xs-12">
       <div class="form-group has-feedback control-group">

			<input type="password" name="old_password" type="text" class="form-control"
									value="" placeholder="password provvisoria" id="old_password" required aria-invalid="false" />

        	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
									 
      </div>
      </div>
 
  <div class="col-xs-12">
       <div class="form-group has-feedback control-group">

			<input type="password" name="password" type="text" class="form-control"
									value="" placeholder="password" id="password" required aria-invalid="false" />

        	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
									 
      </div>
      </div>
      
        <div class="col-xs-12">
       <div class="form-group has-feedback control-group">
 
		
									
			<input type="password" name="re_password" type="text" class="form-control"
									value="" placeholder="repeat password" id="re_password" required aria-invalid="false" />
        
        	<span class="glyphicon glyphicon-lock form-control-feedback"></span>
									 
      </div>
      </div>
      
      
  <div class="col-xs-12">
 <div id="erroMsg" class="form-group has-error">
      <c:if test="${not empty errorMessage}">
   
    <label class="control-label" for="inputError">
                    ${errorMessage}</label>
                 
             
	</c:if>
	 </div>
      </div>
        <div class="col-xs-12">
      
       <div class="form-group">
                	<button id="" class="btn btn-danger btn-block btn-flat"	onclick="validatePassword('${id_utente}','${old_password}')">Reset</button>
                	<%-- <button id="" class="btn btn-danger btn-block btn-flat"	onclick="changePassword('${username}','${token}')">Reset</button> --%>

      </div>
           </div>
     
		<p class="login-box-msg" ><a  class="btn btn-default" href="./" ><i class="fa fa-home fa-4x" aria-hidden="true"></i></a></p>
 
 
  
  <!-- /.login-box-body -->
</div>


  <div id="pleaseWaitDialog" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
     <div class="modal-header centered">

        <h4 class="modal-title" id="myModalLabel">Caricamento in corso</h4>
      </div>
       <div class="modal-body centered">

        <img src="images/transitionb.gif" />
        
        	

  		 </div>
      
    </div>
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
	

	
	 function validatePassword(id_utente, old_pwd) {

	    var allLetters = /^[a-zA-Z]+$/;
	    var letter = /[a-zA-Z]/;
	    var number = /[0-9]/;
	  
	    var password = $('#password').val();
	    var old_password = $('#old_password').val();
	    var re_password = $('#re_password').val();
	    var invalid = [];
	    var maiuscole = /[A-Z]/;
	    var minuscole = /[a-z]/;
	    var special = /^\w+$/;
		 $('#old_password').css('border', '1px solid #d2d6de');	
		 $('#password').css('border', '1px solid #d2d6de');	
		 $('#re_password').css('border', '1px solid #d2d6de');	
		var esito = true;
	   
/* 		if(old_password!=old_pwd){
			$('#myModalErrorContent').html("Attenzione! Password provvisoria errata!");
			$('#old_password').css('border', '1px solid #f00');
			$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");  
			$('#myModalError').modal();
			esito = false;
		} */
		if(password!=re_password){
		    $('#myModalErrorContent').html("Attenzione! Le password non corrispondono!");
		    $('#password').css('border', '1px solid #f00');
		    $('#re_password').css('border', '1px solid #f00');
		    $('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");  
			$('#myModalError').modal();
			esito = false;
		}	
		else if (password.length < 8 ) {
	    	$('#myModalErrorContent').html("Attenzione! Inserire una password di almeno 8 caratteri!");
	    	$('#password').css('border', '1px solid #f00');
	    	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");  
			$('#myModalError').modal();
			esito = false;
	    }
		else if (!number.test(password) || !minuscole.test(password)||!maiuscole.test(password)||!special.test(password)) {
	    	$('#myModalErrorContent').html("Attenzione! <br>La password deve contenere lettere maiuscole, minuscole e numeri <BR>Non ammessi caratteri speciali");
	    	$('#password').css('border', '1px solid #f00');
	    	$('#myModalError').removeClass();
			$('#myModalError').addClass("modal modal-danger");  
			$('#myModalError').modal();
			esito = false;
	    }

		if(esito){
			changePasswordPrimoAccesso(id_utente, old_pwd);
		}
	} 
	
	
	
	</script>

</jsp:attribute>

</t:layout>



