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
	private Date data_acquisto;
	private Date data_scadenza;
	private String obsoleto;
	private DevTipoLicenzaDTO tipo_licenza;
	private String email_responsabile;
	
	private String company;
	private String utente;
	private DevDeviceDTO device;
	private Date data_invio_remind;
	private DevContrattoDTO contratto;
	private Long n_device;
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
	public Date getData_acquisto() {
		return data_acquisto;
	}
	public void setData_acquisto(Date data_acquisto) {
		this.data_acquisto = data_acquisto;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public String getObsoleto() {
		return obsoleto;
	}
	public void setObsoleto(String obsoleto) {
		this.obsoleto = obsoleto;
	}
	public DevTipoLicenzaDTO getTipo_licenza() {
		return tipo_licenza;
	}
	public void setTipo_licenza(DevTipoLicenzaDTO tipo_licenza) {
		this.tipo_licenza = tipo_licenza;
	}
	public String getEmail_responsabile() {
		return email_responsabile;
	}
	public void setEmail_responsabile(String email_responsabile) {
		this.email_responsabile = email_responsabile;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getUtente() {
		return utente;
	}
	public void setUtente(String utente) {
		this.utente = utente;
	}
	public DevDeviceDTO getDevice() {
		return device;
	}
	public void setDevice(DevDeviceDTO device) {
		this.device = device;
	}
	public Date getData_invio_remind() {
		return data_invio_remind;
	}
	public void setData_invio_remind(Date data_invio_remind) {
		this.data_invio_remind = data_invio_remind;
	}
	public DevContrattoDTO getContratto() {
		return contratto;
	}
	public void setContratto(DevContrattoDTO contratto) {
		this.contratto = contratto;
	}
	public Long getN_device() {
		return n_device;
	}
	public void setN_device(Long n_device) {
		this.n_device = n_device;
	}

	
	
}
