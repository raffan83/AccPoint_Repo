package it.portaleSTI.DTO;

public class StatoCertificatoDTO {

	private int id;
	private String descrizione;
	
	public StatoCertificatoDTO(){}
	
	public StatoCertificatoDTO(int id) {
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
