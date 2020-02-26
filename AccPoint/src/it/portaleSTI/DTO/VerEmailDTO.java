package it.portaleSTI.DTO;

import java.sql.Timestamp;
import java.util.Date;

public class VerEmailDTO {

	private int id;
	private VerCertificatoDTO certificato;
	private Timestamp data_invio;
	private UtenteDTO utente;
	private String destinatario;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public VerCertificatoDTO getCertificato() {
		return certificato;
	}
	public void setCertificato(VerCertificatoDTO certificato) {
		this.certificato = certificato;
	}
	public Date getData_invio() {
		return data_invio;
	}
	public void setData_invio(Timestamp data_invio) {
		this.data_invio = data_invio;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public String getDestinatario() {
		return destinatario;
	}
	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}
	
	
}
