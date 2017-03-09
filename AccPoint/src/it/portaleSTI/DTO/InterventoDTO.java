package it.portaleSTI.DTO;

import java.util.Date;

public class InterventoDTO {

	private Date dataCreazione;
	private int id;
	private int idSede;
	private int idUserCreation;
	private int idCommessa;
	private int idStatoIntervento;
	private int pressoDestinatario;
	public Date getDataCreazione() {
		return dataCreazione;
	}
	public void setDataCreazione(Date dataCreazione) {
		this.dataCreazione = dataCreazione;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdSede() {
		return idSede;
	}
	public void setIdSede(int idSede) {
		this.idSede = idSede;
	}
	public int getIdUserCreation() {
		return idUserCreation;
	}
	public void setIdUserCreation(int idUserCreation) {
		this.idUserCreation = idUserCreation;
	}
	public int getIdCommessa() {
		return idCommessa;
	}
	public void setIdCommessa(int idCommessa) {
		this.idCommessa = idCommessa;
	}
	public int getIdStatoIntervento() {
		return idStatoIntervento;
	}
	public void setIdStatoIntervento(int idStatoIntervento) {
		this.idStatoIntervento = idStatoIntervento;
	}
	public int getPressoDestinatario() {
		return pressoDestinatario;
	}
	public void setPressoDestinatario(int pressoDestinatario) {
		this.pressoDestinatario = pressoDestinatario;
	}
	
	
}
