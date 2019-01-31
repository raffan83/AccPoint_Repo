package it.portaleSTI.DTO;

import java.util.Date;

public class SchedaConsegnaRilieviDTO {
	
	private int id;
	private int id_cliente;
	private int id_sede;
	private String nome_cliente;
	private String nome_sede;
	private String mese;
	private int anno;
	private Date data_creazione;
	private String file;
	private String commessa;
	private int stato;
	
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
	public String getMese() {
		return mese;
	}
	public void setMese(String mese) {
		this.mese = mese;
	}
	public int getAnno() {
		return anno;
	}
	public void setAnno(int anno) {
		this.anno = anno;
	}
	public Date getData_creazione() {
		return data_creazione;
	}
	public void setData_creazione(Date data_creazione) {
		this.data_creazione = data_creazione;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}

}
