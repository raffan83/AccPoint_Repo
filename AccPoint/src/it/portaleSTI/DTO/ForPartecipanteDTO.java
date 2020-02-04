package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class ForPartecipanteDTO {
	
	private int id;
	private String nome;
	private String cognome;
	private Date data_nascita;
	private String azienda;
	
	private Set<ForRuoloDTO> listaRuoli = new HashSet<ForRuoloDTO>(0);
	
	public ForPartecipanteDTO() {
		super();
	}
	
	public ForPartecipanteDTO(int id) {
		this.id = id;
	}
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
	public Date getData_nascita() {
		return data_nascita;
	}
	public void setData_nascita(Date data_nascita) {
		this.data_nascita = data_nascita;
	}
	public String getAzienda() {
		return azienda;
	}
	public void setAzienda(String azienda) {
		this.azienda = azienda;
	}

	public Set<ForRuoloDTO> getListaRuoli() {
		return listaRuoli;
	}

	public void setListaRuoli(Set<ForRuoloDTO> listaRuoli) {
		this.listaRuoli = listaRuoli;
	}

	
	

}
