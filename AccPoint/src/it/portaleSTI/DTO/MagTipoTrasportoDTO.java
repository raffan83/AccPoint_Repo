package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagTipoTrasportoDTO implements Serializable{
	
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
	
	public MagTipoTrasportoDTO(int id, String descrizione) {
		this.id= id;
		this.descrizione= descrizione;
	
	}
	
	public MagTipoTrasportoDTO() {
		super();
	}

}
