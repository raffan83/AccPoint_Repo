package it.portaleSTI.DTO;

import java.io.Serializable;

public class CategoriaDocumentoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7787212966327289544L;
	
	private int id;
	private String nomeCategoria;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNomeCategoria() {
		return nomeCategoria;
	}
	public void setNomeCategoria(String nomeCategoria) {
		this.nomeCategoria = nomeCategoria;
	}
	
	

}
