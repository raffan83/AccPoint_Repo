package it.portaleSTI.DTO;

public class AMOperatoreDTO {

	private int id;
	private String nomeOperatore;
	private String pathPatentino;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNomeOperatore() {
		return nomeOperatore;
	}
	public void setNomeOperatore(String nomeOperatore) {
		this.nomeOperatore = nomeOperatore;
	}
	public String getPathPatentino() {
		return pathPatentino;
	}
	public void setPathPatentino(String pathPatentino) {
		this.pathPatentino = pathPatentino;
	}
	
	
	public AMOperatoreDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public AMOperatoreDTO(int id, String nome, String path) {
		this.id = id;
		this.nomeOperatore = nome;
		this.pathPatentino = path;
	}

	
}
