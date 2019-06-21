package it.portaleSTI.DTO;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Id;

public class VerLinearitaDTO {

	private static final long serialVersionUID = 1L;

	
	private int id;

	private int campo;

	
	private BigDecimal caricoAgg;

	private BigDecimal divisione;

	private BigDecimal errore;

	
	private BigDecimal erroreCor;

	private String esito;

	
	private int idMisura;

	private BigDecimal indicazione;

	private BigDecimal massa;

	private BigDecimal mpe;

	private int riferimento;

	
	private int tipoAzzeramento;

	public VerLinearitaDTO() {
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

	public BigDecimal getDivisione() {
		return this.divisione;
	}

	public void setDivisione(BigDecimal divisione) {
		this.divisione = divisione;
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

	public int getIdMisura() {
		return this.idMisura;
	}

	public void setIdMisura(int idMisura) {
		this.idMisura = idMisura;
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

	public int getRiferimento() {
		return this.riferimento;
	}

	public void setRiferimento(int riferimento) {
		this.riferimento = riferimento;
	}

	public int getTipoAzzeramento() {
		return this.tipoAzzeramento;
	}

	public void setTipoAzzeramento(int tipoAzzeramento) {
		this.tipoAzzeramento = tipoAzzeramento;
	}


}
