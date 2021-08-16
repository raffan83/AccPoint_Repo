package it.portaleSTI.DTO;

import java.util.Date;


public class VerDocumentoDTO {
	
	private int id;

	
	private String costruttore;
	private String modello;
	private VerTipoDocumentoDTO tipo_documento;
	private Date data_caricamento;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCostruttore() {
		return costruttore;
	}
	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public VerTipoDocumentoDTO getTipo_documento() {
		return tipo_documento;
	}
	public void setTipo_documento(VerTipoDocumentoDTO tipo_documento) {
		this.tipo_documento = tipo_documento;
	}
	public Date getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(Date data_caricamento) {
		this.data_caricamento = data_caricamento;
	}
	
	
}
