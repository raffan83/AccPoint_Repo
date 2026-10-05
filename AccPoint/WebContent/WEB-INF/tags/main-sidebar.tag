<%@ tag language="java" pageEncoding="UTF-8"%>
<%@tag import="it.portaleSTI.DTO.UtenteDTO"%>
<%@ taglib uri="/WEB-INF/tld/utilities" prefix="utl" %>
<%@ tag import="java.util.Calendar" %>
<%@ tag import="java.util.Map" %>
<%@ tag import="java.util.LinkedHashMap" %>
<%@ tag import="java.util.List" %>
<%@ tag import="java.util.ArrayList" %>

<%!
  // <li><a href="...">testo</a></li>
private String voce(String href, String icona, String testo) {
    return "<li><a href=\"" + href + "\"><i class=\"fa " + icona + "\"></i> " + testo + "</a></li>";
}

  // <li><a href="#" onclick="callAction('url',null,true);">testo</a></li>
private String voceAction(String url, String icona, String testo) {
    return "<li><a href=\"#\" onclick=\"callAction('" + url + "',null,true);\"><i class=\"fa " + icona + "\"></i> " + testo + "</a></li>";
}


  // <a href="#"><i class="fa ICONA"></i> <span>TITOLO</span> + freccia</a>  (intestazione del gruppo)
  private String gruppo(String icona, String titolo) {
    return "<a href=\"#\"><i class=\"fa " + icona + "\"></i> <span>" + titolo + "</span>"
         + "<span class=\"pull-right-container\"><i class=\"fa fa-angle-left pull-right\"></i></span></a>";
  }


  // [<li class="header">..</li>] + <li class="treeview"> intestazione <ul>voci</ul></li>
  private String blocco(String header, String gruppo, String... voci) {
    StringBuilder sb = new StringBuilder();
    if (header != null && !header.isEmpty()) {
      sb.append("<li class=\"header\">").append(header).append("</li>");
    }
    sb.append("<li class=\"treeview\">").append(gruppo).append("<ul class=\"treeview-menu\">");
    for (String v : voci) {
      sb.append(v);
    }
    sb.append("</ul></li>");
    return sb.toString();
  }


  // Costruisce il blocco completo (chiave "blocchi"+x) e registra il gruppo nella lista per la dashboard
  // (titoloBlocco, titoloGruppo, voci non vuote). Legge dalla mappa titoloBlocco+x, titoloGruppo+x, menu+x.
  private void addBlocco(Map<String, String> t, List<Map<String, Object>> gruppi, boolean cond, String x, String... voci) {
    add(t, cond, "blocchi" + x, blocco(t.get("titoloBlocco" + x), t.get("menu" + x), voci));
    if (!cond) {
      return;
    }
    List<String> piene = new ArrayList<String>();
    for (String v : voci) {
      if (v != null && !v.isEmpty()) {
        piene.add(v);
      }
    }
    if (piene.isEmpty()) {
      return;
    }
    Map<String, Object> g = new LinkedHashMap<String, Object>();
    g.put("chiave", x);
    g.put("titoloBlocco", t.get("titoloBlocco" + x));
    g.put("titoloGruppo", t.get("titoloGruppo" + x));
    g.put("voci", piene);
    gruppi.add(g);
  }

  // Se cond e' vero salva l'HTML, altrimenti stringa vuota
  private void add(Map<String, String> m, boolean cond, String key, String html) {
    m.put(key, cond ? html : "");
  }
%>
<%
	UtenteDTO user = (UtenteDTO) request.getSession().getAttribute("userObj");
	int anno = Calendar.getInstance().get(Calendar.YEAR);

	// Ruoli usati piu' volte
	boolean isAM = user.checkRuolo("AM");
	boolean isCL = user.checkRuolo("CL");

	// Condizioni di gruppo (le stesse degli if nel markup), usate per valorizzare le voci
	boolean gCommesse    = isAM || user.checkPermesso("GESTIONE_COMMESSE_METROLOGIA");
	boolean gInterventi  = isAM || user.checkRuolo("PV") || user.checkPermesso("LISTA_INTERVENTI_METROLOGIA");
	boolean gMisure      = gInterventi;
	boolean gCertificati = isAM || user.checkRuolo("PV") || user.checkPermesso("LISTA_CERTIFICATI_MENU_METROLOGIA");
	boolean gStrumenti   = isAM || user.checkPermesso("STRUMENTI_MENU_METROLOGIA");
	boolean gCampioni    = isAM || user.checkPermesso("CAMPIONI_MENU_METROLOGIA");
	boolean gRilievi     = isAM || user.checkPermesso("RILIEVI_DIMENSIONALI") || user.checkPermesso("VISUALIZZA_RILIEVI_DIMENSIONALI");
	boolean gRisorse     = isAM || user.checkPermesso("GESTIONE_RISORSE");
	boolean gMagazzino   = isAM || user.checkPermesso("GESTIONE_MAGAZZINO");
	boolean gVer         = isAM || user.checkPermesso("GESTIONE_VER_STRUMENTI") || user.checkPermesso("GESTIONE_VER_STRUMENTI_CLIENTE");
	boolean gFormazione  = isAM || user.checkPermesso("GESTIONE_FORMAZIONE") || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN");
	boolean gDocumentale = isAM || user.checkPermesso("GESTIONE_DOCUMENTALE");
	boolean gDpi         = isAM || user.checkPermesso("GESTIONE_DPI") || user.checkRuolo("DP");
	boolean gControlli   = isAM || user.checkPermesso("CONTROLLI_OPERATIVI");
	boolean gDevice      = isAM || user.checkPermesso("GESTIONE_DEVICE");
	boolean gScadIT      = isAM || user.checkPermesso("SCADENZARIO_IT");
	boolean gParcoAuto   = isAM || user.checkPermesso("GESTIONE_PARCO_AUTO");
	boolean gAmEng       = isAM || user.checkRuolo("AE");
	boolean gConfig      = isAM || user.checkPermesso("ADMIN CONFIG");
	boolean gUtility     = user.checkPermesso("UTILITY");

	Map<String, String> t = new LinkedHashMap<String, String>();
	// gruppi in ordine, con le loro voci (per la dashboard)
	List<Map<String, Object>> gruppi = new ArrayList<Map<String, Object>>();

	// ---------- METROLOGIA / COMMESSE ----------
	add(t, gCommesse, "tabGestioneCommessa", voce("gestioneCommessa.do", "fa-folder-open", "Gestione Commessa"));
	add(t, gCommesse && user.checkPermesso("SCHEDE_CONSEGNA"), "tabSchedeConsegna", voce("listaSchedeConsegna.do", "fa-file-text-o", "Schede di Consegna"));
	add(t, gCommesse, "tabStatoConsegna", voceAction("gestioneIntervento.do?action=stato_consegna_interventi", "fa-truck", "Stato Consegna Interventi"));

	// ---------- METROLOGIA / INTERVENTI ----------
	boolean condListaInterventi = isAM || user.checkPermesso("LISTA_INTERVENTI_METROLOGIA");
	boolean condAssegnazione    = isAM || (user.checkPermesso("LISTA_INTERVENTI_METROLOGIA") && !user.checkRuolo("FR"));
	boolean condInterventiOper  = isAM || user.checkPermesso("LISTA_INTERVENTI_OPERATORE");
	boolean condAttivitaAdmin   = condInterventiOper && (isAM || user.checkPermesso("GESTIONE_ASSEGNAZIONE_ATTIVITA_ADMIN"));

	add(t, gInterventi && condListaInterventi, "tabListaInterventi", voceAction("listaInterventi.do", "fa-list", "Lista Interventi"));
	add(t, gInterventi && condAssegnazione, "tabAssegnazioneAttivita", voceAction("gestioneAssegnazioneAttivita.do?action=lista&admin=0", "fa-user-plus", "Assegnazione Attività"));
	add(t, gInterventi && condAssegnazione, "tabControlloAttivita", voceAction("gestioneAssegnazioneAttivita.do?action=controllo_attivita&admin=0", "fa-check-square-o", "Controllo Attività"));
	add(t, gInterventi && condInterventiOper, "tabInterventiOperatore", voceAction("listaInterventiOperatore.do?action=filtra_date&mese=1", "fa-wrench", "Interventi Operatore"));
	add(t, gInterventi && condAttivitaAdmin, "tabAssegnazioneAttivitaAdmin", voceAction("gestioneAssegnazioneAttivita.do?action=lista&admin=1", "fa-user-plus", "Assegnazione Attività Admin"));
	add(t, gInterventi && condAttivitaAdmin, "tabControlloAttivitaAdmin", voceAction("gestioneAssegnazioneAttivita.do?action=controllo_attivita&admin=1", "fa-check-square-o", "Controllo Attività Admin"));
	add(t, gInterventi && (isAM || user.checkRuolo("SR")), "tabListaSessioni", voceAction("listaSessioni.do", "fa-calendar-check-o", "Lista Sessioni"));

	// ---------- METROLOGIA / MISURE ----------
	add(t, gMisure && (isAM || (user.checkPermesso("LISTA_INTERVENTI_METROLOGIA") && !user.checkRuolo("PV"))), "tabListaMisure", voceAction("gestioneMisura.do?action=lista", "fa-balance-scale", "Lista Misure"));
	add(t, gMisure && (isAM || user.checkRuolo("OP")), "tabGestioneClienti", voce("gestioneConfigurazioniClienti.do?action=lista", "fa-industry", "Gestione Clienti"));
	add(t, gMisure && isAM, "tabModificheAdmin", voce("gestioneModificheAdmin.do", "fa-pencil-square-o", "Gestione Modifiche Admin"));

	// ---------- METROLOGIA / CERTIFICATI ----------
	add(t, gCertificati, "tabListaCertificati", voce("listaCertificati.do", "fa-certificate", "Lista Certificati"));

	// ---------- METROLOGIA / STRUMENTI ----------
	add(t, gStrumenti && (isAM || user.checkPermesso("GESTIONE_STRUMENTI_METROLOGIA")), "tabGestioneStrumenti", voceAction("listaStrumentiNew.do", "fa-wrench", "Gestione Strumenti"));
	add(t, gStrumenti && (isAM || user.checkPermesso("SCADENZIARIO_STRUMENTI_METROLOGIA")), "tabScadenziarioStrumenti", voce("scadenziarioStrumenti.do", "fa-calendar", "Scadenziario"));
	add(t, gStrumenti && (isAM || user.checkPermesso("RICERCA_STRUMENTI_DATE_METROLOGIA")), "tabRicercaDateStrumenti", voce("ricercaDateStrumenti.do", "fa-search", "Ricerca per Date"));

	// ---------- METROLOGIA / CAMPIONI ----------
	boolean condCampioniAvanzati = isAM || (user.checkPermesso("CAMPIONI_MENU_METROLOGIA") && !user.checkRuolo("FR") && !user.checkRuolo("VC"));

	add(t, gCampioni, "tabCampioniPersonali", voce("listaCampioni.do", "fa-flask", "Campioni  Personali"));
	add(t, gCampioni && condCampioniAvanzati, "tabCampioniPrenotabili", voce("listaCampioniPrenotabili.do", "fa-flask", "Campioni  Prenotabili"));
	add(t, gCampioni, "tabScadenziarioCampioni", voce("scadenziario.do", "fa-calendar", "Scadenziario"));
	add(t, gCampioni && condCampioniAvanzati, "tabScadenziarioLat", voce("scadenziario.do?lat=CDT", "fa-calendar", "Scadenziario LAT"));
	add(t, gCampioni && condCampioniAvanzati, "tabLibrerieElettrici", voce("gestioneLibrerieElettrici.do?action=lista", "fa-book", "Librerie Elettrici"));
	add(t, gCampioni && condCampioniAvanzati, "tabGestionePrenotazioni", voce("gestionePrenotazioneCampione.do?action=gestione_prenotazioni", "fa-calendar-check-o", "Gestione Prenotazioni"));

	// ---------- RILIEVI DIMENSIONALI ----------
	add(t, gRilievi && !user.checkRuolo("RL"), "tabRilieviListaInterventi", voceAction("listaRilieviDimensionali.do?action=lista_interventi", "fa-list", "Lista Interventi"));
	add(t, gRilievi, "tabGestioneRilievi", voceAction("listaRilieviDimensionali.do", "fa-arrows", "Gestione Rilievi"));

	// ---------- PIANIFICAZIONE RISORSE ----------
	add(t, gRisorse && !user.checkRuolo("RL"), "tabGestioneRisorse", voceAction("gestioneRisorse.do?action=lista_risorse", "fa-users", "Gestione Risorse"));
	add(t, gRisorse, "tabGestioneRequisiti", voceAction("gestioneRisorse.do?action=lista_requisiti", "fa-check-square-o", "Gestione Requisiti"));
	add(t, gRisorse, "tabPianificazioneRisorse", voceAction("gestioneRisorse.do?action=pianificazione_risorse", "fa-calendar", "Pianificazione Risorse"));

	// ---------- MAGAZZINO ----------
	add(t, gMagazzino, "tabStatoMagazzino", voceAction("listaPacchi.do", "fa-cubes", "Stato Magazzino"));
	add(t, gMagazzino, "tabStatoItemMagazzino", voceAction("listaItem.do?action=lista", "fa-cube", "Stato Item Magazzino"));
	add(t, gMagazzino, "tabStatoDdt", voceAction("listaPacchi.do?action=lista_ddt", "fa-file-text-o", "Stato DDT"));
	add(t, gMagazzino, "tabPressoFornitore", voceAction("gestionePacco.do?action=presso_fornitore", "fa-truck", "Presso Fornitore"));
	add(t, gMagazzino, "tabAttivitaInCorso", voceAction("gestionePacco.do?action=pacchi_lavorazione", "fa-cogs", "Attivit&agrave; in corso"));

	// ---------- VERIFICAZIONE STRUMENTI ----------
	boolean condVerAdmin = user.checkPermesso("GESTIONE_VER_STRUMENTI");

	add(t, gVer && condVerAdmin, "tabVerComunicazioneEsito", voceAction("gestioneVerComunicazionePreventiva.do?action=esito_comunicazioni", "fa-envelope", "Comunicazione Esito"));
	add(t, gVer && condVerAdmin, "tabVerGestioneCommesse", voce("gestioneVerIntervento.do?action=lista_commesse", "fa-folder-open", "Gestione Commesse"));
	add(t, gVer, "tabVerGestioneStrumenti", voceAction("gestioneVerStrumenti.do", "fa-wrench", "Gestione Strumenti"));
	add(t, gVer, "tabVerListaCertificati", voceAction("gestioneVerCertificati.do", "fa-certificate", "Lista Certificati"));
	add(t, gVer && condVerAdmin, "tabVerListaComunicazioni", voceAction("gestioneVerComunicazionePreventiva.do?action=lista", "fa-envelope-o", "Lista Comunicazioni"));
	add(t, gVer, "tabVerListaInterventi", voceAction("gestioneVerIntervento.do?action=lista", "fa-list", "Lista Interventi"));
	add(t, gVer, "tabVerListaMisure", voceAction("gestioneVerMisura.do?action=lista", "fa-balance-scale", "Lista Misure"));
	add(t, gVer, "tabVerScadenzarioStrumenti", voceAction("scadenzarioVerificazione.do", "fa-calendar", "Scadenzario Strumenti"));
	add(t, gVer && (isAM || user.checkRuolo("VE")), "tabVerListaCampioni", voceAction("listaCampioni.do?campioni_verificazione=1", "fa-flask", "Lista Campioni"));
	add(t, gVer && (isAM || user.checkRuolo("VE")), "tabVerScadenzarioCampioni", voceAction("scadenziario.do?action=campioni_verificazione&verificazione=1", "fa-calendar", "Scadenzario Campioni"));
	add(t, gVer && (isAM || !user.checkRuolo("VC")), "tabVerAccertamentoConformita", voceAction("gestioneVerLegalizzazioneBilance.do?action=lista", "fa-check-circle-o", "Accertamento conformità"));
	add(t, gVer && (isAM || !user.checkRuolo("VC")), "tabVerDocumentazioneTecnica", voceAction("gestioneVerDocumenti.do?action=lista", "fa-file-text-o", "Documentazione Tecnica"));
	add(t, gVer, "tabVerGestioneOfferte", voceAction("gestioneVerOfferte.do?action=lista_offerte", "fa-eur", "Gestione Offerte"));

	// ---------- FORMAZIONE ----------
	boolean condFormAdmin = isAM || user.checkPermesso("GESTIONE_FORMAZIONE_ADMIN");

	add(t, gFormazione && condFormAdmin, "tabFormDocenti", voceAction("gestioneFormazione.do?action=lista_docenti", "fa-user", "Gestione Docenti"));
	add(t, gFormazione && condFormAdmin, "tabFormReferenti", voceAction("gestioneFormazione.do?action=lista_referenti", "fa-user", "Gestione Referenti"));
	add(t, gFormazione, "tabFormPartecipanti", voceAction("gestioneFormazione.do?action=lista_partecipanti", "fa-users", "Gestione Partecipanti"));
	add(t, gFormazione && condFormAdmin, "tabFormCategorieCorsi", voceAction("gestioneFormazione.do?action=lista_cat_corsi", "fa-tags", "Gestione Categorie Corsi"));
	add(t, gFormazione, "tabFormCorsi", voceAction("gestioneFormazione.do?action=lista_corsi", "fa-graduation-cap", "Gestione Corsi"));
	add(t, gFormazione, "tabFormScadenzario", voceAction("gestioneFormazione.do?action=scadenzario", "fa-calendar", "Scadenzario"));
	add(t, gFormazione && condFormAdmin, "tabFormQuestionari", voceAction("gestioneFormazione.do?action=gestione_questionari", "fa-question-circle", "Gestione questionari"));
	add(t, gFormazione, "tabFormConsuntivoQuestionari", voceAction("gestioneFormazione.do?action=consuntivo_questionari", "fa-bar-chart", "Gestione consuntivo questionari"));
	add(t, gFormazione && condFormAdmin, "tabFormPianificazione", voceAction("gestioneFormazione.do?action=gestione_pianificazione&anno=" + anno, "fa-calendar", "Pianificazione"));
	add(t, gFormazione && condFormAdmin, "tabFormListaPianificazioni", voceAction("gestioneFormazione.do?action=lista_pianificazioni", "fa-list", "Lista Pianificazioni"));
	add(t, gFormazione && condFormAdmin, "tabFormConfEmail", voceAction("gestioneFormazione.do?action=gestione_conf_email", "fa-envelope", "Configurazione Invio Email"));

	// ---------- DOCUMENTALE ----------
	boolean condDocD1 = isAM || user.checkRuolo("D1");

	add(t, gDocumentale && condDocD1, "tabDocCommittenti", voce("gestioneDocumentale.do?action=lista_committenti", "fa-industry", "Gestione Committenti"));
	add(t, gDocumentale && condDocD1, "tabDocFornitori", voce("gestioneDocumentale.do?action=lista_fornitori", "fa-truck", "Gestione Fornitori"));
	add(t, gDocumentale && condDocD1, "tabDocReferenti", voce("gestioneDocumentale.do?action=lista_referenti", "fa-user", "Gestione Referenti"));
	add(t, gDocumentale && condDocD1, "tabDocDipendenti", voce("gestioneDocumentale.do?action=lista_dipendenti", "fa-users", "Gestione Dipendenti"));
	add(t, gDocumentale, "tabDocDocumenti", voce("gestioneDocumentale.do?action=lista_documenti", "fa-file-text-o", "Gestione Documenti"));
	add(t, gDocumentale && condDocD1, "tabDocTipiDocumento", voce("gestioneDocumentale.do?action=tipo_documento", "fa-files-o", "Gestione Tipi Documento"));
	add(t, gDocumentale, "tabDocScadenzario", voce("gestioneDocumentale.do?action=scadenzario", "fa-calendar", "Scadenzario Documenti"));

	// ---------- DPI ----------
	add(t, gDpi && !user.checkRuolo("DP"), "tabDpiElenco", voce("gestioneDpi.do?action=lista", "fa-shield", "Elenco Dispositivi"));
	add(t, gDpi, "tabDpiSchedeConsegna", voce("gestioneDpi.do?action=lista_schede_consegna", "fa-file-text-o", "Schede consegna Dispositivi"));
	add(t, gDpi && !user.checkRuolo("DP"), "tabDpiScadenzario", voce("gestioneDpi.do?action=scadenzario", "fa-calendar", "Scadenzario"));
	add(t, gDpi && !user.checkRuolo("DP"), "tabDpiManuali", voce("gestioneDpi.do?action=lista_manuali_dpi", "fa-book", "Gestione manuali DPI"));

	// ---------- CONTROLLI OPERATIVI ----------
	add(t, gControlli, "tabCoAttrezzature", voce("gestioneControlliOperativi.do?action=lista_attrezzature", "fa-wrench", "Lista Attrezzature"));
	add(t, gControlli, "tabCoControlli", voce("gestioneControlliOperativi.do?action=lista_controlli", "fa-check-square-o", "Lista Controlli"));

	// ---------- DEVICE ----------
	add(t, gDevice, "tabDeviceTipi", voce("gestioneDevice.do?action=lista_tipi_device", "fa-tags", "Tipi Device"));
	add(t, gDevice, "tabDeviceLista", voce("gestioneDevice.do?action=lista_device", "fa-laptop", "Lista Device"));
	add(t, gDevice, "tabDeviceContratti", voce("gestioneDevice.do?action=lista_contratti", "fa-file-text-o", "Lista Contratti"));
	add(t, gDevice, "tabDeviceSoftware", voce("gestioneDevice.do?action=lista_software", "fa-code", "Lista Software"));
	add(t, gDevice, "tabDeviceProcedure", voce("gestioneDevice.do?action=lista_procedure", "fa-book", "Lista Procedure"));
	add(t, gDevice, "tabDeviceLta", voce("gestioneDevice.do?action=scadenzario", "fa-calendar", "LTA"));
	add(t, gDevice, "tabDeviceRicercaSoftware", voce("gestioneDevice.do?action=ricerca_software", "fa-search", "Ricerca Software"));

	// ---------- SCADENZARIO IT ----------
	add(t, gScadIT, "tabScadenzarioIt", voce("gestioneScadenzarioIT.do?action=lista", "fa-calendar", "Scadenzario IT"));

	// ---------- PARCO AUTO ----------
	add(t, gParcoAuto && (isAM || user.checkPermesso("GESTIONE_PARCO_AUTO_ADMIN")), "tabPaGestioneAuto", voce("gestioneParcoAuto.do?action=lista_veicoli", "fa-car", "Gestione Auto"));
	add(t, gParcoAuto, "tabPaGestionePrenotazioni", voce("gestioneParcoAuto.do?action=gestione_prenotazioni", "fa-calendar-check-o", "Gestione Prenotazioni"));
	add(t, gParcoAuto, "tabPaConfermaPrenotazioni", voce("confermaPrenotazione.do", "fa-check-circle-o", "Conferma Prenotazioni"));
	add(t, gParcoAuto, "tabPaRichiestePrenotazioni", voce("gestioneParcoAuto.do?action=gestione_richieste", "fa-calendar-plus-o", "Richieste Prenotazioni"));
	add(t, gParcoAuto, "tabPaListaSegnalazioni", voce("gestioneParcoAuto.do?action=lista_segnalazioni", "fa-exclamation-triangle", "Lista Segnalazioni"));

	// ---------- AM ENGINEERING ----------
	add(t, gAmEng, "tabAmListaInterventi", voce("amGestioneInterventi.do?action=lista", "fa-list", "Lista Interventi"));
	add(t, gAmEng, "tabAmListaAttrezzature", voce("amGestioneStrumenti.do?action=lista", "fa-wrench", "Lista Attrezzature"));
	add(t, gAmEng, "tabAmListaCampioni", voce("amGestioneCampioni.do?action=lista", "fa-flask", "Lista Campioni"));
	add(t, gAmEng, "tabAmListaProve", voce("amGestioneInterventi.do?action=lista_prove", "fa-check-square-o", "Lista Prove Effettuate"));
	add(t, gAmEng, "tabAmListaImmagini", voce("amGestioneInterventi.do?action=lista_immagini_campione", "fa-picture-o", "Lista Immagini Attrezzatura"));
	add(t, gAmEng, "tabAmScadenzarioAttivita", voce("amScGestioneScadenzario.do", "fa-calendar", "Scadenzario Attività"));
	add(t, gAmEng, "tabAmListaAttivita", voce("amScGestioneScadenzario.do?action=lista_attivita&tipo_filtro=data", "fa-list", "Lista Attività"));

	// ---------- CONFIGURAZIONI ----------
	boolean condConfUtenti = isAM || user.checkPermesso("ADMIN CONFIG") || user.checkPermesso("GESTIONE_TREND");

	add(t, gConfig && condConfUtenti, "tabConfUtenti", voce("listaUtenti.do", "fa-users", "Gestione Utenti"));
	add(t, gConfig && condConfUtenti && isAM, "tabConfCompany", voce("listaCompany.do", "fa-industry", "Gestione Company"));
	add(t, gConfig && condConfUtenti && isAM, "tabConfRuoli", voce("listaRuoli.do", "fa-user-secret", "Gestione Ruoli"));
	add(t, gConfig && condConfUtenti && isAM, "tabConfPermessi", voce("listaPermessi.do", "fa-key", "Gestione Permessi"));
	add(t, gConfig && condConfUtenti, "tabConfAssociazioni", voce("gestioneAssociazioni.do", "fa-link", "Gestione Associazioni"));
	add(t, gConfig && (isAM || user.checkPermesso("GESTIONE_TREND")), "tabConfTrend", voce("listaTrend.do?action=listaTrend", "fa-line-chart", "Gestione Trend"));
	add(t, gConfig, "tabConfBacheca", voce("gestioneBacheca.do", "fa-envelope", "Gestione Bacheca"));
	add(t, gConfig, "tabConfTabelle", voce("gestioneTabelle.do", "fa-table", "Gestione Tabelle"));
	add(t, gConfig, "tabConfTipoStrumento", voce("gestioneTipoStrumento.do", "fa-wrench", "Gestione Tipo Strumento"));
	add(t, gConfig && isAM, "tabConfVersioniLogs", "<li><a href=\"gestioneVersionePortale.do\"><i class=\"fa fa-code-fork\"></i> Gestione Versioni Portale</a><a href=\"gestioneLog.do\"><i class=\"fa fa-pencil\"></i> Logs</a></li>");

	// ---------- UTILITY ----------
	add(t, gUtility, "tabUtDasmTar", voce("downloadCalver.do?action=calverdesktop", "fa-download", "DasmTar v3.6.1"));
	add(t, gUtility, "tabUtDasmTarLat", voce("downloadCalver.do?action=dasmtarLat", "fa-download", "DasmTarLAT v1.0.7"));
	add(t, gUtility, "tabUtDasmTarSe", voce("downloadCalver.do?action=sicurettaElettrica", "fa-download", "DasmTarSE v3.1.1"));
	add(t, gUtility, "tabUtDasmTarVer", voce("downloadCalver.do?action=dasmtarVerificazione", "fa-download", "DasmTarVER v3.6.1"));
	add(t, gUtility, "tabUtPrintLabel", voce("downloadCalver.do?action=printLabel", "fa-print", "PrintLabel v1.2.0"));
	add(t, gUtility, "tabUtLibrerie", voce("downloadCalver.do?action=librerie", "fa-book", "Librerie"));
	add(t, gUtility, "tabUtConvertitore", voce("downloadCalver.do?action=convertitore", "fa-exchange", "Convertitore"));
	add(t, gUtility && (isAM || user.checkRuolo("RS") || user.checkPermesso("FIRMA_DOCUMENTO")), "tabUtFirmaDocumento", voce("firmaDocumento.do", "fa-pencil-square-o", "Firma Documento"));

	// ---------- TITOLI (gruppo e blocco) ----------
	// titoloGruppoX = nome del gruppo (es. Commesse); titoloBloccoX = testo dell'header sopra il gruppo (es. METROLOGIA), vuoto se non c'e'
	add(t, gCommesse, "titoloGruppoCommesse", "Commesse");
	add(t, gCommesse && !isCL, "titoloBloccoCommesse", "METROLOGIA");
	add(t, gInterventi, "titoloGruppoInterventi", "Interventi");
	add(t, gInterventi && user.checkRuolo("PV"), "titoloBloccoInterventi", "METROLOGIA");
	add(t, gMisure, "titoloGruppoMisure", "Misure");
	add(t, gMisure && user.checkRuolo("PV"), "titoloBloccoMisure", "METROLOGIA");
	add(t, gCertificati, "titoloGruppoCertificati", "Certificati");
	add(t, gCertificati, "titoloBloccoCertificati", "");
	add(t, gStrumenti, "titoloGruppoStrumenti", "Strumenti");
	add(t, gStrumenti, "titoloBloccoStrumenti", "");
	add(t, gCampioni, "titoloGruppoCampioni", "Campioni");
	add(t, gCampioni, "titoloBloccoCampioni", "");
	add(t, gRilievi, "titoloGruppoRilievi", "Rilievi Dimensionali");
	add(t, gRilievi, "titoloBloccoRilievi", "");
	add(t, gRisorse, "titoloGruppoRisorse", "Pianificazione Risorse");
	add(t, gRisorse, "titoloBloccoRisorse", "");
	add(t, gMagazzino, "titoloGruppoMagazzino", "Gestione Magazzino");
	add(t, gMagazzino, "titoloBloccoMagazzino", "MAGAZZINO");
	add(t, gVer, "titoloGruppoVerificazione", "Verificazione Strumenti");
	add(t, gVer, "titoloBloccoVerificazione", "VERIFICAZIONE STRUMENTI");
	add(t, gFormazione, "titoloGruppoFormazione", "Gestione Formazione");
	add(t, gFormazione, "titoloBloccoFormazione", "FORMAZIONE");
	add(t, gDocumentale, "titoloGruppoDocumentale", "Gestione Documentale");
	add(t, gDocumentale, "titoloBloccoDocumentale", "DOCUMENTALE");
	add(t, gDpi, "titoloGruppoDpi", "Gestione Dispositivi");
	add(t, gDpi, "titoloBloccoDpi", "DPI");
	add(t, gControlli, "titoloGruppoControlli", "Controlli Operativi");
	add(t, gControlli, "titoloBloccoControlli", "CONTROLLI OPERATIVI");
	add(t, gDevice, "titoloGruppoDevice", "Gestione Device");
	add(t, gDevice, "titoloBloccoDevice", "DEVICE");
	add(t, gScadIT, "titoloGruppoScadenzarioIt", "Scadenzario IT");
	add(t, gScadIT, "titoloBloccoScadenzarioIt", "DEVICE");
	add(t, gParcoAuto, "titoloGruppoParcoAuto", "Gestione Parco Auto");
	add(t, gParcoAuto, "titoloBloccoParcoAuto", "PARCO AUTO");
	add(t, gAmEng, "titoloGruppoAmEngineering", "Area AM Engineering");
	add(t, gAmEng, "titoloBloccoAmEngineering", "AM ENGINEERING");
	add(t, gAmEng, "titoloGruppoAmScadenzario", "Scadenzario Attività");
	add(t, gAmEng, "titoloBloccoAmScadenzario", "");
	add(t, gConfig, "titoloGruppoConfigurazioni", "Configurazioni");
	add(t, gConfig, "titoloBloccoConfigurazioni", "-----------");
	add(t, gUtility, "titoloGruppoUtility", "Utility");
	add(t, gUtility, "titoloBloccoUtility", "");

	// ---------- INTESTAZIONI DEI GRUPPI ----------
	add(t, gCommesse, "menuCommesse", gruppo("fa-link", t.get("titoloGruppoCommesse")));
	add(t, gInterventi, "menuInterventi", gruppo("fa-link", t.get("titoloGruppoInterventi")));
	add(t, gMisure, "menuMisure", gruppo("fa-link", t.get("titoloGruppoMisure")));
	add(t, gCertificati, "menuCertificati", gruppo("fa-link", t.get("titoloGruppoCertificati")));
	add(t, gStrumenti, "menuStrumenti", gruppo("fa-link", t.get("titoloGruppoStrumenti")));
	add(t, gCampioni, "menuCampioni", gruppo("fa-link", t.get("titoloGruppoCampioni")));
	add(t, gRilievi, "menuRilievi", gruppo("fa-link", t.get("titoloGruppoRilievi")));
	add(t, gRisorse, "menuRisorse", gruppo("fa-link", t.get("titoloGruppoRisorse")));
	add(t, gMagazzino, "menuMagazzino", gruppo("fa-link", t.get("titoloGruppoMagazzino")));
	add(t, gVer, "menuVerificazione", gruppo("fa-link", t.get("titoloGruppoVerificazione")));
	add(t, gFormazione, "menuFormazione", gruppo("fa-link", t.get("titoloGruppoFormazione")));
	add(t, gDocumentale, "menuDocumentale", gruppo("fa-link", t.get("titoloGruppoDocumentale")));
	add(t, gDpi, "menuDpi", gruppo("fa-link", t.get("titoloGruppoDpi")));
	add(t, gControlli, "menuControlli", gruppo("fa-link", t.get("titoloGruppoControlli")));
	add(t, gDevice, "menuDevice", gruppo("fa-link", t.get("titoloGruppoDevice")));
	add(t, gScadIT, "menuScadenzarioIt", gruppo("fa-link", t.get("titoloGruppoScadenzarioIt")));
	add(t, gParcoAuto, "menuParcoAuto", gruppo("fa-link", t.get("titoloGruppoParcoAuto")));
	add(t, gAmEng, "menuAmEngineering", gruppo("fa-link", t.get("titoloGruppoAmEngineering")));
	add(t, gAmEng, "menuAmScadenzario", gruppo("fa-link", t.get("titoloGruppoAmScadenzario")));
	add(t, gConfig, "menuConfigurazioni", gruppo("fa-group", t.get("titoloGruppoConfigurazioni")));
	add(t, gUtility, "menuUtility", gruppo("fa-link", t.get("titoloGruppoUtility")));

	// ---------- BLOCCHI COMPLETI (header + gruppo + voci) ----------
	addBlocco(t, gruppi, gCommesse, "Commesse",
		t.get("tabGestioneCommessa"),
		t.get("tabSchedeConsegna"),
		t.get("tabStatoConsegna"));
	addBlocco(t, gruppi, gInterventi, "Interventi",
		t.get("tabListaInterventi"),
		t.get("tabAssegnazioneAttivita"),
		t.get("tabControlloAttivita"),
		t.get("tabInterventiOperatore"),
		t.get("tabAssegnazioneAttivitaAdmin"),
		t.get("tabControlloAttivitaAdmin"),
		t.get("tabListaSessioni"));
	addBlocco(t, gruppi, gMisure, "Misure",
		t.get("tabListaMisure"),
		t.get("tabGestioneClienti"),
		t.get("tabModificheAdmin"));
	addBlocco(t, gruppi, gCertificati, "Certificati",
		t.get("tabListaCertificati"));
	addBlocco(t, gruppi, gStrumenti, "Strumenti",
		t.get("tabGestioneStrumenti"),
		t.get("tabScadenziarioStrumenti"),
		t.get("tabRicercaDateStrumenti"));
	addBlocco(t, gruppi, gCampioni, "Campioni",
		t.get("tabCampioniPersonali"),
		t.get("tabCampioniPrenotabili"),
		t.get("tabScadenziarioCampioni"),
		t.get("tabScadenziarioLat"),
		t.get("tabLibrerieElettrici"),
		t.get("tabGestionePrenotazioni"));
	addBlocco(t, gruppi, gRilievi, "Rilievi",
		t.get("tabRilieviListaInterventi"),
		t.get("tabGestioneRilievi"));
	addBlocco(t, gruppi, gRisorse, "Risorse",
		t.get("tabGestioneRisorse"),
		t.get("tabGestioneRequisiti"),
		t.get("tabPianificazioneRisorse"));
	addBlocco(t, gruppi, gMagazzino, "Magazzino",
		t.get("tabStatoMagazzino"),
		t.get("tabStatoItemMagazzino"),
		t.get("tabStatoDdt"),
		t.get("tabPressoFornitore"),
		t.get("tabAttivitaInCorso"));
	addBlocco(t, gruppi, gVer, "Verificazione",
		t.get("tabVerComunicazioneEsito"),
		t.get("tabVerGestioneCommesse"),
		t.get("tabVerGestioneStrumenti"),
		t.get("tabVerListaCertificati"),
		t.get("tabVerListaComunicazioni"),
		t.get("tabVerListaInterventi"),
		t.get("tabVerListaMisure"),
		t.get("tabVerScadenzarioStrumenti"),
		t.get("tabVerListaCampioni"),
		t.get("tabVerScadenzarioCampioni"),
		t.get("tabVerAccertamentoConformita"),
		t.get("tabVerDocumentazioneTecnica"),
		t.get("tabVerGestioneOfferte"));
	addBlocco(t, gruppi, gFormazione, "Formazione",
		t.get("tabFormDocenti"),
		t.get("tabFormReferenti"),
		t.get("tabFormPartecipanti"),
		t.get("tabFormCategorieCorsi"),
		t.get("tabFormCorsi"),
		t.get("tabFormScadenzario"),
		t.get("tabFormQuestionari"),
		t.get("tabFormConsuntivoQuestionari"),
		t.get("tabFormPianificazione"),
		t.get("tabFormListaPianificazioni"),
		t.get("tabFormConfEmail"));
	addBlocco(t, gruppi, gDocumentale, "Documentale",
		t.get("tabDocCommittenti"),
		t.get("tabDocFornitori"),
		t.get("tabDocReferenti"),
		t.get("tabDocDipendenti"),
		t.get("tabDocDocumenti"),
		t.get("tabDocTipiDocumento"),
		t.get("tabDocScadenzario"));
	addBlocco(t, gruppi, gDpi, "Dpi",
		t.get("tabDpiElenco"),
		t.get("tabDpiSchedeConsegna"),
		t.get("tabDpiScadenzario"),
		t.get("tabDpiManuali"));
	addBlocco(t, gruppi, gControlli, "Controlli",
		t.get("tabCoAttrezzature"),
		t.get("tabCoControlli"));
	addBlocco(t, gruppi, gDevice, "Device",
		t.get("tabDeviceTipi"),
		t.get("tabDeviceLista"),
		t.get("tabDeviceContratti"),
		t.get("tabDeviceSoftware"),
		t.get("tabDeviceProcedure"),
		t.get("tabDeviceLta"),
		t.get("tabDeviceRicercaSoftware"));
	addBlocco(t, gruppi, gScadIT, "ScadenzarioIt",
		t.get("tabScadenzarioIt"));
	addBlocco(t, gruppi, gParcoAuto, "ParcoAuto",
		t.get("tabPaGestioneAuto"),
		t.get("tabPaGestionePrenotazioni"),
		t.get("tabPaConfermaPrenotazioni"),
		t.get("tabPaRichiestePrenotazioni"),
		t.get("tabPaListaSegnalazioni"));
	addBlocco(t, gruppi, gAmEng, "AmEngineering",
		t.get("tabAmListaInterventi"),
		t.get("tabAmListaAttrezzature"),
		t.get("tabAmListaCampioni"),
		t.get("tabAmListaProve"),
		t.get("tabAmListaImmagini"));
	addBlocco(t, gruppi, gAmEng, "AmScadenzario",
		t.get("tabAmScadenzarioAttivita"),
		t.get("tabAmListaAttivita"));
	addBlocco(t, gruppi, gConfig, "Configurazioni",
		t.get("tabConfUtenti"),
		t.get("tabConfCompany"),
		t.get("tabConfRuoli"),
		t.get("tabConfPermessi"),
		t.get("tabConfAssociazioni"),
		t.get("tabConfTrend"),
		t.get("tabConfBacheca"),
		t.get("tabConfTabelle"),
		t.get("tabConfTipoStrumento"),
		t.get("tabConfVersioniLogs"));
	addBlocco(t, gruppi, gUtility, "Utility",
		t.get("tabUtDasmTar"),
		t.get("tabUtDasmTarLat"),
		t.get("tabUtDasmTarSe"),
		t.get("tabUtDasmTarVer"),
		t.get("tabUtPrintLabel"),
		t.get("tabUtLibrerie"),
		t.get("tabUtConvertitore"),
		t.get("tabUtFirmaDocumento"));

	// ---------- BLOCCHI PER LA DASHBOARD (blocco -> gruppi -> voci) ----------
	// Un header (es. METROLOGIA) vale per tutti i gruppi che seguono, fino al prossimo header diverso.
	// Header uguali consecutivi (es. METROLOGIA su Commesse e Interventi per un PV) vengono uniti.
	List<Map<String, Object>> blocchiDash = new ArrayList<Map<String, Object>>();
	List<Map<String, Object>> gruppiCorrenti = null;
	String ultimoHeader = "";
	for (Map<String, Object> g : gruppi) {
		String tb = (String) g.get("titoloBlocco");
		boolean haHeader = tb != null && !tb.isEmpty();
		if (gruppiCorrenti == null || (haHeader && !tb.equals(ultimoHeader))) {
			Map<String, Object> b = new LinkedHashMap<String, Object>();
			// gli header fatti solo di trattini (separatori) non si mostrano
			b.put("titolo", haHeader ? tb.replace("-", "").trim() : "");
			gruppiCorrenti = new ArrayList<Map<String, Object>>();
			b.put("gruppi", gruppiCorrenti);
			blocchiDash.add(b);
			if (haHeader) {
				ultimoHeader = tb;
			}
		}
		gruppiCorrenti.add(g);
	}

	// ---------- ESPORTO TUTTO IN REQUEST (visibile alle pagine dopo <t:main-sidebar />) ----------
	for (Map.Entry<String, String> e : t.entrySet()) {
		request.setAttribute(e.getKey(), e.getValue());
		//System.out.println("key: " + e.getKey() + "   value: " + e.getValue());
	}
	request.setAttribute("sidebarMap", t);
	request.setAttribute("sidebarGruppi", gruppi);
	request.setAttribute("sidebarBlocchi", blocchiDash);
%>


 <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header">Menu</li>
        ${blocchiCommesse}
        ${blocchiInterventi}
        ${blocchiMisure}
        ${blocchiCertificati}
        ${blocchiStrumenti}
        ${blocchiCampioni}
        ${blocchiRilievi}
        ${blocchiRisorse}
        ${blocchiMagazzino}
        ${blocchiVerificazione}
        ${blocchiFormazione}
        ${blocchiDocumentale}
        ${blocchiDpi}
        ${blocchiControlli}
        ${blocchiDevice}
        ${blocchiScadenzarioIt}
        ${blocchiParcoAuto}
        ${blocchiAmEngineering}
        ${blocchiAmScadenzario}
        ${blocchiConfigurazioni}
        ${blocchiUtility}
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>
