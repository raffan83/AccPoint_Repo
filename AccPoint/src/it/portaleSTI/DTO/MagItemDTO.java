package it.portaleSTI.DTO;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class MagItemDTO implements Serializable{

	private int id;
	private MagTipoItemDTO tipo_item;
	private int id_tipo_proprio;
	private String descrizione;
	private String peso;
	private MagStatoItemDTO stato;
	private int priorita;
	private String attivita;
	private String destinazione;
	private String matricola;
	private String codice_interno;

	
	public String getMatricola() {
		return matricola;
	}
	public void setMatricola(String matricola) {
		this.matricola = matricola;
	}
	public String getCodice_interno() {
		return codice_interno;
	}
	public void setCodice_interno(String codice_interno) {
		this.codice_interno = codice_interno;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_tipo_proprio() {
		return id_tipo_proprio;
	}
	public void setId_tipo_proprio(int id_tipo_proprio) {
		this.id_tipo_proprio = id_tipo_proprio;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getPeso() {
		return peso;
	}
	public void setPeso(String peso) {
		this.peso = peso;
	}
	public MagStatoItemDTO getStato() {
		return stato;
	}
	public void setStato(MagStatoItemDTO stato) {
		this.stato = stato;
	}
	public MagTipoItemDTO getTipo_item() {
		return tipo_item;
	}
	public void setTipo_item(MagTipoItemDTO tipo_item) {
		this.tipo_item = tipo_item;
	}
	public int getPriorita() {
		return priorita;
	}
	public void setPriorita(int priorita) {
		this.priorita = priorita;
	}
	public String getAttivita() {
		return attivita;
	}
	public void setAttivita(String attivita) {
		this.attivita = attivita;
	}
	public String getDestinazione() {
		return destinazione;
	}
	public void setDestinazione(String destinazione) {
		this.destinazione = destinazione;
	}
	

}
