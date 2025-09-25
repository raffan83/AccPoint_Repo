package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class RapportoInterventoDTO {
	
	private int id;
	private InterventoDTO intervento;
	private PRRisorsaDTO operatore;
	private Date data_inizio;
	private Date data_fine;
	private String ora_inizio;
	private String ora_fine;
	private Set<StrumentoDTO> lista_strumenti = new HashSet<StrumentoDTO>();
	private String note;
	private String destinatario_email;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public PRRisorsaDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(PRRisorsaDTO operatore) {
		this.operatore = operatore;
	}
	public Date getData_inizio() {
		return data_inizio;
	}
	public void setData_inizio(Date data_inizio) {
		this.data_inizio = data_inizio;
	}
	public Date getData_fine() {
		return data_fine;
	}
	public void setData_fine(Date data_fine) {
		this.data_fine = data_fine;
	}
	public String getOra_inizio() {
		return ora_inizio;
	}
	public void setOra_inizio(String ora_inizio) {
		this.ora_inizio = ora_inizio;
	}
	public String getOra_fine() {
		return ora_fine;
	}
	public void setOra_fine(String ora_fine) {
		this.ora_fine = ora_fine;
	}
	public InterventoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoDTO intervento) {
		this.intervento = intervento;
	}
	public Set<StrumentoDTO> getLista_strumenti() {
		return lista_strumenti;
	}
	public void setLista_strumenti(Set<StrumentoDTO> lista_strumenti) {
		this.lista_strumenti = lista_strumenti;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getDestinatario_email() {
		return destinatario_email;
	}
	public void setDestinatario_email(String destinatario_email) {
		this.destinatario_email = destinatario_email;
	}
	
	

}
