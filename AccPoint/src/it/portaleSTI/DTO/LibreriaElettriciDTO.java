package it.portaleSTI.DTO;

public class LibreriaElettriciDTO {
	
	private int id;
	private String marca_strumento;
	private String modello_strumento;
	private String campione_riferimento;
	private String note;
	private int disabilitato;
	private String filename_config;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMarca_strumento() {
		return marca_strumento;
	}
	public void setMarca_strumento(String marca_strumento) {
		this.marca_strumento = marca_strumento;
	}
	public String getModello_strumento() {
		return modello_strumento;
	}
	public void setModello_strumento(String modello_strumento) {
		this.modello_strumento = modello_strumento;
	}
	public String getCampione_riferimento() {
		return campione_riferimento;
	}
	public void setCampione_riferimento(String campione_riferimento) {
		this.campione_riferimento = campione_riferimento;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public String getFilename_config() {
		return filename_config;
	}
	public void setFilename_config(String filename_config) {
		this.filename_config = filename_config;
	}
	
	
	
}
