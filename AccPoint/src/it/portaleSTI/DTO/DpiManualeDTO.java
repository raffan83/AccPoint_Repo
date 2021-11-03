package it.portaleSTI.DTO;

public class DpiManualeDTO {
	
	private int id;
	private TipoDpiDTO tipo_dpi;
	String descrizione;
	String modello;
	String conformita;
	int disabilitato;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TipoDpiDTO getTipo_dpi() {
		return tipo_dpi;
	}
	public void setTipo_dpi(TipoDpiDTO tipo_dpi) {
		this.tipo_dpi = tipo_dpi;
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
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	
	

}
