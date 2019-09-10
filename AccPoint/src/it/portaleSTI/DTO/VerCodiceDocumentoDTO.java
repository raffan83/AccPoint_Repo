package it.portaleSTI.DTO;

public class VerCodiceDocumentoDTO {

	int id;
	UtenteDTO user;
	VerFamigliaStrumentoDTO famiglia;
	int count;
	public VerCodiceDocumentoDTO() {
		super();
	}
	public VerCodiceDocumentoDTO(UtenteDTO user, VerFamigliaStrumentoDTO famiglia, int count) {
		
		this.user = user;
		this.famiglia = famiglia;
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
	public VerFamigliaStrumentoDTO getFamiglia() {
		return famiglia;
	}
	public void setFamiglia(VerFamigliaStrumentoDTO famiglia) {
		this.famiglia = famiglia;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
