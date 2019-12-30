package it.portaleSTI.DTO;

public class ForCorsoAllegatiDTO {
	
	private int id;
	private ForCorsoDTO corso;
	private String nome_allegato;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ForCorsoDTO getCorso() {
		return corso;
	}
	public void setCorso(ForCorsoDTO corso) {
		this.corso = corso;
	}
	public String getNome_allegato() {
		return nome_allegato;
	}
	public void setNome_allegato(String nome_allegato) {
		this.nome_allegato = nome_allegato;
	}
	
	

}
