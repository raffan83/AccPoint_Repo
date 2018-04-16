package it.portaleSTI.DTO;

import java.sql.Timestamp;

public class BachecaDTO {
	
	private int id;
	private CompanyDTO company;
	private UtenteDTO utente;
	private String destinatario;
	private Timestamp data;
	private String titolo;
	private String testo;
	private int letto;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDestinatario() {
		return destinatario;
	}
	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}
	public Timestamp getData() {
		return data;
	}
	public void setData(Timestamp data) {
		this.data = data;
	}
	public String getTitolo() {
		return titolo;
	}
	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}
	public CompanyDTO getCompany() {
		return company;
	}
	public void setCompany(CompanyDTO company) {
		this.company = company;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public String getTesto() {
		return testo;
	}
	public void setTesto(String testo) {
		this.testo = testo;
	}
	public int getLetto() {
		return letto;
	}
	public void setLetto(int letto) {
		this.letto = letto;
	}

}
