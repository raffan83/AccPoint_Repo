package it.portaleSTI.DTO;

import java.util.Date;

public class PRInterventoRisorsaDTO {
	private int id;
	private Integer id_intervento;
	private PRRisorsaDTO risorsa;
	private Date data_inizio;
	private Date data_fine;
	private int cella_inizio;
	private int cella_fine;
	String testo_riquadro;
	private int forzato;
	
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

	public Date getData_inizio() {
		return data_inizio;
	}
	public void setData_inizio(Date data_inizio) {
		this.data_inizio = data_inizio;
	}
	public Date getData_fine() {
		return data_fine;
	}
	public void setData_fine(Date data_fine) {
		this.data_fine = data_fine;
	}
	public Integer getId_intervento() {
		return id_intervento;
	}
	public void setId_intervento(Integer id_intervento) {
		this.id_intervento = id_intervento;
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
	public int getForzato() {
		return forzato;
	}
	public void setForzato(int forzato) {
		this.forzato = forzato;
	}
	
	

}
