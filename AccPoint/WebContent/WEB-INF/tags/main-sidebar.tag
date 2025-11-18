<%@ tag language="java" pageEncoding="UTF-8"%>
<%@tag import="it.portaleSTI.DTO.UtenteDTO"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ tag import="java.util.Calendar" %>
<% 
	UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj");
	int anno = Calendar.getInstance().get(Calendar.YEAR);
%>




 <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header">Menu</li>
        <!-- Optionally, you can add icons to the links -->
      <!--   <li class="treeview">
          <a href="#"><i class="fa fa-user"></i> <span>Anagrafica</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="areaUtente.do">Gestione Anagrafica</a></li>
          </ul>
        </li> -->
      
        
        <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_COMMESSE_METROLOGIA")){%>
        
          <% if(!user.checkRuolo("CL")){%>
        <li class="header">METROLOGIA</li>
        <% }%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Commesse</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="gestioneCommessa.do">Gestione Commessa</a></li>
           <% if(user.checkPermesso("SCHEDE_CONSEGNA")){%>
            <li><a href="listaSchedeConsegna.do">Schede di Consegna</a></li>
             <% }%>
              <li><a href="#" onclick="callAction('gestioneIntervento.do?action=stato_consegna_interventi',null,true);">Stato Consegna Interventi</a></li>
          </ul>
        </li>
         <% }%>
          <% if(user.checkRuolo("AM") || user.checkRuolo("PV") || user.checkPermesso("LISTA_INTERVENTI_METROLOGIA")){%>
         

          <%if(user.checkRuolo("PV")){ %>
          <li class="header">METROLOGIA</li>
           <% }%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Interventi</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          	<% if(user.checkRuolo("AM") || user.checkPermesso("LISTA_INTERVENTI_METROLOGIA")){%>
    			<li><a href="#" onclick="callAction('listaInterventi.do',null,true);">Lista Interventi</a></li>
    			
    			<% }%>
    				<% if(user.checkRuolo("AM") || (user.checkPermesso("LISTA_INTERVENTI_METROLOGIA")&& !user.checkRuolo("PV"))){%>
    			<li><a href="#" onclick="callAction('gestioneAssegnazioneAttivita.do?action=lista&admin=0',null,true);">Assegnazione Attività</a></li>
    			<li><a href="#" onclick="callAction('gestioneAssegnazioneAttivita.do?action=controllo_attivita&admin=0',null,true);">Controllo Attività</a></li>
    				<% }%>
    			<% if(user.checkRuolo("AM") || user.checkPermesso("LISTA_INTERVENTI_OPERATORE")){%>
    			<li><a href="#" onclick="callAction('listaInterventiOperatore.do?action=filtra_date&mese=1',null,true);">Interventi Operatore</a></li>
    			<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_ASSEGNAZIONE_ATTIVITA_ADMIN")){%>
    			<li><a href="#" onclick="callAction('gestioneAssegnazioneAttivita.do?action=lista&admin=1',null,true);">Assegnazione Attività Admin</a></li>
    			<li><a href="#" onclick="callAction('gestioneAssegnazioneAttivita.do?action=controllo_attivita&admin=1',null,true);">Controllo Attività Admin</a></li>
    			
    			<% }%>
    			
    		<% }%>
    		<% if(user.checkRuolo("AM") || (user.checkPermesso("LISTA_INTERVENTI_METROLOGIA")&& !user.checkRuolo("PV"))){%>
    			<li><a href="#" onclick="callAction('gestioneMisura.do?action=lista',null,true);">Lista Misure</a></li>
    				<% }%>
    		<% if(user.checkRuolo("AM") || user.checkRuolo("OP")){%>	
    			<li><a href="gestioneConfigurazioniClienti.do?action=lista"><i class="fa fa-industry"></i>Gestione Clienti</a></li>	
    		<% }%>		
    		
    		<% if(user.checkRuolo("AM") ){%>
    		<li><a href="gestioneModificheAdmin.do">Gestione Modifiche Admin</a></li>	
    		
    		<% }%>	
          </ul>
        </li>
         <% }%>
          <% if(user.checkRuolo("AM") || user.checkRuolo("PV") || user.checkPermesso("LISTA_CERTIFICATI_MENU_METROLOGIA")){%>
          
         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Certificati</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="listaCertificati.do">Lista Certificati</a></li>
          </ul>
        </li>
         <% }%>
          <% if(user.checkRuolo("AM") || user.checkPermesso("STRUMENTI_MENU_METROLOGIA")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Strumenti</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          <% if(user.checkRuolo("AM") ||  user.checkPermesso("GESTIONE_STRUMENTI_METROLOGIA")){%>
    			<li><a href="#" onclick="callAction('listaStrumentiNew.do',null,true);">Gestione Strumenti</a></li>
    	      <% }%>
    	         <% if(user.checkRuolo("AM") || user.checkPermesso("SCADENZIARIO_STRUMENTI_METROLOGIA")){%>
			<li><a href="scadenziarioStrumenti.do">Scadenziario</a></li>
			  <% }%>
			<% if(user.checkRuolo("AM") || user.checkPermesso("RICERCA_STRUMENTI_DATE_METROLOGIA")){%>
			<li><a href="ricercaDateStrumenti.do">Ricerca per Date</a></li>
			 <% }%>
          </ul>
        </li>
         <% }%>
         <% if(user.checkRuolo("AM") || user.checkPermesso("CAMPIONI_MENU_METROLOGIA")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Campioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="listaCampioni.do">Campioni  Personali</a></li>
			 <% if(user.checkRuolo("AM") || (user.checkPermesso("CAMPIONI_MENU_METROLOGIA") && !user.checkRuolo("PV"))){%>
			<li><a href="listaCampioniPrenotabili.do">Campioni  Prenotabili</a></li>
			<li><a href="scadenziario.do">Scadenziario</a></li>
			<!-- <li><a href="scadenziario.do?action=campioni&scadenzario_lat_generale=1">Scadenziario LAT</a></li> -->
			<li><a href="scadenziario.do?lat=CDT">Scadenziario LAT</a></li>
			<li><a href="gestioneLibrerieElettrici.do?action=lista">Librerie Elettrici</a></li>
			  <% }%>
          </ul>
        </li>
            <% }%>
<%--               <% if(user.checkRuolo("AM") || user.checkPermesso("PRENOTAZIONE_CAMPIONE_MENU_METROLOGIA")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Prenotazione Campioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
             <% if(user.checkRuolo("AM") || user.checkPermesso("STATO_PRENOTAZIONE_CAMPIONE_METROLOGIA")){%>
			<li><a href="listaPrenotazioni.do">Stato Prenotazioni</a></li>
			       <% }%>
			       <% if(user.checkRuolo("AM") || user.checkPermesso("RICHIESTE_PRENOTAZIONI_METROLOGIA")){%>
			<li><a href="listaPrenotazioniRichieste.do">Gestione Richieste</a></li>
			<% }%>
			
          </ul>
        </li>
		<% }%> --%>
		


 <li class="treeview">
 <% if(user.checkRuolo("AM") || user.checkPermesso("RILIEVI_DIMENSIONALI") || user.checkPermesso("VISUALIZZA_RILIEVI_DIMENSIONALI")){%>
          <a href="#"><i class="fa fa-link"></i> <span>Rilievi Dimensionali</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">   
         <%if(!user.checkRuolo("RL")){ %> 
          <li><a href="#" onclick="callAction('listaRilieviDimensionali.do?action=lista_interventi',null,true);">Lista Interventi</a></li>
          <% }%>   
			<li><a href="#" onclick="callAction('listaRilieviDimensionali.do',null,true);">Gestione Rilievi</a></li> 
			
				
          </ul>
          <%} %>
        </li>
         
         <li class="treeview">
 <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_RISORSE")){%>
          <a href="#"><i class="fa fa-link"></i> <span>Pianificazione Risorse</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">   
         <%if(!user.checkRuolo("RL")){ %> 
          <li><a href="#" onclick="callAction('gestioneRisorse.do?action=lista_risorse',null,true);">Gestione Risorse</a></li>
          <% }%>   
			<li><a href="#" onclick="callAction('gestioneRisorse.do?action=lista_requisiti',null,true);">Gestione Requisiti</a></li> 
			<li><a href="#" onclick="callAction('gestioneRisorse.do?action=pianificazione_risorse',null,true);">Pianificazione Risorse</a></li> 
				
          </ul>
          <%} %>
        </li>

<%--
<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_COMMESSE_CAMPIONAMENTO")){%>
        <% if(!user.checkRuolo("CL")){%>
        <li class="header">CAMPIONAMENTO</li>
         <% }%>
           
         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Commesse</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="gestioneCommessaCampionamento.do">Gestione Commesse</a></li>
          </ul>
        </li>
          <% }%>
           <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_MAGAZZINO_CAMPIONAMENTO")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Tabelle Campionamento</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="listaDotazioni.do">Dotazioni</a></li>
			<li><a href="listaAccessori.do">Accessori</a></li>
			<li><a href="gestioneAssociazioniArticoli.do">Configurazione Articoli</a></li>
          </ul>
        </li>
        <% }%> --%>
        
        
        <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_MAGAZZINO")){%>
  <%--       <% if(!user.checkRuolo("CL")){%> --%>
        <li class="header">MAGAZZINO</li>
       <%--   <% }%> --%>
           
         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Magazzino</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
          <li><a href="#" onclick="callAction('listaPacchi.do',null,true);">Stato Magazzino</a></li>
           <li><a href="#" onclick="callAction('listaItem.do?action=lista',null,true);">Stato Item Magazzino</a></li>
		<li><a href="#" onclick="callAction('listaPacchi.do?action=lista_ddt',null,true);">Stato DDT</a></li>
		<li><a href="#" onclick="callAction('gestionePacco.do?action=pacchi_lavorazione',null,true);">Attivit&agrave; in corso</a></li>
          </ul>
        </li>
          <% }%>
          
 	<%--   <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_SEGRETERIA")){%> 

        <li class="header">SEGRETERIA</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Segreteria</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
          <li><a href="#" onclick="callAction('gestioneSegreteria.do',null,true);">Lista Contatti</a></li>
           
          </ul>
        </li>
           <% }%> --%>
           
         <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_VER_STRUMENTI") || user.checkPermesso("GESTIONE_VER_STRUMENTI_CLIENTE")){%>  
           <li class="header">VERIFICAZIONE STRUMENTI</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Verificazione Strumenti</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
			<!-- <li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do',null,true);">Comunicazione Preventiva</a></li> -->
			<% if(user.checkPermesso("GESTIONE_VER_STRUMENTI")){%>  
			<li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do?action=esito_comunicazioni',null,true);">Comunicazione Esito</a></li>
			 <li><a href="gestioneVerIntervento.do?action=lista_commesse">Gestione Commesse</a></li>
			<% }%>
	        <li><a href="#" onclick="callAction('gestioneVerStrumenti.do',null,true);">Gestione Strumenti</a></li>
	        <li><a href="#" onclick="callAction('gestioneVerCertificati.do',null,true);">Lista Certificati</a></li>
	        <% if(user.checkPermesso("GESTIONE_VER_STRUMENTI")){%>  
	        <li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do?action=lista',null,true);">Lista Comunicazioni</a></li>
	        <% }%>
	        <li><a href="#" onclick="callAction('gestioneVerIntervento.do?action=lista',null,true);">Lista Interventi</a></li>
            <li><a href="#" onclick="callAction('gestioneVerMisura.do?action=lista',null,true);">Lista Misure</a></li>
    
            <li><a href="#" onclick="callAction('scadenzarioVerificazione.do',null,true);">Scadenzario Strumenti</a></li>
             <% if(user.checkRuolo("AM") || user.checkRuolo("VE")){%>
            <li><a href="#" onclick="callAction('listaCampioni.do?campioni_verificazione=1',null,true);">Lista Campioni</a></li>
            <li><a href="#" onclick="callAction('scadenziario.do?action=campioni_verificazione&verificazione=1',null,true);">Scadenzario Campioni</a></li>
            <%} %>
            <% if(user.checkRuolo("AM") || !user.checkRuolo("VC")){%>
             <li><a href="#" onclick="callAction('gestioneVerLegalizzazioneBilance.do?action=lista',null,true);">Accertamento conformità</a></li>
             <li><a href="#" onclick="callAction('gestioneVerDocumenti.do?action=lista',null,true);">Documentazione Tecnica</a></li>
            
            <%} %>
         <li><a href="#" onclick="callAction('gestioneVerOfferte.do?action=lista_offerte',null,true);">Gestione Offerte</a></li>
          </ul>
        </li> 
           <% }%>
           
           
           <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_FORMAZIONE")|| user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN")){%>  
           <li class="header">FORMAZIONE</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Formazione</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		 <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN")){%>
			<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_docenti',null,true);">Gestione Docenti</a></li>			
			<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_referenti',null,true);">Gestione Referenti</a></li>
			<%} %>
			<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_partecipanti',null,true);">Gestione Partecipanti</a></li>	
			<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN")){%>				
			<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_cat_corsi',null,true);">Gestione Categorie Corsi</a></li>
			<%} %>
			<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_corsi',null,true);">Gestione Corsi</a></li>
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=scadenzario',null,true);">Scadenzario</a></li>
	      			<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN")){%>		
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=gestione_questionari',null,true);">Gestione questionari</a></li>
	      	<%} %>
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=consuntivo_questionari',null,true);">Gestione consuntivo questionari</a></li>
	      	<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN")){%>		
	      
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=gestione_pianificazione&anno=<%=anno %>',null,true);">Pianificazione</a></li>
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=lista_pianificazioni',null,true);">Lista Pianificazioni</a></li>
	      	<li><a href="#" onclick="callAction('gestioneFormazione.do?action=gestione_conf_email',null,true);">Configurazione Invio Email</a></li>
	      	<%} %>
          </ul>
        </li> 
           <% }%>
        
        
        
         <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_DOCUMENTALE")){%>  
           <li class="header">DOCUMENTALE</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Documentale</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
		    <%if(user.checkRuolo("AM") ||user.checkRuolo("D1")){ %>
			<li><a href="gestioneDocumentale.do?action=lista_committenti" >Gestione Committenti</a></li>
		
			<li><a href="gestioneDocumentale.do?action=lista_fornitori" >Gestione Fornitori</a></li>	
			<li><a href="gestioneDocumentale.do?action=lista_referenti" >Gestione Referenti</a></li>
			<li><a href="gestioneDocumentale.do?action=lista_dipendenti">Gestione Dipendenti</a></li>
				<%} %>
			<li><a href="gestioneDocumentale.do?action=lista_documenti" >Gestione Documenti</a></li>
			<%if(user.checkRuolo("AM") ||user.checkRuolo("D1")){ %>
			<li><a href="gestioneDocumentale.do?action=tipo_documento" >Gestione Tipi Documento</a></li>
			<%} %>
			<li><a href="gestioneDocumentale.do?action=scadenzario" >Scadenzario Documenti</a></li>
	      	
          </ul>
        </li> 
           <% }%>
        
        
        
        
              <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_DPI") || user.checkRuolo("DP")){%>  
           <li class="header">DPI</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Dispositivi</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
        <% if(!user.checkRuolo("DP")){%>  
		   <li><a href="gestioneDpi.do?action=lista">Elenco Dispositivi</a></li>	
		   <% }%>
			<li><a href="gestioneDpi.do?action=lista_schede_consegna">Schede consegna Dispositivi</a></li>
			<% if(!user.checkRuolo("DP")){%>  
			<li><a href="gestioneDpi.do?action=scadenzario">Scadenzario</a></li>		
			<li><a href="gestioneDpi.do?action=lista_manuali_dpi">Gestione manuali DPI</a></li>	
			<% }%>
	      	
          </ul>
        </li> 
           <% }%>
           
           
           <% if(user.checkRuolo("AM") || user.checkPermesso("CONTROLLI_OPERATIVI")){%>  
           <li class="header">CONTROLLI OPERATIVI</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Controlli Operativi </span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
      
		   <li><a href="gestioneControlliOperativi.do?action=lista_attrezzature">Lista Attrezzature</a></li>	
		
			<li><a href="gestioneControlliOperativi.do?action=lista_controlli">Lista Controlli</a></li>	
		 	      	
          </ul>
        </li> 
           <% }%>
          
           
         
          <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_DEVICE")){%>  
           <li class="header">DEVICE</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Device</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
   
		   <li><a href="gestioneDevice.do?action=lista_tipi_device">Tipi Device</a></li>	
  			<li><a href="gestioneDevice.do?action=lista_device">Lista Device</a></li>
  			<li><a href="gestioneDevice.do?action=lista_contratti">Lista Contratti</a></li>
  			<li><a href="gestioneDevice.do?action=lista_software">Lista Software</a></li>
  			<li><a href="gestioneDevice.do?action=lista_procedure">Lista Procedure</a></li>
  			<li><a href="gestioneDevice.do?action=scadenzario">LTA</a></li>
  			<li><a href="gestioneDevice.do?action=ricerca_software">Ricerca Software</a></li>
		
	      	
          </ul>
        </li> 
           <% }%>
        
        <% if(user.checkRuolo("AM") || user.checkPermesso("SCADENZARIO_IT")){%>  
         <li class="header">DEVICE</li>
          <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Scadenzario IT</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
        	<ul class="treeview-menu">
   
		   <li><a href="gestioneScadenzarioIT.do?action=lista">Scadenzario IT</a></li>	
		   
		   </ul>
		    </li> 
        <% }%>
        
                 
           <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_PARCO_AUTO")){%>  
           <li class="header">PARCO AUTO</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Parco Auto</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
    <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_PARCO_AUTO_ADMIN")){%>  
		   <li><a href="gestioneParcoAuto.do?action=lista_veicoli">Gestione Auto</a></li>	
		   <%} %>
		<li><a href="gestioneParcoAuto.do?action=gestione_prenotazioni">Gestione Prenotazioni</a></li>	
	      	<li><a href="confermaPrenotazione.do">Conferma Prenotazioni</a></li>
	      		<li><a href="gestioneParcoAuto.do?action=gestione_richieste">Richieste Prenotazioni</a></li>
	      		
	      		<li><a href="gestioneParcoAuto.do?action=lista_segnalazioni">Lista Segnalazioni</a></li>
	      		
          </ul>
        </li> 
           <% }%>
         
		<% if(user.checkRuolo("AM") || user.checkRuolo("AE")){%>  
        <li class="header">AM ENGINEERING</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Area AM Engineering</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		   <li><a href="amGestioneInterventi.do?action=lista">Lista Interventi</a></li>	
		   <li><a href="amGestioneStrumenti.do?action=lista">Lista Attrezzature</a></li>
		   <li><a href="amGestioneCampioni.do?action=lista">Lista Campioni</a></li>	
	  <li><a href="amGestioneInterventi.do?action=lista_prove">Lista Prove Effettuate</a></li> 
	  	  <li><a href="amGestioneInterventi.do?action=lista_immagini_campione">Lista Immagini Attrezzatura</a></li> 
          </ul>
        </li> 
        
        
        
         
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Scadenzario Attività</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		   <li><a href="amScGestioneScadenzario.do">Scadenzario Attività</a></li> 
          </ul>
        </li> 
        
           <% }%> 
           

        
         <% if(user.checkPermesso("GREEN_PASS")){%> 
         
        <!--    <li class="header">GREEN PASS</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Green Pass</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
   
		   <li><a href="gestioneGreenPass.do?action=lista">Gestione Green Pass</a></li>	
		
	      	
          </ul>
        </li> 
         -->
         <%} %>
        
        
  <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_MANUTENZIONI AM") || user.checkRuolo("MN")){%>  
           <li class="header">MANUTENZIONE SISTEMI</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Gestione Sistemi</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
			<li><a href="gestioneSistemiManutenzione.do?action=lista_sistemi">Lista Sistemi</a></li>
	
			<li><a href="gestioneSistemiManutenzione.do?action=lista_tipi_manutenzione">Gestione Tipo Attività</a></li>		

	      	
          </ul>
        </li> 
           <% }%> 
        
        
           <% if(user.checkRuolo("AM") || user.checkPermesso("ADMIN CONFIG")){%>
        <li class="header">-----------</li>
             <li class="treeview">
          <a href="#"><i class="fa fa-group"></i> <span>Configurazioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
        
          <ul class="treeview-menu">
           <% if(user.checkRuolo("AM") || user.checkPermesso("ADMIN CONFIG") || user.checkPermesso("GESTIONE_TREND")){%>
			<li><a href="listaUtenti.do"><i class="fa fa-group"></i>Gestione Utenti</a></li>
			  <% if(user.checkRuolo("AM")){%>
			<li><a href="listaCompany.do"><i class="fa fa-industry"></i>Gestione Company</a></li>
			<li><a href="listaRuoli.do"><i class="fa fa-hand-stop-o"></i>Gestione Ruoli</a></li>
			<li><a href="listaPermessi.do"><i class="fa fa-hand-pointer-o"></i>Gestione Permessi</a></li>
			
			  <% }%>
			<li><a href="gestioneAssociazioni.do"><i class="fa fa-hand-peace-o"></i>Gestione Associazioni</a></li>
			 <% }%>
			  <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_TREND")){%>
			  <li><a href="listaTrend.do?action=listaTrend"><i class="fa fa-hand-peace-o"></i>Gestione Trend</a></li>
			  	 <% }%>
			  	 
			  <li><a href="gestioneBacheca.do"><i class="fa fa-envelope"></i>Gestione Bacheca</a></li>
			  
			  <li><a href="gestioneTabelle.do"><i class="glyphicon glyphicon-th"></i>Gestione Tabelle</a></li>
			  <li><a href="gestioneTipoStrumento.do"><i class="glyphicon glyphicon-wrench"></i>Gestione Tipo Strumento</a></li>
			  		<% if(user.checkRuolo("AM")){%>
							<li>
								<a href="gestioneVersionePortale.do"><i class="fa fa-code-fork""></i>Gestione Versioni Portale</a>
								<a href="gestioneLog.do"><i class="fa fa-pencil""></i>Logs</a>
							</li>
						<% }%>
          </ul>
           
        </li>
         <% }%>
          <% if( user.checkPermesso("UTILITY")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Utility</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">          
       
			<li><a href="downloadCalver.do?action=calverdesktop">DasmTar v3.4.1</a></li>

			<li><a href="downloadCalver.do?action=dasmtarLat">DasmTarLAT v1.0.7</a></li>

			<li><a href="downloadCalver.do?action=sicurettaElettrica">DasmTarSE v1.0.2</a></li>
			<li><a href="downloadCalver.do?action=dasmtarVerificazione">DasmTarVER v3.6.1</a></li>
			<li><a href="downloadCalver.do?action=printLabel">PrintLabel v1.2.0</a></li>
			<li><a href="downloadCalver.do?action=librerie">Librerie</a></li>
			<li><a href="downloadCalver.do?action=convertitore">Convertitore</a></li>
			<% if(user.checkRuolo("AM") || user.checkRuolo("RS") || user.checkPermesso("FIRMA_DOCUMENTO")){%>
			<li><a href="firmaDocumento.do"><i class="fa fa-link"></i>Firma Documento</a></li>
			<%} %>
          </ul>
        </li>
           <% }%>

<!--          <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Monitor Landslide</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
          <li><a href="#" onclick="callAction('monitorLandslide.do',null,true);">Monitor</a></li>
           
          </ul>
        </li> -->
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>