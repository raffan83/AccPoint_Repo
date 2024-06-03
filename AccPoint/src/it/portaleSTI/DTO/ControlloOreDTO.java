package it.portaleSTI.DTO;

import java.util.Date;

public class ControlloOreDTO {
	
	private String username;
	private String id_commessa;
	private String oggetto_commessa;
	private String cliente;
	private Date data_commessa;
	private String fase;
	private double ore_previste;
	private double ore_scaricate;
	private double scostamento;
	private String glb_fase;
	private String milestone;
	private int duplicato = 0;
	
	
	public int getDuplicato() {
		return duplicato;
	}
	public void setDuplicato(int duplicato) {
		this.duplicato = duplicato;
	}

	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getId_commessa() {
		return id_commessa;
	}
	public void setId_commessa(String id_commessa) {
		this.id_commessa = id_commessa;
	}
	public String getOggetto_commessa() {
		return oggetto_commessa;
	}
	public void setOggetto_commessa(String oggetto_commessa) {
		this.oggetto_commessa = oggetto_commessa;
	}
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public Date getData_commessa() {
		return data_commessa;
	}
	public void setData_commessa(Date data_commessa) {
		this.data_commessa = data_commessa;
	}
	public String getFase() {
		return fase;
	}
	public void setFase(String fase) {
		this.fase = fase;
	}
	public double getOre_previste() {
		return ore_previste;
	}
	public void setOre_previste(double ore_previste) {
		this.ore_previste = ore_previste;
	}
	public double getOre_scaricate() {
		return ore_scaricate;
	}
	public void setOre_scaricate(double ore_scaricate) {
		this.ore_scaricate = ore_scaricate;
	}
	public double getScostamento() {
		return scostamento;
	}
	public void setScostamento(double scostamento) {
		this.scostamento = scostamento;
	}
	public String getGlb_fase() {
		return glb_fase;
	}
	public void setGlb_fase(String glb_fase) {
		this.glb_fase = glb_fase;
	}
	public String getMilestone() {
		return milestone;
	}
	public void setMilestone(String milestone) {
		this.milestone = milestone;
	}
	
	

}
