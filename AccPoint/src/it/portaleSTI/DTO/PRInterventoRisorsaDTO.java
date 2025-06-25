package it.portaleSTI.DTO;

import java.util.Date;

public class PRInterventoRisorsaDTO {
	private int id;
	private Integer id_intervento;
	private PRRisorsaDTO risorsa;
	private Date data;
	private int cella;
	String testo_riquadro;
	
	public int getId() {
		return id;
	}
	public String getTesto_riquadro() {
		return testo_riquadro;
	}
	public void setTesto_riquadro(String testo_riquadro) {
		this.testo_riquadro = testo_riquadro;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Integer getIntervento() {
		return id_intervento;
	}
	public void setIntervento(Integer intervento) {
		this.id_intervento = intervento;
	}
	public PRRisorsaDTO getRisorsa() {
		return risorsa;
	}
	public void setRisorsa(PRRisorsaDTO risorsa) {
		this.risorsa = risorsa;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public int getCella() {
		return cella;
	}
	public void setCella(int cella) {
		this.cella = cella;
	}
	
	

}
