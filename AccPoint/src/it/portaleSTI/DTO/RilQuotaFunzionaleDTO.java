package it.portaleSTI.DTO;

public class RilQuotaFunzionaleDTO {

	private int id;
	private String descrizione;
	
	public RilQuotaFunzionaleDTO(int id, String descrizione) {
		this.id = id;;
		this.descrizione = descrizione;
	}
	
	public RilQuotaFunzionaleDTO() {
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
