package it.portaleSTI.DTO;

import java.util.Date;

public class InterventoDTO {

	
	private int id;
	private Date dataCreazione;
	private int idSede;
	private String nome_sede;
	private int idUserCreation;
	private int idCommessa;
	private int idStatoIntervento;
	private String refStatoIntervento;
	private int pressoDestinatario;
	private String refUtenteCreazione;
	
	public Date getDataCreazione() {
		return dataCreazione;
	}
	
	
	public String getNome_sede() {
		return nome_sede;
	}


	public void setNome_sede(String nome_sede) {
		this.nome_sede = nome_sede;
	}


	public String getRefStatoIntervento() {
		return refStatoIntervento;
	}
	public void setRefStatoIntervento(String refStatoIntervento) {
		this.refStatoIntervento = refStatoIntervento;
	}
	public String getRefUtenteCreazione() {
		return refUtenteCreazione;
	}
	public void setRefUtenteCreazione(String refUtenteCreazione) {
		this.refUtenteCreazione = refUtenteCreazione;
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
