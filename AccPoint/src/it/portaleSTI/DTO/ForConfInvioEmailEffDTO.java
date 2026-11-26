package it.portaleSTI.DTO;

import java.util.Date;

public class ForConfInvioEmailEffDTO {
	
	private int id;
	private int id_corso;
	private int id_gruppo;
	private Date data_inizio_invio;
	private Date data_scadenza;
	private String descrizione_corso;
	private String descrizione_gruppo;
	private int disabilitato;
	private String oggetto_email;
	private String testo_email;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId_corso() {
		return id_corso;
	}
	public void setId_corso(int id_corso) {
		this.id_corso = id_corso;
	}
	public int getId_gruppo() {
		return id_gruppo;
	}
	public void setId_gruppo(int id_gruppo) {
		this.id_gruppo = id_gruppo;
	}
	public Date getData_inizio_invio() {
		return data_inizio_invio;
	}
	public void setData_inizio_invio(Date data_inizio_invio) {
		this.data_inizio_invio = data_inizio_invio;
	}
	

	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}

	public String getDescrizione_corso() {
		return descrizione_corso;
	}
	public void setDescrizione_corso(String descrizione_corso) {
		this.descrizione_corso = descrizione_corso;
	}
	public String getDescrizione_gruppo() {
		return descrizione_gruppo;
	}
	public void setDescrizione_gruppo(String descrizione_gruppo) {
		this.descrizione_gruppo = descrizione_gruppo;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public String getOggetto_email() {
		return oggetto_email;
	}
	public void setOggetto_email(String oggetto_email) {
		this.oggetto_email = oggetto_email;
	}
	public String getTesto_email() {
		return testo_email;
	}
	public void setTesto_email(String testo_email) {
		this.testo_email = testo_email;
	}
	
	
	
	

}
