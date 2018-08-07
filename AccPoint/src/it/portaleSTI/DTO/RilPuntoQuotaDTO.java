package it.portaleSTI.DTO;

import java.math.BigDecimal;

public class RilPuntoQuotaDTO {
	
	private int id;
	private RilQuotaDTO quota;
	private BigDecimal valore_punto;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public RilQuotaDTO getQuota() {
		return quota;
	}
	public void setQuota(RilQuotaDTO quota) {
		this.quota = quota;
	}
	public BigDecimal getValore_punto() {
		return valore_punto;
	}
	public void setValore_punto(BigDecimal valore_punto) {
		this.valore_punto = valore_punto;
	}


}
