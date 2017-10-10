package it.portaleSTI.DTO;

import java.io.Serializable;

public class PlayloadCampionamentoDTO implements Serializable{
	
	private int id;
	private InterventoCampionamentoDTO intervento;
	private int idInterventoCampionamento;
	private DatasetCampionamentoDTO dataset;
	private String punto_misura;
	private String valore_misurato;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public InterventoCampionamentoDTO getIntervento() {
		return intervento;
	}
	public void setIntervento(InterventoCampionamentoDTO intervento) {
		this.intervento = intervento;
	}
	public DatasetCampionamentoDTO getDataset() {
		return dataset;
	}
	public void setDataset(DatasetCampionamentoDTO dataset) {
		this.dataset = dataset;
	}
	public String getPunto_misura() {
		return punto_misura;
	}
	public void setPunto_misura(String punto_misura) {
		this.punto_misura = punto_misura;
	}
	public String getValore_misurato() {
		return valore_misurato;
	}
	public void setValore_misurato(String valore_misurato) {
		this.valore_misurato = valore_misurato;
	}
	public int getIdInterventoCampionamento() {
		return idInterventoCampionamento;
	}
	public void setIdInterventoCampionamento(int idInterventoCampionamento) {
		this.idInterventoCampionamento = idInterventoCampionamento;
	}
	
}
