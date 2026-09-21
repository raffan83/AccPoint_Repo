package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class InterventoAttivitaOpDTO {

	private int id;
	private int id_intervento;
	private UtenteDTO user;
	private Date date;
	private String descrizione;
	
	
	
	
	public InterventoAttivitaOpDTO() {
		
	}


	public InterventoAttivitaOpDTO(int id, UtenteDTO user, Date date, String descrizione) {
		super();
		this.id = id;
		this.user = user;
		this.date = date;
		this.descrizione = descrizione;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}

	

	public int getId_intervento() {
		return id_intervento;
	}


	public void setId_intervento(int id_intervento) {
		this.id_intervento = id_intervento;
	}


	public UtenteDTO getUser() {
		return user;
	}


	public void setUser(UtenteDTO user) {
		this.user = user;
	}


	public Date getDate() {
		return date;
	}


	public void setDate(Date date) {
		this.date = date;
	}


	public String getDescrizione() {
		return descrizione;
	}


	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	
	
	
	
}
