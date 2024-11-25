package it.portaleSTI.DTO;

import java.util.Date;

public class DevRegistroAttivitaDTO {
	
	private int id;
	private DevDeviceDTO device;
	private Date data_evento;
	private DevTipoEventoDTO tipo_evento;
	private String descrizione;
	private String note_evento;
	private UtenteDTO utente;
	private int frequenza;
	private Date data_prossima;
	private String tipo_intervento;
	private DocumFornitoreDTO company;
	private int email_inviata;
	private int sollecito_inviato;
	private Integer tipo_manutenzione_straordinaria;
	private Date data_invio_sollecito;
	private Date data_invio_email;
	private String obsoleta;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public DevDeviceDTO getDevice() {
		return device;
	}
	public void setDevice(DevDeviceDTO device) {
		this.device = device;
	}
	public Date getData_evento() {
		return data_evento;
	}
	public void setData_evento(Date data_evento) {
		this.data_evento = data_evento;
	}
	public DevTipoEventoDTO getTipo_evento() {
		return tipo_evento;
	}
	public void setTipo_evento(DevTipoEventoDTO tipo_evento) {
		this.tipo_evento = tipo_evento;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getNote_evento() {
		return note_evento;
	}
	public void setNote_evento(String note_evento) {
		this.note_evento = note_evento;
	}
	public UtenteDTO getUtente() {
		return utente;
	}
	public void setUtente(UtenteDTO utente) {
		this.utente = utente;
	}
	public int getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(int frequenza) {
		this.frequenza = frequenza;
	}
	public Date getData_prossima() {
		return data_prossima;
	}
	public void setData_prossima(Date data_prossima) {
		this.data_prossima = data_prossima;
	}
	public String getTipo_intervento() {
		return tipo_intervento;
	}
	public void setTipo_intervento(String tipo_intervento) {
		this.tipo_intervento = tipo_intervento;
	}
	public DocumFornitoreDTO getCompany() {
		return company;
	}
	public void setCompany(DocumFornitoreDTO company) {
		this.company = company;
	}
	public int getEmail_inviata() {
		return email_inviata;
	}
	public void setEmail_inviata(int email_inviata) {
		this.email_inviata = email_inviata;
	}
	public int getSollecito_inviato() {
		return sollecito_inviato;
	}
	public void setSollecito_inviato(int sollecito_inviato) {
		this.sollecito_inviato = sollecito_inviato;
	}
	public Integer getTipo_manutenzione_straordinaria() {
		return tipo_manutenzione_straordinaria;
	}
	public void setTipo_manutenzione_straordinaria(Integer tipo_manutenzione_straordinaria) {
		this.tipo_manutenzione_straordinaria = tipo_manutenzione_straordinaria;
	}
	public Date getData_invio_sollecito() {
		return data_invio_sollecito;
	}
	public void setData_invio_sollecito(Date data_invio_sollecito) {
		this.data_invio_sollecito = data_invio_sollecito;
	}
	public String getObsoleta() {
		return obsoleta;
	}
	public void setObsoleta(String obsoleta) {
		this.obsoleta = obsoleta;
	}
	public Date getData_invio_email() {
		return data_invio_email;
	}
	public void setData_invio_email(Date data_invio_email) {
		this.data_invio_email = data_invio_email;
	}
	
	

}
