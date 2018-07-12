package it.portaleSTI.DTO;

public class MagAttivitaItemDTO {
	
	private int id;
	private String descrizione;
	
	public MagAttivitaItemDTO(int id, String descrizione) {
		
		this.id=id;
		this.descrizione=descrizione;

	}
	public MagAttivitaItemDTO() {
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
