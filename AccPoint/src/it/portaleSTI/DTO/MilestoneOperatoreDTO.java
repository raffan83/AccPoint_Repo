package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.Date;

public class MilestoneOperatoreDTO {
	
	int id;
	InterventoDTO intervento;
	UtenteDTO user;
	String descrizioneMilestone;
	Date data;
	BigDecimal quantitaTotale;
	BigDecimal quantitaAssegnata;
	BigDecimal prezzo_un;
	BigDecimal prezzo_totale;
	BigDecimal presso_assegnato;
	String note;
	int abilitato;
	int controllato;
	String unita_misura;
	String note_operatore;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}
	public UtenteDTO getUser() {
		return user;
	}
	public void setUser(UtenteDTO user) {
		this.user = user;
	}
	public String getDescrizioneMilestone() {
		return descrizioneMilestone;
	}
	public void setDescrizioneMilestone(String descrizioneMilestone) {
		this.descrizioneMilestone = descrizioneMilestone;
	}
	public BigDecimal getQuantitaTotale() {
		return quantitaTotale;
	}
	public void setQuantitaTotale(BigDecimal quantitaTotale) {
		this.quantitaTotale = quantitaTotale;
	}
	public BigDecimal getQuantitaAssegnata() {
		return quantitaAssegnata;
	}
	public void setQuantitaAssegnata(BigDecimal quantitaAssegnata) {
		this.quantitaAssegnata = quantitaAssegnata;
	}
	public BigDecimal getPrezzo_un() {
		return prezzo_un;
	}
	public void setPrezzo_un(BigDecimal prezzo_un) {
		this.prezzo_un = prezzo_un;
	}
	public BigDecimal getPrezzo_totale() {
		return prezzo_totale;
	}
	public void setPrezzo_totale(BigDecimal prezzo_totale) {
		this.prezzo_totale = prezzo_totale;
	}
	public BigDecimal getPresso_assegnato() {
		return presso_assegnato;
	}
	public void setPresso_assegnato(BigDecimal presso_assegnato) {
		this.presso_assegnato = presso_assegnato;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public int getAbilitato() {
		return abilitato;
	}
	public void setAbilitato(int abilitato) {
		this.abilitato = abilitato;
	}
	public int getControllato() {
		return controllato;
	}
	public void setControllato(int controllato) {
		this.controllato = controllato;
	}
	public String getUnita_misura() {
		return unita_misura;
	}
	public void setUnita_misura(String unita_misura) {
		this.unita_misura = unita_misura;
	}
	public String getNote_operatore() {
		return note_operatore;
	}
	public void setNote_operatore(String note_operatore) {
		this.note_operatore = note_operatore;
	}
	
	

	
}
