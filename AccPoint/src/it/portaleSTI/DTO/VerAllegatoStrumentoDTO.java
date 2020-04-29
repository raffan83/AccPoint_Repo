package it.portaleSTI.DTO;

public class VerAllegatoStrumentoDTO {
	
	private int id;
	private VerStrumentoDTO strumento;
	private String nome_file;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public VerStrumentoDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(VerStrumentoDTO strumento) {
		this.strumento = strumento;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}

	
}
