package it.portaleSTI.DTO;

import java.util.HashSet;
import java.util.Set;

public class TipoMatriceDTO {

	private int id = 0;
	private String codice = "";
	private String descrizione = "";
	

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

}
