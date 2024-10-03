package it.portaleSTI.DTO;

import java.util.Date;

public class DpiDTO {
	
	private int id;
	private int tipologia;
	private TipoAccessorioDispositivoDTO tipo_accessorio;
	private TipoDpiDTO tipo_dpi;
	private DocumFornitoreDTO company;
	private String descrizione;
	private String modello;
	private String conformita;
	private Date data_controllo;
	private Date data_scadenza_controllo;
	private int frequenza;
	private Date data_scadenza;
	private int collettivo;
	private int assegnato;
	private String nome_lavoratore;
	private int disabilitato;
	private String note;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public DocumFornitoreDTO getCompany() {
		return company;
	}
	public void setCompany(DocumFornitoreDTO company) {
		this.company = company;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public String getConformita() {
		return conformita;
	}
	public void setConformita(String conformita) {
		this.conformita = conformita;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public int getCollettivo() {
		return collettivo;
	}
	public void setCollettivo(int collettivo) {
		this.collettivo = collettivo;
	}
	public int getAssegnato() {
		return assegnato;
	}
	public void setAssegnato(int assegnato) {
		this.assegnato = assegnato;
	}


	public String getNome_lavoratore() {
		return nome_lavoratore;
	}
	public void setNome_lavoratore(String nome_lavoratore) {
		this.nome_lavoratore = nome_lavoratore;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public int getFrequenza() {
		return frequenza;
	}
	public void setFrequenza(int frequenza) {
		this.frequenza = frequenza;
	}
	
	public Date getData_controllo() {
		return data_controllo;
	}
	public void setData_controllo(Date data_controllo) {
		this.data_controllo = data_controllo;
	}
	public Date getData_scadenza_controllo() {
		return data_scadenza_controllo;
	}
	public void setData_scadenza_controllo(Date data_scadenza_controllo) {
		this.data_scadenza_controllo = data_scadenza_controllo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getTipologia() {
		return tipologia;
	}
	public void setTipologia(int tipologia) {
		this.tipologia = tipologia;
	}

	public TipoDpiDTO getTipo_dpi() {
		return tipo_dpi;
	}
	public void setTipo_dpi(TipoDpiDTO tipo_dpi) {
		this.tipo_dpi = tipo_dpi;
	}
	public TipoAccessorioDispositivoDTO getTipo_accessorio() {
		return tipo_accessorio;
	}
	public void setTipo_accessorio(TipoAccessorioDispositivoDTO tipo_accessorio) {
		this.tipo_accessorio = tipo_accessorio;
	}
	
	

}
