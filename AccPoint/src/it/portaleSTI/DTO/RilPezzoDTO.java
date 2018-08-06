package it.portaleSTI.DTO;

public class RilPezzoDTO {
	
	private int id;
	private String denominazione;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDenominazione() {
		return denominazione;
	}
	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}
	
	public RilPezzoDTO(int id, String denominazione) {
		this.id = id;
		this.denominazione = denominazione;
	}

	public RilPezzoDTO() {
		super();
	}
}
