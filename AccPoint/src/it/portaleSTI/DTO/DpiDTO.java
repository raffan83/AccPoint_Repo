package it.portaleSTI.DTO;

import java.util.Date;

public class DpiDTO {
	
	private int id;
	private TipoDpiDTO tipo;
	private DocumFornitoreDTO company;
	private String descrizione;
	private String modello;
	private String conformita;
	private Date data_scadenza;
	private int collettivo;
	private int assegnato;
	private String nome_lavoratore;
	private int disabilitato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoDpiDTO getTipo() {
		return tipo;
	}
	public void setTipo(TipoDpiDTO tipo) {
		this.tipo = tipo;
	}
	public DocumFornitoreDTO getCompany() {
		return company;
	}
	public void setCompany(DocumFornitoreDTO company) {
		this.company = company;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public String getConformita() {
		return conformita;
	}
	public void setConformita(String conformita) {
		this.conformita = conformita;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public int getCollettivo() {
		return collettivo;
	}
	public void setCollettivo(int collettivo) {
		this.collettivo = collettivo;
	}
	public int getAssegnato() {
		return assegnato;
	}
	public void setAssegnato(int assegnato) {
		this.assegnato = assegnato;
	}


	public String getNome_lavoratore() {
		return nome_lavoratore;
	}
	public void setNome_lavoratore(String nome_lavoratore) {
		this.nome_lavoratore = nome_lavoratore;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	
	

}
