package it.portaleSTI.DTO;

import java.util.Date;

public class AMRapportoDTO {

	private int id;
	private AMProvaDTO prova;
	private StatoCertificatoDTO stato;
	private String nomeFile;
	private Date data;
	private UtenteDTO utente;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public AMProvaDTO getProva() {
		return prova;
	}
	public void setProva(AMProvaDTO prova) {
		this.prova = prova;
	}
	public StatoCertificatoDTO getStato() {
		return stato;
	}
	public void setStato(StatoCertificatoDTO stato) {
		this.stato = stato;
	}
	public String getNomeFile() {
		return nomeFile;
	}
	public void setNomeFile(String nomeFile) {
		this.nomeFile = nomeFile;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	
	
}
