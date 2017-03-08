<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>

 <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dati Aziendali
        <small>Modifica i dati personali ed i dati aziendali</small>
      </h1>
    </section>

    <!-- Main content -->
    <section class="content">
    
    
    <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#datepersonali" data-toggle="tab" aria-expanded="true" onclick="openCity(event, 'datPer')">Dati Personali</a></li>
              <li class=""><a href="#datiazienda" data-toggle="tab" aria-expanded="false" onclick="openCity(event, 'azienda')">Dati Azienda</a></li>
              <li class=""><a href="#profilo" data-toggle="tab" aria-expanded="false" onclick="openCity(event, 'profilo')">Profilo</a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="datepersonali">
                <% UtenteDTO utente=(UtenteDTO)session.getAttribute("userObj"); %>
                
                
                <form class="form-horizontal">
                  <div class="form-group">
                    <label for="inputName" class="col-sm-2 control-label">Codice Utente:</label>
 
                    <div class="col-sm-10">
 						<input class="form-control" class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=utente.getId() %>"/>
                     </div>
     				</div>

                  <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 control-label">Nome</label>

                    <div class="col-sm-10">
						<input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=utente.getNome() %>" />
                    </div>
                  </div>

   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cognome:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getCognome() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getIndirizzo() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=utente.getComune() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cap:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getCap() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getEMail() %>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getTelefono() %>"/>
    </div>
       </div> 
     
         <div class="form-group">
      

       <div class="col-sm-offset-2 col-sm-10">
                   <div class="box-footer">
<button type="submit" class="btn btn-primary" >Modifica Dati</button>
 <button type="submit" class="btn btn-danger" >Invia Modifica</button>
</div>   
              </div>




  </div>  
        </form>
  
    </div> 
		          


                
              <!-- /.tab-pane -->
              <div class="tab-pane" id="datiazienda">
                
<%CompanyDTO company =(CompanyDTO)session.getAttribute("usrCompany"); %>
         <form class="form-horizontal">
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Denominazione:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getDenominazione()%>"/>
    </div>
     </div>
   <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">PartitaIva:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getpIva()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Indirizzo:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getIndirizzo()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Comune:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getComune()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Cap:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getCap()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">E-mail:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getMail()%>"/>
    </div>
     </div>
       <div class="form-group">
        <label for="inputName" class="col-sm-2 control-label">Telefono:</label>
        <div class="col-sm-10">
                      <input class="form-control" id="name" type="text" name="name" disabled="disabled" value="<%=company.getTelefono()%>"/>
    </div>
     </div>
       
         <div class="form-group">
      

       <div class="col-sm-offset-2 col-sm-10">
                   <div class="box-footer">
<button type="submit" class="btn btn-primary" >Modifica Dati</button>
 <button type="submit" class="btn btn-danger" >Invia Modifica</button>
</div>   
              </div>
              </div>
     </form>
 </div>

              <!-- /.tab-pane -->

              <div class="tab-pane" id="profilo">
                 Il tuo profilo utente è di tipo: <%=utente.getTipoutente() %> 
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
    
    
    
    
    

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
document.getElementById("defaultOpen").click();
</script> 
</section>