package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class DevDeviceDTO {
	
	private int id;
	private String codice_interno;
	private DocumFornitoreDTO company_util;
	private DevTipoDeviceDTO tipo_device;
	private Date data_creazione;
	private String denominazione;
	private String costruttore;
	private String modello;
	private String distributore;
	private Date data_acquisto;
	private String ubicazione;
	private String configurazione;
	private DocumDipendenteFornDTO dipendente;
	private Set<DevSoftwareDTO> listaSoftware = new HashSet<DevSoftwareDTO>();
	private Set<DevProceduraDTO> listaProcedure = new HashSet<DevProceduraDTO>();
	private int disabilitato;
	private Date data_cambio_company;
	private String rif_fattura;
	private DocumFornitoreDTO company_proprietaria;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodice_interno() {
		return codice_interno;
	}
	public void setCodice_interno(String codice_interno) {
		this.codice_interno = codice_interno;
	}
	

	public Date getData_creazione() {
		return data_creazione;
	}
	public void setData_creazione(Date data_creazione) {
		this.data_creazione = data_creazione;
	}
	public String getDenominazione() {
		return denominazione;
	}
	public void setDenominazione(String denominazione) {
		this.denominazione = denominazione;
	}
	public String getCostruttore() {
		return costruttore;
	}
	public void setCostruttore(String costruttore) {
		this.costruttore = costruttore;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public String getDistributore() {
		return distributore;
	}
	public void setDistributore(String distributore) {
		this.distributore = distributore;
	}
	public Date getData_acquisto() {
		return data_acquisto;
	}
	public void setData_acquisto(Date data_acquisto) {
		this.data_acquisto = data_acquisto;
	}
	public String getUbicazione() {
		return ubicazione;
	}
	public void setUbicazione(String ubicazione) {
		this.ubicazione = ubicazione;
	}
	public String getConfigurazione() {
		return configurazione;
	}
	public void setConfigurazione(String configurazione) {
		this.configurazione = configurazione;
	}
	public DocumDipendenteFornDTO getDipendente() {
		return dipendente;
	}
	public void setDipendente(DocumDipendenteFornDTO dipendente) {
		this.dipendente = dipendente;
	}
	public Set<DevSoftwareDTO> getListaSoftware() {
		return listaSoftware;
	}
	public void setListaSoftware(Set<DevSoftwareDTO> listaSoftware) {
		this.listaSoftware = listaSoftware;
	}
	

	public DevTipoDeviceDTO getTipo_device() {
		return tipo_device;
	}
	public void setTipo_device(DevTipoDeviceDTO tipo_device) {
		this.tipo_device = tipo_device;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public Set<DevProceduraDTO> getListaProcedure() {
		return listaProcedure;
	}
	public void setListaProcedure(Set<DevProceduraDTO> listaProcedure) {
		this.listaProcedure = listaProcedure;
	}
	public Date getData_cambio_company() {
		return data_cambio_company;
	}
	public void setData_cambio_company(Date data_cambio_company) {
		this.data_cambio_company = data_cambio_company;
	}
	public String getRif_fattura() {
		return rif_fattura;
	}
	public void setRif_fattura(String rif_fattura) {
		this.rif_fattura = rif_fattura;
	}
	public DocumFornitoreDTO getCompany_util() {
		return company_util;
	}
	public void setCompany_util(DocumFornitoreDTO company_util) {
		this.company_util = company_util;
	}
	public DocumFornitoreDTO getCompany_proprietaria() {
		return company_proprietaria;
	}
	public void setCompany_proprietaria(DocumFornitoreDTO company_proprietaria) {
		this.company_proprietaria = company_proprietaria;
	}
	
	
	

}
