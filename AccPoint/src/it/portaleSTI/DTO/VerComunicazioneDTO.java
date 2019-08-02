package it.portaleSTI.DTO;

import java.util.Date;

public class VerComunicazioneDTO {
	
	int id;
	private String tipoComunicazione;
	private Date dataComunicazione;
	private UtenteDTO utente;
	private String filename;
	private String idsStrumenti;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTipoComunicazione() {
		return tipoComunicazione;
	}
	public void setTipoComunicazione(String tipoComunicazione) {
		this.tipoComunicazione = tipoComunicazione;
	}
	public Date getDataComunicazione() {
		return dataComunicazione;
	}
	public void setDataComunicazione(Date dataComunicazione) {
		this.dataComunicazione = dataComunicazione;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getIdsStrumenti() {
		return idsStrumenti;
	}
	public void setIdsStrumenti(String idsStrumenti) {
		this.idsStrumenti = idsStrumenti;
	}
	
	
	

}
