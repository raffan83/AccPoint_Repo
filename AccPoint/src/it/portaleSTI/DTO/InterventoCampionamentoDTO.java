package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class InterventoCampionamentoDTO {

	private int id;
	private UtenteDTO user;
	private Date dataCreazione;
	private String ID_COMMESSA;
	private StatoInterventoDTO stato;
	private Date dataChiusura;
	
	private Set<PrenotazioneAccessorioDTO> listaPrenotazioniAccessori = new HashSet<PrenotazioneAccessorioDTO>(0);
	private Set<PrenotazioniDotazioneDTO> listaPrenotazioniDotazioni = new HashSet<PrenotazioniDotazioneDTO>(0);
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
	public Date getDataCreazione() {
		return dataCreazione;
	}
	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public String getID_COMMESSA() {
		return ID_COMMESSA;
	}
	public void setID_COMMESSA(String iD_COMMESSA) {
		ID_COMMESSA = iD_COMMESSA;
	}
	public StatoInterventoDTO getStato() {
		return stato;
	}
	public void setStato(StatoInterventoDTO stato) {
		this.stato = stato;
	}
	public Date getDataChiusura() {
		return dataChiusura;
	}
	public void setDataChiusura(Date dataChiusura) {
		this.dataChiusura = dataChiusura;
	}
	public Set<PrenotazioneAccessorioDTO> getListaPrenotazioniAccessori() {
		return listaPrenotazioniAccessori;
	}
	public void setListaPrenotazioniAccessori(
			Set<PrenotazioneAccessorioDTO> listaPrenotazioniAccessori) {
		this.listaPrenotazioniAccessori = listaPrenotazioniAccessori;
	}
	public Set<PrenotazioniDotazioneDTO> getListaPrenotazioniDotazioni() {
		return listaPrenotazioniDotazioni;
	}
	public void setListaPrenotazioniDotazioni(
			Set<PrenotazioniDotazioneDTO> listaPrenotazioniDotazioni) {
		this.listaPrenotazioniDotazioni = listaPrenotazioniDotazioni;
	}
	
	
	
}