package it.portaleSTI.DTO;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


public class VerDecentramentoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	
	private int id;

	private int campo;

	
	private BigDecimal caricoAgg;

	private BigDecimal errore;

	private BigDecimal erroreCor;

	private String esito;

	private BigDecimal indicazione;

	private BigDecimal massa;

	private BigDecimal mpe;

	private int posizione;

	private int puntiAppoggio;

	private int tipoRicettore;

	private VerMisuraDTO verMisura;

	public VerDecentramentoDTO() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getCampo() {
		return this.campo;
	}

	public void setCampo(int campo) {
		this.campo = campo;
	}

	public BigDecimal getCaricoAgg() {
		return this.caricoAgg;
	}

	public void setCaricoAgg(BigDecimal caricoAgg) {
		this.caricoAgg = caricoAgg;
	}

	public BigDecimal getErrore() {
		return this.errore;
	}

	public void setErrore(BigDecimal errore) {
		this.errore = errore;
	}

	public BigDecimal getErroreCor() {
		return this.erroreCor;
	}

	public void setErroreCor(BigDecimal erroreCor) {
		this.erroreCor = erroreCor;
	}

	public String getEsito() {
		return this.esito;
	}

	public void setEsito(String esito) {
		this.esito = esito;
	}

	public BigDecimal getIndicazione() {
		return this.indicazione;
	}

	public void setIndicazione(BigDecimal indicazione) {
		this.indicazione = indicazione;
	}

	public BigDecimal getMassa() {
		return this.massa;
	}

	public void setMassa(BigDecimal massa) {
		this.massa = massa;
	}

	public BigDecimal getMpe() {
		return this.mpe;
	}

	public void setMpe(BigDecimal mpe) {
		this.mpe = mpe;
	}

	public int getPosizione() {
		return this.posizione;
	}

	public void setPosizione(int posizione) {
		this.posizione = posizione;
	}

	public int getPuntiAppoggio() {
		return this.puntiAppoggio;
	}

	public void setPuntiAppoggio(int puntiAppoggio) {
		this.puntiAppoggio = puntiAppoggio;
	}

	public int getTipoRicettore() {
		return this.tipoRicettore;
	}

	public void setTipoRicettore(int tipoRicettore) {
		this.tipoRicettore = tipoRicettore;
	}

	public VerMisuraDTO getVerMisura() {
		return this.verMisura;
	}

	public void setVerMisura(VerMisuraDTO verMisura) {
		this.verMisura = verMisura;
	}

}