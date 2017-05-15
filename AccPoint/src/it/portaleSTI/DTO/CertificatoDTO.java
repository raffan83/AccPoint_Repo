package it.portaleSTI.DTO;

public class CertificatoDTO {
	
	private int id;
	private MisuraDTO misura;
	private StatoCertificatoDTO stato;
	private String nomeCertificato;
	private UtenteDTO utente;
	
	public CertificatoDTO(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public MisuraDTO getMisura() {
		return misura;
	}

	public void setMisura(MisuraDTO misura) {
		this.misura = misura;
	}

	public StatoCertificatoDTO getStato() {
		return stato;
	}

	public void setStato(StatoCertificatoDTO stato) {
		this.stato = stato;
	}

	public String getNomeCertificato() {
		return nomeCertificato;
	}

	public void setNomeCertificato(String nomeCertificato) {
		this.nomeCertificato = nomeCertificato;
	}

	public UtenteDTO getUtente() {
		return utente;
	}

	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	
	

}
