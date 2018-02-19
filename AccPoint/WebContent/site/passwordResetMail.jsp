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


<t:layout title="Login Page" bodyClass="hold-transition login-page">


	<jsp:attribute name="body_area"> 

 
<div class="login-box">




  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 70%">
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Inserisci il tuo username per iniziare la procedura di recupero password </p>
 <div class="row">
  <div class="col-xs-12">
       <div class="form-group has-feedback control-group">

			<input type="text" name="username" type="text" class="form-control"
									value="" placeholder="username" id="username" required aria-invalid="false" />
        
        	<span
									class="glyphicon glyphicon-envelope form-control-feedback"></span>
									 <p class="help-block with-errors"></p>
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
                	<button id="" class="btn btn-danger btn-block btn-flat"
								onclick="resetPassword()">Reset</button>

      </div>
           </div>
     
<p class="login-box-msg" ><a  class="btn btn-default" href="./" ><i class="fa fa-home fa-4x" aria-hidden="true"></i></a></p>
 
 
  
  <!-- /.login-box-body -->
</div>


		
     	<div id="myModalError" class="modal fade" role="dialog" aria-labelledby="myLargeModalLabel">
	    <div class="modal-dialog modal-sm" role="document">
	        <div class="modal-content">
	    
	    <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Attenzione</h4>
	      </div>
	    <div class="modal-content">
	       <div class="modal-body" id="myModalErrorContent">
	
	        
	        
	  		 </div>
	      
	    </div>
	       <div class="modal-footer">

        <button type="button" class="btn btn-outline" data-dismiss="modal">Chiudi</button>
      </div>
	  </div>
	    </div>
	
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
	</script>

</jsp:attribute>

</t:layout>



