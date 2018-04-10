package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagItemPaccoDTO implements Serializable {
	
	private MagPaccoDTO pacco;
	private MagItemDTO item;
	private int quantita;
	private String note;
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
	

}
