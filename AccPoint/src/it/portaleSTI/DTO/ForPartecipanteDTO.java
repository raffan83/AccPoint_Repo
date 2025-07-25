package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class ForPartecipanteDTO {
	
	private int id;
	private String nome;
	private String cognome;
	private Date data_nascita;
	private int id_azienda;
	private String nome_azienda;
	private int id_sede;
	private String nome_sede;
	private String cf;
	private String luogo_nascita;
	private int nominativo_irregolare;
	private int duplicato;
	private String note;
	private String email;
	
	public String getCf() {
		return cf;
	}

	public void setCf(String cf) {
		this.cf = cf;
	}

	public String getLuogo_nascita() {
		return luogo_nascita;
	}

	public void setLuogo_nascita(String luogo_nascita) {
		this.luogo_nascita = luogo_nascita;
	}

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

	public Set<ForRuoloDTO> getListaRuoli() {
		return listaRuoli;
	}

	public void setListaRuoli(Set<ForRuoloDTO> listaRuoli) {
		this.listaRuoli = listaRuoli;
	}

	public int getId_azienda() {
		return id_azienda;
	}

	public void setId_azienda(int id_azienda) {
		this.id_azienda = id_azienda;
	}

	public String getNome_azienda() {
		return nome_azienda;
	}

	public void setNome_azienda(String nome_azienda) {
		this.nome_azienda = nome_azienda;
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

	public int getNominativo_irregolare() {
		return nominativo_irregolare;
	}

	public void setNominativo_irregolare(int nominativo_irregolare) {
		this.nominativo_irregolare = nominativo_irregolare;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public int getDuplicato() {
		return duplicato;
	}

	public void setDuplicato(int duplicato) {
		this.duplicato = duplicato;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	

}
