<%@page import="it.portaleSTI.DTO.CompanyDTO"%>
<%@page import="it.portaleSTI.DTO.UtenteDTO"%>
<html>
  <head>	<title>AccPoin</title> 
<script type="text/javascript" src="js/scripts.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/dark_matter.css" rel="stylesheet" type="text/css">
  </head>
  <body class="bg_intro">
  <form method="post" action="test">
  <div class="sfondodati" style="width:50%">
<ul class="tab">
  <li ><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'datPer')" id="defaultOpen" style="font-weight: bold">Dati Personali</a></li>
  <li class="testo12" ><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'azienda')" style="font-weight: bold">Dati Azienda</a></li>
  <li class="testo12"><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'profilo')" style="font-weight: bold">Profilo</a></li>
</ul>

<div id="datPer" class=tabContent>
<% UtenteDTO utente=(UtenteDTO)session.getAttribute("userObj"); %>
<div class="dark-matter">
    <label>
        <span>Codice Utente:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=utente.getId() %>"/>
    </label>
    <label>
        <span>Nome:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=utente.getNome() %>" />
    </label>
    <label>
        <span>Cognome:</span>
        <input id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getCognome() %>"/>
    </label>
        <label>
        <span>Indirizzo:</span>
        <input id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getIndirizzo() %>"/>
    </label>
        <label>
        <span>Comune:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=utente.getComune() %>"/>
    </label>
        <label>
        <span>Cap:</span>
        <input id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getCap() %>"/>
    </label>
        <label>
        <span>E-mail:</span>
        <input id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getEMail() %>"/>
    </label>
        <label>
        <span>Telefono:</span>
        <input id="name" type="text" name="name" disabled="disabled"  value="<%=utente.getTelefono() %>"/>
    </label>
       
     
         
       <input type="button" class="button_" style="margin-left:15%;width:150px" value="Modifica Dati" /> 

        <input type="button" class="button_" style="width:150px" value="Invia Modifica" /> 
  
    
      
</div>
</div>
<%CompanyDTO company =(CompanyDTO)session.getAttribute("usrCompany"); %>
<div id="azienda" class=tabContent>
<div class="dark-matter">
    <label>
        <span>Denominazione:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getDenominazione()%>"/>
    </label>
    <label>
        <span>PartitaIva:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getpIva()%>"/>
    </label>
        <label>
        <span>Indirizzo:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getIndirizzo()%>"/>
    </label>
        <label>
        <span>Comune:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getComune()%>"/>
    </label>
        <label>
        <span>Cap:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getCap()%>"/>
    </label>
        <label>
        <span>E-mail:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getMail()%>"/>
    </label>
        <label>
        <span>Telefono:</span>
        <input id="name" type="text" name="name" disabled="disabled" value="<%=company.getTelefono()%>"/>
    </label>
       
      <input type="button" class="button" style="margin-left:15%" value="Modifica Dati" /> 

        <input type="button" class="button" value="Invia Modifica" /> 
</div>
</div>


<div id="profilo" class="tabcontent">
  <p>Il tuo profilo utente è di tipo: <%=utente.getTipoutente() %></p>
</div>
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
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script> 
</form>
    </body>
    </html>