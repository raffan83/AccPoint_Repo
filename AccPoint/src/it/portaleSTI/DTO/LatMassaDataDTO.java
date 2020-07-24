package it.portaleSTI.DTO;

import java.math.BigDecimal;

public class LatMassaDataDTO {
	
	private int id;
	private int id_misura;
	private int ripetizione;
	private String comparatore;
	private String campione;
	private String parametro;
	private BigDecimal campioneL1;
	private BigDecimal misurandoL1;
	private BigDecimal misurandoL2;
	private BigDecimal campioneL2;
	private BigDecimal iEsimaDiff;
	private BigDecimal iEsimaDiff_media;
	
	private BigDecimal sc1;
	private double vc1;
	private BigDecimal sc2;
	private String esito_conferma;
	private BigDecimal ud;
	private BigDecimal uUf;
	private BigDecimal correzione;
	private int caso;
	private BigDecimal mX;
	private BigDecimal uMx;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_misura() {
		return id_misura;
	}
	public void setId_misura(int id_misura) {
		this.id_misura = id_misura;
	}
	public int getRipetizione() {
		return ripetizione;
	}
	public void setRipetizione(int ripetizione) {
		this.ripetizione = ripetizione;
	}
	public String getComparatore() {
		return comparatore;
	}
	public void setComparatore(String comparatore) {
		this.comparatore = comparatore;
	}
	public String getCampione() {
		return campione;
	}
	public void setCampione(String campione) {
		this.campione = campione;
	}
	public String getParametro() {
		return parametro;
	}
	public void setParametro(String parametro) {
		this.parametro = parametro;
	}
	public BigDecimal getCampioneL1() {
		return campioneL1;
	}
	public void setCampioneL1(BigDecimal campioneL1) {
		this.campioneL1 = campioneL1;
	}
	public BigDecimal getMisurandoL1() {
		return misurandoL1;
	}
	public void setMisurandoL1(BigDecimal misurandoL1) {
		this.misurandoL1 = misurandoL1;
	}
	public BigDecimal getMisurandoL2() {
		return misurandoL2;
	}
	public void setMisurandoL2(BigDecimal misurandoL2) {
		this.misurandoL2 = misurandoL2;
	}
	public BigDecimal getCampioneL2() {
		return campioneL2;
	}
	public void setCampioneL2(BigDecimal campioneL2) {
		this.campioneL2 = campioneL2;
	}
	public BigDecimal getiEsimaDiff() {
		return iEsimaDiff;
	}
	public void setiEsimaDiff(BigDecimal iEsimaDiff) {
		this.iEsimaDiff = iEsimaDiff;
	}
	public BigDecimal getiEsimaDiff_media() {
		return iEsimaDiff_media;
	}
	public void setiEsimaDiff_media(BigDecimal iEsimaDiff_media) {
		this.iEsimaDiff_media = iEsimaDiff_media;
	}
	public BigDecimal getSc1() {
		return sc1;
	}
	public void setSc1(BigDecimal sc1) {
		this.sc1 = sc1;
	}
	public double getVc1() {
		return vc1;
	}
	public void setVc1(double vc1) {
		this.vc1 = vc1;
	}
	public BigDecimal getSc2() {
		return sc2;
	}
	public void setSc2(BigDecimal sc2) {
		this.sc2 = sc2;
	}
	public String getEsito_conferma() {
		return esito_conferma;
	}
	public void setEsito_conferma(String esito_conferma) {
		this.esito_conferma = esito_conferma;
	}
	public BigDecimal getUd() {
		return ud;
	}
	public void setUd(BigDecimal ud) {
		this.ud = ud;
	}
	public BigDecimal getuUf() {
		return uUf;
	}
	public void setuUf(BigDecimal uUf) {
		this.uUf = uUf;
	}
	public BigDecimal getCorrezione() {
		return correzione;
	}
	public void setCorrezione(BigDecimal correzione) {
		this.correzione = correzione;
	}
	public int getCaso() {
		return caso;
	}
	public void setCaso(int caso) {
		this.caso = caso;
	}
	public BigDecimal getmX() {
		return mX;
	}
	public void setmX(BigDecimal mX) {
		this.mX = mX;
	}
	public BigDecimal getuMx() {
		return uMx;
	}
	public void setuMx(BigDecimal uMx) {
		this.uMx = uMx;
	}
}
