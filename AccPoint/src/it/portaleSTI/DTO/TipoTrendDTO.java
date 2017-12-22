package it.portaleSTI.DTO;

import java.io.Serializable;

public class TipoTrendDTO  implements Serializable {
	private static final long serialVersionUID = 1L;
	int id = 0;
	String descrizione = "";
	public TipoTrendDTO() {
		
	}
	public TipoTrendDTO(int id, String descrizione) {
		super();
		this.id = id;
		this.descrizione = descrizione;
	}
	
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
}
