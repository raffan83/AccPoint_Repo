package it.portaleSTI.DTO;

public class SegreteriaDTO {
	
	private int id;
	private String azienda;
	private String localita;
	private String telefono;
	private String referente;
	private String mail;
	private String offerta;
	private String note;
	private UtenteDTO utente;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAzienda() {
		return azienda;
	}
	public void setAzienda(String azienda) {
		this.azienda = azienda;
	}
	public String getLocalita() {
		return localita;
	}
	public void setLocalita(String localita) {
		this.localita = localita;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getReferente() {
		return referente;
	}
	public void setReferente(String referente) {
		this.referente = referente;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getOfferta() {
		return offerta;
	}
	public void setOfferta(String offerta) {
		this.offerta = offerta;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	

	
}
