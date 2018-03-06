package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class TipologiaCampionamentoDTO {

	private int id = 0;
 	private String descrizione = "";
	private TipoMatriceDTO tipoMatrice;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public TipoMatriceDTO getTipoMatrice() {
		return tipoMatrice;
	}

	public void setTipoMatrice(TipoMatriceDTO tipoMatrice) {
		this.tipoMatrice = tipoMatrice;
	}
	

}
