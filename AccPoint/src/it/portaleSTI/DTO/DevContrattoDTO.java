package it.portaleSTI.DTO;

import java.util.Date;

public class DevContrattoDTO {
	
	private int id;
	private Date data_inizio;
	private Date data_scadenza;
	private String fornitore;
	private String permanente;
	private int disabilitato;
	private int n_licenze;
	private Date data_invio_remind;
	private String email_referenti;
	private String subscription;
	private String descrizione;
	private DocumFornitoreDTO company;
	private String stato;
	private Integer id_contratto_precedente;

	public int getN_licenze() {
		return n_licenze;
	}



	public DocumFornitoreDTO getCompany() {
		return company;
	}



	public void setCompany(DocumFornitoreDTO company) {
		this.company = company;
	}



	public void setN_licenze(int n_licenze) {
		this.n_licenze = n_licenze;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
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



	public String getFornitore() {
		return fornitore;
	}



	public void setFornitore(String fornitore) {
		this.fornitore = fornitore;
	}



	public String getPermanente() {
		return permanente;
	}



	public void setPermanente(String permanente) {
		this.permanente = permanente;
	}



	public int getDisabilitato() {
		return disabilitato;
	}



	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}



	public Date getData_invio_remind() {
		return data_invio_remind;
	}



	public void setData_invio_remind(Date data_invio_remind) {
		this.data_invio_remind = data_invio_remind;
	}



	public String getEmail_referenti() {
		return email_referenti;
	}



	public void setEmail_referenti(String email_referenti) {
		this.email_referenti = email_referenti;
	}



	public String getSubscription() {
		return subscription;
	}



	public void setSubscription(String subscription) {
		this.subscription = subscription;
	}



	public String getDescrizione() {
		return descrizione;
	}



	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}



	public String getStato() {
		return stato;
	}



	public void setStato(String stato) {
		this.stato = stato;
	}



	public Integer getId_contratto_precedente() {
		return id_contratto_precedente;
	}



	public void setId_contratto_precedente(Integer id_contratto_precedente) {
		this.id_contratto_precedente = id_contratto_precedente;
	}



	public DevContrattoDTO() {
		// TODO Auto-generated constructor stub
	}

}
