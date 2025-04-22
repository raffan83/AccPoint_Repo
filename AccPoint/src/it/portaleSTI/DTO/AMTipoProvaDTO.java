package it.portaleSTI.DTO;

public class AMTipoProvaDTO {

	private int id = 0;
	private String descrizione = "";
	
	public AMTipoProvaDTO(){}
	
	public AMTipoProvaDTO(int id) {
		super();
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
