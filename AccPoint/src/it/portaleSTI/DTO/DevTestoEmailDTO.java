package it.portaleSTI.DTO;

public class DevTestoEmailDTO {
	private int id;
	private String descrizione;
	private String sollecito;
	private String referenti;
	
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
	public String getReferenti() {
		return referenti;
	}
	public void setReferenti(String referenti) {
		this.referenti = referenti;
	}
	public String getSollecito() {
		return sollecito;
	}
	public void setSollecito(String sollecito) {
		this.sollecito = sollecito;
	}

}
