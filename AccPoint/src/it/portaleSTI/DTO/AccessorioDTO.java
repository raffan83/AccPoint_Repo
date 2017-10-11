package it.portaleSTI.DTO;

import java.util.List;

public class AccessorioDTO {
	private int id;
	private CompanyDTO company;
	private String nome;
	private String descrizione;
	private int quantitaFisica;
	private int quantitaPrenotata;
	private int quantitaNecessaria;
    private TipologiaAccessoriDTO tipologia;
	private String componibile;
	private String id_componibili;
	private int capacita;
	private String um;
    private UtenteDTO user;
	
	
	

	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
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

	public TipologiaAccessoriDTO getTipologia() {
		return tipologia;
	}
	public void setTipologia(TipologiaAccessoriDTO tipologia) {
		this.tipologia = tipologia;
	}
	public int getQuantitaFisica() {
		return quantitaFisica;
	}
	public void setQuantitaFisica(int quantitaFisica) {
		this.quantitaFisica = quantitaFisica;
	}
	public int getQuantitaPrenotata() {
		return quantitaPrenotata;
	}
	public void setQuantitaPrenotata(int quantitaPrenotata) {
		this.quantitaPrenotata = quantitaPrenotata;
	}
	public int getQuantitaNecessaria() {
		return quantitaNecessaria;
	}
	public void setQuantitaNecessaria(int quantitaNecessaria) {
		this.quantitaNecessaria = quantitaNecessaria;
	}
	public String getComponibile() {
		return componibile;
	}
	public void setComponibile(String componibile) {
		this.componibile = componibile;
	}
	public String getId_componibili() {
		return id_componibili;
	}
	public void setId_componibili(String id_componibili) {
		this.id_componibili = id_componibili;
	}
	public int getCapacita() {
		return capacita;
	}
	public void setCapacita(int capacita) {
		this.capacita = capacita;
	}
	public String getUm() {
		return um;
	}
	public void setUm(String um) {
		this.um = um;
	}
	
}
