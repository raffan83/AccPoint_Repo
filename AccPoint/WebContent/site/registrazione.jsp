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
         			<input class="form-control" id="user" type="text" name="user" value="${user}" required autocomplete="off" />
     	</div>
     
   </div>
      </div>
        <div class="col-xs-12">

                <div class="row form-group">
          <label for="user" class="col-sm-2 control-label">Password:</label>

         <div class="col-sm-4">
         			<input class="form-control" id="passw" type="password" name="passw" value="" required autocomplete="new-password"/>
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
  <div class="row form-group">
            <label for="area_interesse" class="col-sm-2 control-label">Area d'interesse:</label>
        <div class="col-sm-4">
                      <select class="form-control select2" title="Seleziona area di interesse" id="area_interesse" name="area_interesse">
                      <option value=""></option>
                      <option value="1">Tarature</option>
                      <option value="2">Rilievi dimensionali</option>
                      <option value="3">Corsi di Formazione</option>
                      <option value="4">Verificazione periodica</option>
                      </select>
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
         
         
         
         <div class="row">
         <div class="col-xs-1">
         </div>
         <div class="col-xs-10">
         <div class="box box-danger box-solid">
<div class="box-header with-border">
	 Informativa Privacy
	<div class="box-tools pull-right">
		
		<button data-widget="collapse" class="btn btn-box-tool"><i class="fa fa-minus"></i></button>

	</div>
		</div>
		<div class="box-body">
		<div class="row">
		<div class="col-xs-12">
		
		<h3 >
        
        <small><b style="text-align:center">MANIFESTAZIONE DI CONSENSO AL TRATTAMENTO DEI DATI PERSONALI</b></small>
      </h3><br>
      
      <div class="col-xs-12">
      <p>Ai sensi del D. Lgs. 196/2003 e smi e dell'art. 7 Regolamento UE 2016/679, il sottoscritto:</p>
      </div>
      <br>
      <div class="row">
       <div class="col-xs-1">
      </div>
      <div class="col-xs-1" style="margin-top:10px">
      <input type="checkbox" id="check1">*
      </div>
	<div class="col-xs-10">
       <p align="justify">dichiara di aver preso visione, letto e compreso il contenuto dell'<u><a target="_blank" href="registrazione.do?action=informativa_privacy" >Informativa privacy</a></u> da Voi fornita ai sensi del D. Lgs. 196/2003 e smi e dell'art. 13 del Regolamento UE 2016/679;</p>
      </div>
      </div>
      <div class="row">
      <div class="col-xs-1">
      </div>
      <div class="col-xs-1" style="margin-top:15px">
      
      <input type="checkbox" id="check2">*
    
      </div>
	<div class="col-xs-10">
       <p  align="justify">presta il proprio consenso, libero ed informato, al trattamento dei propri dati personali identificativi da parte del Titolare e dei responsabili interni ed esterni del trattamento dei dati, per le operazioni connesse all'accesso e utilizzo della piattaforma Calver presente sul sito <u><a target="_blank" href="/AccPoint">www.calver.it</a></u>, nelle modalità indicate nell'informativa e nei limiti della stessa;</p>
      </div>
      </div>
      <div class="row">
       <div class="col-xs-1">
      </div>
      <div class="col-xs-1" style="margin-top:15px">
      <input type="checkbox"  id="check3" name="check3">
      </div>
	<div class="col-xs-10">
       <p align="justify">presta il proprio consenso, libero ed informato, al trattamento dei propri dati personali identificativi da parte del Titolare e dei responsabili interni ed esterni del trattamento dei dati, nelle modalità indicate nell'informativa, per l'invio di e-mail, posta e/o sms e/o contatti telefonici, newsletter, comunicazioni commerciali e/o materiale pubblicitario su prodotti, servizi e iniziative del Titolare.</p>
      </div>
      </div>
      <div class="row">
      <div class="col-xs-2">
      </div>
      <div class="col-xs-10">
      <p>* Campi obbligatori</p>
      
      </div>
      </div>
      <div class="row">
   
      <div class="col-xs-12">
      <p  align="justify">In qualsiasi momento l'Interessato potrà revocare i consensi sopra rilasciati, ferma restando la liceità dei trattamenti basati sui consensi prestati prima della revoca.</p>
      
      </div>
      </div>
</div>
</div>
       

</div>
</div>
         
         </div>
         </div>
         
         


 <div class="box-footer with-border">
   <a id="home" class="btn btn-primary btn-flat" href="/AccPoint">Home</a>
 <a id="submitregistrazione"  class="btn btn-danger  btn-flat disabled" onclick="Registrazione()" >Registrati</a>

 </div>
</div>
		
		</form>
  </div>

		
</jsp:attribute>

<jsp:attribute name="extra_js_footer"> 

<script>

$('.select2').select2()
	   $('#check1').on('ifClicked',function(e){
			
		   if($('#check1').is( ':checked' )){
			   $('#submitregistrazione').addClass('disabled');
		   }else{
			   
				 if($('#check2').is( ':checked' )){
					 
					 $('#submitregistrazione').removeClass('disabled');				  
					
				 }else{
					 $('#submitregistrazione').addClass('disabled');
				 }
		   }
		 });   
	   
	   $('#check2').on('ifClicked',function(e){
		   
		   
		   if($('#check2').is( ':checked' )){
			   $('#submitregistrazione').addClass('disabled');
		   }else{
			   if($('#check1').is( ':checked' )){
					 
					 $('#submitregistrazione').removeClass('disabled');				  
					
				 }else{
					 $('#submitregistrazione').addClass('disabled');
				 }
		   }

		 });

 </script>
</jsp:attribute>

</t:layout>



