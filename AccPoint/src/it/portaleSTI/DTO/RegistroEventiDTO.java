package it.portaleSTI.DTO;

import java.util.Date;

public class RegistroEventiDTO {
	
	private int id;
	private Date data_evento;
	private TipoManutenzioneDTO tipo_manutenzione;
	private CampioneDTO campione;
	private int frequenza_manutenzione;
	private String nome_file;
	
	
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
	public int getFrequenza_manutenzione() {
		return frequenza_manutenzione;
	}
	public void setFrequenza_manutenzione(int frequenza_manutenzione) {
		this.frequenza_manutenzione = frequenza_manutenzione;
	}
	public String getNome_file() {
		return nome_file;
	}
	public void setNome_file(String nome_file) {
		this.nome_file = nome_file;
	}


}
