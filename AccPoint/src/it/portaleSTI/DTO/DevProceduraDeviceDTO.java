package it.portaleSTI.DTO;

import java.io.Serializable;

public class DevProceduraDeviceDTO implements Serializable {
	
	private DevProceduraDTO procedura;
	private DevDeviceDTO device;
	public DevDeviceDTO getDevice() {
		return device;
	}
	public void setDevice(DevDeviceDTO device) {
		this.device = device;
	}
	public DevProceduraDTO getProcedura() {
		return procedura;
	}
	public void setProcedura(DevProceduraDTO procedura) {
		this.procedura = procedura;
	}

}
