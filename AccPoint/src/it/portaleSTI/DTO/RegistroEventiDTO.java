package it.portaleSTI.DTO;

import java.util.Date;

public class RegistroEventiDTO {
	
	private int id;
	private Date data_evento;
	private TipoManutenzioneDTO tipo_manutenzione;
	private CampioneDTO campione;
	private int frequenza_manutenzione;
	private String nome_file;
	private TipoEventoRegistroDTO tipo_evento;
	private String laboratorio; 
	private String stato;
	private String campo_sospesi;
	private String numero_certificato;
	private String allegato;
	private String descrizione;
	private UtenteDTO operatore;
	private Date data_scadenza;
	private String obsoleta;
	
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
	public TipoEventoRegistroDTO getTipo_evento() {
		return tipo_evento;
	}
	public void setTipo_evento(TipoEventoRegistroDTO tipo_evento) {
		this.tipo_evento = tipo_evento;
	}
	public String getLaboratorio() {
		return laboratorio;
	}
	public void setLaboratorio(String laboratorio) {
		this.laboratorio = laboratorio;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
	public String getCampo_sospesi() {
		return campo_sospesi;
	}
	public void setCampo_sospesi(String campo_sospesi) {
		this.campo_sospesi = campo_sospesi;
	}
	public String getNumero_certificato() {
		return numero_certificato;
	}
	public void setNumero_certificato(String numero_certificato) {
		this.numero_certificato = numero_certificato;
	}
	public String getAllegato() {
		return allegato;
	}
	public void setAllegato(String allegato) {
		this.allegato = allegato;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public UtenteDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(UtenteDTO operatore) {
		this.operatore = operatore;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public String getObsoleta() {
		return obsoleta;
	}
	public void setObsoleta(String obsoleta) {
		this.obsoleta = obsoleta;
	}
	


}
