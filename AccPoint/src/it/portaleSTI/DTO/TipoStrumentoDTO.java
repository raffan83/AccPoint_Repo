package it.portaleSTI.DTO;

public class TipoStrumentoDTO {
	int id = 0;
	String nome = "";
	int id_codice_accredia; 
	
	
	public TipoStrumentoDTO(int id, String nome) {
		super();
		this.id = id;
		this.nome = nome;
	}
	
	public TipoStrumentoDTO(){}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getId_codice_accredia() {
		return id_codice_accredia;
	}
	public void setId_codice_accredia(int id_codice_accredia) {
		this.id_codice_accredia = id_codice_accredia;
	}
}
