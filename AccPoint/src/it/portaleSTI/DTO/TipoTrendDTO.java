package it.portaleSTI.DTO;

import java.io.Serializable;

public class TipoTrendDTO  implements Serializable {
	private static final long serialVersionUID = 1L;
	int id = 0;
	String descrizione = "";
	int tipo_grafico;
	
	Boolean attivo;
	
	public TipoTrendDTO() {
		
	}
	public TipoTrendDTO(int id, String descrizione, int tipo_grafico) {
		super();
		this.id = id;
		this.descrizione = descrizione;
		this.tipo_grafico= tipo_grafico;
	}
	
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
	
	public int getTipo_grafico() {
		return tipo_grafico;
	}

	public void setTipo_grafico(int tipo_grafico) {
		this.tipo_grafico = tipo_grafico;
	}
	
	public Boolean getAttivo() {
		return attivo;
	}
	
	public void setAttivo(Boolean attivo) {
		this.attivo = attivo;
	}
	
}
