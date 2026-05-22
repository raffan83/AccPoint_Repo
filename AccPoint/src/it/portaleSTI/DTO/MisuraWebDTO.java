package it.portaleSTI.DTO;

import java.util.Date;

public class MisuraWebDTO {

	
	private Integer id=0;
	private Date data_misura;
	private String denominazione_str;
	private String matricola;
	private String codice_interno;
	private String costruttore;
	private String id_certificato;
	private String nome_certificato;
	private String nome_file;
	
	public MisuraWebDTO() {
		// TODO Auto-generated constructor stub
	}

	

	public MisuraWebDTO(Integer id, Date data_misura, String denominazione_str, String matricola, String codice_interno,
			String costruttore, String id_certificato) {
		super();
		this.id = id;
		this.data_misura = data_misura;
		this.denominazione_str = denominazione_str;
		this.matricola = matricola;
		this.codice_interno = codice_interno;
		this.costruttore = costruttore;
		this.id_certificato = id_certificato;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Date getData_misura() {
		return data_misura;
	}


	public void setData_misura(Date data_misura) {
		this.data_misura = data_misura;
	}


	public String getDenominazione_str() {
		return denominazione_str;
	}


	public void setDenominazione_str(String denominazione_str) {
		this.denominazione_str = denominazione_str;
	}


	public String getMatricola() {
		return matricola;
	}


	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}


	public String getCodice_interno() {
		return codice_interno;
	}


	public void setCodice_interno(String codice_interno) {
		this.codice_interno = codice_interno;
	}


	public String getCostruttore() {
		return costruttore;
	}


	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}


	public String getId_certificato() {
		return id_certificato;
	}


	public void setId_certificato(String id_certificato) {
		this.id_certificato = id_certificato;
	}
	
	public String getNome_certificato() {
		return nome_certificato;
	}



	public void setNome_certificato(String nome_certificato) {
		this.nome_certificato = nome_certificato;
	}


	public String toString() {
	    return "MisuraDTO [id=" + id 
	            + ", data_misura=" + data_misura 
	            + ", denominazione_str=" + denominazione_str 
	            + ", matricola=" + matricola 
	            + ", codice_interno=" + codice_interno 
	            + ", costruttore=" + costruttore 
	            + ", id_certificato=" + id_certificato 
	            + "]";
	}



	public String getNome_file() {
		return nome_file;
	}



	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}



	
	
	
	
}
