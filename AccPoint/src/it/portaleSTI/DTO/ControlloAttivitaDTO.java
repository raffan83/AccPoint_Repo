package it.portaleSTI.DTO;

public class ControlloAttivitaDTO {
	
	private UtenteDTO operatore;
	private InterventoDTO intervento;
	private int strumentiTot;
	private int strumentiAss;
	private int controllato;
	private String unita_misura;
	private String note_operatore;
	
	
	public UtenteDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(UtenteDTO operatore) {
		this.operatore = operatore;
	}
	public InterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}
	public int getStrumentiTot() {
		return strumentiTot;
	}
	public void setStrumentiTot(int strumentiTot) {
		this.strumentiTot = strumentiTot;
	}
	public int getStrumentiAss() {
		return strumentiAss;
	}
	public void setStrumentiAss(int strumentiAss) {
		this.strumentiAss = strumentiAss;
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
