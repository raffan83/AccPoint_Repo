<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>




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
        Dati Profilo Utente
        <small>Modifica i dati personali ed i dati aziendali</small>
      </h1>
       <a class="btn btn-default pull-right" href="/AccPoint"><i class="fa fa-dashboard"></i> Home</a>s
    </section>

    <!-- Main content -->
    <section class="content">
    
    
    <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#datipersonali" data-toggle="tab" aria-expanded="true" onclick="openCity(event, 'datPer')">Dati Personali</a></li>
              <li class=""><a href="#datiazienda" data-toggle="tab" aria-expanded="false" onclick="openCity(event, 'azienda')">Dati Azienda</a></li>
              <li class=""><a href="#profilo" data-toggle="tab" aria-expanded="false" onclick="openCity(event, 'profilo')">Profilo</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="datipersonali">
                
                
                <form class="form-horizontal">
                  <div class="form-group">
                    <label for="inputName" class="col-sm-2 control-label">Codice Utente:</label>
 
                    <div class="col-sm-10">
 						<input class="form-control" class="form-control" id="codUser" type="text" name="codUser" disabled="disabled" value="${userObj.id}"/>
                     </div>
     				</div>

                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Nome</label>

                    <div class="col-sm-10">
						<input class="form-control" id="nome" type="text" name="nome" disabled="disabled" value="${userObj.getNome()}" />
                    </div>
                  </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cognome:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="cognome" type="text" name="cognome" disabled="disabled"  value="${userObj.getCognome()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="indirizzoUsr" type="text" name="indirizzoUsr" disabled="disabled"  value="${userObj.getIndirizzo()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="comuneUsr" type="text" name="comuneUsr" disabled="disabled" value="${userObj.getComune()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cap:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="capUsr" type="text" name="capUsr" disabled="disabled"  value="${userObj.getCap()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="emailUsr" type="text" name="emailUsr" disabled="disabled"  value="${userObj.getEMail()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="telUsr" type="text" name="telUsr" disabled="disabled"  value="${userObj.getTelefono()}"/>
    </div>
       </div> 
     
         <div class="form-group">
      

       <div class="col-sm-offset-2 col-sm-10">
                   <div class="box-footer">
		<button type="button" id="modificaUsr" onclick="enableInput('#datipersonali')" class="btn btn-primary" >Modifica Dati</button>
 		<button type="button" id="inviaUsr" onclick="salvaUsr()" class="btn btn-danger" disabled="disabled"  >Invia Modifica</button>
</div>   
              </div>




  </div>  
        </form>
       <div id="usrError"></div>
    </div> 
		          


                
              <!-- /.tab-pane -->
              <div class="tab-pane" id="datiazienda">
                

         <form class="form-horizontal">
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="denominazioneConpany" type="text" name="name" disabled="disabled" value="${usrCompany.getDenominazione()}"/>
    </div>
     </div>
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">PartitaIva:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="pivaCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getpIva()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="indCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getIndirizzo()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="comuneCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getComune()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cap:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="capCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getCap()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="emailCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getMail()}"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="telCompany" type="text" name="name" disabled="disabled" value="${usrCompany.getTelefono()}"/>
    </div>
     </div>
       
         <div class="form-group">
      

       <div class="col-sm-offset-2 col-sm-10">
                   <div class="box-footer">
		<button type="button" id="modificaCompany" onclick="enableInput('#datiazienda')" class="btn btn-primary" >Modifica Dati</button>
 		<button type="button" id="inviaCompany" onclick="salvaCompany()" class="btn btn-danger" disabled >Invia Modifica</button>
</div>   
              </div>
              </div>
     </form>
     <div id="companyError"></div>
 </div>

              <!-- /.tab-pane -->

              <div class="tab-pane" id="profilo">
                 Il tuo profilo utente è di tipo: ${userObj.getTipoutente()}
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
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
    

<script>
function openCity(evt, cityName) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
   // document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
//document.getElementById("defaultOpen").click();
</script> 
</jsp:attribute> 
</t:layout>


