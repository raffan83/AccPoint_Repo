package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class DevSoftwareDTO {
	
	private int id;
	private String nome;
	private String produttore;
	private String versione;
	private int disabilitato;
	//private Set<DevDeviceDTO> listaDevice = new HashSet<DevDeviceDTO>();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getProduttore() {
		return produttore;
	}
	public void setProduttore(String produttore) {
		this.produttore = produttore;
	}
	
	
	
	public String getVersione() {
		return versione;
	}
	public void setVersione(String versione) {
		this.versione = versione;
	}
//	public Set<DevDeviceDTO> getListaDevice() {
//		return listaDevice;
//	}
//	public void setListaDevice(Set<DevDeviceDTO> listaDevice) {
//		this.listaDevice = listaDevice;
//	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}

	
}
