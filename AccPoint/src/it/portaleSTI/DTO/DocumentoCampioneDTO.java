package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class DocumentoCampioneDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9209334288012566940L;

	private int id;
	private CampioneDTO campione;
	private CategoriaDocumentoDTO categoria;
	private Date data_caricamento;
	private String pathFolder;
	private String filename;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public CategoriaDocumentoDTO getCategoria() {
		return categoria;
	}
	public void setCategoria(CategoriaDocumentoDTO categoria) {
		this.categoria = categoria;
	}
	public Date getData_caricamento() {
		return data_caricamento;
	}
	public void setData_caricamento(Date data_caricamento) {
		this.data_caricamento = data_caricamento;
	}
	public String getPathFolder() {
		return pathFolder;
	}
	public void setPathFolder(String pathFolder) {
		this.pathFolder = pathFolder;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
}
