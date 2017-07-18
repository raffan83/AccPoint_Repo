package it.portaleSTI.DTO;

import java.util.Date;

public class PrenotazioniDotazioneDTO {
	
	private int id;
	private DotazioneDTO dotazione;
	private UtenteDTO userRichiedente;
	private Date dataRichiesta;
	private Date prenotatoDal;
	private Date prenotatoAl;
	private String note;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public DotazioneDTO getDotazione() {
		return dotazione;
	}
	public void setDotazione(DotazioneDTO dotazione) {
		this.dotazione = dotazione;
	}
	public UtenteDTO getUserRichiedente() {
		return userRichiedente;
	}
	public void setUserRichiedente(UtenteDTO userRichiedente) {
		this.userRichiedente = userRichiedente;
	}
	public Date getDataRichiesta() {
		return dataRichiesta;
	}
	public void setDataRichiesta(Date dataRichiesta) {
		this.dataRichiesta = dataRichiesta;
	}
	public Date getPrenotatoDal() {
		return prenotatoDal;
	}
	public void setPrenotatoDal(Date prenotatoDal) {
		this.prenotatoDal = prenotatoDal;
	}
	public Date getPrenotatoAl() {
		return prenotatoAl;
	}
	public void setPrenotatoAl(Date prenotatoAl) {
		this.prenotatoAl = prenotatoAl;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}

 	
	
}
