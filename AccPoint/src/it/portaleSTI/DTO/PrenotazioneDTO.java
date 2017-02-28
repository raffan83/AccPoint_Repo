package it.portaleSTI.DTO;

import java.sql.Date;

public class PrenotazioneDTO {
	private int id;
	private int id_campione;
	private int id_company;
	private int id_user;
	private int stato;
	private Date prenotatoDal;
	private Date prenotatoAl;
	private String note;
	
	
	public PrenotazioneDTO() {
	}


	public int getId() {
		return id;
	}


	public void setId_prenotazione(int id_) {
		this.id = id_;
	}


	public int getId_campione() {
		return id_campione;
	}


	public void setId_campione(int id_campione) {
		this.id_campione = id_campione;
	}


	public int getId_company() {
		return id_company;
	}


	public void setId_company(int id_company) {
		this.id_company = id_company;
	}


	public int getId_user() {
		return id_user;
	}


	public void setId_user(int id_user) {
		this.id_user = id_user;
	}


	public int getStato() {
		return stato;
	}


	public void setStato(int stato) {
		this.stato = stato;
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
