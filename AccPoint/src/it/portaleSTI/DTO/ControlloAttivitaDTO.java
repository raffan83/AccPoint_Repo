package it.portaleSTI.DTO;

public class ControlloAttivitaDTO {
	
	private UtenteDTO operatore;
	private InterventoDTO intervento;
	int strumentiTot;
	int strumentiAss;
	int controllato;
	
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
	

}
