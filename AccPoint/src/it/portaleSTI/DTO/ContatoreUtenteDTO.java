package it.portaleSTI.DTO;

import java.io.Serializable;

public class ContatoreUtenteDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5363788628557238664L;
	
	private int id;
	private int id_user;
	private int contatoreSE;
	private String codiceSE;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId_user() {
		return id_user;
	}
	public void setId_user(int id_user) {
		this.id_user = id_user;
	}
	public int getContatoreSE() {
		return contatoreSE;
	}
	public void setContatoreSE(int contatoreSE) {
		this.contatoreSE = contatoreSE;
	}
	public String getCodiceSE() {
		return codiceSE;
	}
	public void setCodiceSE(String codiceSE) {
		this.codiceSE = codiceSE;
	}

	public ContatoreUtenteDTO() {
		super();
	}
	public ContatoreUtenteDTO(int id) {
		this.id = id;
	}
}
