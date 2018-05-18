package it.portaleSTI.DTO;

import java.util.Date;

public class RegistroEventiDTO {
	
	private int id;
	private Date data_evento;
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
