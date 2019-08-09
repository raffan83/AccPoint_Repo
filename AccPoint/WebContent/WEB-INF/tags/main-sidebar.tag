<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@tag import="it.portaleSTI.DTO.UtenteDTO"%>

<% 
	UtenteDTO user =(UtenteDTO)request.getSession().getAttribute("userObj");
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
          </ul>
        </li>
         <% }%>
          <% if(user.checkRuolo("AM") || user.checkPermesso("LISTA_INTERVENTI_METROLOGIA")){%>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Interventi</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
    			<li><a href="#" onclick="callAction('listaInterventi.do',null,true);">Lista Interventi</a></li>
    			<% if(user.checkRuolo("AM") || user.checkPermesso("LISTA_INTERVENTI_OPERATORE")){%>
    			<li><a href="#" onclick="callAction('listaInterventiOperatore.do',null,true);">Interventi Operatore</a></li>
    			<% }%>
          </ul>
        </li>
         <% }%>
          <% if(user.checkRuolo("AM") || user.checkPermesso("LISTA_CERTIFICATI_MENU_METROLOGIA")){%>
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
          <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_STRUMENTI_METROLOGIA")){%>
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
			<li><a href="listaCampioniPrenotabili.do">Campioni  Prenotabili</a></li>
			<li><a href="scadenziario.do">Scadenziario</a></li>
          </ul>
        </li>
            <% }%>
              <% if(user.checkRuolo("AM") || user.checkPermesso("PRENOTAZIONE_CAMPIONE_MENU_METROLOGIA")){%>
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
		<% }%>
		


 <li class="treeview">
 <% if(user.checkRuolo("AM") || user.checkPermesso("RILIEVI_DIMENSIONALI") || user.checkPermesso("VISUALIZZA_RILIEVI_DIMENSIONALI")){%>
          <a href="#"><i class="fa fa-link"></i> <span>Rilievi Dimensionali</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">             
			<li><a href="#" onclick="callAction('listaRilieviDimensionali.do',null,true);">Gestione Rilievi</a></li> 
			
				
          </ul>
          <%} %>
        </li>


<% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_COMMESSE_CAMPIONAMENTO")){%>
       <%--  <% if(!user.checkRuolo("CL")){%> --%>
        <li class="header">CAMPIONAMENTO</li>
      <%--    <% }%> --%>
           
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
        <% }%>
        
        
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
          </ul>
        </li>
          <% }%>
          
 	  <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_SEGRETERIA")){%> 

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
           <% }%>
           
         <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_VER_STRUMENTI")){%>  
           <li class="header">VERIFICAZIONE STRUMENTI</li>

         <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Verificazione Strumenti</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
		
			<li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do',null,true);">Comunicazione Preventiva</a></li>
			<li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do?action=esito_comunicazioni',null,true);">Comunicazione Esito</a></li>
	        <li><a href="#" onclick="callAction('gestioneVerStrumenti.do',null,true);">Gestione Strumenti</a></li>
	        <li><a href="#" onclick="callAction('gestioneVerComunicazionePreventiva.do?action=lista',null,true);">Lista Comunicazioni</a></li>
	        <li><a href="#" onclick="callAction('gestioneVerIntervento.do?action=lista',null,true);">Lista Interventi</a></li>
           
          </ul>
        </li> 
           <% }%>
        
           <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_CONFIGURAZIONI")){%>
        <li class="header">-----------</li>
             <li class="treeview">
          <a href="#"><i class="fa fa-group"></i> <span>Configurazioni</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
        
          <ul class="treeview-menu">
           <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_CONFIGURAZIONI") || user.checkPermesso("GESTIONE_TREND")){%>
			<li><a href="listaUtenti.do"><i class="fa fa-group"></i>Gestione Utenti</a></li>
			  <% if(user.checkRuolo("AM")){%>
			<li><a href="listaCompany.do"><i class="fa fa-industry"></i>Gestione Company</a></li>
			<li><a href="listaRuoli.do"><i class="fa fa-hand-stop-o"></i>Gestione Ruoli</a></li>
			<li><a href="listaPermessi.do"><i class="fa fa-hand-pointer-o"></i>Gestione Permessi</a></li>
			<li><a href="gestioneConfigurazioniClienti.do?action=lista"><i class="fa fa-industry"></i>Gestione Clienti</a></li>
			  <% }%>
			<li><a href="gestioneAssociazioni.do"><i class="fa fa-hand-peace-o"></i>Gestione Associazioni</a></li>
			 <% }%>
			  <% if(user.checkRuolo("AM") || user.checkPermesso("GESTIONE_TREND")){%>
			  <li><a href="listaTrend.do?action=listaTrend"><i class="fa fa-hand-peace-o"></i>Gestione Trend</a></li>
			  	 <% }%>
			  	 
			  <li><a href="gestioneBacheca.do"><i class="fa fa-envelope"></i>Gestione Bacheca</a></li>
			  
			  <li><a href="gestioneTabelle.do"><i class="glyphicon glyphicon-th"></i>Gestione Tabelle</a></li>
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
			<li><a href="downloadCalver.do?action=calverdesktop">DasmTar v2.0.3</a></li>
			<li><a href="downloadCalver.do?action=sicurettaElettrica">DasmTarSE v0.0.1</a></li>
			<li><a href="downloadCalver.do?action=printLabel">PrintLabel v1.1</a></li>
			<li><a href="downloadCalver.do?action=librerie">Librerie</a></li>
			<li><a href="downloadCalver.do?action=convertitore">Convertitore</a></li>
			<% if(user.checkRuolo("AM")){%>
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