package it.portaleSTI.DTO;

public class TipoAttivitaManutenzioneDTO {

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
	public TipoAttivitaManutenzioneDTO(int tipo){
		this.id=tipo;
		
	}
	public TipoAttivitaManutenzioneDTO() {
		super();
	}
}
