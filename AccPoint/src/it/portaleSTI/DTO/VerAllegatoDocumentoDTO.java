package it.portaleSTI.DTO;

public class VerAllegatoDocumentoDTO {
	
	private int id;
	private String nome_file;
	private VerDocumentoDTO documento;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}
	public VerDocumentoDTO getDocumento() {
		return documento;
	}
	public void setDocumento(VerDocumentoDTO documento) {
		this.documento = documento;
	}


}
