package it.portaleSTI.DTO;

import java.util.Date;

public class GPDTO {
	
	private int id;
	private String nome;
	private String cognome;
	private Date dataNascita;
	private String esito;
	private Date dataVerifica;
	
	
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
	public Date getDataNascita() {
		return dataNascita;
	}
	public void setDataNascita(Date dataNascita) {
		this.dataNascita = dataNascita;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public Date getDataVerifica() {
		return dataVerifica;
	}
	public void setDataVerifica(Date dataVerifica) {
		this.dataVerifica = dataVerifica;
	}
	

}
