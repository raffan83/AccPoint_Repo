package it.portaleSTI.DTO;

import java.util.Date;

public class CartaDiControlloDTO {
	
	private int id;
	private CampioneDTO campione;
	private Date data_caricamento;
	private UtenteDTO utente;
	private String filename;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public Date getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(Date data_caricamento) {
		this.data_caricamento = data_caricamento;
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

	
}
