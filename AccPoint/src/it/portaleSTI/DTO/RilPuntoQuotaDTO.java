package it.portaleSTI.DTO;

import java.math.BigDecimal;

public class RilPuntoQuotaDTO {
	
	private int id;
	private int id_quota=0;
	private BigDecimal valore_punto;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public int getId_quota() {
		return id_quota;
	}
	public void setId_quota(int id_quota) {
		this.id_quota = id_quota;
	}
	public BigDecimal getValore_punto() {
		return valore_punto;
	}
	public void setValore_punto(BigDecimal valore_punto) {
		this.valore_punto = valore_punto;
	}


}
