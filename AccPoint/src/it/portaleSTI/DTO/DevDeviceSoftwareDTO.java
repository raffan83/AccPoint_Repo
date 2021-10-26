package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.Date;

public class DevDeviceSoftwareDTO implements Serializable{
	
	private DevDeviceDTO device;
	private DevSoftwareDTO software;	
	private DevStatoValidazioneDTO stato_validazione;
	private Date data_validazione;
	private String product_key;
	
	public DevDeviceDTO getDevice() {
		return device;
	}
	public void setDevice(DevDeviceDTO device) {
		this.device = device;
	}
	public DevSoftwareDTO getSoftware() {
		return software;
	}
	public void setSoftware(DevSoftwareDTO software) {
		this.software = software;
	}
	public DevStatoValidazioneDTO getStato_validazione() {
		return stato_validazione;
	}
	public void setStato_validazione(DevStatoValidazioneDTO stato_validazione) {
		this.stato_validazione = stato_validazione;
	}
	public Date getData_validazione() {
		return data_validazione;
	}
	public void setData_validazione(Date data_validazione) {
		this.data_validazione = data_validazione;
	}
	public String getProduct_key() {
		return product_key;
	}
	public void setProduct_key(String product_key) {
		this.product_key = product_key;
	}
	

}
