package it.portaleSTI.DTO;

public class FirmaClienteDTO {
	
	private int id;
	private int id_cliente;
	private int id_sede;
	private String nome_cliente;
	private String nome_sede;
	private String nome_file;
	private String nominativo_firma;
	private int disabilitato; 
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}
	public int getId_sede() {
		return id_sede;
	}
	public void setId_sede(int id_sede) {
		this.id_sede = id_sede;
	}
	public String getNome_cliente() {
		return nome_cliente;
	}
	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}
	public String getNome_sede() {
		return nome_sede;
	}
	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public String getNominativo_firma() {
		return nominativo_firma;
	}
	public void setNominativo_firma(String nominativo_firma) {
		this.nominativo_firma = nominativo_firma;
	}
	
	

}
