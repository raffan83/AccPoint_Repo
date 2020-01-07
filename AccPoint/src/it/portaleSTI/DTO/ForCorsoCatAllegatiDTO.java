package it.portaleSTI.DTO;

public class ForCorsoCatAllegatiDTO {
	
	private int id;
	private ForCorsoCatDTO corso;
	private String nome_allegato;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ForCorsoCatDTO getCorso() {
		return corso;
	}
	public void setCorso(ForCorsoCatDTO corso) {
		this.corso = corso;
	}
	public String getNome_allegato() {
		return nome_allegato;
	}
	public void setNome_allegato(String nome_allegato) {
		this.nome_allegato = nome_allegato;
	}
	

}
