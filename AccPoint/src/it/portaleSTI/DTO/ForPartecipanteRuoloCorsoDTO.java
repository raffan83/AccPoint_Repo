package it.portaleSTI.DTO;

import java.io.Serializable;

public class ForPartecipanteRuoloCorsoDTO implements Serializable{
	
	private ForCorsoDTO corso;
	private ForPartecipanteDTO partecipante;
	private ForRuoloDTO ruolo;
	private Double ore_partecipate;
	private String attestato;
	int firma_responsabile;
	int firma_legale_rappresentante;
	
	
	public ForPartecipanteDTO getPartecipante() {
		return partecipante;
	}
	public void setPartecipante(ForPartecipanteDTO partecipante) {
		this.partecipante = partecipante;
	}
	public ForRuoloDTO getRuolo() {
		return ruolo;
	}
	public void setRuolo(ForRuoloDTO ruolo) {
		this.ruolo = ruolo;
	}
	public Double getOre_partecipate() {
		return ore_partecipate;
	}
	public void setOre_partecipate(Double ore_partecipate) {
		this.ore_partecipate = ore_partecipate;
	}
	public String getAttestato() {
		return attestato;
	}
	public void setAttestato(String attestato) {
		this.attestato = attestato;
	}
	public ForCorsoDTO getCorso() {
		return corso;
	}
	public void setCorso(ForCorsoDTO corso) {
		this.corso = corso;
	}
	public int getFirma_responsabile() {
		return firma_responsabile;
	}
	public void setFirma_responsabile(int firma_responsabile) {
		this.firma_responsabile = firma_responsabile;
	}
	public int getFirma_legale_rappresentante() {
		return firma_legale_rappresentante;
	}
	public void setFirma_legale_rappresentante(int firma_legale_rappresentante) {
		this.firma_legale_rappresentante = firma_legale_rappresentante;
	}


}
