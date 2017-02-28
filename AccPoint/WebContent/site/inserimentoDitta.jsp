<html>
  <head>	<title>DIGIWEBUNO</title> 
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/scripts.js"></script>

  </head>
  <% String messaggio=(String)request.getAttribute("messaggio"); %>
  
  <body background="images/sfondo.jpg" >

	<form name="frmInserimentoDitta" method="post">
    <h1 align="center">Inserimento Ditta <br></h1><br><br>

    <table class="sfondodati" width="450" height="194" cellspacing="10" cellpadding="2">
    <tr>
    <td class="testo10" >Nome Ditta </td><td><input type="text" size="50" name="nomeDitta" style="campo" onfocus="nascondi('esito');" id="nomeDitta"></td>
    </tr>
    <tr>
     <td class="testo10" >Partita Iva </td><td><input type="text" size="50" name="pIva" style="campo" id="pIva"></td>
    </tr>
    <tr>
     <td class="testo10" >Codice Ditta </td><td><input type="text" size="50" name="codiceDitta" style="campo" id="codiceDitta"></td>
    </tr>
    <tr><br></tr>
    <% 
    if(messaggio!=null && messaggio.equals("success"))
    { %>
    <tr><td class="esitopositivo" colspan="2" align="center" id="esito">Inserimento eseguito correttamente</td></tr>
    <%
    }
    else if(messaggio!=null && messaggio.equals("pIva"))
    {
    %>
     <tr><td class="esitopositivo" colspan="2" align="center" id="esito"><strong>Errore   &nbsp;  &nbsp;</strong>Partita Iva Duplicata</td></tr>
    <% 
    }
    else
    { 
    %>
     <tr><td class="esitopositivo" colspan="2"></td></tr>
    <%} %>
    <tr><br></tr>
    <tr><td colspan="2" align="center"><button class="button" onclick="if(controllaCampiInsDitta()==true){callAction('insDittaCore')}">Aggiungi</button> </td></tr>
    </table>
</form>    
    </body>
    </html>