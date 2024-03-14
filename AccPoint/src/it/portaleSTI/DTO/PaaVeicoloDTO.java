package it.portaleSTI.DTO;

import java.util.Date;

public class PaaVeicoloDTO {

	private int id;
	private String targa;
	private String modello;
	private DocumCommittenteDTO company;
	private String carta_circolazione;
	private int km_percorsi;
	private String portata_max_veicolo;
	private String immagine_veicolo;
	private String note;
	private UtenteDTO user_update;
	private Date data_update;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTarga() {
		return targa;
	}
	public void setTarga(String targa) {
		this.targa = targa;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public DocumCommittenteDTO getCompany() {
		return company;
	}
	public void setCompany(DocumCommittenteDTO company) {
		this.company = company;
	}
	public String getCarta_circolazione() {
		return carta_circolazione;
	}
	public void setCarta_circolazione(String carta_circolazione) {
		this.carta_circolazione = carta_circolazione;
	}
	public int getKm_percorsi() {
		return km_percorsi;
	}
	public void setKm_percorsi(int km_percorsi) {
		this.km_percorsi = km_percorsi;
	}
	public String getPortata_max_veicolo() {
		return portata_max_veicolo;
	}
	public void setPortata_max_veicolo(String portata_max_veicolo) {
		this.portata_max_veicolo = portata_max_veicolo;
	}
	public String getImmagine_veicolo() {
		return immagine_veicolo;
	}
	public void setImmagine_veicolo(String immagine_veicolo) {
		this.immagine_veicolo = immagine_veicolo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public UtenteDTO getUser_update() {
		return user_update;
	}
	public void setUser_update(UtenteDTO user_update) {
		this.user_update = user_update;
	}
	public Date getData_update() {
		return data_update;
	}
	public void setData_update(Date data_update) {
		this.data_update = data_update;
	}
	
	
	
}
