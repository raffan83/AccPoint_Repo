package it.portaleSTI.DTO;

public class PRInterventoRisorsaDTO {
	private int id;
	private InterventoDTO intervento;
	private PRRisorsaDTO risorsa;
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
	public PRRisorsaDTO getRisorsa() {
		return risorsa;
	}
	public void setRisorsa(PRRisorsaDTO risorsa) {
		this.risorsa = risorsa;
	}
	
	

}
