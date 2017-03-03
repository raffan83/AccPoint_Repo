package it.portaleSTI.DTO;

import java.sql.Date;

public class PrenotazioneDTO {
	private int id;
	private int id_campione;
	private int id_companyRichiedente;
	private int id_userRichiedente;
	private Date dataRichiesta;
	private Date dataApprovazione;
	private int stato;
	private Date prenotatoDal;
	private Date prenotatoAl;
	private String note;
	private String nomeCampione;
	private String matricolaCampione;
	private int id_company;
	private int id_company_utilizzatrice;
	
	private String nomeCompanyProprietario;
	private String nomeCompanyRichiedente;
	private String nomeUtenteRichiesta;
	
	public PrenotazioneDTO() {
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getId_campione() {
		return id_campione;
	}


	public void setId_campione(int id_campione) {
		this.id_campione = id_campione;
	}


	public int getId_companyRichiedente() {
		return id_companyRichiedente;
	}


	public void setId_companyRichiedente(int id_companyRichiedente) {
		this.id_companyRichiedente = id_companyRichiedente;
	}


	public int getId_userRichiedente() {
		return id_userRichiedente;
	}


	public void setId_userRichiedente(int id_userRichiedente) {
		this.id_userRichiedente = id_userRichiedente;
	}


	public Date getDataRichiesta() {
		return dataRichiesta;
	}


	public void setDataRichiesta(Date dataRichiesta) {
		this.dataRichiesta = dataRichiesta;
	}


	public Date getDataApprovazione() {
		return dataApprovazione;
	}


	public void setDataApprovazione(Date dataApprovazione) {
		this.dataApprovazione = dataApprovazione;
	}


	public int getStato() {
		return stato;
	}


	public void setStato(int stato) {
		this.stato = stato;
	}


	public Date getPrenotatoDal() {
		return prenotatoDal;
	}


	public void setPrenotatoDal(Date prenotatoDal) {
		this.prenotatoDal = prenotatoDal;
	}


	public Date getPrenotatoAl() {
		return prenotatoAl;
	}


	public void setPrenotatoAl(Date prenotatoAl) {
		this.prenotatoAl = prenotatoAl;
	}


	public String getNote() {
		return note;
	}


	public void setNote(String note) {
		this.note = note;
	}


	public String getNomeCampione() {
		return nomeCampione;
	}


	public void setNomeCampione(String nomeCampione) {
		this.nomeCampione = nomeCampione;
	}


	public String getMatricolaCampione() {
		return matricolaCampione;
	}


	public void setMatricolaCampione(String matricolaCampione) {
		this.matricolaCampione = matricolaCampione;
	}


	public int getId_company() {
		return id_company;
	}


	public void setId_company(int id_company) {
		this.id_company = id_company;
	}


	public int getId_company_utilizzatrice() {
		return id_company_utilizzatrice;
	}


	public void setId_company_utilizzatrice(int id_company_utilizzatrice) {
		this.id_company_utilizzatrice = id_company_utilizzatrice;
	}


	public String getNomeCompanyProprietario() {
		return nomeCompanyProprietario;
	}


	public void setNomeCompanyProprietario(String nomeCompanyProprietario) {
		this.nomeCompanyProprietario = nomeCompanyProprietario;
	}


	public String getNomeCompanyRichiedente() {
		return nomeCompanyRichiedente;
	}


	public void setNomeCompanyRichiedente(String nomeCompanyRichiedente) {
		this.nomeCompanyRichiedente = nomeCompanyRichiedente;
	}


	public String getNomeUtenteRichiesta() {
		return nomeUtenteRichiesta;
	}


	public void setNomeUtenteRichiesta(String nomeUtenteRichiesta) {
		this.nomeUtenteRichiesta = nomeUtenteRichiesta;
	}

	
}
