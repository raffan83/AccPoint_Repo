package it.portaleSTI.DTO;

public class ForDocenteDTO {
	
	private int id;
	private String nome;
	private String cognome;
	private String titolo;
	private String cv;
	
	
	public ForDocenteDTO(int id) {
		this.id = id;
	}
	
	public ForDocenteDTO() {
		super();
	}
	
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
	public String getCognome() {
		return cognome;
	}
	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
	public String getTitolo() {
		return titolo;
	}
	public void setTitolo(String titolo) {
		this.titolo = titolo;
	}
	public String getCv() {
		return cv;
	}
	public void setCv(String cv) {
		this.cv = cv;
	}
	
	

}
