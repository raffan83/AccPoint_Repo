package it.portaleSTI.DTO;

public class DevStatoValidazioneDTO {
	
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

	
	
	public DevStatoValidazioneDTO() {
		super();
	}
	
	public DevStatoValidazioneDTO(int id, String descrizione) {
		this.id = id;
		this.descrizione = descrizione;
	}
}
