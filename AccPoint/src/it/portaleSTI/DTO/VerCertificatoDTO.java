package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class VerCertificatoDTO implements Serializable {
	
	/**
	 * 
	 */

	private int id=0;
	private VerMisuraDTO misura;
	private StatoCertificatoDTO stato;
	private String nomeCertificato="";
	private UtenteDTO utente;
	private Date dataCreazione;

	private Boolean firmato = false;
	
	
	public VerCertificatoDTO(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public VerMisuraDTO getMisura() {
		return misura;
	}

	public void setMisura(VerMisuraDTO misura) {
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

	public Date getDataCreazione() {
		return dataCreazione;
	}

	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}

	public Boolean getFirmato() {
		return firmato;
	}

	public void setFirmato(Boolean firmato) {
		this.firmato = firmato;
	}
	
	

}
