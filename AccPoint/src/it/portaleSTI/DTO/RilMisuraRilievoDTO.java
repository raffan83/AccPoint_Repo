package it.portaleSTI.DTO;

import java.text.SimpleDateFormat;
import java.util.Date;

public class RilMisuraRilievoDTO {
	
	private int id;
	private String disegno;
	private String variante;
	private String fornitore;
	private String apparecchio;
	private Date data_inizio_rilievo;
	private Date data_consegna;
	private RilStatoRilievoDTO stato_rilievo;
	private String note;
	private int id_cliente_util;
	private int id_sede_util;
	private String nome_cliente_util;
	private String nome_sede_util;
	private String commessa;
	private UtenteDTO utente;
	private RilTipoRilievoDTO tipo_rilievo;
	private String mese_riferimento;
	private String allegato;
	private String immagine_frontespizio;
	private int cifre_decimali;
	private String classe_tolleranza;
	private String denominazione;
	private String materiale;
	private int n_pezzi_tot;
	private int n_quote;
	private int disabilitato;
	private int scheda_consegna;
	private String numero_scheda;
	private int pezzi_ingresso;
	private Double tempo_scansione;
	private int firmato;
	private int controfirmato;
	private RilInterventoDTO intervento;
	private int non_lavorato;
	private int smaltimento;
	
	public int getN_pezzi_tot() {
		return n_pezzi_tot;
	}
	public void setN_pezzi_tot(int n_pezzi_tot) {
		this.n_pezzi_tot = n_pezzi_tot;
	}
	public int getN_quote() {
		return n_quote;
	}
	public void setN_quote(int n_quote) {
		this.n_quote = n_quote;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_cliente_util() {
		return id_cliente_util;
	}
	public void setId_cliente_util(int id_cliente_util) {
		this.id_cliente_util = id_cliente_util;
	}
	public int getId_sede_util() {
		return id_sede_util;
	}
	public void setId_sede_util(int id_sede_util) {
		this.id_sede_util = id_sede_util;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public RilTipoRilievoDTO getTipo_rilievo() {
		return tipo_rilievo;
	}
	public void setTipo_rilievo(RilTipoRilievoDTO tipo_rilievo) {
		this.tipo_rilievo = tipo_rilievo;
	}
	public String getNome_cliente_util() {
		return nome_cliente_util;
	}
	public void setNome_cliente_util(String nome_cliente_util) {
		this.nome_cliente_util = nome_cliente_util;
	}
	public String getDisegno() {
		return disegno;
	}
	public void setDisegno(String disegno) {
		this.disegno = disegno;
	}
	public String getVariante() {
		return variante;
	}
	public void setVariante(String variante) {
		this.variante = variante;
	}
	public String getFornitore() {
		return fornitore;
	}
	public void setFornitore(String fornitore) {
		this.fornitore = fornitore;
	}
	public String getApparecchio() {
		return apparecchio;
	}
	public void setApparecchio(String apparecchio) {
		this.apparecchio = apparecchio;
	}
	public Date getData_inizio_rilievo() {
		return data_inizio_rilievo;
	}
	public void setData_inizio_rilievo(Date data_inizio_rilievo) {
		this.data_inizio_rilievo = data_inizio_rilievo;
	}
	public Date getData_consegna() {
		return data_consegna;
	}
	public void setData_consegna(Date data_consegna) {
		this.data_consegna = data_consegna;
	}

	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getNome_sede_util() {
		return nome_sede_util;
	}
	public void setNome_sede_util(String nome_sede_util) {
		this.nome_sede_util = nome_sede_util;
	}
	public RilStatoRilievoDTO getStato_rilievo() {
		return stato_rilievo;
	}
	public void setStato_rilievo(RilStatoRilievoDTO stato_rilievo) {
		this.stato_rilievo = stato_rilievo;
	}
	public String getMese_riferimento() {
		return mese_riferimento;
	}
	public void setMese_riferimento(String mese_riferimento) {
		this.mese_riferimento = mese_riferimento;
	}
	public String getAllegato() {
		return allegato;
	}
	public void setAllegato(String allegato) {
		this.allegato = allegato;
	}
	public int getCifre_decimali() {
		return cifre_decimali;
	}
	public void setCifre_decimali(int cifre_decimali) {
		this.cifre_decimali = cifre_decimali;
	}
	public String getImmagine_frontespizio() {
		return immagine_frontespizio;
	}
	public void setImmagine_frontespizio(String immagine_frontespizio) {
		this.immagine_frontespizio = immagine_frontespizio;
	}
	public String getClasse_tolleranza() {
		return classe_tolleranza;
	}
	public void setClasse_tolleranza(String classe_tolleranza) {
		this.classe_tolleranza = classe_tolleranza;
	}
	public String getDenominazione() {
		return denominazione;
	}
	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}
	public String getMateriale() {
		return materiale;
	}
	public void setMateriale(String materiale) {
		this.materiale = materiale;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public int getScheda_consegna() {
		return scheda_consegna;
	}
	public void setScheda_consegna(int scheda_consegna) {
		this.scheda_consegna = scheda_consegna;
	}
	public String getNumero_scheda() {
		return numero_scheda;
	}
	public void setNumero_scheda(String numero_scheda) {
		this.numero_scheda = numero_scheda;
	}
	public int getPezzi_ingresso() {
		return pezzi_ingresso;
	}
	public void setPezzi_ingresso(int pezzi_ingresso) {
		this.pezzi_ingresso = pezzi_ingresso;
	}
	public Double getTempo_scansione() {
		return tempo_scansione;
	}
	public void setTempo_scansione(Double tempo_scansione) {
		this.tempo_scansione = tempo_scansione;
	}
	public int getFirmato() {
		return firmato;
	}
	public void setFirmato(int firmato) {
		this.firmato = firmato;
	}
	public int getControfirmato() {
		return controfirmato;
	}
	public void setControfirmato(int controfirmato) {
		this.controfirmato = controfirmato;
	}
//	public int getId_intervento() {
//		return id_intervento;
//	}
//	public void setId_intervento(int id_intervento) {
//		this.id_intervento = id_intervento;
//	}
	public RilInterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(RilInterventoDTO intervento) {
		this.intervento = intervento;
	}
	public int getNon_lavorato() {
		return non_lavorato;
	}
	public void setNon_lavorato(int non_lavorato) {
		this.non_lavorato = non_lavorato;
	}
	public int getSmaltimento() {
		return smaltimento;
	}
	public void setSmaltimento(int smaltimento) {
		this.smaltimento = smaltimento;
	}
	@Override
	public String toString() {

	    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

	    return "\nRilMisuraRilievoDTO (ril_misura_rilievo) {" +
	            "\n  id=" + id +
	            "\n  disegno='" + disegno + '\'' +
	            "\n  variante='" + variante + '\'' +
	            "\n  fornitore='" + fornitore + '\'' +
	            "\n  apparecchio='" + apparecchio + '\'' +
	            "\n  data_inizio_rilievo=" + (data_inizio_rilievo != null ? sdf.format(data_inizio_rilievo) : null) +
	            "\n  data_consegna=" + (data_consegna != null ? sdf.format(data_consegna) : null) +
	            "\n  stato_rilievo=" + stato_rilievo.getDescrizione() +
	            "\n  note='" + note + '\'' +
	            "\n  id_cliente_util=" + id_cliente_util +
	            "\n  id_sede_util=" + id_sede_util +
	            "\n  nome_cliente_util='" + nome_cliente_util + '\'' +
	            "\n  nome_sede_util='" + nome_sede_util + '\'' +
	            "\n  commessa='" + commessa + '\'' +
	            "\n  utente=" + utente.getNominativo() +
	            "\n  tipo_rilievo=" + tipo_rilievo.getDescrizione() +
	            "\n  mese_riferimento='" + mese_riferimento + '\'' +
	            "\n  allegato='" + allegato + '\'' +
	            "\n  immagine_frontespizio='" + immagine_frontespizio + '\'' +
	            "\n  cifre_decimali=" + cifre_decimali +
	            "\n  classe_tolleranza='" + classe_tolleranza + '\'' +
	            "\n  denominazione='" + denominazione + '\'' +
	            "\n  materiale='" + materiale + '\'' +
	            "\n  n_pezzi_tot=" + n_pezzi_tot +
	            "\n  n_quote=" + n_quote +
	            "\n  disabilitato=" + disabilitato +
	            "\n  scheda_consegna=" + scheda_consegna +
	            "\n  numero_scheda='" + numero_scheda + '\'' +
	            "\n  pezzi_ingresso=" + pezzi_ingresso +
	            "\n  tempo_scansione=" + tempo_scansione +
	            "\n  firmato=" + firmato +
	            "\n  controfirmato=" + controfirmato +
	            "\n  intervento=" + intervento.getId() +
	            "\n  non_lavorato=" + non_lavorato +
	            "\n  smaltimento=" + smaltimento +
	            "\n}";
	}
}
