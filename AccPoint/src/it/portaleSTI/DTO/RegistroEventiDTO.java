package it.portaleSTI.DTO;

import java.util.Date;

public class RegistroEventiDTO {
	
	private int id;
	private Date data_evento;
	private String descrizione;
	private String ente_certificatore;
	private String certificato_taratura;
	private Date data_scadenza;
	private TipoManutenzioneDTO tipo_manutenzione;
	private CampioneDTO campione;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getData_evento() {
		return data_evento;
	}
	public void setData_evento(Date data_evento) {
		this.data_evento = data_evento;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getEnte_certificatore() {
		return ente_certificatore;
	}
	public void setEnte_certificatore(String ente_certificatore) {
		this.ente_certificatore = ente_certificatore;
	}
	public String getCertificato_taratura() {
		return certificato_taratura;
	}
	public void setCertificato_taratura(String certificato_taratura) {
		this.certificato_taratura = certificato_taratura;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public CampioneDTO getCampione() {
		return campione;
	}
	public void setCampione(CampioneDTO campione) {
		this.campione = campione;
	}
	public TipoManutenzioneDTO getTipo_manutenzione() {
		return tipo_manutenzione;
	}
	public void setTipo_manutenzione(TipoManutenzioneDTO tipo_manutenzione) {
		this.tipo_manutenzione = tipo_manutenzione;
	}


}
