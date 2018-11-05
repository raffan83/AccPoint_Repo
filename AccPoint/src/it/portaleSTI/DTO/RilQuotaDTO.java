package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

public class RilQuotaDTO {

	private int id;
	private RilParticolareDTO impronta;
	private int id_ripetizione;
	private BigDecimal val_nominale;
	private String coordinata;
	private RilSimboloDTO simbolo;
	private BigDecimal tolleranza_positiva;
	private BigDecimal tolleranza_negativa;
	private RilQuotaFunzionaleDTO quota_funzionale;
	private String sigla_tolleranza;
	private String um;
	   // private Set<RilPuntoQuotaDTO> listaPuntiQuota = new HashSet<RilPuntoQuotaDTO>(0);
	private Set<RilPuntoQuotaDTO> listaPuntiQuota = new HashSet<RilPuntoQuotaDTO>();
    private String note;
    private int importata;
    
    
	
	public int getImportata() {
		return importata;
	}
	public void setImportata(int importata) {
		this.importata = importata;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public RilParticolareDTO getImpronta() {
		return impronta;
	}
	public void setImpronta(RilParticolareDTO impronta) {
		this.impronta = impronta;
	}
	public BigDecimal getVal_nominale() {
		return val_nominale;
	}
	public void setVal_nominale(BigDecimal val_nominale) {
		this.val_nominale = val_nominale;
	}
	public String getCoordinata() {
		return coordinata;
	}
	public void setCoordinata(String coordinata) {
		this.coordinata = coordinata;
	}
	public RilSimboloDTO getSimbolo() {
		return simbolo;
	}
	public void setSimbolo(RilSimboloDTO simbolo) {
		this.simbolo = simbolo;
	}
	public BigDecimal getTolleranza_positiva() {
		return tolleranza_positiva;
	}
	public void setTolleranza_positiva(BigDecimal tolleranza_positiva) {
		this.tolleranza_positiva = tolleranza_positiva;
	}
	public BigDecimal getTolleranza_negativa() {
		return tolleranza_negativa;
	}
	public void setTolleranza_negativa(BigDecimal tolleranza_negativa) {
		this.tolleranza_negativa = tolleranza_negativa;
	}
	public RilQuotaFunzionaleDTO getQuota_funzionale() {
		return quota_funzionale;
	}
	public void setQuota_funzionale(RilQuotaFunzionaleDTO quota_funzionale) {
		this.quota_funzionale = quota_funzionale;
	}
	public String getSigla_tolleranza() {
		return sigla_tolleranza;
	}
	public void setSigla_tolleranza(String sigla_tolleranza) {
		this.sigla_tolleranza = sigla_tolleranza;
	}
	public Set<RilPuntoQuotaDTO> getListaPuntiQuota() {
		return listaPuntiQuota;
	}
	public void setListaPuntiQuota(Set<RilPuntoQuotaDTO> listaPuntiQuota) {
		this.listaPuntiQuota = listaPuntiQuota;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getId_ripetizione() {
		return id_ripetizione;
	}
	public void setId_ripetizione(int id_ripetizione) {
		this.id_ripetizione = id_ripetizione;
	}
	public String getUm() {
		return um;
	}
	public void setUm(String um) {
		this.um = um;
	}
	
}
