package it.portaleSTI.DTO;

import java.io.Serializable;
import java.math.BigDecimal;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;


public class MisuraDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private InterventoDTO intervento;
	
	private InterventoDatiDTO interventoDati;
 
	private Date dataMisura;

	private StatoRicezioneStrumentoDTO statoRicezione;
	
	private StrumentoDTO strumento;

	
	private UtenteDTO user;

	private BigDecimal temperatura=BigDecimal.ZERO;

	private BigDecimal umidita=BigDecimal.ZERO;
	
	private int tipoFirma;
	
	private String obsoleto="";
	
	private String nCertificato="";
	
	private String file_allegato = "";
	
	private String note_allegato = "";
	
	//private char lat;
	private String lat;
	
	private LatMisuraDTO misuraLAT;
	
	private Set<PuntoMisuraDTO> listaPunti = new HashSet<PuntoMisuraDTO>(0);

	private String file_xls_ext="";
	
	private String note_obsolescenza = "";
	
    public String getObsoleto() {
		return obsoleto;
	}

	public void setObsoleto(String obsoleto) {
		this.obsoleto = obsoleto;
	}

	public int getTipoFirma() {
		return tipoFirma;
	}

	public void setTipoFirma(int tipoFirma) {
		this.tipoFirma = tipoFirma;
	}

	public MisuraDTO() {
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataMisura() {
		return dataMisura;
	}

	public void setDataMisura(Date dataMisura) {
		this.dataMisura = dataMisura;
	}

	public StatoRicezioneStrumentoDTO getStatoRicezione() {
		return statoRicezione;
	}

	public void setStatoRicezione(StatoRicezioneStrumentoDTO statoRicezione) {
		this.statoRicezione = statoRicezione;
	}

	public StrumentoDTO getStrumento() {
		return strumento;
	}

	public void setStrumento(StrumentoDTO strumento) {
		this.strumento = strumento;
	}

	public UtenteDTO getUser() {
		return user;
	}

	public void setUser(UtenteDTO user) {
		this.user = user;
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

	public InterventoDTO getIntervento() {
		return intervento;
	}

	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}

	public InterventoDatiDTO getInterventoDati() {
		return interventoDati;
	}

	public Set<PuntoMisuraDTO> getListaPunti() {
		return listaPunti;
	}

	public void setListaPunti(Set<PuntoMisuraDTO> listaPunti) {
		this.listaPunti = listaPunti;
	}

	public void setInterventoDati(InterventoDatiDTO interventoDati) {
		this.interventoDati = interventoDati;
	}

	public String getnCertificato() {
		return nCertificato;
	}

	public void setnCertificato(String nCertificato) {
		this.nCertificato = nCertificato;
	}

	public String getFile_allegato() {
		return file_allegato;
	}

	public void setFile_allegato(String file_allegato) {
		this.file_allegato = file_allegato;
	}

	public String getNote_allegato() {
		return note_allegato;
	}

	public void setNote_allegato(String note_allegato) {
		this.note_allegato = note_allegato;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public LatMisuraDTO getMisuraLAT() {
		return misuraLAT;
	}

	public void setMisuraLAT(LatMisuraDTO misuraLAT) {
		this.misuraLAT = misuraLAT;
	}

	public String getFile_xls_ext() {
		return file_xls_ext;
	}

	public void setFile_xls_ext(String file_xls_ext) {
		this.file_xls_ext = file_xls_ext;
	}
	
	public String getNote_obsolescenza() {
		return note_obsolescenza;
	}

	public void setNote_obsolescenza(String note_obsolescenza) {
		this.note_obsolescenza = note_obsolescenza;
	}

}