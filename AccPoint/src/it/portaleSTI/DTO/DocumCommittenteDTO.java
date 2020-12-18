package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class DocumCommittenteDTO {
	
	private int id;
	private int id_cliente;
	private int id_sede;
	private String nome_cliente;
	private String indirizzo_cliente;
	private String nominativo_referente;
	private String email;
	
	private Set<DocumFornitoreDTO> listaFornitori = new HashSet<DocumFornitoreDTO>(0);
	
	public DocumCommittenteDTO() {
		super();
	}
	
	public DocumCommittenteDTO(int id) {
		this.id = id;
	}
	
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
	public String getIndirizzo_cliente() {
		return indirizzo_cliente;
	}
	public void setIndirizzo_cliente(String indirizzo_cliente) {
		this.indirizzo_cliente = indirizzo_cliente;
	}
	public String getNominativo_referente() {
		return nominativo_referente;
	}
	public void setNominativo_referente(String nominativo_referente) {
		this.nominativo_referente = nominativo_referente;
	}

	public Set<DocumFornitoreDTO> getListaFornitori() {
		return listaFornitori;
	}

	public void setListaFornitori(Set<DocumFornitoreDTO> listaFornitori) {
		this.listaFornitori = listaFornitori;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	

}
