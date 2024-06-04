package it.portaleSTI.DTO;

import java.io.Serializable;

public class DevDeviceMonitorDTO implements Serializable{
	
	private DevDeviceDTO device;
	private  DevDeviceDTO monitor;
	public DevDeviceDTO getDevice() {
		return device;
	}
	public void setDevice(DevDeviceDTO device) {
		this.device = device;
	}
	public DevDeviceDTO getMonitor() {
		return monitor;
	}
	public void setMonitor(DevDeviceDTO monitor) {
		this.monitor = monitor;
	}
	
	

}
