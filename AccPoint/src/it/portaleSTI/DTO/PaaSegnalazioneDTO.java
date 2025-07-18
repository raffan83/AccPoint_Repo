package it.portaleSTI.DTO;

import java.util.Date;

public class PaaSegnalazioneDTO {
	private int id;
	private PaaPrenotazioneDTO prenotazione;
	private PaaTipoSegnalazioneDTO tipo;
	private Date data_segnalazione;
	private String note;
	private int stato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}


	public PaaPrenotazioneDTO getPrenotazione() {
		return prenotazione;
	}
	public void setPrenotazione(PaaPrenotazioneDTO prenotazione) {
		this.prenotazione = prenotazione;
	}
	public PaaTipoSegnalazioneDTO getTipo() {
		return tipo;
	}
	public void setTipo(PaaTipoSegnalazioneDTO tipo) {
		this.tipo = tipo;
	}
	public Date getData_segnalazione() {
		return data_segnalazione;
	}
	public void setData_segnalazione(Date data_segnalazione) {
		this.data_segnalazione = data_segnalazione;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}
	
	
	

}
