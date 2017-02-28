
<html>
  <head>	<title>DIGIWEBUNO</title> 
<link href="css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/scripts.js"></script>
  </head>
  
  <body background="images/sfondo.jpg">
<form name="frmInsForn" method="post" >
    <h1 align="center">Inserimento Attivita <br></h1><br><br>
    
    <table class="sfondodati" width="550" height="100" cellspacing="10" cellpadding="2">
    <tr>
    <td class="testo10" >Operatore</td><td><input type="text" value="<%=request.getSession().getAttribute("nomeUtente") %>" class="camporeadonlyleft" size="30" readonly="readonly"></td>
    </tr>
    <tr>
    <td class="testo10" >Nome Batch </td><td><input type="text" value="<%=request.getSession().getAttribute("nomeBatch") %>" class="camporeadonlyleft" size="90" readonly="readonly"></td>
    </tr>
      <tr>
    <td class="testo10" >Date </td><td><input type="text" value="<%=request.getSession().getAttribute("date") %>" class="camporeadonlyleft" size="90"></td>
    </tr>
    <tr>
    <td colspan="2">
    <table class="sfondodati" width="544" height="100" cellspacing="10" cellpadding="2">
    <tr>
    <th class="testo12" >Attivita</th><th class="testo12" >Documenti</th><th class="testo12">Pagine</th><th class="testo12">Tempo</th><th class="testo12">Note</th><th class="testo12">Seleziona</th>
    </tr>
   <tr><td class="testo12">Classificazione</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeClass" value=<%=request.getSession().getAttribute("timeClass") %> size=10 onKeyPress="return keyCheck(event, this)" ></td><td><input type="text" name="noteClass" id="noteClass" size=50></td><td align="center"><input type="checkbox" name="cClass" id="cClass" value="html"/></td></tr>
   <tr><td class="testo12">Scansione</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeScan" value=<%=request.getSession().getAttribute("timeScan") %> size=10 onKeyPress="return keyCheck(event, this)"></td><td><input type="text" name="noteScan" id="noteScan" size=50></td><td align="center"><input type="checkbox" name="cScan" id="cScan" value="html"/></td></tr>
   <tr><td class="testo12">Validation</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeVal" value=<%=request.getSession().getAttribute("timeVal") %> size=10 onKeyPress="return keyCheck(event, this)"></td><td><input type="text" name="noteVal" id="noteVal" size=50></td><td align="center"><input type="checkbox" name="cVal" id="cVal" value="html"/></td></tr>
   <tr><td class="testo12">Verifica</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeVer" value=<%=request.getSession().getAttribute("timeVer") %> size=10 onKeyPress="return keyCheck(event, this)"></td><td><input type="text" name="noteVer" id="noteVer" size=50></td><td align="center"><input type="checkbox" name="cVer" id="cVer"value="html"/></td></tr>
   <tr><td class="testo12">Risistemazione</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeRis" value=<%=request.getSession().getAttribute("timeRis") %> size=10 onKeyPress="return keyCheck(event, this)"></td><td><input type="text" name="noteRis" id="noteRis" size=50></td><td align="center"><input type="checkbox" name="cRis" id="cRis" value="html"/></td></tr>
   <tr><td class="testo12">Varie</td><td class="testo12" align="center"><%=request.getSession().getAttribute("nDoc") %></td><td class="testo12" align="center"><%=request.getSession().getAttribute("nPag") %></td><td class="testo12" align="center"><input type="text" name="timeVar" value=<%=request.getSession().getAttribute("timeVar") %> size=10 onKeyPress="return keyCheck(event, this)"></td><td><input type="text" name="noteVar" id="noteVar" size=50></td><td align="center"><input type="checkbox" name="cVar" id="cVar" value="html"/></td></tr>
   </table>
    </td>
    </tr>
    
     <tr><br></tr>
    <% 
    String messaggio=(String)request.getAttribute("messaggio");
    if(messaggio.equals("success"))
    { %>
    <tr><td class="esitopositivo" colspan="2" align="center" id="esito">Inserimento eseguito correttamente</td></tr>
    <%
    }
    else
    { 
    %>
     <tr><td class="esitopositivo" colspan="2"></td></tr>
    <%} %>
    <tr><br></tr>
    
    
    <tr><td colspan="2" align="center"><span class="button" onclick="controlloInsDaBatch()">Inserisci</span> </td></tr>
    </table>
</form>    
    </body>
    </html>