package it.portaleSTI.DTO;

public class ItTipoRinnovoDTO {
	
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
	
	public ItTipoRinnovoDTO() {
		// TODO Auto-generated constructor stub
	}



	public ItTipoRinnovoDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
		
	}



}
