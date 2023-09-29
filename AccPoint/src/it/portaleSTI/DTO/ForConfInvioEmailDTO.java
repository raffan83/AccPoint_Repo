package it.portaleSTI.DTO;

import java.util.Date;

public class ForConfInvioEmailDTO {
	
	private int id;
	private int stato_invio;
	private int id_corso;
	private int id_gruppo;
	private Date data_inizio_invio;
	private Date data_prossimo_invio;
	private Date data_scadenza;
	private int frequenza_invio;
	private String descrizione_corso;
	private String descrizione_gruppo;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStato_invio() {
		return stato_invio;
	}
	public void setStato_invio(int stato_invio) {
		this.stato_invio = stato_invio;
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
	
	public Date getData_prossimo_invio() {
		return data_prossimo_invio;
	}
	public void setData_prossimo_invio(Date data_prossimo_invio) {
		this.data_prossimo_invio = data_prossimo_invio;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public int getFrequenza_invio() {
		return frequenza_invio;
	}
	public void setFrequenza_invio(int frequenza) {
		this.frequenza_invio = frequenza;
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
	
	
	
	

}
