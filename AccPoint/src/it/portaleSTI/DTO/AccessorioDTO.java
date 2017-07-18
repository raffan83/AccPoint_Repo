package it.portaleSTI.DTO;

import java.util.List;

public class AccessorioDTO {
	private int id;
	private CompanyDTO company;
	private String nome;
	private String descrizione;
	private int quantita;

	private TipologiaAccessoriDTO tipologia;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CompanyDTO getCompany() {
		return company;
	}
	public void setCompany(CompanyDTO company) {
		this.company = company;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public int getQuantita() {
		return quantita;
	}
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	public TipologiaAccessoriDTO getTipologia() {
		return tipologia;
	}
	public void setTipologia(TipologiaAccessoriDTO tipologia) {
		this.tipologia = tipologia;
	}
}
