package it.portaleSTI.DTO;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the misura database table.
 * 
 */

public class Misura implements Serializable {
	private static final long serialVersionUID = 1L;

	private int id;

	private InterventoDTO intervento;
	
	private InterventoDatiDTO interventoDati;
 
	private Date dataMisura;


	private StatoRicezioneStrumentoDTO statoRicezione;

	
	private StrumentoDTO strumento;

	
	private UtenteDTO user;

	private float temperatura;

	private float umidita;

    public Misura() {
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataMisura() {
		return dataMisura;
	}

	public void setDataMisura(Date dataMisura) {
		this.dataMisura = dataMisura;
	}

	public StatoRicezioneStrumentoDTO getStatoRicezione() {
		return statoRicezione;
	}

	public void setStatoRicezione(StatoRicezioneStrumentoDTO statoRicezione) {
		this.statoRicezione = statoRicezione;
	}

	public StrumentoDTO getStrumento() {
		return strumento;
	}

	public void setStrumento(StrumentoDTO strumento) {
		this.strumento = strumento;
	}

	public UtenteDTO getUser() {
		return user;
	}

	public void setUser(UtenteDTO user) {
		this.user = user;
	}

	public float getTemperatura() {
		return temperatura;
	}

	public void setTemperatura(float temperatura) {
		this.temperatura = temperatura;
	}

	public float getUmidita() {
		return umidita;
	}

	public void setUmidita(float umidita) {
		this.umidita = umidita;
	}

	public InterventoDTO getIntervento() {
		return intervento;
	}

	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}

	public InterventoDatiDTO getInterventoDati() {
		return interventoDati;
	}

	public void setInterventoDati(InterventoDatiDTO interventoDati) {
		this.interventoDati = interventoDati;
	}

}