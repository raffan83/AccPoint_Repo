package it.portaleSTI.DTO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class AMAttivitaManutenzioneDTO {
	
	private int id;
	private AMSistemaDTO sistema;
	private String descrizioneManutenzione;
	private int periodicita;
	private Date dataUltimaManutenzione;
	private Date dataProssimaManutenzione;
	Set<AMInterventoDTO> listaInterventi = new HashSet<AMInterventoDTO>(0);
	
	
	public Set<AMInterventoDTO> getListaInterventi() {
		return listaInterventi;
	}
	public void setListaInterventi(Set<AMInterventoDTO> listaInterventi) {
		this.listaInterventi = listaInterventi;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public AMSistemaDTO getSistema() {
		return sistema;
	}
	public void setSistema(AMSistemaDTO sistema) {
		this.sistema = sistema;
	}
	public String getDescrizioneManutenzione() {
		return descrizioneManutenzione;
	}
	public void setDescrizioneManutenzione(String descrizioneManutenzione) {
		this.descrizioneManutenzione = descrizioneManutenzione;
	}
	public Date getDataUltimaManutenzione() {
		return dataUltimaManutenzione;
	}
	public void setDataUltimaManutenzione(Date dataUltimaManutenzione) {
		this.dataUltimaManutenzione = dataUltimaManutenzione;
	}
	public Date getDataProssimaManutenzione() {
		return dataProssimaManutenzione;
	}
	public void setDataProssimaManutenzione(Date dataProssimaManutenzione) {
		this.dataProssimaManutenzione = dataProssimaManutenzione;
	}
	public int getPeriodicita() {
		return periodicita;
	}
	public void setPeriodicita(int periodicita) {
		this.periodicita = periodicita;
	}
	


}
