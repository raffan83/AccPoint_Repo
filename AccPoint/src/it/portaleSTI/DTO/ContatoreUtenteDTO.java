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

}