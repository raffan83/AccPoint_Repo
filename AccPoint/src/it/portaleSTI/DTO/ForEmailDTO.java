package it.portaleSTI.DTO;

import java.sql.Timestamp;

public class ForEmailDTO {
	
	private int id;
	private UtenteDTO utente;
	private Timestamp data;
	private ForCorsoDTO corso;
	private String destinatario;
	private int attestato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public Timestamp getData() {
		return data;
	}
	public void setData(Timestamp data) {
		this.data = data;
	}
	public ForCorsoDTO getCorso() {
		return corso;
	}
	public void setCorso(ForCorsoDTO corso) {
		this.corso = corso;
	}
	public String getDestinatario() {
		return destinatario;
	}
	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}
	public int getAttestato() {
		return attestato;
	}
	public void setAttestato(int attestato) {
		this.attestato = attestato;
	}
	
	

}
