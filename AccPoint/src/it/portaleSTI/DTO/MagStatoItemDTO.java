package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagStatoItemDTO implements Serializable{

	private int id;
	private String descrizione;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public MagStatoItemDTO(int id, String descrizione) {
		
		this.id=id;
		this.descrizione=descrizione;

	}
	public MagStatoItemDTO() {
		super();
	}
	
	
}
