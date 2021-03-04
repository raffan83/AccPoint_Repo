package it.portaleSTI.DTO;

public class VerAllegatoLegalizzazioneBilanceDTO {
	
	private int id;
	private String nome_file;
	private VerLegalizzazioneBilanceDTO provvedimento;
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
	public VerLegalizzazioneBilanceDTO getProvvedimento() {
		return provvedimento;
	}
	public void setProvvedimento(VerLegalizzazioneBilanceDTO provvedimento) {
		this.provvedimento = provvedimento;
	}
	

}
