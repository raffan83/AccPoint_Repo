package it.portaleSTI.DTO;

public class TipoDpiDTO {
	
	private int id;
	private String descrizione;
	private int collettivo;
	
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
	
	public TipoDpiDTO() {
		super();
	}
	
	public TipoDpiDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
	}
	public int getCollettivo() {
		return collettivo;
	}
	public void setCollettivo(int collettivo) {
		this.collettivo = collettivo;
	}

}
