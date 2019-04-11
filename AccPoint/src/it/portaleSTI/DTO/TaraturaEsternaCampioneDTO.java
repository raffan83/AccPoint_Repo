package it.portaleSTI.DTO;

import java.util.Date;

public class TaraturaEsternaCampioneDTO {
	
	private int id;
	private CampioneDTO campione;
	private UtenteDTO operatore;
	private String oggetto;
	private int stato;
	private String commessa;
	private String committente;
	private String controllo;
	private Date data;
	private AcAttivitaCampioneDTO verifica_intermedia;
	private String note;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public UtenteDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(UtenteDTO operatore) {
		this.operatore = operatore;
	}
	public String getOggetto() {
		return oggetto;
	}
	public void setOggetto(String oggetto) {
		this.oggetto = oggetto;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}
	public String getCommessa() {
		return commessa;
	}
	public void setCommessa(String commessa) {
		this.commessa = commessa;
	}
	public String getCommittente() {
		return committente;
	}
	public void setCommittente(String committente) {
		this.committente = committente;
	}
	public String getControllo() {
		return controllo;
	}
	public void setControllo(String controllo) {
		this.controllo = controllo;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public AcAttivitaCampioneDTO getVerifica_intermedia() {
		return verifica_intermedia;
	}
	public void setVerifica_intermedia(AcAttivitaCampioneDTO verifica_intermedia) {
		this.verifica_intermedia = verifica_intermedia;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	

}
