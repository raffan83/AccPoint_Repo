package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagItemPaccoDTO implements Serializable {
	
	private MagPaccoDTO pacco;
	private MagItemDTO item;
	private int quantita;
	private String note;
	private Integer accettato;
	private String note_accettazione;
	
	
	public MagPaccoDTO getPacco() {
		return pacco;
	}
	public void setPacco(MagPaccoDTO pacco) {
		this.pacco = pacco;
	}
	public MagItemDTO getItem() {
		return item;
	}
	public void setItem(MagItemDTO item) {
		this.item = item;
	}
	public int getQuantita() {
		return quantita;
	}
	public void setQuantita(int quantita) {
		this.quantita = quantita;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Integer getAccettato() {
		return accettato;
	}
	public void setAccettato(Integer accettato) {
		this.accettato = accettato;
	}
	public String getNote_accettazione() {
		return note_accettazione;
	}
	public void setNote_accettazione(String note_accettazione) {
		this.note_accettazione = note_accettazione;
	}
	

}
