package it.portaleSTI.DTO;

public class MagAttivitaPaccoDTO {
	
	private int id;
	private String descrizione;
	
	public MagAttivitaPaccoDTO(int id, String descrizione) {
		
		this.id=id;
		this.descrizione=descrizione;

	}
	public MagAttivitaPaccoDTO() {
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
