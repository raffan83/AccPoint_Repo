package it.portaleSTI.DTO;

public class TipoTrendDTO {
	int id;
	String descrizione;
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
