package it.portaleSTI.DTO;

import java.util.Date;

public class CoControlloDTO {
	private int id;
	private CoAttrezzaturaDTO attrezzatura;
	private String esito_generale;
	private int disabilitato;
	private Date data_controllo;
	private Date data_prossimo_controllo;
	private String note;
	private CoStatoControlloDTO stato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CoAttrezzaturaDTO getAttrezzatura() {
		return attrezzatura;
	}
	public void setAttrezzatura(CoAttrezzaturaDTO attrezzatura) {
		this.attrezzatura = attrezzatura;
	}
	public String getEsito_generale() {
		return esito_generale;
	}
	public void setEsito_generale(String esito_generale) {
		this.esito_generale = esito_generale;
	}
	public int getDisabilitato() {
		return disabilitato;
	}
	public void setDisabilitato(int disabilitato) {
		this.disabilitato = disabilitato;
	}
	public Date getData_controllo() {
		return data_controllo;
	}
	public void setData_controllo(Date data_controllo) {
		this.data_controllo = data_controllo;
	}
	public Date getData_prossimo_controllo() {
		return data_prossimo_controllo;
	}
	public void setData_prossimo_controllo(Date data_prossimo_controllo) {
		this.data_prossimo_controllo = data_prossimo_controllo;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public CoStatoControlloDTO getStato() {
		return stato;
	}
	public void setStato(CoStatoControlloDTO stato) {
		this.stato = stato;
	}
	
	

}
