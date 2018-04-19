package it.portaleSTI.DTO;

import java.io.Serializable;

public class MagAccessorioDTO implements Serializable{
	
	private int id;
	private String descrizione;
	private int quantita_fisica;
	private MagCategoriaDTO categoria;
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
	public int getQuantita_fisica() {
		return quantita_fisica;
	}
	public void setQuantita_fisica(int quantita_fisica) {
		this.quantita_fisica = quantita_fisica;
	}
	public MagCategoriaDTO getCategoria() {
		return categoria;
	}
	public void setCategoria(MagCategoriaDTO categoria) {
		this.categoria = categoria;
	}

}
