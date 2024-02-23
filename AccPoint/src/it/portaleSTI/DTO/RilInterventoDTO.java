package it.portaleSTI.DTO;

import java.util.Date;

public class RilInterventoDTO {
	private int id; 
	private int id_cliente;
	private String nome_cliente;
	private int id_sede;
	private String nome_sede;
	private int stato_intervento;
	private Date data_apertura;
	private Date data_chiusura;
	private String commessa;	
	private int id_pacco;
	
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
	public String getNome_cliente() {
		return nome_cliente;
	}
	public void setNome_cliente(String nome_cliente) {
		this.nome_cliente = nome_cliente;
	}
	public int getId_sede() {
		return id_sede;
	}
	public void setId_sede(int id_sede) {
		this.id_sede = id_sede;
	}
	public String getNome_sede() {
		return nome_sede;
	}
	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}
	public int getStato_intervento() {
		return stato_intervento;
	}
	public void setStato_intervento(int stato_intervento) {
		this.stato_intervento = stato_intervento;
	}
	public Date getData_apertura() {
		return data_apertura;
	}
	public void setData_apertura(Date data_apertura) {
		this.data_apertura = data_apertura;
	}
	public Date getData_chiusura() {
		return data_chiusura;
	}
	public void setData_chiusura(Date data_chiusura) {
		this.data_chiusura = data_chiusura;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public int getId_pacco() {
		return id_pacco;
	}
	public void setId_pacco(int id_pacco) {
		this.id_pacco = id_pacco;
	}
	
	

}
