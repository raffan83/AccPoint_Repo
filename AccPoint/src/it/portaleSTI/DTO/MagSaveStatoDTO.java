package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagSaveStatoDTO implements Serializable{
	
	private int id_cliente;
	private int id_sede;	
	private int tipo_porto;
	private int aspetto;
	private String spedizioniere;
	private String ca;
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
	public int getTipo_porto() {
		return tipo_porto;
	}
	public void setTipo_porto(int tipo_porto) {
		this.tipo_porto = tipo_porto;
	}
	public int getAspetto() {
		return aspetto;
	}
	public void setAspetto(int aspetto) {
		this.aspetto = aspetto;
	}
	public String getSpedizioniere() {
		return spedizioniere;
	}
	public void setSpedizioniere(String spedizioniere) {
		this.spedizioniere = spedizioniere;
	}
	public String getCa() {
		return ca;
	}
	public void setCa(String ca) {
		this.ca = ca;
	}

	
	
}
