package it.portaleSTI.DTO;

import java.util.Date;

public class ForMembriGruppoDTO {
	
	int id;
	String nome;
	String cognome;
	String email;
	String username;
	String descrizioneErrore;
	String cf;
	Long dataEsecuzione;
	Long dataCreazioneUtente;
	Date dataCompletamentoTest;
	Date dataProssimoInvio;
	
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
	public String getEmail() {
		return email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDescrizioneErrore() {
		return descrizioneErrore;
	}
	public void setDescrizioneErrore(String descrizioneErrore) {
		this.descrizioneErrore = descrizioneErrore;
	}
	public String getCf() {
		return cf;
	}
	public long getDataEsecuzione() {
		return dataEsecuzione;
	}
	public void setDataEsecuzione(long dataEsecuzione) {
		this.dataEsecuzione = dataEsecuzione;
	}
	public void setCf(String cf) {
		this.cf = cf;
	}
	public Long getDataCreazioneUtente() {
		return dataCreazioneUtente;
	}
	public void setDataCreazioneUtente(Long dataCreazioneUtente) {
		this.dataCreazioneUtente = dataCreazioneUtente;
	}
	public Date getDataCompletamentoTest() {
		return dataCompletamentoTest;
	}
	public void setDataCompletamentoTest(Date dataCompletamentoTest) {
		this.dataCompletamentoTest = dataCompletamentoTest;
	}
	public Date getDataProssimoInvio() {
		return dataProssimoInvio;
	}
	public void setDataProssimoInvio(Date dataProssimoInvio) {
		this.dataProssimoInvio = dataProssimoInvio;
	}
	
	
	

	
	

}
