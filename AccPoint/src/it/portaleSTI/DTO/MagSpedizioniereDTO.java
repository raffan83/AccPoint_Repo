package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagSpedizioniereDTO implements Serializable{

	private int id;
	private String denominazione;
	private String telefono;
	private String email;
	private String fax;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDenominazione() {
		return denominazione;
	}
	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	
	
	public MagSpedizioniereDTO(int id, String denominazione, String telefono, String email, String fax) {
		
		this.id=id;
		this.denominazione=denominazione;
		this.telefono=telefono;
		this.email=email;
		this.fax=fax;
	}
	public MagSpedizioniereDTO() {
		super();
	}
	
}
