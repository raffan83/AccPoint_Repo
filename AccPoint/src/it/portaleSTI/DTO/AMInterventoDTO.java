package it.portaleSTI.DTO;

import java.util.Date;

public class AMInterventoDTO {
	
	private int id;
	private String nomeCliente;
	private String nomeClienteUtilizzatore;
	private String nomeSede;
	private String nomeSedeUtilizzatore;
	private Date dataIntervento;
	private String idCommessa;
	private AMOperatoreDTO operatore;
	private int stato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNomeCliente() {
		return nomeCliente;
	}
	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}
	public String getNomeSede() {
		return nomeSede;
	}
	public void setNomeSede(String nomeSede) {
		this.nomeSede = nomeSede;
	}
	public Date getDataIntervento() {
		return dataIntervento;
	}
	public void setDataIntervento(Date dataIntervento) {
		this.dataIntervento = dataIntervento;
	}
	
	public String getIdCommessa() {
		return idCommessa;
	}
	
	public void setIdCommessa(String idCommessa) {
		this.idCommessa = idCommessa;
	}
	public AMOperatoreDTO getOperatore() {
		return operatore;
	}
	public void setOperatore(AMOperatoreDTO operatore) {
		this.operatore = operatore;
	}
	public int getStato() {
		return stato;
	}
	public void setStato(int stato) {
		this.stato = stato;
	}
	public String getNomeClienteUtilizzatore() {
		return nomeClienteUtilizzatore;
	}
	public void setNomeClienteUtilizzatore(String nomeClienteUtilizzatore) {
		this.nomeClienteUtilizzatore = nomeClienteUtilizzatore;
	}
	public String getNomeSedeUtilizzatore() {
		return nomeSedeUtilizzatore;
	}
	public void setNomeSedeUtilizzatore(String nomeSedeUtilizzatore) {
		this.nomeSedeUtilizzatore = nomeSedeUtilizzatore;
	}
	
}
