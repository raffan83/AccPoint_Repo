package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class OffOffertaDTO {
	
	
	private int id;
	private Date data_offerta;
	private int id_cliente;
	private int id_sede;
	private String nome_cliente;
	private String nome_sede;
	private Double importo;
	private String utente;
	private String n_offerta;
	private int stato;
	
	
	

	public int getId() {
		return id;
	}




	public void setId(int id) {
		this.id = id;
	}




	public Date getData_offerta() {
		return data_offerta;
	}




	public void setData_offerta(Date data_offerta) {
		this.data_offerta = data_offerta;
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




	public Double getImporto() {
		return importo;
	}




	public void setImporto(Double importo) {
		this.importo = importo;
	}




	public String getUtente() {
		return utente;
	}




	public void setUtente(String utente) {
		this.utente = utente;
	}





	public String getN_offerta() {
		return n_offerta;
	}




	public void setN_offerta(String n_offerta) {
		this.n_offerta = n_offerta;
	}




	public OffOffertaDTO() {
		// TODO Auto-generated constructor stub
	}




	public int getStato() {
		return stato;
	}




	public void setStato(int stato) {
		this.stato = stato;
	}

}
