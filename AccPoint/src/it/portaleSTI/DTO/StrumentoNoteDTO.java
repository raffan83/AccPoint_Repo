package it.portaleSTI.DTO;

import java.sql.Date;

public class StrumentoNoteDTO {

	private int id;
	private int id_strumento;
	private UtenteDTO user;
	private String descrizione;
	private Date data;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_strumento() {
		return id_strumento;
	}
	public void setId_strumento(int id_strumento) {
		this.id_strumento = id_strumento;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	
	
}
