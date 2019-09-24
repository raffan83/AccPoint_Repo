package it.portaleSTI.DTO;

public class VerCodiceDocumentoDTO {

	int id;
	UtenteDTO user;
	String codice_famiglia;
	
	int count;
	public VerCodiceDocumentoDTO() {
		super();
	}
	public VerCodiceDocumentoDTO(UtenteDTO user, String codice_famiglia, int count) {
		
		this.user = user;
		this.codice_famiglia = codice_famiglia;
		this.count = count;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getCodice_famiglia() {
		return codice_famiglia;
	}
	public void setCodice_famiglia(String codice_famiglia) {
		this.codice_famiglia = codice_famiglia;
	}
	
}
