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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:layout title="Registrazione" bodyClass="hold-transition login-page">


	<jsp:attribute name="body_area"> 
 

  <div class="registrazione">
	
	
   <form id="registrazione" name="registrazione" method="post" action="">

  <div class="login-logo">
    <img src="./images/logo_calver_v2.png" style="width: 200px">
  </div>
  <!-- /.login-logo -->
 


 <div class="box box-danger">
<div class="box-header with-border">
	 Richiesta Registrazione Utente
	
</div>
<div class="box-body">
<div class="row">


  <div class="col-xs-12">

                <div class="row form-group">
          <label for="user" class="col-sm-2 control-label">Username:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="user" type="text" name="user" value="${user}" required />
     	</div>
     
   </div>
      </div>
        <div class="col-xs-12">

                <div class="row form-group">
          <label for="user" class="col-sm-2 control-label">Password:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="passw" type="password" name="passw" value="" required />
     	</div>
     	 <label for="passw" class="col-sm-2 control-label">Conferma Password:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="cpassw" type="password" name="cpassw" value="" required />
     	</div>
   </div>
      </div>
      
    <div class="col-xs-12">  

    <div class="row form-group">
          <label for="nome" class="col-sm-2 control-label">Nome:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="nome" type="text" name="nome" value="${nome}" required />

     	</div>
     	
     	 <label for="cognome" class="col-sm-2 control-label">Cognome:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="cognome" type="text" name="cognome"  value="${cognome}" required/>
   	 </div>
   </div>
</div>
    <div class="col-xs-12">  

    <div class="row form-group">
        <label for="indirizzo" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="indirizzo" type="text" name="indirizzo"  value="${indirizzo}" required/>
    </div>
    
     <label for="comune" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="comune" type="text" name="comune"  value="${comune}" required/>
    </div>
    
    
    </div>
</div>
    <div class="col-xs-12">  
    <div class="row form-group">
        <label for="cap" class="col-sm-2 control-label">CAP:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="cap" type="text" name="cap"  value="${cap}" required/>
    </div>
    <label for="cap" class="col-sm-2 control-label">Company:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="descrizioneCompany" type="text" name="descrizioneCompany"  value="${descrizioneCompany}" required/>
    </div>
    </div>
    </div>
    <div class="col-xs-12">  
    <div class="row form-group">
        <label for="email" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="email" type="text" name="email"  value="${email}" required/>
    </div>
        <label for="telefono" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-4">
                      <input class="form-control required" id="telefono" type="text" name="telefono"  value="${telefono}" required/>
    </div>
    </div>
</div>


   
  <div class="col-xs-12">
     
     <div id="erroMsg" class="form-group">
     <c:if test="${success}">
    		<label class="control-label text-green" for="inputError" >
    	</c:if>
    	 <c:if test="${!success}">
    		<label class="control-label text-red" for="inputError" >
    	</c:if>
               ${fn:replace(errorMessage, '"', '')}  </label>
                 
              </div>
       </div>
   </div>
         </div> 


 <div class="box-footer with-border">
   <a id="home" class="btn btn-primary btn-flat" href="/AccPoint">Home</a>
 <button id="submitregistrazione"  class="btn btn-danger  btn-flat" onclick="Registrazione()">Registrati</button>

 </div>
</div>
		
		</form>
  </div>

		
</jsp:attribute>

<jsp:attribute name="extra_js_footer"> 

	<script>
	$( document ).ready(function() {
	 
		  	$('#registrazione').validator(); 

	  	  $( "input" ).keydown(function() {
	  		//$('#erroMsg').html('');
	  	});
	});
	</script>

</jsp:attribute>

</t:layout>



