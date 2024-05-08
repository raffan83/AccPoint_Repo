package it.portaleSTI.DTO;

import java.util.Date;

public class PaaPrenotazioneDTO {
	
	private int id;
	private PaaVeicoloDTO veicolo;
	private UtenteDTO utente;
	private Date data_inizio_prenotazione;
	private Date data_fine_prenotazione;
	private Date data_conferma;
	private String note;
	private int stato_prenotazione;
	private int cella_inizio;
	private int cella_fine;
	private int manutenzione;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public PaaVeicoloDTO getVeicolo() {
		return veicolo;
	}
	public void setVeicolo(PaaVeicoloDTO veicolo) {
		this.veicolo = veicolo;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public Date getData_inizio_prenotazione() {
		return data_inizio_prenotazione;
	}
	public void setData_inizio_prenotazione(Date data_inizio_prenotazione) {
		this.data_inizio_prenotazione = data_inizio_prenotazione;
	}
	public Date getData_fine_prenotazione() {
		return data_fine_prenotazione;
	}
	public void setData_fine_prenotazione(Date data_fine_prenotazione) {
		this.data_fine_prenotazione = data_fine_prenotazione;
	}
	public Date getData_conferma() {
		return data_conferma;
	}
	public void setData_conferma(Date data_conferma) {
		this.data_conferma = data_conferma;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getStato_prenotazione() {
		return stato_prenotazione;
	}
	public void setStato_prenotazione(int stato_prenotazione) {
		this.stato_prenotazione = stato_prenotazione;
	}
	public int getCella_inizio() {
		return cella_inizio;
	}
	public void setCella_inizio(int cella_inizio) {
		this.cella_inizio = cella_inizio;
	}
	public int getCella_fine() {
		return cella_fine;
	}
	public void setCella_fine(int cella_fine) {
		this.cella_fine = cella_fine;
	}
	public int getManutenzione() {
		return manutenzione;
	}
	public void setManutenzione(int manutenzione) {
		this.manutenzione = manutenzione;
	}
	
	

}
