package it.portaleSTI.DTO;

import java.io.Serializable;

public class AttivitaMilestoneDTO implements Serializable {

	
	
	private int id_riga=0;
	private String descrizioneAttivita="";
	private String noteAttivita="";
	private String descrizioneArticolo="";
	private String quantita="";
	private String codiceArticolo="";
	private String codiceAggregatore="";
	private double importo_unitario;
	private String unitaMisura;
	
	public int getId_riga() {
		return id_riga;
	}
	public void setId_riga(int id_riga) {
		this.id_riga = id_riga;
	}
	public String getCodiceArticolo() {
		return codiceArticolo;
	}
	public void setCodiceArticolo(String codiceArticolo) {
		this.codiceArticolo = codiceArticolo;
	}
	public String getDescrizioneAttivita() {
		return descrizioneAttivita;
	}
	public void setDescrizioneAttivita(String descrizioneAttivita) {
		this.descrizioneAttivita = descrizioneAttivita;
	}
	public String getNoteAttivita() {
		return noteAttivita;
	}
	public void setNoteAttivita(String noteAttivita) {
		this.noteAttivita = noteAttivita;
	}
	public String getDescrizioneArticolo() {
		return descrizioneArticolo;
	}
	public void setDescrizioneArticolo(String descrizioneArticolo) {
		this.descrizioneArticolo = descrizioneArticolo;
	}
	public String getQuantita() {
		return quantita;
	}
	public void setQuantita(String quantita) {
		this.quantita = quantita;
	}
	public String getCodiceAggregatore() {
		return codiceAggregatore;
	}
	public void setCodiceAggregatore(String codiceAggregatore) {
		this.codiceAggregatore = codiceAggregatore;
	}
	public double getImporto_unitario() {
		return importo_unitario;
	}
	public void setImporto_unitario(double importo_unitario) {
		this.importo_unitario = importo_unitario;
	}
	public String getUnitaMisura() {
		return unitaMisura;
	}
	public void setUnitaMisura(String unitaMisura) {
		this.unitaMisura = unitaMisura;
	}
	
}
