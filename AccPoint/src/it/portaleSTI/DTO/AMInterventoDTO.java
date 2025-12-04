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
	private Integer id_cliente;
	private Integer id_sede;
	private Integer id_cliente_utilizzatore;
	private Integer id_sede_utilizzatore;
	private String note;
	
	
	public int getId() {
		return id;
	}
	public Integer getId_cliente_utilizzatore() {
		return id_cliente_utilizzatore;
	}
	public void setId_cliente_utilizzatore(Integer id_cliente_utilizzatore) {
		this.id_cliente_utilizzatore = id_cliente_utilizzatore;
	}
	public Integer getId_sede_utilizzatore() {
		return id_sede_utilizzatore;
	}
	public void setId_sede_utilizzatore(Integer id_sede_utilizzatore) {
		this.id_sede_utilizzatore = id_sede_utilizzatore;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public Integer getId_cliente() {
		return id_cliente;
	}
	public void setId_cliente(Integer id_cliente) {
		this.id_cliente = id_cliente;
	}
	public Integer getId_sede() {
		return id_sede;
	}
	public void setId_sede(Integer id_sede) {
		this.id_sede = id_sede;
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
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
}
