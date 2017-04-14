package it.portaleSTI.DTO;

public class StatoPackDTO {

	private int id;
	private String descrizione;
	
	public StatoPackDTO(int i) {
		id=i;
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
