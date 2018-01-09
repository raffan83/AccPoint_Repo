package it.portaleSTI.DTO;

import java.util.Date;

public class DocumentiEsterniStrumentoDTO {
	
	private int id=0;
	private StrumentoDTO strumento;
	private String nomeDocumento;
	private Date dataCaricamento;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public StrumentoDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(StrumentoDTO strumento) {
		this.strumento = strumento;
	}
	public String getNomeDocumento() {
		return nomeDocumento;
	}
	public void setNomeDocumento(String nomeDocumento) {
		this.nomeDocumento = nomeDocumento;
	}
	public Date getDataCaricamento() {
		return dataCaricamento;
	}
	public void setDataCaricamento(Date dataCaricamento) {
		this.dataCaricamento = dataCaricamento;
	}



}
