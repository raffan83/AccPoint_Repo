package it.portaleSTI.DTO;

import java.util.Date;

public class DevProceduraDTO {
	
	private int id;
	private String descrizione;
	private String frequenza;
	private DevTipoProceduraDTO tipo_procedura;
	private int disabilitato;
	private Date scadenza_contratto;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(String frequenza) {
		this.frequenza = frequenza;
	}
	public DevTipoProceduraDTO getTipo_procedura() {
		return tipo_procedura;
	}
	public void setTipo_procedura(DevTipoProceduraDTO tipo_procedura) {
		this.tipo_procedura = tipo_procedura;
	}
//	public int getId_device() {
//		return id_device;
//	}
//	public void setId_device(int id_device) {
//		this.id_device = id_device;
//	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public Date getScadenza_contratto() {
		return scadenza_contratto;
	}
	public void setScadenza_contratto(Date scadenza_contratto) {
		this.scadenza_contratto = scadenza_contratto;
	}
	
	
	
}
