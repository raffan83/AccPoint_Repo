package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class LatMisuraDTO {
	
	private int id;
	private InterventoDTO intervento;
	private InterventoDatiDTO intervento_dati;
	private int idMisura;
	private StrumentoDTO strumento;
	private Date data_misura;
	private UtenteDTO user;
	private LatMasterDTO misura_lat;
	private BigDecimal incertezza_rif;
	private BigDecimal incertezza_rif_sec;
	private BigDecimal incertezza_estesa;
	private BigDecimal incertezza_estesa_sec;
	private BigDecimal incertezza_media;
	private BigDecimal campo_misura;
	private BigDecimal campo_misura_sec;
	private BigDecimal sensibilita;
	private String stato;
	private String ammaccature;
	private String bolla_trasversale;
	private String regolazione;
	private String centraggio;
	private String nCertificato;
	
	public int getIdMisura() {
		return idMisura;
	}
	public void setIdMisura(int idMisura) {
		this.idMisura = idMisura;
	}
	private BigDecimal temperatura;
	private BigDecimal umidita;
	private String note;
	private CampioneDTO rif_campione;
	private CampioneDTO rif_campione_lavoro;

	private Set<LatPuntoLivellaDTO> listaPunti = new HashSet<LatPuntoLivellaDTO>(0);
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}
	public InterventoDatiDTO getIntervento_dati() {
		return intervento_dati;
	}
	public void setIntervento_dati(InterventoDatiDTO intervento_dati) {
		this.intervento_dati = intervento_dati;
	}
	public StrumentoDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(StrumentoDTO strumento) {
		this.strumento = strumento;
	}
	public Date getData_misura() {
		return data_misura;
	}
	public void setData_misura(Date data_misura) {
		this.data_misura = data_misura;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
	public LatMasterDTO getMisura_lat() {
		return misura_lat;
	}
	public void setMisura_lat(LatMasterDTO misura_lat) {
		this.misura_lat = misura_lat;
	}
	public BigDecimal getIncertezza_rif() {
		return incertezza_rif;
	}
	public void setIncertezza_rif(BigDecimal incertezza_rif) {
		this.incertezza_rif = incertezza_rif;
	}

	public BigDecimal getIncertezza_rif_sec() {
		return incertezza_rif_sec;
	}
	public void setIncertezza_rif_sec(BigDecimal incertezza_rif_sec) {
		this.incertezza_rif_sec = incertezza_rif_sec;
	}
	public BigDecimal getIncertezza_estesa() {
		return incertezza_estesa;
	}
	public void setIncertezza_estesa(BigDecimal incertezza_estesa) {
		this.incertezza_estesa = incertezza_estesa;
	}
	public BigDecimal getIncertezza_estesa_sec() {
		return incertezza_estesa_sec;
	}
	public void setIncertezza_estesa_sec(BigDecimal incertezza_estesa_sec) {
		this.incertezza_estesa_sec = incertezza_estesa_sec;
	}
	public BigDecimal getIncertezza_media() {
		return incertezza_media;
	}
	public void setIncertezza_media(BigDecimal incertezza_media) {
		this.incertezza_media = incertezza_media;
	}
	public BigDecimal getCampo_misura() {
		return campo_misura;
	}
	public void setCampo_misura(BigDecimal campo_misura) {
		this.campo_misura = campo_misura;
	}
	public BigDecimal getCampo_misura_sec() {
		return campo_misura_sec;
	}
	public void setCampo_misura_sec(BigDecimal campo_misura_sec) {
		this.campo_misura_sec = campo_misura_sec;
	}
	public BigDecimal getSensibilita() {
		return sensibilita;
	}
	public void setSensibilita(BigDecimal sensibilita) {
		this.sensibilita = sensibilita;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
	public String getAmmaccature() {
		return ammaccature;
	}
	public void setAmmaccature(String ammaccature) {
		this.ammaccature = ammaccature;
	}
	public String getBolla_trasversale() {
		return bolla_trasversale;
	}
	public void setBolla_trasversale(String bolla_trasversale) {
		this.bolla_trasversale = bolla_trasversale;
	}
	public String getRegolazione() {
		return regolazione;
	}
	public void setRegolazione(String regolazione) {
		this.regolazione = regolazione;
	}
	public String getCentraggio() {
		return centraggio;
	}
	public void setCentraggio(String centraggio) {
		this.centraggio = centraggio;
	}
	public String getnCertificato() {
		return nCertificato;
	}
	public void setnCertificato(String nCertificato) {
		this.nCertificato = nCertificato;
	}
	public BigDecimal getTemperatura() {
		return temperatura;
	}
	public void setTemperatura(BigDecimal temperatura) {
		this.temperatura = temperatura;
	}
	public BigDecimal getUmidita() {
		return umidita;
	}
	public void setUmidita(BigDecimal umidita) {
		this.umidita = umidita;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public CampioneDTO getRif_campione() {
		return rif_campione;
	}
	public void setRif_campione(CampioneDTO rif_campione) {
		this.rif_campione = rif_campione;
	}
	public CampioneDTO getRif_campione_lavoro() {
		return rif_campione_lavoro;
	}
	public void setRif_campione_lavoro(CampioneDTO rif_campione_lavoro) {
		this.rif_campione_lavoro = rif_campione_lavoro;
	}
	public Set<LatPuntoLivellaDTO> getListaPunti() {
		return listaPunti;
	}
	public void setListaPunti(Set<LatPuntoLivellaDTO> listaPunti) {
		this.listaPunti = listaPunti;
	}
		
	

}
