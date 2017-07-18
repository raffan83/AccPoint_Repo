package it.portaleSTI.DTO;

import java.io.Serializable;

public class AttivitaMilestoneDTO implements Serializable {

	
	
	private int id_riga;
	private String descrizioneAttivita;
	private String noteAttivita;
	private String descrizioneArticolo;
	private String quantita;
	private String codiceArticolo;
	
	
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
	
	
}
