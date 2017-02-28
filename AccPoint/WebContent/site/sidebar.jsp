<html>
  <head>	<title>Portale STI</title> 
  
<script src="../js/jquery-1.2.1.min.js" type="text/javascript"></script>
<script src="../js/scripts.js" type="text/javascript"></script>
<script src="../js/menu-collapsed.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../css/styleMen.css" />

 <style type="text/css">
   li a {display:inline-block;}
   li a {display:block;}
   </style>
  
</head>
<body bgcolor="#EE1C25">
<% //String tipoAcc=(String)request.getSession().getAttribute("tipoAccount");%>
<ul id="menu">
		<li>
		<a href="#">Anagrafica</a>
			<ul>
			<li><a href="#" onclick="explore('gestioneCommessa.do');">Gestione Anagrafica</a></li>
			</ul>
		</li>
		
		<li>
		<a href="#">Commesse</a>
			<ul>
			<li><a href="#" onclick="explore('gestioneCommessa.do');">Gestione Commessa</a></li>
			</ul>
		</li>
		<li>	
			
			<a href="#">Strumenti</a>
			<ul>
				
    			<li><a href="#" onclick="explore('listaStrumenti.do');">Gestione Strumenti</a></li>
    			<li><a href="#" onclick="explore('listaStrumentiNew.do');">Gestione Strumenti [NEW]</a></li>
    			<li><a href="#" onclick="explore('abbinaSchede.do');">Abbina Schede</a></li>
    			
    		</ul>
    		</li>
    		<li>
		<a href="#">Campioni</a>
			<ul>
			<li><a href="#" onclick="explore('listaCampioni.do');">Lista Campioni</a></li>
			<li><a href="#" onclick="explore('scadenziario.do');">Scadenziario</a></li>
			</ul>
		</li>	
		
			<li>
		<a href="#">Prenotazione Campioni</a>
			<ul>
			<li><a href="#" onclick="explore('listaCampioni.do');">Prenota</a></li>
			<li><a href="#" onclick="explore('scadenziario.do');">Richieste</a></li>
			</ul>
		</li>		
			<!--	<li><a href="#" onclick="explore('anaFra');">Anagrafica Fraschetti</a></li>
				<li><a href="#" onclick="explore('anaAXAA');">Anagrafica AXA Aziende</a></li>
				<li><a href="#" onclick="explore('anaAXAP');">Anagrafica AXA Persone</a></li>
				<li><a href="#" onclick="explore('anaSAR');">Anagrafica SAR</a></li> 
			</ul>
		</li>
		<li>
			<a href="#">Statistiche</a>
			<ul>
				<% //if(tipoAcc.equals("AM")){%>
					<li><a href="#" onclick="explore('statistiche');">Visualizza</a>
    				<li><a href="#" onclick="explore('ricercaRapp');">Ricerca Rapporto</a>
    			<%//}%>
 				<%// if(tipoAcc.equals("OP")){%>
					<li><a href="#" onclick="explore('visualizzaStatisticheOP');">Visualizza</a>
					<li><a href="#" onclick="explore('rapOp');">Inserisci Rapporto</a>
					<li><a href="#" onclick="explore('insDatiOper');">Inserisci Dati Operatore</a>
					<li><a href="#" onclick="explore('insDatiOperDaBatch');">Inserisci Dati Operatore da Batch</a>
    			<%//}%>   
			</ul>
		</li>
		<li>
			<a href="#">Gestione Batch</a>
			<ul>
				<li><a href="" onclick="explore('gestioneFTP');">Gestione FTP</a></li>
    			<li><a href="" onclick="explore('preparaExport');">Gestione Export</a></li>
			</ul>
		</li>
		
			<%// if(tipoAcc.equals("AM")){%>
			<li><a href="#" onclick="explore('contabilita');">Contabilita</a></li>
			<li><a href="#" onclick="explore('disegnaGrafico');">Grafico</a></li>
		<%//}%>
		<li>
			<a href="#">Check In / Check Out</a>
			<ul>
				<li><a href="" onclick="explore('creazioneContainer');">Crazione Container</a></li>
				<li><a href="" onclick="explore('checkin');">Check In</a></li>
				<li><a href="" onclick="explore('checkout');">Check Out</a></li>
    			<li><a href="" onclick="explore('statoCheck');">Visualizza Stato</a></li>
			</ul>
		</li>
		<li><a href="#" onclick="explore('exec');" >Execute</a></li>
		<li><a href="#" onclick="explore('pdf');" >PDF</a></li>
	<!--  	<li>
			<a href="#">Documentazione</a>
			<ul>
				<li><a href="" onclick="explore('insDocumento');">Inserisci Documento</a></li>
    			<li><a href="" onclick="explore('preparaExport');">Visualizza Documento</a></li>
    			<li><a href="" onclick="explore('indexModelli');">Modelli Documentali</a></li>
			</ul>
		</li> 
		-->
	</ul>
    </body>
    </html>