package it.portaleSTI.DTO;

import java.math.BigDecimal;


public class VerRipetibilitaDTO {

	private static final long serialVersionUID = 1L;

	private int id;

	private int idMisura;
	
	private int campo;

	private BigDecimal caricoAgg;

	private BigDecimal deltaPortata;

	private String esito;

	private BigDecimal indicazione;

	private BigDecimal massa;

	private BigDecimal mpe;


	private int numeroRipetizione;

	private BigDecimal portata;
	
	private String posizione;


	public VerRipetibilitaDTO() {
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

	public BigDecimal getDeltaPortata() {
		return this.deltaPortata;
	}

	public void setDeltaPortata(BigDecimal deltaPortata) {
		this.deltaPortata = deltaPortata;
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

	public int getNumeroRipetizione() {
		return this.numeroRipetizione;
	}

	public void setNumeroRipetizione(int numeroRipetizione) {
		this.numeroRipetizione = numeroRipetizione;
	}

	public BigDecimal getPortata() {
		return this.portata;
	}

	public void setPortata(BigDecimal portata) {
		this.portata = portata;
	}



	public int getIdMisura() {
		return idMisura;
	}

	public void setIdMisura(int idMisura) {
		this.idMisura = idMisura;
	}

	public String getPosizione() {
		return posizione;
	}

	public void setPosizione(String posizione) {
		this.posizione = posizione;
	}

	

}
