package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class TipoCampionamentoDTO {

	private int id;
	private String codice;
	private String descrizione;
	private String nomeScheda;

	private Set<DatasetCampionamentoDTO> listaDatasetCampionamentoDTO = new HashSet<DatasetCampionamentoDTO>(0);
	
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCodice() {
		return codice;
	}

	public void setCodice(String codice) {
		this.codice = codice;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getNomeScheda() {
		return nomeScheda;
	}

	public void setNomeScheda(String nomeScheda) {
		this.nomeScheda = nomeScheda;
	}

	public Set<DatasetCampionamentoDTO> getListaDatasetCampionamentoDTO() {
		return listaDatasetCampionamentoDTO;
	}

	public void setListaDatasetCampionamentoDTO(Set<DatasetCampionamentoDTO> listaDatasetCampionamentoDTO) {
		this.listaDatasetCampionamentoDTO = listaDatasetCampionamentoDTO;
	}


	
	
}