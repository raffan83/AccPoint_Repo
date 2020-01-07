package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class ForCorsoDTO {

	private int id;
	private ForCorsoCatDTO corso_cat;
	private ForDocenteDTO docente;
	private Date data_inizio;
	private Date data_scadenza;
	private String documento_test;
	
	private Set<UtenteDTO> listaUtenti = new HashSet<UtenteDTO>();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public ForCorsoCatDTO getCorso_cat() {
		return corso_cat;
	}
	public void setCorso_cat(ForCorsoCatDTO corso_cat) {
		this.corso_cat = corso_cat;
	}
	public ForDocenteDTO getDocente() {
		return docente;
	}
	public void setDocente(ForDocenteDTO docente) {
		this.docente = docente;
	}
	public Date getData_inizio() {
		return data_inizio;
	}
	public void setData_inizio(Date data_inizio) {
		this.data_inizio = data_inizio;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public String getDocumento_test() {
		return documento_test;
	}
	public void setDocumento_test(String documento_test) {
		this.documento_test = documento_test;
	}
	public Set<UtenteDTO> getListaUtenti() {
		return listaUtenti;
	}
	public void setListaUtenti(Set<UtenteDTO> listaUtenti) {
		this.listaUtenti = listaUtenti;
	}
	
	
}
