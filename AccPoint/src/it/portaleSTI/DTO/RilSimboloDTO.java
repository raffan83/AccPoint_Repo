package it.portaleSTI.DTO;

public class RilSimboloDTO {
	
	private int id;
	private String descrizione;
	
	public RilSimboloDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
	}
	
	public RilSimboloDTO() {
		super();
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
