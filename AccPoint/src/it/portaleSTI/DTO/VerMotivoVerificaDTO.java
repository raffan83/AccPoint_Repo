package it.portaleSTI.DTO;

public class VerMotivoVerificaDTO {
	
	private int id;
	private String descrizione;
	
	public VerMotivoVerificaDTO() {}
	public VerMotivoVerificaDTO(int id, String descrizione) {
		super();
		this.id = id;
		this.descrizione = descrizione;
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
