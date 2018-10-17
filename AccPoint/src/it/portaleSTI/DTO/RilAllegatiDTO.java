package it.portaleSTI.DTO;

public class RilAllegatiDTO {
	
	private int id;
	private String nome_file;
	private RilMisuraRilievoDTO rilievo;
	
	
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
	public RilMisuraRilievoDTO getRilievo() {
		return rilievo;
	}
	public void setRilievo(RilMisuraRilievoDTO rilievo) {
		this.rilievo = rilievo;
	}

}
