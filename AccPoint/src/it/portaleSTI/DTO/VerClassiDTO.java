package it.portaleSTI.DTO;


import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;



public class VerClassiDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private int classe;

	private BigDecimal errore;
	
	private int limiteInferiore;

	private int limiteSuperiore;

	public VerClassiDTO() {
	}


	public BigDecimal getErrore() {
		return this.errore;
	}

	public void setErrore(BigDecimal errore) {
		this.errore = errore;
	}

	public int getLimiteInferiore() {
		return this.limiteInferiore;
	}
	public void setLimiteInferiore(int limiteInferiore) {
		this.limiteInferiore = limiteInferiore;
	}
	public int getLimiteSuperiore() {
		return this.limiteSuperiore;
	}
	public void setLimiteSuperiore(int limiteSuperiore) {
		this.limiteSuperiore = limiteSuperiore;
	}


	public int getClasse() {
		return classe;
	}


	public void setClasse(int classe) {
		this.classe = classe;
	}
}
