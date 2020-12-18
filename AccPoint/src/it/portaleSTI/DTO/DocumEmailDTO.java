package it.portaleSTI.DTO;

import java.sql.Timestamp;

public class DocumEmailDTO {
	
	private int id;
	private UtenteDTO utente;
	private Timestamp data;
	private DocumTLDocumentoDTO documento;
	private String destinatario;
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
	public DocumTLDocumentoDTO getDocumento() {
		return documento;
	}
	public void setDocumento(DocumTLDocumentoDTO documento) {
		this.documento = documento;
	}
	public String getDestinatario() {
		return destinatario;
	}
	public void setDestinatario(String destinatario) {
		this.destinatario = destinatario;
	}
	
	

}
