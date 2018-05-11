package it.portaleSTI.DTO;



public class CompanyDTO  {

	private Integer id=0;
	private String denominazione="";
	private String pIva="";
	private String indirizzo="";
	private String comune="";
	private String cap="";
	private String mail="";
	private String telefono="";
	private String codAffiliato="";
	private String nomeLogo="";
	private String email_pec="";
	private String pwd_pec="";
	private String host_pec ="";
	private String porta_pec="";
	


	public CompanyDTO(Integer id, String denominazione, String pIva,
			String indirizzo, String comune, String cap, String mail,
			String telefono, String codAffiliato) {
		super();
		this.id = id;
		this.denominazione = denominazione;
		this.pIva = pIva;
		this.indirizzo = indirizzo;
		this.comune = comune;
		this.cap = cap;
		this.mail = mail;
		this.telefono = telefono;
		this.codAffiliato = codAffiliato;
	}



	public String getMail() {
		return mail;
	}



	public void setMail(String mail) {
		this.mail = mail;
	}



	public CompanyDTO() {
	}

	

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDenominazione() {
		return this.denominazione;
	}

	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}

	public String getpIva() {
		return pIva;
	}
	
	public void setpIva(String pIva) {
		this.pIva = pIva;
	}

	public String getIndirizzo() {
		return this.indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getComune() {
		return this.comune;
	}

	public void setComune(String comune) {
		this.comune = comune;
	}

	public String getCap() {
		return this.cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}


	public String getTelefono() {
		return this.telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCodAffiliato() {
		return this.codAffiliato;
	}

	public void setCodAffiliato(String codAffiliato) {
		this.codAffiliato = codAffiliato;
	}



	public String getNomeLogo() {
		return nomeLogo;
	}



	public void setNomeLogo(String nomeLogo) {
		this.nomeLogo = nomeLogo;
	}



	public String getPwd_pec() {
		return pwd_pec;
	}



	public void setPwd_pec(String pwd_pec) {
		this.pwd_pec = pwd_pec;
	}



	public String getEmail_pec() {
		return email_pec;
	}



	public void setEmail_pec(String email_pec) {
		this.email_pec = email_pec;
	}



	public String getHost_pec() {
		return host_pec;
	}



	public void setHost_pec(String host_pec) {
		this.host_pec = host_pec;
	}



	public String getPorta_pec() {
		return porta_pec;
	}



	public void setPorta_pec(String porta_pec) {
		this.porta_pec = porta_pec;
	}

}
