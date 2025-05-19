package it.portaleSTI.DTO;

public class AMOperatoreDTO {

	private int id;
	private String nomeOperatore;
	private String pathPatentino;
	private String dicituraPatentino;
	private String firma;
	private int responsabile;
	
	public String getFirma() {
		return firma;
	}
	public void setFirma(String firma) {
		this.firma = firma;
	}
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
	
	
	public String getDicituraPatentino() {
		return dicituraPatentino;
	}
	public void setDicituraPatentino(String dicituraPatentino) {
		this.dicituraPatentino = dicituraPatentino;
	}
	public AMOperatoreDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public int getResponsabile() {
		return responsabile;
	}
	public void setResponsabile(int responsabile) {
		this.responsabile = responsabile;
	}
	public AMOperatoreDTO(int id, String nome, String path) {
		this.id = id;
		this.nomeOperatore = nome;
		this.pathPatentino = path;
	}

	
	
}
