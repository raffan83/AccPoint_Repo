package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class CoAttrezzaturaDTO {

	
	private int id;
	private CoTipoAttrezzaturaDTO tipo;
	private String descrizione;
	private String codice;
	private String modello;
	private int disabilitato;
	private Date data_scadenza;
	private int frequenza_controllo;
	
	Set<CoTipoControlloDTO> listaTipiControllo = new HashSet<CoTipoControlloDTO>();
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CoTipoAttrezzaturaDTO getTipo() {
		return tipo;
	}
	public void setTipo(CoTipoAttrezzaturaDTO tipo) {
		this.tipo = tipo;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getCodice() {
		return codice;
	}
	public void setCodice(String codice) {
		this.codice = codice;
	}
	public String getModello() {
		return modello;
	}
	public void setModello(String modello) {
		this.modello = modello;
	}
	public Set<CoTipoControlloDTO> getListaTipiControllo() {
		return listaTipiControllo;
	}
	public void setListaTipiControllo(Set<CoTipoControlloDTO> listaTipiControllo) {
		this.listaTipiControllo = listaTipiControllo;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public Date getData_scadenza() {
		return data_scadenza;
	}
	public void setData_scadenza(Date data_scadenza) {
		this.data_scadenza = data_scadenza;
	}
	public int getFrequenza_controllo() {
		return frequenza_controllo;
	}
	public void setFrequenza_controllo(int frequenza_controllo) {
		this.frequenza_controllo = frequenza_controllo;
	}
	
	
}
