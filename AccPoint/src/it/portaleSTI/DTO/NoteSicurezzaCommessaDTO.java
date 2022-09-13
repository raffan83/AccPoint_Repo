package it.portaleSTI.DTO;

import java.util.Date;

public class NoteSicurezzaCommessaDTO {
	private int id;
	private String commessa;
	private String nota;
	private Date data_modifica;
	private UtenteDTO utente_modifica;
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public String getNota() {
		return nota;
	}
	public void setNota(String nota) {
		this.nota = nota;
	}
	public Date getData_modifica() {
		return data_modifica;
	}
	public void setData_modifica(Date data_modifica) {
		this.data_modifica = data_modifica;
	}
	public UtenteDTO getUtente_modifica() {
		return utente_modifica;
	}
	public void setUtente_modifica(UtenteDTO utente_modifica) {
		this.utente_modifica = utente_modifica;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	

}
