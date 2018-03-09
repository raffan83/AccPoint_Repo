package it.portaleSTI.DTO;

public class MagItemDTO {

	private int id;
	private int id_tipo;
	private int id_tipo_proprio;
	private String descrizione;
	private String peso;
	private String stato;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getId_tipo() {
		return id_tipo;
	}
	public void setId_tipo(int id_tipo) {
		this.id_tipo = id_tipo;
	}
	public int getId_tipo_proprio() {
		return id_tipo_proprio;
	}
	public void setId_tipo_proprio(int id_tipo_proprio) {
		this.id_tipo_proprio = id_tipo_proprio;
	}
	public String getDescrizione() {
		return descrizione;
	}
	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}
	public String getPeso() {
		return peso;
	}
	public void setPeso(String peso) {
		this.peso = peso;
	}
	public String getStato() {
		return stato;
	}
	public void setStato(String stato) {
		this.stato = stato;
	}
}
