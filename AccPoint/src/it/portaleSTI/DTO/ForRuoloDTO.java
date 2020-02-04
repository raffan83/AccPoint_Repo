package it.portaleSTI.DTO;

public class ForRuoloDTO {
	
	private int id;
	private String descrizione;
	
	public ForRuoloDTO() {
		super();
	}
	public ForRuoloDTO(int id) {
		this.id = id;
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
