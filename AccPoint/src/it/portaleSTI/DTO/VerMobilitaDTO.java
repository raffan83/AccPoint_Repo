package it.portaleSTI.DTO;

import java.math.BigDecimal;

public class VerMobilitaDTO {

	private static final long serialVersionUID = 1L;

	private int id;

	private int campo;

	private int carico;
	
	private BigDecimal caricoAgg;

	private int caso;

	private String check;

	private BigDecimal differenziale;

	private BigDecimal divisione;

	private String esito;

	private int idMisura;

	private BigDecimal indicazione;

	private BigDecimal massa;

	private BigDecimal postIndicazione;

	public VerMobilitaDTO() {
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

	public int getCarico() {
		return this.carico;
	}

	public void setCarico(int carico) {
		this.carico = carico;
	}

	public BigDecimal getCaricoAgg() {
		return this.caricoAgg;
	}

	public void setCaricoAgg(BigDecimal caricoAgg) {
		this.caricoAgg = caricoAgg;
	}

	public int getCaso() {
		return this.caso;
	}

	public void setCaso(int caso) {
		this.caso = caso;
	}

	public String getCheck() {
		return this.check;
	}

	public void setCheck(String check) {
		this.check = check;
	}

	public BigDecimal getDifferenziale() {
		return this.differenziale;
	}

	public void setDifferenziale(BigDecimal differenziale) {
		this.differenziale = differenziale;
	}

	public BigDecimal getDivisione() {
		return this.divisione;
	}

	public void setDivisione(BigDecimal divisione) {
		this.divisione = divisione;
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

	public BigDecimal getPostIndicazione() {
		return this.postIndicazione;
	}

	public void setPostIndicazione(BigDecimal postIndicazione) {
		this.postIndicazione = postIndicazione;
	}


}
