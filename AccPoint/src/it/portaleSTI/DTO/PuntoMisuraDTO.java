package it.portaleSTI.DTO;

import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Blob;

public class PuntoMisuraDTO {

	private int id = 0;
	private int id_misura = 0;
	private int id_tabella = 0;
	private int id_ripetizione = 0;
	private int ordine = 0;
	private String tipoProva = "";
	private String tipoVerifica = "";
	private String um = "";
	private BigDecimal valoreCampione = BigDecimal.ZERO;
	private BigDecimal valoreMedioCampione = BigDecimal.ZERO;
	private BigDecimal valoreStrumento = BigDecimal.ZERO;
	private BigDecimal valoreMedioStrumento = BigDecimal.ZERO;
	private BigDecimal scostamento = BigDecimal.ZERO;
	private BigDecimal accettabilita = BigDecimal.ZERO;
	private BigDecimal incertezza = BigDecimal.ZERO;
	private String esito = "";
	private String desc_Campione = "";
	private String desc_parametro = "";
	private String numeroCertificatoCampione;
	private BigDecimal misura = BigDecimal.ZERO;
	private String um_calc = "";
	private BigDecimal risoluzione_campione = BigDecimal.ZERO;
	private BigDecimal risoluzione_misura = BigDecimal.ZERO;
	private BigDecimal fondoScala = BigDecimal.ZERO;
	private int interpolazione = 0;
	private String fm = "";
	private int selConversione = 0;
	private int selTolleranza = 0;
	private BigDecimal letturaCampione = BigDecimal.ZERO;
	private double per_util = 0;
	private String obsoleto = "";
	private String applicabile = "";
	private BigDecimal dgt = BigDecimal.ZERO;
	private String calibrazione="";
	private byte[] file_att;
	private String numero_certificato_campione;
	private String mabba_val;
	private String mabba_comparatore;
	private BigDecimal mabba_mc;

	
	public BigDecimal getDgt() {
		return dgt;
	}
	public void setDgt(BigDecimal dgt) {
		this.dgt = dgt;
	}
	public int getId_ripetizione() {
		return id_ripetizione;
	}
	public void setId_ripetizione(int id_ripetizione) {
		this.id_ripetizione = id_ripetizione;
	}
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
	public int getId_tabella() {
		return id_tabella;
	}
	public void setId_tabella(int id_tabella) {
		this.id_tabella = id_tabella;
	}
	public int getOrdine() {
		return ordine;
	}
	public void setOrdine(int ordine) {
		this.ordine = ordine;
	}
	public String getTipoProva() {
		return tipoProva;
	}
	public void setTipoProva(String tipoProva) {
		this.tipoProva = tipoProva;
	}
	public String getTipoVerifica() {
		return tipoVerifica;
	}
	public void setTipoVerifica(String tipoVerifica) {
		this.tipoVerifica = tipoVerifica;
	}
	public String getUm() {
		return um;
	}
	public void setUm(String um) {
		this.um = um;
	}
	public BigDecimal getValoreCampione() {
		return valoreCampione;
	}
	public void setValoreCampione(BigDecimal valoreCampione) {
		this.valoreCampione = valoreCampione;
	}
	public BigDecimal getValoreMedioCampione() {
		return valoreMedioCampione;
	}
	public void setValoreMedioCampione(BigDecimal valoreMedioCampione) {
		this.valoreMedioCampione = valoreMedioCampione;
	}
	public BigDecimal getValoreStrumento() {
		return valoreStrumento;
	}
	public void setValoreStrumento(BigDecimal valoreStrumento) {
		this.valoreStrumento = valoreStrumento;
	}
	public BigDecimal getValoreMedioStrumento() {
		return valoreMedioStrumento;
	}
	public void setValoreMedioStrumento(BigDecimal valoreMedioStrumento) {
		this.valoreMedioStrumento = valoreMedioStrumento;
	}
	public BigDecimal getScostamento() {
		return scostamento;
	}
	public void setScostamento(BigDecimal scostamento) {
		this.scostamento = scostamento;
	}
	public BigDecimal getAccettabilita() {
		return accettabilita;
	}
	public void setAccettabilita(BigDecimal accettabilita) {
		this.accettabilita = accettabilita;
	}
	public BigDecimal getIncertezza() {
		return incertezza;
	}
	public void setIncertezza(BigDecimal incertezza) {
		this.incertezza = incertezza;
	}
	public String getEsito() {
		return esito;
	}
	public void setEsito(String esito) {
		this.esito = esito;
	}
	public String getDesc_Campione() {
		return desc_Campione;
	}
	public void setDesc_Campione(String desc_Campione) {
		this.desc_Campione = desc_Campione;
	}
	public String getDesc_parametro() {
		return desc_parametro;
	}
	public void setDesc_parametro(String desc_parametro) {
		this.desc_parametro = desc_parametro;
	}
	
	public String getNumeroCertificatoCampione() {
		return numeroCertificatoCampione;
	}
	public void setNumeroCertificatoCampione(String numeroCertificatoCampione) {
		this.numeroCertificatoCampione = numeroCertificatoCampione;
	}

	
	public BigDecimal getMisura() {
		return misura;
	}
	public void setMisura(BigDecimal misura) {
		this.misura = misura;
	}
	public String getUm_calc() {
		return um_calc;
	}
	public void setUm_calc(String um_calc) {
		this.um_calc = um_calc;
	}
	public BigDecimal getRisoluzione_campione() {
		return risoluzione_campione;
	}
	public void setRisoluzione_campione(BigDecimal risoluzione_campione) {
		this.risoluzione_campione = risoluzione_campione;
	}
	public BigDecimal getRisoluzione_misura() {
		return risoluzione_misura;
	}
	public void setRisoluzione_misura(BigDecimal risoluzione_misura) {
		this.risoluzione_misura = risoluzione_misura;
	}
	public BigDecimal getFondoScala() {
		return fondoScala;
	}
	public void setFondoScala(BigDecimal fondoScala) {
		this.fondoScala = fondoScala;
	}
	public int getInterpolazione() {
		return interpolazione;
	}
	public void setInterpolazione(int interpolazione) {
		this.interpolazione = interpolazione;
	}
	public String getFm() {
		return fm;
	}
	public void setFm(String fm) {
		this.fm = fm;
	}
	public int getSelConversione() {
		return selConversione;
	}
	public void setSelConversione(int selConversione) {
		this.selConversione = selConversione;
	}
	public BigDecimal getLetturaCampione() {
		return letturaCampione;
	}
	public void setLetturaCampione(BigDecimal letturaCampione) {
		this.letturaCampione = letturaCampione;
	}
	public double getPer_util() {
		return per_util;
	}
	public void setPer_util(double per_util) {
		this.per_util = per_util;
	}
	public String getObsoleto() {
		return obsoleto;
	}
	public void setObsoleto(String obsoleto) {
		this.obsoleto = obsoleto;
	}
	public int getSelTolleranza() {
		return selTolleranza;
	}
	public void setSelTolleranza(int selTolleranza) {
		this.selTolleranza = selTolleranza;
	}
	public String getApplicabile() {
		return applicabile;
	}
	public void setApplicabile(String applicabile) {
		this.applicabile = applicabile;
	}
	public String getCalibrazione() {
		return calibrazione;
	}
	public void setCalibrazione(String calibrazione) {
		this.calibrazione = calibrazione;
	}
	public byte[] getFile_att() {
		return file_att;
	}
	public void setFile_att(byte[] file_att) {
		this.file_att = file_att;
	}
	public String getNumero_certificato_campione() {
		return numero_certificato_campione;
	}
	public void setNumero_certificato_campione(String numero_certificato_campione) {
		this.numero_certificato_campione = numero_certificato_campione;
	}
	public String getMabba_val() {
		return mabba_val;
	}
	public void setMabba_val(String mabba_val) {
		this.mabba_val = mabba_val;
	}
	public String getMabba_comparatore() {
		return mabba_comparatore;
	}
	public void setMabba_comparatore(String mabba_comparatore) {
		this.mabba_comparatore = mabba_comparatore;
	}
	public BigDecimal getMabba_mc() {
		return mabba_mc;
	}
	public void setMabba_mc(BigDecimal mabba_mc) {
		this.mabba_mc = mabba_mc;
	}



}
